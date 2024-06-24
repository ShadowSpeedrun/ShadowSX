#802038C8
#StageLoading-CutsceneFalse.asm

#Stage Load - Set "In Cutscene" False

#Assume cutscene is false.  Cutscene flag will set to true after load if needed.

Start:
  #Original Code
  stw r4, 0(r3)

  #Set "In Cutscene" False
  lis r18, 0x8057
  ori r18, r18, 0xD8F8
  li r16, 0x0
  sth r16, 0(r18)