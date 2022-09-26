#To be inserted at 802D1BE8
;SetStoryModeFlag-MainAndLast.asm

Start:
  ;Original Code
  lwz r4, 12(r31)

  ;Load address of "Story Mode Flag" into r18
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6180
  or r18, r16, r17

  ;Set "Story Mode Flag" to true.
  li r16, 0x1
  sth r16, 0(r18)

  ;Clean up to prevent
  ;accidental code changes.
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
