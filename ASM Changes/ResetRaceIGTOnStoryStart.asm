#To be inserted at 802D1BF4
;ResetRaceIGTOnStoryStart.asm

;Reset Story Race IGT if we are loading
;Westopolis.

;r16, r17, 18 used for loading / storing 
;Values from Memory.

Start:
  ;Original Code
  mr r4, r3

  ;Load value of StageID
  ;into r18. (8057D748)
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x5FD1
  or r18, r16, r17
  lwz r18, 0(r18)

  ;If Westopolis, Reset Time
  ;Else, Exit
  cmplwi r18, 100
  bne- End
  
  ;Load address of Story Race Time
  ;into r18. (80577AF4)
  ;f3 is 0.0f, store to Story Race Time
  li r17, 0x7777
  addi r17, r17, 0x37D
  or r18, r16, r17
  stfs f3, 0(r18)

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
