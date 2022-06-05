-- Variables

local RLCore = exports['rl-core']:GetCoreObject()
local fuelSynced = false
local inBlacklisted = false
local inGasStation = false
local Stations = {}
local props = {
	'prop_gas_pump_1d',
	'prop_gas_pump_1a',
	'prop_gas_pump_1b',
	'prop_gas_pump_1c',
	'prop_vintage_pump',
	'prop_gas_pump_old2',
	'prop_gas_pump_old3',
}

-- Functions

local function ManageFuelUsage(vehicle)
	if not DecorExistOn(vehicle, Config.FuelDecor) then
		SetFuel(vehicle, math.random(200, 800) / 10)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))
		fuelSynced = true
	end
	if IsVehicleEngineOn(vehicle) then
		SetFuel(vehicle, GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
		SetVehicleEngineOn(veh, true, true, true)
	else
		SetVehicleEngineOn(veh, true, true, true)
	end
end

-- Threads

CreateThread(function()
	local bones = {
		'wheel_lr',
		'wheel_rr'
	}
	exports['qb-target']:AddTargetBone(bones, {
		options = {
		{
			type = "client",
			event = "lj-fuel:client:SendMenuToServer",
			icon = "fas fa-gas-pump",
			label = "Refuel Vehicle",
			canInteract = function()
				return inGasStation or HasPedGotWeapon(PlayerPedId(), 883325847)
			end
		}
	},
		distance = 1.5,
	})
end)

if Config.LeaveEngineRunning then
	CreateThread(function()
		while true do
			Wait(100)
			local ped = GetPlayerPed(-1)
			if DoesEntityExist(ped) and IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) and not IsPauseMenuActive() then
				local engineWasRunning = GetIsVehicleEngineRunning(GetVehiclePedIsIn(ped, true))
				Wait(1000)
				if DoesEntityExist(ped) and not IsPedInAnyVehicle(ped, false) and not IsEntityDead(ped) and not IsPauseMenuActive() then
					local veh = GetVehiclePedIsIn(ped, true)
					if engineWasRunning then
						SetVehicleEngineOn(veh, true, true, true)
					end
				end
			end
		end
	end)
end

if Config.ShowNearestGasStationOnly then
    CreateThread(function()
	local currentGasBlip = 0
	while true do
		local coords = GetEntityCoords(PlayerPedId())
		local closest = 1000
		local closestCoords

		for _, gasStationCoords in pairs(Config.GasStationsBlips) do
			local dstcheck = #(coords - gasStationCoords)
			if dstcheck < closest then
				closest = dstcheck
				closestCoords = gasStationCoords
			end
		end
		if DoesBlipExist(currentGasBlip) then
			RemoveBlip(currentGasBlip)
		end
		currentGasBlip = CreateBlip(closestCoords)
		Wait(10000)
	end
end)

elseif Config.ShowAllGasStations then
    CreateThread(function()
        for _, gasStationCoords in pairs(Config.GasStationsBlips) do
            CreateBlip(gasStationCoords)
        end
    end)
end

CreateThread(function() 
    for k=1, #Config.GasStations do
		Stations[k] = PolyZone:Create(Config.GasStations[k].zones, {
			name="GasStation"..k,
			minZ = 	Config.GasStations[k].minz,
			maxZ = Config.GasStations[k].maxz,
			debugPoly = false
		})
		Stations[k]:onPlayerInOut(function(isPointInside)
			if isPointInside then
				inGasStation = true
			else
				inGasStation = false
			end
		end)
    end
end)

CreateThread(function()
	DecorRegister(Config.FuelDecor, 1)
	for index = 1, #Config.Blacklist do
		if type(Config.Blacklist[index]) == 'string' then
			Config.Blacklist[GetHashKey(Config.Blacklist[index])] = true
		else
			Config.Blacklist[Config.Blacklist[index]] = true
		end
	end
	for index = #Config.Blacklist, 1, -1 do
		Config.Blacklist[index] = nil
	end
	while true do
		Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			if Config.Blacklist[GetEntityModel(vehicle)] then
				inBlacklisted = true
			else
				inBlacklisted = false
			end
			if not inBlacklisted and GetPedInVehicleSeat(vehicle, -1) == ped then
				ManageFuelUsage(vehicle)
			end
		else
			if fuelSynced then
				fuelSynced = false
			end
			if inBlacklisted then
				inBlacklisted = false
			end
		end
	end
end)

-- Client Events

RegisterNetEvent('lj-fuel:client:buyCanMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "Gas Station",
            txt = 'The total cost is going to be: $'..Config.canCost..' including taxes.',
            params = {
                event = "lj-fuel:client:buyCan",
            }
        },
    })
end)

RegisterNetEvent('lj-fuel:client:buyCan', function()
    if not HasPedGotWeapon(ped, 883325847) then
		if RLCore.Functions.GetPlayerData().money['cash'] >= Config.canCost then
			TriggerServerEvent('RLCore:Server:AddItem', "weapon_petrolcan", 1)
			SetPedAmmo(ped, 883325847, 4500)
			TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["weapon_petrolcan"], "add")
        	TriggerServerEvent('lj-fuel:server:PayForFuel', Config.canCost, GetPlayerServerId(PlayerId()))
		else
			RLCore.Functions.Notify("Don't not have enough money", "error")
		end
    end
end)

