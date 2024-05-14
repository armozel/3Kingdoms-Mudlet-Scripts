ThreeKlient = ThreeKlient or {}
ThreeKlient.ui = ThreeKlient.ui or {}
ThreeKlient.ui.vitalsContainer = ThreeKlient.ui.vitalsContainer or Adjustable.Container:new({name = "vitals", autoLoad = false}) 
ThreeKlient.ui.colorMap = ThreeKlient.ui.colorMap or {
  r = "red", y = "yellow", g = "green", c = "cyan", v = "violet"
}
ThreeKlient.ui.fontSize = ThreeKlient.ui.fontSize or 14
ThreeKlient.ui.columns = ThreeKlient.ui.columns or 2

local function replaceColor(color, value)
  if ThreeKlient.ui.colorMap[color] then
    color = ThreeKlient.ui.colorMap[color]
    return "<" .. color .. ">" .. value .. "<reset>"
  end
  return color .. "-" .. value
end

local function doColor(gline)
  return string.gsub(gline, "<(.)([^>]+)>", replaceColor)
end

local function getGaugeCss(backgroundColor)
	local res = f[[
		background-color: {backgroundColor};
		border-style: solid;
		border-color: white;
		border-width: 1px;
		border-radius: 5px;
		margin: 5px;
	]]
	return res
end

local function setFontSize(fontSize)
  ThreeKlient.ui.fontSize = fontSize
  for name, _ in pairs(ThreeKlient.ui.gaugeContainers) do
    local gauge = ThreeKlient.ui.gauges[name]
    if gauge then
      gauge:setFontSize(fontSize)
    end
  end
end

function ThreeKlient.ui.setupVitals()
  local ui = ThreeKlient.ui
  ui.vitalsHBox = ui.vitalsHBox or Geyser.HBox:new({
    name = "vitalsHBox",
    x = 0,
    y = 0,
    height = "100%",
    width = "100%",
  }, ui.vitalsContainer)
  
  ui.column1 = ui.column1 or Geyser.VBox:new({
    name = "vitalsColumn1",
    
  }, ui.vitalsHBox)
  
  ui.column2 = ui.column2 or Geyser.VBox:new({
    name = "vitalsColumn2",
  }, ui.vitalsHBox)
  
  ui.gaugeContainers = ui.gaugeContainers or {
    hp = ui.column1,
    sp = ui.column1,
    gp1 = ui.column1,
    gp2 = ui.column1,
    enemyhp = ui.column2,
    gline1 = ui.column2,
    gline2 = ui.column2,
  }
  
  ui.gauges = ui.gauges or {
    hp = Geyser.Gauge:new({
      name = "vitalsHp",
      strict = true
    }, ui.gaugeContainers.hp),
    sp = Geyser.Gauge:new({
      name = "vitalsSp",
      strict = true
    }, ui.gaugeContainers.sp),
    gp1 = Geyser.Gauge:new({
      name = "vitalsGp1",
      strict = true
    }, ui.gaugeContainers.gp1),
    gp2 = Geyser.Gauge:new({
      name = "vitalsGp2",
      strict = true
    }, ui.gaugeContainers.gp2),
    enemyhp = Geyser.Gauge:new({
      name = "vitalsEnemyHp",
      strict = true
    }, ui.gaugeContainers.enemyhp),
    gline1 = Geyser.Label:new({
      name = "gline1Label",
      color = "black",
    }, ui.gaugeContainers.gline1),
    gline2 = Geyser.Label:new({
      name = "gline2Label",
      color = "black",
    }, ui.gaugeContainers.gline2),
  }
  
  ui.gauges.hp.front:setStyleSheet(getGaugeCss("green"))
  ui.gauges.hp.back:setStyleSheet(getGaugeCss("black"))
  ui.gauges.hp:setValue(100, 100, "<center>100</center>")
  
  ui.gauges.sp.front:setStyleSheet(getGaugeCss("blue"))
  ui.gauges.sp.back:setStyleSheet(getGaugeCss("black"))
  ui.gauges.sp:setValue(100, 100, "<center>100</center>")
  
  ui.gauges.gp1.front:setStyleSheet(getGaugeCss("darkgoldenrod"))
  ui.gauges.gp1.back:setStyleSheet(getGaugeCss("black"))
  ui.gauges.gp1:setValue(100, 100, "<center>100</center>")
  
  ui.gauges.gp2.front:setStyleSheet(getGaugeCss("darkcyan"))
  ui.gauges.gp2.back:setStyleSheet(getGaugeCss("black"))
  ui.gauges.gp2:setValue(100, 100, "<center>100</center>")
  
  ui.gauges.enemyhp.front:setStyleSheet(getGaugeCss("maroon"))
  ui.gauges.enemyhp.back:setStyleSheet(getGaugeCss("black"))
  ui.gauges.enemyhp:setValue(100, 100, "<center>Enemy</center>")
  
  ui.gauges.gline1:setStyleSheet([[
    color: 'black';
    qproperty-alignment: 'AlignHCenter | AlignVCenter';
  ]])
  ui.gauges.gline1:setFontSize(ui.fontSize)
  ui.gauges.gline1:echo("gline1")
  ui.gauges.gline2:setStyleSheet([[
    color: 'black';
    qproperty-alignment: 'AlignHCenter | AlignVCenter';
  ]])
  ui.gauges.gline2:setFontSize(ui.fontSize)
  ui.gauges.gline2:echo("gline2")
  setFontSize(ThreeKlient.ui.fontSize)
