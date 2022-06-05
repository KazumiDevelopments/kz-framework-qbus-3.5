-- Debug printer
function dprint(msg)
	if debugMode then
		print(msg)
	end
end

-- Spawn the vehicle with the given properties.
function spawnVehicle(model, x, y, z, heading)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end
	local vehicle = CreateVehicle(model, x, y, z, heading, true, false)
	SetVehicleHasBeenOwnedByPlayer(vehicle, true)
	return vehicle
end

RegisterNetEvent('sd:save')
AddEventHandler('sd:save', function(vehicle)
	local model = GetEntityModel(vehicle)
	local x,y,z = table.unpack(GetEntityCoords(vehicle))
	local heading = GetEntityHeading(vehicle)
	TriggerServerEvent('sd:save', vehicle, model, x, y, z, heading)
end)

-- Trigger vehicle save (set interval in config)
Citizen.CreateThread(function()
	ped = GetPlayerPed(-1)
	local vehicle = 0
	local inVeh = false
	while true do
		dprint('Triggering save...')
		if IsPedInAnyVehicle(ped) then
			inVeh = true
			vehicle = GetVehiclePedIsUsing(ped)
			TriggerEvent('sd:save', vehicle)
			SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		elseif saveOnExit then
			if inVeh then
				TriggerEvent('sd:save', vehicle)
			end
			inVeh = false
		end

		Citizen.Wait(intervals.save*1000)
	end
end)

-- Check which saved ids don't match with the corresponding models to detect despawned vehicles.
RegisterNetEvent('sd:checkVehs')
AddEventHandler('sd:checkVehs', function(table)
	local results = {
		['restored'] = 0,
		['total'] = 0
	}
	for i=1,#table,1 do
		if GetEntityModel(table[i].id) ~= table[i].model then
			local newId = spawnVehicle(table[i].model, table[i].position.x, table[i].position.y, table[i].position.z, table[i].heading)
			TriggerServerEvent('sd:updateId', table[i].id, newId)
			results.restored = results.restored + 1
			Citizen.Wait(100)
		end
		results.total = results.total + 1
	end
	dprint(results.restored .. '/' .. results.total .. ' vehicles have been restored!')
end)

-- Trigger despawn check (set interval in config).
Citizen.CreateThread(function()
	while true do
		dprint('Retrieving table...')
		TriggerServerEvent('sd:retrieveTable')
		Citizen.Wait(intervals.check*1000)
	end
end)

if saveOnEnter then
	Citizen.CreateThread(function()
		local inVehicle = false
		while true do
			if IsPedInAnyVehicle(ped) then
				if not inVehicle then
					TriggerEvent('sd:save', GetVehiclePedIsUsing(ped))
				end
				inVehicle = true
			else
				inVehicle = false
			end
			Citizen.Wait(500)
		end
	end)
end