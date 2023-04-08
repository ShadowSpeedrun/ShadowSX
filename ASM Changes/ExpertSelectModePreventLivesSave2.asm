#To be inserted at 80204e74
;ExpertSelectModePreventLivesSave2.asm

Start:
  ;Load Flag for Expert Select Mode
  lis r18, 0x8057
  ori r18, r18, 0xD8FF
  lhz r18, 0(r18)
  
  ;If the Flag is on, dont save lives.
  cmpwi r18, 1
  beq End

  ;Original Code
  stw r0, 0x0070 (r30)

End:
  li r18, 0x0