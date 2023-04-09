#To be inserted at 80206334
;DpadUpSelectModeLevelEnter.asm

Start:
  ;Check if we are running from the select mode screen
  lis r18, 0x8058
  ori r18, r18, 0x3ACC
  lwz r16, 0(r18)
  cmpwi r16, 6
  bne Exit
  
  ;Set from Select Mode Flag to 1
  li r16, 1
  lis r18, 0x8057
  ori r18, r18, 0xD8FF
  sth r16, 0(r18)

  ;Check for Player Input Dpad Up
  ;No Dpad Up = No need to run code.
  lis r18, 0x8056
  ori r18, r18, 0xED4C
  lwz r18, 0(r18)
  andi. r18, r18, 0x40
  cmpwi r18, 0x40  
  bne DisableEggIL

  ;Load the value of "Level Boss Selected" into r18.(80584568)
  ;Do not modify settings if this is 1.
  lis r18, 0x8058
  ori r18, r18, 0x4568
  lbz r18, 0(r18)
  cmpwi r18, 1
  beq DisableEggIL

  ;Load the value of "Final Boss Selected" into r18.(80584570)
  lis r18, 0x8058
  ori r18, r18, 0x4570
  lbz r18, 0(r18)
  cmpwi r18, 1
  beq CheckForEggDealer 

  ;Not a boss, is a level, set expert and continue.
  ;Set Expert Enable To 1
  li r3, 0x1
  b DisableEggIL

CheckForEggDealer:
  ;Get the Final Boss Position (r18)
  lis r18, 0x8058
  ori r18, r18, 0x456C
  lwz r18, 0(r18)

  ;Only enable if boss is Egg Dealer
  cmplwi r18, 0x3
  beq EnableEggIL
  cmplwi r18, 0x4
  beq EnableEggIL
  cmplwi r18, 0x5
  beq EnableEggIL
  cmplwi r18, 0x6
  beq EnableEggIL
  b DisableEggIL

LoadEggDealerILFlag:
  ;Load "Egg Dealer IL Flag" Address into r18.
  lis r18, 0x8057
  ori r18, r18, 0xD929
  blr

EnableEggIL:
  ;Set "Egg Dealer IL Flag" to true.
  bl LoadEggDealerILFlag
  li r19, 0x1
  sth r19, 0(r18)
  b Exit
  
DisableEggIL:
  ;Set "Egg Dealer IL Flag" to False.
  bl LoadEggDealerILFlag
  li r19, 0x0
  sth r19, 0(r18)

Exit: 
  ;Original Code?
  stb r3, 89(r31)
  li r3, 0x0
  li r18, 0x0
  li r19, 0x0

