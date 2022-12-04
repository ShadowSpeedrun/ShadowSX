#To be inserted at 80205BC8
;MissionCompleteEvents.asm

;Set "In Checkpoint" False
;Set OG Timer to the value of New IGT on mission complete.
;Save Race Time to save data.

Start:
  ;Original Code
  stwu r1, -16(r1)
  
  ;Set "In Checkpoint" to false.
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6130
  or r18, r16, r17
  li r15, 0x0
  sth r15, 0(r18)

  ;Set "OG Timer" to the value of New IGT.
  lfs f3, 31120(r31)
  stfs f3, 30652(r31)
  fmr f4, f3

  ;Load current Race IGT into f3.
  lfs f3, 31136(r31)

  ;Check if we are in Expert Mode.
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x604E
  or r18, r16, r17
  lbz r16, 0(r18)
  
  ;Save Race IGT to the appropriate
  ;save location based on Expert flag.
  cmpwi r16, 0x1
  bne- SaveRaceTimeStory
  
  ;Save to Expert Race Time.
  stfs f3, 7060(r31)
  fmr f4, f3
  b End

SaveRaceTimeStory:
  stfs f3, 7036(r31)
  fmr f4, f3

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
