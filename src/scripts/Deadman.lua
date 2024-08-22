local MINUTES = 60
deadmanStatus = true
local function resetDeadMan()
  deadmanStatus = true
    -- echo("Deadman reset\n")
  deleteNamedTimer("hsima", "deadman")
  registerNamedTimer("hsima", "deadman", 20*MINUTES, function()
    deadmanStatus = false
  end)
end

local function deadManEvent(eventName, commandSent)
  if commandSent == command then -- command holds the last command entered on the command line, unaltered by aliases etc
    resetDeadMan()
  -- else
    -- echo("Deadman not reset\n")
  end
end
registerNamedEventHandler("hsima", "deadman", "sysDataSendRequest", deadManEvent)