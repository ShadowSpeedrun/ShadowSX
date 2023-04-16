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
  ori r18, r16, 0xD748
  lwz r18, 0(r18)

  ;If Westopolis, Reset Time
  ;Else, If Last Way, Reset Last Way Time
  ;Else, Do nothing.
  cmplwi r18, 100
  beq- ResetStory
  cmplwi r18, 700
  bne- End

ResetLast:  
  ;Load address of Story Race Time
  ;into r18. (80577B24)
  ;f2 is 0.0f, store to Last Story Race Time
  ori r18, r16, 0x7B24
  stfs f2, 0(r18)
  b End
  
ResetStory:
  ;Load address of Story Race Time
  ;into r18. (80577AF4)
  ;f3 is 0.0f, store to Story Race Time
  ori r18, r16, 0x7AF4
  stfs f3, 0(r18)

End:
  li r16, 0x0
  li r18, 0x0
