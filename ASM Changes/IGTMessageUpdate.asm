#To be inserted at 8004a47c
;Determine that we are trying to render the Time message.
;Check for Time Flag (8057D901)
lis r16, 0x8057
li r17, 0x7777
addi r17, r17, 0x618A
or r18, r16, r17
lhz r16, 0(r18)
cmpwi r16, 1
bne End

;save LR to restore later
mflr r22

;r10 contains address to start of our message.
;Offset it to the start of the dynamic section.
lwz r21, 0(r10)
addi r21, r21, 0x24

;Load Memory Race Time(80577AF4)
;Optimize this
lis r16, 0x8057
li r17, 0x7777
addi r17, r17, 0x37D
or r18, r16, r17
lfs f1, 0(r18)

GetDigits:
  ;r4 -> r14
  ;r0 -> r15
  ;r6 -> r16
  ;r5 -> r17
  ;r3 -> r18
  ;sp -> r19
  
  ;Load what sp would be into r19
  lis r16, 0x8060
  li r17, 0x7777
  addi r17, r17, 0x3B49
  or r19, r16, r17
  
  li r17, 0x7777
  addi r17, r17, 0x3BC5
  or r18, r16, r17
  
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
bl LoadTimeByteAddress
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

;Load Byte for Seconds
bl LoadTimeByteAddress
lbz r16, 1(r18)
bl RenderTimeSection

;Render Period
li r16, 0x2E
sth r16, 0(r21)
addi r21, r21, 2

;Load Byte for SubSeconds
bl LoadTimeByteAddress
lbz r16, 2(r18)
bl RenderTimeSection

;Restore LR before exiting
mtlr r22
b End

LoadTimeByteAddress:
  lis r16, 0x8060
  li r17, 0x7777
  addi r17, r17, 0x3BC8
  or r18, r16, r17
  blr

RenderTimeSection:
  cmpwi r16, 10
  bge RenderTensPlace
  blt RenderOnesPlace
  blr

RenderTensPlace:
  ;r16 input
  ;r17 ones
  ;r18 tens
  ;r14 = 10
  li r14, 10

  mr r17, r16
  divw r16, r16, r14
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
  lis r5, 0x8057


