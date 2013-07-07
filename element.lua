function element(oldtable)
	return function(newtable)
		if newtable == "table" then
			return oldtable
		end

		setmetatable(newtable, {__index = oldtable})
		return element(newtable)
	end
end

