  local vitals = ThreeKlient.mip.vitals
  if vitals.hpcur and vitals.hpmax and checkHP then
    checkHP(vitals.hpcur, vitals.hpmax)
  end
  if vitals.spcur and vitals.spmax and checkSP then
    checkSP(vitals.spcur, vitals.spmax)
  end
  if vitals.gp1cur and vitals.gp1max and checkFort then
    checkFort(vitals.gp1cur, vitals.gp1max)
  end
  if vitals.gp2cur and vitals.gp2max and checkControlLevel then
    checkControlLevel(tonumber(vitals.gp2cur), tonumber(vitals.gp2max))
  end
  if vitals.enemyname and (string.len(vitals.enemyname) == 1 or vitals.enemyname == "Enemy") then
    inCombat = false
  else
    inCombat = true
  end 
