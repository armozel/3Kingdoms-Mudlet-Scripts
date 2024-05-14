ThreeKlient = ThreeKlient or {}
ThreeKlient.ui = ThreeKlient.ui or {}
ThreeKlient.mip = ThreeKlient.mip or {}
ThreeKlient.mip.histPattern = ThreeKlient.mip.histPattern or "^(\d+):(\d+)"

function ThreeKlient.mip.parseChat(chatTable)
    local chatMonitor = ThreeKlient.ui.chatMonitor
    -- chatTable[1] is a short name of the chat line
    -- chatTable[2] is a prettier string for the line name?
    -- chatTable[3] is the name of the character who originated the chat
    -- chatTable[4] is the original chat
    chatMonitor:echo(chatTable[4].."\n")
    -- ttsSpeak(monitorOutput)
end

function ThreeKlient.mip.parseTell(chatTable)
    local chatMonitor = ThreeKlient.ui.chatMonitor
    -- chatTable[1] is either an empty string (incoming tell) or x outgoing tell
    -- chatTable[2] is the target of the tell
    -- chatTable[3] is the content of the tell
    if chatTable[1]=="x" then
        chatMonitor:echo("You tell " .. chatTable[2] .. ": " .. chatTable[3].."\n")
    else
        chatMonitor:echo( chatTable[1] .. " tells you: " .. chatTable[2].."\n")
    end
    -- ttsSpeak(monitorOutput)
end

function ThreeKlient.ui.setupChat()
    ThreeKlient.ui.chatMonitor = ThreeKlient.ui.chatMonitor or Geyser.UserWindow:new({
        name = "ChatMonitor",
        titleText ="My ChatPopup", -- only available since Mudlet 4.8+
        x = "20%", y="20%",
        height ="20%",
        docked = true,
        dockPosition = 'top', -- Possible dockPositions are left "l", right "r", top "t", bottom "b" and floating "f" 
        autoWrap = true,
    })
    ThreeKlient.ui.chatMonitor:setFontSize(20)
end