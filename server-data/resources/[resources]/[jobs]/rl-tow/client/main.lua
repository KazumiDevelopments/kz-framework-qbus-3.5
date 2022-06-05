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

isLoggedIn = false
local PlayerJob = {}
local CurrentPlate = nil
local JobsDone = 0
local NpcOn = false
local CurrentLocation = {}
local CurrentBlip = nil
local LastVehicle = 0
local VehicleSpawned = false

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

    isLoggedIn = true
    PlayerJob = RLCore.Functions.GetPlayerData().job

    if PlayerJob.name == "tow" then
        local TowVehBlip = AddBlipForCoord(Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z)
        SetBlipSprite(TowVehBlip, 326)
        SetBlipDisplay(TowVehBlip, 4)
        SetBlipScale(TowVehBlip, 0.6)
        SetBlipAsShortRange(TowVehBlip, true)
        SetBlipColour(TowVehBlip, 4)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Locations["vehicle"].label)
        EndTextCommandSetBlipName(TowVehBlip)
    end
end)

RegisterNetEvent('RLCore:Client:OnPlayerUnload')
AddEventHandler('RLCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('RLCore:Client:OnJobUpdate')
AddEventHandler('RLCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo

    if PlayerJob.name == "tow" then
        local TowVehBlip = AddBlipForCoord(Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z)
        SetBlipSprite(TowVehBlip, 326)
        SetBlipDisplay(TowVehBlip, 4)
        SetBlipScale(TowVehBlip, 0.6)
        SetBlipAsShortRange(TowVehBlip, true)
        SetBlipColour(TowVehBlip, 4)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Locations["vehicle"].label)
        EndTextCommandSetBlipName(TowVehBlip)
    end
end)

RegisterNetEvent('jobs:client:ToggleNpc')
AddEventHandler('jobs:client:ToggleNpc', function()
    if RLCore.Functions.GetPlayerData().job.name == "tow" then
        if CurrentTow ~= nil then 
            RLCore.Functions.Notify("Finish your work first!", "error")
            return
        end
        NpcOn = not NpcOn
        if NpcOn then
            local randomLocation = getRandomVehicleLocation()
            CurrentLocation.x = Config.Locations["towspots"][randomLocation].coords.x
            CurrentLocation.y = Config.Locations["towspots"][randomLocation].coords.y
            CurrentLocation.z = Config.Locations["towspots"][randomLocation].coords.z
            CurrentLocation.model = Config.Locations["towspots"][randomLocation].model
            CurrentLocation.id = randomLocation

            CurrentBlip = AddBlipForCoord(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z)
            SetBlipColour(CurrentBlip, 3)
            SetBlipRoute(CurrentBlip, true)
            SetBlipRouteColour(CurrentBlip, 3)
        else
            if DoesBlipExist(CurrentBlip) then
                RemoveBlip(CurrentBlip)
                CurrentLocation = {}
                CurrentBlip = nil
            end
            VehicleSpawned = false
        end
    end
end)

RegisterNetEvent('rl-tow:client:ImpoundVehicle')
AddEventHandler('rl-tow:client:ImpoundVehicle', function()
    local playerped = PlayerPedId()
    local coordA = GetEntityCoords(playerped, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB)
    plate = GetVehicleNumberPlateText(targetVehicle) 

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
            RLCore.Functions.TriggerCallback('vehiclemod:server:saveStatus', function(result)
            end, plate)
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
                            if NpcOn then
                                RemoveBlip(CurrentBlip)
                                RLCore.Functions.Notify("Bring the vehicle to Hayes Depot!", "success", 5000)
                            end
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
        RLCore.Functions.Notify("You must have been in a hoisting vehicle first..", "error")
    end
end)

