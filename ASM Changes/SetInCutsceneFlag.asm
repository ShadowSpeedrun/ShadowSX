#To be inserted at 802D1CCC
;SetInCutsceneFlag.asm

;Set Flag after cutscene scene is assigned.

;TODO: Add comment on why this code is simple.
;ie. Only possible when the game is loading cutscene.

Start:
  ;Original Code
  mr r4, r3
  
  ;Load address for "In Cutscene".
  lis r18, 0x8057
  ori r18, r18, 0xD8F9
 
  ;Set "In Cutscene" to true.
  li r16, 0x1
  sth r16, 0(r18)

  ;Cleanup to prevent
  ;accidental code changes.
  li r16, 0x0
  li r18, 0x0
