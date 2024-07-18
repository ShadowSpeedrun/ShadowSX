#802D2134
#ResetRaceIGTOnStoryNew.asm

#r16, f0 used

Start:
  #Original Code
  li r5, 0

ResetStory:
  #Load address of Story Race Time
  #into r16. (80577AF4)
  lis r16, 0x8057
  ori r16, r16, 0x7AF4
  #make f0 0.0f, store to Story Race Time
  fsubs f0, f0, f0
  stfs f0, 0(r16)