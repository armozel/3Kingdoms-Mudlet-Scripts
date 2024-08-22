
lastEnemyHealth=100
lastMitigateLevel=5
lastBloodRushLevel=0
lastBoostLevel=0
lastPerceiveLevel=0
lastRootLevel=0
lastAmplifyLevel=0
maxAmplifyLevel=0
maxBloodRushLevel=0
maxRootLevel=0
maxBoostLevel=0

shielding=false
tanking=false
brawling=false
inCombat=false
totalBrawlerDamage=0
highBrawlerHit=0
lowBrawlerHit=10000
totalBrawlerRounds=0
brawlerdpr=0

totalDamageDone=0
totalRounds=0

lastControlLevel="Com"
controlNum=18
debugFlag=false
broodlings=0
maxBroodlings="22"
corpseHog=1
eminating=false
wrangling=false
flying=false
wrangled=false
overload=false
regen=1
partyspam=false
infesting=false
healbot=true
ktrig=true
boosting=true
assaulting=true
malicious=false
maliced=false
dogging=false
hitting=false
bubbling=false
bubbleTarget="eradan"
bubbleThreshold=220
tankname=false
myFortitude = 1000
conditions = {}

function SendNoEcho(stuff)
    send(stuff, false)
end

function doNewBroodling()
 broodlings=broodlings+1
 SendNoEcho("brood name ",(broodlings))
end

function printMenu()

SendNoEcho("ptell ---------------------------------------")
SendNoEcho("ptell |..........HSIMA'S MENU...............|")
SendNoEcho("ptell |.....................................|")
SendNoEcho("ptell |.........PTELL MENU: This Screen.....|")
SendNoEcho("ptell |.PTELL BUBBLE NEW #: Create bubble ..|")
SendNoEcho("ptell |.....................trigger at X....|")
SendNoEcho("ptell |.PTELL BUBBLE SET #: Set bubble .....|")
SendNoEcho("ptell |.....................trigger at X....|")
SendNoEcho("ptell |PTELL BUBBLE STATUS: Print current #.|")
SendNoEcho("ptell |...........OW HSIMA: Mitigate you....|")
SendNoEcho("ptell |.....................(reduce damage).|")
SendNoEcho("ptell |..........TAP HSIMA: Amplify you.....|")
SendNoEcho("ptell |.....................(and your party)|")
SendNoEcho("ptell |..........BEG HSIMA: control heal....|")
SendNoEcho("ptell |.......PTELL FOLLOW: For re-follow...|")
SendNoEcho("ptell |......PTELL CONTROL: Control Level...|")
SendNoEcho("ptell |.....................................|")
SendNoEcho("ptell ---------------------------------------")

end

function checkCombatStart()
  
  
  if (not inCombat) then
  	SendNoEcho("subvert")
  	if (tankname) then
        SendNoEcho("amplify "..tankname)
  	end
  	if (lastBloodRushLevel > 0) then
	  	SendNoEcho("bloodrush")
  	end
  	if (lastRootLevel > 0) then
	  	SendNoEcho("root brood")
  	end

  	inCombat = true
  end
end

function checkControlLevel(currentLevel,maxLevel)
	if (currentLevel and maxLevel and currentLevel ~= lastControlLevel) then
	 lastControlLevel=currentLevel
   controlNum = (currentLevel/maxLevel) * (100) 
   controlNum = math.floor(controlNum + 0.5)
	end
end

function toggleCorpsehog()
 if (corpseHog > 0) then
  corpseHog=0
  SendNoEcho("pt Leaving Corpses Now, Still Enveloping")
 elseif ( corpseHog == 0 ) then
  corpseHog=-1
  SendNoEcho("pt Not going anything to corpses.")
 elseif ( corpseHog < 0 ) then
  corpseHog=1
  SendNoEcho("pt Destroying corpses after Enveloping.")
  end
end

function echoBroodLevel(currentLevel)
if (debugFlag) then
 echo("\n"..currentLevel..".."..broodlings)
end
if (currentLevel ~= broodlings) then
 broodlings = currentLevel
end
end

function toggleTanking()

  if (tanking) then
   tanking=false
   SendNoEcho("pt Healing mode now: Normal")
  else
   tanking=true
   SendNoEcho("focus prevent enormous")
   SendNoEcho("pt Healing mode now: High SP Efficiency Tanking")
  end
end

function toggleHitting()
 if (corpseHog > 0) then
	echo("\nTurn down corpsehog before turning on hitting mode.")
 else
  if (hitting) then
   hitting=false
   SendNoEcho("pt Corpse mode now: Tank")
  else
   hitting=true
   SendNoEcho("pt Corpse mode now: Hitter")
  end
 end
