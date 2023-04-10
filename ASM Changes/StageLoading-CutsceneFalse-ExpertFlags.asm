#To be inserted at 802038C8
;StageLoading-CutsceneFalse-ExpertFlags.asm

;Stage Load - Set "In Cutscene" False, Expert Mode Set Story post launch

;Assume cutscene is false.  Cutscene flag will set to true after load if needed.
;Set Story Flag to true if loading new expert level after starting.

Start:
  ;Original Code
  stw r4, 0(r3)

  ;Set "In Cutscene" False
  lis r18, 0x8057
  ori r18, r18, 0xD8F9
  li r16, 0x0
  sth r16, 0(r18)

  ;Check for Expert Select Mode flag
  lis r16, 0x8057
  ori r18, r16, 0xD8FF
  lhz r18, 0(r18)
  cmpwi r18, 0x1
  beq- End

  ;Load "In Expert Mode" value
  ori r18, r16, 0xD7C5
  lbz r17, 0(r18)

  ;If "In Expert Mode" is true.
  ;Set "Story Flag" true.
  cmpwi r17, 0x1
  bne- End

  ;Set "Story Flag" true.
  ori r18, r16, 0xD8F7
  sth r17, 0(r18)

  ;If Westopolis, reset Expert Race Timer.
  
  ;Load value of StageID
  ;into r18. (8057D748)
  ori r18, r16, 0xD748
  lwz r18, 0(r18)

  ;If Westopolis, Reset Time
  ;Else, Exit
  cmplwi r18, 100
  bne- End
  
  ;Load address of Expert Race Time
  ;into r18. (80577B0C)
  ;f0 is 0.0f, store to Expert Race Time
  ori r18, r16, 0x7B0C
  stfs f0, 0(r18)

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
