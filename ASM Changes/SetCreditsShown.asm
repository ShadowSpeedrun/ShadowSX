#80342398
#SetCreditsShown.asm

Start: 
  #Original Code
  stwu sp, -0x0020 (sp)
  
  #Set Flag for showing the Race Time before Auto Save
  lis r18, 0x8057
  ori r18, r18, 0xD900
  
  li r16, 0x1
  sth r16, 0(r18)
  
  li r16, 0x0
  li r18, 0x0