#To be inserted at 8035a290
;Original Code
cmpwi r3, 2
bne- End

;Check the current Message ID to see if we are showing the SX intro.
;Load Intro Message ID (8057D8FD)
lis r16, 0x8057
li r17, 0x7777
addi r17, r17, 0x6186
or r18, r16, r17
lhz r19, 0(r18)

cmpwi r19, 44
bne- End

;A was pressed while the SX intro was up.
;Move on to the AutoSave, dont allow the message to close.
li r19, 40
sth r19, 0(r18)
li r3, 0

;Load the value of "P1 Button State" into r19.(8056ED4C)
lis r16, 0x8056
li r17, 0x7777
addi r17, r17, 0x75D5
or r18, r16, r17
lwz r19, 0(r18)

;Setup for address loading
;to reduce redundant instructions
lis r16, 0x8057

CheckCS:
  ;Check for L (0x1000)
  andi. r20, r19, 0x1000
  cmplwi r20, 0x1000
  bne- CheckRace

  ;Load "Disable CS" Address into r18. (8057D8FB)  
  li r17, 0x7777
  addi r17, r17, 0x6184
  or r18, r16, r17

  ;Set "Disable CS" to true.
  li r20, 0x1
  sth r20, 0(r18)  

CheckRace:
  ;Check for R (0x2000)
  andi. r20, r19, 0x2000
  cmplwi r20, 0x2000
  bne- CheckUI

  ;Load "Enable Race Mode" Address into r18. (8057D8F5)
  li r17, 0x7777
  addi r17, r17, 0x617E
  or r18, r16, r17

  ;Set "Enable Race Mode" to true.
  li r20, 0x1
  sth r20, 0(r18)

CheckUI:
  ;Check for Dpad Up (0x40)
  andi. r20, r19, 0x40
  cmplwi r20, 0x40
  bne- End

  ;Load "EnableXboxUI" Address into r18. (8057D8FF)
  li r17, 0x7777
  addi r17, r17, 0x6188
  or r18, r16, r17

  ;Set "EnableXboxUI" to true.
  li r20, 0x1
  sth r20, 0(r18)

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
  li r19, 0x0
  li r20, 0x0

  ;Rerun Original Code for branches to work.
  cmpwi r3, 2

