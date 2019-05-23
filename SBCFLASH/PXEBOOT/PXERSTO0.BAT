        @ECHO OFF
REM PXERSTOR Freedos (SBCFLASH) RESTORE files to D: drive
REM will abort if any files not found

REM SET DATA STORAGE FOR CF CARD TO C:\SBCFLASH\4CONV1\DATAFILE
SET PXEDATA=C:\SBCFLASH\PXEBOOT\DATAFILE
SET PXEMAIN=C:\SBCFLASH\PXEBOOT
SET minival=

CLS
vecho /fYELLOW /bBLUE "*** CF card RESTORE in progress ***"
vecho /fGRAY
echo.
echo.

REM CF card is detected and copy files if files exists
:copyfiles
echo Copying files to D:...

if not exist %PXEDATA%\NUL goto dirnotfound
if not exist %PXEDATA%\cellserv.dat goto notfound
if not exist %PXEDATA%\cellserv.ini goto notfound
vdelay 1000

IF EXIST %PXEDATA%\cellserv.ini COPY/y/v %PXEDATA%\cellserv.ini %PXEDATA%\cellserv.old
REM DEL %PXEDATA%\cellserv.ini
IF NOT EXIST %PXEDATA%\cellserv.ini echo cellserv.ini renamed to cellserv.old

IF EXIST %PXEDATA%\cellexe.exe DEL %PXEDATA%\cellexe.exe
IF NOT EXIST %PXEDATA%\cellexe.exe echo deleted cellexe.exe

IF EXIST %PXEDATA%\diskmon.bin DEL %PXEDATA%\diskmon.bin
IF NOT EXIST %PXEDATA%\diskmon.bin echo deleted diskmon.bin

REM Copy Old CF datafiles to CF Card
XCOPY %PXEDATA%\*.* D:\*.* /a /e /s /h /y /v /c
vdelay 1000

echo.
vecho /fWHITE Completed copy original datafiles to CF card.
vecho /fGRAY
echo.
vdelay 1000

REM Copy Template data for PXEBOOT to CF card
COPY/y/v %PXEMAIN%\cellser0.new D:\cellserv.new
COPY/y/v %PXEMAIN%\mdwpxe.* D:\*.*
COPY/y/v %PXEMAIN%\SESSION.LOG D:\*.*
COPY/y/v %PXEMAIN%\syslinux.cfg D:\*.*
vdelay 500
echo.
vecho /fWHITE Completed copy PXE Boot files to CF card.
vecho /fGRAY
echo.
vdelay 1000

REM Merge Cellserv.ini and Cellserv.pxe to form new file
REM TYPE %PXEMAIN%\TOPLABEL.TXT > D:\CELLSERV.INI
TYPE %PXEMAIN%\CELLSER0.NEW > D:\CELLSERV.INI
REM TYPE %PXEMAIN%\BTMLABEL.TXT >> D:\CELLSERV.INI
TYPE D:\CELLSERV.OLD >> D:\CELLSERV.INI
EDIT D:\CELLSERV.INI

REM RESTORE successful
echo.
echo.
vecho /n /fYELLOW /bLIGHTGREEN "RESTORE of CF data files to 4GB CF SUCCESSFUL..."
vpause /fYELLOW /t7
vecho /fGRAY
echo.
echo.
goto done

:dirnotfound
echo.
echo.
vecho /n /fRED "Folder: " %PXEDATA% " not found. Aborting Program..."
vpause /fYELLOW /t10
vecho /fGRAY
echo.
echo.
CALL PXECLEAN.BAT
verrlvl 200
goto end

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

:done
:end
