#80205078
#ExpertUnlockPatch.asm

#A nop inserted in earlier code will prevent 
#using Expert Unlock as a means of setting the Expert Mode Flag back to false.
#This patch will do an extra check compared to the Memory Card's data to
#ensure the Expert Mode Flag stays True if it was unlocked without 71 A Ranks.

#r31 = 80576958

#r29 is a 1 by default, but a 0 if the previous
#checks fail to find an A Rank.

lbz r16, 0x3625 (r31)
cmpwi r16, 1
bne OriginalCode
li r29, 1

OriginalCode:
stb r29, 0x16C9 (r31)


