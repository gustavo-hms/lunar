property = {}
property.__index = function(t, prop)
	return function(self)
		if self == "type" then return "property" end
		return self[prop], prop
	end
end
setmetatable(property, property)
