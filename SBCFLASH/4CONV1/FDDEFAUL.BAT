cls
echo            **************************************************
echo            ***      LOAD DEFAULT (TESTER 1) SETTINGS      ***
echo            ************************************************** 
echo.
echo            Press  1 = Load 366 version Default (T1) cellserv
echo.
echo            Press  2 = Load 375 version Default (T1) cellserv
echo.
echo            Press  3 = Return to main menu
echo.
Choice /C:123 /N /S "Choose Your Option (1,2,3,4 or 5)?"%1
IF ERRORLEVEL ==3 GOTO OTHREE
IF ERRORLEVEL ==2 GOTO OTWO
IF ERRORLEVEL ==1 GOTO OONE

:OONE
cls
echo.
copy c:\366\cell.dat d:cellserv.dat
copy c:\366\cell.ini c:cellserv.ini
@echo off
cls
echo.
echo.
echo.
echo ### NEW SBC Verion 3.66 ###
echo.
echo.
echo load default (Tester 1) INI and DAT info.....Done.

:OTWO
cls
echo.
copy c:\375\cell.dat d:cellserv.dat
copy c:\375\cell.ini c:cellserv.ini
@echo off
cls
echo.
echo.
echo.
echo ### NEW SBC Verion 3.75 ###
echo.
echo.
echo load default (Tester 1) INI and DAT info.....Done.

:OTHREE
EXIT
