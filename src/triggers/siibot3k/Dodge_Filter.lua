deleteLine()
actions = {
  ["psionic prevention: you deftly dodge the attack!"] = true,
  ["psionic prevention: you manage to dodge a little of the attack!"] = true,
  ["psionic prevention: you manage to dodge a large part of the attack!"] = true,
  ["psionic prevention: you manage to dodge some of the attack!"] = true,
  ["psionic prevention: you barely manage to dodge."] = true,
}
splat={
  ["psionic prevention: you dodge the wrong way and are pulverized!"] = true
}
if (badlinesplit) then
  dodgemess=partialLine..' '..dodgemess
  badlinesplit=false
  partialLine=''
  send('pt fixed to:'..dodgemess)
end
dodgemess=string.lower(matches[1]):gsub("[\n\r]", ""):gsub("^%s*(.-)%s*$", "%1")

if (actions[dodgemess]) then
   fullDodge=fullDodge+1
elseif (splat[dodgemess]) then
  failDodge=failDodge+1
else
  badlinesplit=true
  partialLine=dodgemess
end
if (fullDodge+failDodge >= 1000) then
   send('pt Splat percentage: '..failDodge/(fullDodge+failDodge))
   fullDodge=0
   failDodge=0
end