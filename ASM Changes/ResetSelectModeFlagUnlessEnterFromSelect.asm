#To be inserted at 802b7528
lwz r16, 0(r3)
cmpwi r16, 6
beq End

ResetSelectFlag:
  li r16, 0x0
  lis r18, 0x8057
  ori r18, r18, 0xD8FF
  sth r16, 0(r18)
  li r18, 0x0

End:
  ;Original Code
  stw r4, 0 (r3)
  li r16, 0x0