Citizen.CreateThread(function()
    local TowBlip = AddBlipForCoord(Config.Locations["payslip"].x, Config.Locations["payslip"].y, Config.Locations["payslip"].z)
    SetBlipSprite(TowBlip, 477)
    SetBlipDisplay(TowBlip, 4)
    SetBlipScale(TowBlip, 0.6)
    SetBlipAsShortRange(TowBlip, true)
    SetBlipColour(TowBlip, 4)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations["payslip"].label)
    EndTextCommandSetBlipName(TowBlip)
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and RLCore ~= nil then
            if PlayerJob.name == "tow" then
                local pos = GetEntityCoords(GetPlayerPed(-1))
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, true) < 1.5) then
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                            DrawText3D(Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, "Press [E] to store")
                        else
                            DrawText3D(Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, "Press [E] for vehicles")
                        end
                        if IsControlJustReleased(0, Keys["E"]) then
                            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                                TriggerServerEvent('rl-tow:server:DoBail', false)
                            else
                                MenuGarage()
                                Menu.hidden = not Menu.hidden
                            end
                        end
                        Menu.renderGUI()
                    end 
                end
    
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["payslip"].x, Config.Locations["payslip"].y, Config.Locations["payslip"].z, true) < 2) then
                    DrawText3D(Config.Locations["payslip"].x, Config.Locations["payslip"].y, Config.Locations["payslip"].z, "Press [E] to take your payslip")
                    if IsControlJustReleased(0, Keys["E"]) then
                        if JobsDone > 0 then
                            RemoveBlip(CurrentBlip)
                            TriggerServerEvent("rl-tow:server:11101110", JobsDone)
                            JobsDone = 0
                            NpcOn = false
                        else
                            RLCore.Functions.Notify("You have not done any work yet..", "error")
                        end
                    end
                end

                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["shop"].x, Config.Locations["shop"].y, Config.Locations["shop"].z, true) < 2) then
                    DrawText3D(Config.Locations["shop"].x, Config.Locations["shop"].y, Config.Locations["shop"].z, "Press [E] to open shop")
                    if IsControlJustReleased(0, Keys["E"]) then
                        TriggerServerEvent("inventory:server:OpenInventory", "shop", "tow", Config.Items)
                    end
                end

                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stash"].x, Config.Locations["stash"].y, Config.Locations["stash"].z, true) < 2.5) then
                    DrawText3D(Config.Locations["stash"].x, Config.Locations["stash"].y, Config.Locations["stash"].z, "Press [E] to open stash")
                    if IsControlJustReleased(0, Keys["E"]) then
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "tow")
                        TriggerEvent("inventory:client:SetCurrentStash", "tow")
                    end
                end

                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["boss"].x, Config.Locations["boss"].y, Config.Locations["boss"].z, true) < 2.5) and PlayerJob.isboss then
                    DrawText3D(Config.Locations["boss"].x, Config.Locations["boss"].y, Config.Locations["boss"].z, "Press [E] to access boss menu")
                    if IsControlJustReleased(0, Keys["E"]) then
                        TriggerServerEvent("bb-bossmenu:server:openMenu")
                    end
                end

                if NpcOn and CurrentLocation ~= nil and next(CurrentLocation) ~= nil then
                    if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, CurrentLocation.x, CurrentLocation.y, CurrentLocation.z, true) < 50.0 and not VehicleSpawned then
                        VehicleSpawned = true
                        RLCore.Functions.SpawnVehicle(CurrentLocation.model, function(veh)
                            exports['rl-hud']:SetFuel(veh, 0.0)
                            if math.random(1,2) == 1 then
                                doCarDamage(veh)
                            end
                        end, CurrentLocation, true)
                    end
                end
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

