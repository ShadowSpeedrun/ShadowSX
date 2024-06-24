#To be inserted at 801e5828
#SetInLastStoryOnSRUnlock.asm

Start:
  #Original Code
  li r0, 1
  
  #This happens right before the auto save and unlock messages.
  #The code we are injecting into is where weapons are unlocked.
  #If Shadow Rifle is being unlocked, may as well set 
  #the In Last Story Flag as well so we can show the IGT message.
  
  #r4 = Weapon to Unlock? 5= EV1 a = SR
  #r3 = 80578068
  #r0 = 1
  #8057D902 = LS Flag
  
  cmpwi r4, 0xa
  bne Exit
  
  sth r0, 0x589A(r3)

Exit: