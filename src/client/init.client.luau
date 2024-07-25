print("Hello world, from client!")

local test = {}
test.__index = test

function test.new()
	local self = setmetatable({}, test)

	return self
end

return test
