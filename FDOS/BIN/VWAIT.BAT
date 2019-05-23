@ECHO OFF

IF "%1"=="" GOTO Syntax

ECHO.

ECHO Waiting %1 seconds

ECHO.

vmath %1 * 1000 | set /p WAITIME=

vdelay %WAITIME%

GOTO Done

 

:Syntax

ECHO.

ECHO WAIT for a specified number of seconds

ECHO.

ECHO Usage:  WAIT  n

ECHO.

ECHO Where:  n  =  the number of seconds to wait (1 to 99)

ECHO.

 

:Done
SET WAITIME=
