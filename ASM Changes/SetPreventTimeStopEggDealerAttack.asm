#80312190
#SetPreventTimeStopEggDealerAttack.asm
Start:
  #Set Flag to prevent HUD Hide and Time Stop.
  #The Flag will be cleared once noticed by the Check.asm
  #Borrowing In Checkpoint Flag for preventing Timer Stop.

  cmpwi r4, 0 #0 = Intro
  beq IntroCheck
  cmpwi r4, 1 #1 = Mid
  beq MidCheck
  cmpwi r4, 2 #2 = Fight End
  beq FightEndCleanup
  cmpwi r4, 6 #Missiles (Intro Attack)
  beq End 

  #Check the Stage Action for if we are actively dying
  #80575F80
  lis r18, 0x8057
  ori r18, r18, 0x5F80
  lwz r18, 0(r18)
  cmpwi r18, 9
  beq End

  #Load value of "In Checkpoint" into r16
  lis r18, 0x8057
  ori r18, r18, 0xD8A6
  li r17, 1
  sth r17, 0(r18)
  b End

#8057D900 (normally show time on run end) will be used to keep track of Intro and Mid Shown.
#8057D900 = Intro
#8057D901 = Mid

#8057D902 = Storage for plenalty time?

#8057D734 = Timer as float

IntroCheck:
  lis r18, 0x8057
  ori r18, r18, 0xD900
  lbz r18, 0(r18)
  cmpwi r18, 0
  beq IntroSet

  #If Intro Seen Again, Add 14.5 seconds 0x41680000
  lis r18, 0x8057
  ori r18, r18, 0xD902

  lis r17, 0x4168
  stw r17, 0(r18)
  lfs f0, 0(r18)

  lis r18, 0x8057
  ori r18, r18, 0xD734
  lfs f1, 0x1D4(r18)
  fadds f0, f0, f1
  stfs f0, 0x1D4(r18)  

IntroSet:
  #Load "StageSequenceManager Phase" into r16.
  #Dont Set a value if not Story Mode
  lis r16, 0x805E
  ori r16, r16, 0xF9A8
  lwz r16, 0x0(r16)
  lwz r16, 0x4(r16)
  cmpwi r16, 1
  bne End

  lis r18, 0x8057
  ori r18, r18, 0xD900
  li r17, 1
  stb r17, 0(r18)
  b Cleanup

MidCheck:
  lis r18, 0x8057
  ori r18, r18, 0xD901
  lbz r18, 0(r18)
  cmpwi r18, 0
  beq MidSet

  #If Mid Seen Again, Add 2 seconds 0x40000000
  lis r18, 0x8057
  ori r18, r18, 0xD902

  lis r17, 0x4000
  stw r17, 0(r18)
  lfs f0, 0(r18)

  lis r18, 0x8057
  ori r18, r18, 0xD734
  lfs f1, 0x1D4(r18)
  fadds f0, f0, f1
  stfs f0, 0x1D4(r18)

MidSet:
  #Load "StageSequenceManager Phase" into r16.
  #Dont Set a value if not Story Mode
  lis r16, 0x805E
  ori r16, r16, 0xF9A8
  lwz r16, 0x0(r16)
  lwz r16, 0x4(r16)
  cmpwi r16, 1
  bne End

  lis r18, 0x8057
  ori r18, r18, 0xD901
  li r17, 1
  stb r17, 0(r18)

Cleanup:
  #Restore Memory and Registries
  lis r18, 0x8057
  ori r18, r18, 0xD902
  li r17, 0
  stw r17, 0(r18)
  lfs f0, 0(r18)
  lfs f1, 0(r18)
  b End

FightEndCleanup:
  lis r18, 0x8057
  ori r18, r18, 0xD900
  li r17, 0
  sth r17, 0(r18)
  stw r17, 2(r18)

End:
  #Original Code
  li r4, 4



