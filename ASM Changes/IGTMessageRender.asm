#8004A480
#IGTMessageRender.asm

Start:
  #Determine that we are trying to render the Time message.
  #Check for Time Flag (8057D900)
  lis r16, 0x8057
  ori r18, r16, 0xD900
  lhz r18, 0(r18)
  cmpwi r18, 1
  bne End

  #Ensure we are trying to render the IGT Message.
  lis r18, 0x807D
  addi r18, r18, 0x5700
  lwz r18, 0(r18)
  cmpwi r18, 43
  bne End

  #save LR to restore later
  mflr r22

  #r10 contains address to start of our message.
  #Offset it to the start of the dynamic section.
  lwz r21, 0x14(r10)
  addi r21, r21, 0x22#0x22 JPN, 0x54 everyone else.
  ori r18, r16, 0x6972
  lwz r18, 0(r18)
  cmpwi r18, 0
  beq GetTimer
  addi r21, r21, 0x32 #add remaining offset if not JPN.

GetTimer:
  #Determine the Timer to Display
  #First check for Expert Flag(8057D7C4)
  ori r18, r16, 0xD7C4
  lhz r15, 0(r18)
  cmpwi r15, 1
  beq SetExpertTime
 
  #check for Last Story Flag(80584724)
  addi r18, r18, 0x6F60
  lwz r18, 0(r18)
  cmpwi r18, 2
  beq SetLastTime

  #Both checks failed, default to Story Mode Time
  #Story Race(80577AF4)

  ori r18, r16, 0x7AF4
  lfs f1, 0(r18)
  b GetDigits

SetExpertTime:
  #Expert Race(80577B0C)
  ori r18, r16, 0x7B0C
  lfs f1, 0(r18)
  b GetDigits

SetLastTime:
  #Last Story Race(80577B24)
  ori r18, r16, 0x7B24
  lfs f1, 0(r18)
  #b GetDigits

GetDigits:
  #Do a bl to 0x801e45a4
  lis r18, 0x801e
  ori r18, r18, 0x45a4
  #Set r3 to location for time bytes
  lis r3, 0x8060
  ori r3, r3, 0xB33C
  #Keep copy of r4 to restore later.
  mr r23, r4
  mtctr r18
  bctrl
  #Restore r3
  mr r3, r30
  #Restore r4
  mr r4, r23
  li r23, 0
  #Restore r5
  lis r5, 0x8057

  #LocationOfTimeBytes(8060B33F)

  #Load Byte for Minutes
  lis r18, 0x8060
  ori r18, r18, 0xB33F
  lbz r20, 0(r18)

  li r17, 60
  divw r16, r20, r17
  #r16 is now Hours#

  #Render Hours if any
  cmpwi r16, 0
  bne RenderHours

RemoveHours:
  #0x20 = space
  li r16, 0x20
  sth r16, 0(r21)
  addi r21, r21, 2

  b RenderMinutes

RenderHours:
  addi r16, r16, 0x30
  sth r16, 0(r21)
  addi r21, r21, 2
  
  #Render Colon
  li r16, 0x3A
  sth r16, 0(r21)
  addi r21, r21, 2

  li r17, 60
  divw r16, r20, r17

  mulli r17, r16, 60
  sub r20, r20, r17
  #r20 is now Minutes

RenderMinutes:
  mr r16, r20
  bl RenderTimeSection

  #Render Colon
  li r16, 0x3A
  sth r16, 0(r21)
  addi r21, r21, 2
  #Fall Through to continue on.

Continue:
  #Load Byte for Seconds
  lis r18, 0x8060
  ori r18, r18, 0xB33F

  lbz r16, 1(r18)
  bl RenderTimeSection

  #Render Period
  li r16, 0x2E
  sth r16, 0(r21)
  addi r21, r21, 2

  #Load Byte for SubSeconds
  lis r18, 0x8060
  ori r18, r18, 0xB33F

  lbz r16, 2(r18)
  bl RenderTimeSection

  #Restore LR before exiting
  mtlr r22
  b End

RenderTimeSection:
  cmpwi r16, 10
  bge RenderTensPlace
  blt RenderOnesPlace
  blr

RenderTensPlace:
  #r16 input
  #r17 ones
  #r18 tens
  #r19 = 10
  li r19, 10

  mr r17, r16
  divw r16, r16, r19
  mr r18, r16
  mulli r16, r18, 10
  sub r17, r17, r16

  mr r16, r18
  addi r16, r16, 0x30
  sth r16, 0(r21)
  addi r21, r21, 2

  mr r16, r17
  addi r16, r16, 0x30
  sth r16, 0(r21)
  addi r21, r21, 2

  blr

RenderOnesPlace:
  li r17, 0x30
  sth r17, 0(r21)
  addi r21, r21, 2

  addi r16, r16, 0x30
  sth r16, 0(r21)
  addi r21, r21, 2

  blr

End:
  li r14, 0x0
  li r15, 0x0
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
  li r19, 0x0
  li r20, 0x0
  li r21, 0x0
  li r22, 0x0
  #Original Code
  li r0,0


