local RLCore = nil

Citizen.CreateThread(function()
    while RLCore == nil do
        TriggerEvent("RLCore:GetObject", function(obj)
            RLCore = obj 
        end)
        Citizen.Wait(200)
    end
end)

local OutsideVehicles = {}
local CurrentDisplayVehicle = nil
local ParkingSpot = nil
local state = false

function createBlips(job)
    for k, v in pairs(Depots) do
        if v.showBlip then
            local Depot = AddBlipForCoord(Depots[k].Blip.x, Depots[k].Blip.y, Depots[k].Blip.z)
            SetBlipSprite (Depot, 68)
            SetBlipDisplay(Depot, 4)
            SetBlipScale  (Depot, 0.7)
            SetBlipAsShortRange(Depot, true)
            SetBlipColour(Depot, 5)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Depots[k].label)
            EndTextCommandSetBlipName(Depot)
        end
    end
    for k, v in pairs(JobGarages) do
        if v.showBlip then
            if job == v.job then
                if v.isHelipad then
                    local Helipad = AddBlipForCoord(JobGarages[k].Blip.x, JobGarages[k].Blip.y, JobGarages[k].Blip.z)
                    SetBlipSprite (Helipad, 43)
                    SetBlipDisplay(Helipad, 4)
                    SetBlipScale  (Helipad, 0.6)
                    SetBlipAsShortRange(Helipad, true)
                    SetBlipColour(Helipad, 38)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentSubstringPlayerName(JobGarages[k].label)
                    EndTextCommandSetBlipName(Helipad)
                else
                    local Garage = AddBlipForCoord(JobGarages[k].Blip.x, JobGarages[k].Blip.y, JobGarages[k].Blip.z)
                    SetBlipSprite (Garage, 357)
                    SetBlipDisplay(Garage, 4)
                    SetBlipScale  (Garage, 0.6)
                    SetBlipAsShortRange(Garage, true)
                    SetBlipColour(Garage, 38)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentSubstringPlayerName(JobGarages[k].label)
                    EndTextCommandSetBlipName(Garage)
                end
            end
        end
    end
    if Var.BlipsonStartup then
        ToggleGarageBlips()
    end
end

function ToggleGarageBlips()
    state = not state
    for k, v in pairs(Garages) do
        if v.showBlip ~= nil then
            if v.showBlip then
                if state then
                    v.blip = AddBlipForCoord(Garages[k].Blip.x, Garages[k].Blip.y, Garages[k].Blip.z)
                    SetBlipSprite (v.blip, 357)
                    SetBlipDisplay(v.blip, 4)
                    SetBlipScale  (v.blip, 0.65)
                    SetBlipAsShortRange(v.blip, true)
                    SetBlipColour(v.blip, 3)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentSubstringPlayerName(Garages[k].label)
                    EndTextCommandSetBlipName(v.blip)
                else
                    RemoveBlip(v.blip)
                end
            end
        end
    end
end

function GetCurrentGarage()
    local ply = PlayerPedId()
    local plypos = GetEntityCoords(ply)
    for k, v in pairs(Garages) do
        local takeDist = #(plypos - vector3(Garages[k].polyzone.x, Garages[k].polyzone.y, Garages[k].polyzone.z))
        if takeDist <= 25 then
            if k == "sapcounsel2" then
                k = "sapcounsel"
            elseif k == "sapcounsel3" then
                k = "sapcounsel"
            elseif k == "caears24b2" then
                k = "caears24b"
            elseif k == "haanparking2" then
                k = "haanparking"
            elseif k == "haanparking3" then
                k = "haanparking"
            end
            return k
        end
    end
end

function GetGangGarage()
    local ply = PlayerPedId()
    local plypos = GetEntityCoords(ply)
    for k, v in pairs(GangGarages) do
        local takeDist = #(plypos - vector3(GangGarages[k].polyzone.x, GangGarages[k].polyzone.y, GangGarages[k].polyzone.z))
        if takeDist <= 20 then
            return k
        end
    end
end

function GetHouseGarage()
    local ply = PlayerPedId()
    local plypos = GetEntityCoords(ply)
    for k, v in pairs(HouseGarages) do
        if HouseGarages[k].takeVehicle.x ~= nil and HouseGarages[k].takeVehicle.y ~= nil and HouseGarages[k].takeVehicle.z ~= nil then
            local takeDist = #(plypos - vector3(HouseGarages[k].takeVehicle.x, HouseGarages[k].takeVehicle.y, HouseGarages[k].takeVehicle.z))
            if takeDist <= 10 then
                return k
            end
        end
    end
