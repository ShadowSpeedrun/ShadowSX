#To be inserted at 8035a280
;Initialize Intro Message

;Original Code
;lhz r4, 40

;Load Intro Message ID (8057D8FD)
lis r16, 0x8057
li r17, 0x7777
addi r17, r17, 0x6186
or r18, r16, r17
lwz r19, 0(r18)
cmplwi r19, 0x0
bne- End

;Initialize to SX intro
li r20, 44
sth r20, 0(r18)

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
  li r19, 0x0
  li r20, 0x0
  
