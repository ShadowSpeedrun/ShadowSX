@echo off
mkdir old
.\xdelta-3.1.0-x86_64.exe -v -d -s "ShadowTheHedgehog.iso" "vcdiff/ShadowSX.vcdiff" "ShadowSX.iso"
move "ShadowTheHedgehog.iso" old
echo Completed!
@pause
