gauges3k = gauges3k or {}
gauges3k.container = gauges3k.container or Adjustable.Container:new({name = "3k Gauges"})
gauges3k.colorMap = gauges3k.colorMap or 
  { r = "red", y = "yellow", g = "green", c = "cyan", v = "violet" }
  
--local fileName = getMudletHomeDir() .. "/gauges3k.config.lua"

function replaceColor(color, value)
  if gauges3k.colorMap[color] then
    color = gauges3k.colorMap[color]
    else
      return color .. "-" .. value
  end
  return "<" .. color .. ">" .. value .. "<reset>"
end

function gauges3k.doColor(gline)
	return string.gsub(gline,"<(.)([^>]+)>", replaceColor)
end

function gauges3k.load()
--	local cfg = {}
--	if io.exists(fileName) then
--		table.load(fileName, cfg)
--	end
	
	gauges3k.fontSize = 14
	gauges3k.columns = 2
	gauges3k.init()
end

function gauges3k.save()
--	local cfg = {
--		fontSize = gauges3k.fontSize,
--		columns  = gauges3k.columns
--	}
--	table.save(fileName, cfg)
end

function gauges3k.getFrontCSS(backgroundColor)
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

function gauges3k.getBackCSS(backgroundColor)
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

function gauges3k.setFontSize(fontSize)
	gauges3k.fontSize = fontSize
	
	for name, _ in pairs(gauges3k.gaugeContainers) do
		local object = gauges3k.gauges[name]
		if object then
			object:setFontSize(fontSize)
		end
	end
end

function gauges3k.init()
	gauges3k.hbox = Geyser.HBox:new({
		name = "Gauges 3k HBox",
		x = 0,
		y = 0,
		width = "100%",
		height = "100%"
	}, gauges3k.container)
	
	gauges3k.column1 = Geyser.VBox:new({
		name = "Gauges 3k Column1"
	}, gauges3k.hbox)
	
  gauges3k.column2 = Geyser.VBox:new({
    name = "Gauges 3k Column2",
  }, gauges3k.hbox)
  
	gauges3k.gaugeContainers = {
    hp = gauges3k.column1,
    sp = gauges3k.column1,
    gp1 = gauges3k.column1,
    gp2 = gauges3k.column1,    
    enemyhp = gauges3k.column2,
    gline1 = gauges3k.column2,
    gline2 = gauges3k.column2
  }
	
	local frontCSS = gauges3k.getFrontCSS
	local backCSS = gauges3k.getBackCSS
	
	gauges3k.gauges = {}
	
	gauges3k.gauges.hp = Geyser.Gauge:new({
		name = "3k Gauges HP",
		strict = true
	}, gauges3k.gaugeContainers.hp)
	
	gauges3k.gauges.hp.front:setStyleSheet(frontCSS("green"))
	gauges3k.gauges.hp.back:setStyleSheet(backCSS("black"))
	gauges3k.gauges.hp:setValue(100, 100, "<center>100</center>")
	
  gauges3k.gauges.sp = Geyser.Gauge:new({
    name = "3k Gauges SP",
    strict = true
  }, gauges3k.gaugeContainers.sp)
  
	gauges3k.gauges.sp.front:setStyleSheet(frontCSS("blue"))
	gauges3k.gauges.sp.back:setStyleSheet(backCSS("black"))
	gauges3k.gauges.sp:setValue(100, 100, "<center>100</center>")
  
	gauges3k.gauges.gp1 = Geyser.Gauge:new({
	  name = "3k Gauges GP1",
		strict = true
	}, gauges3k.gaugeContainers.gp1)
	
	gauges3k.gauges.gp1.front:setStyleSheet(frontCSS("darkgoldenrod"))
	gauges3k.gauges.gp1.back:setStyleSheet(backCSS("black"))
	gauges3k.gauges.gp1:setValue(100, 100, "<center>100</center>")
	
	gauges3k.gauges.gp2 = Geyser.Gauge:new({
		name = "3k Gauges GP2",
		strict = true
	}, gauges3k.gaugeContainers.gp2)
  
	gauges3k.gauges.gp2.front:setStyleSheet(frontCSS("darkcyan"))
	gauges3k.gauges.gp2.back:setStyleSheet(backCSS("black"))
	gauges3k.gauges.gp2:setValue(100, 100, "<center>100</center>")
	
	gauges3k.gauges.enemyhp = Geyser.Gauge:new({
		name = "3k Gauges Enemy HP",
		strict = true
	}, gauges3k.gaugeContainers.enemyhp)
	
	gauges3k.gauges.enemyhp.front:setStyleSheet(frontCSS("maroon"))
	gauges3k.gauges.enemyhp.back:setStyleSheet(backCSS("black"))
	gauges3k.gauges.enemyhp:setValue(100, 100, "<center>Enemy</center>")
  
  gauges3k.gauges.gline1 = Geyser.Label:new({
    name = "3k Gline 1",
    color = "black"
    }, gauges3k.gaugeContainers.gline1)
  
  gauges3k.gauges.gline1:setStyleSheet([[
    color: 'black';
    qproperty-alignment: 'AlignHCenter | AlignVCenter';
  ]])
  
	gauges3k.setFontSize(gauges3k.fontSize)
	gauges3k.update()
