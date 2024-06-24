#801e33dc
#SetShowRaceTimeFalseOnPauseExit.asm
#To account for Boss Battle usage.

Start:
  li r5, 0
  #Set "Show Race Time" to false.
  lis r18, 0x8057
  ori r18, r18, 0xD900
  sth r5, 0(r18)

  #Original Code 
  li r5, 1

  #Cleanup to prevent
  #accidental code changes
  li r18, 0x0
