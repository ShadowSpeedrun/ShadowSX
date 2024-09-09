#8035a284
#SXIntroMessage.asm

#Boot intro SX

Start:
  #Load Intro Message ID (8057D8FC)
  lis r18, 0x8057
  ori r18, r18, 0xD8FC
  lhz r4, 0(r18)

  li r18, 0x0
  
  #Original code
  li r5, 0
