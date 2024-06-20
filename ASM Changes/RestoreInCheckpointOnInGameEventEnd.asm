#To be inserted at 80204bb4
;RestoreInCheckpointOnInGameEventEnd.asm
Start:
  ;Load value of "In Checkpoint" into r16
  lis r18, 0x8057
  ori r18, r18, 0xD8A6
  li r17, 0
  sth r17, 0(r18)

End:
  ;Original Code
  stb r0, 0x0148 (r3)