end

function GetJobGarage()
    local ply = PlayerPedId()
    local plypos = GetEntityCoords(ply)
    for k, v in pairs(JobGarages) do
        local takeDist = #(plypos - vector3(JobGarages[k].polyzone.x, JobGarages[k].polyzone.y, JobGarages[k].polyzone.z))
        if takeDist <= 15 then
            if k == "mrpd2" then
                k = "mrpd"
            elseif k == "pillboxmd2" then
                k = "pillboxmd"
            end
            return k
        end
    end
end

function GetCurrentDepot()
    local ply = PlayerPedId()
    local plypos = GetEntityCoords(ply)
    for k, v in pairs(Depots) do
        local takeDist = #(plypos - vector3(Depots[k].polyzone.x, Depots[k].polyzone.y, Depots[k].polyzone.z))
        if takeDist <= 10 then
            return k
        end
    end
end

function getVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle
	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		offset = offset - 1
		if vehicle ~= 0 then break end
	end
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end

function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function DeleteViewedCar()
    if DoesEntityExist(CurrentDisplayVehicle) then
		SetEntityAsMissionEntity(CurrentDisplayVehicle, true, true)
		DeleteVehicle(CurrentDisplayVehicle)
		DeleteEntity(CurrentDisplayVehicle)
		CurrentDisplayVehicle = nil
	end
end

function GetpSpot(pGarage)
    local pSpot = nil
    local selectedGarage = nil
    if Garages[pGarage] ~= nil then
        selectedGarage = Garages[pGarage]
    elseif GangGarages[pGarage] ~= nil then
        selectedGarage = GangGarages[pGarage]
    elseif JobGarages[pGarage] ~= nil then
        selectedGarage = JobGarages[pGarage]
    end
    for i=1, #selectedGarage.spawns do
        local RunSpawnCheck = false
        local distance = #(vector3(selectedGarage.spawns[i].x, selectedGarage.spawns[i].y, selectedGarage.spawns[i].z) - GetEntityCoords(PlayerPedId()))
        if distance < 1.6 then
            RunSpawnCheck = true
        elseif distance < 1.8 and not RunSpawnCheck then
            RunSpawnCheck = true
        elseif distance < 2.0 and not RunSpawnCheck then
            RunSpawnCheck = true
        elseif distance < 2.4 and not RunSpawnCheck then
            RunSpawnCheck = true
        elseif distance < 3.0 and not RunSpawnCheck then
            RunSpawnCheck = true
        elseif distance < 3.5 and not RunSpawnCheck then
        end

        if RunSpawnCheck then
            local vehicle = GetClosestVehicle(selectedGarage.spawns[i].x, selectedGarage.spawns[i].y, selectedGarage.spawns[i].z, 2.0, 0, 127)
            if not DoesEntityExist(vehicle) then
                pSpot = vector4(selectedGarage.spawns[i].x, selectedGarage.spawns[i].y, selectedGarage.spawns[i].z, selectedGarage.spawns[i].h)
                break
            end
        end
    end
    return pSpot
end

function GetdSpot(pDepot)
    local pSpot = nil
    local spawnamount = {}
    for i=1, #Depots[pDepot].spawns do
        table.insert(spawnamount, i)
    end
    repeat
        local p = math.random(1, #spawnamount)
        local n = spawnamount[p]
        local vehicle = GetClosestVehicle(Depots[pDepot].spawns[n].x, Depots[pDepot].spawns[n].y, Depots[pDepot].spawns[n].z, 2.0, 0, 127)
        if not DoesEntityExist(vehicle) then
            pSpot = vector4(Depots[pDepot].spawns[n].x, Depots[pDepot].spawns[n].y, Depots[pDepot].spawns[n].z, Depots[pDepot].spawns[n].h)
            break
        else
            table.remove(spawnamount, p)
        end
    until(#spawnamount == 0)
    return pSpot
end

function SpawnVehicle(vehicle, pGarage, Fuel, body, engine, plate, gType, IsViewing, IsShared)
    if not IsViewing then
        DeleteViewedCar()
    end

    if gType == 0 then
        ParkingSpot = GetpSpot(pGarage)
    elseif gType == 1 then
        local ped = PlayerPedId()
        local heading = GetEntityHeading(ped)
        local forward = GetEntityForwardVector(ped)
        local coords = GetEntityCoords(ped)
        local x, y, z = table.unpack(coords + forward)
        ParkingSpot = vector4(x, y, z, heading+85)
    elseif gType == 2 then
        ParkingSpot = JobGarages[pGarage].helipad
    end

    Citizen.Wait(math.random(100, 200))
    
    if  ParkingSpot ~= nil then
        if not IsViewing then
            local model = GetHashKey(vehicle)
            if not IsModelInCdimage(model) then return end
            RequestModel(model)
            while not HasModelLoaded(model) do Citizen.Wait(10) end
            local veh = CreateVehicle(model, ParkingSpot.x, ParkingSpot.y, ParkingSpot.z, ParkingSpot.w, true, false)
            local netid = NetworkGetNetworkIdFromEntity(veh)
            SetVehicleHasBeenOwnedByPlayer(veh, true)
            SetNetworkIdCanMigrate(netid, true)
            SetVehicleNeedsToBeHotwired(veh, false)
            SetVehRadioStation(veh, 'OFF')
            SetModelAsNoLongerNeeded(model)
            ParkingSpot = nil
            CurrentDisplayVehicle = veh
            RLCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                RLCore.Functions.SetVehicleProperties(veh, properties)
                SetVehicleNumberPlateText(veh, plate)
                exports['lj-fuel']:SetFuel(veh, Fuel)
                doCarDamage(veh, body, engine)
                SetEntityAsMissionEntity(veh, true, true)
                SetVehicleEngineOn(veh, false, false)
                SetVehicleProperties(veh, properties)
            end, plate, IsShared)
        else
            if IsShared then
                TriggerServerEvent('qb-garage:server:updateSharedVehState', 'Out', plate, pGarage)
            else
                TriggerServerEvent('qb-garage:server:updateVehicleState', 0, plate, pGarage)
                if plate ~= nil then
                    OutsideVehicles[plate] = CurrentDisplayVehicle
                    TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                end
            end
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(CurrentDisplayVehicle))
            ParkingSpot = nil
            CurrentDisplayVehicle = nil
        end
    else
        RLCore.Functions.Notify('Need some Space. Move a bit further!', 'error')
    end
end

