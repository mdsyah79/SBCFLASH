@ECHO OFF
REM FDFORMAT is a SBCFLASH utility to Quick Format CF cards
REM This FDFORMAT uses part.exe as a backup formatting tool.
CLS
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card FORMAT/MAKEBOOT IN-PROGRESS ***"
vecho /fGRAY

if exist %TEMP%\log.tmp del %TEMP%\log.tmp
SET formatcount=0

REM Start of CF Formating operations
verrlvl 0
FORMAT /s /q /z:seriously D:
if errorlevel 4 goto partfmt
vdelay 1000
goto checkformat

:partfmt
REM Alternative formatting tool since first format failed
vdelay 1000
vecho /fYellow /bGRAY "Ooops... You have a stubborn CF card."
vecho /fYellow /bGRAY "First format failed. Executing secondary formatting..."
vecho /fGRAY
part -q -d 2 -f 1
vdelay 1000

:checkformat
REM check if format is successful
verrlvl 0
vinfo /d D:
if errorlevel 5 goto formatfail
vdelay 1000

REM Check CF with DOSFSCK
DOSFSCK -av D:
vdelay 1000

:makeboot
REM Change to required directory
PUSHD C:\SBCFLASH\4CONV1

REM Run makeboot by Pharlap to make d bootable
makeboot d diskmon.bin
vdelay 1500
c:

REM Change to working directory
POPD

echo.
echo.
vecho /fGREEN "MAKEBOOT completed making CF bootable to cellexe."
vecho /fGRAY
vdelay 2000

:makebootpass
CLS
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card FORMAT/MAKEBOOT SUCCESSFUL ***"
vecho /fGRAY
echo.
echo.
echo.
vecho /fGREEN "MAKEBOOT completed making CF bootable to cellexe."
vecho /fGRAY
vdelay 2000
goto done

REM This section is makeboot failure delcaration and return to main.
:makebootfail
CLS
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card MAKEBOOT FAILED ***"
vecho /fGRAY
echo.
echo.
vecho /fRED "Attempt to make bootable the 4GB CF card failed."
vecho /fRED "It could be the CF card is faulty or not inserted properly"
echo.
echo.
vecho /n /fWHITE "Will return to Main Menu in "
vpause /fYELLOW /t10 CTRL-C
vecho /fGRAY "(Press CTRL-C to skip timer)"
verrlvl 200
echo.
CALL FDCLEAN.BAT
goto end

REM This section is partiton failure delcaration and return to main.
:formatfail
CLS
vecho /fYELLOW /bBLUE "*** %cfcap%GB CF card FORMAT FAILED ***"
vecho /fGRAY
echo.
echo.
vecho /fRED "Attempt to format the 4GB CF card failed."
vecho /fRED "It could be the CF card is faulty, not inserted properly"
echo.
echo.
vecho /n /fWHITE "Will return to Main Menu in "
vpause /fYELLOW /t10 CTRL-C
vecho /fGRAY "(Press CTRL-C to skip timer)"
verrlvl 200
echo.
CALL FDCLEAN.BAT
goto end

:done

:end