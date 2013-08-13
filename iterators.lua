function elements(t)
	return coroutine.wrap(function() elems(t) end)
end

function elems(t)
	for _, v in ipairs(t) do
		coroutine.yield(v)
	end

	local meta = getmetatable(t)
	if meta == nil then return nil end

	for e in elements(meta.__index) do
		coroutine.yield(e)
	end
end

function attributes(t)
	return coroutine.wrap(function() attr(t) end)
end

function attr(t)
	for k, v in pairs(t) do
		if type(k) ~= "number" then
			coroutine.yield(k, v)
		end
	end

	local meta = getmetatable(t)
	if meta == nil then return nil end

	for k, v in attributes(meta.__index) do
		if rawget(t, k) == nil then
			coroutine.yield(k, v)
		end
	end
end