function SpawnDepotVehicle(Data)
    local enginePercent = round(Data.engine / 10, 0)
    local bodyPercent = round(Data.body / 10, 0)
    local currentFuel = Data.fuel
    local model = GetHashKey(Data.vehicle)
    local spawnpoint = GetdSpot(GetCurrentDepot())
    if OutsideVehicles ~= nil and next(OutsideVehicles) ~= nil then
        if OutsideVehicles[Data.plate] ~= nil then
            local VehExists = DoesEntityExist(OutsideVehicles[Data.plate])
            if VehExists then
                if Var.DepotGetDestroyedVeh then
                    local Engine = GetVehicleEngineHealth(OutsideVehicles[Data.plate])
                    if Engine < 40 then
                        if spawnpoint ~= nil then
                            RLCore.Functions.TriggerCallback('qb-garage:server:PayDepotPrice', function(paid)
                                if paid then
                                    if not IsModelInCdimage(model) then return end
                                    RequestModel(model)
                                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                                    local veh = CreateVehicle(model, spawnpoint.x, spawnpoint.y, spawnpoint.z, spawnpoint.w, true, false)
                                    local netid = NetworkGetNetworkIdFromEntity(veh)
                                    SetVehicleHasBeenOwnedByPlayer(veh, true)
                                    SetNetworkIdCanMigrate(netid, true)
                                    SetVehicleNeedsToBeHotwired(veh, false)
                                    SetVehRadioStation(veh, 'OFF')
                                    SetModelAsNoLongerNeeded(model)

                                    if Data.plate ~= nil then
                                        local vehicleProps = GetVehicleProperties(OutsideVehicles)
                                        DeleteVehicle(OutsideVehicles[Data.plate])
                                        OutsideVehicles[Data.plate] = veh
                                        TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                                        TriggerServerEvent('crpmofify:modifystate', vehicleProps) 
                                    end
                                    RLCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                                        RLCore.Functions.SetVehicleProperties(veh, properties)
                                        SetVehicleNumberPlateText(veh, Data.plate)
                                        exports['lj-fuel']:SetFuel(veh, Data.fuel)
                                        doCarDamage(veh, Data.body, Data.engine)
                                        SetEntityAsMissionEntity(veh, true, true)
                                        TriggerServerEvent('qb-garage:server:updateVehicleState', 0, Data.plate, Data.garage)
                                        RLCore.Functions.Notify("Vehicle OFF: Engine " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                                        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                                        SetVehicleEngineOn(veh, false, false)
                                        SetVehicleProperties(veh, properties)
                                    end, Data.plate)
                                end
                             end, Data.plate, Data.fine)
                        else
                            RLCore.Functions.Notify('Unable to find free space!', 'error')
                        end
                    else
                        RLCore.Functions.Notify('You can not claim undestroyed vehicles.', 'error', 1000)
                        AddTemporaryBlip(OutsideVehicles[Data.plate])
                    end
                else
                    RLCore.Functions.Notify('You can not claim undestroyed vehicles.', 'error', 1000)
                    AddTemporaryBlip(OutsideVehicles[Data.plate])
                end
            else
                if spawnpoint ~= nil then
                    RLCore.Functions.TriggerCallback('qb-garage:server:PayDepotPrice', function(paid)
                        if paid then
                            if not IsModelInCdimage(model) then return end
                            RequestModel(model)
                            while not HasModelLoaded(model) do Citizen.Wait(10) end
                            local veh = CreateVehicle(model, spawnpoint.x, spawnpoint.y, spawnpoint.z, spawnpoint.w, true, false)
                            local netid = NetworkGetNetworkIdFromEntity(veh)
                            SetVehicleHasBeenOwnedByPlayer(veh, true)
                            SetNetworkIdCanMigrate(netid, true)
                            SetVehicleNeedsToBeHotwired(veh, false)
                            SetVehRadioStation(veh, 'OFF')
                            SetModelAsNoLongerNeeded(model)

                            if Data.plate ~= nil then
                                DeleteVehicle(OutsideVehicles[Data.plate])
                                OutsideVehicles[Data.plate] = veh
                                TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                            end
                            RLCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                                RLCore.Functions.SetVehicleProperties(veh, properties)
                                SetVehicleNumberPlateText(veh, Data.plate)
                                exports['lj-fuel']:SetFuel(veh, Data.fuel)
                                doCarDamage(veh, Data.body, Data.engine)
                                SetEntityAsMissionEntity(veh, true, true)
                                TriggerServerEvent('qb-garage:server:updateVehicleState', 0, Data.plate, Data.garage)
                                RLCore.Functions.Notify("Vehicle OFF: Engine " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                                SetVehicleEngineOn(veh, false, false)
                                SetVehicleProperties(veh, properties)
                            end, Data.plate)
                        end
                    end, Data.plate, Data.fine)
                else
                    RLCore.Functions.Notify('Unable to find free space!', 'error')
                end
            end
        else
            if spawnpoint ~= nil then
                RLCore.Functions.TriggerCallback('qb-garage:server:PayDepotPrice', function(paid)
                    if paid then
                        if not IsModelInCdimage(model) then return end
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local veh = CreateVehicle(model, spawnpoint.x, spawnpoint.y, spawnpoint.z, spawnpoint.w, true, false)
                        local netid = NetworkGetNetworkIdFromEntity(veh)
                        SetVehicleHasBeenOwnedByPlayer(veh, true)
                        SetNetworkIdCanMigrate(netid, true)
                        SetVehicleNeedsToBeHotwired(veh, false)
                        SetVehRadioStation(veh, 'OFF')
                        SetModelAsNoLongerNeeded(model)

                        if Data.plate ~= nil then
                            DeleteVehicle(OutsideVehicles[Data.plate])
                            OutsideVehicles[Data.plate] = veh
                            TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                        end
                        RLCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                            RLCore.Functions.SetVehicleProperties(veh, properties)
                            SetVehicleNumberPlateText(veh, Data.plate)
                            exports['lj-fuel']:SetFuel(veh, Data.fuel)
                            doCarDamage(veh, Data.body, Data.engine)
                            SetEntityAsMissionEntity(veh, true, true)
                            TriggerServerEvent('qb-garage:server:updateVehicleState', 0, Data.plate, Data.garage)
                            RLCore.Functions.Notify("Vehicle OFF: Engine " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                            SetVehicleEngineOn(veh, false, false)
                            SetVehicleProperties(veh, properties)
                        end, Data.plate)
                    end
                end, Data.plate, Data.fine)
            else
                RLCore.Functions.Notify('Unable to find free space!', 'error')
            end
        end
    else
        if spawnpoint ~= nil then
            RLCore.Functions.TriggerCallback('qb-garage:server:PayDepotPrice', function(paid)
                if paid then
                    if not IsModelInCdimage(model) then return end
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local veh = CreateVehicle(model, spawnpoint.x, spawnpoint.y, spawnpoint.z, spawnpoint.w, true, false)
                    local netid = NetworkGetNetworkIdFromEntity(veh)
                    SetVehicleHasBeenOwnedByPlayer(veh, true)
                    SetNetworkIdCanMigrate(netid, true)
                    SetVehicleNeedsToBeHotwired(veh, false)
                    SetVehRadioStation(veh, 'OFF')
                    SetModelAsNoLongerNeeded(model)

                    if Data.plate ~= nil then
                        DeleteVehicle(OutsideVehicles[Data.plate])
                        OutsideVehicles[Data.plate] = veh
                        TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                    end
                    RLCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                        RLCore.Functions.SetVehicleProperties(veh, properties)
                        SetVehicleNumberPlateText(veh, Data.plate)
                        exports['lj-fuel']:SetFuel(veh, Data.fuel)
                        doCarDamage(veh, Data.body, Data.engine)
                        SetEntityAsMissionEntity(veh, true, true)
                        TriggerServerEvent('qb-garage:server:updateVehicleState', 0, Data.plate, Data.garage)
                        RLCore.Functions.Notify("Vehicle OFF: Engine " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                        SetVehicleEngineOn(veh, false, false)
                        SetVehicleProperties(veh, properties)
                    end, Data.plate)
                end
            end, Data.plate, Data.fine)
        else
            RLCore.Functions.Notify('Unable to find free space!', 'error')
        end
    end
