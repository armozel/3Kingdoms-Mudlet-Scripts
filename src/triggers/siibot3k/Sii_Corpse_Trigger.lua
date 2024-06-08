if ( corpseHog > 0 and (#matches > 1) and ((matches[2] == 'Hsima') or (matches[2] == "broodlings"))) then
   send("wrap")
   --send("boost")
   send("envelop corpse")
   send("bake")
   send("divvy gold")
   --send("pt Full Dodges: "..fullDodge.." FAILS: "..failDodge)
   fullDodge=0
   failDodge=0
   inCombat = false
   if deadmanStatus then
     tempTimer( 3, [[raiseEvent("walkerKillingBlow")]])
   else
     cecho ("\n<yellow>Deadman triggered I'm not going to move!")
     cecho ("\n<yellow>Check tellhist then enter /stop and /hunt to continue.")
   end
end