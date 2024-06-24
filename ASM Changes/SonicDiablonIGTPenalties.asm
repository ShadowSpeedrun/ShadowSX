#802d4a80
#SonicDiablonIGTPenalties.asm

#805EE65C = Boss Health Bar as Float 
#(Seems to be consistant between Games and Bosses)
#8057D900 = Cutscene Flags (Normally for IGT at of run)

#Times for Intro, Mid Cutscnes
#Sonic & Diablon = 4  , 3

Start:
  #if Story;
  #Load "StageSequenceManager Phase" into r16.
  #Dont continue if not Story Mode
  lis r16, 0x805E
  ori r16, r16, 0xF9A8
  lwz r16, 0x0(r16)
  lwz r16, 0x4(r16)
  #cmpwi r16, 1
  #bne End

  #Load value of Boss Health into f4
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
  li r16, 0x3F80
  sth r16, 2(18)
  lfs f9, 2(r18)

  #Health != 1 means mid fight cutscene
  fcmpu cr0, f10, f9
  bne MidPenalty

IntroPenalty:
  lbz r17, 0(r18)
  cmpwi r17, 1
  bne IntroSet

  #Add 4 seconds 0x40800000
  lis r17, 0x4080
  stw r17, 2(r18)
  b ApplyPenalty

IntroSet:
  li r17, 1
  stb r17, 0(r18)
  bne TimeCleanup

MidPenalty:
  lbz r17, 1(r18)
  cmpwi r17, 1
  bne MidSet

  #Add 3 seconds 0x40400000
  lis r17, 0x4040
  stw r17, 2(r18)
  b ApplyPenalty

MidSet:
  li r17, 1
  stb r17, 1(r18)
  bne TimeCleanup

ApplyPenalty:
  lfs f9, 2(r18)

  lis r18, 0x8057
  ori r18, r18, 0xD734

  lfs f10, 0x1D4(r18)
  fadds f9, f9, f10
  stfs f9, 0x1D4(r18)

TimeCleanup:
  #Restore Memory and Registries
  lis r18, 0x8057
  ori r18, r18, 0xD902
  li r17, 0
  stw r17, 0(r18)
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