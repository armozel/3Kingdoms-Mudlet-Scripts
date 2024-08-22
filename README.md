This plugin is an implementation of the MIP protocol (see PortalMIP9.pdf) developed for 3Kingdoms 
by Gameaxle Software and implemented by a number of other muds.

Currently implmented features are:
- hpbars with hp, sp, gp1, gp2, enemy name and hp, gline1 and gline2 support
- basic chat monitor (though emotes look odd) in screen reader targetable pop out window

The portal MIP hides your hpbar by default so to integrate this into an existing mudlet ecosystem
you'll probably need to implement two things.  One is a hook that is called when the mip updates
the hpbar window.  This is an example that uses the enemyname to determine if the player is
in combat or not.

function ThreeKlient.mip.vitalUpdateHook()
  local vitals=ThreeKlient.mip.vitals
  if vitals.enemyname and string.len(vitals.enemyname) == 1 then
    inCombat = false
  else
    inCombat = true
  end 
end

The other is a ticker to do things that should happen once a round.  On 3kingdoms a round is
two seconds long so you would want to define a two second timer.  Then in that timer define
anything you would normally trigger off an hpbar.  For example I copied these existing
functions from my hpbar trigger and redefined them using the mip vitals table.

local vitals = ThreeKlient.mip.vitals
if vitals.hpcur and vitals.hpmax then
  checkHP(vitals.hpcur, vitals.hpmax)
end
if vitals.spcur and vitals.spmax then
  checkSP(vitals.spcur, vitals.spmax)
end
if vitals.gp1cur and vitals.gp1max then
  checkFort(vitals.gp1cur, vitals.gp1max)
end
if vitals.gp2cur and vitals.gp2max then
  checkControlLevel(tonumber(vitals.gp2cur), tonumber(vitals.gp2max))
end

There is a ticker included with some hooks defined as above, but you might want to make your own or do other things once a round.

A speedwalker and a stepper are included with some common 3k areas and paths.
Currently the party functionality involves editing the scripts by hand to include your party members and sometimes oddly named followers under the "Scripts" menu and then open "paulWalker" and then click on the "walker" script.  Toward the top there is a line like the following which needs to contain the lowercase names of all party members except you.  You can replace a name which is there or follow the list syntax
stepperBot.partyMembers = { "hsima", "uq", "eddy", "eagleeyes", "hawkeyes" }
if you don't it will skip the room any time it sees a player who isn't on this list.

The line below it in the same script file needs to contain any mobs you don't want to fight
stepperBot.badmobs = { "ron", "broodling", "storm servant", "valithyn", 
    "kinky-looking black mamba", "tholen", "white barn owl", "wandering spider",
    "tiny silver toaster", "avatar of", "aerial servant", "storm servant",
    "small wandering spider", "cargo truck named", "massive %a+ wolf", 
    "game hunter", "park ranger", "packy the packmule", "tank named", 
    "sugger support mech", "permit officer", "vampire", "asp caterpillar",
    "bunyip", "three headed", "droid", "puddle of slime", "squire", 
    "phr", "queen's elite guardswoman", "princess qi", "alphabet serial killer",
    "cleric of lathander", "support mech", "truck named", "jeep named" }
Currently this is mine and it is hard coded so that's not ideal.  Making this more user friendly is high on my todo list.