end

function toggleAssaulting()
 if (assaulting) then
  assaulting=false
  SendNoEcho("pt Autoassaulting Off")
 else
  assaulting=true
  SendNoEcho("pt Autoassaulting On")
 end
end

function toggleDogging()
 if (dogging) then
  dogging=false
  SendNoEcho("pt Corpse mode now: No Dog")
 else
  dogging=true
  SendNoEcho("pt Corpse mode now: Dog Hog")
 end
end

function toggleInfesting()
 if (infesting) then
  infesting=false
  SendNoEcho("pt Infesting Disabled")
 else
  infesting=true
  SendNoEcho("pt Infesting Enabled")
 end
end

function toggleWrangling()
 if (wrangling) then
  wrangling=false
  echo("\nWrangling Disabled")
 else
  wrangling=true
  echo("\nWrangling Enabled")
 end
end

function toggleMalice()
 if (malicious) then
  malicious=false
  echo("\nMalice Disabled")
 else
  malicious=true
  echo("\nMalice Enabled")
 end
end

function toggleBoosting()
 if (boosting) then
  boosting=false
  echo("\nBoosting Disabled")
 else
  boosting=true
  echo("\nBoosting Enabled")
 end
end

function toggleFlying()
 if (flying) then
  flying=false
  SendNoEcho("pt Flying Disabled")
 else
  flying=true
  SendNoEcho("pt Flying Enabled")
 end
end

function toggleHealbot()
 if (healbot) then
  healbot=false
  echo("\nHealbot Disabled")
 else
  healbot=true
  echo("\nHealbot Enabled")
 end
end

function togglePartyspam()
 if (partyspam) then
  partyspam=false
  echo("\nPartyspam Disabled")
 else
  partyspam=true
  echo("\nPartyspam Enabled")
 end
end

function toggleEminating()
 if (corpseHog > 0) then
	echo("\nTurn down corpsehog before turning on eminating.")
 else
  if (eminating) then
   eminating=false
   echo("\nEminating Disabled")
  else
   eminating=true
   echo("\nEminating  Enabled")
  end
 end
end

function setRegen(currentRegenLevel)

 if regen ~= currentRegenLevel then
  regen=currentRegenLevel
  if (regen == 1) then
	SendNoEcho("4")
  end
  if (regen == 2) then
	SendNoEcho("6")
  end
  if (regen == 3) then
	SendNoEcho("7")
  end
  if (regen == 4) then
	SendNoEcho("8")
  end
  if (regen == 5) then
	SendNoEcho("9")
  end
  if (regen == 6) then
	SendNoEcho("10")
  end
  
 else
  return
 end
end

function toggleOverload()
 if (overload) then
  overload=false
  SendNoEcho("overload off")
  echo("\nOverload Disabled")
 else
  overload=true
  SendNoEcho("overload on")
  SendNoEcho("wake hsima")
  SendNoEcho("wake hsima")
  SendNoEcho("wake hsima")
  SendNoEcho("wake hsima")
  SendNoEcho("ptell Red Warrior is about to DIE!")
  echo("\nOverload Enabled")
 end
end

function checkHP(currentHP, maxHP)


  hurtHP1 = maxHP * .99 
  hurtHP2 = maxHP * .95 
  hurtHP3 = maxHP * .90 
  hurtHP4 = maxHP * .85 
  hurtHP5 = maxHP * .80 
  hurtHP6 = maxHP * .75 
  dodgeHP = maxHP * .40
  dyingHP = maxHP * .30


  if ( healbot and (currentHP > hurtHP1) ) then
	setRegen(1)
  end
  if ( healbot and (currentHP > hurtHP2) and (currentHP < hurtHP1) ) then
	setRegen(2)
  end
  if ( healbot and (currentHP > hurtHP3) and (currentHP < hurtHP2) ) then
	setRegen(3)
  end
  if ( healbot and (currentHP > hurtHP4) and (currentHP < hurtHP3) ) then
	setRegen(4)
  end
  if ( healbot and (currentHP > hurtHP5) and (currentHP < hurtHP4) ) then
	setRegen(5)
  end
  if ( healbot and (currentHP < hurtHP5) ) then
	setRegen(6)
  end
  if ( not(overload) and (currentHP < dyingHP) ) then
	toggleOverload()
  end
  if ( not(overload) and (currentHP < dyingHP) ) then
	toggleOverload()
  end

  if ( currentHP < dodgeHP ) then
	SendNoEcho("wake hsima")
	SendNoEcho("wake hsima")
	SendNoEcho("boost")
	SendNoEcho("perceive")
	SendNoEcho("ptell Red Warrior Needs Food Badly!")
	echo("\nOverload Enabled")

  end

  if ( overload and (currentHP > hurtHP1) ) then
	toggleOverload()
  end
end

function dogCheck(dogHP, maxDogHP, happiness, hunger)
 
 hurtDogHp = maxDogHP * .95
 feedDogAmt = 20
 if (hunger > feedDogAmt) then
	SendNoEcho("unwrap")
	SendNoEcho("dog feed")
 end
end

function checkSP(currentSP, maxSP)
  okSP = maxSP * .9
  dyingSP = maxSP * .2
  if (debugFlag) then
	echo("\nokSP"..okSP.. " dyingSP: "..dyingSP)
  end
  if ( (currentSP > okSP) and (inCombat) and (assaulting) and (controlNum>50)) then
	SendNoEcho("assault")
  end
  if ( isHurt("SP") and (currentSP > okSP) ) then
	unsetHurt("SP")
  end
  if ( (currentSP < dyingSP) ) then
	setHurt("SP")
  end
end

function checkFort(currentFort, maxFort)

  if (maxFort == 0) then
	return -- remerging and nothing maters
  end

  okFort = maxFort * .9
  lowFort = maxFort * .8
  dyingFort = 100
 
  if ( (currentFort > okFort)) then
	unsetHurt("Fort")
  end

  if ( (currentFort < lowFort) ) then
	setHurt("Fort")
  end

  if ( (currentFort < dyingFort) ) then
	SendNoEcho("unwrap")
	SendNoEcho("boost")
	SendNoEcho("envelop corpse")
	SendNoEcho("collect dna from corpse")
	SendNoEcho("icof")
  end

end

function checkOverload(currentOverload, decimalOverload, overloadString)

  okOverload = 20
  dyingOverload = 70
  if (debugFlag) then
 	 echo("\nokOverload",okOverload, 
		" dyingOverload: ",dyingOverload)
  end
  if ( healbot and (currentOverload < okOverload)) then
	unsetHurt("Overload")
  end

  if ( healbot and (currentOverload > dyingOverload) ) then
	setHurt("Overload")
  end
end

function isHurt(newCondition)
	if (conditions[newCondition] == nil) then
		return false
	else
		return conditions[newCondition]
	end
end

function setHurt(newCondition)
	if (conditions[newCondition] ~= nil) then
		if(conditions[newCondition]) then
			return
		else
			echo("\nSetting Hurt Condition: ", newCondition)
			conditions[newCondition] = true
		end
	else
		echo("\nSetting Hurt Condition: ", newCondition)
		conditions[newCondition] = true
	end
end

function unsetHurt(newCondition)
	if (conditions[newCondition] == nil) then
		conditions[newCondition] = false
	elseif(conditions[newCondition]) then
		echo("\nRemove Hurt Condition: ".. newCondition)
		conditions[newCondition] = false
	else
		return
	end
	
end


function doPerceive(perceiveLevel)
	if (lastPerceiveLevel ~= perceiveLevel) then
		SendNoEcho("pt Perceives Left: "..perceiveLevel)
		lastPerceiveLevel = perceiveLevel
	end
end

function doBoosts(boostLevel)
	if (lastBoostLevel ~= boostLevel) then
		lastBoostLevel = boostLevel
	end
	if (lastBloodRushLevel > maxBoostLevel) then
		maxBoostLevel=lastBoostLevel
	end
end

function doShields(shieldString)
 if (shieldString == "Off") then
	shielding = false
 else
	shielding = true
 end
end

function doAmplify(amplifyLevel)
	if (lastAmplifyLevel ~= amplifyLevel) then
		lastAmplifyLevel = amplifyLevel
	end
	if (lastAmplifyLevel > maxAmplifyLevel) then
		maxAmplifyLevel=lastAmplifyLevel
	end
end
function doBloodRush(bloodRushLevel)
	if (lastBloodRushLevel ~= bloodRushLevel) then
		lastBloodRushLevel = bloodRushLevel
	end
	if (lastBloodRushLevel > maxBloodRushLevel) then
		maxBloodRushLevel=lastBloodRushLevel
	end
end

function doRoot(rootLevel)
	if (lastRootLevel ~= rootLevel) then
		lastRootLevel = rootLevel
	end
	if (lastRootLevel > maxRootLevel) then
		maxRootLevel=lastRootLevel
	end
end

function doMitigate(mitigateLevel)
	if (lastMitigateLevel ~= mitigateLevel) then
		SendNoEcho("pt Mitigates Left: "..mitigateLevel)
		lastMitigateLevel = mitigateLevel
	end
end

function pickUp(stuff)
	if (stuff == nil or stuff == '') then
		stuff=false
	end
	if (stuff) then
		echo("\nPicking up " .. stuff)
	else
		echo("\nPicking up everything")
	end
	if (flying) then
		if (not(stuff)) then
			SendNoEcho("gather all")
		else
			SendNoEcho("gather " .. stuff)
		end
	else
 		if (not(stuff)) then
			SendNoEcho("get all")
		else
			SendNoEcho("get " .. stuff)
		end
	end
end

function pickUpGold()
	if (flying) then
		SendNoEcho("gather gold")
	else
		SendNoEcho("get gold")
	end	
end

function massInfest( howMany )

	if ( howMany) then
		echo("\nInfesting ".. howMany.." corpses!")
		for i=1,howMany,1 do
			SendNoEcho("infest corpse ".. i)
		end
	else
		SendNoEcho("infest")
	end
end

function printEnv()
  echo("\nHealbot: "..healbot)
  echo("\nCorpsehog: "..corpseHog)
  echo("\nInfesting: "..infesting)
  echo("\neminating (emenating):".. eminating)
  echo("\nWrangling: "..wrangling)
  echo("\nWrangled: "..wrangled)
  echo("\nFlying: "..flying)
  echo("\nRegen: "..regen)
  echo("\nOverload: ".. overload)
  echo("\nPartyspam: ".. partyspam)
  echo("\nktrig: ".. ktrig)
  echo("\nboosting: ".. boosting)
  echo("\nmalicious: ".. malicious)
  echo("\nmaliced: "..maliced)
  echo("\ndogging: "..dogging)
  echo("\nhitting: "..hitting)
  echo("\ntankname: "..tankname)
  echo("\nassaulting: "..assaulting) 
  echo("\ncontrol: "..lastControlLevel) 
end

function startBubble(newTarget, newThreshold)
	echo("\nbubble "..bubbleTarget.." "..bubbleThreshold)
	echo("\nnewtarget ".. newTarget.. 
		" newThreshold ".. newThreshold)
	
	bubbleTarget = newTarget

	if (bubbling) then
		SendNoEcho("bubble off")
	end
	bubbleThreshold = newThreshold
	bubbling = true
	echo("\nbubble "..bubbleTarget.." "..bubbleThreshold)
	SendNoEcho("bubble "..bubbleTarget.." "..bubbleThreshold)
end

function stopBubble()
	if (bubbling) then
		SendNoEcho("bubble off")
	end
	bubbleTarget = "none"
	bubbleThreshold = 3000
	bubbling = false
end
function bubble_trigger (name, line, wildcards, styles)
  for k, v in ipairs (styles) do
     print ("Style ".. k.. 
            " contents = ".. v.text..
            " colour = ".. RGBColourToName (v.textcolour))
	if ((k==1) and (RGBColourToName (v.textcolour)~="yellow")) then
		return;

	else
		if (k==2) then
			stuff=string.match(v.text, '^%a*:(%a*)$')
			print(stuff)
		end
	end
  end -- for loop
end

function checkBubble()
	if (bubbling) then
		SendNoEcho("ptell bubbling "..bubbleTarget.."@"..bubbleThreshold)
	else
		SendNoEcho("ptell Bubble not active")
	end
end

function setBubble(newTarget, newCommand, newThreshold)
	echo("\nbubble ".. 
		bubbleTarget.." "..bubbleThreshold..
		" newTarget ".. newTarget..
		" newCommand ".. newCommand..
		" newThreshold ".. newThreshold)

  if (newCommand == "new") then
	bubbling = true
	bubbleTarget = newTarget
 	bubbleThreshold = newThreshold
	SendNoEcho("bubble off")
	SendNoEcho("bubble "..bubbleTarget.." "..bubbleThreshold)
	SendNoEcho("ptell Starting to bubble "..bubbleTarget.."@"..bubbleThreshold)
  else
	if (bubbling) then
		bubbleThreshold = newThreshold
		SendNoEcho("bubble off")
		SendNoEcho("bubble "..bubbleTarget.." "..bubbleThreshold)
		SendNoEcho("ptell bubbling "..bubbleTarget.."@"..bubbleThreshold)
	else
		SendNoEcho("ptell Bubble not active")
	end
  end
end

function setTankName(newTarget)
	tankname = newTarget

	echo("\nTank is now "..tankname..".")
end

function ThreeKlient.mip.vitalUpdateHook()
  local vitals=ThreeKlient.mip.vitals
  if vitals.enemyname and string.len(vitals.enemyname) == 1 then
    inCombat = false
  else
    inCombat = true
  end 
end