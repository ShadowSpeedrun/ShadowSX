#To be inserted at 8016f014
lis r18, 0x8057
ori r18, r18, 0xD8FF
lhz r18, 0(r18)
cmpwi r18, 1
beq SelectModeLives

;Original Code
lwz r0, 0x00A0 (r3)
b Exit

SelectModeLives:
  li r0, 99

Exit:
  li r18, 0