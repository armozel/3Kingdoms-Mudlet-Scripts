-- Run these commands as your player to enable this script to work
-- aset look_monster bkred
-- aset room_short bkmagenta
-- aset look_player bkgreen
-- prompt >$nl$
--  Corpse Trigger that looks something like:
--     if ( corpseHog > 0 and ((matches[2] == 'Hsima') or (matches[2] == "Hsima's broodlings"))) then
-- 		raiseEvent("walkerKillingBlow")
-- 		inCombat = false
-- 	end

stepperBot = stepperBot or {}
stepperBot.handlerID = stepperBot.handlerID or {}
stepperBot.paths = stepperBot.paths or {}
stepperBot.badmobs = stepperBot.badmobs or {}
stepperBot.partyMembers = stepperBot.partyMembers or {}
stepperBot.fighting = stepperBot.fighting or false

stepperBot.partyMembers = { "hsima", "uq", "eddy", "eagleeyes", "hawkeyes" }
stepperBot.badmobs = { "ron", "broodling", "storm servant", "valithyn", 
    "kinky-looking black mamba", "tholen", "white barn owl", "wandering spider",
    "tiny silver toaster", "avatar of", "aerial servant", "storm servant",
    "small wandering spider", "cargo truck named", "massive %a+ wolf", 
    "game hunter", "park ranger", "packy the packmule", "tank named", 
    "sugger support mech", "permit officer", "vampire", "asp caterpillar",
    "bunyip", "three headed", "droid", "puddle of slime", "squire", 
    "phr", "queen's elite guardswoman", "princess qi", "alphabet serial killer",
    "cleric of lathander", "support mech", "truck named", "jeep named" }

stepperBot.paths["none"] = {}
stepperBot.paths["mj"] = {  "n", "portal", "e", "e", "e", "e", "e",
		"w", "w", "w", "w", "w", "w", "w", "w", "w", "n",
		"e", "e", "e", "e", "e", "e", "e", "e", "e", "ne",
		"w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "n",
		"e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "n",
		"w", "w", "ne", "e", "e", "nw", "n", "s", "sw",  "sw",
		"sw", "w", "w", "n", "nw", "n", "e", "nw", "sw", "e",
		"s", "s", "s", "nw", "s", "w", "nw", "w", "w", "nw", "e", 
		"e", "nw", "n", "s", "se", "se", "se", "s", "s", "s", "e",
		"e", "portal", "s" }
stepperBot.paths["pol"] = { "n", "n", "n", "n", "n", "n", "n", "ne",
	"s", "s", "s", "s", "s", "ne", "n", "n", "n", "s", "s", "se",
	"ne", "ne", "ne", "nw", "nw", "nw", "n", "nw", 
	"se", "se", "se", "se", "se", "se", "n", 
	"nw", "nw", "nw", "nw", "nw", "se", "ne", "se", "se", "se", 
	"n", "n", "n", "n", "n", "n", "nw", "s", "s", "s", "sw",
	"n", "n", "n", "n", "nw", "s", "s", "s", "s", "sw",
	"n", "n", "n", "sw", "s", "s", "s", "nw", "n", "sw", "n", "n",
	"ne", "n", "n", "ne", "se", "nw", "nw", "nw",
	"s", "s", "s", "s", "s", "sw", "n", "n", "n", "n", "n", "n", "sw",
	"s", "s", "s", "s", "s", "s", "n", "n", "nw", "n", "n", "n", "sw",
	"sw", "sw", "sw", "se", "se", "se", "s", "se", "se",
	"nw", "nw", "nw", "nw", "nw", "nw", "sw",
	"se", "se", "se", "se", "se", "se", "sw",
	"nw", "nw", "nw", "nw", "nw", "s", "se", "se", "se", "nw", "nw", 
	"nw", "s", "s", "s", "s", "ne", "ne", "ne", "se", "ne",
	"sw", "sw", "sw", "sw", "sw", "s", "ne", "ne", "ne", "ne", "ne",
	"ne", "sw", "sw", "s", "sw", "sw", "se", "se", "se", "se",
	"n", "n", "n", "ne", "n", "s", "s", "s", "s", "s", "se", "s", "s" }
	stepperBot.paths["pol2"]=stepperBot.paths["pol"]
	stepperBot.paths["pol3"]=stepperBot.paths["pol"]
