#To be inserted at 801e33bc
;ExpertSelectModePreventLivesSave.asm

Start:
  ;Load flag for Select Mode
  lis r18, 0x8057
  ori r18, r18, 0xD8FE
  lhz r18, 0(r18)
  
  ;If flag is on, dont save lives.
  cmpwi r18, 1
  beq End
  
  ;Original Code
  stw r0, 0x00A0 (r31)

End:
  li r18, 0x0