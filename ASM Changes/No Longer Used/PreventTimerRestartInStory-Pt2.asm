#To be inserted at 80206238
#PreventTimerRestartInStory-Pt2.asm

#Replacing Original Code 
#to add new functionality.

Start:
  #Load value of "Story Mode Flag"
  #into r18.
  lis r18, 0x8057
  ori r18, r18, 0xD8F6
  lhz r18, 0(r18)

  #If "Story Mode Flag" is false,
  #Run Timer Reset Code
  cmplwi r18, 0
  bne- End
  lis r18, 0x8033
  ori r18, r18, 0x6FE4
  mtlr r18
  blrl

End:
  li r18, 0x0
