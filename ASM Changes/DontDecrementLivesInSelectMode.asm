#To be inserted at 8016EFA0
;DontDecrementLivesInSelectMode.asm

Start:
  ;Load "StageSequenceManager Phase" into r16.
  lis r16, 0x805E
  ori r16, r16, 0xF9A8
  lwz r16, 0x0(r16)
  lwz r16, 0x4(r16)

  ;If Phase is "Select Mode", skip Original Code
  cmplwi r16, 0
  beq- End

  ;Original Code
  add r0, r0, r4

End: