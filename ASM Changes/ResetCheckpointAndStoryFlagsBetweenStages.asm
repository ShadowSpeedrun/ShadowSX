#To be inserted at 80203894
;ResetCheckpointAndStoryFlagsBetweenStages.asm

;Assume Stage ID of -1 means we are not in a 
;level and therefore can reset these flags
;in case the next level is loaded with Select Mode.

Start:
  ;Original Code
  stw r0, 0(r3)

  ;Set "In Checkpoint" to false.
  ;r15 is supposed to be 0.
  ;But the last story select mode code could make
  ;it not 0, so ensure it's 0 now.
  li r15, 0x0
  lis r16, 0x8057
  ori r16, r16, 0xD8A6
  sth r15, 0(r16)
