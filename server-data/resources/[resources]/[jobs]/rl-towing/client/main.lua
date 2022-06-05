RLCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

local PlayerJob = {}
local CurrentPlate = nil
local JobsDone = 0
local NpcOn = false
local CurrentLocation = {}

local selectedVeh = nil

Citizen.CreateThread(function()
	while RLCore == nil do
		TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
		Citizen.Wait(200)
	end

	while RLCore.Functions.GetPlayerData() == nil do
		Wait(0)
	end

	while RLCore.Functions.GetPlayerData().job == nil do
		Wait(0)
	end
end)

RegisterNetEvent('rl-tow:client:ImpoundVehicle')
AddEventHandler('rl-tow:client:ImpoundVehicle', function()
    local playerped = PlayerPedId()
    local coordA = GetEntityCoords(playerped, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB)

    if DoesEntityExist(targetVehicle) then
        TaskStartScenarioInPlace(playerped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
        RLCore.Functions.Progressbar("impound", "Impounding", 6000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            ClearPedTasks(PlayerPedId())
            RLCore.Functions.Notify("Impounded!", "success")
            RLCore.Functions.DeleteVehicle(targetVehicle)
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
            RLCore.Functions.Notify("Failed!", "error")
        end)
    end
end)

RegisterNetEvent('rl-tow:client:TowVehicle')
AddEventHandler('rl-tow:client:TowVehicle', function()
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
    if isTowVehicle(vehicle) then 
        if CurrentTow == nil then 
            local playerped = PlayerPedId()
            local coordA = GetEntityCoords(playerped, 1)
            local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
            targetVehicle = getVehicleInDirection(coordA, coordB)
            if NpcOn and CurrentLocation ~= nil then
                if GetEntityModel(targetVehicle) ~= GetHashKey(CurrentLocation.model) then
                    RLCore.Functions.Notify("This is not the right vehicle..", "error")
                    return
                end
            end
            if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                if vehicle ~= targetVehicle then
                    local towPos = GetEntityCoords(vehicle)
                    local targetPos = GetEntityCoords(targetVehicle)
                    if GetDistanceBetweenCoords(towPos.x, towPos.y, towPos.z, targetPos.x, targetPos.y, targetPos.z, true) < 11.0 then
                        RLCore.Functions.Progressbar("towing_vehicle", "Towing Vehicle", 5000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "mini@repair",
                            anim = "fixing_a_ped",
                            flags = 16,
                        }, {}, {}, function() -- Done
                            StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_ped", 1.0)
                            AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0, -1.5 + -0.85, 0.0 + 1.15, 0, 0, 0, 1, 1, 0, 1, 0, 1)
                            FreezeEntityPosition(targetVehicle, true)
                            CurrentTow = targetVehicle
                            RLCore.Functions.Notify("Vehicle Towed!")
                        end, function() -- Cancel
                            StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_ped", 1.0)
                            RLCore.Functions.Notify("Failed!", "error")
                        end)
                    end
                end
            end
        else
            RLCore.Functions.Progressbar("untowing_vehicle", "Untowing Vehicle", 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 16,
            }, {}, {}, function() -- Done
                StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_ped", 1.0)
                FreezeEntityPosition(CurrentTow, false)
                Citizen.Wait(250)
                AttachEntityToEntity(CurrentTow, vehicle, 20, -0.0, -15.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                DetachEntity(CurrentTow, true, true)
                if NpcOn then
                    local targetPos = GetEntityCoords(CurrentTow)
                    if GetDistanceBetweenCoords(targetPos.x, targetPos.y, targetPos.z, Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, true) < 25.0 then
                        deliverVehicle(CurrentTow)
                    end
                end
                CurrentTow = nil
                RLCore.Functions.Notify("Vehicle tackled!")
            end, function() -- Cancel
                StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_ped", 1.0)
                RLCore.Functions.Notify("Failed!", "error")
            end)
        end
    else
        RLCore.Functions.Notify("You must sit in the flatbed before you attempt to tow a vehicle.", "error")
    end
end)

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function isTowVehicle(vehicle)
    local retval = false
    for k, v in pairs(Config.Vehicles) do
        if GetEntityModel(vehicle) == GetHashKey(k) then
            retval = true
        end
    end
    return retval
end


function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end