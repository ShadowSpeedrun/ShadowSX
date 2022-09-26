#To be inserted at 80201854
;NewIgtForUiDisplay.asm

;Use New IGT by default. 
;Use Race IGT for Story if Race Mode is enabled.

Start:
  ;There was original code here, but a diffent code removed it...
  ;TODO: go clean that up probably.

  ;Load New IGT into f1.
  lfs f1, 29219(r29)
   
  ;Use Race IGT if in Race Mode and in Story.

  ;Load "Race Mode" into r16.
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x617E
  or r18, r16, r17
  lhz r16, 0(r18)

  ;If not "Race Mode", leave.
  cmplwi r16, 1
  bne- End

  ;Load "Story Mode Flag" into r16.
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6180
  or r18, r16, r17
  lhz r16, 0(r18)
  
  ;If not "Race Mode", leave.
  cmplwi r16, 1
  bne- End
  
  ;Load "Race IGT" into f1.
  lfs f1, 29235(r29)

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
