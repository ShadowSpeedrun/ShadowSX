#801E5838
#DisableableSPWUnlock.asm
Start:
  #Load "Disable SPW Unlocks" Address into r18. (80577B2F)
  lis r18, 0x8057
  addi r18, r18, 0x7B2F

  #Check if feature is enabled.
  #If so, we skip the code that sets the SPW unlock status.
  lbz r19, 0(r18)
  cmplwi r19, 1
  beq- End

  #Original Code
  sth r0, 0 (r3) 

End:
  li r18, 0
  li r19, 0