function deliverVehicle(vehicle)
    DeleteVehicle(vehicle)
    JobsDone = JobsDone + 1
    VehicleSpawned = false
    RLCore.Functions.Notify("You have delivered a vehicle!", "success")
    RLCore.Functions.Notify("A new vehicle can be picked up")

    local randomLocation = getRandomVehicleLocation()
    CurrentLocation.x = Config.Locations["towspots"][randomLocation].coords.x
    CurrentLocation.y = Config.Locations["towspots"][randomLocation].coords.y
    CurrentLocation.z = Config.Locations["towspots"][randomLocation].coords.z
    CurrentLocation.model = Config.Locations["towspots"][randomLocation].model
    CurrentLocation.id = randomLocation

    CurrentBlip = AddBlipForCoord(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z)
    SetBlipColour(CurrentBlip, 3)
    SetBlipRoute(CurrentBlip, true)
    SetBlipRouteColour(CurrentBlip, 3)
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function getRandomVehicleLocation()
    local randomVehicle = math.random(1, #Config.Locations["towspots"])
    while (randomVehicle == LastVehicle) do
        Citizen.Wait(10)
        randomVehicle = math.random(1, #Config.Locations["towspots"])
    end
    return randomVehicle
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

function MenuGarage()
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Vehicles", "VehicleList", nil)
    Menu.addButton("Close Menu", "closeMenuFull", nil) 
end

function VehicleList(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "Vehicles:"
    ClearMenu()
    for k, v in pairs(Config.Vehicles) do
        Menu.addButton(Config.Vehicles[k], "TakeOutVehicle", k, "Garage", " Motor: 100%", " Body: 100%", " Fuel: 100%")
    end
        
    Menu.addButton("Back", "MenuGarage",nil)
end

function TakeOutVehicle(vehicleInfo)
    TriggerServerEvent('rl-tow:server:DoBail', true, vehicleInfo)
    selectedVeh = vehicleInfo
end

RegisterNetEvent('rl-tow:client:SpawnVehicle')
AddEventHandler('rl-tow:client:SpawnVehicle', function()
    local vehicleInfo = selectedVeh
    local coords = Config.Locations["vehicle"]
    RLCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "TOWR"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.h)
        exports['lj-fuel']:SetFuel(veh, 100)
        SetEntityAsMissionEntity(veh, true, true)
        closeMenuFull()
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
        SetVehicleEngineOn(veh, true, true)
        CurrentPlate = GetVehicleNumberPlateText(veh)
        for i = 1, 9, 1 do 
            SetVehicleExtra(veh, i, 0)
        end
    end, coords, true)
end)

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function doCarDamage(currentVehicle)
	smash = false
	damageOutside = false
	damageOutside2 = false 
	local engine = 199.0
	local body = 149.0
	if engine < 200.0 then
		engine = 200.0
    end
    
    if engine  > 1000.0 then
        engine = 950.0
    end

	if body < 150.0 then
		body = 150.0
	end
	if body < 950.0 then
		smash = true
	end

	if body < 920.0 then
		damageOutside = true
	end

	if body < 920.0 then
		damageOutside2 = true
	end

    Citizen.Wait(100)
    SetVehicleEngineHealth(currentVehicle, engine)
	if smash then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
	end
	if damageOutside then
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
	end
	if damageOutside2 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end
	if body < 1000 then
		SetVehicleBodyHealth(currentVehicle, 985.1)
	end
end

RegisterNetEvent('rl-tow:client:status')
AddEventHandler('rl-tow:client:status', function(degradation)
	local playerped = PlayerPedId()
	local coordA = GetEntityCoords(playerped, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
	targetVehicle = getVehicleInDirection(coordA, coordB)

    if targetVehicle ~= nil  and targetVehicle ~= 0 then
        SetVehicleDoorOpen(targetVehicle, 4, 0, 0)
        RequestAnimDict("mini@repair")
        while not HasAnimDictLoaded("mini@repair") do
            Citizen.Wait(0)
        end
    
        TaskTurnPedToFaceEntity(PlayerPedId(), targetVehicle, 1.0)
        Citizen.Wait(200)
    
        if not IsEntityPlayingAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 3) then
            TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end 

        Wait(5000)

        ClearPedTasks(playerped)
        SetVehicleDoorShut(targetVehicle, 4, 1, 1)

        if not RequestVehicle(targetVehicle) then
            return
        end

		engineHealth = GetVehicleEngineHealth(targetVehicle) 
        bodyHealth = GetVehicleBodyHealth(targetVehicle)
        dirtLevel = GetVehicleDirtLevel(targetVehicle)
        tyres = GetVehicleNumberOfWheels(targetVehicle)*2

        for i=0,GetVehicleNumberOfWheels(targetVehicle)+1 do
            if IsVehicleTyreBurst(targetVehicle, i) then
                tyres = tyres - 2
            end
        end

        currentVeh = targetVehicle
        engineHealth = GetVehicleEngineHealth(targetVehicle) 
        bodyHealth = GetVehicleBodyHealth(targetVehicle)
        TriggerEvent("rl-tow:getDegredation", targetVehicle, function(degHealth)
            TriggerEvent('chat:addMessage', {
                template = "<div class='chat-message emergency'>SYSTEM:<br> Brakes (Rubber) - " .. round(degHealth["breaks"] / 10,2) .. "/10.0" .. " <br> Axle (Scrap) - " .. round(degHealth["axle"] / 10,2) .. "/10.0" .. " <br> Radiator (Scrap) - " .. round(degHealth["radiator"] / 10,2) .. "/10.0" .. " <br> Clutch (Scrap) - " .. round(degHealth["clutch"] / 10,2) .. "/10.0" .. " <br> Transmission (Aluminium) - " .. round(degHealth["transmission"] / 10,2) .. "/10.0" .. " <br> Electronics (Plastic) - " .. round(degHealth["electronics"] / 10,2) .. "/10.0" .. " <br> Injector (Copper) - " .. round(degHealth["fuel_injector"] / 10,2) .. "/10.0" .. " <br> Fuel (Steel) - " .. round(degHealth["fuel_tank"] / 10,2) .. "/10.0" .. " <br> Body (Glass) - " .. round((bodyHealth / 10) / 10,2) .. "/10.0" .. " <br> Engine (Scrap) - " .. round((engineHealth / 10) / 10,2) .. "/10.0</div>",
                args = {}
            })
        end)
	end
end)

RegisterNetEvent('rl-tow:client:setEngineHealth')
AddEventHandler('rl-tow:client:setEngineHealth', function(health)
    if targetVehicle and targetVehicle ~= 0 then
        SetVehicleEngineHealth(targetVehicle, health + 0.0)
    end
end)

RegisterNetEvent('rl-tow:client:setBodyHealth')
AddEventHandler('rl-tow:client:setBodyHealth', function(health)
    if targetVehicle and targetVehicle ~= 0 then
        SetVehicleBodyHealth(targetVehicle, health + 0.0)
    end
end)

RegisterNetEvent('rl-tow:client:TriggerRepairs')
AddEventHandler('rl-tow:client:TriggerRepairs', function(degname,amount)

	local itemname = "Metalscrap"
	local notfucked = false
	local current = 100

	if degname == "body" or degname == "Body" then
		itemname = "Glass"
		degname = "body"
		notfucked = true
		current = bodyHealth
	end

	if degname == "Engine" or degname == "engine" then
		degname = "engine"
		notfucked = true
		current = engineHealth
	end

	if degname == "brakes" or degname == "Brakes" then
		itemname = "Rubber"
		degname = "breaks"
		notfucked = true
		current = degHealth["breaks"]
	end

	if degname == "Axle" or degname == "axle" then
		degname = "axle"
		notfucked = true
		current = degHealth["axle"]
	end

	if degname == "Radiator" or degname == "radiator" then
		degname = "radiator"
		notfucked = true
		current = degHealth["radiator"]
	end

	if degname == "Clutch" or degname == "clutch" then
		degname = "clutch"
		notfucked = true
		current = degHealth["clutch"]
	end

	if degname == "electronics" or degname == "Electronics" then
		degname = "electronics"
		itemname = "Plastic"
		notfucked = true
		current = degHealth["electronics"]
	end

	if degname == "fuel" or degname == "Fuel" then
		itemname = "Steel"
		degname = "fuel_tank"
		notfucked = true
		current = degHealth["fuel_tank"]
	end

	if degname == "transmission" or degname == "Transmission" then
		itemname = "Aluminum"
		degname = "transmission"
		notfucked = true
		current = degHealth["transmission"]
	end

	if degname == "Injector" or degname == "injector" then
		itemname = "Copper"
		degname = "fuel_injector"
		notfucked = true
		current = degHealth["fuel_injector"]
	end
    
	if not notfucked then
        TriggerEvent('chat:addMessage', {
            template = "<div class='chat-message server'>SYSTEM: That part does not exist?</div>",
            args = {}
        })
	else
        local playerped = PlayerPedId()
        local coordA = GetEntityCoords(playerped, 1)
        local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
        targetVehicle = getVehicleInDirection(coordA, coordB)
    
        if targetVehicle ~= nil  and targetVehicle ~= 0 and RequestVehicle(targetVehicle) then
            SetVehicleDoorOpen(targetVehicle, 4, 0, 0)

            RequestAnimDict("mp_car_bomb")
            while not HasAnimDictLoaded("mp_car_bomb") do
                Citizen.Wait(0)
            end

            TaskPlayAnim(playerped,"mp_car_bomb","car_bomb_mechanic",8.0, -8, -1, 49, 0, 0, 0, 0)

            RLCore.Functions.Progressbar("repairing", "Repairing", 15000, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                ClearPedTasks(playerped)
                SetVehicleDoorShut(targetVehicle, 4, 1, 1)

                if degname == 'body' then
                    current = GetVehicleBodyHealth(targetVehicle)
                elseif degname == 'engine' then
                    current = GetVehicleEngineHealth(targetVehicle)
                end

                TriggerServerEvent('rl-tow:server:fixVehicle',GetVehicleNumberPlateText(targetVehicle),degname,amount,itemname, current)
            end)
        end
		
	end
	
end)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function RequestVehicle(targetVehicle)
    local timeout = 20

    while not NetworkHasControlOfEntity(targetVehicle) and timeout > 0 do 
        NetworkRequestControlOfEntity(targetVehicle)
        Citizen.Wait(100)
        timeout = timeout -1
    end

    return NetworkHasControlOfEntity(targetVehicle)
end

local trackedVehicles = {}
local changingVar = {}

Citizen.CreateThread(function()
	Citizen.Wait(4000)

	local tick = 0
	local rTick = 0
	local vehicleNewBodyHealth = 0
	local vehicleNewEngineHealth = 0
    local exitveh = true
    local enteredveh = false
	local lastvehicle = 0
	while true do
		Citizen.Wait(1000)
		local playerPed = PlayerPedId()
		local currentVehicle = GetVehiclePedIsIn(playerPed)
		if IsPedInVehicle(PlayerPedId(),currentVehicle,false) then

			tick = tick + 1
			rTick = rTick + 1

			local driverPed = GetPedInVehicleSeat(currentVehicle, -1)
			if playerPed == driverPed then
				local plate = GetVehicleNumberPlateText(currentVehicle)
				local engineHealth = math.ceil(GetVehicleEngineHealth(currentVehicle))
				local bodyHealth = math.ceil(GetVehicleBodyHealth(currentVehicle))
				trackedVehicles[currentVehicle] = {plate, engineHealth, bodyHealth}
            end
            
            if not enteredveh then
				currentVehicle = GetVehiclePedIsIn(playerPed, false)
				local plate = GetVehicleNumberPlateText(currentVehicle)
                if currentVehicle then 
                    TriggerServerEvent('rl-tow:callDegredation', plate) 
                end
                
				enteredveh = true
				exitveh = false
				tick = 13
				rTick = 55
                --print("Entered new veh triggered")
                Wait(600)
			end

			if tick >= 15 then
				TriggerEvent('rl-tow:getVehicleDegredation',currentVehicle,tick)
				trackVehicleHealth()
				tick = 0
			end

			if rTick >= 60 then
				TriggerEvent('rl-tow:randomDegredation',1,currentVehicle,3)
				rTick = 0
            end
        else
            if not exitveh then	
				--print("exited vehicle and updated.")
				tick = 0
				rTick = 0
				lastvehicle = 0
				currentVehicle = 0
                exitveh = true
                enteredveh = false
			end
		end

	end

end)

RegisterNetEvent('rl-tow:getSQL')
AddEventHandler('rl-tow:getSQL', function(degredation)
    changingVar = degredation
    --print("changingVar: " .. json.encode(changingVar))
end)

RegisterNetEvent('rl-tow:randomDegredation')
AddEventHandler('rl-tow:randomDegredation', function(upperLimit,vehicle,spinAmount)
	degHealth = getDegredationArray()
	local plate = GetVehicleNumberPlateText(vehicle)

	if vehicle ~= nil and vehicle ~= 0 then
		local br = degHealth.breaks
		local ax = degHealth.axle
		local rad = degHealth.radiator
		local cl = degHealth.clutch
		local tra = degHealth.transmission
		local elec = degHealth.electronics
		local fi = degHealth.fuel_injector 
        local ft = degHealth.fuel_tank
        
		for i=1,spinAmount do
			local chance =  math.random(0,150)
			if chance <= 10 and chance >= 0 then
				br = br - math.random(0,upperLimit)
			elseif chance <= 20 and chance >= 11 then
				ax = ax - math.random(0,upperLimit)
			elseif chance <= 30 and chance >= 21 then
				rad = rad - math.random(0,upperLimit)
			elseif chance <= 40 and chance >= 31 then
				cl = cl - math.random(0,upperLimit)
			elseif chance <= 50 and chance >= 41 then
				tra = tra - math.random(0,upperLimit)
			elseif chance <= 60 and chance >= 51 then
				elec = elec - math.random(0,upperLimit)
			elseif chance <= 70 and chance >= 61 then
				fi = fi - math.random(0,upperLimit)
			elseif chance <= 80 and chance >= 71 then
				ft = ft - math.random(0,upperLimit)
			end
		end

        if br < 0 then
            br = 0 
        end

        if ax < 0 then
            ax = 0 
        end
            
        if rad < 0 then 
            rad = 0 
        end

        if cl < 0 then 
            cl = 0 
        end
            
        if tra < 0 then 
            tra = 0 
        end
            
        if elec < 0 then
            elec = 0 
        end
            
        if fi < 0 then
            fi = 0 
        end
            
        if ft < 0 then
            ft = 0 
        end

		--print("Random degen done: " .. br..","..ax..","..rad..","..cl..","..tra..","..elec..","..fi..","..ft)
        TriggerServerEvent('rl-tow:updateVehicleDegredationServer',plate,br,ax,rad,cl,tra,elec,fi,ft)
	end
end)

function getDegredationArray()
    local degHealth = Config.MaxStatusValues

    if changingVar["breaks"] then
        degHealth["breaks"] = changingVar["breaks"]
    end

    if changingVar["axle"] then
        degHealth["axle"] = changingVar["axle"]
    end

    if changingVar["radiator"] then
        degHealth["radiator"] = changingVar["radiator"]
    end

    if changingVar["clutch"] then
        degHealth["clutch"] = changingVar["clutch"]
    end

    if changingVar["transmission"] then
        degHealth["transmission"] = changingVar["transmission"]
    end

    if changingVar["electronics"] then
        degHealth["electronics"] = changingVar["electronics"]
    end

    if changingVar["fuel_injector"] then
        degHealth["fuel_injector"] = changingVar["fuel_injector"]
    end

    if changingVar["fuel_tank"] then
        degHealth["fuel_tank"] = changingVar["fuel_tank"]
    end

    return degHealth
end

function string:split(delimiter)
    local result = {}
    local from  = 1
    local delim_from, delim_to = string.find( self, delimiter, from  )
    while delim_from do
      table.insert( result, string.sub( self, from , delim_from-1 ) )
      from  = delim_to + 1
      delim_from, delim_to = string.find( self, delimiter, from  )
    end
    table.insert( result, string.sub( self, from  ) )
    return result
end

RegisterNetEvent('rl-tow:getVehicleDegredation')
AddEventHandler('rl-tow:getVehicleDegredation', function(currentVehicle,tick)
		degHealth = getDegredationArray()
		if IsPedInVehicle(PlayerPedId(),currentVehicle,false) then
			if true then
				if GetVehicleClass(currentVehicle) ~= 13 and GetVehicleClass(currentVehicle) ~= 21 and GetVehicleClass(currentVehicle) ~= 16 and GetVehicleClass(currentVehicle) ~= 15 and GetVehicleClass(currentVehicle) ~= 14 then
					if degHealth.fuel_injector <= 45 then
						--print("fuel injector "..degHealth.fuel_injector)
						local decayChance = math.random(10,100)
						if degHealth.fuel_injector <= 45 and degHealth.fuel_injector >= 25 then	
							if decayChance > 99 then
								fuelInjector(currentVehicle,50)
							end
						elseif degHealth.fuel_injector <= 24 and degHealth.fuel_injector >= 15 then	
							if decayChance > 98 then
								fuelInjector(currentVehicle,400)

							end
						elseif degHealth.fuel_injector <= 14 and degHealth.fuel_injector >= 9 then	
							if decayChance > 97 then
								fuelInjector(currentVehicle,600)

							end
						elseif  degHealth.fuel_injector <= 8 and degHealth.fuel_injector >= 0 then	
							if decayChance > 90 then
								fuelInjector(currentVehicle,1000)

							end
						end
					end

					if degHealth.radiator <= 35 and tick >= 15 then
						--print("rad "..degHealth.radiator)
						local engineHealth = GetVehicleEngineHealth(currentVehicle)
						if degHealth.radiator <= 35 and degHealth.radiator >= 20 then
							if engineHealth <= 1000 and engineHealth >= 700 then
								SetVehicleEngineHealth(currentVehicle, engineHealth-10)
							end
						elseif degHealth.radiator <= 19 and degHealth.radiator >= 10 then
							if engineHealth <= 1000 and engineHealth >= 500 then
								SetVehicleEngineHealth(currentVehicle, engineHealth-20)
							end
						elseif degHealth.radiator <= 9 and degHealth.radiator >= 0 then
							if engineHealth <= 1000 and engineHealth >= 200 then
								SetVehicleEngineHealth(currentVehicle, engineHealth-30)
							end
						end
					end

					if degHealth.axle <= 35 and tick >= 15 then
						--print("axle "..degHealth.axle)
						local Chance = math.random(1,100)
						if degHealth.axle <= 35 and degHealth.axle >= 20 and Chance > 90 then
							for i=0,360 do					
								SetVehicleSteeringScale(currentVehicle,i)
								Citizen.Wait(5)
							end
						elseif degHealth.axle <= 19 and degHealth.axle >= 10 and Chance > 70 then
							for i=0,360 do	
								Citizen.Wait(10)
								SetVehicleSteeringScale(currentVehicle,i)
							end
						elseif degHealth.axle <= 9 and degHealth.axle >= 0 and Chance > 50 then
							for i=0,360 do
								Citizen.Wait(15)
								SetVehicleSteeringScale(currentVehicle,i)
							end
						end
					end

					if degHealth.transmission <= 35 and tick >= 15 then
						--print("Trans "..degHealth.transmission)
						local speed = GetEntitySpeed(currentVehicle)
						local Chance = math.random(1,100)
						if degHealth.transmission <= 35 and degHealth.transmission >= 20 and Chance > 90 then
							for i=0,3 do
								if not IsPedInVehicle(PlayerPedId(),currentVehicle,false) then
									return
								end
								Citizen.Wait(5)
								SetVehicleHandbrake(currentVehicle,true)
								Citizen.Wait(math.random(1000))
								SetVehicleHandbrake(currentVehicle,false)
							end
						elseif degHealth.transmission <= 19 and degHealth.transmission >= 10 and Chance > 70 then
							for i=0,5 do
								if not IsPedInVehicle(PlayerPedId(),currentVehicle,false) then
									return
								end							
								Citizen.Wait(10)
								SetVehicleHandbrake(currentVehicle,true)
								Citizen.Wait(math.random(1000))
								SetVehicleHandbrake(currentVehicle,false)
							end
						elseif degHealth.transmission <= 9 and degHealth.transmission >= 0 and Chance > 50 then
							for i=0,11 do
								if not IsPedInVehicle(PlayerPedId(),currentVehicle,false) then
									return
								end							
								Citizen.Wait(20)
								SetVehicleHandbrake(currentVehicle,true)
								Citizen.Wait(math.random(1000))
								SetVehicleHandbrake(currentVehicle,false)
							end
						end
					end

					if degHealth.electronics <= 35 and tick >= 15 then
						--print("elec "..degHealth.electronics)
						local Chance = math.random(1,100)
						if degHealth.electronics <= 35 and degHealth.electronics >= 20 and Chance > 90 then
							for i=0,10 do
								Citizen.Wait(50)
								electronics(currentVehicle)
							end
						elseif degHealth.electronics <= 19 and degHealth.electronics >= 10 and Chance > 70 then
							for i=0,10 do
								Citizen.Wait(100)
								electronics(currentVehicle)
							end
						elseif degHealth.electronics <= 9 and degHealth.electronics >= 0 and Chance > 50 then
							for i=0,10 do
								Citizen.Wait(200)
								electronics(currentVehicle)
							end
						end
					end

					if degHealth.breaks <= 35 and tick >= 15 then
					    --print("breaks "..degHealth.breaks)
						local Chance = math.random(1,100)
						if degHealth.breaks <= 35 and degHealth.breaks >= 20 and Chance > 90 then
								SetVehicleHandbrake(currentVehicle,true)
								Citizen.Wait(1000)
								SetVehicleHandbrake(currentVehicle,false)
						elseif degHealth.breaks <= 19 and degHealth.breaks >= 10 and Chance > 70 then
								SetVehicleHandbrake(currentVehicle,true)
								Citizen.Wait(4500)
								SetVehicleHandbrake(currentVehicle,false)
						elseif degHealth.breaks <= 9 and degHealth.breaks >= 0 and Chance > 50 then
								SetVehicleHandbrake(currentVehicle,true)
								Citizen.Wait(7000)
								SetVehicleHandbrake(currentVehicle,false)
						end
					else
						SetVehicleHandbrake(currentVehicle,false)
					end

					if degHealth.clutch <= 35 and tick >= 15 then
						--print("Clutch "..degHealth.clutch)
						local Chance = math.random(1,100)
						if degHealth.clutch <= 35 and degHealth.clutch >= 20 and Chance > 90 then
								SetVehicleHandbrake(currentVehicle,true)
								fuelInjector(currentVehicle,50)
								for i=1,360 do
									SetVehicleSteeringScale(currentVehicle,i)
									Citizen.Wait(5)
								end
								Citizen.Wait(2000)
								SetVehicleHandbrake(currentVehicle,false)
						elseif degHealth.clutch <= 19 and degHealth.clutch >= 10 and Chance > 70 then
								SetVehicleHandbrake(currentVehicle,true)
								fuelInjector(currentVehicle,100)
								for i=1,360 do
									SetVehicleSteeringScale(currentVehicle,i)
									Citizen.Wait(5)
								end
								Citizen.Wait(5000)
								SetVehicleHandbrake(currentVehicle,false)
						elseif degHealth.clutch <= 9 and degHealth.clutch >= 0 and Chance > 50 then
								SetVehicleHandbrake(currentVehicle,true)
								fuelInjector(currentVehicle,200)
								for i=1,360 do
									SetVehicleSteeringScale(currentVehicle,i)
									Citizen.Wait(5)
								end
								Citizen.Wait(7000)
								SetVehicleHandbrake(currentVehicle,false)
						end
					end

					if degHealth.fuel_tank <= 35 and tick >= 15 then
					    --print("fuel tank "..degHealth.fuel_tank)
						if degHealth.clutch <= 35 and degHealth.clutch >= 20 then
							TriggerEvent("carHud:FuelMulti",20)
						elseif degHealth.clutch <= 19 and degHealth.clutch >= 10 then
							TriggerEvent("carHud:FuelMulti",10)
						elseif degHealth.clutch <= 9 and degHealth.clutch >= 0 then
							TriggerEvent("carHud:FuelMulti",20)
						end
					else
						TriggerEvent("carHud:FuelMulti",1)
					end	
				end			
			end
		end
end)

function fuelInjector(currentVehicle,wait)
	SetVehicleEngineOn(currentVehicle,0,0,1)
	SetVehicleUndriveable(currentVehicle,true)
	Citizen.Wait(wait)
	SetVehicleEngineOn(currentVehicle,1,0,1)
	SetVehicleUndriveable(currentVehicle,false)
end

function electronics(currentVehicle)
	local radioStations = {"RADIO_01_CLASS_ROCK","RADIO_02_POP","RADIO_03_HIPHOP_NEW","RADIO_04_PUNK","RADIO_05_TALK_01","RADIO_06_COUNTRY","RADIO_07_DANCE_01","RADIO_08_MEXICAN","RADIO_09_HIPHOP_OLD",
	"RADIO_12_REGGAE","RADIO_13_JAZZ","RADIO_14_DANCE_02","RADIO_15_MOTOWN","RADIO_20_THELAB","RADIO_16_SILVERLAKE","RADIO_17_FUNK","RADIO_18_90S_ROCK"}
	SetVehicleLights(currentVehicle,1)
	local radioRand = math.random(1,18)
	SetVehRadioStation(currentVehicle,radioStations[radioRand])
	Citizen.Wait(600)
	SetVehicleLights(currentVehicle,0)
end

function trackVehicleHealth()
	local tempReturn = {}
	for k, v in pairs(trackedVehicles) do
		if not IsEntityDead(k) then
			v[2] = math.ceil(GetVehicleEngineHealth(k))
			v[3] = math.ceil(GetVehicleBodyHealth(k))
			v[4] = DecorGetInt(k, "CurrentFuel")
			if v[4] == nil then
				v[4] = 50
			end
			tempReturn[#tempReturn+1] = v
		else
			trackedVehicles[k] = nil
		end
	end
	if #tempReturn > 0 then
		TriggerServerEvent('rl-tow:updateVehicleHealth', tempReturn)
	end
end

RegisterNetEvent('rl-tow:getDegredation')
AddEventHandler('rl-tow:getDegredation', function(veh,cb)

	local plate = GetVehicleNumberPlateText(veh)
	TriggerServerEvent('rl-tow:callDegredation', plate)

	Citizen.Wait(200)
	deghealth = getDegredationArray()
	cb(deghealth)
end)
