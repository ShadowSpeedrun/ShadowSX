#8040da78
#PracticeModeCommands.asm
#All controller commands needed for Practice Mode
#Will be processed here.

#r4 is the value of 8056ED4E which is the digital button presses.

#Original Code
lwz r5, 0 (r30)

#Check if Practice Mode
lis r18, 0x8057
ori r18, r18, 0xD8F4
lbz r16, 0(r18)
cmpwi r16, 1
bne End

andi. r16, r4, 0x20
cmpwi r16, 0x20
bne End

#Check if Clear Meters and Score Command
andi. r16, r4, 0x3020
cmpwi r16, 0x3020 #Z+L+R
bne HeroCheck
#Execute Clear Meters Command
li r17, 0
lis r18, 0x8057
ori r18, r18, 0x66C8
stw r17, 0(r18)
stw r17, 0xC(r18)
stw r17, 0x4C(r18)
stw r17, 0x50(r18)
b End

HeroCheck:
#Check if Fill Hero Meter Command
andi. r16, r4, 0x2020
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
andi. r16, r4, 0x1020
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
andi. r16, r4, 0x60
cmpwi r16, 0x60 #Z+DPad Up
bne CheckTimerStateChange
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

CheckTimerStateChange:
#Check if Toggle Meter with Score Command
andi. r16, r4, 0xA0
cmpwi r16, 0xA0 #Z+DPad Down
bne ClearToggleLock

#Consume the Dpad Down Input to prevent 
#it from changing partner character status.
subi r4, r4, 0x80

#Execute Timer State Change Command
lis r18, 0x8057
ori r18, r18, 0xD8F5

lbz r16, 1(r18)
cmpwi r16, 1
beq End

#ApplyLock
li r16, 1
stb r16, 1(r18)

lbz r16, 2(r18)
addi r16, r16, 1
cmpwi r16, 2
ble ChangeTimeMode
li r16, 0
ChangeTimeMode:
stb r16, 2(r18)
b End

ClearToggleLock:
lis r18, 0x8057
ori r18, r18, 0xD8F6
li r16, 0
stb r16, 0(r18)

End:
  #Rerun earlier cmpwi to fix upcoming beq
  cmpwi r3, 0