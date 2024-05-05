mip = mip or {}
mip.vitals = mip.vitals or {}

mip.codes = mip.codes or {
	CL_SEND_SOUND     = 'AAA', -- CL_SEND_SOUND 		AAA	sound			raw string
	CL_SEND_IMAGE     = 'AAB', -- CL_SEND_IMAGE 		AAB	image			Serialized table with keys: file, caption
	CL_SEND_REBOOT    = 'AAC', -- CL_SEND_REBOOT 		AAC	reboot		raw string
	CL_SEND_MUSIC     = 'AAD', -- CL_SEND_MUSIC 		AAD	music			serialized table with keys: file, iterations
	CL_SEND_UPTIME    = 'AAF', -- CL_SEND_UPTIME		AAD	uptime		raw string
	CL_SEND_AVI       = 'AAG', -- CL_SEND_AVI 	  	AAG	AVI				serialized table with keys: file, caption, height, width, iterations
	CL_DOWNLOAD_MEDIA = 'AAH', -- CL_DOWNLOAD_MEDIA	AAH	Download		a serialized table with file and url keys.
	CL_SEND_SPECIAL   = 'BAA', -- CL_SEND_SPECIAL 	  BAA	SendSpecial	raw string
	CL_SEND_TELL      = 'BAB', -- CL_SEND_TELL		  BAB	Tell				Serialized table with keys: incoming, from, text
	CL_SEND_SPECIAL2  = 'BAC', -- CL_SEND_SPECIAL2 	BAC	SndSpecial2	raw string
	CL_SEND_ROOM      = 'BAD', -- CL_SEND_ROOM	  	BAD	room				raw string (short decription) 
	CL_SEND_MUDLAG    = 'BAE', -- CL_SEND_MUDLAG 		BAE	mudlag			raw string
	CL_SEND_EDIT      = 'BAF', -- CL_SEND_EDIT      BAF	Edit				raw string
	CL_GP1_MASK       = 'BBA', -- CL_GP1_MASK 	  	BBA	gp1_mask		raw string
	CL_GP2_MASK       = 'BBB', -- CL_GP2_MASK 	  	BBB	gp2_mask		raw string
	CL_HP_MASK        = 'BBC', -- CL_HP_MASK 		BBC	hp_mask		raw string
	CL_SP_MASK        = 'BBD', -- CL_SP_MASK 		BBD	sp_mask		raw string
	CL_SEND_CAPTION   = 'CAP', -- CL_SEND_CAPTION 	CAP	caption		raw string 
             --		(If this is used, then (AAC), (AAF) and,  (BAE) literals are not)
	-- CDF,                     -- CL_SEND_BEGIN_FILE	CDF	Begin_file	not forwarded, handled internally.
	-- CCF,                     -- CL_SEND_CONT_FILE 	CCF	cont_file		not forwarded, handled internally.
	-- CEF,                     -- CL_SEND_END_FILE 	CEF	end_file		not forwarded, handled internally.
	CL_SEND_CHAT      = 'CAA', -- CL_SEND_CHAT 		CAA	chat				serialized table with keys: cmd, Line, Who, text
	CL_SEND_ROOMCODE  = 'DDD', -- CL_SEND_ROOMCODE	DDD	Roomexits		raw string
	CL_SEND_HPBAR     = 'FFF', -- composite	Serialized table with possible keys: cHP, mHP, cSP, mSP, cGP1,
             -- mGP1, cGP2, mGP2, gline1, gline2, EnemyName, EnemyHeath, attimg
             -- Note: the serialized table does not contain all values, just the ones
             -- the mud sent in the newest tag.
	}

-- ProcessCode[codeIndex]() is a function call by reference defined at the bottom of this file
-- most functions are stubs
function mip:readMIP(code, lineLength)
  local currentLine = getCurrentLine()
  local entry = string.sub(currentLine, 15, lineLength + 14)
  deleteLine()
  mip:processMIP(code, entry)
end

function mip:processMIP(code, entry)
	if code == mip.codes["CL_SEND_HPBAR"] then
		mip:processVitals(entry)
	elseif code == mip.codes["CL_SEND_TELL"] then
		mip:processTellReceived(entry)
  elseif code == mip.codes["CL_SEND_CHAT"] then
		mip:processChatReceived(entry)
	end

end

-- Function to split a string on a delimiter and return a table
function splitString(inputstr, sep)
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function mip:processVitals(entry)
    local extras = nil
	  local hasUpdated = false

    local entries = splitString(entry, "~")

    local i = 1
    while i <= #entries do
        local letter = entries[i]
        local nextEntry = entries[i + 1]
        -- echo(letter .. "|" .. nextEntry .. "\n")
        -- Check if the letter is a capital letter A-M
        if letter:match("[A-N]") then
            -- Call setVitals with the current letter and next entry
            if (mip:setVitals(letter, nextEntry)) then
					    hasUpdated = true -- we really don't care if it returns false
				    end
            i = i + 2
        else
          echo(letter.."\n")
          i = i + 1
        end

        -- Skip to the next pair (letter, next entry)
        
    end

   if not hasUpdated then return end

   --echo("\nraising event mip.vitals\n")
   raiseEvent("mip.vitals")
end

function mip:setVitals(code, value)
  local hasUpdated = false
  -- echo("\ncode: " .. code .. " value: " .. value .. "\n")

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
	-- hm~High Mortal~Hsima~Hsima <HM-Legend>: working with someone to implement mip in mudlet
	local entries = splitString(entry, "~")
	if #entries == 4 then
		mip:parseChat(entries)
	else
		-- something is wrong?
		echo(entry .. "\n")
	end
end

function mip:processTellReceived(entry)
	-- ~Stout~woo
	-- ~Hsima~yo mamma sucks
	-- x~Hsima~yo mamma sucks
	local entries = splitString(entry, "~")
	if #entries == 3 or #entries == 2 then
		mip:parseTell(entries)
	else
		-- something is wrong?
		echo(tostring(#entries)..entry .. "\n")
	end
end

function mip:processImageReceived(entry)
  -- TODO add functionality
end

function mip:processMusicReceived(entry)
  -- TODO add functionality
end

function mip:processAVIReceived(entry)
  -- TODO add functionality
end

function mip:processDLRceived(entry)
  -- TODO add functionality
end

function mip:processRoomReceived(entry)
  -- TODO add functionality
end

function mip:processBeginFileReceived(entry)
  -- TODO add functionality
end

function mip:processContFileReceived(entry)
  -- TODO add functionality
end

function mip:processEndFileReceived(entry)
  -- TODO add functionality
end

function mip:processExitsReceived(entry)
  -- TODO add functionality
end
