#80201924
#ToggleShowDarkMeterAsDarkScore.asm

#r29 = 805766e4

#Check if Practice Mode (8057D8F4)
lbz r16, 0x7210(r29)
cmpwi r16, 1
bne UseScore

#Check if Toggle is On (8057D8F5)
lbz r16, 0x7211(r29)
cmpwi r16, 1
bne UseScore

#Load DarkMeterValue into r5 (805766D4)
lwz r5, -0x0010 (r29)
b End

UseScore:
#Original Code
#Loads DarkScore to r5
lwz r5, 0x0034 (r29)

End: