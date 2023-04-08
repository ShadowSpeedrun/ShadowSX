#To be inserted at 8035b1dc
;ShowIGTDuringAutoSave.asm

Start:
  ;LoadTimeFlagAddress
  lis r18, 0x8057
  ori r18, r18, 0xD901
  lhz r19, 0(r18)
  cmpwi r19, 1
  bne- CleanupAndEnd
  
  ;Display Time Message
  lis r18, 0x8011
  ori r18, r18, 0x7514
  mtlr r18
  blrl
  
  li r4, 43
  li r5, 0x0
  li r6, 0x0
  
  lis r18, 0x802e
  ori r18, r18, 0x58b4
  mtlr r18
  blrl
  
  cmpwi r3, 2
  bne- EndMessage
  
  ;Message Accept. Disable Time Flag
  ;LoadTimeFlagAddress
  lis r18, 0x8057
  ori r18, r18, 0xD901
  li r19, 0
  sth r19, 0(r18)

EndMessage:
  li r3, 1
  b EndOfChecks

EndOfChecks:
  bl Cleanup
  lis r18, 0x8035
  ori r18, r18, 0xb258
  mtlr r18
  li r18, 0x0
  blr

Cleanup:
  li r18, 0x0
  li r19, 0x0
  blr
  
CleanupAndEnd:
  bl Cleanup
  ;Will continue into End

End:
  ;Original Code
  lbz r3, 0x16C8 (r30)