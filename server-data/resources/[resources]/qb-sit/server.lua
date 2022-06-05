local RLCore = exports['rl-core']:GetCoreObject()

local seatsTaken = {}

RegisterNetEvent('rl-sit:takePlace', function(objectCoords)
	seatsTaken[objectCoords] = true
end)

RegisterNetEvent('rl-sit:leavePlace', function(objectCoords)
	if seatsTaken[objectCoords] then
		seatsTaken[objectCoords] = nil
	end
end)

RLCore.Functions.CreateCallback('rl-sit:getPlace', function(source, cb, objectCoords)
	cb(seatsTaken[objectCoords])
end)