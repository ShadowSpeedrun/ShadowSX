#To be inserted at 80337030
;DontStopTimeInCheckpoint.asm

;Original Code
;cmplwi	r0, 0

;Adding code "around" original code
;to add new functionality.

Start:
  ;Load value of "In Checkpoint" into r16
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6130
  or r18, r16, r17
  lhz r16, 0(r18)

  ;If "In Checkpoint" is 1, exit code.
  cmplwi r16, 0
  bne- Exit

  ;r0 is the value of "Stop Time and Shadow" (8057D768)
  ;This being 1 means the game is trying to pause.

  ;We need to clean up but also...
  ;If r0 is 0, we can leave normally.
  ;If r0 is 1, we need also need to 80337048.

  ;Run Original code for compare.
  cmplwi r0, 0
  bne- loc_0x28
  b Exit

loc_0x28:
  lis r18, 0x8033
  ori r18, r18, 0x7048
  mtlr r18
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
  blr 

Exit:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
