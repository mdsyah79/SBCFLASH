@echo off
REM FDCLEAN.BAT is a clean-up script to clear used variables

REM ****** Cleanup Operation ******
SET CFNODET=
SET CFNOFMT=
SET CFNOPART=
SET CFWRGPART=
SET minival=
SET cfcap=
REM SET errlog=
if exist %TEMP%\log.tmp del %TEMP%\log.tmp
IF exist %TEMP%\REPART.TXT DEL %TEMP%\REPART.TXT
IF exist %TEMP%\CFINSER1.TXT DEL %TEMP%\CFINSER1.TXT
IF exist %TEMP%\CFINSER4.TXT DEL %TEMP%\CFINSER4.TXT
IF exist %TEMP%\CFINSER.TXT DEL %TEMP%\CFINSER.TXT
REM *******************************
