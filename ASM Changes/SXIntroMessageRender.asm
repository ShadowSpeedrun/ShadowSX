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
  cmpwi r16, 3
  beq RenderSXOptions
  cmpwi r16, 4
  beq RenderSXOptions2
  cmpwi r16, 5
  beq RenderSXOptions3
  cmpwi r16, 6
  beq RenderSXOptions4
  
  ;If somehow past here, set to final index and retry.
  li r16, 6
  sth r16, 0(r18)
  b RenderSXIntro

RenderSXStart:
  ;r10 contains address to start of our message.
  lwz r21, 0(r10)

  ;Start by rendering a blank screen
  mr r20, r21
  
  bl GetNewButtonPressesToR16

  andi. r18, r16, 32
  ;r18 is z button press isolated.
  
  cmpwi r18, 32
  bne StoreCurrentInputAndExit

  ;Set Screen to Options if Z is pressed.
  li r19, 3
  lis r18, 0x8057
  ori r18, r18, 0xD8FA
  sth r19, 0(r18)
 
  b StoreCurrentInputAndExit

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
  ;r16 is currently the value of the page offset.
  ;Page 1 starts at index 3
  
  ;rx = (0x14 * Page Number)
  mulli r16, r16, 0x14
  lwzx r21, r10, r16

  ;Start by rendering a blank screen
  mr r20, r21

  li r19, 0
  lis r16, 0x8057
  addi r17, r16, 0x7B2C
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  li r19, 1
  lis r16, 0x8057
  addi r17, r16, 0x7B2D
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  li r19, 2
  lis r16, 0x8057
  addi r17, r16, 0x7B2E
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  li r19, 3
  lis r16, 0x8057
  addi r17, r16, 0x7B2F
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  li r19, 4
  lis r16, 0x8057
  addi r17, r16, 0x7B30
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  bl SelectedOption

  bl GetNewButtonPressesToR16

  andi. r19, r16, 0x33C0
  ;r19 is dpad button presses isolated.  

  cmpwi r19, 0
  bgtl ProcessButtonOptions

  b StoreCurrentInputAndExit

RenderSXOptions2:
  ;r10 contains address to start of our message.
  ;r16 is currently the value of the page offset.
  ;Page 1 starts at index 3
  
  ;rx = (0x14 * Page Number)
  mulli r16, r16, 0x14
  lwzx r21, r10, r16

  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)

  cmpwi r16, 3
  ble BeginSXOptions2

  li r16, 3
  sth r16, 0(r18)

  BeginSXOptions2:
  ;Start by rendering a blank screen
  mr r20, r21

  li r19, 0
  lis r16, 0x8057
  ori r17, r16, 0xFBA0
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  li r19, 1
  lis r16, 0x8057
  ori r17, r16, 0xFBA1
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  li r19, 2
  lis r16, 0x8057
  ori r17, r16, 0xFBA2
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  li r19, 3
  lis r16, 0x8057
  ori r17, r16, 0xFBA3
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  bl SelectedOption

  bl GetNewButtonPressesToR16

  andi. r19, r16, 0x33C0
  ;r19 is dpad button presses isolated.  

  cmpwi r19, 0
  bgtl ProcessButtonOptions

  b StoreCurrentInputAndExit

RenderSXOptions3:
  ;r10 contains address to start of our message.
  ;r16 is currently the value of the page offset.
  ;Page 1 starts at index 3
  
  ;rx = (0x14 * Page Number)
  mulli r16, r16, 0x14
  lwzx r21, r10, r16

  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)

  cmpwi r16, 2
  ble BeginSXOptions3

  li r16, 2
  sth r16, 0(r18)

  BeginSXOptions3:
  ;Start by rendering a blank screen
  mr r20, r21

  li r19, 0
  lis r16, 0x8057
  ori r17, r16, 0xFBA0
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  li r19, 1
  lis r16, 0x8057
  ori r17, r16, 0xFBA1
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  li r19, 2
  lis r16, 0x8057
  ori r17, r16, 0xFBA2
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  bl SelectedOption

  bl GetNewButtonPressesToR16

  andi. r19, r16, 0x33C0
  ;r19 is dpad button presses isolated.  

  cmpwi r19, 0
  bgtl ProcessButtonOptions

  b StoreCurrentInputAndExit

RenderSXOptions4:
  ;r10 contains address to start of our message.
  ;r16 is currently the value of the page offset.
  ;Page 1 starts at index 3
  
  ;rx = (0x14 * Page Number)
  mulli r16, r16, 0x14
  lwzx r21, r10, r16

  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)

  cmpwi r16, 2
  ble BeginSXOptions4

  li r16, 2
  sth r16, 0(r18)

  BeginSXOptions4:
  ;Start by rendering a blank screen
  mr r20, r21

  li r19, 0
  lis r16, 0x8057
  ori r17, r16, 0xFBA0
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  li r19, 1
  lis r16, 0x8057
  ori r17, r16, 0xFBA1
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  li r19, 2
  lis r16, 0x8057
  ori r17, r16, 0xFBA2
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  bl SelectedOption

  bl GetNewButtonPressesToR16

  andi. r19, r16, 0x33C0
  ;r19 is dpad button presses isolated.  

  cmpwi r19, 0
  bgtl ProcessButtonOptions

  b StoreCurrentInputAndExit

