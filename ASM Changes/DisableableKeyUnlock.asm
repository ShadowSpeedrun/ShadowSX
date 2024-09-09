#8011bdf0
#DisableableKeyUnlock.asm
#Prevent saving keys after level end.

#80577B30 = Address to prevent Key Saving

Start:
  lis r18, 0x8057
  ori r18, r18, 0x7B30
  lbz r18, 0(r18)
  cmpwi r18, 1
  beq End

  #Original Code - Store the value of 1 of the keys.
  #This will happen 5 times.
  stwx r3, r6, r0

End:  
  li r18, 0