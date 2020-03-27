GUIModel = {}
setmetatable(GUIModel, {
  __index=function(cls, key)
    return getmetatable(cls)[key]
  end,
  __call=function(cls, ...)
    return getmetatable(cls).new(...)
  end,
  new=function()
    local self=setmetatable({}, getmetatable(GUIModel))
	
	listOfTimers = {}
	
	tabs = {"Schwafel","Laber","Volk","Gilde", "Gruppe", "Sag", "Rede"}

	menu = {}
	menuItem = {}
	menuSubItem = {}
	
	characterView = {
		name = "",
		vollername = "",
		
	
	}
	
	
	stats = {}
	stats.tp = 0
	stats.tp_max = 0
	stats.ap = 0
	stats.ap_max = 0
	stats.zp = 0
	stats.zp_max = 0
	stats.mp = 0
	stats.mp_max = 0
	
	
	
	self.name = ""
	self.vollername = ""
	self.alter = ""
	self.gilde = ""
	self.zuenfte = ""
	self.ep = ""
	self.level = ""
	self.gesinnung = ""
	self.portfolio = ""
	self.hunger = ""
	self.durst = ""
    self.stats = {}
    return self
  end,
  __tostring=function(v)
    return string.format()
  end,
	addTimer=function()
	--addTimer
	end,
	addMenuItem=function()
	--addMenuItem
	end,
	addTab=function()
	--addTab
	end,
})
