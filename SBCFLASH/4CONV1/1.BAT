@echo off

XCOPY D:\*.* %CFDATA%\*.* /a /e /h /s /y /v
vdelay 1500

REM copy/y d:\cellserv.dat c:\sbcflash\366\*.*
REM copy/y d:\cellserv.ini c:\sbcflash\366\*.*

vecho /n /fYELLOW /bGREEN "Successfully cloned cellserv files to C: drive!!!"
vpause /fYELLOW /bGREEN /t1

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

rem -----old line-----
rem format d:/s
rem c:\366\
rem bootdisk d diskmon.bin
