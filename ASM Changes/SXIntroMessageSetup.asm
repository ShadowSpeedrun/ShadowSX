#To be inserted at 80359C94
;SXIntroMessageSetup.asm

;Initialize Intro Message

Start:
  ;Original Code
  stw r0, 0x0014 (sp)
  
  ;Load Intro Message ID (8057D8FC)
  lis r18, 0x8057
  ori r18, r18, 0xD8FC
  lwz r19, 0(r18)
  cmplwi r19, 0x0
  bne- End
  
  ;Initialize to SX intro
  li r19, 44
  sth r19, 0(r18)
  
  ;Check if Rom Settings are valid
  ;If not, assign default settings.


  ;Set r18 to start of flag data.
  lis r18, 0x8057
  ori r18, r18, 0x7B2C

CheckCSSkip:
  ;Load location for CSSkip flag
  lbz r19, 0(r18)

  ;If not 0, or 1
  ;assign 1 by default.
  cmpwi r19, 0
  beq CheckRT
  cmpwi r19, 1
  beq CheckRT
  li r19, 1
  stb r19, 0(r18)

CheckRT:
  ;Load location for Race Time flag
  lbz r19, 1(r18)

  ;If not 0, or 1
  ;assign 0 by default.

  cmpwi r19, 0
  beq CheckMUI
  cmpwi r19, 1
  beq CheckMUI
  li r19, 0
  stb r19, 1(r18)

CheckMUI:
  ;Load location for Modern UI Control flag
  lbz r19, 2(r18)

  ;If not 0, or 1
  ;assign 0 by default.

  cmpwi r19, 0
  beq CheckSPWDisable
  cmpwi r19, 1
  beq CheckSPWDisable
  li r19, 0
  stb r19, 2(r18)

CheckSPWDisable:
  ;Load location for Disable SPW Unlock flag
  lbz r19, 3(r18)

  ;If not 0, or 1
  ;assign 0 by default.

  cmpwi r19, 0
  beq End
  cmpwi r19, 1
  beq End
  li r19, 0
  stb r19, 3(r18)

End:
  li r18, 0x0
  li r19, 0x0
  
