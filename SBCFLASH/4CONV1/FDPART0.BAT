@ECHO OFF
REM FDPART is SBCFLASH utility to partition FAT16 format to CF cards
REM this FDPART uses FDISK util to set fat16 partition.
CLS
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card PARTITIONING IN-PROGRESS ***"
vecho /fGRAY

REM Delete REPART.TXT if exists before start
IF EXIST %TEMP%\REPART.TXT GOTO done

REM Start of CF card partition operations to fat16
FDISK /DEACTIVATE 2
FDISK /CLEAR 2
FDISK /PRIO:1024,100 2

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
vdelay 1000
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
TOUCH %TEMP%\REPART.TXT

REM Reboot PC
FDAPM WARMBOOT

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
CALL FDCLEAN.BAT
:done
DEL %TEMP%\REPART.TXT
