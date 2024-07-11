#80206334
#DpadUpSelectModeLevelEnter.asm

#8057D8F4 = Practice Mode (Normally Option Index for Intro Message????)

Start:
  #Check if we are running from the select mode screen
  lis r18, 0x8058
  ori r18, r18, 0x3ACC
  lwz r16, 0(r18)
  cmpwi r16, 6
  bne Exit
  
  #Check for Player Input Dpad Up
  #No Dpad Up = No need to run code.
  lis r18, 0x8056
  ori r18, r18, 0xED4C
  lwz r19, 0(r18)
  #Check for Z Button First.
  #Z = Practice Mode.
  andi. r19, r19, 0x20
  cmpwi r19, 0x20
  bne CheckDPadUp
  
  #Set Practice Mode to 1
  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  li r19, 1
  stb r19, 0(r18)
  #Set TimeMode to 1 to prevent 0 timer.
  stb r19, 3(r18)
  #Continue on for other checks.

CheckDPadUp:
  lis r18, 0x8056
  ori r18, r18, 0xED4C
  lwz r19, 0(r18)
  andi. r19, r19, 0x40
  cmpwi r19, 0x40  
  bne DisableEggIL

  #Load the value of "Level Boss Selected" into r18.(80584568)
  #Do not modify settings if this is 1.
  lis r18, 0x8058
  ori r18, r18, 0x4568
  lbz r18, 0(r18)
  cmpwi r18, 1
  beq DisableEggIL

  #Load the value of "Final Boss Selected" into r18.(80584570)
  lis r18, 0x8058
  ori r18, r18, 0x4570
  lbz r18, 0(r18)
  cmpwi r18, 1
  beq CheckForEggDealer 

  #Not a boss, is a level, set expert and continue.
  #Set Expert Enable To 1
  li r3, 0x1
  b DisableEggIL

CheckForEggDealer:
  #Get the Final Boss Position (r18)
  lis r18, 0x8058
  ori r18, r18, 0x456C
  lwz r18, 0(r18)

  #Only enable if boss is Egg Dealer
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
  #Load "Egg Dealer IL Flag" Address into r18.
  lis r18, 0x8057
  ori r18, r18, 0xD928
  blr

EnableEggIL:
  #Set "Egg Dealer IL Flag" to true.
  bl LoadEggDealerILFlag
  li r19, 0x1
  sth r19, 0(r18)
  b Exit
  
DisableEggIL:
  #Set "Egg Dealer IL Flag" to False.
  bl LoadEggDealerILFlag
  li r19, 0x0
  sth r19, 0(r18)

Exit: 
  #Original Code
  stb r3, 89(r31)

  li r3, 0x0
  li r18, 0x0
  li r19, 0x0

