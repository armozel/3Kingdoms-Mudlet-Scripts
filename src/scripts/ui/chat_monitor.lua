ThreeKlient = ThreeKlient or {}
ThreeKlient.ui = ThreeKlient.ui or {}
ThreeKlient.comm = ThreeKlient.comm or {}
ThreeKlient.comm.histPattern = ThreeKlient.ui.histPattern or "^(\d+):(\d+)"


ThreeKlient.ui.chatMonitor or ThreeKlient.ui.chatMonitor or Geyser.UserWindow:new({
    name = "ChatMonitor",
    titleText ="My ChatPopup", -- only available since Mudlet 4.8+
    x = "20%", y="20%",
    width="30%", height ="50%",
})
ThreeKlient.ui.chatMonitor.setFontSize("ChatMonitor", 20)

function ThreeKlient.comm.parseChat(chatTable)
    local chatMonitor = ThreeKlient.ui.chatMonitor
    -- chatTable[1] is a short name of the chat line
    -- chatTable[2] is a prettier string for the line name?
    -- chatTable[3] is the name of the character who originated the chat
    -- chatTable[4] is the original chat
    chatMonitor:echo(chatTable[4].."\n")
    -- ttsSpeak(monitorOutput)
end

function ThreeKlient.comm.parseTell(chatTable)
    local chatMonitor = ThreeKlient.ui.chatMonitor
    -- chatTable[1] is either an empty string (incoming tell) or x outgoing tell
    -- chatTable[2] is the target of the tell
    -- chatTable[3] is the content of the tell
    if chatTable[1]=="x" then
        chatMonitor:echo("You tell " .. chatTable[2] .. ": " .. chatTable[3].."\n")
    else
        chatMonitor:echo( chatTable[2] .. " tells you: " .. chatTable[3].."\n")
    end
    -- ttsSpeak(monitorOutput)
end