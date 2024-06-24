#80129BCC
#InCheckpointFalseAfterWarp.asm

Start:
  #Original Code
  addi r3, r3, 0xA8
 
  #Load address of "In Checkpoint"
  #into r18.
  lis r18, 0x8057
  ori r18, r18, 0xD8A6
  li r16, 0x0

  #Set "In Checkpoint" to false.
  sth r16, 0(r18)

  #Cleanup to prevent
  #accidental code changes.
  li r18, 0x0
