@ECHO OFF
REM PXERSTOR Freedos (SBCFLASH) RESTORE files to D: drive
REM will abort if any files not found
REM This is PXERSTOR using SED 

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
REM COPY/y/v %PXEMAIN%\cellser0.new D:\cellserv.new
COPY/y/v %PXEMAIN%\mdwpxe.* D:\*.*
COPY/y/v %PXEMAIN%\SESSION.LOG D:\*.*
COPY/y/v %PXEMAIN%\syslinux.cfg D:\*.*
vdelay 500
echo.
vecho /fWHITE Completed copy PXE Boot files to CF card.
vecho /fGRAY
echo.
vdelay 1000

REM SED will search line with MDWID and append the Server Ip address below
verrlvl 0
FIND "ServerIP=172.30.30.254" D:\cellserv.ini
IF '%errorlevel%'=='0' goto mdwpxe
sed '/MDWID/ a\ServerIP=172.30.30.254    ; This line is automatically added by SBCFLASH for PXEBOOT' < D:\cellserv.old > D:\cellserv.ini
REM edit D:\cellserv.ini

:mdwpxe
REM SED will search cellserv.dat file for tester number and update mdwpxe.spt
if exist tstrnum.txt del tstrnum.txt
type D:\cellserv.dat | sed 's/-/\n/ g' | sed -n '/[0-9][0-9]HAV*/ p' | sed -n 's/HAV[0-9]*// p' > tstrnum.txt
sed -in 's/^0// p' tstrnum.txt
type tstrnum.txt
pause

type tstrnum.txt | set /p testernum=
sed -i 's/ cell[0-9][0-9]* / cell%testernum% /' D:\mdwpxe.spt

REM SED will add comment to ensure cell number is correct
sed -i '/ goto retry_dhcp/ a\# Please ensure above cellX, X is your tester number you are flashing.' D:\mdwpxe.spt

REM edit d:\mdwpxe.spt
SET testernum=

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
