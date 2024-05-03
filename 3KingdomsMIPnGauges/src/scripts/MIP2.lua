mip = mip or {}
mip.vitals = mip.vitals or {}

function mip:readMIP(code, lineLength)
  local currentLine = getCurrentLine()
  local entry = string.sub(currentLine, 15, lineLength + 14)
  mip:processMIP(code, entry)
  selectCurrentLine()
  deleteLine()
end

function mip:processMIP(code, entry)
	if code == "FFF" then
		mip:processVitals(entry)
	elseif code == "CAA" then
		mip:processChatReceived(entry)
	elseif code == "BAB" then
		mip:processTellReceived(entry)
	end
end

function mip:processVitals(entry)
	local code, hasUpdated = false
  
	for i, value in pairs(string.split(entry, "~")) do
    -- code pairs are held in a tilde separated string for example A~100~B~100~C~100~D~100
    -- which results in only the value indexes that have no remainder from modulus division (ex. 4 mod 2 = 0)
    -- being the value to be set and the code being all value indexes being modulus division with a remainder
    
    if i % 2 == 0 then
      hasUpdated = mip:setVitals(code, value)
    else
      code = value    
    end

	end

	if not hasUpdated then return end
  
  --echo("\nraising event mip.vitals\n")
	raiseEvent("mip.vitals")
end

function mip:setVitals(code, value)
  local hasUpdated = false
  echo("\ncode: " .. code .. " value: " .. value .. "\n")
  
  if code == "A" then
		-- hp current
		hasUpdated = true
		mip.vitals.hpcur = tonumber(value)
		
	elseif code == "B" then
		-- hp max
		hasUpdated = true
		mip.vitals.hpmax = tonumber(value)
		
	elseif code == "C" then
		-- sp current
		hasUpdated = true
		mip.vitals.spcur = tonumber(value)
		
	elseif code == "D" then
		-- sp max
		hasUpdated = true
		mip.vitals.spmax = tonumber(value)
		
	elseif code == "E" then
		-- gp1 current
		hasUpdated = true
		mip.vitals.gp1cur = tonumber(value)
	
	elseif code == "F" then
		-- gp1 max
		hasUpdated = true
		mip.vitals.gp1max = tonumber(value)
	
	elseif code == "G" then
		-- gp2 current
		hasUpdated = true
		mip.vitals.gp2cur = tonumber(value)
		
	elseif code == "H" then
		-- gp2 max
		hasUpdated = true
		mip.vitals.gp2max = tonumber(value)
		
	elseif code == "I" then
		-- gline1
		hasUpdated = true
		mip.vitals.gline1 = value
		
	elseif code == "J" then
		-- gline2
		hasUpdated = true
		mip.vitals.gline2 = value
		
	elseif code == "K" then
		-- enemy name
		hasUpdated = true
		mip.vitals.enemyname = value
		
	elseif code == "L" then
		-- enemy hp percentage
		hasUpdated = true
		mip.vitals.enemyhp = tonumber(value)
	end
  
  return hasUpdated
end

function mip:processChatReceived(entry)
	-- TODO add functionality
end

function mip:processTellReceived(entry)
	-- TODO add functionality
end