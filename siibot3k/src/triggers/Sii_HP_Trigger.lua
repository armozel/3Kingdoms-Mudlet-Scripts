if walker_active then
  deleteLine()
end
if (matches[2] and matches[3]) then
  checkHP(tonumber(matches[2]), tonumber(matches[3]))
  --hpbar:setValue(tonumber(matches[2]),tonumber(matches[3]))
end
if (matches[4] and matches[5]) then
 checkSP(tonumber(matches[4]), tonumber(matches[5]))
 --spbar:setValue(tonumber(matches[4]),tonumber(matches[5]))
end
if (matches[6] and matches[7]) then
 checkFort(tonumber(matches[6]), tonumber(matches[7]))
 --fortbar:setValue(tonumber(matches[6]),tonumber(matches[7]))
end
if (matches[8] and matches[9] and matches[10]) then
 checkOverload(tonumber(matches[8]), tonumber(matches[9]), matches[10])
end
hpbar_line1 = matches[1]