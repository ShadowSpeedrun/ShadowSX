#To be inserted at 8035503C
;ResetRaceIGTOnExpertModeNew.asm

;r16, f0 used

Start:
  ;Original Code
  li r0, 0
 
ResetExpert:  
  ;Load address of Expert Race Time
  ;into r16. (80577B0C)
  lis r16, 0x8057
  ori r16, r16, 0x7B0C
  ;f0 is 0.0f, store to Expert Race Time
  fsubs f0, f0, f0
  stfs f0, 0(r16)