#To be inserted at 8004a47c
;save LR to restore later
mflr r22

;r10 contains address to start of our message.
lwz r21, 0(r10)

cmpwi r11, 1
bne Exit

;Check for if we are rendering blank message(8057D8FD = 44)
lis r18, 0x807D
addi r18, r18, 0x5700
lwz r16, 0(r18)
cmpwi r16, 44
beq RenderSXIntro
bne Exit

BlankScreen:
 mflr r14  

  bl BlankScreenLine
  bl BlankScreenLine
  bl BlankScreenLine
  bl BlankScreenLine
  bl BlankScreenLine
  bl BlankScreenLine
  bl BlankScreenLine
  bl BlankScreenLine
  bl BlankScreenLine

  mtlr r14
  li r14, 0
  blr

BlankScreenLine:
  lis r16, 0x20
  addi r16, r16, 0x20
  li r17, 0
  b BlankScreenWrite

BlankScreenEnd:
  li r16, 0x20
  sth r16, 0(r21)
  addi r21, r21, 4
  ;Extra shift to skip 0x0a
  blr

BlankScreenLoop:
  cmpwi r17, 21
  blt BlankScreenWrite
  b BlankScreenEnd

BlankScreenWrite:
  stw r16, 0(r21)
  addi r21, r21, 4
  addi r17, r17, 1
  b BlankScreenLoop

RenderSXIntro:
  ;Start by rendering a blank screen
  mr r20, r21
 
  bl BlankScreen
  
  ;Check which screen to show
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6184
  or r18, r16, r17
  lhz r16, 0(r18)
  cmpwi r16, 0
  beq RenderSXStart
  cmpwi r16, 1
  beq RenderSXOptions
  bne RenderSXSaveMessage

RenderSXStart:
  li r16, 26; 13 spaces 2 bytes each
  li r17, 1
  bl MoveCursorR16XR17Y

  bl SXTitle

  li r16, 26; 13 spaces 2 bytes each
  li r17, 2
  bl MoveCursorR16XR17Y

  bl SXSubTitle

  li r16, 10; 5 spaces 2 bytes each
  li r17, 4
  bl MoveCursorR16XR17Y

  bl SXWebsite

  li r16, 26; 13 spaces 2 bytes each
  li r17, 6
  bl MoveCursorR16XR17Y

  bl AtoStart

  li r16, 24; 12 spaces 2 bytes each
  li r17, 8
  bl MoveCursorR16XR17Y

  bl ZforOptions

  bl GetNewButtonPressesToR16

  andi. r18, r16, 32
  ;r18 is z button press isolated.  

  li r19, 1
  cmpwi r18, 32
  beql ScreenToOptionsR19
  
  bl StoreCurrentInput 
 
  b Exit

ScreenToOptionsR19:
  mflr r15

  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6184
  or r18, r16, r17

  sth r19, 0(r18)

  mtlr r15
  li r15, 0
  blr

GetNewButtonPressesToR16:
  ;Load the value of "P1 Button State" into r19.(8056ED4C)
  lis r16, 0x8056
  li r17, 0x7777
  addi r17, r17, 0x75D5
  or r18, r16, r17
  lwz r19, 0(r18)

  ;Load current saved input into r16
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6180
  or r18, r16, r17
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
  lis r16, 0x8056
  li r17, 0x7777
  addi r17, r17, 0x75D5
  or r18, r16, r17
  lwz r19, 0(r18)

  ;Load address for input save
  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x6180
  or r18, r16, r17

  stw r19, 0(r18)
  blr

