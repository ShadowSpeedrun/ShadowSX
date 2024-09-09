///////////////////////////////////////////////////////
////  SHADOW THE HEDGEHOG - SPEEDRUNNER'S CUT 1.1  ////
///////////////////////////////////////////////////////

Thank you for trying out Shadow SX 1.1!

The use of the Shadow SX Launcher should take care of the main bulk of the ROM patching and Dolphin Configuration.  Below are other options and concideratons when preparing and running Shadow SX.

///////////////////////////////////////////////////////
////                  DOLPHIN TIPS                 ////
///////////////////////////////////////////////////////

These are some tips to consider when setting up dolphin

1. If you plan to run your ROM from an HDD, you may need to re-enable the Emulate Disk Speed setting in the game properites to improve performance.

2. When setting up an Xbox or Playstation style controller, be sure to set the buttons up like this:

  B = Left Face Button
  A = Bottom Face Button
  X = Right Face Button
  Y = Top Face Button

  Be sure to enable the Modern UI Control option in game if you want a similar UI navigation experience as those console versions.

3. Make sure to enable Background Input in the Controller Settings if you want to be able to play the game while having something else focused on your computer. (Useful for recording or streaming)

4. Regarding Aspect Ratio choose whichever option fits your needs best. If you have a decent 4:3 Monitor, set the option to Stretch to Window and run it full screen on that monitor for the best experience.

///////////////////////////////////////////////////////
////    STEAM DECK GAMING MODE (HANDHELD MODE)     ////
///////////////////////////////////////////////////////

Adding "-sdg" as a launch argument for the launcher will adjust the options and controls in the launcher for use on a gaming device like a steam deck.
This will disable a few options that would be difficult to navigate in Steam Deck's Gaming Mode.

Here's how to set up this mode:
Windows:
  1. Use the Right Mouse button to click and drag the ShadowSXLauncher.exe, when hovering over open space, let go of right click to reval the click on the "Create shortcuts here" option.
  2. Right Click the new shortcut to access the properites and add "-sdg" to the end of the file path in the Target field.
    For example, mine looks like this now: "C:\Users\Zzetti\Desktop\Shadow-SX-Launcher\ShadowSXLauncher.exe" -sdg
  You can now use that shortcut to launch the launcher in Steam Deck Gaming Mode.
  
Linux:
  This may vary depending on the linux distro settings you have.  These steps are assuming KDE Desktop is used.
  1. Using Dolphin(KDE File Explorer) Right click in an empty space to reveal and click on the "Create New" > "Link to Application..."
  2. Name the Link and then navigate to the "Application" tab where you can assign the launcher's file path and add the "-sdg"(without quotes) to the "Arguments" Field.
  You can now use this new link to open the launcher in Steam Deck Gaming Mode.

Steam:
  1. From the Library page, click on the "Add New Game" option in the bottom corner to add a new non stream game.
  2. Browse to the Shadow SX Launcher to add it to Steam.
  3. From the games list, select ShadowSXLauncher and then access the properites.
  4. Type "-sdg" (without quotes) to the Launch Options.
  Now when you launch Shadow SX Launcher from Steam, it will be in Steam Deck Gaming Mode.

///////////////////////////////////////////////////////////
////            SPEEDRUNNING CONSIDERATIONS            ////
///////////////////////////////////////////////////////////

The default settings should work for everyone, adjusting the settings is allowed, though keep in mind this may have an effect on performance. 
From my tests so far, it appears that you can increase the visual quality of the game, but at the cost of reduced framerate or more frequent drops in framerate.  
The real time appears to be unaffected, so whether you want fast framerates of improved visual quality is currently up to you. 
For players expecting to have submittable runs, the framerate (VPS in Dolphin) should be consistent and pretty much always 60.  
Footage that does not meet this may not be accepted for leaderboard placements.