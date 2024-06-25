#8016b08c
#RestartInsteadOfGoalComplete.asm

#If Practice Mode, Restart instead 
#of Mission Complete to allow faster practice
#without worry of restarting right before.
#Added benefit of preventing new invalid times.

#Practice Mode Flag = 8057D8F4

Start:
  #Original Code
  li r4, 6

  #If Practice Mode, Restart instead.
  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lbz r18, 0(r18)
  cmpwi r18, 1
  bne End

  #Change Action
  li r4, 7
End: