@ECHO OFF
REM PXEFMT is a SBCFLASH utility to Quick Format CF cards
CLS
vecho /fYELLOW /bBLUE "*** Format and apply Syslinux Bootloader IN-PROGRESS ***"
vecho /fGRAY
vdelay 500

REM Start of CF Formating operations
FORMAT /s /q /z:seriously D:

REM check if format is successful
verrlvl 0
vinfo /d D:
if errorlevel 5 goto formatfail
vecho /fYELLOW /bBLUE "*** CF card FORMAT SUCCESSFUL ***"
vecho /fGRAY
vdelay 1500

REM Run Syslinux command to make d bootable
CLS
vecho /fYELLOW /bBLUE "*** Format and apply Syslinux Bootloader IN-PROGRESS ***"
vecho /fGRAY
syslinux -f -i -m -a -d \ D:
vdelay 1500

echo.
echo.
vecho /fGREEN "SYSLINUX completed making CF bootable."
vecho /fGRAY
vdelay 3000
goto end

CLS
vecho /fYELLOW /bBLUE "*** CF card FORMAT/MAKEBOOT SUCCESSFUL ***"
vecho /fGRAY
echo.
echo.
echo.
vecho /fGREEN "MAKEBOOT completed making CF bootable to cellexe."
vecho /fGRAY
vdelay 2000
goto end

REM This section is makeboot failure delcaration and return to main.
:syslinuxfail
CLS
vecho /fYELLOW /bBLUE "*** CF card MAKEBOOT FAILED ***"
vecho /fGRAY
echo.
echo.
vecho /fRED "Attempt to make bootable the CF card failed."
vecho /fRED "It could be the CF card is faulty or not inserted properly"
echo.
echo.
vecho /n /fWHITE "Will return to Main Menu in "
vpause /fYELLOW /t10 CTRL-C
vecho /fGRAY "(Press CTRL-C to skip timer)"
verrlvl 200
echo.
CALL PXECLEAN.BAT
goto end

REM This section is partiton failure delcaration and return to main.
:formatfail
CLS
vecho /fYELLOW /bBLUE "*** CF card FORMAT FAILED ***"
vecho /fGRAY
echo.
echo.
vecho /fRED "Attempt to format the CF card failed."
vecho /fRED "It could be the CF card is faulty, not inserted properly"
echo.
echo.
vecho /n /fWHITE "Will return to Main Menu in "
vpause /fYELLOW /t10 CTRL-C
vecho /fGRAY "(Press CTRL-C to skip timer)"
verrlvl 200
echo.
CALL PXECLEAN.BAT
goto end

:done
:end