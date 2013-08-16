property = {}
property.__index = function(t, prop)
	return function(self)
		if self == "type" then return "property" end
		return self[prop], prop
	end
end
setmetatable(property, property)

register = {}

function setElementConstructor(constructor)
	register.newElement = makeBuilder(constructor, elementBuilder)
end

function setEmptyElementConstructor(constructor)
	register.newEmptyElement = makeBuilder(constructor, emptyElementBuilder)
end

function makeBuilder(constructor, builder)
	return function(tag)
		local element = constructor(tag)
		local base = {}
		base.build = builder
		_G[tag] = elem(base, element)
	end
end

function elem(oldtable, element)
	return function(newtable)
		if newtable == "type" then return "element" end

		if newtable == "element" then
			element = oldtable:build(element)
			return element
		end

		setmetatable(newtable, {__index = oldtable})
		return elem(newtable)
	end
end

function elementBuilder(self, element)
	local properties = {}
	local table = {}
	table.elements = {}
	table.attributes = {}

	for e in elements(self) do
		if type(e) ~= "function" then
			table.elements[#table.elements+1] = e

		elseif e "type" == "property" then
			value, name = e(self)
			properties[#properties + 1] = name
			table.elements[#table.elements+1] = value

		else 
			table.elements[#table.elements + 1] = e "table"
		end
	end

	for k, v in attributes(self) do
		if type(v) ~= "function" then
			table.attributes[k] = v

		elseif v "type" == "property" then
			value, name = v(self)
			properties[#properties + 1] = name
			table.attributes[k] = value
		end
	end

	for _, prop in ipairs(properties) do
		table.attributes[prop] = nil
	end

	element.attributes = table.attributes
	element.elements = table.elements

	return element
end

function emptyElementBuilder(self, element)
	local properties = {}
	local table = {}
	table.attributes = {}

	for k, v in attributes(self) do
		if type(v) ~= "function" then
			table.attributes[k] = v

		else
			value, name = v(self)
			properties[#properties + 1] = name
			table.attributes[k] = value
		end
	end

	for _, prop in ipairs(properties) do
		table.attributes[prop] = nil
	end

	element.attributes = table.attributes

	return element
end
