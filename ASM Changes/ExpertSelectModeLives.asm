#8016F014
#ExpertSelectModeLives.asm

Start:
  #Load "StageSequenceManager Phase" into r16.
  lis r16, 0x805E
  ori r16, r16, 0xF9A8
  lwz r16, 0x0(r16)
  lwz r16, 0x4(r16)

  #If Phase is "Select Mode" set lives to 99.
  cmplwi r16, 0
  beq SelectModeLives

  #Original Code
  lwz r0, 0x00A0 (r3)
  b Exit

SelectModeLives:
  li r0, 99

Exit: