@echo off

if x%1 == x goto err

set DRV=%1

if %DRV% == A: goto rep_a
if not %DRV% == a: goto skip_a
:rep_a
set DRV=A
:skip_a

if %DRV% == B: goto rep_b
if not %DRV% == b: goto skip_b
:rep_b
set DRV=B
:skip_b

set MON=diskkern.bin
if "%2"=="" goto no_mon
set MON=%2
:no_mon
if exist %MON% goto found_mon
echo Error: Cannot find monitor "%MON%"
goto err
:found_mon

echo.
echo Making boot disk in drive %DRV%: with ETS Monitor "%MON%"
echo.
echo WARNING: All data in drive %DRV%: will be erased! (CTRL-C aborts)
echo.
rem pause

format %DRV%: /q /u
makeboot %DRV% %MON%
cls
echo.
rem echo Step 2: Press 2 follow by enter...

goto end

:err

echo.
echo usage: BOOTDISK disk_drive [monitor_filename]
echo.
echo     disk_drive:       drive name (A, B, C, etc.)
echo     monitor_filename: name of ETS Monitor file, default is DISKKERN.BIN
echo.
echo Use this batch file to create a bootable embedded kernel disk to use
echo for cross-debugging.  It can be used with hard disks as well as with
echo floppy disks.
echo.
echo example:  BOOTDISK A              (creates bootable disk in drive A:)
echo           BOOTDISK E mymon.bin    (creates disk in E: with MYMON.BIN)
echo.

:end
