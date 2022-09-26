#To be inserted at 80337030
;DontStopTimeInCheckpoint.asm

;Replacing Original Code 
;to add new functionality.
Start:
  ;Load value of "In Checkpoit" into r16
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

  ;If r0 is 1, Exit, but also run other code...
  ;TODO: Figure out why we need to do this again.
  ;It's be actual months since I originally wrote this.
  cmplwi r0, 0
  bne- loc_0x28
  b Exit

loc_0x28:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
  b 0x334C6C

Exit:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
