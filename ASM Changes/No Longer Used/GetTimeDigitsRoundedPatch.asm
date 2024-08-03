#801e45e0
#GetTimeDigitsRoundedPatch.asm
#Add .5 to the Milliseconds so when it's rounded down,
#it becomes a value as if it followed the 
#round up if 5 or higher rule.

#Original Code
fmuls f0, f3, f0

#Add .5 to remaining seconds here
lis r18, 0x3F00 #0.5
stw r18, -4(sp)
lfs f3, -4(sp)

fadds f0, f0, f3

lis r18, 0x42C8 #100
stw r18, -4(sp)
lfs f3, -4(sp)