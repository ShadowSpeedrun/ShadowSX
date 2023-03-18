#To be inserted at 801e5828
;Original Code
li r0, 1


;This happens right before the auto save and unlock messages.
;The code we are injecting into is where we set the Shadow Rifle
;as unlocked. So may as well set the In Last Story Flag as well
;so we can show the IGT message.

;r3 = 80578068
;r0 = 1
;8057D903 = LS Flag

sth r0, 0x589B(r3)