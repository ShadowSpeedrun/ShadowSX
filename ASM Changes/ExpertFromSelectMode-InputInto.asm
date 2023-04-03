#To be inserted at 80206334
loc_0x0:
  ;Check for Player Input X
  lis r18, 0x8056
  ori r18, r18, 0xED54
  lbz r18, 3(r18)
  andi. r18, r18, 0x8
  cmpwi r18, 0x8

  bne- loc_0x1C
  ;Set Expert Enable To 1
  li r3, 0x1
  ;Also set from Select Mode to 1
  lis r18, 0x8057
  ori r18, r18, 0xD8FF
  sth r3, 0(r18)

loc_0x1C:
  stb r3, 89(r31)
  li r3, 0x0
