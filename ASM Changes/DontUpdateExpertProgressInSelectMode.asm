#To be inserted at 80204e60
;DontUpdateExpertProgressInSelectMode.asm

Start:
  ;Load Flag for Select Mode
  lis r18, 0x8057
  ori r18, r18, 0xD8FE
  lhz r18, 0(r18)
  
  ;If flag is on, do not save update Expert Progress.
  cmpwi r18, 1
  beq End
  
  ;Original Code
  stw r0, 0x006C (r30)

End:
  li r18, 0