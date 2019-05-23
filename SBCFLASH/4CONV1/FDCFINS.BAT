@ECHO OFF
REM FDCFINS.BAT is SBCFLASH program to control CF card insertion.
REM cfcap is CF card capacity. 1GB or 4GB.
CLS
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card processing ***"
vecho /fGRAY

REM If REPART.TXT exists before start means repartition is rebooting. Skip cfinser.
IF EXIST %TEMP%\REPART.TXT goto done

REM Delete CFINSER.TXT if exists before start then CF already inserted
IF EXIST %TEMP%\CFINSER%cfcap%.TXT goto done

REM Prepare for D: drive removal
echo.
echo.
vecho /fWHITE /bRED "Preparing for CF Removal..."
echo.
REM Deactivate D: partitions to reduce CF data corruption
FDISK /DEACTIVATE 2 > NUL
VDELAY 500

REM Flush the D: Drive
FDAPM FLUSH
vdelay 1500

REM Ask user insert CF
echo.
vecho /n /fRED "Please insert correct %cfcap%GB CF card into the slot NOW..."
REM Create temp file for resume reboot purpose
TOUCH %TEMP%\CFINSER%cfcap%.TXT
vdelay 5000
echo.
vecho "Press ANY KEY to continue... (press CTRL-C to quit to Main Menu)"
vpause CTRL-C
if errorlevel 200 goto abortbatch

CLS
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card processing ***"
echo.
echo.
vecho /fYELLOW "Please reboot the SBC Station now..."
vecho /n /fWHITE "Don't worry after reboot, program will resume..."
vpause /fYELLOW /t5

:rebootnow
CLS
vecho /fRED /bBLUE "*** WARNING!!! ***"
echo.
echo.
vecho /n /fRED /bWHITE "PLEASE REBOOT NOW..."
vdelay 5000
goto rebootnow

:done
vecho /fGREEN "CF Card inserted!!!"
vecho /fGRAY
IF EXIST %TEMP%\CFINSER%cfcap%.TXT DEL %TEMP%\CFINSER%cfcap%.TXT

REM DONOT CALL FDCLEAN.BAT, will cause FDPART.BT to fail
REM FDPART.BAT will clean
:end