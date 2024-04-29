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
  
  cmpwi r17, 3
  bge SetToSavePrompt

SetToAutoSave:
  ;Move on to the AutoSave, dont allow the message to close.
  li r19, 40
  sth r19, 0(r18)
  li r3, 0
  b End

SetToSavePrompt:
  li r3, 1
  sth r3, -2(r18)
  li r3, 0

CheckSPWChanges:
  ;Next, apply changes from options menu.
  ;Check if SPW were adjusted.
  lis r18, 0x8057
  ori r17, r18, 0x806C
  ori r18, r18, 0x9FC4
  lhz r17, 0(r17)
  lhz r19, 0(r18)
  cmpw r17, r19
  beq CheckPage2Options
  ;If here, we did make changes.
  ;Set 9FC4 to 0 to apply changes correctly.
  li r19, 0
  sth r19, 0(r18)

CheckPage2Options:
  lis r18, 0x8057
  ori r18, r18, 0xFBA0
  ori r17, r18, 0x8020 ;Last Story & Expert Bytes 

  ;Check if we want to unlock Last Story
  lbz r19, 0(r18)
  cmpwi r19, 8 
  bne CheckExpert
  li r19, 1
  stb r19, 0(r17)

CheckExpert:
  lbz r19, 1(r18)
  cmpwi r19, 8 ;Check if we want to unlock Expert Mode
  bne CheckStages
  li r19, 1
  stb r19, 1(r17)

CheckStages:
  lbz r19, 1(r18)
  cmpwi r19, 8 ;Check if we want to unlock Stages
  bne CheckKeys
  ;Run code to unlock Stages

CheckKeys:
  lbz r19, 1(r18)
  cmpwi r19, 3 ;Check if we want to unlock Stages
  beq UnlockAllKeys
  bgt RemoveAllKeys
  ;Not greater than or equal means we dont want to change anything.
  b End

UnlockAllKeys:
  b End

RemoveAllKeys:
  lis r18, 0x8057 ;Westopolis Keys
  ori r18, r18, 0x6C2C
  li r17, 0 ;r17 = stage counter.
  
  RemoveKeysLoop:
    mulli r16, r17, 0xC0 ;r16 = RAM offset to stage data
    li r19, 0xFF
    stwx r19, r18, r16
    addi r16, r16, 4
    stwx r19, r18, r16
    addi r16, r16, 4
    stwx r19, r18, r16
    addi r16, r16, 4
    stwx r19, r18, r16
    addi r16, r16, 4
    stwx r19, r18, r16
    addi r16, r16, 4
    addi r17, r17, 1
    cmpwi r17, 23
    blt RemoveKeysLoop

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
  li r19, 0x0

  ;Rerun Original Code for branches to work.
  cmpwi r3, 2

