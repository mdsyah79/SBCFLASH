@echo off

sed '/ goto retry_dhcp/ a\# Please ensure above cellX, X is your tester number you are flashing.' < mdwpxe.spt > mdwpxe.new

edit mdwpxe.new
