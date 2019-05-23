@echo off
SET DATAFILE=C:\SBCFLASH\366
IF EXIST %TEMP%\366REPART.TXT GOTO repartmode

REM This line is to ensure unformatted CF wont cause error
verrlvl 0
vinfo /d d:
if errorlevel 5 goto repartmode

verrlvl 0
IF NOT EXIST D:\cellserv.dat copy/y %DATAFILE%\cell.dat %DATAFILE%\cellserv.dat
IF NOT EXIST D:\cellserv.ini copy/y %DATAFILE%\cell.ini %DATAFILE%\cellserv.ini

IF EXIST d:\cellserv.dat copy/y d:\cellserv.dat c:\sbcflash\366\*.* > NUL
IF EXIST d:\cellserv.ini copy/y d:\cellserv.ini c:\sbcflash\366\*.* > NUL

IF NOT EXIST D:\cellserv.ini vecho /n /fYELLOW /bGREEN "Cellserv not found. Cloned from C!!!"
IF EXIST d:\cellserv.* vecho /n /fYELLOW /bGREEN "Successfully cloned cellserv files to C: drive!!!"
vpause /fYELLOW /bGREEN /t3

:repartmode
CALL 1CHKCF.BAT
IF %ERRORLEVEL% == 200 GOTO end

CLS
vecho /fYELLOW /bGREEN "Formatting CF card now..."
vecho /fGRAY /bBLACK
vdelay 500

format d: /Q /S /Z:seriously
if %errorlevel% == 0 goto AfterFormat

REM Secondary format
part -d 2 -f 1
sys d:

vdelay 500

:AfterFormat
REM vinfo /d %FDRIVE%

REM vinfo ERRORLEVELS
REM if errorlevel 100 goto Done
REM if errorlevel 15 goto NoSuchDrive (drive not present)
REM if errorlevel 5 goto IgnoreThisError (not formatted)
REM if errorlevel 2 goto WrongTypeDrive (removable drive aka floppy detected)

REM Check if Drive is readable after format
vinfo /v /d D:

if errorlevel 5 goto notformatted

vecho /n /fYELLOW /bGREEN "Drive D: formatted SUCESSFULLY!!!"
vpause /fYELLOW /bGREEN /t1
vecho /n /fGRAY /bBLACK

verrlvl 0
goto done

:notformatted
vecho /n /fRED /bGREEN "Unable to format drive D:!!!"
vpause /fYELLOW /bGREEN /t3
vecho /fGRAY /bBLACK

goto end
:done

PUSHD C:\SBCFLASH\366

CLS
makeboot d diskmon.bin
vdelay 500

:done
POPD

echo.
echo.
echo.
vecho /n /fYELLOW /bBLUE "CF Card Format and Makeboot program COMPLETED!!!"
vpause /fYELLOW /bBLUE /t1
vecho /fGRAY /bBLACK

:end
PUSHD C:\SBCFLASH\366
CALL 1CLEAN.BAT
POPD
verrlvl 0

rem -----old line-----
rem format d:/s
rem c:\366\
rem bootdisk d diskmon.bin
