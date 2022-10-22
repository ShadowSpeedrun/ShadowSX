#To be inserted at 8011B5D4
Start:
  ;Original Code
  mflr r0 

  ;Store off regs so the key count function can use them.
  mr r14, r3  
  mr r15, r4
  mr r16, r5
  mr r17, r0

  ;Branch to Key Count Function, r3 is 0-5.
  lis r18, 0x8011
  ori r18, r18, 0xBE9C
  mtlr r18
  blrl

  ;Swap around regs to recover r3 to original
  ;r18 is now the values of the key count.
  mr r18, r3
  mr r3, r14
  mr r4, r15
  mr r5, r16
  mr r0, r17
  li r14, 0x0
  li r15, 0x0
  li r16, 0x0
  li r17, 0x0

  ; Check for 5 keys
  cmpwi r18, 5
  bne- End
  
  ;If 5 Keys, set door opened.
  lwz r14, 0(r3)
  li r15, 0x40
  sth r15, 24(r14)
  li r14, 0x0
  li r15, 0x0
End:
  li r18, 0x0

