#0
#TimePenaltyCheck-SF.asm

#805EE65C (float) = Boss Health Bar
#8057D900 (half) = Cutscene Flags (Normally for IGT at of run)
#8057D902 (float) = Temp Bucket for applying Time Calcs.

#Registers in use:
#r16 volatile
#r17 volatile
#r18 Reference for D900 and near by addresses

#f9 = volatile
#f10 = volatile
#f11 = Intro Time Param
#f12 = Mid Time Param

Start:
  #Manage Stack Pointer
  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  #Load "StageSequenceManager Phase" into r16.
  #Dont continue if not Story Mode
  lis r16, 0x805E
  ori r16, r16, 0xF9A8
  lwz r16, 0x0(r16)
  lwz r16, 0x4(r16)
  cmpwi r16, 1
  bne End

  #Load value of Boss Health into f10
  lis r16, 0x805E
  ori r16, r16, 0xE65C  
  lfs f10, 0(r16)

  #f6 = 0#  
  #if Health == 0, clean up values used for checks.
  fcmpu cr0, f10, f6
  beq FightEndCleanup

  #Try to keep D900 available for reference.
  lis r18, 0x8057
  ori r18, r18, 0xD900

  #Set f9 = 1
  lis r16, 0x3F80
  stw r16, 2(r18)
  lfs f9, 2(r18)

  #Health != 1 means mid fight cutscene
  fcmpu cr0, f10, f9
  bne MidPenalty

IntroPenalty:
  lbz r17, 0(r18)
  cmpwi r17, 1
  bne IntroSet
  b ApplyPenalty

IntroSet:
  li r17, 1
  stb r17, 0(r18)
  bne TimeCleanup

MidPenalty:
  lbz r17, 1(r18)
  cmpwi r17, 1
  bne MidSet

  #Set f11 to Mid Time
  fmr f11, f12 
  b ApplyPenalty

MidSet:
  li r17, 1
  stb r17, 1(r18)
  bne TimeCleanup

ApplyPenalty:
  lis r18, 0x8057
  ori r18, r18, 0xD734

  lfs f10, 0x1D4(r18)
  fadds f11, f11, f10
  stfs f11, 0x1D4(r18)

TimeCleanup:
  #Zero out Temp Memory Bucket
  lis r18, 0x8057
  ori r18, r18, 0xD902
  li r17, 0
  stw r17, 0(r18)
  b End

FightEndCleanup:
  #Zero out Temp Memory Bucket and Flags
  lis r18, 0x8057
  ori r18, r18, 0xD900
  li r17, 0
  sth r17, 0(r18)
  stw r17, 2(r18)

End:
  #Original Code
  li r4, 4

  #Manage Stack Pointer and Return
  lwz r14, 4(sp)
  addi sp, sp, 8

  mtlr r14
  li r14, 0
  blr
