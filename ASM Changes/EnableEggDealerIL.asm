#To be inserted at 80356314
;Set Egg Dealer IL Mode
;Original Code
;lwzx	r30, r29, r0

Start:
  ;Load the value of "P1 Button State" into r19.(8056ED4C)
  lis r16, 0x8056
  li r17, 0x7777
  addi r17, r17, 0x75D5
  or r18, r16, r17
  lwz r19, 0(r18)

  ;to check for Dpad Up (0x40)
  andi. r19, r19, 0x40
  cmplwi r19, 0x40
  bne- DisableEggIL
  b CheckIfEggDealer

CheckIfEggDealer:
  ;Load the value of "Final Boss Selected" into r19.(80584570)
  lis r16, 0x8058
  li r17, 0x4570
  or r18, r16, r17
  lbz r19, 0(r18)
  ;to check for the final bosses being selected
  cmplwi r19, 0x01
  bne- DisableEggIL

  ;Load the value of "Final Boss Position" into r19.(8058456C)
  lis r16, 0x8058
  li r17, 0x456C
  or r18, r16, r17
  lwz r19, 0(r18)

  ;Load "Egg Dealer IL Flag" Address into r18.
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x61B2
  or r18, r16, r17

  ;Only enable if boss is Egg Dealer
  cmplwi r19, 0x3
  beq EnableEggIL
  cmplwi r19, 0x4
  beq EnableEggIL
  cmplwi r19, 0x5
  beq EnableEggIL
  cmplwi r19, 0x6
  beq EnableEggIL
  b DisableEggIL

EnableEggIL:
  ;Set "Egg Dealer IL Flag" to true.
  li r19, 0x1
  sth r19, 0(r18)
  b End
  
DisableEggIL:
  ;Set "Egg Dealer IL Flag" to False.
  li r19, 0x0
  sth r19, 0(r18)
  b End

End:
 li r16, 0x0
 li r17, 0x0
 li r18, 0x0
 li r19, 0x0
 lwzx	r30, r29, r0