@ECHO OFF
SET DOSDIR=C:\FDOS
SET LANG=EN
SET TZ=UTC
SET PATH=%dosdir%\BIN
if exist %dosdir%\LINKS\NUL SET PATH=%path%;%dosdir%\LINKS
SET NLSPATH=%dosdir%\NLS
SET HELPPATH=%dosdir%\HELP
SET TEMP=%dosdir%\TEMP
SET TMP=%TEMP%
SET BLASTER=A220 I5 D1 H5 P330
SET DIRCMD=/P /OGN /Y
SET COPYCMD=/-Y

IF "%config%"=="4" GOTO END
DEVLOAD /H /Q %dosdir%\BIN\UDVD2.SYS /D:FDCD0001

LH FDAPM APMDOS
IF "%config%"=="2" LH SHARE
rem IF EXIST %DOSDIR%\BIN\DOSLFN.COM LH DOSLFN
REM NLSFUNC %dosdir%\BIN\COUNTRY.SYS
REM DISPLAY CON=(EGA),858,2)
REM MODE CON CP PREP=((858) %dosdir%\CPI\EGA.CPX)
REM KEYB US,858,%dosdir%\bin\keyboard.sys
REM CHCP 858
REM MKEYB UK


REM MOUSE
CTMOUSE

SHSUCDX /QQ /D3
REM LH SHSUCDHD /QQ /F:FDBOOTCD.ISO
REM DEVLOAD /H /Q %dosdir%\BIN\UIDE.SYS /H /D:FDCD0001 /S5
SHSUCDX /QQ /~ /D:?SHSU-CDR,D /D:?SHSU-CDH,D /D:?FDCD0001,D /D:?FDCD0002,D /D:?FDCD0003,D

MEM /C /N
SHSUCDX /D

:END
SET AUTOFILE=%0
SET CFGFILE=C:\FDCONFIG.SYS
alias reboot=fdapm warmboot
alias reset=fdisk /reboot
alias halt=fdapm poweroff
alias shutdown=fdapm poweroff
alias cfg=edit %cfgfile%
alias auto=edit %0

set OS_NAME=FreeDOS
set OS_VERSION=1.2

if exist %dosdir%\bin\fdnet.bat call %dosdir%\bin\fdnet.bat start
if exist %dosdir%\bin\welcome.bat call %dosdir%\bin\welcome.bat
