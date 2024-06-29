#8011bef0
#PracticeModePreventKeyPickup.asm

#Check if Practice Mode (8057D8F4)
lis r16, 0x8057
ori r16, r16, 0xD8F4
lbz r16, 0(r16)
cmpwi r16, 1
beq PreventSave

#Original Code
stwx r3, r5, r4
b End

PreventSave:
  li r0, 100

End: