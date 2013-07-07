property = {}
property.__index = function(t, prop)
	return function(self)
		return self[prop]
	end
end
setmetatable(property, property)
