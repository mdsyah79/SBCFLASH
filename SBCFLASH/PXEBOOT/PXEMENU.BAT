@echo off
REM PXEMENU is the 3rd menu from Main SBCFLASH menu.
REM This selection is meant for migration from 4GB to 1GB.

REM SET NEW PATH
SET PATH=%path%;C:\SBCFLASH\PXEBOOT

:start
verrlvl 0
CLS
echo            **************************************************
echo            ***         CONVERT TO PXE BOOT MODE           ***
echo            ************************************************** 
echo.
echo            Press  1 = Backup CF card info to C: Drive
echo.
echo            Press  2 = Format and apply Syslinux Bootloader
echo.
echo            Press  3 = Restore datafiles from old CF card
echo.
echo            Press  4 = Edit cellserv ini
echo.
echo            Press  5 = Return to main menu
echo.
Choice /C:12345 /N /S "Choose Your Option (1,2,3,4 or 5)?"
IF ERRORLEVEL ==5 GOTO done
REM IF ERRORLEVEL ==5 GOTO PXEFIVE
IF ERRORLEVEL ==4 GOTO PXEFOUR
IF ERRORLEVEL ==3 GOTO PXETHREE
IF ERRORLEVEL ==2 GOTO PXETWO
IF ERRORLEVEL ==1 GOTO PXEONE

:PXEONE
CLS
echo.
vecho /fYELLOW /bBLUE "*** Backup CF card info to C: Drive ***"
vecho /fGRAY
CALL PXECHKCF.BAT
if errorlevel 200 goto done
CALL PXEBAKUP.BAT
if errorlevel 200 goto done
CALL PXECLEAN.BAT
GOTO start

:PXETWO
CLS
echo.
vecho /fYELLOW /bBLUE "*** Format and apply Syslinux Bootloader ***"
vecho /fGRAY
CALL PXEFMT.BAT
if errorlevel 200 goto done
CALL PXECLEAN.BAT
GOTO start

:PXETHREE
SET cfcap=4
CLS
echo.
vecho /fYELLOW /bBLUE "*** Restore datafiles from old CF card ***"
vecho /fGRAY
CALL PXERSTOR.BAT
CALL PXECLEAN.BAT
GOTO start

:PXEFOUR
SET cfcap=4
CLS
echo.
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card processing ***"
vecho /fGRAY
EDIT D:\CELLSERV.INI
EDIT D:\CELLSERV.DAT
EDIT D:\MDWPXE.SPT
GOTO start

REM :PXEFIVE
REM CLS
REM ECHO.
REM CHDIR \FDOS12
REM CALL FDDEFAUL.BAT
REM CD\
REM CALL WAIT.BAT
REM GOTO start

:done
:end
SET PXEDATA=
CALL PXECLEAN.BAT
