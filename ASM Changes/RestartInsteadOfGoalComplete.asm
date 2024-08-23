#8016b08c
#RestartInsteadOfGoalComplete.asm

#If Practice Mode, Restart instead 
#of Mission Complete to allow faster practice
#without worry of restarting right before.
#Added benefit of preventing new invalid times.

#Practice Mode Flag = 8057D8F4

Start:
  #Manage Stack Pointer
  stwu sp, -8(sp)
  mflr r19
  stw r19, 4(sp)

  #Original Code
  li r4, 6

  #If Practice Mode, Restart instead.
  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lbz r17, 0(r18)
  cmpwi r17, 1
  bne End

  #Change Action
  li r4, 7
  
  #Set "In Checkpoint" to false in case of CCG
  li r17, 0
  sth r17, -0x4E(r18)

End:

  #Manage Stack Pointer and Return
  lwz r19, 4(sp)
  addi sp, sp, 8
  addi r19, r19, 4 #Return to Instruction after initial inject branch.

  mtlr r19
  li r19, 0
  blr