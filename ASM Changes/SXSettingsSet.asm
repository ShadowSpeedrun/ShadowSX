#8035a290
#SXSettingsSet.asm

Start:
  #Original Code
  cmpwi r3, 2
  bne- End
  
  #Check the current Message ID to see if we are showing the SX intro.
  #Load Intro Message ID (8057D8FC)
  lis r18, 0x8057
  ori r18, r18, 0xD8FC
  lhz r19, 0(r18)
  
  cmpwi r19, 44
  bne- End
  
  #OK was pressed while one of the SX intros was up.
  
  #Check if we were in a screen that is supposed to move to
  #the AutoSave Screen next.
  
  #Load value of 0x8057D8FA
  #r18 is already set to be 0x8057D8FC
  lhz r17, -2(r18)
  
  cmpwi r17, 4
  bge SetToSavePrompt

SetToAutoSave:
  #Move on to the AutoSave, dont allow the message to close.
  li r19, 40
  sth r19, 0(r18)
  li r3, 0
  #Set Offset to Zero
  sth r3, -2(r18)

  #Set Last seen Message to Autosave to prevent showing 0 offset 44.
  lis r18, 0x807D
  ori r18, r18, 0x5700
  stw r19, 0(r18)
  li r19, -2
  stw r19, 4(r18)

  b End

SetToSavePrompt:
  li r3, 2
  sth r3, -2(r18)
  li r3, 0
  #Set Cursor Index to 0 for Practice Mode later.
  sth r3, -8(r18)

CheckSPWChanges:
  #Next, apply changes from options menu.
  #Check if SPW were adjusted.
  lis r18, 0x8057
  ori r17, r18, 0x8068
  ori r18, r18, 0x9FC4
  lhz r17, 0(r17)
  lhz r19, 0(r18)

  CheckSamuraiBladeChange:
    andi. r15, r17, 0x3
    andi. r16, r19, 0x3
    cmpw r15, r16
    beq CheckSatelliteLaserChange
    andi. r19, r19, 0x7FC #Clear SB from Save so it appears on next save.

  CheckSatelliteLaserChange:
    andi. r16, r17, 0xC
    andi. r15, r19, 0xC
    cmpw r15, r16
    beq CheckVacuumEggChange
    andi. r19, r19, 0x7F3 #Clear SL from Save so it appears on next save.

  CheckVacuumEggChange:
    andi. r16, r17, 0x30
    andi. r15, r19, 0x30
    cmpw r15, r16
    beq CheckOmochaoGunChange
    andi. r19, r19, 0x7CF #Clear SL from Save so it appears on next save.

  CheckOmochaoGunChange:
    andi. r16, r17, 0xC0
    andi. r15, r19, 0xC0
    cmpw r15, r16
    beq CheckHealCannonChange
    andi. r19, r19, 0x73F #Clear SL from Save so it appears on next save.

  CheckHealCannonChange:
    andi. r16, r17, 0x300
    andi. r15, r19, 0x300
    cmpw r15, r16
    beq CheckShadowRifleChange
    andi. r19, r19, 0x4FF #Clear SL from Save so it appears on next save.

  CheckShadowRifleChange:
    andi. r16, r17, 0x400
    andi. r15, r19, 0x400
    cmpw r15, r16
    beq SaveSPWStatus
    andi. r19, r19, 0x3FF #Clear SL from Save so it appears on next save.
  SaveSPWStatus: 
    sth r19, 0(r18)

CheckPage2Options:
  lis r16, 0x8057
  ori r18, r16, 0xFBA0
  ori r17, r16, 0x8020 #Last Story & Expert Bytes 

  #Check if we want to unlock Last Story
  lbz r19, 0(r18)
  cmpwi r19, 8 
  bne CheckExpert
  li r19, 1
  stb r19, 0(r17)

CheckExpert:
  lbz r19, 1(r18)
  cmpwi r19, 8 #Check if we want to unlock Expert Mode
  bne CheckStages
  li r19, 1
  stb r19, 1(r17)

CheckStages:
  lbz r19, 2(r18)
  cmpwi r19, 8 #Check if we want to unlock Stages And Bosses
  bne CheckKeys

  lis r18, 0x8057 #Westopolis Played
  ori r18, r18, 0x6BE0
  li r17, 0 #r17 = stage counter.
  li r19, 1

  SetStagesAvailableLoop:
    mulli r16, r17, 0x60 #r16 = RAM offset to stage data
    stwx r19, r18, r16
    addi r17, r17, 1
    cmpwi r17, 40
    blt SetStagesAvailableLoop

  lis r18, 0x8057 #Black Bull Show Stats
  ori r18, r18, 0x749C
  li r17, 0 #r17 = stage counter.
  li r19, 1

  SetBossesVisiableLoop:
    mulli r16, r17, 0x60 #r16 = RAM offset to stage data
    stbx r19, r18, r16
    addi r17, r17, 1
    cmpwi r17, 17
    blt SetBossesVisiableLoop

CheckKeys:
  lis r16, 0x8057
  ori r18, r16, 0xFBA0
  lbz r19, 3(r18)
  cmpwi r19, 3 #Check if we want to unlock Stages
  beq UnlockAllKeys
  bgt RemoveAllKeys
  #Not greater than or equal means we dont want to change anything.
  b End

UnlockAllKeys:
  #Do all of "Group 60"
  lis r18, 0x8057 #Westopolis Keys
  ori r18, r18, 0x6C2C
  li r17, 0 #r17 = stage counter.

  li r19, 60
  li r15, 2
  bl KeySetActiveLoop

  #Glyphic Canyon
  li r19, 95
  li r15, 3
  bl KeySetActiveLoop

  #Lethal Highway
  li r19, 60
  li r15, 8
  bl KeySetActiveLoop

  #Doom
  li r19, 201
  mulli r16, r17, 0x60 #r16 = RAM offset to stage data
  stwx r19, r18, r16
  addi r16, r16, 4
  addi r19, r19, 1
  stwx r19, r18, r16
  addi r16, r16, 4
  addi r19, r19, 1
  stwx r19, r18, r16
  addi r16, r16, 4
  addi r19, r19, 1
  stwx r19, r18, r16
  addi r16, r16, 4
  li r19, 5
  stwx r19, r18, r16
  addi r17, r17, 1

  #Sky Troops
  li r19, 95
  li r15, 10
  bl KeySetActiveLoop

  #Mad Matrix
  li r19, 60
  li r15, 11
  bl KeySetActiveLoop

  #Death Ruins
  li r19, 1
  li r15, 13
  bl KeySetActiveLoop

  #Air Fleet
  li r19, 95
  li r15, 15
  bl KeySetActiveLoop

  #Space Gadget
  li r19, 1
  li r15, 17
  bl KeySetActiveLoop

  #GUN Fortress
  li r19, 95
  li r15, 20
  bl KeySetActiveLoop

  #Cosmic Fall
  li r19, 1
  li r15, 21
  bl KeySetActiveLoop

  #Final Haunt 
  li r19, 95
  li r15, 23
  bl KeySetActiveLoop
  
  b End

KeySetActiveLoop:
  stwu sp, -8(sp)
  mflr r16
  stw r16, 4(sp)

  KeyLoop:
    mulli r16, r17, 0x60 #r16 = RAM offset to stage data
    stwx r19, r18, r16
    addi r16, r16, 4
    addi r19, r19, 1
    stwx r19, r18, r16
    addi r16, r16, 4
    addi r19, r19, 1
    stwx r19, r18, r16
    addi r16, r16, 4
    addi r19, r19, 1
    stwx r19, r18, r16
    addi r16, r16, 4
    addi r19, r19, 1
    stwx r19, r18, r16
    addi r17, r17, 1
    subi r19, r19, 4 #Go back to starting amount for next loop.
    cmpw r17, r15
    blt KeyLoop

  lwz r16, 4(sp)
  addi sp, sp, 8
  mtlr r16
  blr

RemoveAllKeys:
  lis r18, 0x8057 #Westopolis Keys
  ori r18, r18, 0x6C2C
  li r17, 0 #r17 = stage counter.
  li r19, 0
  subi r19, r19, 1 #r19 = FFFFFFFF

  RemoveKeysLoop:
    mulli r16, r17, 0x60 #r16 = RAM offset to stage data
    stwx r19, r18, r16
    addi r16, r16, 4
    stwx r19, r18, r16
    addi r16, r16, 4
    stwx r19, r18, r16
    addi r16, r16, 4
    stwx r19, r18, r16
    addi r16, r16, 4
    stwx r19, r18, r16
    addi r17, r17, 1
    cmpwi r17, 23
    blt RemoveKeysLoop

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
  li r19, 0x0

  #Rerun Original Code for branches to work.
  cmpwi r3, 2

