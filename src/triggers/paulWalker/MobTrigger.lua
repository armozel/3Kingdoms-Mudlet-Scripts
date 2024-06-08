if walker_active then
  deleteLine()
end -- if
local function t_has(tab, value)
  for i,v in ipairs(tab) do
    if string.match(value, v) then
      return true
    end
  end
  return false
end

local thisMob = string.lower(matches[1])
if not t_has(stepperBot.badmobs, thisMob) then
  -- add mob to mob count or add mob to table
  table.insert(walker_mobs, thisMob)
end