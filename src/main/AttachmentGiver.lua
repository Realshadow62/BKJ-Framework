--[[
	Handles welding and CFraming of webbings
]]
local utils = require(script.Parent.Parent.res.Utilities)

local DEFAULT_PART = "HumanoidRootPart"	--Careful when changing this
local WARN_UNDEFINED_PART = "Target part for attachment %s is not a part in %s. Defaulting to %s."
local ERR_NO_PRIMARY_PART = "Attachment %s does not have a PrimaryPart!"

return function(Character, Attachment)
	local primary = assert(Attachment.PrimaryPart, ERR_NO_PRIMARY_PART:format(Attachment.Name))
	local bodyPart = utils.defaultTo(Character:FindFirstChild(primary.Name), Character[DEFAULT_PART], WARN_UNDEFINED_PART:format(Attachment.Name, Character.Name, DEFAULT_PART))
	
	Attachment:SetPrimaryPartCFrame(bodyPart.CFrame)
	utils.weld(Attachment.PrimaryPart, bodyPart)
	Attachment.Parent = Character
end


