///////////////////////////////////////////////////////
////  SHADOW THE HEDGEHOG - SPEEDRUNNER'S CUT 1.1  ////
///////////////////////////////////////////////////////

Thank you for trying out Shadow SX 1.1!

///////////////////////////////////////////////////////
////     SETUP INSTRUCTIONS - PATCHING THE ROM     ////
///////////////////////////////////////////////////////

The setup process is a bit different compared to how it was in 1.0.  So be sure to read through them again just so you dont miss anything.

1. Create a new folder for holding the downloaded files. The name doesn’t have to be exact, but I would recommended "Shadow-SX" for the name.

2. Drag the files inside of "Shadow-SX-Files" onto your "Shadow-SX" Folder.

    Your folder should now look like this:

    Shadow-SX
    |_
      ShadowSXResources
	  av_libglesv2.dll
	  libHarfBuzzSharp.dll
	  libSkiaSharp.dll
      ShadowSXLauncher.exe

3. If you don’t already have a patched ROM, you should now create one using the Shadow SX Launcher.  Alterative methods of patching the game are listed on the github releases page.

    To patch the ROM using the Shadow SX Launcher:
        1. Open the launcher, then press the "Create Shadow SX ROM" button.
		2. Select the version and variant of the ROM you would like to create.
        2. Select your original clean ripped Shadow the Hedgehog ISO ROM. - CRC32: F582CF1E
        3. Select where you want to save your patched ROM copy. (The original ROM will not be altered)
	
	Assuming everything is correct, the ROM will be created. If you come across an error that is not fixable with the provided suggestions, reach out on the Shadow Speedrunning Discord Server for help.

    The remaining steps are for those that wish to play on PC with the Dolphin Emulator on Windows. If you are only planning on playing on Console, you do not need to follow the remaining steps, simply run the patched ROM on your console of choice.
	
	All optional settings for gameplay purposes are able to be configured in the game itself without the need for extra files. The first blue message that appears on boot will explain how to enable one or more options.

///////////////////////////////////////////////////////
////          SETUP INSTRUCTIONS - DOLPHIN         ////
///////////////////////////////////////////////////////

It is highly reccommended that you follow these steps to configure this download of dolphin to be a standalone portable build. This will allow us to adjust the settings just for this download without affecting other games.
These steps are currently only tested for Windows. Mac and Linux may be able to follow along a bit where it makes sense.

1. Download the latest Dolphin Release.

2. Extract the contents to the Dolphin-x64 folder that is in the Shadow-SX folder.  

3 Copy the files in the "Dolphin-Config-Files" folder into the Dolphin-x64 folder.
  
	This will make this dolphin setup into a portable version which will keep settings and changes local to this version without messing with any existing dolphin settings on your computer.

4. If you are using the Shadow SX Launcher, you can use the Settings to set up the custom textures created for this release. If not, you can manually copy (not move) over the custom textures you want from ShadowSXResources\CustomTextures to Dolphin-x64\User\Load\Textures\GUPX8P

5. Run Dolphin in the Dolphin-x64 folder.

6. Double click the main window, where instructed, to set the rom path to where your Shadow SX ROM will be.

7. If you plan to run your ROM from an HDD, you may need to re-enable the Emulate Disk Speed setting in the game to improve performance.

8. Click on the Controllers icon to set up your controller.

GC controllers should be mapped 1 to 1 or using an adapter.

Xbox and PlayStation style controllers should have the following setup:

B = Left Face Button
A = Bottom Face Button
X = Right Face Button
Y = Top Face Button

Be sure to enable the Modern UI Control option in game if you want a similar UI navigation experience as those console versions.

Also, make sure to enable Background Input in the Controller Settings if you want to be able to play the game while having something else focused on your computer. 

************************************************************************
                        Congratulations! 
You can now run Shadow the Hedgehog with the Shadow-SX changes applied.
*************************************************************************

Notes:

If you want, you could run Shadow SX from Dolphin.exe, but it is recommended that you instead use the provided ShadowSXLauncher.exe which allows launching the game standalone without the dolphin interface and adjusting some settings in a more user friendly way.

The default settings should work for everyone, adjusting the settings is allowed, though keep in mind this may have an effect on performance. From my tests so far, it appears that you can increase the visual quality of the game, but at the cost of reduced framerate or more frequent drops in framerate.  The real time appears to be unaffected, so whether you want fast framerates of improved visual quality is currently up to you. For players expecting to have submittable runs, the framerate (VPS in Dolphin) should be consistent and pretty much always 60.  Footage that does not meet this may not be accepted for leaderboard placements.

Regarding Aspect Ratio choose whichever option fits your needs best. If you have a decent 4:3 Monitor, set the option to Stretch to Window and run it full screen on that monitor for the best experience.
