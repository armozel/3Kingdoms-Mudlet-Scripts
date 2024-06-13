if walker_active then 
  if ( not walker_killing ) then
    tempRegexTrigger("^>$", [[raiseEvent("walkerPaul")]], 1)
  end
end -- if

walker_roomPlayers = 0
walker_mobs = {}
