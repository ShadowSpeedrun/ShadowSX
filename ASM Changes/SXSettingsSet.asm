#To be inserted at 8035a290
;SXSettingsSet.asm

Start:
  ;Original Code
  cmpwi r3, 2
  bne- End
  
  ;Check the current Message ID to see if we are showing the SX intro.
  ;Load Intro Message ID (8057D8FC)
  lis r18, 0x8057
  ori r18, r18, 0xD8FC
  lhz r19, 0(r18)
  
  cmpwi r19, 44
  bne- End
  
  ;OK was pressed while one of the SX intros was up.
  
  ;Check if we were in a screen that is supposed to move to
  ;the AutoSave Screen next.
  
  ;Load value of 0x8057D8FA
  ;r18 is already set to be 0x8057D8FC
  lhz r17, -2(r18)
  
  cmpwi r17, 1
  beq SetToSavePrompt

SetToAutoSave:
  ;Move on to the AutoSave, dont allow the message to close.
  li r19, 40
  sth r19, 0(r18)
  li r3, 0
  b End

SetToSavePrompt:
  li r3, 2
  sth r3, -2(r18)
  li r3, 0

End:
  li r17, 0x0
  li r18, 0x0
  li r19, 0x0

  ;Rerun Original Code for branches to work.
  cmpwi r3, 2

