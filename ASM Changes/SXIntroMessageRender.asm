#To be inserted at 8004a47c
;SXIntroMessageRender.asm

Start:
  ;save LR to restore later
  mflr r22
  
  ;Check if we are trying to render a option text
  ;If so, skip to the end.
  cmpwi r11, 1
  bne Exit
  
  ;Check for if we are rendering blank message(807D5700 = 44)
  lis r18, 0x807D
  addi r18, r18, 0x5700
  lwz r16, 0(r18)
  cmpwi r16, 44
  beq RenderSXIntro
  bne Exit

RenderSXIntro:  
  ;Check which screen to show
  lis r18, 0x8057
  ori r18, r18, 0xD8FA
  
  lhz r16, 0(r18)
  cmpwi r16, 0
  beq RenderSXStart
  cmpwi r16, 1
  beq RenderSXSaveMessage
  bne RenderSXOptions

RenderSXStart:
  ;r10 contains address to start of our message.
  lwz r21, 0(r10)

  ;Start by rendering a blank screen
  mr r20, r21
  
  bl GetNewButtonPressesToR16

  andi. r18, r16, 32
  ;r18 is z button press isolated.  

  li r19, 2
  cmpwi r18, 32
  beql ScreenToOptionsR19
  
  bl StoreCurrentInput 
 
  b Exit

ScreenToOptionsR19:
  mflr r15

  lis r18, 0x8057
  ori r18, r18, 0xD8FA

  sth r19, 0(r18)

  mtlr r15
  li r15, 0
  blr

GetNewButtonPressesToR16:
  ;Load the value of "P1 Button State" into r19.(8056ED4C)
  lis r18, 0x8056
  ori r18, r18, 0xED4C
  lwz r19, 0(r18)

  ;Load current saved input into r16
  lis r18, 0x8057
  ori r18, r18, 0xD8F6

  lwz r16, 0(r18)
 
  ;r19 is current input
  ;r16 is last seen input
  xor r16, r16, r19  
  ;r16 should be which buttons changed state

  and r16, r19, r16
  ;r16 should be which buttons are now pressed.

  blr


StoreCurrentInput:
  ;Load the value of "P1 Button State" into r19.(8056ED4C)
  lis r18, 0x8056
  ori r18, r18, 0xED4C
  lwz r19, 0(r18)

  ;Load address for input save
  lis r18, 0x8057
  ori r18, r18, 0xD8F6
  stw r19, 0(r18)
  blr

RenderSXOptions:
  ;r10 contains address to start of our message.
  ;rx = (0x14 * (Page Number + 1))
  lwz r21, 0x28(r10)

  ;Start by rendering a blank screen
  mr r20, r21

  ;Sub Offset if JPN
  ;80576972 = 0

  lis r16, 0x8057
  ori r18, r16, 0xFB80
  lbz r16, 4(r18)
  bl MoveCursorR16X

  lis r16, 0x8057
  addi r18, r16, 0x7B2C
  lbz r17, 0(r18)
  bl RenderOptionR17On

  lis r16, 0x8057
  ori r18, r16, 0xFB80
  lbz r16, 5(r18)
  bl MoveCursorR16X

  lis r16, 0x8057
  addi r18, r16, 0x7B2D
  lbz r17, 0(r18)
  bl RenderOptionR17On

  lis r16, 0x8057
  ori r18, r16, 0xFB80
  lbz r16, 6(r18)
  bl MoveCursorR16X

  lis r16, 0x8057
  addi r18, r16, 0x7B2E
  lbz r17, 0(r18)
  bl RenderOptionR17On

  ;Show Option 4
  lis r16, 0x8057
  ori r18, r16, 0xFB80
  lhz r16, 7(r18)
  bl MoveCursorR16X

  ;Load Value of Option
  lis r16, 0x8057
  addi r18, r16, 0x7B2F
  lbz r17, 0(r18)
  bl RenderOptionR17On

  bl SelectedOption

  bl GetNewButtonPressesToR16

  andi. r19, r16, 960
  ;r19 is dpad button presses isolated.  

  cmpwi r19, 0
  bgtl ProcessDpadOptions

  bl StoreCurrentInput 

  b Exit

RenderSXSaveMessage:
  ;r10 contains address to start of our message.
  lwz r21, 0x28(r10)

  ;Start by rendering a blank screen
  mr r20, r21

  bl GetNewButtonPressesToR16
  
  bl StoreCurrentInput 
 
  b Exit

