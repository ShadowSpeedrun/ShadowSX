#To be inserted at 802038C8
;StageLoading-CutsceneFalse-ExpertFlags.asm
;Stage Load - Set "In Cutscene" False, Expert Mode Set Story post launch

;Assume cutscene is false.  Cutscene flag will set to true after load if needed.
;Set Story Flag to true if loading new expert level after starting.

Start:
  ;Original Code
  stw r4, 0(r3)

  ;Set "In Cutscene" False
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6182
  or r18, r16, r17
  li r14, 0x0
  sth r14, 0(r18)

  ;Load "In Expert Mode" value
  li r17, 0x7777
  addi r17, r17, 0x604E
  or r18, r16, r17
  lbz r14, 0(r18)

  ;If "In Expert Mode" is true.
  ;Set "Story Flag" true.
  cmpwi r14, 0x1
  bne- End

  ;Set "Story Flag" true.
  li r17, 0x7777
  addi r17, r17, 0x6180
  or r18, r16, r17
  sth r14, 0(r18)

  ;If Westopolis, reset Expert Race Timer.
  
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
  
  ;Load address of Expert Race Time
  ;into r18. (80577B0C)
  ;f0 is 0.0f, store to Expert Race Time
  li r17, 0x7777
  addi r17, r17, 0x395
  or r18, r16, r17
  stfs f0, 0(r18)

End:
  li r14, 0x0
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
