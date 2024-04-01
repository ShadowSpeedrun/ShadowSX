#To be inserted at 8020623c
;LevelRestartTimerReset.asm
;80206238 will bl to the Level Timer Reset.
;Run this code after the branch returns.

;We only want to restart the New IGT if we are
;in Select Mode.

Start:
  ;Load "StageSequenceManager Phase" into r18.
  lis r18, 0x805E
  ori r18, r18, 0xF9A8
  lbz r18, 0x4(r18)

  ;If "Select Mode",
  ;Run Timer Reset Code
  cmplwi r18, 0
  bne- End

  ;Assume f0 is 0 and r3 is 8057d728, 
  ;as they were just used in the recently ran code.

  ;Set New IGT to 0
  stfs f0, 480(r3)

End:
  extsh.	r0, r31 ;Original Code
  li r18, 0x0