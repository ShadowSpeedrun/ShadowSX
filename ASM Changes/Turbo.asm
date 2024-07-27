#80358a04
#Turbo.asm
#L+B = Turbo B, Z+A = Turbo A

#r8 is the value of digital button presses.

Start: 
  #Check for Button Combos
  li r20, 0

  #8057D6C0 = Time To Add
  #8057D728 = Frame Counter
  #80576710 = Normal Score
  #8057D908 = New IGT
  #lis r18, 0x8057
  #ori r18, r18, 0xD908
  #lwz r19, -0x248(r18)
  #stw r19, 0(r18)

  #lwz r19, -0x1E0(r18)
  #stw r19, -0x71F8(r18)

TurboACheck:
  andi. r19, r8, 33 #(Z+A)
  cmpwi r19, 33 
  bne TurboBCheck
  #Prep A Button for Turbo
  li r20, 1

TurboBCheck:
  andi. r19, r8, 4098 #(L+B)
  cmpwi r19, 4098
  bne Turbo
  #Prep B Button for Turbo
  ori r20, r20, 2

Turbo:
  #Check if a turbo button is assigned.
  cmpwi r20, 0
  beq End

  #8057D90C = Bucket for Float Counter
  #8057D910 = Bucket for loading floats
  #8057D6C0 = TimetoAdd But maybe just use f1?
  #Check for over 5 frames = 0.083333 (3D AA AA AB)
  #use f9, f10

  lis r18, 0x8057
  ori r18, r18, 0xD90C
  lis r17, 0x3DAA 
  ori r17, r17, 0xAAAB
  stw r17, 4(r18)
  lfs f10, 4(r18)
  lfs f9, 0(r18)

  fcmpu cr0, f9, f10
  blt OffFrame

  li r17, 0
  stw r17, 0(r18)
  b End  
  #Button is already on.
OffFrame:  
  fadd f9, f9, f1
  stfs f9, 0(r18)
  sub r8, r8, r20

End:
  #Original Code
  stw r8, 0x0004 (r3)