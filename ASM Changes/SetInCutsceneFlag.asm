#To be inserted at 802D1CCC
;SetInCutsceneFlag.asm

;Set Flag after cutscene scene is assigned.

;TODO: Add comment on why this code is simple.
;ie. Only possible when the game is loading cutscene.

Start:
  ;Original Code
  mr r4, r3
  
  ;Load address for "In Cutscene".
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6182
  or r18, r16, r17
 
  ;Set "In Cutscene" to true.
  li r14, 0x1
  sth r14, 0(r18)

  ;Cleanup to prevent
  ;accidental code changes.
  li r14, 0x0
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
