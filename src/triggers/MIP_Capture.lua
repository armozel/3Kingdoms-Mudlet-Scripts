--mip.parseMIPLine(matches)
local code = matches[4]
local lineLength = tonumber(matches[3])
mip:readMIP(code, lineLength)
