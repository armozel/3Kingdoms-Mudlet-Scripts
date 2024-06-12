This includes basic processing for MIP codes as tested on 3Kingdoms.  
Notable features include a 
 * Chat Monitor
 * hp/sp/gp1/gp2 gagues as well as gline1 and gline2 display
 * speedwalker
 * stepper
 * Compatible with the generic mapper package in mudlet core
   
By default the package will start the MIP at login and open a chat monitor window and the gagues.

Further features are available as a series of aliases, mostly prepended by a /
 * /reset all
   * This will set up the needed colors and prompts for the stepper to function
   * Note: the stepper uses ansi colors to detect various things so ansi will need to be on and this will change your colors from their current values
   * you should only really need to do this once, but it could fix odd states
 * /go <areaname>
    * the go command will take you to one of the areas with a defined speedwalk alias
    * in some cases it will print the directions on the screen because I haven't converted them yet
 * /home
    * reverses the speedwalk from the entrance room (actually it's separate because mudlet is a little dumb)
  * /hunt
    * starts the stepper assuming you are either in the starting room of the path or the place you last did /stop
    * this also turns off the cartographer minimap and by default hides a lot of things. basically anything it is dealing with currently.
    * not all speed walk paths have stepper paths
  * /stop
    * this will deactivate the stepper but saves your spot.

  ** 3K areas with speedwalk **
  * Chaos
     * pool : alignment pool
     * mj : Mahjongg
     * chess : Chess board Dungeon
     * alphabet : Alphabet Dungeon
     * sb : Isle of Colors
     * hotel : Hotel Transylvania
     * spirit : Tree of Life area, spirit armor drops here
     * dftree : Terra's Terrific Treehouse
     * rocks : will run to the chaos observatory, buy four moon rocks, keep them, and run back to chaos
     * veg : Chaos Farm
     * anchorman : Anchorman Dungeon
     * dundee : Crocodile Dundee Swamp
     * qoh : Queen of Hearts area
     * chins : chinchilla 2.0 area
  ** Science **
 * mammon : great corpse area
 * wh : Whorehouse
 * aegis : Aegis Dungeon
 * z : Section Z Dungeon
** Magic **
   * underdark : Underdark
   * hk : Honorable Knight, nothing else here, nope
   * rimalkin : Rimalkin Dungeon
   * zel : Zeligar's Tower Dungeon
   * pol, pol2, pol3 : Portal of Life area
   * brigands : an area, with brigands
  
