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

;OK was pressed while one of the SX intros was up.

;Check if we were in a screen that is supposed to move to
;the AutoSave Screen next.

;8057D8FB
lis r16, 0x8057
li r17, 0x7777
addi r17, r17, 0x6184
or r18, r16, r17
lhz r17, 0(r18)

cmpwi r17, 1
beq SetToSavePrompt

SetToAutoSave:
  ;Set address back to 8057D8FD
  addi r18, r18, 2
  ;Move on to the AutoSave, dont allow the message to close.
  li r19, 40
  sth r19, 0(r18)
  li r3, 0
  b End

SetToSavePrompt:
  li r3, 2
  sth r3, 0(r18)
  addi r18, r18, 2
  li r3, 0

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
  li r19, 0x0

  ;Rerun Original Code for branches to work.
  cmpwi r3, 2

