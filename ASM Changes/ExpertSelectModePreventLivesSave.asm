#801E33BC
#ExpertSelectModePreventLivesSave.asm

Start:
  #Load "StageSequenceManager Phase" into r16.
  lis r16, 0x805E
  ori r16, r16, 0xF9A8
  lwz r16, 0x0(r16)
  lwz r16, 0x4(r16)

  #If Select Mode, dont save lives.
  cmpwi r16, 0
  beq End
  
  #Original Code
  stw r0, 0x00A0 (r31)

End: