#To be inserted at 80178458
;LevelLoadTimerReset.asm
;80178454 will bl to the Level Timer Reset.
;Run this code after the branch returns.

;Since this is the start of a new level attempt, 
;we always want to reset the New IGT time.

;Assume f0 is 0 and r3 is 8057d728, 
;as they were just used in the recently ran code.

;Set New IGT to 0
stfs f0, 480(r3)

li r3, 1 ;Original Code