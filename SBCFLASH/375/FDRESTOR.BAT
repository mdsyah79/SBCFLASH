@ECHO OFF
REM FDBACKUP Freedos (SBCFLASH) RESTORE files to D: drive (4GB CF CARD)
REM will abort if any files not found

REM SET DATA STORAGE FOR CF CARD TO C:\SBCFLASH\4CONV1\DATAFILE
SET CFDATA=C:\SBCFLASH\4CONV1\DATAFILE

CLS
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card RESTORE in progress ***"
vecho /fGRAY
echo.
echo.

REM CF card is detected and copy files if files exists
:copyfiles
echo D: drive detected!!! Copying files...

REM Run DOSFSCK to chk CF card
DOSFSCK -av D:
vdelay 1000

if not exist %CFDATA%\NUL goto dirnotfound
if not exist %CFDATA%\cellserv.dat goto notfound
if not exist %CFDATA%\cellserv.ini goto notfound
if not exist %CFDATA%\cellexe.exe goto notfound

REM REMOVE 'ServerIP=172.30.30.254' FROM CELLSERV.INI IF EXISTS
echo REMOVING 'ServerIP=172.30.30.254' IF EXISTS IN CELLSERV.INI
sed -i '/^ServerIP/d' %CFDATA%\cellserv.ini
vdelay 500
sed -i '/^; The above line is automatically/d' %CFDATA%\cellserv.ini
vdelay 500


XCOPY %CFDATA%\*.* D:\*.* /a /e /h /s /y /v
vdelay 1500

REM RESTORE successful
echo.
echo.
vecho /n /fYELLOW /bLIGHTGREEN "RESTORE of 1BF CF data files to 4GB CF SUCCESSFUL..."
vpause /fYELLOW /t7
vecho /fGRAY
echo.
echo.
goto done

:dirnotfound
echo.
echo.
vecho /n /fRED "Folder: " %CFDATA% " not found. Aborting Program..."
vpause /fYELLOW /t10
vecho /fGRAY
echo.
echo.
CALL FDCLEAN.BAT
verrlvl 200
goto end

:notfound
echo.
echo.
vecho /fRED "Required files ( cellserv.ini, cellserv.dat or cellexe.exe ) not found."
vecho /n /fRED "Aborting Program..."
vpause /fYELLOW /t10
vecho /fGRAY
echo.
echo.
CALL FDCLEAN.BAT
verrlvl 200
goto end

:done
:end
SET CFDATA=
