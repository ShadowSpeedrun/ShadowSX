#To be inserted at 80117644
;SetCheckpointFalseOnExit.asm

Start:
  ;Original Code 
  addi r3, r3, 0xA8

  ;Set "In Checkpoint" to false.
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6130
  or r18, r16, r17
  ;r4 is already 0x0
  sth r4, 0(r18)

  ;Cleanup to prevent
  ;accidental code changes
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
