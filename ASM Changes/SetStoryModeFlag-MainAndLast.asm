#To be inserted at 802D1BE8
;SetStoryModeFlag-MainAndLast.asm

Start:
  ;Original Code
  lwz r4, 12(r31) ;This is the current Stage ID (r4)

  ;Load address of "Story Mode Flag" into r18
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6180
  or r18, r16, r17

  ;Set "Story Mode Flag" to true.
  li r16, 0x1
  sth r16, 0(r18)

  ;Check if in Last Way or Devil Doom
  ;to set flag to say we are in Last Story.

  cmplwi r4, 700
  beq SetLastStoryFlag
  cmplwi r4, 710
  bne End

SetLastStoryFlag:
  ;If true then this
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x618C
  or r18, r16, r17
  li r16, 1
  sth r16, 0(r18)

End:
  ;Clean up to prevent
  ;accidental code changes.
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
