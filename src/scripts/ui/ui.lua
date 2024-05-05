ThreeKlient = ThreeKlient or {}
ThreeKlient.ui = ThreeKlient.ui or {}

function ThreeKlient.ui.setup()
  ThreeKlient.ui = ThreeKlient.ui or {}
  setupVitals()
  ThreeKlient.ui.show()
end

function ThreeKlient.ui.tearDown()
  ThreeKlient.ui.hide()
  ThreeKlient.ui = nil
end

function ThreeKlient.ui.show()
  local ui = ThreeKlient.ui
  ui.vitalsContainer:show()
end

function ThreeKlient.ui.hide()
  local ui = ThreeKlient.ui
  ui.vitalsContainer:hide()
  ui.chatMonitor:hide()
end