end

function RemoveOutsideVeh(plate)
    if plate ~= nil then
        OutsideVehicles[plate] = nil
        TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
    end
end

function AddTemporaryBlip(vehicle)  
    local VehicleCoords = GetEntityCoords(vehicle)
    local TempBlip = AddBlipForCoord(VehicleCoords)
    local vehname = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()
    SetNewWaypoint(VehicleCoords.x, VehicleCoords.y)
    SetBlipSprite (TempBlip, 466)
    SetBlipDisplay(TempBlip, 4)
    SetBlipScale  (TempBlip, 1.1)
    SetBlipAsShortRange(TempBlip, true)
    SetBlipColour(TempBlip, 26)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Car: "..RLCore.Shared.Vehicles[vehname].name)
    EndTextCommandSetBlipName(TempBlip)
    RLCore.Functions.Notify("Your Car "..RLCore.Shared.Vehicles[vehname].name.." is indicated on the map for 1 minute!", "success", 10000)
    SetTimeout(60 * 1000, function()
        TriggerEvent('RLCore:Notify', 'Your vehicle is no longer displayed on the map!', 'error')
        RemoveBlip(TempBlip)
    end)
end

function doCarDamage(veh, body, engine)
	smash = false
	damageOutside = false
	damageOutside2 = false
	local engine = engine + 0.0
	local body = body + 0.0
	if engine < 200.0 then
		engine = 200.0
    end

    if engine > 1000.0 then
        engine = 1000.0
    end

	if body < 150.0 then
		body = 150.0
	end
	if body < 700.0 then
		smash = true
	end

	if body < 600.0 then
		damageOutside = true
	end

	if body < 300.0 then
		damageOutside2 = true
	end

    Citizen.Wait(100)
    SetVehicleEngineHealth(veh, engine)
	if smash then
		SmashVehicleWindow(veh, 0)
		SmashVehicleWindow(veh, 1)
		SmashVehicleWindow(veh, 2)
		SmashVehicleWindow(veh, 3)
		SmashVehicleWindow(veh, 4)
	end
	if damageOutside then
		SetVehicleDoorBroken(veh, 1, true)
		SetVehicleDoorBroken(veh, 6, true)
		SetVehicleDoorBroken(veh, 4, true)
	end
	if damageOutside2 then
		SetVehicleTyreBurst(veh, 1, false, 990.0)
		SetVehicleTyreBurst(veh, 2, false, 990.0)
		SetVehicleTyreBurst(veh, 3, false, 990.0)
		SetVehicleTyreBurst(veh, 4, false, 990.0)
	end
	if body < 1000 then
		SetVehicleBodyHealth(veh, 985.1)
	end
end
-- Haritha#3955 --
-- Haritha#3955 --
-- Haritha#3955 --
-- Haritha#3955 --
-- Haritha#3955 --


SetVehicleProperties = function(vehicle, vehicleProps)
    RLCore.Functions.SetVehicleProperties(vehicle, vehicleProps)

    if vehicleProps["windows"] then
        for windowId = 1, 13, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end

    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end

    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
end

GetVehicleProperties = function(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = RLCore.Functions.GetVehicleProperties(vehicle)

        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}

        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
        
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
        
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end

        for id = 1, 13 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        
        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
        
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end

        return vehicleProps
    end
end