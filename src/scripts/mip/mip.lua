ThreeKlient = ThreeKlient or {}
ThreeKlient.mip = ThreeKlient.mip or {}
ThreeKlient.mip.vitals = ThreeKlient.mip.vitals or {}
ThreeKlient.mip.codes = ThreeKlient.mip.codes or {
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
function ThreeKlient.mip.readMIP(code, lineLength)
    local mip = ThreeKlient.mip
    local currentLine = getCurrentLine()
    local entry = string.sub(currentLine, 15, lineLength + 14)
    deleteLine()
    mip.processMIP(code, entry)
  end
  
  function ThreeKlient.mip.processMIP(code, entry)
      local mip = ThreeKlient.mip
      if code == mip.codes["CL_SEND_HPBAR"] then
          mip.processVitals(entry)
      elseif code == mip.codes["CL_SEND_TELL"] then
          mip.processTellReceived(entry)
    elseif code == mip.codes["CL_SEND_CHAT"] then
          mip.processChatReceived(entry)
      end
  
  end
  
  -- Function to split a string on a delimiter and return a table
  local function splitString(inputstr, sep)
      local t = {}
      for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
          table.insert(t, str)
      end
      return t
  end
  
  function ThreeKlient.mip.processVitals(entry)
      local mip = ThreeKlient.mip
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
              if (mip.setVitals(letter, nextEntry)) then
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

     raiseEvent("ThreeKlientCharVitals")
  end
  
  local vitalsCodeReverse = {
    A = "hpcur",
    B = "hpmax",
    C = "spcur",
    D = "spmax",
    E = "gp1cur",
    F = "gp1max",
    G = "gp2cur",
    H = "gp2max",
    I = "gline1",
    J = "gline2",
    K = "enemyname",
    L = "enemyhp"
  }

  function ThreeKlient.mip.setVitals(code, value)
    local mip = ThreeKlient.mip
    local vitalCode = vitalsCodeReverse[code]

    if vitalCode == nil then
        return false
    end

    local notNumeric = 
        vitalCode ~= "gline1" 
        and vitalCode ~= "gline2" 
        and vitalCode ~= "enemyname"

    if notNumeric then
        mip.vitals[vitalCode] = tonumber(value)
    else
        mip.vitals[vitalCode] = value  
    end

    return true
  end
  
  function ThreeKlient.mip.processChatReceived(entry)
      -- hm~High Mortal~Hsima~Hsima <HM-Legend>: working with someone to implement mip in mudlet
      local mip = ThreeKlient.mip
      local entries = splitString(entry, "~")
      if #entries == 4 then
          mip.parseChat(entries)
      else
          -- something is wrong?
          echo(entry .. "\n")
      end
  end
  
  function ThreeKlient.mip.processTellReceived(entry)
      -- ~Stout~woo
      -- ~Hsima~yo mamma sucks
      -- x~Hsima~yo mamma sucks
      local mip = ThreeKlient.mip
      local entries = splitString(entry, "~")
      if #entries == 3 or #entries == 2 then
          mip.parseTell(entries)
      else
          -- something is wrong?
          echo(tostring(#entries)..entry .. "\n")
      end
  end
  
  function ThreeKlient.mip.processImageReceived(entry)
    -- TODO add functionality
  end
  
  function ThreeKlient.mip.processMusicReceived(entry)
    -- TODO add functionality
  end
  
  function ThreeKlient.mip.processAVIReceived(entry)
    -- TODO add functionality
  end
  
  function ThreeKlient.mip.processDLRceived(entry)
    -- TODO add functionality
  end
  
  function ThreeKlient.mip.processRoomReceived(entry)
    -- TODO add functionality
  end
  
  function ThreeKlient.mip.processBeginFileReceived(entry)
    -- TODO add functionality
  end
  
  function ThreeKlient.mip.processContFileReceived(entry)
    -- TODO add functionality
  end
  
  function ThreeKlient.mip.processEndFileReceived(entry)
    -- TODO add functionality
  end
  
  function ThreeKlient.mip.processExitsReceived(entry)
    -- TODO add functionality
  end
  