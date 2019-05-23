@ECHO OFF
REM PXERSTOR Freedos (SBCFLASH) RESTORE files to D: drive
REM will abort if any files not found
REM This is PXERSTOR using SED 

REM SET DATA STORAGE FOR CF CARD TO C:\SBCFLASH\4CONV1\DATAFILE
SET PXEDATA=C:\SBCFLASH\PXEBOOT\DATAFILE
SET PXEMAIN=C:\SBCFLASH\PXEBOOT
SET PXETEMP=C:\SBCFLASH\PXEBOOT\TEMPLATE
SET tnum=
SET mdwid=
SET minival=
VERIFY ON

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
REM if not exist %PXEDATA%\cellserv.ini goto notfound
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
COPY/y/v %PXEMAIN%\mdwpxe.krn D:\*.*
COPY/y/v %PXEMAIN%\mdwpxe.spt D:\*.*
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
FIND "ServerIP=172.30.30.254" D:\cellserv.ini > NUL
IF '%errorlevel%'=='0' goto mdwpxe
sed '/MDWID/ a\ServerIP=172.30.30.254' < D:\cellserv.old > D:\cellserv.ini
vdelay 500
sed -i '/ServerIP/ a\; The above line is automatically added by SBCFLASH for PXEBOOT' D:\cellserv.ini
vdelay 500
REM edit D:\cellserv.ini

:mdwpxe
REM SED will search cellserv.dat file for tester number and update mdwpxe.spt
if exist tstrnum.txt del tstrnum.txt
type D:\cellserv.dat | sed 's/-/\n/ g' | sed -n '/[0-9][0-9]HAV*/ p' | sed -n 's/HAV[0-9]*// p' > tstrnum.txt
sed -in 's/^0// p' tstrnum.txt

type tstrnum.txt | set /p tnum=
sed -i 's/ cell[0-9][0-9]* / cell%tnum% /' D:\mdwpxe.spt
vdelay 500

REM SED will add comment to ensure cell number is correct
verrlvl 0
FIND "Please ensure above cellX, X is your tester number you are flashing." D:\mdwpxe.spt > NUL
IF '%errorlevel%'=='0' goto seddone
sed -i '/ goto retry_dhcp/ a\# Please ensure above cellX, X is your tester number you are flashing.' D:\mdwpxe.spt
REM edit d:\mdwpxe.spt

:seddone
SET tnum=

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
vecho /fGREEN "Cellserv.ini and Cellserv.dat not found...."
vecho /fYELLOW "Please enter TESTER and MDW ID..."
vecho /fYELLOW "to generate NEW CELLSERV.ini and dat files ...."
echo.
pause
vecho /fBLUE "Copying template files...."
vecho /fGRAY
echo.
echo.
COPY/y/v %PXEMAIN%\cell.ini %PXEDATA%\cellserv.ini
COPY/y/v %PXEMAIN%\cell.dat %PXEDATA%\cellserv.dat

:asktnum
REM Ask user input tester number...
echo.
echo.
echo.
vecho /n /fYELLOW "Enter Tester Number (Press CTRL-C to Cancel) : "
REM set tnum=
vask /c | set /p tnum=
if "%errorlevel%" == "200" goto done
echo Tester Number : %tnum% : will be added to cellserv.dat file...
vecho /fGRAY " "

REM Validate user input is one or two digits only
verrlvl 0
echo %tnum% | xgrep ^[1-2]?[0-9][^.*]$
if "%tnum%" == "" goto validatefail1
if "%tnum%" == "0" goto validatefail1
if "%errorlevel%" == "0" goto validatepass1


:validatefail1
echo Please enter only numbers from 1 to 29.
PAUSE
set tnum=
goto asktnum


:validatepass1
REM If tester number is only 1 digit, add 0 infront
verrlvl 0
echo %tnum% | xgrep ^[0-9][^.*]$ > NUL
if "%errorlevel%" == "1" goto dbldigit
echo %tnum% | sed -n 's/%tnum%/0%tnum%/p' | set /p tnum=
vdelay 100

:dbldigit
REM Add tnum to cellserv.dat file
REM sed -i 's/-/ - /g' %PXEDATA%\cellserv.dat
REM vdelay 100
sed -in 's/-[0-9][0-9]HAV00000-/-%tnum%HAV00000-/' %PXEDATA%\cellserv.dat
sed -in 's/ HAV/HAV/' %PXEDATA%\cellserv.dat
set tnum=
vdelay 500
REM sed -in 's/ - /-/g' %PXEDATA%\cellserv.dat
REM vdelay 700

:askmdwidnum
REM Ask user input mdwid number...
echo.
echo.
echo.
vecho /n /fYELLOW "Enter Tester MDW ID (Press CTRL-C to Cancel): "
vask /c | set /p mdwid=
if "%errorlevel%" == "200" goto done
echo MDWID : %mdwid% : will be added to cellserv.ini file...
vecho /fGRAY " "

REM Validate user input is FOUR digits only
verrlvl 0
echo %mdwid% | xgrep ^[0-9][0-9][0-9][0-9][^.*]$
if "%mdwid%" == "" goto validatefail2
if "%mdwid%" == "0" goto validatefail2
if "%errorlevel%" == "0" goto validatepass2

:validatefail2
echo Please enter only 4 digit numbers from 0001 - 9999.
PAUSE
set mdwid=
goto askmdwidnum

:validatepass2
sed -in 's/MDWID=[0-9][0-9][0-9][0-9]/MDWID=%mdwid%/' %PXEDATA%\cellserv.ini
set mdwid=
REM vdelay 700

vdelay 500
CLS
goto copyfiles

:done
VERIFY OFF
:end
