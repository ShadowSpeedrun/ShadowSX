#To be inserted at 80117644
;SetCheckpointFalseOnExit.asm

Start:
  ;Original Code 
  addi r3, r3, 0xA8

  ;Set "In Checkpoint" to false.
  lis r18, 0x8057
  ori r18, r18, 0xD8A7
  li r16, 0x0
  sth r16, 0(r18)

  ;Cleanup to prevent
  ;accidental code changes
  li r18, 0x0
