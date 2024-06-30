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
#                     Heavy Dog = 4   , 2.5 (410)
#       Egg Breaker Dark & Hero = 4   , 1.5 (310, 411)
#            Egg Breaker Normal = 4   , 4   (511)
#                    Black Bull = 5   , 3   (210, 412)
#                   Blue Falcon = 4   , 2   (510)
#(Not Required) Sonic & Diablon = 4   , 3   (611, 613, 618)
#                    Black Doom = 5   , 2   (610, 616, 617)
#     (Not Required) Egg Dealer = 14.5, 2   (612, 614, 615)
#                    Devil Doom = 4   , 5   (710)
#
#1.5, 2, 2.5, 3, 4, 5, 14.5

Start:
  mflr r16
  #Try to keep D900 available for reference.
  lis r18, 0x8057
  ori r18, r18, 0xD900

MidPenalty:
  #load Stage ID into r19
  lwz r19, -0x1B8(r18)

  #Assume 2 Seconds and overwrite 
  #if another check passes.
  bl Penalty2

  #if DD -> Penalty5
  cmpwi r19, 710
  beql Penalty5

  #if EB-N -> Penalty4
  cmpwi r19, 511
  beql Penalty4

  #if HD -> 2.5
  cmpwi r19, 410
  beql Penalty2_5

  #if EB-DH -> 1.5
  cmpwi r19, 310
  beql Penalty1_5
  cmpwi r19, 411
  beql Penalty1_5

  #if BB or SD -> 3
  cmpwi r19, 210
  beql Penalty3
  cmpwi r19, 412
  beql Penalty3

  #Move Mid to correct register
  #Penalty routines load to f11 for condensed code.
  fmr f12, f11 

IntroPenalty:
  #load Stage ID into r19
  lwz r19, -0x1B8(r18)

  #Assume 4 Seconds and overwrite 
  #if another check passes.
  bl Penalty4

  #if Penalty5
  cmpwi r19, 610
  beql Penalty5
  cmpwi r19, 616
  beql Penalty5
  cmpwi r19, 617
  beql Penalty5
  cmpwi r19, 210
  beql Penalty5
  cmpwi r19, 412
  beql Penalty5

  mtlr r16
  #bl TimePenaltyCheck
  #To be injected in MCM
  nop
  b End

Penalty1_5:
  #Add 1.5 seconds 0x3FC00000
  lis r17, 0x3FC0
  stw r17, 4(r18)
  lfs f11, 4(r18)
  blr

Penalty2:
  #Add 2 seconds 0x40000000
  lis r17, 0x4000
  stw r17, 4(r18)
  lfs f11, 4(r18)
  blr

Penalty2_5:
  #Add 2.5 seconds 0x40200000
  lis r17, 0x4020
  stw r17, 4(r18)
  lfs f11, 4(r18)
  blr

Penalty3:
  #Add 3 seconds 0x40400000
  lis r17, 0x4040
  stw r17, 4(r18)
  lfs f11, 4(r18)
  blr

Penalty4:
  #Add 4 seconds 0x40800000
  lis r17, 0x4080
  stw r17, 4(r18)
  lfs f11, 4(r18)
  blr

Penalty5:
  #Add 5 seconds 0x40A00000
  lis r17, 0x40A0
  stw r17, 4(r18)
  lfs f11, 4(r18)
  blr

End:
  #Original Code
  li r4, 4
