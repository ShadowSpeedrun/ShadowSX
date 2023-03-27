#To be inserted at 8035a284
;Boot intro SX

;Load Intro Message ID (8057D8FD)
lis r16, 0x8057
li r17, 0x7777
addi r17, r17, 0x6186
or r18, r16, r17
lhz r4, 0(r18)

End:
li r16, 0x0
li r17, 0x0
li r18, 0x0

;Original code
li r5, 0
