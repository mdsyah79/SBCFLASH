@echo off

sed '/MDWID/ a\ServerIP=172.30.30.254    ; This line is automatically added by SBCFLASH for PXEBOOT' < cellserv.old > cellserv.ini
edit cellserv.ini

if exist tstrnum.txt del tstrnum.txt

type cellserv.dat | sed 's/-/\n/ g' 
pause
type cellserv.dat | sed 's/-/\n/ g' | sed -n '/[0-9][0-9]HAV*/ p'
pause
type cellserv.dat | sed 's/-/\n/ g' | sed -n '/[0-9][0-9]HAV*/ p' | sed -n 's/HAV[0-9]*// p'
pause

type cellserv.dat | sed 's/-/\n/ g' | sed -n '/[0-9][0-9]HAV*/ p' | sed -n 's/HAV[0-9]*// p' > tstrnum.txt

type tstrnum.txt | set /p testernum=

sed -i 's/ cell[0-9][0-9]* / cell%testernum% /' mdwpxe.spt

edit mdwpxe.spt
