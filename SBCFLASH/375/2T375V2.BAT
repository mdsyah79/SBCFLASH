REM SET DATA STORAGE FOR CF CARD TO C:\SBCFLASH\375\DATAFILE
SET DATA=C:\SBCFLASH\375\DATAFILE

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
sed -i '/^\; The above line is automatically/d' %DATA%\cellserv.ini
