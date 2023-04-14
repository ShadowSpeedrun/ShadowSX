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

  ;Load "Story Mode Flag" into r16.
  ori r18, r17, 0xD8F6
  lhz r16, 0(r18)
  
  ;If not "Story Mode", leave.
  cmplwi r16, 1
  bne- End
  
  ;Load "Race IGT" into f1.
  lfs f1, 29236(r29)

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
