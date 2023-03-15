#To be inserted at 80342398
;Set Time Popup On

;Original Code
stwu sp, -0x0020 (sp)

;Set Flag
lis r16, 0x8057
li r17, 0x7777
addi r17, r17, 0x618A
or r18, r16, r17
li r16, 0x1
sth r16, 0(r18)

li r16, 0x0
li r17, 0x0
li r18, 0x0