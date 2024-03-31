#To be inserted at 80204E74
;ExpertSelectModePreventLivesSave2.asm

Start:
  ;Load "StageSequenceManager Phase" into r16.
  lis r16, 0x805E
  ori r16, r16, 0xF9A8
  lbz r16, 0x4(r16)

  ;If Select Mode, dont save lives.
  cmpwi r16, 0
  beq End
  
  ;Original Code
  stw r0, 0x0070 (r30)

End: