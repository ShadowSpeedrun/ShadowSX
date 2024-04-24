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
 
  b StoreCurrentInputAndExit

ScreenToOptionsR19:
  lis r18, 0x8057
  ori r18, r18, 0xD8FA

  sth r19, 0(r18)

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


StoreCurrentInputAndExit:
  ;Load the value of "P1 Button State" into r19.(8056ED4C)
  lis r18, 0x8056
  ori r18, r18, 0xED4C
  lwz r19, 0(r18)

  ;Load address for input save
  lis r18, 0x8057
  ori r18, r18, 0xD8F6
  stw r19, 0(r18)
  b Exit

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

  b StoreCurrentInputAndExit

RenderSXSaveMessage:
  ;r10 contains address to start of our message.
  lwz r21, 0x28(r10)

  ;Start by rendering a blank screen
  mr r20, r21

  bl GetNewButtonPressesToR16
  
  b StoreCurrentInputAndExit

ProcessDpadOptions:
  mflr r14
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

  b ReturnR14BLR 

DpadUpOptions:
  mflr r15

  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)
  ;r16 is now the current options index
  cmpwi r16, 0
  beq ReturnR15BLR

  subi r16, r16, 1
  sth r16, 0(r18)
  b ReturnR15BLR 

DpadDownOptions:
  mflr r15

  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)
  ;r16 is now the current options index
  cmpwi r16, 3
  beq ReturnR15BLR

  addi r16, r16, 1
  sth r16, 0(r18)  

  b ReturnR15BLR 

DpadLeftOptions:
  mflr r15

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

  b ReturnR15BLR 

DpadRightOptions:
  mflr r15

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

  b ReturnR15BLR 

RenderOptionR17On:
  mflr r14

  ; +On +Off
  lis r16, 0x20 ;Space before
  addi r16, r16, 0x20 ;Default to Space for unselected

  cmpwi r17, 1
  beql SpaceToCrossCharacter 

  bl RenderR16R21
  	lis r16, 0x4f
  addi r16, r16, 0x6e
  bl RenderR16R21

  lis r16, 0x20 ;Space before
  addi r16, r16, 0x20 ;Default to Space for unselected

  cmpwi r17, 0
  beql SpaceToCrossCharacter 

  bl RenderR16R21
  	lis r16, 0x4f
  addi r16, r16, 0x66
  bl RenderR16R21
  	lis r16, 0x66
  addi r16, r16, 0x0A
  bl RenderR16R21

  b ReturnR14BLR 

SpaceToCrossCharacter:
  mflr r15
  addi r16, r16, 0x0b
  b ReturnR15BLR

SelectedOption:
  mflr r14

  lis r18, 0x8057
  ori r18, r18, 0xD8F4

  lhz r16, 0(18)
  mr r17, r16
  
  li r19, 0
  bl CheckOptionR19Selected
  
  li r19, 1
  bl CheckOptionR19Selected

  li r19, 2
  bl CheckOptionR19Selected

  li r19, 3
  bl CheckOptionR19Selected

  b ReturnR14BLR

CheckOptionR19Selected:
  mflr r15

  ;Load Option Offset
  lis r16, 0x8057
  ori r18, r16, 0xFB80
  lbzx r16, r18, r19
  add r21, r20, r16

  li r16, 0x20
  cmpw r17, r19
  bne EndCheckOption
  
  ;Make the it a selected character if not branched past  
  addi r16, r16, 0x0b

EndCheckOption:
  sth r16, 0(r21)
  b ReturnR15BLR

MoveCursorR16X:
  ;Use Saved start
  add r21, r20, r16
  blr

RenderR16R21: 
  mflr r15
  stw r16, 0(r21)
  addi r21, r21, 4
  b ReturnR15BLR

ReturnR14BLR:
  mtlr r14
  li r14, 0
  blr

ReturnR15BLR:
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




