local Preferences = {}
setmetatable(Preferences, {
	__index=function(cls, key)
		return getmetatable(cls)[key]
	end,
	__call=function(cls, ...)
		return getmetatable(cls).new(...)
	end,
	new=function()
		local self=setmetatable({}, getmetatable(Preferences))
--		self.stats{}
--		self.y
		return self
	end,
	__tostring=function(v)
		return string.format()
	end,
	
})
