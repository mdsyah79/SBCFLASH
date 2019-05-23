@echo off
SET ver=2.2
if "%1" == "repart" goto THREE
if "%1" == "cfinser1" goto THREE
if "%1" == "cfinser4" goto THREE
if "%1" == "366repart" goto ONE
if "%1" == "375repart" goto TWO

:start
verrlvl 0
CLS
SET PATH=;
SET PATH=%dosdir%\BIN
cls
echo.
echo               MDW Repair Lab                          Ver %ver%
echo               ***********************************************
echo               *                                             *
echo               *  Press  1 = To flash SBC with ver 3.66      *
echo               *                                             *
echo               *  Press  2 = To flash SBC with ver 3.75      *
echo               *                                             *
echo               *  Press  3 = To transfer 1GB to 4GB CF mode  *
echo               *                                             *
echo               *  Press  4 = CONVERT TO PXE BOOT MODE        *
echo               *                                             *
echo               *  Press  5 = To exit flash mode              *
echo               *                                             *
echo               ***********************************************
echo.
echo.
Choice /C:12345 /N /S "Choose Your Option (1,2,3,4 or 5)?"
IF ERRORLEVEL ==5 GOTO FIVE
IF ERRORLEVEL ==4 GOTO FOUR
IF ERRORLEVEL ==3 GOTO THREE
IF ERRORLEVEL ==2 GOTO TWO
IF ERRORLEVEL ==1 GOTO ONE
echo.
echo.
pause
echo.
goto start

:ONE
SET PATH=%path%;C:\SBCFLASH\366
IF EXIST %TEMP%\366REPART.TXT goto OONE
cls
echo            **************************************************
echo            ***     Proceed to flash SBC Version 3.66      ***
echo            ************************************************** 
echo.
echo            Press  1 = Backup compact flash info & format
echo.
echo            Press  2 = Retore back cellserv.ini/dat info
echo.
echo            Press  3 = To change cellserv ini/dat in Compact Flash
echo.
echo            Press  4 = load default (Tester1) ini/dat info into CF 
echo.
echo            Press  5 = Return to main manu 
echo.
Choice /C:12345 /N /S "Choose Your Option (1,2,3,4 or 5)?"
IF ERRORLEVEL ==5 GOTO start
IF ERRORLEVEL ==4 GOTO OFOUR
IF ERRORLEVEL ==3 GOTO OTHREE
IF ERRORLEVEL ==2 GOTO OTWO
IF ERRORLEVEL ==1 GOTO OONE

:OONE
cls
echo.
REM CHDIR \366
CALL 1.BAT
REM CD\
echo.
echo.
echo.
echo Done.....
rem CALL WAIT.BAT
GOTO ONE

:OTWO
cls
echo.
REM CHDIR \366
CALL 2.BAT
REM CD\
REM CALL WAIT.BAT 1
GOTO ONE

:OTHREE
CLS
ECHO.
REM CHDIR \366
CALL 3.BAT
REM CD\
rem CALL WAIT.BAT
GOTO ONE

:OFOUR
CLS
ECHO.
REM CHDIR \366
CALL 4.BAT
REM CD\
REM CALL WAIT.BAT 3
GOTO ONE

:TWO
SET PATH=%path%;C:\SBCFLASH\375
IF EXIST %TEMP%\375REPART.TXT GOTO TONE
cls
echo            ##################################################
echo            ###      Proceed to flash SBC Version 3.75     ###
echo            ################################################## 
echo.
echo            Press  1 = Backup orginal cellserv.ini & format
echo.
echo            Press  2 = Retore back cellserv.ini/dat info
echo.
echo            Press  3 = To change cellserv ini/dat in Compact Flash
echo.
echo            Press  4 = load default (Tester1) ini/dat info into CF 
echo.
echo            Press  5 = Return to main manu 
echo.
choice /C:12345 /N /S "Choose Your Option (1,2,3,4 or 5)?"
IF ERRORLEVEL == 5 GOTO start
IF ERRORLEVEL == 4 GOTO TFOUR
IF ERRORLEVEL == 3 GOTO TTHREE
IF ERRORLEVEL == 2 GOTO TTWO
IF ERRORLEVEL == 1 GOTO TONE

:TONE
cls
echo.
CALL 1.BAT
echo.
echo.
echo.
echo Done.....
GOTO TWO

:TTWO
cls
echo.
CALL 2.BAT
GOTO TWO

:TTHREE
CLS
ECHO.
CALL 3.BAT
GOTO TWO

:TFOUR
CLS
ECHO.
CALL 4.BAT
GOTO TWO

:THREE
CALL %SBCFLASH%\4CONV1\FDMENU.BAT
GOTO start

:FOUR
CALL %SBCFLASH%\PXEBOOT\PXEMENU.BAT
GOTO start

:FIVE
cls
echo.
echo.
echo.
echo      Important : To set IRQ resources
echo                @ CMOS setup page_PnP/PCI configuratios
echo                  IRQ Resources_Resources controlled by [Manual]
echo                  IRQ Resources [5,10,12,14] assigned to [Reserved]
echo.
echo.
echo                  Please switch off power,unplug Inno disk
echo                           from SBC card.
echo.
echo                                         Have a nice day ! 
echo.
echo.
