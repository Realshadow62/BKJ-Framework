local Restrictions = {}

function Restrictions.Team(kit, plr)
	if plr.Team == kit.Team then
		return true
	end
	return false
end

function Restrictions.Tickets(kit)
	if kit.Tickets > 0 then
		return true		
	end
	return false
end

return Restrictions