RegisterNetEvent('lj-fuel:client:refuelCanMenu', function()
	exports['qb-menu']:openMenu({
		{
			header = "Gas Station",
			txt = "Buy jerry can. Remember there will be a 10% tax fee.",
			params = {
				event = "lj-fuel:client:refuelCan",
			}
		},
	})
end)

RegisterNetEvent('lj-fuel:client:refuelCan', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
	local ped = PlayerPedId()
	local CurFuel = GetVehicleFuelLevel(vehicle)
	if HasPedGotWeapon(ped, 883325847) then
	if GetAmmoInPedWeapon(ped, 883325847) < 4500 then
		RequestAnimDict("weapon@w_sp_jerrycan")
		while not HasAnimDictLoaded('weapon@w_sp_jerrycan') do Wait(100) end
			TaskPlayAnim(ped, "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
			RLCore.Functions.Progressbar("refuel-car", "Refueling", 10000, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
			}, {}, {}, {}, function() -- Done
			TriggerServerEvent('lj-fuel:server:PayForFuel', Config.refuelCost, GetPlayerServerId(PlayerId()))
			SetPedAmmo(ped, 883325847, 4500)
			PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
			StopAnimTask(ped, "weapon@w_sp_jerrycan", "fire", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
		end, function() -- Cancel
			RLCore.Functions.Notify("Refueling Canceled", "error")
			StopAnimTask(ped, "weapon@w_sp_jerrycan", "fire", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
			end)
		else 
			RLCore.Functions.Notify("This jerry can is already full", "error")
		end
	end
end)

RegisterNetEvent('lj-fuel:client:SendMenuToServer', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
	local CurFuel = GetVehicleFuelLevel(vehicle)
	local refillCost = Round(Config.RefillCost - CurFuel) * Config.CostMultiplier
	if CurFuel < 95 then
		TriggerServerEvent('lj-fuel:server:OpenMenu', refillCost, inGasStation)
	else
		RLCore.Functions.Notify("This vehicle is already full", "error")
	end
end)

RegisterNetEvent('lj-fuel:client:RefuelVehicle', function(refillCost)
	local vehicle = RLCore.Functions.GetClosestVehicle()
	local ped = PlayerPedId()
	local CurFuel = GetVehicleFuelLevel(vehicle)
	local time = (100 - CurFuel) * 400
	local vehicleCoords = GetEntityCoords(vehicle)
	if inGasStation == false and not HasPedGotWeapon(ped, 883325847) then
	elseif inGasStation == false and GetAmmoInPedWeapon(ped, 883325847) == 0 then
		return
	end
	if HasPedGotWeapon(ped, 883325847) then
		RequestAnimDict("weapon@w_sp_jerrycan")
		while not HasAnimDictLoaded('weapon@w_sp_jerrycan') do 
			Wait(100) 
		end
			TaskPlayAnim(ped, "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
			if GetIsVehicleEngineRunning(vehicle) and Config.VehicleBlowUp then
				local Chance = math.random(1, 100)
			if Chance <= Config.BlowUpChance then
				AddExplosion(vehicleCoords, 5, 50.0, true, false, true)
					return
				end
			end
			RLCore.Functions.Progressbar("refuel-car", "Refueling", time, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
				}, {}, {}, {}, function() -- Done
				SetFuel(vehicle, 100)
				SetPedAmmo(ped, 883325847, 0)
				PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
				StopAnimTask(ped, "weapon@w_sp_jerrycan", "fire", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
			end, function() -- Cancel
				RLCore.Functions.Notify("Refueling Canceled", "error")
				StopAnimTask(ped, "weapon@w_sp_jerrycan", "fire", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
			end)
		else
		if inGasStation then
			if isCloseVeh() then
				if RLCore.Functions.GetPlayerData().money['cash'] <= refillCost then 
					RLCore.Functions.Notify("Don't not have enough money", "error")
				else
				RequestAnimDict("weapon@w_sp_jerrycan")
				while not HasAnimDictLoaded('weapon@w_sp_jerrycan') do Wait(100) end
				TaskPlayAnim(ped, "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
				if GetIsVehicleEngineRunning(vehicle) and Config.VehicleBlowUp then
					local Chance = math.random(1, 100)
				if Chance <= Config.BlowUpChance then
					AddExplosion(vehicleCoords, 5, 50.0, true, false, true)
						return
					end
				end
				RLCore.Functions.Progressbar("refuel-car", "Refueling", time, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					TriggerServerEvent('lj-fuel:server:PayForFuel', refillCost, GetPlayerServerId(PlayerId()))
					SetFuel(vehicle, 100)
					PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
					StopAnimTask(ped, "weapon@w_sp_jerrycan", "fire", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
				end, function() -- Cancel
					RLCore.Functions.Notify("Refueling Canceled", "error")
					StopAnimTask(ped, "weapon@w_sp_jerrycan", "fire", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
					end)
				end
			end
		end
	end
end)

-- Target Export

exports['qb-target']:AddTargetModel(props, {
	options = {
		{
			type = "client",
			event = "lj-fuel:client:buyCanMenu",
			icon = "fas fa-burn",
			label = "Buy Jerry Can",
		},
		{
			type = "client",
			event = "lj-fuel:client:refuelCanMenu",
			icon = "fas fa-gas-pump",
			label = "Refuel Jerry Can",
		},
	},
		distance = 2.0
})