ProcessDpadOptions:
  mflr r15
  ;r19 is dpad buttons pressed

  ;Check for Dpad Up
  andi. r16, r19, 64
  cmpwi r16, 64
  beql DpadUpOptions

  ;Check for Dpad Down
  andi. r16, r19, 128
  cmpwi r16, 128
  beql DpadDownOptions

  ;Check for Dpad Left
  andi. r16, r19, 256
  cmpwi r16, 256
  beql DpadLeftOptions

  ;Check for Dpad Right
  andi. r16, r19, 512
  cmpwi r16, 512
  beql DpadRightOptions

  mtlr r15
  li r15, 0
  blr

DpadUpOptions:
  mflr r14

  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)
  ;r16 is now the current options index
  cmpwi r16, 0
  bgtl MoveOptionUp

  mtlr r14
  li r14, 0
  blr

MoveOptionUp:
  mflr r17
 
  subi r16, r16, 1
  sth r16, 0(r18)  

  mtlr r17
  li r17, 0
  blr

DpadDownOptions:
  mflr r14

  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)
  ;r16 is now the current options index
  cmpwi r16, 3
  bltl MoveOptionDown

  mtlr r14
  li r14, 0
  blr

MoveOptionDown:
  mflr r17
 
  addi r16, r16, 1
  sth r16, 0(r18)  

  mtlr r17
  li r17, 0
  blr

DpadLeftOptions:
  mflr r14

  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)
  ;r16 is now the current options index

  lis r17, 0x8057
  addi r17, r17, 0x7B2C
  add r17, r17, r16
  ;r17 is now the selected option

  ;Turn Option On
  li r16, 1
  stb r16, 0(r17)

  mtlr r14
  li r14, 0
  blr

DpadRightOptions:
  mflr r14

  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)
  ;r16 is now the current options index

  lis r17, 0x8057
  addi r17, r17, 0x7B2C
  add r17, r17, r16
  ;r17 is now the selected option

  ;Turn Option Off
  li r16, 0
  stb r16, 0(r17)

  mtlr r14
  li r14, 0
  blr

RenderOptionR17On:
  mflr r14

  ; +On +Off
  lis r16, 0x20 ;Space before

  cmpwi r17, 1
  beql SelectedCharacter
  bnel UnselectedCharacter

  bl RenderR16R21
  	lis r16, 0x4f
  addi r16, r16, 0x6e
  bl RenderR16R21

  lis r16, 0x20 ;Space between

  cmpwi r17, 0
  beql SelectedCharacter
  bnel UnselectedCharacter

  bl RenderR16R21
  	lis r16, 0x4f
  addi r16, r16, 0x66
  bl RenderR16R21
  	lis r16, 0x66
  addi r16, r16, 0x0A
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

SelectedCharacter:
  mflr r15
  addi r16, r16, 0x2b
  mtlr r15
  li r15, 0
  blr

UnselectedCharacter:
  mflr r15
  addi r16, r16, 0x20
  mtlr r15
  li r15, 0
  blr

SelectedOption:
  mflr r14

  lis r18, 0x8057
  ori r18, r18, 0xD8F4

  lhz r16, 0(18)
  mr r17, r16
  
  ;Load Option Offset
  lis r16, 0x8057
  ori r18, r16, 0xFB80
  lbz r16, 0(r18)
  add r21, r20, r16

  li r16, 0
  cmpwi r17, 0
  beql SelectedCharacter
  bnel UnselectedCharacter
  sth r16, 0(r21)

  ;Load Option Offset
  lis r16, 0x8057
  ori r18, r16, 0xFB80
  lbz r16, 1(r18)
  add r21, r20, r16

  li r16, 0
  cmpwi r17, 1
  beql SelectedCharacter
  bnel UnselectedCharacter
  sth r16, 0(r21)

  ;Load Option Offset
  lis r16, 0x8057
  ori r18, r16, 0xFB80
  lbz r16, 2(r18)
  add r21, r20, r16

  li r16, 0
  cmpwi r17, 2
  beql SelectedCharacter
  bnel UnselectedCharacter
  sth r16, 0(r21)

  ;Load Option Offset
  lis r16, 0x8057
  ori r18, r16, 0xFB80
  lbz r16, 3(r18)
  add r21, r20, r16

  li r16, 0
  cmpwi r17, 3
  beql SelectedCharacter
  bnel UnselectedCharacter
  sth r16, 0(r21)

  mtlr r14
  li r14, 0
  blr

MoveCursorR16X:
  ;Use Saved start
  add r21, r20, r16
  blr

RenderR16R21: 
  mflr r15
  stw r16, 0(r21)
  addi r21, r21, 4
  mtlr r15
  li r15, 0
  blr 

Exit:
  ;Restore LR before exiting
  mtlr r22

End:
  li r14, 0x0
  li r15, 0x0
  li r16, 0x0
  li r17, 0x0
  li r18, 0x0
  li r19, 0x0
  li r20, 0x0
  li r21, 0x0
  li r22, 0x0
  ;Original Code
  lis r5, 0x8057




