gauges3k = gauges3k or {}

gauges3k.container = gauges3k.container or Adjustable.Container:new({name = "3k Gauges"})

local fileName = getMudletHomeDir() .. "/gauges3k.config.lua"

function gauges3k.load()
	local cfg = {}
	if io.exists(fileName) then
		table.load(fileName, cfg)
	end
	
	gauges3k.fontSize = cfg.fontSize or 14
	gauges3k.columns = cfg.columns or 1
	gauges3k.init()
end


function gauges3k.save()
	local cfg = {
		fontSize = gauges3k.fontSize,
		columns  = gauges3k.columns
	}
	table.save(fileName, cfg)
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
		local object = gauges3k[name]
		if object then
			object:setfontSize(fontSize)
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
	
	gauges3k.gaugeContainers = {
		hp = gauges3k.column1,
		sp = gauges3k.column1,
		gp1 = gauges3k.column1,
		gp2 = gauges3k.column1,
		enemyhp = gauges3k.column1,
		gline1 = gauges3k.column1,
		gline2 = gauges3k.column1
	}
	
	local frontCSS = gauges3k.getFrontCSS
	local backCSS = gauges3k.getBackCSS
	
	gauges3k.gauges = {}
	
	gauges3k.gauges.hp = Geyser
end


