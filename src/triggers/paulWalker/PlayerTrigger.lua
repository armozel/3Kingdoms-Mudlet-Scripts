local function t_has(tab, value)
  for i,v in ipairs(tab) do
    if string.match(value, v) then
      return true
    end
  end
  return false
end

local thisPlayer = string.lower(matches[1])
if not t_has(stepperBot.partyMembers, thisPlayer) then
  -- add mob to mob count or add mob to table
  walker_roomPlayers = walker_roomPlayers + 1
end