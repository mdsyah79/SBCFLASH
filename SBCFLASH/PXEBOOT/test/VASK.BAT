@echo off

vecho /n /fYELLOW "Your name?"
vask /c /d10 /fWHITE /bBLUE Jerome Shidel | set /p NAME=
if errorlevel 200 goto CTRLC
if errorlevel 1 goto TIMEOUT
vecho /a0x07 /p Hello there /s- '" /fWHITE "%NAME%" /fGRAY'."
goto DONE

:CTRLC
:TIMEOUT
vecho /a7 /p Default user name %NAME% selected.
:DONE
set NAME=

