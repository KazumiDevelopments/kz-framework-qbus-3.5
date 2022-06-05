local RLCore = exports['rl-core']:GetCoreObject()

isLoggedIn = false
PlayerJob = {}
local onDuty = true

local BackEngineVehicles = {
    'ninef',
    'adder',
    'vagner',
    't20',
    'infernus',
    'zentorno',
    'reaper',
    'comet2',
    'comet3',
    'jester',
    'jester2',
    'cheetah',
    'cheetah2',
    'prototipo',
    'turismor',
    'pfister811',
    'ardent',
    'nero',
    'nero2',
    'tempesta',
    'vacca',
    'bullet',
    'osiris',
    'entityxf',
    'turismo2',
    'fmj',
    're7b',
    'tyrus',
    'italigtb',
    'penetrator',
    'monroe',
    'ninef2',
    'stingergt',
    'surfer',
    'surfer2',
    'comet3',
}

local blips = {
     {title="Tuner Autos", colour=46, id=402}
  }
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(174.24, -3023.22, 5.8)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

--playerload
RegisterNetEvent('RLCore:Client:OnPlayerLoaded')
AddEventHandler('RLCore:Client:OnPlayerLoaded', function()
    RLCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "tuner" then
                TriggerServerEvent("RLCore:ToggleDuty")
            end
        end
    end)
    isLoggedIn = true
end)

--playerduty
RegisterNetEvent("tuner:duty")
AddEventHandler("tuner:duty", function()
        onDuty = not onDuty
        TriggerServerEvent("RLCore:ToggleDuty")
end)

--shop
RegisterNetEvent('inventory:client:OpenMechanicShop')
AddEventHandler('inventory:client:OpenMechanicShop', function()
    print(onDuty)
    if onDuty then
    local ShopItems = {}
    ShopItems.label = "Mechanic Shop"
    ShopItems.items = Config.MechanicItems
    ShopItems.slots = #Config.MechanicItems
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Mechanic Shop", ShopItems)
else
    RLCore.Functions.Notify("You must sign on duty first", "error", 5000) -- [text] = message, [type] = primary | error | success, [length] = time till fadeout.
end
end)

--stash
RegisterNetEvent("tuner:stash")
AddEventHandler("tuner:stash", function()
    if onDuty then
    TriggerEvent("inventory:client:SetCurrentStash", "tuner")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "tuner", {
        maxweight = 4000000,
        slots = 500,
    })
else
    RLCore.Functions.Notify("You must sign on duty first", "error", 5000) -- [text] = message, [type] = primary | error | success, [length] = time till fadeout.
end
end)

-- Turbo install 
RegisterNetEvent('tuner-autos:Turbo')
AddEventHandler('tuner-autos:Turbo', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
    if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing Turbo", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function()
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed A Turbo!'stu tu tu'")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(vehicle, 18, true)
                                     ToggleVehicleMod(vehicle, 18, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveTurbo")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)

-- Transmission install
RegisterNetEvent('tuner-autos:TRANSLV1')
AddEventHandler('tuner-autos:TRANSLV1', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
    if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing A Stage 1 Transmission", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed A Stage 1 Tranny")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(vehicle, 13, 0, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveTranslv1")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)

RegisterNetEvent('tuner-autos:TRANSLV2')
AddEventHandler('tuner-autos:TRANSLV2', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
    if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing A Stage 2 Transmission", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed A Stage 2 Tranny")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(vehicle, 13, 1, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveTranslv2")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)

RegisterNetEvent('tuner-autos:TRANSLV3')
AddEventHandler('tuner-autos:TRANSLV3', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
    if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing A Stage 3 Transmission", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed A Stage 3 Tranny")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(vehicle, 13, 2, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveTranslv3")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)

--Engine install
RegisterNetEvent('tuner-autos:ENGLV1')
AddEventHandler('tuner-autos:ENGLV1', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
   if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing A Stage 1 Engine", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed A Stage 1 Engine")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(vehicle, 11, 0, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveEnglv1")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)

RegisterNetEvent('tuner-autos:ENGLV2')
AddEventHandler('tuner-autos:ENGLV2', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
    if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing A Stage 2 Engine", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed A Stage 2 Engine")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(vehicle, 11, 1, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveEnglv2")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)


RegisterNetEvent('tuner-autos:ENGLV3')
AddEventHandler('tuner-autos:ENGLV3', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
    if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing A Stage 3 Engine", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed A Stage 3 Engine")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(vehicle, 11, 2, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveEnglv3")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)

RegisterNetEvent('tuner-autos:ENGLV4')
AddEventHandler('tuner-autos:ENGLV4', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
    if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing Engine", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed A Stage 4 Engine")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(vehicle, 11, 3, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveEnglv4")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)

-- Brakes Install
RegisterNetEvent('tuner-autos:BRAKESLV1')
AddEventHandler('tuner-autos:BRAKESLV1', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
    if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing Stage 1 Brakes", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed Stage 1 Brakes")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(veh, 12, 0, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveBrakeslv1")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)

RegisterNetEvent('tuner-autos:BRAKESLV2')
AddEventHandler('tuner-autos:BRAKESLV2', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
    if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing Stage 2 Brakes", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed Stage 2 Brakes")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(veh, 12, 1, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveBrakeslv2")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)

RegisterNetEvent('tuner-autos:BRAKESLV3')
AddEventHandler('tuner-autos:BRAKESLV3', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
	if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing Stage 3 Brakes", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed Stage 3 Brakes")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(veh, 12, 2, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveBrakeslv3")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)

--Suspension install
RegisterNetEvent('tuner-autos:SUSLV1')
AddEventHandler('tuner-autos:SUSLV1', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
    if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing Stage 1 Suspension", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed Stage 1 Suspension")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(veh, 15, 0, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveSuslv1")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)

RegisterNetEvent('tuner-autos:SUSLV2')
AddEventHandler('tuner-autos:SUSLV2', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
    if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing Stage 2 Suspension", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed Stage 2 Suspension")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(veh, 15, 1, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveSuslv2")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)


RegisterNetEvent('tuner-autos:SUSLV3')
AddEventHandler('tuner-autos:SUSLV3', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
    if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing Stage 3 Suspension", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed Stage 3 Suspension")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(veh, 15, 2, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveSuslv3")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)



RegisterNetEvent('tuner-autos:SUSLV4')
AddEventHandler('tuner-autos:SUSLV4', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
    if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Installing Stage 4 Suspension", 15000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                    local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
                    if success then
                        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
                        RLCore.Functions.Notify("Success You Installed Stage 4 Suspension")
                        ClearPedTasksImmediately(PlayerPedId())
                                     SetVehicleModKit(vehicle, 0)
                                     SetVehicleMod(veh, 15, 3, true)
                                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                                     TriggerServerEvent('updateVehicle', vehicle)
                                     TriggerServerEvent("tuner-autos:RemoveSuslv4")
                        ClearPedTasks(playerPed)
                    else
                        RLCore.Functions.Notify("Failed You Snapped A Bolt..", "error")
                        ClearPedTasks(playerPed)
                    end
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)


--misc
--[[RegisterNetEvent('tuner-autos:RepairKit')
AddEventHandler('tuner-autos:RepairKit', function()
	local vehicle = RLCore.Functions.GetClosestVehicle()
    local PlayerJob = RLCore.Functions.GetPlayerData().job
    if PlayerJob.name == "tuner" then
	if onDuty then
	if vehicle ~= nil and vehicle ~= 0 then
        if (IsBackEngine(GetEntityModel(vehicle))) then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        else
            SetVehicleDoorOpen(vehicle, 4, false, false)
        end
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
			
                RLCore.Functions.Progressbar("tuner_Transmission", "Repairing car", 20000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
                     ClearPedTasksImmediately(PlayerPedId())
                     SetVehicleModKit(vehicle, 0)
                     SetVehicleFixed(veh)
                     SetVehicleDirtLevel(veh, 0.0)
                     SetVehiclePetrolTankHealth(veh, 1000.0)
                     local vehicle = RLCore.Functions.GetVehicleProperties(vehicle)
                     TriggerServerEvent('updateVehicle', vehicle)
                     TriggerServerEvent("tuner-autos:RemoveRepairKit")
                     
                end)

			end
		end
	end
else
    RLCore.Functions.Notify("You need to sign on duty", "Error", 5000)
end
else
    RLCore.Functions.Notify("Do you work for tuner?", "error", 4000)
end
end)]]




--Crafting engine
RegisterNetEvent('tuner:Engines1')
AddEventHandler("tuner:Engines1", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting A Stage 1 Engine", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds 
    if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:EnginesCraft1")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000) 
        ClearPedTasks(playerPed)
    end    
         
    end)    
end)

RegisterNetEvent('tuner:Engines2')
AddEventHandler("tuner:Engines2", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting A Stage 2 Engine", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:EnginesCraft2")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)    
end)

RegisterNetEvent('tuner:Engines3')
AddEventHandler("tuner:Engines3", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting A Stage 3 Engine", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:EnginesCraft3")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)    
end)

RegisterNetEvent('tuner:Engines4')
AddEventHandler("tuner:Engines4", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting A Stage 4 Engine", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:EnginesCraft4")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)    
end)

--Crafting transmission
RegisterNetEvent('tuner:Transmission1')
AddEventHandler("tuner:Transmission1", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting A Stage 1 Tranny", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:TransmissionCraft1")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)    
end)

RegisterNetEvent('tuner:Transmission2')
AddEventHandler("tuner:Transmission2", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting A Stage 2 Tranny", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:TransmissionCraft2")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)    
end)

RegisterNetEvent('tuner:Transmission3')
AddEventHandler("tuner:Transmission3", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting A Stage 3 Tranny", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:TransmissionCraft3")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)    
end)


--Crafting brakes
RegisterNetEvent('tuner:Brakeslv1')
AddEventHandler("tuner:Brakeslv1", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting Stage 1 Brakes", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:BrakesCraft1")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)    
end)    


