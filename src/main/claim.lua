local main = script.Parent 
local replicator = main.replicate
local IsServer= game:GetService("RunService").IsServer

local Attach = require(main.AttachmentGiver)

local ASSET_LINK = "rbxassetid://%d"

local KitsGiver = {}

function replicate(event)
	
end

function KitsGiver.Webbings(kit, plr)
	local char = plr.Character
	for _,webbing in pairs(kit.Webbings) do
		Attach(char, webbing)
	end
end

function KitsGiver.Equipment(kit, plr)
	for _,tool in pairs(kit.Equipment) do
		tool:Clone().Parent = plr.Backpack
	end
end

function KitsGiver.Uniform(kit, plr)
	local char = plr.Character
	local shirt = char:FindFirstChildWhichIsA("Shirt") or Instance.new("Shirt", char)
	local pants = char:FindFirstChildWhichIsA("Pants") or Instance.new("Pants", char)

	shirt.ShirtTemplate = ASSET_LINK:format(kit.Uniform[1] or 0)
	pants.PantsTemplate = ASSET_LINK:format(kit.Uniform[1] or 1)
end

function KitsGiver.Tickets(kit)
	kit.Tickets -= 1
	if kit.Tickets < 1 then
		kit._exhausted:Invoke()
		if IsServer() then
			replicator:FireAllClients("exh")
		end		
	end	
end

return KitsGiver