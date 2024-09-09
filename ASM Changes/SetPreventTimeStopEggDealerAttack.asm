#80312190
#SetPreventTimeStopEggDealerAttack.asm
Start:
  #Set Flag to prevent HUD Hide and Time Stop.
  #The Flag will be cleared once noticed by the Check.asm
  #Borrowing In Checkpoint Flag for preventing Timer Stop.

  cmpwi r4, 1 #0 = Intro, 1 = Mid
  ble PenaltyCheck
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

PenaltyCheck:
  #Setup Memory Bucket
  lis r18, 0x8057
  ori r18, r18, 0xD904

  #Intro is 14.5 seconds 0x41680000
  lis r17, 0x4168
  stw r17, 0(r18)
  lfs f11, 0(r18)

  #Mid is 2 seconds 0x40000000
  lis r17, 0x4000
  stw r17, 0(r18)
  lfs f12, 0(r18)

  #bl TimePenaltyCheck
  #To be injected in MCM
  nop
  b End

FightEndCleanup:
  #Zero out Temp Memory Bucket and Flags
  lis r18, 0x8057
  ori r18, r18, 0xD900
  li r17, 0
  sth r17, 0(r18)
  stw r17, 4(r18)

End:
  #Original Code
  li r4, 4



