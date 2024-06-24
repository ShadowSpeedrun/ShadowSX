#803442f8
#SkipIntroSooner.asm

#Original Code
#lbz r0, 0x007F (r3)

#The original code would load from the
#address 8057D71F, which is set to 1
#by default and then set to 0 once the
#intro movie starts.

#The code that runs just after this
#check to see if this is 0 before allowing
#the user to skip to the title screen.

#We will for the r0 register to 0 to allow
#this check to always work.

li r0, 0x0