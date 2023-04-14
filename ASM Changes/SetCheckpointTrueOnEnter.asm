#To be inserted at 80117FE8
;SetCheckpointTrueOnEnter.asm

Start:
  ;Original code
  ;Convenient!
  li r4, 0x1

  ;Load "In Checkpoint" Address into r18.
  lis r18, 0x8057
  ori r18, r18, 0xD8A6

  ;Set "In Checkpoint" to true.
  sth r4, 0(r18)

  ;Clean up register to prevent
  ;accidental code changes.
  li r18, 0x0
