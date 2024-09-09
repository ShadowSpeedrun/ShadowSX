#802d4a80
#SonicDiablonIGTPenalties.asm

#Times for Intro, Mid Cutscnes
#Sonic & Diablon = 4  , 3

Start:
  #Setup Memory Bucket
  lis r18, 0x8057
  ori r18, r18, 0xD904

  #Intro is 4 seconds 0x40800000
  lis r17, 0x4080
  stw r17, 0(r18)
  lfs f11, 0(r18)

  #Mid is 3 seconds 0x40400000
  lis r17, 0x4040
  stw r17, 0(r18)
  lfs f12, 0(r18)

  #bl TimePenaltyCheck
  #To be injected in MCM
  nop

End:
  #Original Code
  li r4, 4