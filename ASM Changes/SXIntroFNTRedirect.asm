#To be inserted at 80049e0c
;SX Intro FNT Redirect

;Original Code
;lwz r3, 0 (r10)

cmpwi r11, 1
bne CancelAndExit

;Check for if we are rendering blank message(8057D8FD = 44)
lis r18, 0x807D
addi r18, r18, 0x5700
lwz r16, 0(r18)

cmpwi r16, 44
bne CancelAndExit

;Check which screen to show
lis r16, 0x8057
li r17, 0x7777
addi r17, r17, 0x6184
or r18, r16, r17
lhz r16, 0(r18)

;r18 is offset to use.
mulli r18, r16, 0x14
b Exit

CancelAndExit:
  li r18, 0

Exit:
  lwzx r3, r10, r18
  li r16, 0
  li r17, 0
  li r18, 0