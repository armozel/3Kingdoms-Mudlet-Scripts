if walker_active then
  deleteLine()
end
echoBroodLevel(tonumber(matches[3]))
doRoot(tonumber(matches[4]))
if (matches[5] and matches[6]) then
  checkControlLevel(tonumber(matches[5]), tonumber(matches[6]))
end
hpbar_line2 = matches[1]
