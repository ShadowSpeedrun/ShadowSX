#To be inserted at 8016F068
;SelectModeLives.asm

;Original Code
;li r0, 0x5

Start:
  ;Load value of "Egg Dealer Lives Flag"
  ;into r18. (8057D929)
  lis r18, 0x8057
  ori r18, r18, 0xD929
  lhz r18, 0(r18)

  ;If "Egg Dealer Lives Flag" is true
  ;Load 0 instead of 99.
  cmplwi r18, 1
  bne- MoreLives
  li r0, 0x0
  b End

MoreLives:
  li r0, 0x63
  b End

End:
 li r18, 0x0