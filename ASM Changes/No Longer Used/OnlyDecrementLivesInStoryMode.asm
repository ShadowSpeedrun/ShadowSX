#To be inserted at 8016EFA0
;OnlyDecrementLiveInStoryMode.asm

Start:
  ;Load value of "Story Mode Flag"
  ;into r18.
  lis r18, 0x8057
  ori r18, r18, 0xD8F6

  lhz r18, 0(r18)

  ;If "Story Mode Flag" is true
  ;Allow Original Code to Run.
  cmplwi r18, 1
  bne- End

  ;Original Code
  add r0, r0, r4

End:
  li r18, 0x0
