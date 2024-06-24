#80290ef8
#BossPenalties.asm
#805EE65C = Boss Health Bar as Float 
#(Seems to be consistant between Games and Bosses)
#8057D900 = Cutscene Flags (Normally for IGT at of run)
#8057D748 = Stage ID
#210 = BB1
#310 = EB-D
#410 = HD
#411 = EB-H
#412 = BB2
#510 = BF
#511 = EB-N
#611 = SD-PD
#610 = BD-PD
#613 = SD-D
#612 = ED-D
#614 = ED-N
#615 = ED-H
#616 = BD-H
#618 = SD-PH
#617 = BD-PH
#710 = DD

#Times for bosses in order of Intro, Mid
#
#                  Heavy Dog = 4   , 2.5 (410)
#           Egg Breaker Dark = 4   , 1.5 (310)
#           Egg Breaker Hero = 4   , 1.5 (411)
#         Egg Breaker Normal = 4   , 4   (511)
#               Black Bull 1 = 5   , 3   (210)
#               Black Bull 2 = 5   , 3   (412)
#                Blue Falcon = 4   , 2   (510)
#          Sonic and Diablon = 4   , 3   (611, 613, 618)
#                 Black Doom = 5   , 2   (610, 616, 617)
#                 Egg Dealer = 14.5, 2   (612, 614, 615)
#                 Devil Doom = 4   , 5   (710)
#
#1.5, 2, 2.5, 3, 4, 5, 14.5

#This SEEMS to be consistant every time we reach here
#Would be nice to verify why that is the case.
#f6 = 0,0
#f9 = Should be safe (volatile)
#f10 = Should be safe (volatile)

Start:
  #if Story# 
  #Load "StageSequenceManager Phase" into r16.
  #Dont continue if not Story Mode
  lis r16, 0x805E
  ori r16, r16, 0xF9A8
  lwz r16, 0x0(r16)
  lwz r16, 0x4(r16)
  cmpwi r16, 1
  bne End

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

  #load #8057D748
  lwz r17, -0x1B8(r18)

  #if Egg Dealer -> Penalty14_5
  cmpwi r17, 612
  beq Penalty14_5
  cmpwi r17, 614
  beq Penalty14_5
  cmpwi r17, 615
  beq Penalty14_5

  #if Penalty5
  cmpwi r17, 610
  beq Penalty5
  cmpwi r17, 616
  beq Penalty5
  cmpwi r17, 617
  beq Penalty5
  cmpwi r17, 210
  beq Penalty5
  cmpwi r17, 412
  beq Penalty5

  #else Penalty4
  b Penalty4

IntroSet:
  li r17, 1
  stb r17, 0(r18)
  bne TimeCleanup

MidPenalty:
  lbz r17, 1(r18)
  cmpwi r17, 1
  bne MidSet

  #load #8057D748
  lwz r17, -0x1B8(r18)

  #if DD -> Penalty5
  cmpwi r17, 710
  beq Penalty5

  #if EB-N -> Penalty4
  cmpwi r17, 511
  beq Penalty4

  #if HD -> 2.5
  cmpwi r17, 410
  beq Penalty2_5

  #if EB-DH -> 1.5
  cmpwi r17, 310
  beq Penalty1_5
  cmpwi r17, 411
  beq Penalty1_5

  #if BB or SD -> 3
  cmpwi r17, 210
  beq Penalty3
  cmpwi r17, 412
  beq Penalty3
  cmpwi r17, 611
  beq Penalty3
  cmpwi r17, 613
  beq Penalty3
  cmpwi r17, 618
  beq Penalty3

  #else -> 2
  b Penalty2

MidSet:
  li r17, 1
  stb r17, 1(r18)
  bne TimeCleanup

Penalty1_5:
  #Add 1.5 seconds 0x3FC00000
  lis r17, 0x3FC0
  stw r17, 2(r18)
  b ApplyPenalty

Penalty2:
  #Add 2 seconds 0x40000000
  lis r17, 0x4000
  stw r17, 2(r18)
  b ApplyPenalty

Penalty2_5:
  #Add 2.5 seconds 0x40200000
  lis r17, 0x4020
  stw r17, 2(r18)
  b ApplyPenalty

Penalty3:
  #Add 3 seconds 0x40400000
  lis r17, 0x4040
  stw r17, 2(r18)
  b ApplyPenalty

Penalty4:
  #Add 4 seconds 0x40800000
  lis r17, 0x4080
  stw r17, 2(r18)
  b ApplyPenalty

Penalty5:
  #Add 5 seconds 0x40A00000
  lis r17, 0x40A0
  stw r17, 2(r18)
  b ApplyPenalty

Penalty14_5:
  #Add 14.5 seconds 0x41680000
  lis r17, 0x4168
  stw r17, 2(r18)

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
  #lfs f4, 0(r18)
  #lfs f6, 0(r18)
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









