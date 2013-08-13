function element(oldtable)
	return function(newtable)
		if newtable == "type" then return "element" end
		if newtable == "table" then return build(oldtable) end

		setmetatable(newtable, {__index = oldtable})
		return element(newtable)
	end
end

function build(t)
	local properties = {}
	local table = {}
	table.elements = {}
	table.attributes = {}
	
	for e in elements(t) do
		if type(e) ~= "function" then
			table.elements[#table.elements+1] = e

		elseif e "type" == "property" then
			value, name = e(t)
			properties[#properties + 1] = name
			table.elements[#table.elements+1] = value

		else 
			table.elements[#table.elements + 1] = e "table"
		end
	end

	for k, v in attributes(t) do
		if type(v) ~= "function" then
			table.attributes[k] = v

		else
			value, name = v(t)
			properties[#properties + 1] = name
			table.attributes[k] = value
		end
	end

	for _, prop in ipairs(properties) do
		table.attributes[prop] = nil
	end

	return table
end
