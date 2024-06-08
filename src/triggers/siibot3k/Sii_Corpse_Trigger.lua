-- These things will only happen if you killed it
if ( corpseHog > 0 and (#matches > 1) and ((matches[2] == 'Hsima') or (matches[2] == "Hsima's broodlingsz"))) then
   send("wrap")
   --send("boost")
   send("envelop corpse")
   send("bake")
   send("divvy gold")
end
-- These things will always happen if something dies in the room
if vitals.enemyname and string.len(vitals.enemyname) > 1 then
 inCombat = false
 ThreeKlient.mip.vitals.enemyname = 'E'
 ThreeKlient.ui.onVitalsUpdate()
end
if walker_active and deadmanStatus then
  tempTimer( 3, [[raiseEvent("walkerKillingBlow")]])
else
  cecho ("\n<yellow>Deadman triggered I'm not going to move!")
  cecho ("\n<yellow>Check tellhist then enter /stop and /hunt to continue.")
end