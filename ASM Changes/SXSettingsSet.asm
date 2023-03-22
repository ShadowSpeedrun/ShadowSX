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

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
  li r19, 0x0

  ;Rerun Original Code for branches to work.
  cmpwi r3, 2

