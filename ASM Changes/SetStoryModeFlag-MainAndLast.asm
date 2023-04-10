#To be inserted at 802D1BE8
;SetStoryModeFlag-MainAndLast.asm

Start:
  ;Original Code
  lwz r4, 12(r31) ;This is the current Stage ID (r4)

  ;Register to set addresses to true.
  li r16, 0x1

  ;Load address of "Story Mode Flag" into r18
  lis r18, 0x8057
  ori r18, r18, 0xD8F7

  ;Set "Story Mode Flag" to true.
  sth r16, 0(r18)

  ;Check if in Last Way or Devil Doom
  ;to set flag to say we are in Last Story.

  ;Load address to "In Last Story" flag
  lis r18, 0x8057
  ori r18, r18, 0xD903
  cmplwi r4, 700
  beq SetLastStoryFlag
  cmplwi r4, 710
  beq SetLastStoryFlag
  
  ;If here, not in Last Story.
  ;Ensure flag is false
  li r16, 0x0

SetLastStoryFlag:
  sth r16, 0(r18)

End:
  ;Clean up to prevent
  ;accidental code changes.
  li r16, 0x0
  li r18, 0x0
