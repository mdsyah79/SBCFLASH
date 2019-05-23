@ECHO OFF
REM 1CHKCF.BAT is SBCFLASH program to CHECK CF card status.
REM CF card status are No Format (nofmt) No Partition (nopart)...
REM ... No Card Detected (chkfail) and Wrong Partition(fat32) type (wrgpart).
REM Fat16 partition is required due to "MAKEBOOT.EXE" program by Pharlap...
CLS
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF CARD CHECKING IN PROGRESS ***"
vecho /fGRAY

REM vinfo ERRORLEVELS
REM if errorlevel 100 goto Done
REM if errorlevel 15 goto NoSuchDrive (drive not present)
REM if errorlevel 5 goto IgnoreThisError (not formatted)
REM if errorlevel 2 goto WrongTypeDrive (removable drive aka floppy detected)

REM FDISK ERRORLEVELS
REM errorlevel 5 is No Media Present (Invalid Drive)

REM Activate D: partitions and detect if CF exists.
REM ----------------Old Code-----------------------
REM REM If no CF exists goto main menu
REM REM FDISK /ACTIVATE:1 2 > NUL
REM REM VDELAY 500
REM -----------------------------------------------
verrlvl 1
FDISK /ACTIVATE:1 2 | GREP "^Invalid drive" > NUL
if %errorlevel% == "0" SET CFNODET=1
verrlvl 0
if "%CFNODET%" == "1" goto cfnodet

REM ---------------Old CFNODET Code-------------------------------------
REM REM Check if CF card is inserted and present
REM REM Fdisk errorlevel 5 means non-existent drive aka no cf inserted
REM verrlvl 0
REM FDISK /INFO 2 > NUL
REM if "%errorlevel%" == "5" SET CFNODET=1
REM if "%CFNODET%" == "1" goto cfnodet
REM --------------------------------------------------------------------

REM Use FDISK to check whether CF is PARTITIONED
verrlvl 0
REM FDISK /INFO 2 | GREP % > NUL
FDISK /INFO 2 | GREP "^ D:" > NUL
if errorlevel 1 SET CFNOPART=1

REM Use FDISK to check whether CF Partition is FAT16
verrlvl 0
FDISK /INFO 2 | GREP "FAT16" > NUL
if errorlevel 1 SET CFWRGPART=1


REM Use FDISK to check whether CF is formatted
verrlvl 0
vinfo /d D:
if errorlevel 5 SET CFNOFMT=1

vecho /fWHITE " "
echo ................................................................
echo CF card Status:
echo CFNODET = [%CFNODET%] (1 means CF not detected)
echo CFNOFMT = [%CFNOFMT%] (1 means CF not formatted)
echo CFNOPART = [%CFNOPART%] (1 means CF has no partition)
echo CFWRGPART = [%CFWRGPART%] (1 means CF is having FAT32 partition)
echo ................................................................
vecho /fGRAY " "
vdelay 2000

if %CFNOPART% == 1 CALL 1PART.BAT
if %CFWRGPART% == 1 CALL 1PART.BAT
REM if %CFNOFMT% == 1 CALL 1FORMAT.BAT
goto end

:cfnodet
REM CF card not detected subroutine
vecho /fRED "CF CARD ERROR DETECTED."
vecho /fRED "Please ensure you insert correct CF card and reboot."
vecho /n /fWHITE "EXITING TO MAIN MENU"
vpause /fYELLOW /t7
CALL 1CLEAN.BAT
verrlvl 200

:done

:end
1CLEAN.BAT
