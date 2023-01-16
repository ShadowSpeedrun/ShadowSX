#To be inserted at 8016F068
;Original Code
;li r0, 0x5

Start:
  ;Load value of "Egg Dealer Lives Flag"
  ;into r16. (8057D929)
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x61B2
  or r18, r16, r17
  lhz r16, 0(r18)

  ;If "Egg Dealer Lives Flag" is true
  ;Load 0 instead of 99.
  cmplwi r16, 1
  bne- MoreLives
  li r0, 0x0
  b End

MoreLives:
  li r0, 0x63
  b End

End:
 li r16, 0x0
 li r17, 0x0
 li r18, 0x0