RenderSXOptions:
  ;0x0A = NewLine
  ;0x20 = Space

  li r16, 26; 13 spaces 2 bytes each
  li r17, 0
  bl MoveCursorR16XR17Y
  bl SXOptionsTitle

  li r16, 12; 6 spaces 2 bytes each
  li r17, 2
  bl MoveCursorR16XR17Y
  bl CSOption

  li r16, 50; 25 spaces 2 bytes each
  li r17, 2
  bl MoveCursorR16XR17Y

  lis r16, 0x8057
  addi r18, r16, 0x7B2C
  lbz r17, 0(r18)
  bl RenderOptionR17On

  li r16, 12; 6 spaces 2 bytes each
  li r17, 3
  bl MoveCursorR16XR17Y
  bl RTOption

  li r16, 50; 25 spaces 2 bytes each
  li r17, 3
  bl MoveCursorR16XR17Y
  lis r16, 0x8057
  addi r18, r16, 0x7B2D
  lbz r17, 0(r18)
  bl RenderOptionR17On

  li r16, 12; 6 spaces 2 bytes each
  li r17, 4
  bl MoveCursorR16XR17Y
  bl MUIOption

  li r16, 50; 25 spaces 2 bytes each
  li r17, 4
  bl MoveCursorR16XR17Y
  lis r16, 0x8057
  addi r18, r16, 0x7B2E
  lbz r17, 0(r18)
  bl RenderOptionR17On

  li r16, 14; 7 spaces 2 bytes each
  li r17, 6
  bl MoveCursorR16XR17Y
  bl DpadSelectText

  li r16, 10; 5 spaces 2 bytes each
  li r17, 7
  bl MoveCursorR16XR17Y
  bl DpadChangeText

  li r16, 26; 13 spaces 2 bytes each
  li r17, 8
  bl MoveCursorR16XR17Y
  bl AtoStart

  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x617E 
  or r18, r17, r16
  lhz r16, 0(18)
  bl SelectedOptionR16  

  bl GetNewButtonPressesToR16

  andi. r19, r16, 960
  ;r19 is dpad button presses isolated.  

  cmpwi r19, 0
  bgtl ProcessDpadOptions

  bl StoreCurrentInput 

  b Exit

RenderSXSaveMessage:
  li r16, 26; 13 spaces 2 bytes each
  li r17, 0
  bl MoveCursorR16XR17Y
  bl SXOptionsTitle

  li r16, 16; 8 spaces 2 bytes each
  li r17, 2
  bl MoveCursorR16XR17Y
  bl SXOptionSave1

  li r16, 16; 8 spaces 2 bytes each
  li r17, 3
  bl MoveCursorR16XR17Y
  bl SXOptionSave2

  li r16, 6; 6 spaces 2 bytes each
  li r17, 5
  bl MoveCursorR16XR17Y
  bl SXOptionSave3

  ;One position back because too lazy to remove space
  li r16, 6; 3 spaces 2 bytes each
  li r17, 6
  bl MoveCursorR16XR17Y
  bl SXOptionSave4

  li r16, 28; 14 spaces 2 bytes each
  li r17, 8
  bl MoveCursorR16XR17Y
  bl AtoStart

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

  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x617E
  or r18, r16, r17
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

  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x617E
  or r18, r16, r17
  lhz r16, 0(r18)
  ;r16 is now the current options index
  cmpwi r16, 2
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

  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x617E
  or r18, r16, r17
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

  lis r16, 0x8057
  li r17, 0x7777
  addi r17, r17, 0x617E
  or r18, r16, r17
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

SXTitle:
  mflr r14

  ;Shadow SX Beta V4
  	lis r16, 0x53
  addi r16, r16, 0x68
  bl RenderR16R21
  	lis r16, 0x61
  addi r16, r16, 0x64
  bl RenderR16R21
  	lis r16, 0x6F
  addi r16, r16, 0x77
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x53
  bl RenderR16R21
  	lis r16, 0x58
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x42
  addi r16, r16, 0x65
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x61
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x56
  bl RenderR16R21
  	lis r16, 0x34
  addi r16, r16, 0x20  
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

SXSubTitle:
  mflr r14

  ;Speedrunners's Cut
        lis r16, 0x53
  addi r16, r16, 0x70
  bl RenderR16R21
        lis r16, 0x65
  addi r16, r16, 0x65
  bl RenderR16R21
  	lis r16, 0x64
  addi r16, r16, 0x72
  bl RenderR16R21
  	lis r16, 0x75
  addi r16, r16, 0x6E
  bl RenderR16R21
  	lis r16, 0x6E
  addi r16, r16, 0x65
  bl RenderR16R21
  	lis r16, 0x72
  addi r16, r16, 0x27
  bl RenderR16R21
  	lis r16, 0x73
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x43
  addi r16, r16, 0x75
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x20  
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

SXWebsite:
  mflr r14

  ;www.shadowspeedrun.com/ShadowSX
  	lis r16, 0x77
  addi r16, r16, 0x77
  bl RenderR16R21
  	lis r16, 0x77
  addi r16, r16, 0x2e
  bl RenderR16R21
  	lis r16, 0x73
  addi r16, r16, 0x68
  bl RenderR16R21
  	lis r16, 0x61
  addi r16, r16, 0x64
  bl RenderR16R21
  	lis r16, 0x6f
  addi r16, r16, 0x77
  bl RenderR16R21
  	lis r16, 0x73
  addi r16, r16, 0x70
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x65
  bl RenderR16R21
  	lis r16, 0x64
  addi r16, r16, 0x72
  bl RenderR16R21
  	lis r16, 0x75
  addi r16, r16, 0x6e
  bl RenderR16R21
  	lis r16, 0x2e
  addi r16, r16, 0x63
  bl RenderR16R21
  	lis r16, 0x6f
  addi r16, r16, 0x6d
  bl RenderR16R21
  	lis r16, 0x2f
  addi r16, r16, 0x53
  bl RenderR16R21
  	lis r16, 0x68
  addi r16, r16, 0x61
  bl RenderR16R21
  	lis r16, 0x64
  addi r16, r16, 0x6f
  bl RenderR16R21
  	lis r16, 0x77
  addi r16, r16, 0x53
  bl RenderR16R21
  	lis r16, 0x58
  addi r16, r16, 0x20
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

AtoStart:
  mflr r14

  ;Press A to Start
  	lis r16, 0x50
  addi r16, r16, 0x72
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x73
  bl RenderR16R21
  	lis r16, 0x73
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x41
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x6f
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x53
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x61
  bl RenderR16R21
  	lis r16, 0x72
  addi r16, r16, 0x74
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

ZforOptions:
  mflr r14

  ;Press z for Options
  ;lowercase to avoid swapping out txd for now.
  	lis r16, 0x50
  addi r16, r16, 0x72
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x73
  bl RenderR16R21
  	lis r16, 0x73
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x7a
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x66
  addi r16, r16, 0x6f
  bl RenderR16R21
  	lis r16, 0x72
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x4f
  addi r16, r16, 0x70
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x69
  bl RenderR16R21
  	lis r16, 0x6f
  addi r16, r16, 0x6e
  bl RenderR16R21
  	lis r16, 0x73
  addi r16, r16, 0x20
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

SXOptionsTitle:
  mflr r14

  ;Shadow SX Options
  	lis r16, 0x53
  addi r16, r16, 0x68
  bl RenderR16R21
  	lis r16, 0x61
  addi r16, r16, 0x64
  bl RenderR16R21
  	lis r16, 0x6F
  addi r16, r16, 0x77
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x53
  bl RenderR16R21
  	lis r16, 0x58
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x4f
  addi r16, r16, 0x70
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x69
  bl RenderR16R21
  	lis r16, 0x6f
  addi r16, r16, 0x6e
  bl RenderR16R21
  	lis r16, 0x73
  addi r16, r16, 0x20  
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

CSOption:
  mflr r14

  ;Cutscene Skip

  	lis r16, 0x20
  addi r16, r16, 0x43
  bl RenderR16R21
  	lis r16, 0x75
  addi r16, r16, 0x74
  bl RenderR16R21
  	lis r16, 0x73
  addi r16, r16, 0x63
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x6e
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x53
  addi r16, r16, 0x6b
  bl RenderR16R21
  	lis r16, 0x69
  addi r16, r16, 0x70
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

RTOption:
  mflr r14

  ;Race Timer

  	lis r16, 0x20
  addi r16, r16, 0x52
  bl RenderR16R21
  	lis r16, 0x61
  addi r16, r16, 0x63
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x54
  addi r16, r16, 0x69
  bl RenderR16R21
  	lis r16, 0x6d
  addi r16, r16, 0x65
  bl RenderR16R21
    	lis r16, 0x72
  addi r16, r16, 0x20
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

MUIOption:
  mflr r14

  ;Modern UI Control

  	lis r16, 0x20
  addi r16, r16, 0x4d
  bl RenderR16R21
  	lis r16, 0x6f
  addi r16, r16, 0x64
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x72
  bl RenderR16R21
  	lis r16, 0x6e
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x55
  addi r16, r16, 0x49
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x43
  bl RenderR16R21
  	lis r16, 0x6f
  addi r16, r16, 0x6e
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x72
  bl RenderR16R21
  	lis r16, 0x6f
  addi r16, r16, 0x6c
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

RenderOptionR17On:
  mflr r14

  ;- +On +Off
  	lis r16, 0x2d
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x20
  ;addi r16, r16, 0x2b

  cmpwi r17, 1
  beql SelectedCharacter
  bnel UnselectedCharacter

  bl RenderR16R21
  	lis r16, 0x4f
  addi r16, r16, 0x6e
  bl RenderR16R21
  	lis r16, 0x20
  ;addi r16, r16, 0x2b

  cmpwi r17, 0
  beql SelectedCharacter
  bnel UnselectedCharacter

  bl RenderR16R21
  	lis r16, 0x4f
  addi r16, r16, 0x66
  bl RenderR16R21
  	lis r16, 0x66
  addi r16, r16, 0x20
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

DpadSelectText:
  mflr r14

  ;Dpad Up Down to select Option
  	lis r16, 0x44
  addi r16, r16, 0x70
  bl RenderR16R21
  	lis r16, 0x61
  addi r16, r16, 0x64
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x55
  bl RenderR16R21
  	lis r16, 0x70
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x44
  addi r16, r16, 0x6f
  bl RenderR16R21
  	lis r16, 0x77
  addi r16, r16, 0x6e
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x74
  bl RenderR16R21
  	lis r16, 0x6f
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x73
  addi r16, r16, 0x65
  bl RenderR16R21
  	lis r16, 0x6c
  addi r16, r16, 0x65
  bl RenderR16R21
  	lis r16, 0x63
  addi r16, r16, 0x74
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x4f
  bl RenderR16R21
  	lis r16, 0x70
  addi r16, r16, 0x74
  bl RenderR16R21
  	lis r16, 0x69
  addi r16, r16, 0x6f
  bl RenderR16R21
  	lis r16, 0x6e
  addi r16, r16, 0x20
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

DpadChangeText:
  mflr r14

  ;Dpad Up Down to select Option
  	lis r16, 0x44
  addi r16, r16, 0x70
  bl RenderR16R21
  	lis r16, 0x61
  addi r16, r16, 0x64
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x4c
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x66
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x52
  addi r16, r16, 0x69
  bl RenderR16R21
  	lis r16, 0x67
  addi r16, r16, 0x68
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x6f
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x63
  bl RenderR16R21
  	lis r16, 0x68
  addi r16, r16, 0x61
  bl RenderR16R21
  	lis r16, 0x6e
  addi r16, r16, 0x67
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x4f
  addi r16, r16, 0x70
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x69
  bl RenderR16R21
  	lis r16, 0x6f
  addi r16, r16, 0x6e
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

SelectedOptionR16:
  mflr r14
  mr r17, r16 
  li r16, 12 ;6 spaces 2 bytes each
  addi r17, r17, 2
  
  add r21, r20, r16
  mulli r16, r17, 88 ;43 character, 1 newline
  add r21, r21, r16

  li r16, 0x2b
  sth r16, 0(r21)
  addi r21, r21, 2
  mtlr r14
  li r14, 0
  blr

MoveCursorR16XR17Y:
  ;Use Saved start
  add r21, r20, r16
  mulli r16, r17, 88 ;43 character, 1 newline
  add r21, r21, r16
  blr

RenderR16R21: 
  mflr r15
  stw r16, 0(r21)
  addi r21, r21, 4
  mtlr r15
  li r15, 0
  blr 

SXOptionSave1:
  mflr r14

  ;Changes will be saved to the
  	lis r16, 0x43
  addi r16, r16, 0x68
  bl RenderR16R21
  	lis r16, 0x61
  addi r16, r16, 0x6e
  bl RenderR16R21
  	lis r16, 0x67
  addi r16, r16, 0x65
  bl RenderR16R21
  	lis r16, 0x73
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x77
  addi r16, r16, 0x69
  bl RenderR16R21
  	lis r16, 0x6c
  addi r16, r16, 0x6c
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x62
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x73
  addi r16, r16, 0x61
  bl RenderR16R21
  	lis r16, 0x76
  addi r16, r16, 0x65
  bl RenderR16R21
  	lis r16, 0x64
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x6f
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x74
  bl RenderR16R21
  	lis r16, 0x68
  addi r16, r16, 0x65
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

SXOptionSave2:
  mflr r14

  ;memory card on next game save
  	lis r16, 0x6d
  addi r16, r16, 0x65
  bl RenderR16R21
  	lis r16, 0x6d
  addi r16, r16, 0x6f
  bl RenderR16R21
  	lis r16, 0x72
  addi r16, r16, 0x79
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x63
  bl RenderR16R21
  	lis r16, 0x61
  addi r16, r16, 0x72
  bl RenderR16R21
  	lis r16, 0x64
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x6f
  addi r16, r16, 0x6e
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x6e
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x78
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x67
  addi r16, r16, 0x61
  bl RenderR16R21
  	lis r16, 0x6d
  addi r16, r16, 0x65
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x73
  bl RenderR16R21
  	lis r16, 0x61
  addi r16, r16, 0x76
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x20
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

SXOptionSave3:
  mflr r14

  ;A quick way to force a save is to enter
  	lis r16, 0x41
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x71
  addi r16, r16, 0x75
  bl RenderR16R21
  	lis r16, 0x69
  addi r16, r16, 0x63
  bl RenderR16R21
  	lis r16, 0x6b
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x77
  addi r16, r16, 0x61
  bl RenderR16R21
  	lis r16, 0x79
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x6f
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x66
  bl RenderR16R21
  	lis r16, 0x6f
  addi r16, r16, 0x72
  bl RenderR16R21
  	lis r16, 0x63
  addi r16, r16, 0x65
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x61
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x73
  bl RenderR16R21
  	lis r16, 0x61
  addi r16, r16, 0x76
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x69
  addi r16, r16, 0x73
  bl RenderR16R21
 	lis r16, 0x20
  addi r16, r16, 0x74
  bl RenderR16R21
  	lis r16, 0x6f
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x6e
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x65
  bl RenderR16R21
  	lis r16, 0x72
  addi r16, r16, 0x20
  bl RenderR16R21

  mtlr r14
  li r14, 0
  blr

SXOptionSave4:
  mflr r14

  ;and exit the main menu options menu.
  	lis r16, 0x20
  addi r16, r16, 0x61
  bl RenderR16R21
  	lis r16, 0x6e
  addi r16, r16, 0x64
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x65
  bl RenderR16R21
  	lis r16, 0x78
  addi r16, r16, 0x69
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x68
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x6d
  addi r16, r16, 0x61
  bl RenderR16R21
  	lis r16, 0x69
  addi r16, r16, 0x6e
  bl RenderR16R21
  	lis r16, 0x20
  addi r16, r16, 0x6d
  bl RenderR16R21
  	lis r16, 0x65
  addi r16, r16, 0x6e
  bl RenderR16R21
  	lis r16, 0x75
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x6f
  addi r16, r16, 0x70
  bl RenderR16R21
  	lis r16, 0x74
  addi r16, r16, 0x69
  bl RenderR16R21
  	lis r16, 0x6f
  addi r16, r16, 0x6e
  bl RenderR16R21
  	lis r16, 0x73
  addi r16, r16, 0x20
  bl RenderR16R21
  	lis r16, 0x6d
  addi r16, r16, 0x65
  bl RenderR16R21
  	lis r16, 0x6e
  addi r16, r16, 0x75
  bl RenderR16R21
  	lis r16, 0x2e
  addi r16, r16, 0x20
  bl RenderR16R21

  mtlr r14
  li r14, 0
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




