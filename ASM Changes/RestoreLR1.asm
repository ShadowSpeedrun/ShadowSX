#To be inserted at 80337048
;RestoreLR1.asm

;Restore link register that DontStopTimeInCheckpoint.asm modified.

Start:
  ;Original Code
  lis r4, 0x8058

  ;Restore Link Register to 801E1E94
  lis r18, 0x801E
  ori r18, r18, 0x1E94
  mtlr r18
  li r18, 0x0