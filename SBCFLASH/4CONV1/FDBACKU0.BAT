@ECHO OFF
REM FDBACKUP Freedos (SBCFLASH) Backup cellserv and cellexe files to C: drive
REM will abort if any files not found

REM SET DATA STORAGE FOR CF CARD TO C:\SBCFLASH\4CONV1\DATAFILE
SET CFDATA=C:\SBCFLASH\4CONV1\DATAFILE

REM If CFDATA folder not exist, create one. Ignore errors.
IF NOT EXIST %CFDATA%\NUL MKDIR %CFDATA%
vdelay 1000
IF NOT EXIST %CFDATA%\NUL goto MKDIRERR

REM If DATAFILE folder exists, clear all contents
IF EXIST %CFDATA%\NUL DELTREE/Y %CFDATA%\

CLS
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card BACKUP IN-PROGRESS ***"
vecho /fGRAY
echo.
echo.

REM Check CF with DOSFSCK
DOSFSCK -av D:
vdelay 1000

REM CF card is detected and copy files if files exists
:copyfiles
echo D: drive detected!!! Copying files...

if not exist D:\cellserv.dat goto notfound
if not exist D:\cellserv.ini goto notfound
if not exist D:\cellexe.exe goto nocellexe

XCOPY D:\*.* %CFDATA%\*.* /a /e /h /s /y /v
vdelay 1500

REM Backup successful
echo.
echo.
vecho /n /fWHITE "Backup of 1GB datafiles to C: drive SUCCESSFUL..."
vdelay 3000
REM vpause /fYELLOW /t3
vecho /fGRAY
echo.
echo.
goto done

REM For any downgrade scenario where PXE to PHARLAP then cellexe.exe will be reinserted back.
REM this is due to PXE boot dont require cellexe.exe
:nocellexe
echo.
echo.
vecho /fYELLOW "Required files ( cellexe.exe ) not found."
vecho /fGREEN "NEW cellexe.exe will be inserted..."
echo.
echo  ***Select which version you are flashing?***
echo.
echo  Press 1 = Version 3.66
echo.
echo  Press 2 = Version 3.75
echo.
echo  Press 3 = Quit
echo.
Choice /C:123 /N /S "Choose Your Option (1,2 or 3)?"
IF ERRORLEVEL ==3 GOTO done
IF ERRORLEVEL ==2 GOTO two
IF ERRORLEVEL ==1 GOTO one

:one
CLS
echo.
vecho /fYELLOW /bBLUE "*** Copying Cellexe.exe version 3.66 ***"
vecho /fGRAY
copy /y C:\SBCFLASH\366\CELLEXE.EXE D:\*.*
vpause /fYELLOW /t5
goto copyfiles

:two
CLS
echo.
vecho /fYELLOW /bBLUE "*** Copying Cellexe.exe version 3.75 ***"
vecho /fGRAY
copy /y C:\SBCFLASH\375\CELLEXE.EXE D:\*.*
vpause /fYELLOW /t5
goto copyfiles


:notfound
echo.
echo.
vecho /fRED "Required files ( cellserv.ini, cellserv.dat ) not found."
vecho /n /fRED "Aborting Program..."
vpause /fYELLOW /t10
vecho /fGRAY
echo.
echo.
CALL FDCLEAN.BAT
verrlvl 200
goto end

:mkdirerr
echo.
echo.
vecho /n /fRED "Unable to create %CFDATA% directory. Aborting Program..."
vpause /fYELLOW /t10
vecho /fGRAY
echo.
echo.
CALL FDCLEAN.BAT
verrlvl 200
goto end

:done
:end
SET CFDATA=
