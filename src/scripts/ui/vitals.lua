ThreeKlient = ThreeKlient or {}
ThreeKlient.ui = ThreeKlient.ui or {}
ThreeKlient.ui.vitalsContainer = ThreeKlient.ui.vitalsContainer or Adjustable.Container:new({name = "vitals"}) 
ThreeKlient.ui.colorMap = ThreeKlient.ui.colorMap or {
  r = "red", y = "yellow", g = "green", c = "cyan", v = "violet"
}
ThreeKlient.ui.fontSize = ThreeKlient.ui.fontSize or 14
ThreeKlient.ui.columns = ThreeKlient.ui.columns or 2

local function replaceColor(color, value)
  if ThreeKlient.ui.colorMap[color] then
    color = ThreeKlient.ui.colorMap[color]
  else
    return f[[{color}-{value}]]
  end
  return f[[<{color}>{value}<reset>]]
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
    gp1 = Geyser.Gauges:new({
      name = "vitalsGp1",
      strict = true
    }, ui.gaugeContainers.gp1),
    gp2 = Geyser.Gauges:new({
      name = "vitalsGp2",
      strict = true
    }, ui.gaugeContainers.gp2),
    enemyhp = Geyser.Gauges:new({
      name = "vitalsEnemyHp",
      strict = true
    }, ui.gaugeContainers.enemyhp),
    gline1 = Geyser.Label:new({
      name = "gline1Label",
      color = "black",
    }, ui.gaugeContainers.gline1),
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
  
  ui.gauges.enemyhp.front(getGaugeCss("maroon"))
  ui.gauges.enemyhp.back(getGaugeCss("black"))
  ui.gauges.enemyhp:setValue(100, 100, "<center>Enemy</center>")
  
  ui.gauges.gline1:setStyleSheet([[
    color: 'black';
    qproperty-alignment: 'AlignHCenter | AlignVCenter';
  ]])
  setFontSize(ui.fontSize)
end

function ThreeKlient.ui.onUpdateVitals()
  local vitals = ThreeKlient.mip.vitals

  if vitals.hpcur and vitals.hpmax then
    updateVital("hp", vitals.hpcur, vitals.hpmax)
  end
  
  if vitals.spcur and vitals.spmax then
    updateVital("sp", vitals.spcur, vitals.spmax) 
  end

  if vitals.gp1cur and vitals.gp1max then
    updateVital("gp1", vitals.gp1cur, vitals.gp1max)
  end

  if vitals.gp2cur and vitals.gp2max then
    updateVital("gp2", vitals.gp2cur, vitals.gp2max) 
  end

  if vitals.enemyname and vitals.enemyhp then
    updateVital("enemyhp", vitals.enemyhp, 100, vitals.enemyname)
  end

  if vitals.gline1 then
    local gline1str = doColor(vitals.gline1)
    ui.gauges.gline1:cecho(geline1str)
  end
end

local function updateVital(vitalType, currentValue, maxValue, name)
  local gauges = ThreeKlient.ui.gauges
  local gauge = gauges[vitalType]

  if gauge == nil then
    return
  end

  local gaugetext = f[[<center>{currentValue}</center>]]

  if name ~= nil then
    gaugetext = f[[<center>{name}</center>]]
  end

  if currentValue > maxValue then
      gauge:setValue(currentValue % maxValue, maxValue, gaugetext)
  else
      gauge:setValue(currentValue, maxValue, gaugetext)
  end
end
