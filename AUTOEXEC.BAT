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
DEVLOAD /H /Q %dosdir%\BIN\UDVD2.SYS /D:FDCD0001

LH FDAPM APMDOS
IF "%config%"=="2" LH SHARE
IF EXIST %DOSDIR%\BIN\DOSLFN.COM LH DOSLFN
REM NLSFUNC %dosdir%\BIN\COUNTRY.SYS
REM DISPLAY CON=(EGA),858,2)
REM MODE CON CP PREP=((858) %dosdir%\CPI\EGA.CPX)
REM KEYB US,858,%dosdir%\bin\keyboard.sys
REM CHCP 858
REM MKEYB UK


REM MOUSE
CTMOUSE

REM ***** Below is CDROM driver. Diabled by adding REM *****
SHSUCDX /QQ /D3
REM LH SHSUCDHD /QQ /F:FDBOOTCD.ISO
REM DEVLOAD /H /Q %dosdir%\BIN\UIDE.SYS /H /D:FDCD0001 /S5
SHSUCDX /QQ /~ /D:?SHSU-CDR,D /D:?SHSU-CDH,D /D:?FDCD0001,D /D:?FDCD0002,D /D:?FDCD0003,D

REM ***** Below is MEM=DISPLAY MEMORY USAGE SCHUCDX=DISPLAY WHICH CDROM. Diabled by adding REM *****
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

REM Network ENable
REM FDNET

REM ----------------------SBCFLASH START----------------------------------

SET SBCFLASH=C:\SBCFLASH

if not exist %sbcflash%\sbcflash.bat goto NOSBCFLASHFOUND

if exist %TEMP%\366REPART.TXT goto 366repart

if exist %TEMP%\375REPART.TXT goto 375repart

if exist %TEMP%\REPART.TXT goto repartmode

if exist %TEMP%\CFINSER1.TXT goto cfinser1

if exist %TEMP%\CFINSER4.TXT goto cfinser4

CALL %sbcflash%\sbcflash.bat
goto done

:nosbcflashfound
echo No SBCFLASH program found! Exiting to DOS prompt...
goto done

:366repart
echo Ver 366 REPART Mode
vdelay 1000
REM CALL %SBCFLASH%\366\1.BAT
CALL %sbcflash%\sbcflash.bat 366repart
goto done

:375repart
echo Ver 375 REPART Mode
vdelay 1000
REM CALL %SBCFLASH%\375\1.BAT
CALL %sbcflash%\sbcflash.bat 375repart
goto done

:repartmode
echo REPART Mode
vdelay 1000
REM CALL %SBCFLASH%\4CONV1\FDMENU.BAT REPART
CALL %sbcflash%\sbcflash.bat repart
goto done

:cfinser1
echo CFINSER1 Mode
vdelay 1000
CALL %sbcflash%\sbcflash.bat cfinser1
goto done

:cfinser4
echo CFINSER4 Mode
vdelay 1000
CALL %sbcflash%\sbcflash.bat cfinser4
goto done


:done
CD\
