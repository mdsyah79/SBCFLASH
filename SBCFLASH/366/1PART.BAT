@ECHO OFF
REM 1PART is SBCFLASH utility to partition FAT16 format to CF cards
REM this 1PART uses PART util to RESTORE a saved mbr to set fat16 partition.
CLS
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card PARTITIONING IN-PROGRESS ***"
vecho /fGRAY

REM If 366REPART.TXT exists means repartitioning is done. Goto next step.
IF EXIST %TEMP%\366REPART.TXT GOTO done

REM --------------------Old Code--------------------------------
REM REM if existing cellserv files detected, 
REM REM ask user whether proceed to partition CF or not
REM IF NOT EXIST D:\CELLSERV.INI GOTO newpart
REM echo.
REM echo.
REM echo.
REM vecho /fYELLOW /bGREEN "Found existing SBC Bootup Files in currect CF!!!"
REM vecho /fYELLOW /bBLACK "Press (1) to continue..."
REM vecho /fRED /bBLACK "Press (2) to stop..."
REM verrlvl 0
REM Choice /C:12 /N /S "Choose Your Option (1 or 2)?"
REM IF "%ERRORLEVEL%" == "1" GOTO newpart
REM IF "%ERRORLEVEL%" == "2" GOTO partabort
REM -------------------------------------------------------------

:newpart
REM Use existing MBR to set CF partition to FAT16
IF NOT EXIST SBCFLASH.MBR GOTO oldpart
FDISK /DEACTIVATE 2
FDISK /CLEARALL 2
PART -d 2 -l SBCFLASH.MBR
goto partchk

:oldpart
REM Start of CF card partition operations to fat16
FDISK /DEACTIVATE 2
FDISK /CLEARALL 2
FDISK /MBR 2
FDISK /PRIO:1024,100 2

:partchk
REM Check after partition. 
REM If fdisk/info still empty means CF card missing or faulty.
verrlvl 0
FDISK /INFO 2 | GREP "FAT16"
if errorlevel 1 goto partfail

verrlvl 0
FDISK /INFO 2 | GREP "^ D:"
if errorlevel 1 goto partfail

REM If Partiton check pass, Declare Success message.
echo.
vecho /fYELLOW "FDISK SUCCESSFULLY recreated D: partition using FAT16..."
vecho /fGRAY
vdelay 3000
CLS
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card PARTITIONING IN-PROGRESS ***"
vecho /fGRAY
echo.
echo.
vecho /fYELLOW "Please hold while we reboot the SBC Station..."
vecho /n /fWHITE "Rebooting to register NEW PARTITION in CF CARD..."
vpause /fYellow /t5
vecho /fGRAY

REM Create temp file for reboot purpose
TOUCH %TEMP%\366REPART.TXT

REM Reboot PC
FDAPM WARMBOOT

REM This section is partiton failure delcaration and return to main.
:partabort
CLS
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card PARTITIONING ABORT ***"
vecho /fGRAY
echo.
echo.
vecho /fRED "You have chosen to abort partition of CF."
vecho /fRED "Suspected CF card is a valid and bootable CF card."
vecho /fRED "Please change the CF card and try again."
vecho /fGRAY
echo.
echo.
vecho /n /fWHITE "Will return to Main Menu in "
vpause /fYELLOW /t10 CTRL-C
vecho /fGRAY "(Press CTRL-C to skip timer)"
verrlvl 200
echo.
CALL 1CLEAN.BAT
goto end

REM This section is partiton failure delcaration and return to main.
:partfail
CLS
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card PARTITIONING FAILED ***"
vecho /fGRAY
echo.
echo.
vecho /fRED "Attempt to partition the 4GB CF card failed."
vecho /fRED "It could be the CF card is faulty, not inserted properly"
vecho /fRED "or CF card is not present in the slot."
vecho /fGRAY
echo.
echo.
vecho /n /fWHITE "Will return to Main Menu in "
vpause /fYELLOW /t10 CTRL-C
vecho /fGRAY "(Press CTRL-C to skip timer)"
verrlvl 200
echo.
CALL 1CLEAN.BAT

:done

:end
DEL %TEMP%\366REPART.TXT
