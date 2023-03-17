#To be inserted at 80203894
;ResetCheckpointAndStoryFlagsBetweenStages.asm

;Assume Stage ID of -1 means we are not in a 
;level and therefore can reset these flags
;in case the next level is loaded with Select Mode.

Start:
  ;Original Code
  stw r0, 0(r3)

  ;Set "In Checkpoint" to false.
  ;r15 is 0x0.
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6130
  or r18, r16, r17
  sth r15, 0(r18)
  
  ;Add Offet to then set "Story Mode Flag" to false.
  addi r18, r18, 0x50
  sth r15, 0(r18)

  ;Again, but for Last Story Flag
  addi r18, r18, 0xC
  sth r15, 0(r18)
  
  ;Cleanup to prevent
  ;accidental code changes.
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
