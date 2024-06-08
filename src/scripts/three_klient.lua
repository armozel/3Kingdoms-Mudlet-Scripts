ThreeKlient = ThreeKlient or {}
ThreeKlient.config = ThreeKlient.config or { user = "ThreeKlient" }
ThreeKlient.eventHandlers = {
    -- basic events
    {"ThreeKlientCharVitals", "ThreeKlient.ui.onVitalsUpdate", nil},
    -- ui handlers
    {"ThreeKlientLoaded", "ThreeKlient.ui.setup", nil},
    -- package events
    {"ThreeKlientInstalled", "ThreeKlient.ui.setup", nil},
    {"ThreeKlientUninstalled", "ThreeKlient.ui.tearDown", nil},
    
}

function ThreeKlient.registerEventHandlers()
    for i, v in ipairs(ThreeKlient.eventHandlers) do
        if v[3] == nil then
            v[3] = registerAnonymousEventHandler(v[1], v[2])
        end
    end
end

function ThreeKlient.deregisterEventHandlers()
    for i, v in ipairs(ThreeKlient.eventHandlers) do
        if v[3] ~= nil then
            killAnonymousEventHandler(v[3])
        end
    end
end

local function onInstall(_, package)
    if package ~= "3Klient" then
        return
    end
    ThreeKlient.registerEventHandlers()
    raiseEvent("ThreeKlientInstalled")
    cecho("<green>Installed 3Klient.<reset>\n")
end

local function onUninstall(_, package)
    if package ~= "3Klient" then
        return
    end
    ThreeKlient.deregisterEventHandlers()
    raiseEvent("ThreeKlientUninstalled")
    cecho("<red>Uninstalled 3Klient.<reset>\n")
end

local function onProfileLoad()
    ThreeKlient.registerEventHandlers()
    raiseEvent("ThreeKlientLoaded")
    cecho("<green>Loaded 3Klient.<reset>\n")
end

registerNamedEventHandler(ThreeKlient.config.user, "ThreeKlientInstall", "sysInstall", onInstall)
registerNamedEventHandler(ThreeKlient.config.user, "ThreeKlientLoad", "sysLoadEvent", onProfileLoad)
registerNamedEventHandler(ThreeKlient.config.user, "ThreeKlientUinstall", "sysUninstall", onUninstall)