end 

function gauges3k.update()
	local numtemplate = "<center>%d</center>"
	
	if mip.vitals.hpcur and mip.vitals.hpmax then

		local hptext = string.format(numtemplate, mip.vitals.hpcur)
		if mip.vitals.hpcur > mip.vitals.hpmax then
			gauges3k.gauges.hp:setValue(mip.vitals.hpcur % mip.vitals.hpmax, mip.hpmax, hptext)
		else
			gauges3k.gauges.hp:setValue(mip.vitals.hpcur, mip.vitals.hpmax, hptext)
		end
	end

    if mip.vitals.spcur and mip.vitals.spmax then
  
	  local sptext = string.format(numtemplate, mip.vitals.spcur)
	  if mip.vitals.spcur > mip.vitals.spmax then
	    gauges3k.gauges.sp:setValue(mip.vitals.spcur % mip.vitals.spmax, mip.vitals.spmax, sptext)
	  else
	    gauges3k.gauges.sp:setValue(mip.vitals.spcur, mip.vitals.spmax, sptext)
	  end
    end
  
	if mip.vitals.gp1cur then

		local gp1text = string.format(numtemplate, mip.vitals.gp1cur)
		if mip.vitals.gp1max then
			gauges3k.gauges.gp1:setValue(mip.vitals.gp1cur, mip.vitals.gp1max, gp1text)
		else
			gauges3k.gauges.gp1:setValue(mip.vitals.gp1cur, 100, gp1text)
		end
	end

	if mip.vitals.gp2cur then
		local gp2text = string.format(numtemplate, mip.vitals.gp2cur)

		if mip.vitals.gp2max then
			gauges3k.gauges.gp2:setValue(mip.vitals.gp2cur, mip.vitals.gp2max, gp2text)
		else
			gauges3k.gauges.gp2:setValue(mip.vitals.gp2cur, 100, gp2text)
		end
	end

	if mip.vitals.enemyname and mip.vitals.enemyhp then

		local enemyhptext = "<center>" .. mip.vitals.enemyname .. "</center>"
		if mip.vitals.enemyhp > 100 then
			gauges3k.gauges.enemyhp:setValue(mip.vitals.enemyhp % 100, 100, enemyhptext)
		else
			gauges3k.gauges.enemyhp:setValue(mip.vitals.enemyhp, 100, enemyhptext)
		end
	end
  
  if mip.vitals.gline1 then
    local gline1str = gauges3k.doColor(mip.vitals.gline1)
    gauges3k.gauges.gline1:cecho(gline1str)
  end
  
end

--if not gauges3k.hbox then
	gauges3k.load()
--end

if gauges3k.updateEventHandler then
	killAnonymousEventHandler(gauges3k.updateEventHandler)
end

gauges3k.updateEventHandler = registerAnonymousEventHandler("mip.vitals", gauges3k.update)

--if gauges3k.saveEventHandler then
--	killAnonymousEventHandler(gauges3k.saveEventHandler)
--end

--gauges3k.saveEventHandler = registerAnonymousEventHandler("sysExitEvent", gauges3k.save)


gauges3k.container:show()
