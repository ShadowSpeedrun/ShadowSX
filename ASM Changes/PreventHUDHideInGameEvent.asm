#To be inserted at 80204ce8
;PreventHUDHideInGameEvent.asm

;If "In Checkpoint" flag is set, prevent the HUD from Hiding.
Start:
  ;Load value of "In Checkpoint" into r16
  lis r18, 0x8057
  ori r18, r18, 0xD8A6
  lhz r18, 0(r18)

  ;If "In Checkpoint" is 1, exit code.
  cmplwi r18, 0
  bne- Exit

;Original Code
stb r0, 0x0148 (r5)

Exit: