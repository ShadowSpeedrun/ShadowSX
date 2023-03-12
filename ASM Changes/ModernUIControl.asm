#To be inserted at 803562A0
;Modern UI Control
;Original Code
lwzx r4, r29, r0

;Load "EnableXboxUI" Address into r18. (8057D8FF)
lis r16, 0x8057
li r17, 0x7777
addi r17, r17, 0x6188
or r18, r16, r17

;Check if feature is enabled.
lhz r19, 0(r18)
cmplwi r19, 1
bne- End

cmplwi r4, 2
beq- PressAccept
cmplwi r4, 8
beq- PressBack
b End

PressAccept:
  li r4, 0x8
  b End

PressBack:
  li r4, 0x2
  b End

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
  li r19, 0x0