#To be inserted at 80336FF0
#ResetNewIgtOnRestart.asm

#Set New IGT to 0 in sync with 
#when we would for the original timer.

Start:
  stfs f0, 12(r3) #Original Code
  stfs f0, 480(r3)