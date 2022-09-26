#To be inserted at 80336FF0
;ResetNewIgtOnRestart.asm

;Set New IGT to 0 in sync with 
;when we would for the original timer.

;TODO: Overwriting original code?
Start:
  stfs f0, 12(r3)
  stfs f0, 479(r3)
