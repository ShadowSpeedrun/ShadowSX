#To be inserted at 8016EFA0
;Original Code
;add r0, r0, r4

Start:
  ;Load value of "Story Mode Flag"
  ;into r16.
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6180
  or r18, r16, r17
  lhz r16, 0(r18)

  ;If "Story Mode Flag" is true
  ;Allow Original Code to Run.
  cmplwi r16, 1
  bne- End
  add r0, r0, r4

End:
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