stepperBot.paths["sb"] = {  "n", "w", "n", "n", "n", "n", "nw", "n", "ne", 
		"climb", "u", "d", "d", "sw", "s", "s", "s", "s", "s", 
		"s", "s", "s", "s", "s", "nw", "n", "n", "n", "n", "n", 
		"nw", "s", "s", "s", "s", "s", "s", "s", "s", "s", "nw", 
		"n", "n", "n", "n", "n", "n", "n", "n", "n", "s", "w", 
		"s", "s", "s", "s", "s", "w", "n", "n", "n", "n", "sw", 
		"s", "s", "nw", "e", "e", "e", "e", "e", "e", "se", "se", 
		"n", "n", "e",
		"e", "s", "s", "se", "n", "n", "n", "n", "n", "n", "n", 
		"ne", "s", "s", "s", "s", "s", "s", "s", "s", "s", "se",
		"n", "n", "n", "n", "n", "n", "n", "n", "n", "n", "n", 
		"ne", "s", "s", "s", "s", "s", "s", "s", "s", "s", "ne", 
		"n", "n", "n", "n", "n", "n", "n", "se", "s", "s", "s", "s", 
		"s", "e", "n", "n", "n", "n", "se", "s", "s", "s", "s", "s", 
		"se", "sw", "ne", "nw", "ne", "n", "n", "n", "se", 
		"w", "w", "w", "w", "w", "w", "w", "w", "nw", "nw", "nw", 
		"s", "s", "sw", "s" }
stepperBot.paths["anchorman"] = {"ne", "sw", "n", "n", "w", "e", "n", "e", "w", "n", "enter",
                    "e", "e", "w", "u", "d", "se", "nw", "w", "n", "n", "get all;glance",
                    "s", "w", "e", "s", "s", "s", "s", "s", "s"}
stepperBot.paths["zel"] = {"n", "n", "e", "w", "w", "n", "nw", "e", "e", "s", "n", "w", "n", "e", "e",
					"e", "w", "s", "s", "search ledges;glance", "get gloves;glance", "n", "n", "w", "w", "w", "s",
					"get key;glance", "n", "e", "e", "n", "e", "n", "s", "w", "s", "e", "s", "s", "e", "e", "e", "n",
					"n", "e", "e", "n", "n", "w", "w", "s", "s", "s", "e", "e", "e", "n", "n", "n", "n", "w", "w", "w",
					"w", "s", "s", "s", "s", "unlock door;glance", "open door;glance", "w", "get key;glance", "e", "n",
					"n", "n", "n", "e", "e", "e", "e", "s", "s", "s", "s", "w", "w", "w", "s", "w", "w", "w", "n", "n",
					"w", "w", "n", "unlock door;glance", "open door;glance", "w", "w", "s", "s", "sw", "w", "w", "w", "n",
					"nw", "e", "n", "e", "e", "nw", "w", "ne", "w", "e", "se", "se", "ne", "e", "e", "e", "w", "w", "w", "sw",
					"s", "w", "w", "w", "w", "se", "e", "e", "e", "s", "ne", "n", "n", "e", "e", "s", "w", "s", "se", "s", "e", "s", "s"}
stepperBot.paths["spirit"] = {"doorway", "onward", "doorway", "get all;glance",
                    "onward", "doorway", "get all;glance",
                    "onward", "doorway", "get all;glance",
                    "onward", "doorway", "get all;glance",
                    "onward", "doorway", "get all;glance",
                    "onward", "doorway", "get all;glance",
                    "onward", "doorway", "get all;glance",
                    "onward", "doorway", "get all;glance",
                    "onward", "doorway", "get all;glance",
                    "light", "will"}

stepperBot.paths["chins"] = { "e", "e", "e", "e", "e", "n", "w", "w", "w", "w", "w", "n",
								"e", "e", "e", "e", "e", "n", "w", "w", "w", "w", "w", "n",
								"e", "e", "e", "e", "e", "w", "w", "w", "w", "w", 
								"s", "s", "s", "s"}
