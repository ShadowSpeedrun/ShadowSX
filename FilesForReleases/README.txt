///////////////////////////////////////////////////////
////    SHADOW THE HEDGEHOG - SPEEDRUNNER'S CUT    ////
////                BETA 3 RELEASE                 ////
///////////////////////////////////////////////////////

This update adds in a few quality of life and polish items. The main noticeable change is the addition of 2 new blue message screens, 1 of which would have affected RTA timing of runs.

While it may look like little has changed, there's quite a bit of new code to get these features in, so any help with playtesting this release would be much appreciated.

Like with the last update, the only things left I would like to add before a 1.0 release are not essential to the gameplay or would majorly change how you would play each level.  So, feel free to get some practice in while I get things finished up.

///////////////////////////////////////////////////////
////              SETUP INSTRUCTIONS               ////
///////////////////////////////////////////////////////

1. Create a new folder for holding the downloaded files. The name doesn’t have to be exact, but I would recommended "Shadow-SX" for the name.

2. Download the latest Dolphin Development Build.

3. Extract the contents such that the Dolphin-x64 folder is in the Shadow-SX folder.  
 
   Your folder should now look like:
   
   Shadow-SX
   |_
      Dolphin-x64

4. Drag the files inside of "Shadow-SX-Files" onto your "Shadow-SX" Folder. This will copy over the dolphin settings and game changes. This also will make this dolphin exe into a portable version which will keep settings and changes local to this version without messing with any existing dolphin settings on your computer.

    Your folder should now look like this:

    Shadow-SX
    |_
      Dolphin-x64
      ShadowSXResources
      ShadowSXLauncher.exe
	  
5. If you don’t already have a patched ROM, you should now create one using the ShadowSXLauncher.  If you are on Mac or Linux, or would prefer not to use the Launcher to patch the ROM, you can use the manual patching tools provided on the download page.

    To patch the ROM using the ShadowSXLauncher:
        1. Open the launcher, then press the "Create Shadow SX ROM" button.
        2. Select your original clean ripped Shadow the Hedgehog ISO ROM. - CRC32: F582CF1E
        3. Select where you want to save your patched ROM copy. (The original ROM will not be altered)
	
	Assuming everything is correct, the ROM will be created. If you come across an error that is not fixable with the provided suggestions, reach out on the Shadow Speedrunning Discord Server for help.

    The remaining steps are for those that wish to play on PC with the Dolphin Emulator. If you are only planning on playing on Console, you do not need to follow the remaining steps, simply run the patched ROM on your console of choice.
	
	All optional settings as of now able to be enabled in the game itself without the need for extra files. The first blue message that appears on boot will explain how to enable one or more options.

6. Within ShadowSXResources\CustomTextures, there is a folder named GUPE8P.  Copy (not move) that folder and paste it in: Dolphin-x64\User\Load\Textures.  This adds some custom textures that can be used to improve or customize the look of Shadow SX.

7. In the Dolphin-x64\User\Load\Textures\Buttons folder, delete all folders except for the one that lists your preferred button display, deleting all if you want to use the default GC button layout.

8. Run "Dolphin.exe" in the Dolphin-x64 folder.

9. Double click the main window, where instructed, to set the rom path to where your ShadowSX ROM will be.

10. Click on the Controllers icon to set up your controller.

GC controllers should be mapped 1 to 1 or using an adapter.

Xbox and PlayStation style controllers should have the following setup:

B = Left Face Button
A = Bottom Face Button
X = Right Face Button
Y = Top Face Button

Be sure to enable the Modern UI Control option in game if you want a similar UI navigation experience as those console versions.

************************************************************************
                        Congratulations! 
You can now run Shadow the Hedgehog with the Shadow-SX changes applied.
*************************************************************************

Notes:

If you want, you could run Shadow SX from Dolphin.exe, but it is recommended that you instead use the provided ShadowSXLauncher.exe which allows launching the game standalone without the dolphin interface and adjusting some settings in a more user friendly way.  While I initially planned to have quick access to some of the more common dolphin settings, those will still need to be done with the dolphin interface, a shortcut to which is provided in the settings menu of the launcher.  If you choose to do this, be sure to make sure all of the folders and files are named correctly under the "Shadow-SX" folder based on the above instructions. The main folder itself doesn’t need to be named "Shadow-SX".

The end goal is to have a set of settings that would allow everyone to play on the same "Console". The default settings should work for everyone, but if you need to adjust settings to get things working, let me know. From my tests so far, it appears that you can increase the visual quality of the game, but at the cost of reduced framerate or more frequent drops in framerate.  The real time appears to be unaffected, so whether you want fast framerates of improved visual quality is currently up to you.

Regarding Aspect Ratio, Auto or Force 4:3 should be fine. If you have a decent 4:3 Monitor, set the option to Stretch to Window and run it full screen on that monitor for the best experience.

Make sure to enable Background Input in the Controller Settings if you want to be able to play the game while having something else focused on your computer.
