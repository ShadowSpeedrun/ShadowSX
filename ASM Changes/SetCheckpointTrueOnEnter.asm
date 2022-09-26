#To be inserted at 80117FE8
;SetCheckpointTrueOnEnter.asm

Start:
  ;Original code
  ;Convenient!
  li r4, 0x1

  ;Load "In Checkpoint" Address into r18.
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6130
  or r18, r16, r17

  ;Set "In Checkpoint" to true.
  sth r4, 0(r18)

  ;Clean up register to prevent
  ;accidental code changes.
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
