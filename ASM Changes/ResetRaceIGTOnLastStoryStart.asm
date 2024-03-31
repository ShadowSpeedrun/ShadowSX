#To be inserted at 802D2214
;ResetRaceIGTOnLastStoryStart.asm

;r16, f0 used

Start:
  ;Original Code
  li r3, 700
 
ResetLast:  
  ;Load address of Last Story Race Time
  ;into r16. (80577B24)
  lis r16, 0x8057
  ori r16, r16, 0x7B24
  ;make f0 0.0f, store to Last Story Race Time
  fsubs f0, f0, f0
  stfs f0, 0(r16)