end

local function updateVitalTitle(title)
  local vitalsContainer = ThreeKlient.ui.vitalsContainer
  if (title) then
    vitalsContainer:setTitle(title)
  end
end

local function updateVital(vitalType, currentValue, maxValue, name)
  local gauges = ThreeKlient.ui.gauges
  local gauge = gauges[vitalType]
  local gaugetext = ""
  local isNumeric = vitalType ~= "gline1" 
    and vitalType ~= "gline2"

  if gauge == nil then
    return
  end

  if name ~= nil then
    gaugetext = f[[<center>{name}</center>]]
  else
    gaugetext =  f[[<center>{tostring(currentValue)}</center>]]
  end
  if isNumeric then
    if currentValue > maxValue then
        gauge:setValue(currentValue % maxValue, maxValue, gaugetext)
    else
        gauge:setValue(currentValue, maxValue, gaugetext)
    end
  else
    gauge:echo(name)
  end
end

function ThreeKlient.ui.onVitalsUpdate()
  local vitals = ThreeKlient.mip.vitals
  if vitals.uptime and vitals.reboot and vitals.mudlag then
    local title = "Uptime " .. vitals.uptime .. " Reboot in " .. vitals.reboot .. " (Mudlag " .. vitals.mudlag ..")"
    updateVitalTitle(title)
  end
  if vitals.hpcur and vitals.hpmax then
    updateVital("hp", vitals.hpcur, vitals.hpmax, nil)
  end
  
  if vitals.spcur and vitals.spmax then
    updateVital("sp", vitals.spcur, vitals.spmax, nil)
  end

  if vitals.gp1cur and vitals.gp1max then
    updateVital("gp1", vitals.gp1cur, vitals.gp1max, nil)
  end

  if vitals.gp2cur and vitals.gp2max then
    updateVital("gp2", vitals.gp2cur, vitals.gp2max, nil)
  end

  if vitals.enemyname and vitals.enemyhp then
    updateVital("enemyhp", vitals.enemyhp, 100, vitals.enemyname)
  end

  if vitals.gline1 then
    local gline1str = doColor(vitals.gline1)
    updateVital("gline1", nil, nil, gline1str)
  end

  if vitals.gline2 then
    local gline2str = doColor(vitals.gline2)
    updateVital("gline2", nil, nil, gline2str)
  end

  if ThreeKlient.mip.vitalUpdateHook then
    ThreeKlient.mip.vitalUpdateHook()
  end
end