RegisterNetEvent('tuner:Brakeslv2')
AddEventHandler("tuner:Brakeslv2", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting Stage 2 Brakes", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:BrakesCraft2")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)   
end)

RegisterNetEvent('tuner:Brakeslv3')
AddEventHandler("tuner:Brakeslv3", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting Stage 3 Brakes", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:BrakesCraft3")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)    
end)

--craft suspension
RegisterNetEvent('tuner:Suslv1')
AddEventHandler("tuner:Suslv1", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting Stage 1 Suspension", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:SuspensionCraft1")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)    
end)

RegisterNetEvent('tuner:Suslv2')
AddEventHandler("tuner:Suslv2", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting Stage 2 Suspension", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:SuspensionCraft2")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)    
end)

RegisterNetEvent('tuner:Suslv3')
AddEventHandler("tuner:Suslv3", function() 
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting Stage 3 Suspension", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:SuspensionCraft3")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)    
end)

RegisterNetEvent('tuner:Suslv4')
AddEventHandler("tuner:Suslv4", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting Stage 4 Suspension", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:SuspensionCraft4")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)    
end)

--Craft turbo
RegisterNetEvent('tuner:Turbos')
AddEventHandler("tuner:Turbos", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner:TurboCraft")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)   
end)

--Craft repairkit
RegisterNetEvent('tuner:RepairKit')
AddEventHandler("tuner:RepairKit", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
   if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("tuner-jobcrafting:server:makerepairkit")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)    
end)

--Craft lockpick
RegisterNetEvent('tuner:LockPick')
AddEventHandler("tuner:LockPick", function()
    RLCore.Functions.Progressbar("tuner_Transmission", "Crafting", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_player",
        flags = 16,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        if onDuty then
        playAnim("anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_crouch_checkingleaves_idle_01_inspector", 10000)
        local success = exports["tgiann-skillbar"]:taskBar(3) --StartLockPickCircle(1,10) 1= how many times, 30 = time in seconds
   if success then
        StopAnimTask(ped, dict, "machinic_loop_mechandplayer", 1.0)
        TriggerServerEvent("uner-jobcrafting:server:makelockpick")
        ClearPedTasks(playerPed)
    else
        RLCore.Functions.Notify("Crafting Failed!", "error")
        ClearPedTasks(playerPed)
    end
    else
        RLCore.Functions.Notify("You must sign on duty first", "error", 5000)
        ClearPedTasks(playerPed) 
    end    
         
    end)   
end)

--Qb-menu
RegisterNetEvent("tuner-autosjob:client:MechanicShopPay", function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Till",
        submitText = "Bill Person",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'id',
                text = '      PAYPAL ID'
            },
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = '      AMOUNT'
            }
        }
    })
    if dialog then
        if not dialog.id or not dialog.amount then return end
        TriggerServerEvent("tuner-autosjob:client:MechanicShopPay:player", dialog.id, dialog.amount)
    end
end)

RegisterNetEvent('CheckVehStatus')
AddEventHandler('CheckVehStatus', function()
    veh = RLCore.Functions.GetClosestVehicle()
    plate = GetVehicleNumberPlateText(veh)
    engineHealth = GetVehicleEngineHealth(veh)
    vehTemp = GetVehicleEngineTemperature(veh)
    bodyHealth = GetVehicleBodyHealth(veh)
    fuelHealth = exports['lj-fuel']:GetFuel(veh)
    tankHealth = GetVehiclePetrolTankHealth(veh)
 
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "<  Go back",
            txt = "",
            params = {
                event = "Check:vehicle"
            }
        },
        {
            id = 2,
            header = "Fuel Level",
            txt = "Status: " .. math.ceil(fuelHealth) .. ".0% / 100.0%",
        },
        {
            id = 3,
            header = "Engine Health",
            txt = "Status: " .. math.ceil(engineHealth / 10) .. "% / 100.0%",
        },
        {
            id = 4,
            header = "Body Health",
            txt = "Status: " .. math.ceil(bodyHealth / 10) .. "% / 100.0%",
        },
        {
            id = 5,
            header = "Tank Health",
            txt = "Status: " .. math.ceil(tankHealth / 10) .. "% / 100.0%",
        },
        {
            id = 6,
            header = "Engine Temperature",
            txt = "Status: " .. math.ceil(vehTemp) .. "° C",
        },        
    })
    
end)

RegisterNetEvent('Check:vehicle', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Vehicle Stats",
            txt = plate,
        },
        {
            id = 2,
            header = "Check Health",
            txt = "Status?",
            params = {
                event = "CheckVehStatus",
                args = {
                    
                }
            }
        },
        {
            id = 3,
            header = "Check Upgrades",
            txt = "Status?",
            params = {
                event = "CheckMods",
                args = {
                    
                }
            }
        },
        {
            id = 4,
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },        
    })
end)


RegisterNetEvent('CheckMods')
AddEventHandler('CheckMods', function()

    veh = RLCore.Functions.GetClosestVehicle()
    engine = GetVehicleMod(veh, 11)
    brakes = GetVehicleMod(veh, 12)
    transmission = GetVehicleMod(veh, 13)
    suspension = GetVehicleMod(veh, 15)
    turbo = IsToggleModOn(veh, 18)
    
    if engine == -1 then
        engine = "Standard"
    elseif
    engine == 0 then
        engine = "Upgrade Level 1"
    elseif
    engine == 1 then
        engine = "Upgrade Level 2"
    elseif
    engine == 2 then
        engine = "Upgrade Level 3"
    elseif
    engine == 3 then
        engine = "Upgrade Level 4"
    end
    if brakes == -1 then
        brakes = "Standard"
    elseif
    brakes == 0 then
        brakes = "Upgrade Level 1"
    elseif
    brakes == 1 then
        brakes = "Upgrade Level 2"
    elseif
    brakes == 2 then
        brakes = "Upgrade Level 3"
    end
    if transmission == -1 then
        transmission = "Standard"
    elseif
    transmission == 0 then
        transmission = "Upgrade Level 1"
    elseif
    transmission == 1 then
        transmission = "Upgrade Level 2"
    elseif
    transmission == 2 then
        transmission = "Upgrade Level 3"
    end
    if suspension == -1 then
        suspension = "Standard"
    elseif
    suspension == 0 then
        suspension = "Upgrade Level 1"
    elseif
    suspension == 1 then
        suspension = "Upgrade Level 2"
    elseif
    suspension == 2 then
        suspension = "Upgrade Level 3"
    end
    if turbo == "0" then
        turbo = "Standard"
    elseif
    turbo == 1 then
        turbo = "You have a Turbo"
    end
    
    
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "<  Go back",
            txt = "",
            params = {
                event = "Check:vehicle"
            }
        },
        {
            id = 2,
            header = "Engine Upgrades",
            txt =  engine,
        },
        {
            id = 3,
            header = "Brakes Upgrade",
            txt = brakes,
        },
        {
            id = 4,
            header = "Transmission Upgrade",
            txt = transmission,
        },
        {
            id = 5,
            header = "Suspension Upgrade",
            txt = suspension,
        },
        {
            id = 6,
            header = "Turbo Upgrade",
            txt = turbo,
        },
              
    })
    
end)

RegisterNetEvent('tuner-jobcrafting:Menu1', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "tuner Parts",
            txt = ""
        },
        {
            id = 2,
            header = "Engines",
            txt = " ",
            params = {
                event = "tuner:Engines",
            }
        },
        {
            id = 3,
            header = "Transmission",
            txt = " ",
            params = {
                event = "tuner:trans",
            }
        },
        {
            id = 4,
            header = "Brakes",
            txt = " ",
            params = {
                event = "tuner:brakes",
            }
        },
        {
            id = 5,
            header = "Suspension",
            txt = " ",
            params = {
                event = "tuner:Suspension",
            }
        },
        {
            id = 6,
            header = "Turbo",
            txt = " 150 Scrap | 150 Steel | 150 Plastic | 150 Aluminum ",
            params = {
                event = "tuner:Turbos",
            }
        },
        {
            id = 7,
            header = "Repair Kit",
            txt = " 10 Scrap | 10 Steel | 10 Plastic | 10 Aluminum ",
            params = {
                event = "tuner:RepairKit",
            }
        },
        {
            id = 8,
            header = "Advanced LockPick ",
            txt = " 5 Scrap | 5 Steel | 5 Plastic | 5 Aluminum ",
            params = {
                event = "tuner:LockPick",
            }
        },
    })
end)


RegisterNetEvent('tuner:Engines', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "tuner Engine",
            txt = " Prices "
        },
        {
            id = 2,
            header = "Stage 1 Engine",
            txt = " 25 Scrap | 25 Steel | 25 Plastic | 25 aluminum ",
            params = {
                event = "tuner:Engines1",
            }
        },
        {
            id = 3,
            header = "Stage 2 Engine",
            txt = " 50 Scrap | 50 Steel | 50 Plastic | 50 aluminum ",
            params = {
                event = "tuner:Engines2",
            }
        },
        {
            id = 4,
            header = "Stage 3 Engine",
            txt = " 100 Scrap | 100 Steel | 100 Plastic | 100 aluminum ",
            params = {
                event = "tuner:Engines3",
            }
        },
        {
            id = 5,
            header = "Stage 4 Engine",
            txt = " 150 Scrap | 150 Steel | 150 Plastic | 150 aluminum ",
            params = {
                event = "tuner:Engines4",
            }
        },

        {
            id = 6,
            header = "BACK",
            txt = " ",
            params = {
                event = "tuner-jobcrafting:Menu1",
            }
        },

    })
