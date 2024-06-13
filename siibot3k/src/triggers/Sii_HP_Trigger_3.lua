if walker_active then
  deleteLine()
end

 doBoosts(tonumber(matches[2]))
 doShields(matches[3])
 doAmplify(tonumber(matches[4]))
 doBloodRush(tonumber(matches[5]))
 doPerceive(tonumber(matches[6]))
 checkCombatStart(matches[8])
 doMitigate(tonumber(matches[7]))

 if (matches[8]) then
  -- enemybar.front:echo("Enemy:"..matches[6])
 end
 if (matches[9]) then
   -- enemybar:setValue(tonumber(matches[9]),100)
 --doEntrap(tonumber(matches[9]))
 else
    -- enemybar:setValue(tonumber(100),100)
 end
hpbar_line3 = matches[1]
if (hpbar_line1 and hpbar_line2 and hpbar_line3) then
  --textStatus:echo("<p>"..hpbar_line1.."</p><p>"..hpbar_line2.."</p><p>"..hpbar_line3.."</p>")
end
-- sets the tooltip text
--textStatus:setToolTip(hpbar_line1, "10")