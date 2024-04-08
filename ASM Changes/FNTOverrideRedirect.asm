#To be inserted at 80049e0c
;FNTOverrideRedirect.asm

Start:
  ;Pre-emptively set offset to 0 in case of exit.
  li r18, 0

  ;TODO: Confirm this is checking for OK prompt
  cmpwi r11, 1
  bne End
  
  ;Load requested message to be shown in r16.
  lis r18, 0x807D
  addi r18, r18, 0x5700
  lwz r16, 0(r18)

  ;Load last attempted to shown message into r17
  lis r18, 0x8057
  ori r18, r18, 0xD8FE
  lhz r17, 0(r18) ;8057D8FE

  ;Store requested message into last message.
  sth r16, 0(r18)

  ;Pre-emptively set offset to 0 in case of exit.
  li r18, 0

  ;If the message we are attempting to show is -1, check if the last message was an override message.
  cmpwi r16, -1
  bne SetMessage

  ;Check for if the last message was an override message, either Delete or Format(80575700 = 44)
  cmpwi r17, 44
  bgt SetMessage
  cmpwi r17, 43
  blt SetMessage

  ;Set r16 to override message. This is to prevent the original message from appearing before the close animation.
  mr r16, r17

SetMessage:
  ;Check for if the message we are trying to show is an override message, either Delete or Format(80575700 = 44)
  cmpwi r16, 44
  bgt End
  cmpwi r16, 43
  blt End

  ;This is an overrideable message, set r16 to the offset multiplier.
  lis r18, 0x8057
  ori r18, r18, 0xD8FA
  lhz r16, 0(r18)

  ;r18 is offset to use in actual bytes.
  mulli r18, r16, 0x14
  
End:
  ;Original Code
  ;lwz r3, 0 (r10)
  
  lwzx r3, r10, r18 
  li r16, 0
  li r17, 0
  li r18, 0



