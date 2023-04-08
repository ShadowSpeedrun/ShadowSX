#To be inserted at 80206198
;PreventTimerRestartInStory-Pt1.asm

;Replacing Original Code 
;to add new functionality.
Start:
  ;Load value of "Story Mode Flag"
  ;into r18.
  lis r18, 0x8057
  ori r18, r18, 0xD8F7
  lhz r18, 0(r18)

  ;If "Story Mode Flag" is false,
  ;Go run that code....
  ;TODO: wtf does that code do.
  cmplwi r18, 0
  bne- End
  lis r18, 0x8033
  ori r18, r18, 0x6FAC
  mtlr r18
  blrl

End:
  li r18, 0x0
