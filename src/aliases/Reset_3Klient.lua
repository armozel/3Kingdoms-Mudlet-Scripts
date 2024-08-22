local vitals = ThreeKlient.mip.vitals
vitals.enemyname = 'Enemy'
walker_active = false
walker_killing = false
walker_position = 1
send("brief on yes", false)
send("aset look_monster bkred")
send("aset room_short bkmagenta")
send("aset look_player bkgreen")
send("prompt >$nl$")
stepperBot.fighting = false

stepperBot.partyMembers = { "uq", "eddy", "eagleeyes" }
stepperBot.badmobs = { "ron", "broodling", "storm servant", "valithyn", 
    "kinky-looking black mamba", "tholen", "white barn owl", "wandering spider",
    "tiny silver toaster", "avatar of", "aerial servant", "storm servant",
    "small wandering spider", "cargo truck named", "massive %a+ wolf", 
    "game hunter", "park ranger", "packy the packmule", "tank named", 
    "sugger support mech", "permit officer", "vampire", "asp caterpillar",
    "bunyip", "three headed", "droid", "puddle of slime", "squire", 
    "phr", "queen's elite guardswoman", "princess qi", "alphabet serial killer",
    "cleric of lathander", "support mech" }
