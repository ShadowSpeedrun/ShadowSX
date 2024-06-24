#80173074
#SkipStoryCutscenesUnlessDisabled-Pt2.asm

#This code takes place when a Real Time cutscene
#is running and checks for a "skip disabled" 
#value that was set prior to the cutscene.  

Start:
  #Original Code
  lbz r0, 8(r3)

  #If we would have been allowed to skip normally,
  #leave without running extra code.
  cmplwi	r0, 0
  beq End 

  #Load value of "Enable Cutscene Skip"(80577B2C)
  #into r16.
  lis r18, 0x8057
  ori r18, r18, 0x7B2C
  lbz r16, 0(r18)

  #If we want to enable the skip
  #make r0 0 to allow skipping the current cutscene
  #Else, leave without changing r0.
  cmplwi	r16, 1
  bne End
  li r0, 0
  
End:
  li r16, 0
  li r18, 0