stepperBot.paths["dftree"] = { "n", "w", "w", "w", "ne", "ne", "n", "n", "nw",
        "sw", "n", "sw", "n", "nw", "ne", "s", "u", "pick fruit;glance", "get seed;glance", "d",
        "n", "sw", "se", "s", "ne", "s", "sw", "nw", "nw", "nw", "ne", "ne", "ne", "ne",
         "ne", "ne", "e", "e", "se", "se", "se", "se", "se", "se", "sw", "sw", "sw", "nw", "n",
        "se", "n", "ne", "nw", "s", "u", "pick fruit;glance", "get seed;glance", "d", "n",
        "se", "sw", "s", "nw", "s", "nw", "sw", "s", "s", "se", "se", "w", "w", "w", "s" } 
stepperBot.paths["veg"] = { "n", "n", "n", "n", "e", 
        "s", "s", "s", "s", "e", "n", "n", "n", "n", "e",
        "s", "s", "s", "s", "e", "n", "n", "n", "s", "s", "s", "w",
        "n", "n", "n", "n", "w", "s", "s", "s", "s", "w",
        "n", "n", "n", "n", "w", "s", "s", "s", "s"}
stepperBot.paths["rimalkin"] = { "e", "ne", "se", "n", "nw", "se", "s", "se", "nw", "s",
      "sw", "w", "n", "e", "d", "n", "nw", "ne", "sw", "se", "s",
      "u", "n", "w", "w" }
stepperBot.paths["alphabet"] = { "s", "s", "e", "w", "n", "e", "e", "e", "e", "s", "n",
      "w", "w", "s", "s", "w", "w", "s", "n", "e", "e", "e", "n", "s","s", "n", "e", "s", 
	  "s", "e", "w", "w", "w", "w", "w", "e", "n","e", "w", "s", "e", "e", "e", "n", "n", 
	  "w", "w", "n", "n", "w", "w", "n"}
stepperBot.paths["brigands"] = { "w", "w", "w", "w", "n", "e", "e", "e", "e", "e",
      "n", "w", "w", "w", "n", "w", "s", "n", "e", "ne", "s", "s", "e", "n",
	  "n", "e", "s", "s", "s", "e", "e", "se", "nw", "ne", "ne", "sw", "sw", "w", "w", "s", "w"}
stepperBot.paths["hotel"] = {"n", "e", "n", "e", "n", "e", "n", "e", "n", "e", "n", "e",
      "n", "e", "n", "e", "w", "w", "w", "s", "w", "s", "w", "s", "w", "s", "w", "s",
       "w", "s", "n", "n", "n", "e", "n", "e", "n", "e", "n", "e", "w", "w",
       "w", "s", "w", "s", "n", "n", "s", "s", "s", "s", "s", "s", "s", "s" }
stepperBot.paths["dundee"] = {"e", "get all;glance", "n", "get all;glance", "n", "get all;glance",
     "e", "get all;glance", "e", "get all;glance", "e", "get all;glance", "e", "get all;glance",
     "e", "get all;glance", "e", "get all;glance", "e", "get all;glance", "e", "get all;glance",
      "e", "get all;glance", "e", "get all;glance", "s", "get all;glance",
     "w", "get all;glance", "w", "get all;glance", "w", "get all;glance", "w", "get all;glance", 
     "w", "get all;glance", "w", "get all;glance", "w", "get all;glance", "w", "get all;glance",
      "w", "get all;glance", "w", "get all;glance", "s", "get all;glance",
     "e", "get all;glance", "e", "get all;glance", "e", "get all;glance", "e", "get all;glance",
     "e", "get all;glance", "e", "get all;glance", "e", "get all;glance", "e", "get all;glance",
      "e", "get all;glance", "e", "get all;glance", "s", "get all;glance",
     "w", "get all;glance", "w", "get all;glance", "w", "get all;glance", "w", "get all;glance", 
     "w", "get all;glance", "w", "get all;glance", "w", "get all;glance", "w", "get all;glance",
      "w", "get all;glance", "w", "get all;glance", "s", "get all;glance",
     "e", "get all;glance", "e", "get all;glance", "e", "get all;glance", "e", "get all;glance",
     "e", "get all;glance", "e", "get all;glance", "e", "get all;glance", "e", "get all;glance",
      "e", "get all;glance", "e", "get all;glance",
     "w", "get all;glance", "w", "get all;glance", "w", "get all;glance", "w", "get all;glance", 
     "w", "get all;glance", "w", "get all;glance", "w", "get all;glance", "w", "get all;glance",
      "w", "get all;glance", "w", "get all;glance",      
     "n", "get all;glance", "n", "get all;glance", "w" }
stepperBot.paths["dundee2"] = {"e", "get all;glance", "n", "get all;glance", "n", "get all;glance",
     "e", "get all;glance", "e", "get all;glance", "e", "get all;glance", "e", "get all;glance",
     "e", "get all;glance", "e", "get all;glance", "e", "get all;glance", "s", "get all;glance",
     "w", "get all;glance", "w", "get all;glance", "w", "get all;glance", "w", "get all;glance", 
     "w", "get all;glance", "w", "get all;glance", "s", "get all;glance", "e", "get all;glance",
     "e", "get all;glance", "e", "get all;glance", "e", "get all;glance", "e", "get all;glance",
     "e", "get all;glance", "s", "get all;glance", "w", "get all;glance", "w", "get all;glance",
     "w", "get all;glance", "w", "get all;glance", "w", "get all;glance", "w", "get all;glance", 
     "s", "get all;glance", "e", "get all;glance", "e", "get all;glance", "e", "get all;glance",
     "e", "get all;glance", "e", "get all;glance", "e", "get all;glance", "w", "get all;glance",
     "w", "get all;glance", "w", "get all;glance", "w", "get all;glance", "w", "get all;glance",
     "w", "get all;glance", "w", "get all;glance", "n", "get all;glance", "n", "get all;glance",
     "w" }
stepperBot.paths["mammon"] = { "n", "e", "e", "ne", "n", "n", "n", "n", "n", "n", "w", "w", "w", "w", "w", "w", "s", "s", "s",
      "s", "s", "s", "e", "e", "e", "e", "n", "n", "n", "n", "w", "w", "s", "w", "e", "s", "e", "w", "n", "n", "e", "e", "s", 
      "s", "s", "s", "w", "w", "w", "w", "n", "n", "n", "n", "n", "n", "e", "e", "e", "e", "e", "e", "s", "s", "s", "s", "s", 
      "s", "sw", "w", "w", "s" }
stepperBot.paths["battleground"] = { "e", "e", "e", "e", "e", "e", "e", "n", "w", "w", "w", "w", "w", "w", "w", "n",
        "e", "e", "e", "e", "e", "e", "e", "n", "w", "w", "w", "w", "w", "w", "w", "n",
        "e", "e", "e", "e", "e", "e", "e", "n", "w", "w", "w", "w", "w", "w", "w", "n",
        "e", "e", "e", "e", "e", "e", "e", "n", "w", "w", "w", "w", "w", "w", "w",
        "s", "s", "s", "s", "s", "s", "s" }
stepperBot.paths["wh"] = { "w", "w", "n", "n", "s", "s", "w", "u",
		"e", "n", "e", "w", "n", "n", "e", "n", "w", "e", "e",
		"w", "s", "e", "e", "n", "s", "w", "s", "w", "e", "s",
		"s", "w", "e", "e", "n", "n", "s", "s", "e", "u", "w",
		"w", "n", "enter", "n", "n", "w", "w", "s", "s", "e",
		"n", "se", "s", "s", "e", "e", "d", "d", "w", "w", 
		"n", "n", "e", "n", "s", "w", "n", "n", "e", "w", "w", "e",
		"s", "w", "w", "e", "e", "s", "s", "w", "n", "s", "e", "s" }
stepperBot.paths["chess"] = { "w", "w", "w", "s", "s", "s", "e", "e", "e", "e", "e", "e", "e",
		"n", "w", "w", "w", "w", "w", "w", "n", "e", "e", "e", "e", "e", "e",
		"n", "w", "w", "w", "w", "w", "w", "n", "e", "e", "e", "e", "e", "e",
		"n", "w", "w", "w", "w", "w", "w", "n", "e", "e", "e", "e", "e", "e",
		"n", "w", "w", "w", "w", "w", "w", "w",  "s", "s", "s", "s", "e", "e", "e" }
