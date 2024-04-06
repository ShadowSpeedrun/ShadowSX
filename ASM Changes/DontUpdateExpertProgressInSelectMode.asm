#To be inserted at 80204E60
;DontUpdateExpertProgressInSelectMode.asm

Start:
  ;Load "StageSequenceManager Phase" into r16.
  lis r16, 0x805E
  ori r16, r16, 0xF9A8
  lwz r16, 0x0(r16)
  lwz r16, 0x4(r16)

  ;If Select Mode, do not save update Expert Progress.
  cmpwi r16, 0
  beq End
  
  ;Original Code
  stw r0, 0x006C (r30)

End: