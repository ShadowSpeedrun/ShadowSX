#80178BC4
#RestoreTimeOnDeathChecks.asm

#Normally we do not want to restore the timer to
#the last checkpoint / save, but for Bosses we need to
#reset the OG timer to keep functionality the same as OG.
#We also only want to reset the New IGT if we are in select mode.

#To check for if we are in a boss fight, we will do some bit math
#on the Stage ID. Boss IDs are set as: Level Column - Boss - #
#So 412 = Column 4 Third Boss = Black Bull 2.

Start:
  #Load value of "Boss Selected"
  #into r18. (8057D748)
  lis r18, 0x8057
  ori r17, r18, 0xD748
  lwz r17, 0(r17)

  li r19, 100
  divw r16, r17, r19
  mullw r16, r16, r19
  sub r17, r17, r16

  cmpwi r17, 10
  bge RestoreTimerOG
  blt End

RestoreTimerOG:
  #Original Code
  #r4+148 = 8057D734
  stfs f0, 148(r4)

CheckSelectMode:
#Load "StageSequenceManager Phase" into r18.
  lis r18, 0x805E
  ori r18, r18, 0xF9A8
  lwz r18, 0x0(r18)
  lwz r18, 0x4(r18)

  #If Select Mode, Reset New Timer as well
  cmpwi r18, 0
  bne End

ResetNewTimer:
  stfs f0, 0x268(r4)

End:
  li r16, 0
  li r17, 0
  li r18, 0
  li r19, 0