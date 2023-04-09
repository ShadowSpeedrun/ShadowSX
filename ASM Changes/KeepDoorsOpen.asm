#To be inserted at 8011B5D4
;KeepDoorsOpen.asm

Start:
  ;Original Code
  mflr r0 

  ;Store off regs so the key count function can use them.
  mr r16, r3  
  mr r17, r4
  mr r18, r5
  mr r19, r0

  ;Branch to Key Count Function, r3 is 0-5.
  lis r20, 0x8011
  ori r20, r20, 0xBE9C
  mtlr r20
  blrl

  ;Swap around regs to recover r3 to original
  ;r18 is now the values of the key count.
  mr r20, r3
  mr r3, r16
  mr r4, r17
  mr r5, r18
  mr r0, r19
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
  li r19, 0x0

  ; Check for 5 keys
  cmpwi r20, 5
  bne- End
  
  ;If 5 Keys, set door opened.
  lwz r16, 0(r3)
  li r17, 0x40
  sth r17, 24(r16)
  li r16, 0x0
  li r17, 0x0
End:
  li r20, 0x0

