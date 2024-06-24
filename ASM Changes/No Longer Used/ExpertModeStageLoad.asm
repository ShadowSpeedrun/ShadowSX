#To be inserted at 80355080
#ExpertModeStageLoad.asm

#Set Story Mode flag to true.
#Reset Expert Race IGT if we are loading
#Westopolis.

#r16, r17, 18 used for loading / storing 
#Values from Memory.

Start:
  #Original Code
  stb r0, 293(r3)

  #Store 0x01 into 8057D8F7 
  #(Custom Story Mode Flag)
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6180
  or r18, r16, r17
  li r16, 0x1
  sth r16, 0(r18)

  #Load value of StageID
  #into r18. (8057D748)
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x5FD1
  or r18, r16, r17
  lwz r18, 0(r18)

  #If Westopolis, Reset Time
  #Else, Exit
  cmplwi r18, 100
  bne- End
  
  #Load address of Expert Race Time
  #into r18. (80577B0C)
  #f0 is 0.0f, store to Expert Race Time
  li r17, 0x7777
  addi r17, r17, 0x395
  or r18, r16, r17
  stfs f0, 0(r18)

End:
  #Clean up to prevent 
  #accidental code changes
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
