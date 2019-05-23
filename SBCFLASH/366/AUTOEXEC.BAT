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
REM ***** Below is DVD/CDROM drive driver. Diabled by adding REM *****
REM DEVLOAD /H /Q %dosdir%\BIN\UDVD2.SYS /D:FDCD0001

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
REM CTMOUSE

REM ***** Below is CDROM driver. Diabled by adding REM *****
REM SHSUCDX /QQ /D3
REM REM LH SHSUCDHD /QQ /F:FDBOOTCD.ISO
REM REM DEVLOAD /H /Q %dosdir%\BIN\UIDE.SYS /H /D:FDCD0001 /S5
REM SHSUCDX /QQ /~ /D:?SHSU-CDR,D /D:?SHSU-CDH,D /D:?FDCD0001,D /D:?FDCD0002,D /D:?FDCD0003,D

REM ***** Below is MEM=DISPLAY MEMORY USAGE SCHUCDX=DISPLAY WHICH CDROM. Diabled by adding REM *****
REM MEM /C /N
REM SHSUCDX /D

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

REM ----------------------SBCFLASH START----------------------------------

SET SBCFLASH=C:\SBCFLASH
SET PATH=%PATH%;%SBCFLASH%

if not exist %sbcflash%\sbcflash.bat goto NOSBCFLASHFOUND
call %sbcflash%\sbcflash.bat
goto DONE

:nosbcflashfound
echo No SBCFLASH program found! Exiting to DOS prompt...


:done

