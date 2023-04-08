#To be inserted at 80173074
;SkipStoryCutscenesUnlessDisabled-Pt2.asm

;This code takes place when a Real Time cutscene
;is taking running and checks for a "skip disabled" 
;value that was set prior to the cutscene.  

;Since this code also runs during the level results screen,
;we want to ensure we are in a cutscene before running our
;custom logic.

Start:
  ;Original Code
  lbz r0, 8(r3)

  ;If we would have been allowed to skip normally,
  ;leave without running extra code.
  cmplwi	r0, 0
  beq End

  ;Load value of "In Cutscene"(8057D8F9)
  ;into r16.
  lis r17, 0x8057
  ori r18, r17, 0xD8F9
  lhz r16, 0(r18)

  ;Leave if we are not in a story cutscene
  ;cmplwi	r16, 0
  ;beq End

  ;Load value of "Enable Cutscene Skip"(80577B2C)
  ;into r16.
  addi r18, r17, 0x7B2C
  lbz r16, 0(r18)

  ;If we want to enable the skip
  ;make r0 0 to allow skipping the current cutscene
  ;Else, leave without changing r0.
  cmplwi	r16, 1
  bne End
  li r0, 0
  
End:
  li r16, 0
  li r17, 0
  li r18, 0