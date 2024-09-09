#80049e0c
#FNTOverrideRedirect.asm

Start:
  #Pre-emptively set offset to 0 in case of exit.
  li r18, 0

  #TODO: Confirm this is checking for OK prompt
  cmpwi r11, 1
  bne End

  #Load Current Message ID
  lis r18, 0x807D
  addi r18, r18, 0x5700
  lwz r16, 0(r18)
  li r18, 0

  #Only apply offset if it's a valid Message ID
  cmpwi r16, 43
  beq ApplyOffset
  cmpwi r16, 44
  bne End

ApplyOffset:
  #Get Custom Offset.
  #If above 0, assume we want to show a custom message.
  lis r18, 0x8057
  ori r18, r18, 0xD8FA
  lhz r16, 0(r18)

  #r18 is offset to use in actual bytes.
  mulli r18, r16, 0x14

End:
  #Original Code
  #lwz r3, 0 (r10)
  
  lwzx r3, r10, r18 
  li r16, 0
  li r18, 0