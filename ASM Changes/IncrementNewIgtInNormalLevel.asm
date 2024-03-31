#To be inserted at 80337034
;IncrementNewIgtInNormalLevel.asm

;Do not apply scaler
;Race time is Saved time + New IGT

;TODO: Find out why we are not providing original code?
Start:
  ;Load value of "In Cutscene Flag" to r16.
  lis r16, 0x8057
  ori r18, r16, 0xD8F8
  lhz r17, 0(r18)
  
  ;If "In Cutscene Flag" is 1, we are not in
  ;a level and can leave.
  cmplwi r17, 0
  bne- End
  
  ;f0 is timestep
  ;f1 is scaler
  ;Divide timestep by scaler to undo scale.
  lfs f1, -100(r3)
  lfs f0, 32(r4)
  fdivs f0, f0, f1
  
  ;Ensure timestep is not negative.
  ;TODO: uh. double check this.
  ;It works, but perhaps on accident.
  fcmpo cr0, f0, f6
  bgt- ApplyTime
  fmr f0, f6

ApplyTime:
  ;Add timestep to New IGT.
  lfs f1, 480(r3)
  fadds f1, f1, f0
  stfs f1, 480(r3)

  ;Check if in Expert Mode.
  ;to determine if Story or Expert
  ;Race Time should be used.
  ori r18, r16, 0xD7C4
  lhz r17, 0(r18)
  cmpwi r17, 0x1
  beq LoadExpertRaceTime

  ;Check if Last Story
  addi r18, r18, 0x6F60
  lwz r17, 0(r18)
  cmpwi r17, 0x2

  beq LoadLastStoryRaceTime
  
  ;Default to Story Race Time if neither are enabled.

LoadStoryRaceTime:
  lfs f0, -23604(r3)
  b CalcRaceTime

LoadExpertRaceTime:
  lfs f0, -23580(r3)
  b CalcRaceTime

LoadLastStoryRaceTime:
  lfs f0, -23556(r3)
  b CalcRaceTime

CalcRaceTime:
  fadds f1, f1, f0
  stfs f1, 496(r3)

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0


