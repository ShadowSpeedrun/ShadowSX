#To be inserted at 8020449c
;Prevent Game Over if in Egg Dealer Fight Mode
;Original Code
;lwz r0, 0x0020 (r3)

Start:
  ;Load value of "Egg Dealer Lives Flag"
  ;into r16. (8057D929)
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x61B2
  or r18, r16, r17
  lhz r16, 0(r18)

  ;If "Egg Dealer Lives Flag" is true
  ;Set r0 to 1 to trick the check.
  cmplwi r16, 1
  bne- OriginalCode
  li r0, 1
  b End

OriginalCode:
  lwz r0, 0x0020 (r3)
  b End

End:
 li r16, 0x0
 li r17, 0x0
 li r18, 0x0