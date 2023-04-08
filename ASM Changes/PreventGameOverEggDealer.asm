#To be inserted at 8020449c
;PreventGameOverEggDealer.asm

;Original Code
;lwz r0, 0x0020 (r3)

Start:
  ;Load value of "Egg Dealer Lives Flag"
  ;into r18. (8057D929)
  lis r18, 0x8057
  ori r18, r18, 0xD929
  lhz r18, 0(r18)

  ;If "Egg Dealer Lives Flag" is true
  ;Set r0 to 1 to trick the check.
  cmplwi r18, 1
  bne- OriginalCode
  li r0, 1
  b End

OriginalCode:
  lwz r0, 0x0020 (r3)
  b End

End:
 li r18, 0x0