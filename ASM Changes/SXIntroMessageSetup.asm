#80359C94
#SXIntroMessageSetup.asm

#Initialize Intro Message

Start:
  #Original Code
  stw r0, 0x0014 (sp)
  
  #Load Intro Message ID (8057D8FC)
  lis r18, 0x8057
  ori r18, r18, 0xD8FC
  lhz r19, 0(r18)
  
  #If 0, run init
  cmplwi r19, 0x0
  beq Init
  
  #Check if we are past Intro into Options
  lhz r19, -2(r18)
  cmpwi r19, 0x0
  bgt InitOptionSets
  b End

Init:  
  #Initialize to SX intro
  li r19, 44
  sth r19, 0(r18)

  #Check if Rom Settings are valid
  #If not, assign default settings.

  #Set r18 to start of flag data.
  lis r18, 0x8057
  ori r18, r18, 0x7B2C

InitMenuOptions:
  #8057FB80 is current level keys. Borrowing for lookup table data.
  lis r16, 0x8057
  ori r18, r16, 0xFBA0

  #Set the values for Page 2 to be "No Change" by default
  #07, 07, 07, 02
  li r16, 0x0707
  sth r16, 0(r18)
  li r16, 0x0702
  sth r16, 2(r18)
  b End

InitOptionSets:
  #Initialize Options References
  lis r16, 0x8057
  addi r18, r16, 0x6972
  lhz r16, 0(r18)
  cmpwi r16, 1 #0 == JPN Lang
               #1 == ENG Lang
  
  #8057FB80 is current level keys. Borrowing for lookup table data.
  lis r16, 0x8057
  ori r18, r16, 0xFB80
  li r17, 10 #Offset for Set 1
  ble OptionSets
  li r17, 8 #Offsets for Set 2
 
OptionSets: 
  #Set 1 Offsets
  #0038, 0078, 00B8, 00F8, 0138

  li r16, 0x0038
  add r16, r16, r17
  sth r16, 0(r18)

  li r16, 0x0078
  add r16, r16, r17
  sth r16, 2(r18)

  li r16, 0x00b8
  add r16, r16, r17
  sth r16, 4(r18)

  li r16, 0x00f8
  add r16, r16, r17
  sth r16, 6(r18)

  li r16, 0x0138
  add r16, r16, r17
  sth r16, 8(r18)

  #0062, 00A2, 00E2, 0122, 0162
  li r16, 0x0062
  add r16, r16, r17
  sth r16, 10(r18)

  li r16, 0x00A2
  add r16, r16, r17
  sth r16, 12(r18)

  li r16, 0x00E2
  add r16, r16, r17
  sth r16, 14(r18)

  li r16, 0x0122
  add r16, r16, r17
  sth r16, 16(r18)

  li r16, 0x0162
  add r16, r16, r17
  sth r16, 18(r18)

End:
  li r16, 0x0
  li r18, 0x0
  li r19, 0x0
  
