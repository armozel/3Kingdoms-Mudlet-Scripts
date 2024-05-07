local code = matches[4]
local lineLength = tonumber(matches[3])
if ThreeKlient.mip.readMIP then
    ThreeKlient.mip.readMIP(code, lineLength)
else
    echo(matches[1])
end