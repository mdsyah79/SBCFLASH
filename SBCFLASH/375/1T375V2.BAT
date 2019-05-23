@echo off

REM SET DATA STORAGE FOR CF CARD TO C:\SBCFLASH\4CONV1\DATAFILE
SET DATA=C:\SBCFLASH\375\DATAFILE

REM If DATA folder not exist, create one. Ignore errors.
IF NOT EXIST %DATA%\NUL MKDIR %DATA%
vdelay 1000
IF NOT EXIST %DATA%\NUL goto MKDIRERR


REM copy/y d:\cellserv.dat c:\sbcflash\375\*.*
REM copy/y d:\cellserv.ini c:\sbcflash\375\*.*

XCOPY D:\*.* %DATA%\*.* /a /e /s /h /y /v
vdelay 1500

REM Backup successful
echo.
echo.
vecho /n /fWHITE "Backup CF card info to C: Drive SUCCESSFUL..."
vdelay 3000
REM vpause /fYELLOW /t3
vecho /fGRAY
echo.
echo.
goto done

CLS
vecho /fYELLOW /bGREEN "Formatting CF card now..."
vecho /fGRAY /bBLACK
vdelay 500

format d: /S /Q /Z:seriously

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

goto End
:done

PUSHD C:\SBCFLASH\375

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
SET DATA=
rem -----old line-----
rem format d:/s
rem c:\375\
rem bootdisk d diskmon.bin
