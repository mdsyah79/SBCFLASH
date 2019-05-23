@ECHO OFF
REM FDCHKCF.BAT is SBCFLASH program to CHECK CF card status.
REM CF card status are No Format (nofmt) No Partition (nopart)...
REM ... No Card Detected (chkfail) and Wrong Partition(fat32) type (wrgpart).
REM Fat16 partition is required due to "MAKEBOOT.EXE" program by Pharlap...
CLS
vecho /fYELLOW /bBLUE "*** CF CARD CHECKING IN PROGRESS ***"
vecho /fGRAY

:restart
REM vinfo ERRORLEVELS
REM if errorlevel 100 goto Done
REM if errorlevel 15 goto NoSuchDrive (drive not present)
REM if errorlevel 5 goto IgnoreThisError (not formatted)
REM if errorlevel 2 goto WrongTypeDrive (removable drive aka floppy detected)

REM FDISK ERRORLEVELS
REM errorlevel 5 is No Media Present (Invalid Drive)

REM Activate D: partitions
FDISK /ACTIVATE:1 2 > NUL
VDELAY 500

REM Check if CF card is inserted and present
REM Fdisk errorlevel 5 means non-existent drive aka no cf inserted
verrlvl 0
FDISK /INFO 2 > NUL
vdelay 1000
if not "%errorlevel%" == "5" goto runfsck

REM IF CF card is 1GB and minival=1(CF fail) will read error message 
REM IF CF card is 4GB but not detected will also run this line
vecho /fRED "CF CARD NOT DETECTED."
vecho /fRED "Please ensure you insert correct CF card."
vdelay 1000

REM ****** Cleanup Operation ******
CALL PXECLEAN.BAT
verrlvl 200
goto end

REM Run FSCK on CF card to check on errors
:runfsck
DOSFSCK -av D:
vdelay 1000

:done
vecho /fGRAY
echo.
echo.
echo.
echo.
echo.
vecho /fWHITE "CF Card Detected!"
vdelay 1500

:end