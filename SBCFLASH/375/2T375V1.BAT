REM SET DATA STORAGE FOR CF CARD TO C:\SBCFLASH\366\DATAFILE
SET DATA=C:\SBCFLASH\366\DATAFILE

REM CF card is detected and copy files if files exists
:copyfiles
echo Copying files to D:...

if not exist %DATA%\NUL goto dirnotfound
vdelay 1000

IF EXIST %DATA%\cellexe.exe DEL %DATA%\cellexe.exe
IF NOT EXIST %DATA%\cellexe.exe echo deleted cellexe.exe

IF EXIST %DATA%\diskmon.bin DEL %DATA%\diskmon.bin
IF NOT EXIST %DATA%\diskmon.bin echo deleted diskmon.bin

REM REMOVE 'ServerIP=172.30.30.254' FROM CELLSERV.INI IF EXISTS
echo REMOVING 'ServerIP=172.30.30.254' IF EXISTS IN CELLSERV.INI
sed -i '/^ServerIP/d' %DATA%\cellserv.ini
vdelay 500

REM Copy Old CF datafiles to CF Card
XCOPY %DATA%\*.* D:\*.* /a /e /s /h /y /v /c
vdelay 1000

REM copy %sbcflash%\366\cellserv.dat d:\*.*
REM copy %sbcflash%\366\cellserv.ini d:\*.*
copy %sbcflash%\366\cellexe.exe d:\*.*

@echo off
echo.
echo.
echo.
vecho /fYELLOW /bGREEN "*** NEW SBC Verion 3.66 ***"
echo.
echo.
vecho /fYELLOW /bBLUE "Restore cellserv ini/dat info COMPLETED!!!"
echo.

set DATA=
vdelay 1000