stepperBot.paths["z"] = { "nw", "s", "s", "n", "e", "e", "s", "d",  -- 00
        "w", "sw", "se", "e", "u", -- 01
        "s", "s", "e", "e", "u", -- 02
        "e", "w", "n", "ne", "w", "w", "u", -- 04
        "n", "n", "sw",	"nw", "s", "s", "u", -- 06
        "n", "e", "e", "nw", "u", -- 05
        "e", "e", "w", "s", "s", "d", -- 07
        "s", "n", "n", "se", "se", "n", "n", "s", "u", -- 11
        "e", "e", "sw", "s", "u", -- 09
        "n", "n", "sw", "w", "s", "d", -- 06
        "w", "w", "s", "s", "e", "e", "n", "w", "d", -- 12
        "s", "s", "ne", "ne", "s", "s", "u", -- 14
        "w", "w", "n", "n", "e", "s", "n", "e", "d", 
        "w", "w", "s", "s", "e", "e", "d", 
        "se", "s", "n", "w", "w", "s", "d", 
        "n", "s", "s", "n", "e", "e", "s", "n", "n", "se", "e", "e", "se", "se", "proceed", 
        "sw", "s", "d", "n", "n", "se", "se", "n", "n", "u", 
        "s", "s", "nw", "nw", "d", 
        "e", "e", "sw", "w", "s", "e", "e", "u", 
        "e", "e", "sw", "s", "u",  
        "w", "w", "s", "e", "e", "s", "w", "w", "d", 
        "sw", "s", "d", "n", "n", "se", "se", "n", "n", "d", 
        "se", "s", "w", "d", "n", "n", "e", "d", 
        "w", "s", "e", "e", "d", "n", "nw", "u", 
        "s", "s", "n", "w", "nw", "s", "s", "u", 
        "s", "s", "ne", "ne", "s", "s", "d", 
        "sw", "s", "u", "se", "s", "d", 
        "w", "ne", "w", "n", "e", "e", "u", 
        "w", "w", "s", "s", "e", "e", "n", "w", "u", 
        "n", "n", "se", "ne", "s", "s", "d", 
        "e", "w", "w", "s", "e", "sw", "e", "e", "e", "e", "proceed", 
        "s", "w", "d", "s", "se", "n", "e", "n", "u", 
		"w", "w", "s", "e", "w", "s", "e", "e", "d", 
		"n", "e", "nw", "e", "e", "d", 
		"s", "n", "e", "se", "n", "n", "d", 
		"w", "w", "s", "e", "w", "s", "e", "e", "d", 
		"n", "w", "w", "s", "enter portal", 
		"w", "w", "n", "n", "u", "s", "se", "ne", "n", "d", 
		"e", "w", "w", "n", "e", "ne", "w", "w", "d", 
		"se", "n", "n", "s", "w", "w", "s", "n", "n", "d", 
		"e", "nw", "nw", "e", "d", 
		"w", "w", "s", "e", "e", "s", "w", "w", "u", 
		"w", "w", "enter portal", "n", "e", "s", "w", "w", "n", "n", "e", "e", "d", 
		"se", "w", "s", "e", "e", "d", 
		"se", "w", "w", "n", "d", 
		"n", "nw", "se", "ne", "e", "e", "e", "se", "se", "e", "e", "ne", "e" 
		}
stepperBot.paths["aegis"] = { "e", "e", "s", "e", "e", "s", "w", "s", "w", "n",
	"w", "s", "e", "s", "e", "s", "e", "n", "e", "s", "e", "e",
	"n", "w", "s", "w", "n", "n", "e", "e", "n", "w", "n", "w",
	"n", "e", "e", "d",
	"w", "n", "e", "w", "w", "s", "w", "w", "n", "w", "w", "w", "e",
	"s", "s", "e", "e", "e", "e", "e", "e", "e", "s", "w", "w", "w", 
	"w", "w", "w", "w", "w", "e", "s", "e", "e", "e", "e", "e", "e",
	"s", "w", "s", "w", "n", "w", "w", "w", "w", "e", "s", "e", "n",
	"e", "d",
	"w", "s", "e", "w", "n", "w", "n", "n", "w", "s", "s", 
	"n", "w", "e", "n", "w", "e", "n", "w", "e", "e", "n", 
	"w", "e", "n", "w", "e", "e", "w", "s", "e", "w", "s", "e", "s", 
	"n", "e", "s", "n", "e", "s", "n", 
	"e", "s", "n", "e", "e", "w", "s", "e", "w", "s", "e", "w", "s",
	 "e", "w", "s",
	"n", "w", "e", "n", "n", "n", "w", "n", "w", "e", "n", "s", "e", "d",
        }
C_WALKPRE = "\n<yellow>!!! <white>"

walker_position = walker_position or 1
walker_auto = walker_auto or false
walker_active = walker_active or false

function walkerEcho(s)
  cecho(C_WALKPRE .. s .. "\n")
end

function paul_walker()
  if (walker_active and #walker_mobs > 0 and walker_roomPlayers == 0) then
    cecho(C_WALKPRE .. "Stopping to fight mobs(" .. #walker_mobs..").\n")
    raiseEvent("walkerKill", walker_mobs[1])
  elseif (walker_active and walker_roomPlayers > 0) then
--    cecho (C_WALKPRE .. "I should move, because there is a person here.  Gross.\n")
    walker_step()
  elseif walker_active then
--  cecho ("\n<yellow>Nothing here, I should move!")
    walker_step()
  else
--  cecho ("\n<yellow>I shouldn't do anything!")
  end
end

function walker_step()
  if stepperBot and stepperBot.paths[walker_current_path] and walker_position <= #stepperBot.paths[walker_current_path] then
    send(stepperBot.paths[walker_current_path][walker_position], false)
    walker_position = walker_position + 1
  else
    cecho(C_WALKPRE .. "* * * PATH COMPLETE * * *\n")
    walker_active = false
    walker_position = 1
    raiseEvent("roomConsoleUpdate")
    send("brief on yes", false)
  end -- if
end -- walker_step


function walker_kb()
  if walker_active then
    walker_killing = false
    cecho(C_WALKPRE .. "Mob dead, next!")
    send("glance", false)
  end
end

local function t_has(tab, value)
  for i,v in ipairs(tab) do
    if string.match(value, v) then
      return true
    end
  end
  return false
end

function walker_kill(event, mob)
  walker_killing = true
  walker_mobs = {
    zombie = "zombie",
    vampire = "vampire$",
    branch = "branch$",
    guard = "guard$",
    crocodile = "crocodile$",
    swamphen = "swamphen$",
    amphiuma = "amphiuma$",
    snake = "snake$",
    mole = "mole$",
    frog = "frog$",
    sparrow = "sparrow",
    rimalkin = "rimalkin",
    angel = "angel",
    root = "root",
    spirit = "spirit",
    elemental = "elemental",
    imp = "imp",
    lion = "lion",
    tank = "tank",
    hound = "hound",
    tiger = "tiger",
    pirate = "pirate",
    velociraptor = "velociraptor",
    demon = "demon",
    refugee = "refugee",
    tornado = "tornado",
    flameroller = "flameroller",
    whore = 'whore',
	brigand = 'brigand',
    customer = 'customer',
    netta = 'netta',
    savon = 'savon',
    bertolo = 'bertolo',
	surgeon = 'surgeon',
	golem = 'golem',
	eye = 'eye',
	soldier = 'soldier',
	chinchilla = 'chinchilla',
	letter = 'letter',
	gun = 'gun'
  }

  cecho(C_WALKPRE .. "Trying to attack:"..mob.."!")

    if walker_mobs ~= {} then
      for k,v in pairs(walker_mobs) do
        if string.match(mob, v) then
          mob = k
        end
      end
    end
    send("kill "..mob,true)
end
if stepperBot.handlerID.walkerKillingBlow then killAnonymousEventHandler(stepperBot.handlerID.walkerKillingBlow) end
stepperBot.handlerID.walkerKillingBlow = registerAnonymousEventHandler("walkerKillingBlow", "walker_kb")
if stepperBot.handlerID.walkerKill then killAnonymousEventHandler(stepperBot.handlerID.walkerKill) end
stepperBot.handlerID.walkerKill = registerAnonymousEventHandler("walkerKill", "walker_kill")
if stepperBot.handlerID.walkerPaul then killAnonymousEventHandler(stepperBot.handlerID.walkerPaul) end
stepperBot.handlerID.walkerPaul = registerAnonymousEventHandler("walkerPaul", "paul_walker")
if stepperBot.handlerID.walkerStep then killAnonymousEventHandler(stepperBot.handlerID.walkerStep) end
stepperBot.handlerID.walkerStep = registerAnonymousEventHandler("walkerStep", "walker_step")

