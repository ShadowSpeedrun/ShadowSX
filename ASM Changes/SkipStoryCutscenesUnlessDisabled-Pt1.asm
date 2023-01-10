#To be inserted at 802D2C8C
;SkipStoryCutscenesUnlessDisabled-Pt1.asm
Start:
  ;Original Code
  lbz r0, 24(r31)
  
  ;If we would have been allowed to skip normally,
  ;leave without running extra code.
  cmplwi	r0, 0
  beq End

  ;Load value of "Disable Cutscene Skip"(8057D8FB)
  ;into r16.
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6184
  or r18, r16, r17
  lhz r16, 0(r18)

  ;If we want to disable the skip
  ;leave without changing r0.
  ;Else, make r0 0 to allow skipping the current cutscene
  cmplwi	r16, 1
  beq End
  li r0, 0
  
End:
  li r16, 0
  li r17, 0
  li r18, 0