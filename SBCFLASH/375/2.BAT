
copy %sbcflash%\375\cellserv.dat d:\*.*
copy %sbcflash%\375\cellserv.ini d:\*.*
copy %sbcflash%\375\cellexe.exe d:\*.*

REM REMOVE 'ServerIP=172.30.30.254' FROM CELLSERV.INI IF EXISTS
echo REMOVING 'ServerIP=172.30.30.254' IF EXISTS IN CELLSERV.INI
sed -i '/^ServerIP/d' D:\cellserv.ini
vdelay 500
sed -i '/^\; The above line is automatically/d' D:\cellserv.ini
vdelay 500

@echo off
echo.
echo.
echo.
vecho /fYELLOW /bGREEN "*** NEW SBC Verion 3.75 ***"
echo.
echo.
vecho /fYELLOW /bBLUE "Restore cellserv ini/dat info COMPLETED!!!"
echo.

vdelay 1000

