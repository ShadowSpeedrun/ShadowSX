#To be inserted at 8016f014
;ExpertSelectModeLives.asm

Start:
  ;Load Flag for Select Mode
  lis r18, 0x8057
  ori r18, r18, 0xD8FE
  lhz r18, 0(r18)
  
  ;If Flag is on, set lives to 99.
  cmpwi r18, 1
  beq SelectModeLives
  
  ;Original Code
  lwz r0, 0x00A0 (r3)
  b Exit

SelectModeLives:
  li r0, 99

Exit:
  li r18, 0