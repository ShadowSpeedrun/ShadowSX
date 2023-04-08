#To be inserted at 80337030
;DontStopTimeInCheckpoint.asm

;Adding code "around" original code
;to add new functionality.

Start:
  ;Load value of "In Checkpoint" into r16
  lis r18, 0x8057
  ori r18, r18, 0xD8A7
  lhz r18, 0(r18)

  ;If "In Checkpoint" is 1, exit code.
  cmplwi r18, 0
  bne- Exit

  ;r0 is the value of "Stop Time and Shadow" (8057D768)
  ;This being 1 means the game is trying to pause.

  ;We need to clean up but also...
  ;If r0 is 0, we can leave normally.
  ;If r0 is 1, we need also need to 0x80337048.

  ;Run Original code for compare.
  cmplwi r0, 0
  bne- LeaveToOtherCode
  b Exit

LeaveToOtherCode:
  lis r18, 0x8033
  ori r18, r18, 0x7048
  mtlr r18
  li r18, 0x0
  blr 

Exit:
  li r18, 0x0
