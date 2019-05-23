@ECHO OFF
REM FDBACKUP Freedos (SBCFLASH) Backup cellserv and cellexe files to C: drive
REM will abort if any files not found

REM SET DATA STORAGE FOR CF CARD TO C:\SBCFLASH\4CONV1\DATAFILE
SET PXEDATA=C:\SBCFLASH\PXEBOOT\DATAFILE

REM If PXEDATA folder not exist, create one. Ignore errors.
IF NOT EXIST %PXEDATA%\NUL MKDIR %PXEDATA%
vdelay 1000
IF NOT EXIST %PXEDATA%\NUL goto MKDIRERR

REM If DATAFILE folder exists, clear all contents
IF EXIST %PXEDATA%\NUL DELTREE/y/v %PXEDATA%\

CLS
vecho /fYELLOW /bBLUE "*** Backup CF card info to C: Drive IN-PROGRESS ***"
vecho /fGRAY
echo.
echo.

REM CF card is detected and copy files if files exists
:copyfiles
echo D: drive detected!!! Copying files...

REM if not exist D:\cellserv.dat goto notfound
REM if not exist D:\cellserv.ini goto notfound

XCOPY D:\*.* %PXEDATA%\*.* /a /e /s /h /y /v
vdelay 1500

REM Backup successful
echo.
echo.
vecho /n /fWHITE "Backup CF card info to C: Drive SUCCESSFUL..."
vdelay 3000
REM vpause /fYELLOW /t3
vecho /fGRAY
echo.
echo.
goto done

:notfound
echo.
echo.
vecho /n /fRED "Required files not found. Aborting Program..."
vpause /fYELLOW /t10
vecho /fGRAY
echo.
echo.
CALL PXECLEAN.BAT
verrlvl 200
goto end

:mkdirerr
echo.
echo.
vecho /n /fRED "Unable to create %PXEDATA% directory. Aborting Program..."
vpause /fYELLOW /t10
vecho /fGRAY
echo.
echo.
CALL PXECLEAN.BAT
verrlvl 200
goto end

:done
:end
SET PXEDATA=
