copy d:\cellserv.dat c:\sbcflash\366\*.*
copy d:\cellserv.ini c:\sbcflash\366\*.*

format d: /S /Q /U /Z:seriously

:AfterFormat
vinfo /d %FDRIVE%

if errorlevel 2 goto StillCannotReadC

verrlvl 0
goto Done


:StillCannotReadC
set FERROR="Unable to read drive %FDRIVE% after format."

:Done

c:\sbcflash\366\
bootdisk d diskmon.bin
 
rem -----old line-----
rem format d:/s
rem c:\366\
rem bootdisk d diskmon.bin
