@echo off
REM FDMENU is the 3rd menu from Main SBCFLASH menu.
REM This selection is meant for migration from 4GB to 1GB.

:reset
REM Reset CF card status before start of functions
SET CFNOFMT=
SET CFNOPART=
SET CFWRGPART=
SET cfcap=

REM SET NEW PATH
SET PATH=%path%;C:\SBCFLASH\4CONV1

CLS
REM REDIRECTION FOR FUNCTIONS THAT REQUIRE REBOOT
IF exist %TEMP%\REPART.TXT vecho /fBLACK /bYELLOW "Resuming from previous Partition session..."
vecho /fGRAY /bBLACK "."
IF exist %TEMP%\REPART.TXT vdelay 3000
IF exist %TEMP%\CFINSER1.TXT vecho /fBLACK /bYELLOW "Resuming from previous 1GB CF RE-INSERTION session..."
vecho /fGRAY /bBLACK "."
IF exist %TEMP%\CFINSER1.TXT vdelay 3000
IF exist %TEMP%\CFINSER4.TXT vecho /fBLACK /bYELLOW "Resuming from previous 4GB CF INSERTION session..."
vecho /fGRAY /bBLACK "."
IF exist %TEMP%\CFINSER4.TXT vdelay 3000

IF exist %TEMP%\REPART.TXT GOTO FDTWO
IF exist %TEMP%\CFINSER1.TXT GOTO FDONE
IF exist %TEMP%\CFINSER4.TXT GOTO FDTWO

:start
verrlvl 0
CLS
echo            **************************************************
echo            ***        TRANSFER 1GB TO 4GB CF MODE         ***
echo            ************************************************** 
echo.
echo            Press  1 = Backup 1GB CF info to C: Drive
echo.
echo            Press  2 = Remove 1GB and Insert 4GB + Processing
echo.
echo            Press  3 = Restore 1GB CF card datafiles to 4GB CF card
echo.
echo            Press  4 = To change cellserv ini/dat in Compact Flash
echo.
echo            Press  5 = Return to main menu
echo.
Choice /C:12345 /N /S "Choose Your Option (1,2,3,4 or 5)?"
IF ERRORLEVEL ==5 GOTO done
REM IF ERRORLEVEL ==5 GOTO FDFIVE
IF ERRORLEVEL ==4 GOTO FDFOUR
IF ERRORLEVEL ==3 GOTO FDTHREE
IF ERRORLEVEL ==2 GOTO FDTWO
IF ERRORLEVEL ==1 GOTO FDONE

:FDONE
SET cfcap=1
CLS
echo.
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card processing ***"
vecho /fGRAY
CALL FDCHKCF.BAT
if errorlevel 200 goto done
CALL FDBACKUP.BAT
if errorlevel 200 goto done
CALL FDCLEAN.BAT
GOTO start

:FDTWO
SET cfcap=4
CLS
echo.
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card processing ***"
vecho /fGRAY
CALL FDCFINS.BAT
if errorlevel 200 goto done
REM CALL FDCHKCF.BAT
REM if errorlevel 200 goto done
CALL FDPART.BAT
if errorlevel 200 goto done
CALL FDFORMAT.BAT
if errorlevel 200 goto done
CALL FDCHKCF.BAT
if errorlevel 200 goto done
CALL FDCLEAN.BAT
GOTO start

:FDTHREE
SET cfcap=4
CLS
echo.
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card processing ***"
vecho /fGRAY
CALL FDRESTOR.BAT
CALL FDCLEAN.BAT
GOTO start

:FDFOUR
SET cfcap=4
CLS
echo.
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card processing ***"
vecho /fGRAY
CALL FDEDIT.BAT
GOTO start

REM :FDFIVE
REM CLS
REM ECHO.
REM CHDIR \FDOS12
REM CALL FDDEFAUL.BAT
REM CD\
REM CALL WAIT.BAT
REM GOTO start

:done
:end
SET CFDATA=
CALL FDCLEAN.BAT
