#To be inserted at 80205BC8
;MissionCompleteEvents.asm

;Set "In Checkpoint" False
;Set OG Timer to the value of New IGT on mission complete.
;Save Race Time to save data, if select mode flag is off.

Start:
  ;Original Code
  stwu r1, -16(r1)
  
  ;Set "In Checkpoint" to false.
  lis r16, 0x8057
  ori r18, r16, 0xD8A6
  li r17, 0x0
  sth r17, 0(r18)

  ;Set "OG Timer" to the value of New IGT.
  lfs f3, 31120(r31)
  stfs f3, 30652(r31)
  fmr f4, f3

  ;Load Flag for Select Mode
  ori r18, r16, 0xD8FE
  lhz r18, 0(r18)
  
  ;If flag is on, skip to the end.
  cmpwi r18, 1
  beq End

  ;Load current Race IGT into f3.
  lfs f3, 31136(r31)

  ;Check if we are in Expert Mode.
  ori r18, r16, 0xD7C5
  lbz r17, 0(r18)
  
  ;Save Race IGT to the appropriate
  ;save location based on Expert flag.
  cmpwi r17, 0x1
  beq SaveExpertRaceTime

  ;Check if we are in Last Story.
  ori r18, r16, 0xD902
  lhz r17, 0(r18)
  cmpwi r17, 0x1
  beq SaveLastStoryRaceTime
  b SaveRaceTimeStory
  
SaveExpertRaceTime:
  ;Save to Expert Race Time.
  stfs f3, 7060(r31)
  fmr f4, f3
  b End

SaveLastStoryRaceTime:
  ;Save to Last Story Race Time.
  stfs f3, 7084(r31)
  fmr f4, f3
  b End

SaveRaceTimeStory:
  stfs f3, 7036(r31)
  fmr f4, f3

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
