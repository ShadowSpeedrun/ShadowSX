#To be inserted at 80201854
;NewIgtForUiDisplay.asm

;Use New IGT by default. 
;Use Race IGT for Story if Race Mode is enabled.

Start:
  ;There was original code here, but a diffent code removed it...
  ;TODO: go clean that up probably.

  ;Load New IGT into f1.
  lfs f1, 29220(r29)
   
  ;Use Race IGT if in Race Mode and in Story.

  ;Load "Race Mode" into r16.
  lis r17, 0x8057
  addi r18, r17, 0x7B2D
  lbz r16, 0(r18)

  ;If not "Race Mode", leave.
  cmplwi r16, 1
  bne- End

  ;Load "StageSequenceManager Phase" into r16.
  lis r16, 0x805E
  ori r16, r16, 0xF9A8
  lbz r16, 0x4(r16)
  
  ;If not "Story Mode / Last Story = 1 / Expert Mode = 6", leave.
  cmplwi r16, 1
  beq- RaceIGTMode
  cmplwi r16, 6
  bne- End
  
RaceIGTMode:
  ;Load "Race IGT" into f1.
  lfs f1, 29236(r29)

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