RenderOptionR17ToPosR19:
  mflr r14

  ;r19 = position on screen
  lis r16, 0x8057
  ori r18, r16, 0xFB80
  ;Multiply by 2 for halfword then offset by 10 bytes
  mulli r19, r19, 2
  addi r19, r19, 10
  
  lhzx r16, r18, r19
  add r21, r20, r16 ;MoveCursorR16X

  ;Load address to Options into r19
  lwz r19, 0x28(r10)
  cmpwi r17, 0 ; Render "Off"  
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 1 ; Render "On"
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 2 ; Render "No Change"
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 3 ; Render "Unlock"
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 4 ; Render "Remove"
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 5 ; Render "Level 1"
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 6 ; Render "Level 2"
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 7 ; Render "No"
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 8 ; Render "Yes"
  beql RenderOptionText
 
  b ReturnR14BLR  

RenderOptionText:
  mflr r15

  RenderTextLoop:
    lhz r16, 0(r19) ;Get Character data to write
    cmpwi r16, 0x0A; Check if we are writing a newline.    
    sth r16, 0(r21) ;Write Character Data to Message
    addi r21, r21, 2
    addi r19, r19, 2
    bne RenderTextLoop  

  b ReturnR15BLR

RenderSXSaveMessage:
  ;r10 contains address to start of our message.
  lwz r21, 0x28(r10)

  ;Start by rendering a blank screen
  mr r20, r21

  bl GetNewButtonPressesToR16
  
  b StoreCurrentInputAndExit

ProcessButtonOptions:
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

  ;Check for L Button
  andi. r16, r19, 4096
  cmpwi r16, 4096
  beql LButtonOptions

  ;Check for R Button
  andi. r16, r19, 8192
  cmpwi r16, 8192
  beql RButtonOptions

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
  cmpwi r16, 4
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

  ;Check which screen to show
  lis r18, 0x8057
  ori r18, r18, 0xD8FA
  lhz r18, 0(r18)
  cmpwi r18, 3
  beq Page1DLeftCommand
  cmpwi r18, 4
  beq Page2DLeftCommand

  Page1DLeftCommand:
    lis r17, 0x8057
    addi r17, r17, 0x7B2C
    add r17, r17, r16
    ;r17 is now the selected option
    
    lbz r16, 0(r17)
    cmpwi r16, 0
    bgt DecrementOption
    b ReturnR15BLR

  Page2DLeftCommand:
    lis r17, 0x8057
    ori r17, r17, 0xFBA0
    add r17, r17, r16
    ;r17 is now the selected option
    
    lbz r16, 0(r17)
    cmpwi r16, 2
    beq ReturnR15BLR

  DecrementOption:    
    subi r16, r16, 1; Decrement to next option.
    stb r16, 0(r17)

  b ReturnR15BLR 

DpadRightOptions:
  mflr r15

  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)
  ;r16 is now the current options index

  ;Check which screen to show
  lis r18, 0x8057
  ori r18, r18, 0xD8FA
  lhz r18, 0(r18)
  cmpwi r18, 3
  beq Page1DRightCommand
  cmpwi r18, 4
  beq Page2DRightCommand

  Page1DRightCommand:
    lis r17, 0x8057
    addi r17, r17, 0x7B2C
    add r17, r17, r16
    ;r17 is now the selected option
    
    lbz r16, 0(r17)
    cmpwi r16, 1
    blt IncrementOption
    b ReturnR15BLR

  Page2DRightCommand:
    lis r17, 0x8057
    ori r17, r17, 0xFBA0
    add r17, r17, r16
    ;r17 is now the selected option
    
    lbz r16, 0(r17)
    cmpwi r16, 4
    beq ReturnR15BLR

  IncrementOption:    
    addi r16, r16, 1; Increment to next option.
    stb r16, 0(r17)

  b ReturnR15BLR 

LButtonOptions:
  mflr r15

  lis r18, 0x8057
  ori r18, r18, 0xD8FA
  lhz r16, 0(r18) ;Load Screen Offset
  cmpwi r16, 3
  beq ReturnR15BLR
  
  subi r16, r16, 1
  sth r16, 0(r18) ;Go Back 1 Page.

  b ReturnR15BLR 

RButtonOptions:
  mflr r15

  lis r18, 0x8057
  ori r18, r18, 0xD8FA
  lhz r16, 0(r18) ;Load Screen Offset
  cmpwi r16, 6
  beq ReturnR15BLR
  
  addi r16, r16, 1
  sth r16, 0(r18) ;Go Forward 1 Page.

  b ReturnR15BLR 

SelectedOption:
  mflr r14
  
  ;Load value for current menu option
  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)

  ;Multiply r16 by 2 since r19 will be as well later on.
  mulli r17, r16, 2  
  
  li r19, 0
  bl CheckOptionR19Selected
  
  li r19, 1
  bl CheckOptionR19Selected

  li r19, 2
  bl CheckOptionR19Selected

  li r19, 3
  bl CheckOptionR19Selected

  li r19, 4
  bl CheckOptionR19Selected

  b ReturnR14BLR

CheckOptionR19Selected:
  mflr r15

  ;Load Option Offset
  lis r16, 0x8057
  ori r18, r16, 0xFB80

  ;Multiply index by 2 for halfword size
  mulli r19, r19, 2

  lhzx r16, r18, r19
  add r21, r20, r16

  li r16, 0x20
  cmpw r17, r19
  bne EndCheckOption
  
  ;Make the it a selected character if not branched past  
  addi r16, r16, 0x0b

  EndCheckOption:
  sth r16, 0(r21)
  b ReturnR15BLR

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




