-- These things will always happen if something dies in the room
local vitals = ThreeKlient.mip.vitals
inCombat = false
ThreeKlient.mip.vitals.enemyname = 'Enemy'
ThreeKlient.ui.onVitalsUpdate()

if walker_active and deadmanStatus then
  tempTimer( 3, [[raiseEvent("walkerKillingBlow")]])
else
  cecho ("\n<yellow>Deadman triggered I'm not going to move!")
  cecho ("\n<yellow>Check tellhist then enter /stop and /hunt to continue.")
end