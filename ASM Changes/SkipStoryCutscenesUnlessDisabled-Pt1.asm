#To be inserted at 802D2C8C
;SkipStoryCutscenesUnlessDisabled-Pt1.asm

Start:
  ;Original Code
  lbz r0, 24(r31)
  
  ;If we would have been allowed to skip normally,
  ;leave without running extra code.
  cmplwi	r0, 0
  beq End

  ;Load value of "Enable Cutscene Skip"(80577B2C)
  ;into r18.
  lis r18, 0x8057
  addi r18, r18, 0x7B2C
  lbz r18, 0(r18)

  ;If we want to enable the skip
  ;make r0 0 to allow skipping the current cutscene
  ;Else, leave without changing r0.
  cmplwi	r18, 1
  bne End
  li r0, 0
  
End:
  li r18, 0