#801e45f4
#GetTimeDigitsRoundedPatch2.asm
#If when rounded up, milliseconds == 100,
#carry over to a new second.

#Original Code
sub r0, r6, r0

#r5 = Milliseconds as Bytes
#Adding .5 earlier on allowed the milliseconds to round up to 100,
#so we need now need to adjust both this and the seconds byte to show this properly.
cmpwi r5, 100
bne End

#We will set r5 to be 0, but we'll borrow it first to add 1 to seconds
lbz r5, 4(r3)
addi r5, r5, 1
stb r5, 4(r3)
li r5, 0

End: