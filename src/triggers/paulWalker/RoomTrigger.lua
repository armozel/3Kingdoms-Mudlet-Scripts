if walker_active then 
  --if (matches[1]) then
    -- Drop Room info in tooltip for hpbar display
    --textStatus:setToolTip(matches[1], "10")
  --end
  deleteLine()
  if ( not walker_killing ) then
    tempRegexTrigger("^>$", [[raiseEvent("walkerPaul")]], 1)
  end
end -- if

walker_roomPlayers = 0
walker_mobs = {}
