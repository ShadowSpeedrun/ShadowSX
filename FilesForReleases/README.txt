///////////////////////////////////////////////////////
////    SHADOW THE HEDGEHOG - SPEEDRUNNER'S CUT    ////
////                 ALPHA RELEASE                 ////
///////////////////////////////////////////////////////

The goal of this alpha release is to test out the game modifications and to see how everyone can run this configuration of Dolphin. Ideally everyone should be running on the same settings to keep things as fair as possible.  Lets figure out needs adjustments together!

Beta will focus on locking down recommend settings and creating extra tools to speed up setup and configuration along with a handful of visual mods to make it clear that this is not original Shadow.

///////////////////////////////////////////////////////
////              SETUP INSTRUCTIONS               ////
///////////////////////////////////////////////////////

1. Create a folder named, "Shadow-SX".

2. Download the latest Dolphin Development Build.

3. Extract the contents such that the Dolphin-x64 folder is in the Shadow-SX folder.  
 
4. Create a Folder named, "ShadowData".

   Your folder should now look like:
   
   Shadow-SX
   |_
      Dolphin-x64
	  ShadowData
	  
5. Place your clean ripped Shadow The Hedgehog NTSC ISO into the folder. - CRC64: B964387A53E0D95C

6. Drag the files inside of "Shadow-SX-Files" onto your "Shadow-SX" Folder. This will copy over the dolphin settings and game changes. This also will make this dolphin exe into a portable version which will keep settings and changes local to this version without messing with any existing dolphin settings on your computer.

7. Run "Dolphin.exe" in the Dolphin-x64 folder.

8. Double click the main window where instructed to set the rom path to ShadowData.

9. Click on the Controllers icon to set up your controller.

GC controllers should be mapped 1 to 1 or using an adapter.

Xbox and PlayStation style controllers should have the following setup:

B = Left Face Button
A = Bottom Face Button
X = Right Face Button
Y = Top Face Button

I also recommend the following steps when using a Xbox or PlayStation style controller:

1. Right click on the Shadow the Hedgehog Game Icon and enter Properties.

2. Click on the Gecko Codes Tab.

3. Make sure the SX - Modern UI Control code is enabled.

Doing this will allow you to navigate the menus in game just as you would on the Xbox or PS2 release. Mainly your 'B' button acting as back instead of confirm due to how the GC controller is set up and whatnot.


************************************************************************
                        Congratulations! 
You can now run Shadow the Hedgehog with the Shadow-SX changes applied.
*************************************************************************

Notes:

Try to keep graphics and emulator setting changes to an abosulte minimum. The goal is to allow everyone to run on a similar "Console".
That said, I do want to allow better visual quality if possible.  The Default is standard, but I have been able to run at 2x Resolution and 2x MSAA. Let me know if that is something you can do or if you need to keep things default.

Regarding Aspect Ratio, Auto or Force 4:3 should be fine. If you have a decent 4:3 Monitor, set the option to Stretch to Window and run it full screen on that monitor for the best experience.


I also recommend creating shortcuts to run the game or access the memory card data.  You can do that by following these steps:

Dolphin UI Shortcut

1. Navigate to the Dolphin.exe file in "Shadow-SX\Dolphin-x64".

2. Right Click and drag the Dolphin.exe file to the side and release to show more options.

3. Select "Create shortcuts here".  This will create a shortcut file.

4. You can name this, "Shadow-SX Dolphin" or "Dolphin UI" depending on if you follow the next set of steps.

Dolphinless Shortcut

1. Make a copy of this shortcut and rename it to "ShadowSX-Run" or somthing similar.

2. Right Click and open the Properties of the shortcut.

3. Change the Target text to include the following after Dolphin.exe: 
	-b "<Path to Shadow ISO in ShadowData>"
	The quotes are important!

This shortcut is now able to launch Shadow-SX without opening the Dolphin UI!

Memory Card Shortcut

1. Navigate to the "Card A" Folder in "Shadow-SX\Dolphin-x64\User\GC\USA\Card A"
Note: You will need to run the game first to see this folder.

2. Right Click and drag the "Card A" Folder to the side and release to show more options.

3. Select "Create shortcuts here".  This will create a shortcut file.

4. You can name this, "Memory Card" or something similar.