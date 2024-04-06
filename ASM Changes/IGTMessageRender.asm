#To be inserted at 8004A480
;IGTMessageRender.asm

Start:
  ;Determine that we are trying to render the Time message.
  ;Check for Time Flag (8057D901)
  lis r16, 0x8057
  ori r18, r16, 0xD900
  lhz r18, 0(r18)
  cmpwi r18, 1
  bne End

  ;Ensure we are trying to render the IGT Message.
  lis r18, 0x807D
  addi r18, r18, 0x5700
  lwz r18, 0(r18)
  cmpwi r18, 43
  bne End

  ;save LR to restore later
  mflr r22

  ;r10 contains address to start of our message.
  ;Offset it to the start of the dynamic section.
  lwz r21, 0(r10)
  addi r21, r21, 0x54

  ;Determine the Timer to Display
  ;First check for Expert Flag(8057D7C4)
  ori r18, r16, 0xD7C4
  lhz r15, 0(r18)
  cmpwi r15, 1
  beq SetExpertTime
 
  ;check for Last Story Flag(80584724)
  addi r18, r18, 0x6F60
  lwz r18, 0(r18)
  cmpwi r18, 2
  beq SetLastTime

  ;Both checks failed, default to Story Mode Time
  ;Story Race(80577AF4)

  ori r18, r16, 0x7AF4
  lfs f1, 0(r18)
  b GetDigits

SetExpertTime:
  ;Expert Race(80577B0C)
  ori r18, r16, 0x7B0C
  lfs f1, 0(r18)
  b GetDigits

SetLastTime:
  ;Last Story Race(80577B24)
  ori r18, r16, 0x7B24
  lfs f1, 0(r18)
  ;b GetDigits

GetDigits:
  ;r4 -> r14
  ;r0 -> r15
  ;r6 -> r16
  ;r5 -> r17
  ;r3 -> r18
  ;sp -> r19
  
  ;Load what sp would be into r19
  lis r16, 0x8060
  ori r19, r16, 0xB2C0
  
  ori r18, r16, 0xB33C
  
  fctiwz f0, f1
  stwu r19, -0x0020 (r19)
  lis r14, 0x4330
  li r15, 60
  stw r14, 0x0010 (r19)
  lfd f2, -0x3678 (rtoc)
  stfd f0, 0x0008 (r19)
  lfs f3, -0x367C (rtoc)
  lwz r16, 0x000C (r19)
  xoris r17, r16, 0x8000
  divw r14, r16, r15
  stw r17, 0x0014 (r19)
  lfd f0, 0x0010 (r19)
  fsubs f0, f0, f2
  fsubs f0, f1, f0
  fmuls f0, f3, f0
  fctiwz f0, f0
  mullw r15, r14, r15
  stfd f0, 0x0018 (r19)
  lwz r17, 0x001C (r19)
  sub r15, r16, r15
  stb r17, 0x0005 (r18)
  stw r14, 0 (r18)
  stb r15, 0x0004 (r18)
  addi r19, r19, 32

  ;LocationOfTimeBytes(8060B33F)

  ;Load Byte for Minutes
  lis r18, 0x8060
  ori r18, r18, 0xB33F
  lbz r20, 0(r18)

  li r17, 60
  divw r16, r20, r17
  ;r16 is now Hours;

  ;Render Hours if any
  cmpwi r16, 0
  bne RenderHours

RemoveHours:
  ;0x20 = space
  li r16, 0x20
  sth r16, 0(r21)
  addi r21, r21, 2

  b RenderMinutes

RenderHours:
  addi r16, r16, 0x30
  sth r16, 0(r21)
  addi r21, r21, 2
  
  ;Render Colon
  li r16, 0x3A
  sth r16, 0(r21)
  addi r21, r21, 2

  li r17, 60
  divw r16, r20, r17

  mulli r17, r16, 60
  sub r20, r20, r17
  ;r20 is now Minutes

RenderMinutes:
  mr r16, r20
  bl RenderTimeSection

  ;Render Colon
  li r16, 0x3A
  sth r16, 0(r21)
  addi r21, r21, 2
  ;Fall Through to continue on.

Continue:
  ;Load Byte for Seconds
  lis r18, 0x8060
  ori r18, r18, 0xB33F

  lbz r16, 1(r18)
  bl RenderTimeSection

  ;Render Period
  li r16, 0x2E
  sth r16, 0(r21)
  addi r21, r21, 2

  ;Load Byte for SubSeconds
  lis r18, 0x8060
  ori r18, r18, 0xB33F

  lbz r16, 2(r18)
  bl RenderTimeSection

  ;Restore LR before exiting
  mtlr r22
  b End

RenderTimeSection:
  cmpwi r16, 10
  bge RenderTensPlace
  blt RenderOnesPlace
  blr

RenderTensPlace:
  ;r16 input
  ;r17 ones
  ;r18 tens
  ;r19 = 10
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
  ;Original Code
  li r0,0


