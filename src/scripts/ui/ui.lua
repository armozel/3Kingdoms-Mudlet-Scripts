ThreeKlient = ThreeKlient or {}
ThreeKlient.ui = ThreeKlient.ui or {}

function ThreeKlient.ui.setup()
  ThreeKlient.ui = ThreeKlient.ui or {}
  ThreeKlient.ui.setupVitals()
  ThreeKlient.ui.setupChat()
  ThreeKlient.ui.show()
  loadWindowLayout()
end

function ThreeKlient.ui.tearDown()
  saveWindowLayout()
  ThreeKlient.ui.hide()
  ThreeKlient.ui = nil
end

function ThreeKlient.ui.hide()
    local ui = ThreeKlient.ui
    ui.vitalsContainer:hide()
    ui.chatMonitor:hide()
  end

function ThreeKlient.ui.show()
  local ui = ThreeKlient.ui
  ui.vitalsContainer:show()
  ui.chatMonitor:show()
end
