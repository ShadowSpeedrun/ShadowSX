///////////////////////////////////////////////////////
////    SHADOW THE HEDGEHOG - SPEEDRUNNER'S CUT    ////
////                 BETA RELEASE                  ////
///////////////////////////////////////////////////////

The goal of this beta release is to test out the game with the majority of the modifications and to see how everyone can run this configuration of Dolphin. Ideally everyone should be running on the same settings to keep things as fair as possible.  Lets figure out needs adjustments together!

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

5. Place your clean ripped Shadow The Hedgehog NTSC ISO named "ShadowTheHedgehog" into the folder. - CRC64: B964387A53E0D95C

6. Drag the files inside of "Shadow-SX-Files" onto your "Shadow-SX" Folder. This will copy over the dolphin settings and game changes. This also will make this dolphin exe into a portable version which will keep settings and changes local to this version without messing with any existing dolphin settings on your computer.

    Your folder should now look like this:

    Shadow-SX
    |_
      Dolphin-x64
      ShadowData
      ShadowSXResources
      ShadowSXLauncher.exe

7. Within ShadowSXResources\CustomTextures, there is a folder named GUPE8P.  Copy (not move) that folder and paste it in: Dolphin-x64\User\Load\Textures.  This adds some custom textures that will clearly show the game as Shadow SX during load screens along with a few other modifications for a better experience when using higher internal resolutions.

8. In the Dolphin-x64\User\Load\Textures\Buttons folder, delete all folders except for the one that lists your prefered button display, deleting all if you want to use the default GC button layout.

9. Run "Dolphin.exe" in the Dolphin-x64 folder.

10. Double click the main window where instructed to set the rom path to ShadowData.

11. Click on the Controllers icon to set up your controller.

GC controllers should be mapped 1 to 1 or using an adapter.

Xbox and PlayStation style controllers should have the following setup:

B = Left Face Button
A = Bottom Face Button
X = Right Face Button
Y = Top Face Button

************************************************************************
                        Congratulations! 
You can now run Shadow the Hedgehog with the Shadow-SX changes applied.
*************************************************************************

Notes:

If you want, you could run Shadow SX from Dolphin.exe, but it is recommended that you instead use the provided ShadowSXLauncher.exe which allows launching the game standalone without the dolphin interface, and adjusting some settings in a more user friendly way.  While I initially planned to have quick access to some of the more common dolphin settings, those will still need to be done with the dolphin interface, a shortcut to which is provided in the settings menu of the launcher.  If you choose to do this, be sure to make sure all of the folders and files are named correctly under the "Shadow-SX" folder based on the above instructions. The main folder itself doesnt need to be named "Shadow-SX".

The end goal is to have a set of settings that would allow everyone to play on the same "Console". The default settings should work for everyone, but if you need to adjust settings to get things working, let me know. From my tests so far, it appears that you can increase the visual quality of the game, but at the cost of reduced framerate or more frequent drops in framerate.  The real time appears to be unaffected, so whether you want fast framerates of improved visual quality is currently up to you.

Regarding Aspect Ratio, Auto or Force 4:3 should be fine. If you have a decent 4:3 Monitor, set the option to Stretch to Window and run it full screen on that monitor for the best experience.