local res = script.res
local main = script.main

local utils = require(res.Utilities)
local signal = require(res.Signal)
local claim = require(main.claim)
local restrict = require(main.restrict)

local replicator = main.replicate

local DEFAULT_TICKETS = 10

local Kits = {}
Kits.__index = Kits

function Kits.new()
	return setmetatable({}, Kits)
end

function setupConnection(identifier, event)
	if game:GetService("RunService"):IsClient() then
		replicator.OnClientEvent:Connect(function(flag)
			if flag == identifier then
				event:Invoke()
			end
		end)
	end
end

function Kits:restrict(team)
	utils.instAssert(team, "Team", "Provided object must be a team!")
	self.Team = team
	return self 
end

function Kits:limit(tickets)
	local event = signal.new()
	self.Tickets = math.floor(tickets) or DEFAULT_TICKETS
	self._exhausted = event
	self.Exhausted = event.Invoked
	setupConnection("exh", self._exhausted)
	return self 
end

function Kits:attach(webbings)
	self.Webbings = webbings or {}
	return self 
end

function Kits:equip(equipment)
	self.Equipment = equipment or {}
	return self 
end

function Kits:outfit(shirtId, pantsId)
	self.Uniform = {shirtId or 0, pantsId or 1}
	return self
end

function Kits:give(plr)
	for value,func in pairs(restrict) do
		if self[value] then
			if not func(self, plr) then
				return
			end
		end
	end

	for value, func in pairs(claim) do
		if self[value] then
			func(self, plr)
		end
	end
end

return Kits