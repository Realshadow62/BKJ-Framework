--[[
	Shared utilities
]]

local utils = {}

function utils.instAssert(inst, cond, msg)
	if typeof(inst) ~= "Instance" then
		error("Provided argument must be an Instance!")
	end
	if not inst:IsA(cond) then
		error(msg)
	end
	return inst
end

function utils.softAssert(cond, msg)
	if not cond then
		warn(msg)		
	end
	return cond
end

function utils.defaultTo(cond, val, msg)
	if not cond then
		utils.softAssert(not msg, msg)
		assert(typeof(val) ~= nil, "default value cannot be nil")--Manually check for nil since we might want it to default to false 
		return val
	end
	return cond
end

function utils.weld(p1, p2)
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = p1
	weld.Part1 = p2
	weld.Parent = p1
	return weld
end


return utils