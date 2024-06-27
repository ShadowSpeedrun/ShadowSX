#803499cc
#PracticeModeCommands.asm
#All controller commands needed for Practice Mode
#Will be processed here.

#r0 is the value of 8056ED4E which is the digital button presses.

#Original Code
stw r0, 0x0028 (r31)

#Check if Practice Mode
lis r18, 0x8057
ori r18, r18, 0xD8F4
lbz r16, 0(r18)
cmpwi r16, 1
bne End

andi. r16, r0, 0x20
cmpwi r16, 0x20
bne End

#Check if Clear Meters Command
andi. r16, r0, 0x3020
cmpwi r16, 0x3020 #Z+L+R
bne HeroCheck
#Execute Clear Meters Command
li r17, 0
lis r18, 0x8057
ori r18, r18, 0x66C8
stw r17, 0(r18)
stw r17, 0xC(r18)
b End

HeroCheck:
#Check if Fill Hero Meter Command
andi. r16, r0, 0x2020
cmpwi r16, 0x2020 #Z+R
bne DarkCheck
#Execute Fill Hero Meter Command
li r17, 0x7530
lis r18, 0x8057
ori r18, r18, 0x66C8
stw r17, 0(r18)
b End

DarkCheck:
#Check if Fill Dark Meter Command
andi. r16, r0, 0x1020
cmpwi r16, 0x1020 #Z+L
bne CheckMeterScoreToggle
#Execute Fill Dark Meter Command
li r17, 0x7530
lis r18, 0x8057
ori r18, r18, 0x66C8
stw r17, 0xC(r18)
b End

CheckMeterScoreToggle:
#Check if Toggle Meter with Score Command
andi. r16, r0, 0x60
cmpwi r16, 0x60 #Z+DPad Down
bne ClearToggleLock
#Execute Toggle Meter with Score Command
lis r18, 0x8057
ori r18, r18, 0xD8F5

lbz r16, 1(r18)
cmpwi r16, 1
beq End

#ApplyLock
li r16, 1
stb r16, 1(r18)

lbz r16, 0(r18)
cmpwi r16, 0
bne SetToggleOff
li r16, 1
b SetToggle
SetToggleOff:
li r16, 0
SetToggle:
stb r16, 0(r18)
b End

ClearToggleLock:
lis r18, 0x8057
ori r18, r18, 0xD8F6
li r16, 0
stb r16, 0(r18)

End: