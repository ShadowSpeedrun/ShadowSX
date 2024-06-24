#8004a47c
#SXIntroMessageRender.asm

Start:
  #save LR to restore later
  mflr r22
  
  #Check if we are trying to render a option text
  #If so, skip to the end.
  cmpwi r11, 1
  bne Exit
  
  #Check for if we are rendering blank message(807D5700 = 44)
  lis r18, 0x807D
  addi r18, r18, 0x5700
  lwz r16, 0(r18)
  cmpwi r16, 44
  beq RenderSXIntro
  bne Exit

RenderSXIntro:  
  #Check which screen to show
  lis r18, 0x8057
  ori r18, r18, 0xD8FA
  
  lhz r16, 0(r18)
  cmpwi r16, 0
  beq RenderSXStart
  cmpwi r16, 1
  beq RenderSXSaveMessage
  cmpwi r16, 3
  beq SetupPage1SXOptions
  cmpwi r16, 4
  beq SetupPage2SXOptions
  cmpwi r16, 5
  beq SetupPage3SXOptions
  cmpwi r16, 6
  beq SetupPage4SXOptions
  
  #If somehow past here, set to final index and retry.
  li r16, 6
  sth r16, 0(r18)
  b RenderSXIntro

RenderSXStart:
  #First, ensure save data values are set up.
  #Set r18 to start of flag data.
  lis r18, 0x8057
  ori r18, r18, 0x7B2C

  CheckCSSkip:
    #Load location for CSSkip flag
    lbz r19, 0(r18)

    #If not 0, or 1
    #assign 1 by default.
    cmpwi r19, 0
    beq CheckRT
    cmpwi r19, 1
    beq CheckRT
    li r19, 1
    stb r19, 0(r18)

  CheckRT:
    #Load location for Race Time flag
    lbz r19, 1(r18)

    #If not 0, or 1
    #assign 0 by default.

    cmpwi r19, 0
    beq CheckMUI
    cmpwi r19, 1
    beq CheckMUI
    li r19, 0
    stb r19, 1(r18)

  CheckMUI:
    #Load location for Modern UI Control flag
    lbz r19, 2(r18)

    #If not 0, or 1
    #assign 0 by default.

    cmpwi r19, 0
    beq CheckSPWDisable
    cmpwi r19, 1
    beq CheckSPWDisable
    li r19, 0
    stb r19, 2(r18)

  CheckSPWDisable:
    #Load location for Disable SPW Unlock flag
    lbz r19, 3(r18)

    #If not 0, or 1
    #assign 0 by default.

    cmpwi r19, 0
    beq CheckKeyDisable
    cmpwi r19, 1
    beq CheckKeyDisable
    li r19, 0
    stb r19, 3(r18)

  CheckKeyDisable:
    #Load location for Disable SPW Unlock flag
    lbz r19, 4(r18)

    #If not 0, or 1
    #assign 0 by default.

    cmpwi r19, 0
    beq StartSXIntroRender
    cmpwi r19, 1
    beq StartSXIntroRender
    li r19, 0
    stb r19, 4(r18)

  StartSXIntroRender:
    #r10 contains address to start of our message.
    lwz r21, 0(r10)

    #Start by rendering a blank screen
    mr r20, r21
  
    bl GetNewButtonPressesToR16

    andi. r18, r16, 32
    #r18 is z button press isolated.
  
    cmpwi r18, 32
    bne StoreCurrentInputAndExit

    #Set Screen to Options if Z is pressed.
    li r19, 3
    lis r18, 0x8057
    ori r18, r18, 0xD8FA
    sth r19, 0(r18)
 
  b StoreCurrentInputAndExit

GetNewButtonPressesToR16:
  #Load the value of "P1 Button State" into r19.(8056ED4C)
  lis r18, 0x8056
  ori r18, r18, 0xED4C
  lwz r19, 0(r18)

  #Load current saved input into r16
  lis r18, 0x8057
  ori r18, r18, 0xD8F6

  lwz r16, 0(r18)
 
  #r19 is current input
  #r16 is last seen input
  xor r16, r16, r19  
  #r16 should be which buttons changed state

  and r16, r19, r16
  #r16 should be which buttons are now pressed.

  blr

StoreCurrentInputAndExit:
  #Load the value of "P1 Button State" into r19.(8056ED4C)
  lis r18, 0x8056
  ori r18, r18, 0xED4C
  lwz r19, 0(r18)

  #Load address for input save
  lis r18, 0x8057
  ori r18, r18, 0xD8F6
  stw r19, 0(r18)
  b Exit

SetupPage1SXOptions:
  #Run logic to get Page 1 values and specify which options are available.
  #8057FBB0 will be used to store theses values for reference later.

  lis r16, 0x8057
  addi r17, r16, 0x7B2C
  ori r18, r16, 0xFBB0

  #r17 = value save address
  #r18 = value to use address

  #Get value for CS Skip
  lbz r16, 0(r17)
  stb r16, 0(r18)
  #Configure avaiable settings for option
  li r16, 0
  stb r16, 5(r18)

  #Get value for Race Mode
  lbz r16, 1(r17)
  stb r16, 1(r18)
  #Configure avaiable settings for option
  li r16, 0
  stb r16, 6(r18)

  #Get value for Modern UI Control
  lbz r16, 2(r17)
  stb r16, 2(r18)
  #Configure avaiable settings for option
  li r16, 0
  stb r16, 7(r18)

  #Get value for Disable SPW Unlock
  lbz r16, 3(r17)
  stb r16, 3(r18)
  #Configure avaiable settings for option
  li r16, 0
  stb r16, 8(r18)

  #Get value for Disable Key Saving
  lbz r16, 4(r17)
  stb r16, 4(r18)
  #Configure avaiable settings for option
  li r16, 0
  stb r16, 9(r18)
  
  #Set 8057FBBA as the max index for the option selection (0 based)
  li r17, 4
  stb r17, 10(r18)

  b RenderSXOptionsMain

SetupPage2SXOptions:
  #Run logic to get Page 2 values and specify which options are available.
  #8057FBB0 will be used to store theses values for reference later.

  lis r16, 0x8057
  ori r17, r16, 0xFBA0
  ori r18, r16, 0xFBB0

  #r17 = value save address
  #r18 = value to use address

  #Get Value for Unlock Last Story
  lbz r16, 0(r17)
  stb r16, 0(r18)
  #Configure avaiable settings for option
  li r16, 2
  stb r16, 5(r18)

  #Get Value for Unlock Expert Mode
  lbz r16, 1(r17)
  stb r16, 1(r18)
  #Configure avaiable settings for option
  li r16, 2
  stb r16, 6(r18)
  
  #Get Value for Unlock Stages
  lbz r16, 2(r17)
  stb r16, 2(r18)
  #Configure avaiable settings for option
  li r16, 2
  stb r16, 7(r18)
  
  #Get Value for All Keys Action
  lbz r16, 3(r17)
  stb r16, 3(r18)
  #Configure avaiable settings for option
  li r16, 1
  stb r16, 8(r18)
  
  #Set 8057FBBA as the max index for the option selection (0 based)
  li r17, 3
  stb r17, 10(r18)

  b RenderSXOptionsMain

SetupPage3SXOptions:
  #Run logic to get Page 3 values and specify which options are available.
  #8057FBB0 will be used to store theses values for reference later.
  #80578068 = Weapon Unlocked

  lis r16, 0x8057
  ori r17, r16, 0x8068
  ori r18, r16, 0xFBB0

  #r17 = value save address
  #r18 = value to use address
  
  #Get Value for Shadow Rifle
  lhz r16, 0(r17)
  andi. r16, r16, 0x400
  srawi r16, r16, 10 #This should result in either 1 or 0 for Shadow Rifle Status. 
  
  stb r16, 0(r18)
  #Configure avaiable settings for option
  li r16, 0
  stb r16, 5(r18)

  #Get Value for Samurai Blade
  lhz r16, 0(r17) # bits 1 & 2 signify Samurai Blade Unlocks
  andi. r16, r16, 3 #Filter out all other weapon statuses
  cmpwi r16, 0 #Only need to adjust r16 if not 0.
  bnel SPWStatusOptionIndex
  
  stb r16, 1(r18)
  #Configure avaiable settings for option
  li r16, 3
  stb r16, 6(r18)

  #Get Value for Satellite Laser
  lhz r16, 0(r17) # bits 3 & 4 signify Samurai Blade Unlocks
  andi. r16, r16, 0xC #Filter out all other weapon statuses
  srawi r16, r16, 2 #make r16 use the right most bits for weapon status.
  cmpwi r16, 0 #Only need to adjust r16 if not 0.
  bnel SPWStatusOptionIndex
  
  stb r16, 2(r18)
  #Configure avaiable settings for option
  li r16, 3
  stb r16, 7(r18)
  
  #Set 8057FBBA as the max index for the option selection (0 based)
  li r17, 2
  stb r17, 10(r18)

  b RenderSXOptionsMain

SetupPage4SXOptions:
  #Run logic to get Page 4 values and specify which options are available.
  #8057FBB0 will be used to store theses values for reference later.
  #80578068 = Weapon Unlocked

  lis r16, 0x8057
  ori r17, r16, 0x8068
  ori r18, r16, 0xFBB0

  #r17 = value save address
  #r18 = value to use address
  
  #Get Value for Vacuum Egg
  lhz r16, 0(r17) # bits 5 & 6 signify Samurai Blade Unlocks
  andi. r16, r16, 0x30 #Filter out all other weapon statuses
  srawi r16, r16, 4 #make r16 use the right most bits for weapon status.
  cmpwi r16, 0 #Only need to adjust r16 if not 0.
  bnel SPWStatusOptionIndex
  
  stb r16, 0(r18)
  #Configure avaiable settings for option
  li r16, 3
  stb r16, 5(r18)

  #Get Value for Omochao Gun
  lhz r16, 0(r17) # bits 7 & 8 signify Samurai Blade Unlocks
  andi. r16, r16, 0xC0 #Filter out all other weapon statuses
  srawi r16, r16, 6 #make r16 use the right most bits for weapon status.
  cmpwi r16, 0 #Only need to adjust r16 if not 0.
  bnel SPWStatusOptionIndex
  
  stb r16, 1(r18)
  #Configure avaiable settings for option
  li r16, 3
  stb r16, 6(r18)

  #Get Value for Heal Cannon
  lhz r16, 0(r17) # bits 9 & 10 signify Samurai Blade Unlocks
  andi. r16, r16, 0x300 #Filter out all other weapon statuses
  srawi r16, r16, 8 #make r16 use the right most bits for weapon status.
  cmpwi r16, 0 #Only need to adjust r16 if not 0.
  bnel SPWStatusOptionIndex
  
  stb r16, 2(r18)
  #Configure avaiable settings for option
  li r16, 3
  stb r16, 7(r18)
  
  #Set 8057FBBA as the max index for the option selection (0 based)
  li r17, 2
  stb r17, 10(r18)

  b RenderSXOptionsMain

SavePage1SXOptions:
  #Run logic to save Page 1 values.
  #8057FBB0 are the current configured options.
  #80577B2C = Where Memory Card options are saved.

  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  lis r16, 0x8057
  ori r17, r16, 0x7B2C
  ori r18, r16, 0xFBB0

  #r17 = value save address
  #r18 = value to use address

  lbz r16, 0(r18)
  stb r16, 0(r17)  

  lbz r16, 1(r18)
  stb r16, 1(r17)  

  lbz r16, 2(r18)
  stb r16, 2(r17)  

  lbz r16, 3(r18)
  stb r16, 3(r17)  

  lbz r16, 4(r18)
  stb r16, 4(r17)  

  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR  

SavePage2SXOptions:
  #Run logic to save Page 2 values.
  #8057FBB0 are the current configured options.
  #8057FBA0 = Where Page 2 options are saved.

  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  lis r16, 0x8057
  ori r17, r16, 0xFBA0
  ori r18, r16, 0xFBB0

  #r17 = value save address
  #r18 = value to use address

  lbz r16, 0(r18)
  stb r16, 0(r17)  

  lbz r16, 1(r18)
  stb r16, 1(r17)  

  lbz r16, 2(r18)
  stb r16, 2(r17)  

  lbz r16, 3(r18)
  stb r16, 3(r17)  

  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR  

SavePage3SXOptions:
  #Run logic to save Page 3 values.
  #8057FBB0 are the current configured options.
  #80578068 = Weapon Unlocked

  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  lis r16, 0x8057
  ori r17, r16, 0x8068
  ori r18, r16, 0xFBB0

  #r17 = value save address
  #r18 = value to use address
  
  #Set Value for Shadow Rifle
  lbz r16, 0(r18)
  mulli r16, r16, 0x400
  lhz r15, 0(r17)
  andi. r15, r15, 0x3FF #Set to off to start
  or r15, r15, r16
  sth r15, 0(r17)

  #Set Value for Samurai Blade
  lbz r16, 1(r18)
  bl SPWStatusOptionSave
  li r15, 0
  slw r16, r16, r15
  lhz r15, 0(r17)
  andi. r15, r15, 0x7FC #Set to off to start
  or r15, r15, r16
  sth r15, 0(r17)

  #Set Value for Satellite Laser
  lbz r16, 2(r18)
  bl SPWStatusOptionSave
  li r15, 2
  slw r16, r16, r15
  lhz r15, 0(r17)
  andi. r15, r15, 0x7F3 #Set to off to start
  or r15, r15, r16
  sth r15, 0(r17)

  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR

SavePage4SXOptions:
  #Run logic to save Page 4 values.
  #8057FBB0 are the current configured options.
  #80578068 = Weapon Unlocked

  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  lis r16, 0x8057
  ori r17, r16, 0x8068
  ori r18, r16, 0xFBB0

  #r17 = value save address
  #r18 = value to use address  
  
  #Get Value for Vacuum Egg
  lbz r16, 0(r18)
  bl SPWStatusOptionSave
  li r15, 4
  slw r16, r16, r15
  lhz r15, 0(r17)
  andi. r15, r15, 0x7CF #Set to off to start
  or r15, r15, r16
  sth r15, 0(r17)

  #Get Value for Omochao Gun
  lbz r16, 1(r18)
  bl SPWStatusOptionSave
  li r15, 6
  slw r16, r16, r15
  lhz r15, 0(r17)
  andi. r15, r15, 0x73F #Set to off to start
  or r15, r15, r16
  sth r15, 0(r17)

  #Get Value for Heal Cannon
  lbz r16, 2(r18)
  bl SPWStatusOptionSave
  li r15, 8
  slw r16, r16, r15
  lhz r15, 0(r17)
  andi. r15, r15, 0x4FF #Set to off to start
  or r15, r15, r16
  sth r15, 0(r17)
  
  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR  

SPWStatusOptionIndex:
  #Set r16 to 5, or 6 for Weapon Status
  #r16 = 0, 1, 2, or 3 based on if either SPW check is set or not.
  #if r16 is 0, we skipped this routine as we want 0 for the Off option.

  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)
  
  cmpwi r16, 3
  bne SPWLevelIs1
  
  li r16, 6
  b EndSPWStatusOptionIndex

  SPWLevelIs1:
  li r16, 5

  EndSPWStatusOptionIndex:
  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR

SPWStatusOptionSave:
  #Depending on the current page, apply the current setting to the
  #SPW unlocked address.

  #Options are 0, 5, or 6 for Weapon Status
  #5 will be saved as b01, even though b10 is a valid option.

  #TODO: Assume r16 is the value for now.

  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)
  
  cmpwi r16, 5
  blt EndSPWStatusOptionSave #Value is 0, leave now.
  beq SaveSPWAsLevel1
  
  #Save as Level 2
  li r16, 3
  b EndSPWStatusOptionSave

  SaveSPWAsLevel1:
  li r16, 1

  EndSPWStatusOptionSave:
  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR  

RenderSXOptionsMain:
  #r10 contains address to start of our message.
  #r17 is currently the max index.

  #Check which screen to show
  lis r18, 0x8057
  ori r18, r18, 0xD8FA
  lhz r16, 0(r18)
  #r16 is currently the value of the page offset.
  #Page 1 starts at index 3
  
  #rx = (0x14 * Page Number)
  mulli r16, r16, 0x14
  lwzx r21, r10, r16

  #Set the cusor to the lowest available opition if current index is too high.  
  lis r16, 0x8057
  ori r18, r16, 0xD8F4
  lhz r16, 0(r18)

  cmpw r16, r17
  ble BeginRenderSXOptionsMain

  mr r16, r17
  sth r16, 0(r18)

BeginRenderSXOptionsMain:
  #Start by rendering a blank screen
  mr r20, r21

  li r19, 0
  lis r16, 0x8057
  ori r17, r16, 0xFBB0
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19
 
  #Determine if we should process further options.
  lis r16, 0x8057
  ori r17, r16, 0xFBBA
  lbz r17, 0(r17)
  cmpwi r17, 1
  blt EndRenderSXOptionsMain
  
  li r19, 1
  lis r16, 0x8057
  ori r17, r16, 0xFBB1
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  #Determine if we should process further options.
  lis r16, 0x8057
  ori r17, r16, 0xFBBA
  lbz r17, 0(r17)
  cmpwi r17, 2
  blt EndRenderSXOptionsMain

  li r19, 2
  lis r16, 0x8057
  ori r17, r16, 0xFBB2
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  #Determine if we should process further options.
  lis r16, 0x8057
  ori r17, r16, 0xFBBA
  lbz r17, 0(r17)
  cmpwi r17, 3
  blt EndRenderSXOptionsMain

  li r19, 3
  lis r16, 0x8057
  ori r17, r16, 0xFBB3
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  #Determine if we should process further options.
  lis r16, 0x8057
  ori r17, r16, 0xFBBA
  lbz r17, 0(r17)
  cmpwi r17, 4
  blt EndRenderSXOptionsMain

  li r19, 4
  lis r16, 0x8057
  ori r17, r16, 0xFBB4
  lbz r17, 0(r17)
  bl RenderOptionR17ToPosR19

  #Dont need to check as we dont support any more options at once.

EndRenderSXOptionsMain:

  bl SelectedOption

  bl GetNewButtonPressesToR16

  andi. r19, r16, 0x03C0
  #r19 is dpad button presses isolated.  

  cmpwi r19, 0
  bgtl ProcessDpadButtonOptions

  #Run apply settings code if we need to save changes now.
  lis r18, 0x8057
  ori r18, r18, 0xD8FA  
  lhz r16, 0(r18)

  cmpwi r16, 3
  beql SavePage1SXOptions
  cmpwi r16, 4
  beql SavePage2SXOptions
  cmpwi r16, 5
  beql SavePage3SXOptions
  cmpwi r16, 6
  beql SavePage4SXOptions

  bl GetNewButtonPressesToR16

  andi. r19, r16, 0x3000
  #r19 is dpad button presses isolated.  

  cmpwi r19, 0
  bgtl ProcessTriggerButtonOptions

  b StoreCurrentInputAndExit

RenderOptionR17ToPosR19:
  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  #r19 = position on screen
  lis r16, 0x8057
  ori r18, r16, 0xFB80
  #Multiply by 2 for halfword then offset by 10 bytes
  mulli r19, r19, 2
  addi r19, r19, 10
  
  lhzx r16, r18, r19
  add r21, r20, r16 #MoveCursorR16X

  #Load address to Options into r19
  lwz r19, 0x28(r10)
  cmpwi r17, 0 # Render "Off"  
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 1 # Render "On"
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 2 # Render "No Change"
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 3 # Render "Unlock"
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 4 # Render "Remove"
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 5 # Render "Level 1"
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 6 # Render "Level 2"
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 7 # Render "No"
  beql RenderOptionText

  addi r19, r19, 0x14 
  cmpwi r17, 8 # Render "Yes"
  beql RenderOptionText

  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR  

RenderOptionText:
  mflr r14

  RenderTextLoop:
    lhz r16, 0(r19) #Get Character data to write
    cmpwi r16, 0x0A# Check if we are writing a newline.    
    sth r16, 0(r21) #Write Character Data to Message
    addi r21, r21, 2
    addi r19, r19, 2
    bne RenderTextLoop  

  b ReturnR14BLR

RenderSXSaveMessage:
  #r10 contains address to start of our message.
  lwz r21, 0x28(r10)

  #Start by rendering a blank screen
  mr r20, r21

  bl GetNewButtonPressesToR16
  
  b StoreCurrentInputAndExit

ProcessDpadButtonOptions:
  #r19 is dpad buttons pressed

  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  #Check for Dpad Up
  andi. r16, r19, 64
  cmpwi r16, 64
  beql DpadUpOptions

  #Check for Dpad Down
  andi. r16, r19, 128
  cmpwi r16, 128
  beql DpadDownOptions

  #Check for Dpad Left
  andi. r16, r19, 256
  cmpwi r16, 256
  beql DpadLeftOptions

  #Check for Dpad Right
  andi. r16, r19, 512
  cmpwi r16, 512
  beql DpadRightOptions

  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR  

ProcessTriggerButtonOptions:
  #r19 is dpad buttons pressed

  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  #Check for L Button
  andi. r16, r19, 4096
  cmpwi r16, 4096
  beql LButtonOptions

  #Check for R Button
  andi. r16, r19, 8192
  cmpwi r16, 8192
  beql RButtonOptions

  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR  

DpadUpOptions:
  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)
  #r16 is now the current options index
  cmpwi r16, 0
  beq DpadUpEnd

  subi r16, r16, 1
  sth r16, 0(r18)

DpadUpEnd:
  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR  

DpadDownOptions:
  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)
  #r16 is now the current options index
  cmpwi r16, 4
  beq DpadDownEnd

  addi r16, r16, 1
  sth r16, 0(r18)
  
DpadDownEnd:
  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR   

DpadLeftOptions:
  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)
  #r16 is now the current options index

  #Get current option mode
  lis r18, 0x8057
  ori r18, r18, 0xFBB5
  lbzx r15, r18, r16
  #r15 is now the current option mode

  #Get the current option value
  addi r18, r18, -5
  lbzx r17, r18, r16
  #r17 is now the selected option

  cmpwi r15, 0
  beq Mode0LeftCommand
  cmpwi r15, 1
  beq Mode1LeftCommand
  cmpwi r15, 2
  beq Mode2LeftCommand
  cmpwi r15, 3
  beq Mode3LeftCommand

  Mode0LeftCommand:
    cmpwi r17, 0
    bgt DecrementOption
    b DpadLeftEnd

  Mode1LeftCommand:
    cmpwi r17, 2
    bgt DecrementOption
    b DpadLeftEnd

  Mode2LeftCommand:
    cmpwi r17, 7
    bgt DecrementOption
    b DpadLeftEnd

  Mode3LeftCommand:
    cmpwi r17, 5
    bgt DecrementOption

    #If not 6, we want to make the value 0,
    #since we want to go 5 -> 0, and setting
    #0 to 0 is fine.
    li r17, 0
    stbx r17, r18, r16
    b DpadLeftEnd

  DecrementOption:    
    subi r17, r17, 1# Decrement to next option.
    stbx r17, r18, r16

  DpadLeftEnd:
    lwz r14, 4(sp)
    addi sp, sp, 8
 
  b ReturnR14BLR  

DpadRightOptions:
  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)
  #r16 is now the current options index

  #Get current option mode
  lis r18, 0x8057
  ori r18, r18, 0xFBB5
  lbzx r15, r18, r16
  #r15 is now the current option mode

  #Get the current option value
  addi r18, r18, -5
  lbzx r17, r18, r16
  #r17 is now the selected option

  cmpwi r15, 0
  beq Mode0RightCommand
  cmpwi r15, 1
  beq Mode1RightCommand
  cmpwi r15, 2
  beq Mode2RightCommand
  cmpwi r15, 3
  beq Mode3RightCommand

  Mode0RightCommand:
    cmpwi r17, 1
    blt IncrementOption
    b DpadRightEnd

  Mode1RightCommand:
    cmpwi r17, 4
    blt IncrementOption
    b DpadRightEnd

  Mode2RightCommand:
    cmpwi r17, 8
    blt IncrementOption
    b DpadRightEnd

  Mode3RightCommand:
    cmpwi r17, 6
    blt IncrementOption
    cmpwi r17, 5
    blt IncrementOption

    #Is 0 if not branched by now.
    li r17, 5 # 0 -> 5 to go Off to Level 1
    stbx r17, r18, r16
    b DpadRightEnd

  IncrementOption:    
    addi r17, r17, 1# Increment to next option.
    stbx r17, r18, r16

  DpadRightEnd:
    lwz r14, 4(sp)
    addi sp, sp, 8
 
  b ReturnR14BLR  

LButtonOptions:
  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  lis r18, 0x8057
  ori r18, r18, 0xD8FA
  lhz r16, 0(r18) #Load Screen Offset
  cmpwi r16, 3
  beq LButtonEnd
  
  subi r16, r16, 1
  sth r16, 0(r18) #Go Back 1 Page.

LButtonEnd:
  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR  

RButtonOptions:
  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  lis r18, 0x8057
  ori r18, r18, 0xD8FA
  lhz r16, 0(r18) #Load Screen Offset
  cmpwi r16, 6
  beq RButtonEnd
  
  addi r16, r16, 1
  sth r16, 0(r18) #Go Forward 1 Page.

RButtonEnd:
  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR  

SelectedOption:
  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)
  
  #Load value for current menu option
  lis r18, 0x8057
  ori r18, r18, 0xD8F4
  lhz r16, 0(r18)

  #Multiply r16 by 2 since r19 will be as well later on.
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

  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR  

CheckOptionR19Selected:
  stwu sp, -8(sp)
  mflr r14
  stw r14, 4(sp)

  #Load Option Offset
  lis r16, 0x8057
  ori r18, r16, 0xFB80

  #Multiply index by 2 for halfword size
  mulli r19, r19, 2

  lhzx r16, r18, r19
  add r21, r20, r16

  li r16, 0x20
  cmpw r17, r19
  bne EndCheckOption
  
  #Make the it a selected character if not branched past  
  addi r16, r16, 0x0b

  EndCheckOption:
  sth r16, 0(r21)
  
  lwz r14, 4(sp)
  addi sp, sp, 8
 
  b ReturnR14BLR  

RenderR16R21: 
  mflr r14
  stw r16, 0(r21)
  addi r21, r21, 4
  b ReturnR14BLR

ReturnR14BLR:
  mtlr r14
  li r14, 0
  blr

Exit:
  #Restore LR before exiting
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
  #Original Code
  lis r5, 0x8057




