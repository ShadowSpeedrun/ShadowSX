#!/bin/sh
cd "$(cd "$(dirname "$0")" && pwd)"
mkdir old
chmod +x xdelta3
./xdelta3 -v -d -s "ShadowTheHedgehog.iso" "vcdiff/ShadowSX.vcdiff" "ShadowSX.iso"
mv "ShadowTheHedgehog.iso" old
