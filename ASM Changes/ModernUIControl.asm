#To be inserted at 803562A0
;ModernUIControl.asm

;If the option is enabled, this code will swap the
;action that X and B would preform to match what the
;non-gamecube versions did.

;Original Code
lwzx r4, r29, r0

;Load "EnableXboxUI" Address into r18. (80577B2E)
lis r18, 0x8057
addi r18, r18, 0x7B2E

;Check if feature is enabled.
lbz r19, 0(r18)
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
  li r18, 0x0
  li r19, 0x0