end)

RegisterNetEvent('tuner:trans', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "tuner Transmissions",
            txt = " Prices ",
        },
        {
            id = 2,
            header = "Stage 1 Transmission",
            txt = " 25 Scrap | 25 Steel | 25 Plastic | 25 Aluminum ",
            params = {
                event = "tuner:Transmission1",
            }
        },
        {
            id = 3,
            header = "Stage 2 Transmission",
            txt = " 50 Scrap | 50 Steel | 50 Plastic | 50 Aluminum ",
            params = {
                event = "tuner:Transmission2",
            }
        },
        {
            id = 4,
            header = "Stage 3 Transmission",
            txt = " 100 Scrap | 100 Steel | 100 Plastic | 100 Aluminum ",
            params = {
                event = "tuner:Transmission3",
            }
        },
        
        {
            id = 5,
            header = "BACK",
            txt = " ",
            params = {
                event = "tuner-jobcrafting:Menu1",
            }
        },

    })
end)


RegisterNetEvent('tuner:brakes', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "tuner Brakes",
            txt = " Prices "
        },
        {
            id = 2,
            header = "Stage 1 Brakes",
            txt = " 25 Scrap | 25 Steel | 25 Plastic | 25 Aluminum ",
            params = {
                event = "tuner:Brakeslv1",
            }
        },
        {
            id = 3,
            header = "Stage 2 Brakes",
            txt = " 50 Scrap | 50 Steel | 50 Plastic | 50 Aluminum ",
            params = {
                event = "tuner:Brakeslv2",
            }
        },
        {
            id = 4,
            header = "Stage 3 Brakes",
            txt = " 100 Scrap | 100 Steel | 100 Plastic | 100v Aluminum ",
            params = {
                event = "tuner:Brakeslv3",
            }
        },
        
        {
            id = 5,
            header = "BACK",
            txt = " ",
            params = {
                event = "tuner-jobcrafting:Menu1",
            }
        },

    })
end)

RegisterNetEvent('tuner:Suspension', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "tuner Suspensions",
            txt = " Prices "
        },
        {
            id = 2,
            header = "Stage 1 Suspensions",
            txt = " 25 Scrap | 25 Steel | 25 Plastic | 25 Aluminum  ",
            params = {
                event = "tuner:Suslv1",
            }
        },
        {
            id = 3,
            header = "Stage 2 Suspensions",
            txt = " 50 Scrap | 50 Steel | 50 Plastic | 50 Aluminum ",
            params = {
                event = "tuner:Suslv2",
            }
        },
        {
            id = 4,
            header = "Stage 3 Suspensions",
            txt = " 100 Scrap | 100 Steel | 100 Plastic | 100 Aluminum ",
            params = {
                event = "tuner:Suslv3",
            }
        },
        {
            id = 5,
            header = "Stage 4 Suspensions",
            txt = " 150 Scrap | 150 Steel | 150 Plastic | 150 Aluminum ",
            params = {
                event = "tuner:Suslv4",
            }
        },
        
        {
            id = 5,
            header = "BACK",
            txt = " ",
            params = {
                event = "tuner-jobcrafting:Menu1",
            }
        },

    })
end)


--functions
function IsBackEngine(vehModel)
    for _, model in pairs(BackEngineVehicles) do
        if GetHashKey(model) == vehModel then
            return true
        end
    end
    return false
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(0)
    end
end

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Wait(0) 
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end