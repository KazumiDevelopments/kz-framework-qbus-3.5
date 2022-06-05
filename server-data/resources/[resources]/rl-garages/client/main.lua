RLCore = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

--- CODE

local currentHouseGarage = nil
local hasGarageKey = nil
local currentGarage = nil
local OutsideVehicles = {}

RegisterNetEvent('rl-garages:client:setHouseGarage')
AddEventHandler('rl-garages:client:setHouseGarage', function(house, hasKey)
    currentHouseGarage = house
    hasGarageKey = hasKey
end)

RegisterNetEvent('rl-garages:client:houseGarageConfig')
AddEventHandler('rl-garages:client:houseGarageConfig', function(garageConfig)
    HouseGarages = garageConfig
end)

RegisterNetEvent('rl-garages:client:addHouseGarage')
AddEventHandler('rl-garages:client:addHouseGarage', function(house, garageInfo)
    HouseGarages[house] = garageInfo
end)

-- function AddOutsideVehicle(plate, veh)
--     OutsideVehicles[plate] = veh
--     TriggerServerEvent('rl-garages:server:UpdateOutsideVehicles', OutsideVehicles)
-- end

RegisterNetEvent('rl-garages:client:takeOutDepot')
AddEventHandler('rl-garages:client:takeOutDepot', function(vehicle)
    if OutsideVehicles ~= nil and next(OutsideVehicles) ~= nil then
        if OutsideVehicles[vehicle.plate] ~= nil then
            local VehExists = DoesEntityExist(OutsideVehicles[vehicle.plate])
            if not VehExists then
                RLCore.Functions.SpawnVehicle(vehicle.model, function(veh)
                    RLCore.Functions.SetVehicleProperties(veh, vehicle.props)
                    --RLCore.Functions.TriggerCallback('rl-garage:server:GetVehicleProperties', function(properties)
                        RLCore.Functions.SetVehicleProperties(veh, properties)
                        enginePercent = round(vehicle.props.engineHealth / 10, 0)
                        bodyPercent = round(vehicle.props.bodyHealth / 10, 0)
                        currentFuel = vehicle.fuel

                        if vehicle.plate ~= nil then
                            DeleteVehicle(OutsideVehicles[vehicle.plate])
                            OutsideVehicles[vehicle.plate] = veh
                            TriggerServerEvent('rl-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                        end
                        
                        if vehicle.status ~= nil then
                            TriggerServerEvent('rl-vehicletuning:server:LoadStatus', vehicle.status, vehicle.plate)
                        end
                        
                        if vehicle.drivingdistance ~= nil then
                            local amount = round(vehicle.drivingdistance / 1000, -2)
                            TriggerEvent('rl-hud:client:UpdateDrivingMeters', true, amount)
                            TriggerServerEvent('rl-vehicletuning:server:UpdateDrivingDistance', vehicle.drivingdistance, vehicle.plate)
                        end

                        if vehicle.model == "urus" then
                            SetVehicleExtra(veh, 1, false)
                            SetVehicleExtra(veh, 2, true)
                        end

                        SetVehicleNumberPlateText(veh, vehicle.plate)
                        SetEntityHeading(veh, Depots[currentGarage].takeVehicle.h)
                        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                        exports['lj-fuel']:SetFuel(veh, vehicle.fuel)
                        SetEntityAsMissionEntity(veh, true, true)
                        TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate, vehicle)
                        TriggerServerEvent('rl-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                        RLCore.Functions.Notify("Vehicle Off: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "%", "primary", 4500)
                        closeMenuFull()
                        SetVehicleEngineOn(veh, true, true)
                    --end, vehicle.plate)
                    TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate, vehicle)
                end, Depots[currentGarage].spawnPoint, true)
            else
                local Engine = GetVehicleEngineHealth(OutsideVehicles[vehicle.plate])
                if Engine < 40.0 then
                    RLCore.Functions.SpawnVehicle(vehicle.model, function(veh)
                        RLCore.Functions.SetVehicleProperties(veh, vehicle.props)
                        --RLCore.Functions.TriggerCallback('rl-garage:server:GetVehicleProperties', function(properties)
                            RLCore.Functions.SetVehicleProperties(veh, properties)
                            enginePercent = round(vehicle.props.engineHealth / 10, 0)
                            bodyPercent = round(vehicle.props.bodyHealth / 10, 0)
                            currentFuel = vehicle.fuel
    
                            if vehicle.plate ~= nil then
                                DeleteVehicle(OutsideVehicles[vehicle.plate])
                                OutsideVehicles[vehicle.plate] = veh
                                TriggerServerEvent('rl-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                            end

                            if vehicle.status ~= nil and next(vehicle.status) ~= nil then
                                TriggerServerEvent('rl-vehicletuning:server:LoadStatus', vehicle.status, vehicle.plate)
                            end
                            
                            if vehicle.drivingdistance ~= nil then
                                local amount = round(vehicle.drivingdistance / 1000, -2)
                                TriggerEvent('rl-hud:client:UpdateDrivingMeters', true, amount)
                                TriggerServerEvent('rl-vehicletuning:server:UpdateDrivingDistance', vehicle.drivingdistance, vehicle.plate)
                            end
    
                            SetVehicleNumberPlateText(veh, vehicle.plate)
                            SetEntityHeading(veh, Depots[currentGarage].takeVehicle.h)
                            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                            exports['lj-fuel']:SetFuel(veh, vehicle.fuel)
                            SetEntityAsMissionEntity(veh, true, true)
                            TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate, vehicle)
                            TriggerServerEvent('rl-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                            RLCore.Functions.Notify("Vehicle Off: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "%", "primary", 4500)
                            closeMenuFull()
                            SetVehicleEngineOn(veh, true, true)
                        --end, vehicle.plate)
                        TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate, vehicle)
                    end, Depots[currentGarage].spawnPoint, true)
                else
                    RLCore.Functions.Notify('You cannot duplicate this vehicle', 'error')
                    AddTemporaryBlip(OutsideVehicles[vehicle.plate])
                end
            end
        else
            RLCore.Functions.SpawnVehicle(vehicle.model, function(veh)
                RLCore.Functions.SetVehicleProperties(veh, vehicle.props)
                --RLCore.Functions.TriggerCallback('rl-garage:server:GetVehicleProperties', function(properties)
                    RLCore.Functions.SetVehicleProperties(veh, properties)
                    enginePercent = round(vehicle.props.engineHealth / 10, 0)
                    bodyPercent = round(vehicle.props.bodyHealth / 10, 0)
                    currentFuel = vehicle.fuel

                    if vehicle.plate ~= nil then
                        OutsideVehicles[vehicle.plate] = veh
                        TriggerServerEvent('rl-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                    end

                    if vehicle.status ~= nil and next(vehicle.status) ~= nil then
                        TriggerServerEvent('rl-vehicletuning:server:LoadStatus', vehicle.status, vehicle.plate)
                    end

                    SetVehicleNumberPlateText(veh, vehicle.plate)
                    SetEntityHeading(veh, Depots[currentGarage].takeVehicle.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    exports['lj-fuel']:SetFuel(veh, vehicle.fuel)
                    SetEntityAsMissionEntity(veh, true, true)
                    TriggerServerEvent('rl-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                    RLCore.Functions.Notify("Vehicle Off: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "%", "primary", 4500)
                    closeMenuFull()
                    SetVehicleEngineOn(veh, true, true)
                --end, vehicle.plate)
                TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate, vehicle)
            end, Depots[currentGarage].spawnPoint, true)
        end
    else
        RLCore.Functions.SpawnVehicle(vehicle.model, function(veh)
            RLCore.Functions.SetVehicleProperties(veh, vehicle.props)
            --RLCore.Functions.TriggerCallback('rl-garage:server:GetVehicleProperties', function(properties)
                RLCore.Functions.SetVehicleProperties(veh, properties)
                enginePercent = round(vehicle.props.engineHealth / 10, 0)
                bodyPercent = round(vehicle.props.bodyHealth / 10, 0)
                currentFuel = vehicle.fuel

                if vehicle.plate ~= nil then
                    OutsideVehicles[vehicle.plate] = veh
                    TriggerServerEvent('rl-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                end
                
                if vehicle.status ~= nil then
                    TriggerServerEvent('rl-vehicletuning:server:LoadStatus', vehicle.status, vehicle.plate)
                end
                
                if vehicle.drivingdistance ~= nil then
                    local amount = round(vehicle.drivingdistance / 1000, -2)
                    TriggerEvent('rl-hud:client:UpdateDrivingMeters', true, amount)
                    TriggerServerEvent('rl-vehicletuning:server:UpdateDrivingDistance', vehicle.drivingdistance, vehicle.plate)
                end

                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, Depots[currentGarage].takeVehicle.h)
                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                exports['lj-fuel']:SetFuel(veh, vehicle.fuel)
                SetEntityAsMissionEntity(veh, true, true)
                TriggerServerEvent('rl-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                RLCore.Functions.Notify("Vehicle Off: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "%", "primary", 4500)
                closeMenuFull()
                SetVehicleEngineOn(veh, true, true)
            --end, vehicle.plate)
            TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate, vehicle)
        end, Depots[currentGarage].spawnPoint, true)
    end

    TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate, vehicle)
end)

function AddTemporaryBlip(vehicle)  
    local VehicleCoords = GetEntityCoords(vehicle)
    local TempBlip = AddBlipForCoord(VehicleCoords)
    local VehicleData = RLCore.Shared.VehicleModels[GetEntityModel(vehicle)]

    SetBlipSprite (TempBlip, 225)
    SetBlipDisplay(TempBlip, 4)
    SetBlipScale  (TempBlip, 0.85)
    SetBlipAsShortRange(TempBlip, true)
    SetBlipColour(TempBlip, 0)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Temp Blip: "..VehicleData["name"])
    EndTextCommandSetBlipName(TempBlip)
    RLCore.Functions.Notify("Your "..VehicleData["name"].." is temporarily indicated on the map!", "success", 10000)

    SetTimeout(60 * 1000, function()
        RLCore.Functions.Notify('Your vehicle is NOT shown on the map anymore!', 'error')
        RemoveBlip(TempBlip)
    end)
end

DrawText3Ds = function(x, y, z, text)
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

Citizen.CreateThread(function()
    for k, v in pairs(Garages) do
        Garage = AddBlipForCoord(Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z)

        SetBlipSprite (Garage, 357)
        SetBlipDisplay(Garage, 4)
        SetBlipScale  (Garage, 0.65)
        SetBlipAsShortRange(Garage, true)
        SetBlipColour(Garage, 3)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Garages[k].label)
        EndTextCommandSetBlipName(Garage)
    end

    for k, v in pairs(Depots) do
        Depot = AddBlipForCoord(Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z)

        SetBlipSprite (Depot, 68)
        SetBlipDisplay(Depot, 4)
        SetBlipScale  (Depot, 0.7)
        SetBlipAsShortRange(Depot, true)
        SetBlipColour(Depot, 5)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Depots[k].label)
        EndTextCommandSetBlipName(Depot)
    end
end)

function MenuGarage()
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("My Vehicles", "VehicleList", nil)
    Menu.addButton("Close Menu", "close", nil) 
end

function MenuDepot()
    ped = GetPlayerPed(-1);
    MenuTitle = "Depot"
    ClearMenu()
    Menu.addButton("Depot Vehicle", "DepotList", nil)
    Menu.addButton("Close Menu", "close", nil) 
end

function MenuHouseGarage(house)
    ped = GetPlayerPed(-1);
    MenuTitle = HouseGarages[house].label
    ClearMenu()
    Menu.addButton("My Vehicles", "HouseGarage", house)
    Menu.addButton("Close Menu", "close", nil) 
end

function yeet(label)
    print(label)
end

function HouseGarage(house)
    RLCore.Functions.TriggerCallback("rl-garage:server:GetHouseVehicles", function(result)
        ped = GetPlayerPed(-1);
        MenuTitle = "Depot Vehicles :"
        ClearMenu()

        if result == nil then
            TriggerEvent("debug", 'Garages: 0 Vehicles', 'error')
            RLCore.Functions.Notify("You have no vehicles in your garage", "error", 5000)
            closeMenuFull()
        else
            TriggerEvent("debug", 'Garages: ' .. #result .. ' Vehicles', 'success')
            Menu.addButton(HouseGarages[house].label, "yeet", HouseGarages[house].label)

            for k, v in pairs(result) do
                enginePercent = round(v.props.engineHealth / 10, 0)
                bodyPercent = round(v.props.bodyHealth / 10, 0)
                currentFuel = v.fuel
                curGarage = HouseGarages[house].label

                if v.state == 0 then
                    v.state = "Out"
                elseif v.state == 1 then
                    v.state = "Garage"
                elseif v.state == 2 then
                    v.state = "In"
                end
                
                local label = RLCore.Shared.Vehicles[v.model]["name"]
                if RLCore.Shared.Vehicles[v.model]["brand"] ~= nil then
                    label = RLCore.Shared.Vehicles[v.model]["brand"].." "..RLCore.Shared.Vehicles[v.model]["name"]
                end

                Menu.addButton(label, "TakeOutGarageVehicle", v, v.state, " Motor: " .. enginePercent.."%", " Body: " .. bodyPercent.."%")
            end
        end
            
        Menu.addButton("Back", "MenuHouseGarage", house)
    end, house)
end

function getPlayerVehicles(garage)
    local vehicles = {}

    return vehicles
end

function DepotList()
    RLCore.Functions.TriggerCallback("rl-garage:server:GetDepotVehicles", function(result)
        ped = GetPlayerPed(-1);
        MenuTitle = "Depot Vehicles :"
        ClearMenu()

        if result == nil then
            RLCore.Functions.Notify("There are no vehicles in the depot", "error", 5000)
            closeMenuFull()
        else
            Menu.addButton(Depots[currentGarage].label, "yeet", Depots[currentGarage].label)

            

            for k, v in pairs(result) do
                --print(json.encode(result))
                --[[ for b, g in pairs(v.props) do 
                    print(b,g)
                end ]]

                --print(v.props.engineHealth)
                enginePercent = round(v.props.engineHealth / 10, 0)
                bodyPercent = round(v.props.bodyHealth / 10, 0)
                currentFuel = v.fuel
                
                if v.state == 0 then
                    v.state = "Depot"
                end

                --local label = RLCore.Shared.Vehicles[v.vehicle]["name"]
                --if RLCore.Shared.Vehicles[v.vehicle]["brand"] ~= nil then
                --    label = RLCore.Shared.Vehicles[v.vehicle]["brand"].." "..RLCore.Shared.Vehicles[v.vehicle]["name"]
                --else
                --   label = v.model
                --end
                Menu.addButton(GetLabelText(GetDisplayNameFromVehicleModel(v.model)), "TakeOutDepotVehicle", v, v.state .. " ($"..v.depotprice..",-)", " Motor: " .. enginePercent.."%", " Body: " .. bodyPercent.."%")
            end
        end
            
        Menu.addButton("Back", "MenuDepot",nil)
    end)
end

function VehicleList()
    RLCore.Functions.TriggerCallback("rl-garage:server:GetUserVehicles", function(result)
        ped = GetPlayerPed(-1);
        MenuTitle = "My Vehicles :"
        ClearMenu()

        if result == nil then
            TriggerEvent("debug", 'Garages: 0 Vehicles', 'error')
            RLCore.Functions.Notify("You have no vehicles in this garage", "error", 5000)
            closeMenuFull()
        else
            TriggerEvent("debug", 'Garages: ' .. #result .. ' Vehicles', 'success')
            Menu.addButton(Garages[currentGarage].label, "yeet", Garages[currentGarage].label)

            for k, v in pairs(result) do
                local vehProps = json.decode(v.props)
                enginePercent = round(vehProps.engineHealth / 10, 0)
                bodyPercent = round(vehProps.bodyHealth / 10, 0)
                currentFuel = vehProps.fuelLevel
                curGarage = Garages[v.garage].label


                if v.state == 0 then
                    v.state = "Out"
                elseif v.state == 1 then
                    v.state = "Garage"
                elseif v.state == 2 then
                    v.state = "In"
                end

                --local label = RLCore.Shared.Vehicles[v.model]["name"]
                --if RLCore.Shared.Vehicles[v.model]["brand"] ~= nil then
                --    label = RLCore.Shared.Vehicles[v.model]["brand"].." "..RLCore.Shared.Vehicles[v.model]["name"]
                --end

                Menu.addButton(GetLabelText(GetDisplayNameFromVehicleModel(v.model)), "TakeOutVehicle", v, v.state, " Motor: " .. enginePercent .. "%", " Body: " .. bodyPercent.. "%")
            end
        end
            
        Menu.addButton("Back", "MenuGarage", nil)
    end, currentGarage)
end

RegisterCommand("vals", function(source, args, raw)
    print(GetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId(), false)))
    print(GetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), false)))
end)

function TakeOutVehicle(vehicle)
    if vehicle.state == "Garage" then
        local vehProps = json.decode(vehicle.props)
        enginePercent = round(vehProps.engineHealth / 10, 0)
        bodyPercent = round(vehProps.bodyHealth / 10, 0)
        currentFuel = vehProps.fuelLevel

        TriggerEvent("debug", 'Garages: Spawn ' .. vehicle.model, 'success')
        print(json.encode(vehicle.plate))

        RLCore.Functions.SpawnVehicle(vehicle.model, function(veh)
            SetVehicleProperties(veh, vehicle.props)
            -- RLCore.Functions.SetVehicleProperties(veh, vehicle.props)
            --RLCore.Functions.TriggerCallback('rl-garage:server:GetVehicleProperties', function(properties)
                if vehicle.plate ~= nil then
                    OutsideVehicles[vehicle.plate] = veh
                    TriggerServerEvent('rl-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                end

                if vehicle.status ~= nil and next(vehicle.status) ~= nil then
                    TriggerServerEvent('rl-vehicletuning:server:LoadStatus', vehicle.status, vehicle.plate)
                end

                if vehicle.model == "urus" then
                    SetVehicleExtra(veh, 1, false)
                    SetVehicleExtra(veh, 2, true)
                end
                
                if vehicle.drivingdistance ~= nil then
                    local amount = round(vehicle.drivingdistance / 1000, -2)
                    TriggerEvent('rl-hud:client:UpdateDrivingMeters', true, amount)
                    TriggerServerEvent('rl-vehicletuning:server:UpdateDrivingDistance', vehicle.drivingdistance, vehicle.plate)
                end

                --RLCore.Functions.SetVehicleProperties(veh, properties)
                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, Garages[currentGarage].spawnPoint.h)
                exports['lj-fuel']:SetFuel(veh, vehicle.fuel)
                SetEntityAsMissionEntity(veh, true, true)
                TriggerServerEvent('rl-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                RLCore.Functions.Notify("Vehicle Off: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "%", "primary", 4500)
                closeMenuFull()
                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate, vehicle)
                SetVehicleEngineOn(veh, true, true)
                Citizen.Wait(500)
                TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate, vehicle)
            --end, vehicle.plate)
            
        end, Garages[currentGarage].spawnPoint, true)
    elseif vehicle.state == "Out" then
        RLCore.Functions.Notify("Is your vehicle in the depot??", "error", 2500)
    elseif vehicle.state == "In" then
        RLCore.Functions.Notify("This vehicle has been seized by the Police", "error", 4000)
    end
end

function TakeOutDepotVehicle(vehicle)
    if vehicle.state == "Depot" then
        TriggerServerEvent("rl-garage:server:PayDepotPrice", vehicle)
    end
end

function TakeOutGarageVehicle(vehicle)
    if vehicle.state == "Garage" then
        TriggerEvent("debug", 'Garages: Spawn ' .. vehicle.model, 'success')
        RLCore.Functions.SpawnVehicle(vehicle.model, function(veh)
            RLCore.Functions.SetVehicleProperties(veh, vehicle.props)
            --RLCore.Functions.TriggerCallback('rl-garage:server:GetVehicleProperties', function(properties)
                RLCore.Functions.SetVehicleProperties(veh, properties)
                enginePercent = round(vehicle.props.engineHealth / 10, 1)
                bodyPercent = round(vehicle.props.bodyHealth / 10, 1)

                if vehicle.plate ~= nil then
                    OutsideVehicles[vehicle.plate] = veh
                    TriggerServerEvent('rl-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                end
                
                
                if vehicle.drivingdistance ~= nil then
                    local amount = round(vehicle.drivingdistance / 1000, -2)
                    TriggerEvent('rl-hud:client:UpdateDrivingMeters', true, amount)
                    TriggerServerEvent('rl-vehicletuning:server:UpdateDrivingDistance', vehicle.drivingdistance, vehicle.plate)
                end

                if vehicle.model == "urus" then 
                    SetVehicleExtra(veh, 1, false)
                    SetVehicleExtra(veh, 2, true)
                end

                if vehicle.status ~= nil and next(vehicle.status) ~= nil then
                    TriggerServerEvent('rl-vehicletuning:server:LoadStatus', vehicle.status, vehicle.plate)
                end

                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, HouseGarages[currentHouseGarage].takeVehicle.h)
                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                exports['lj-fuel']:SetFuel(veh, vehicle.fuel)
                SetEntityAsMissionEntity(veh, true, true) 
                TriggerServerEvent('rl-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                RLCore.Functions.Notify("Vehicle Off: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "%", "primary", 4500)
                closeMenuFull()
                TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate, vehicle)
                SetVehicleEngineOn(veh, true, true)
                Citizen.Wait(500)
                TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate, vehicle)
            --end, vehicle.plate)
        end, HouseGarages[currentHouseGarage].takeVehicle, true)
    end
end

function close()
    Menu.hidden = true
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end

function ClearMenu()
	--Menu = {}
	Menu.GUI = {}
	Menu.buttonCount = 0
	Menu.selection = 0
end

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local inGarageRange = false

        for k, v in pairs(Garages) do
            local takeDist = GetDistanceBetweenCoords(pos, Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z)
            if takeDist <= 15 then
                inGarageRange = true
                DrawMarker(2, Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                if takeDist <= 1.5 then
                    if not IsPedInAnyVehicle(ped) then
                        DrawText3Ds(Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z + 0.5, '[E] Garage')
                        if IsControlJustPressed(1, 177) and not Menu.hidden then
                            close()
                            PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                        end
                        if IsControlJustPressed(0, 38) then
                            RLCore.Functions.TriggerCallback('bb-garages:server:hasFines', function(hasfines)
                                if hasfines == false then
                                    MenuGarage()
                                    Menu.hidden = not Menu.hidden
                                    currentGarage = k
                                else
                                    RLCore.Functions.Notify("You have unpaid state fines, Please pay your fines in the banking app before you can use the garage...", "error")
                                end
                            end)
                        end
                    else
                        DrawText3Ds(Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z, Garages[k].label)
                    end
                end

                Menu.renderGUI()

                if takeDist >= 4 and not Menu.hidden then
                    closeMenuFull()
                end
            end

            local putDist = GetDistanceBetweenCoords(pos, Garages[k].putVehicle.x, Garages[k].putVehicle.y, Garages[k].putVehicle.z)

            if putDist <= 25 and IsPedInAnyVehicle(ped) then
                inGarageRange = true
                TriggerEvent('menu:garageClose')
                --[[ DrawMarker(2, Garages[k].putVehicle.x, Garages[k].putVehicle.y, Garages[k].putVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false, true, false, false, false)
                if putDist <= 1.5 then
                    DrawText3Ds(Garages[k].putVehicle.x, Garages[k].putVehicle.y, Garages[k].putVehicle.z + 0.5, '[E] Park Vehicle')
                    if IsControlJustPressed(0, 38) then
                        --
                        local curVeh = GetVehiclePedIsIn(ped)
                        local plate = GetVehicleNumberPlateText(curVeh)
                        RLCore.Functions.TriggerCallback('rl-garage:server:checkVehicleOwner', function(owned)
                            if owned then
                                TriggerServerEvent('rl-garage:server:updateComponents', GetVehicleProperties(curVeh), plate, k)
                                TriggerServerEvent('rl-garage:server:updateVehicleState', 1, plate, k)
                                TriggerServerEvent('vehiclemod:server:saveStatus', plate)
                                RLCore.Functions.DeleteVehicle(curVeh)
                                if plate ~= nil then
                                    OutsideVehicles[plate] = veh
                                    TriggerServerEvent('rl-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                                end
                                RLCore.Functions.Notify("Vehicle parked in, "..Garages[k].label, "primary", 4500)
                            else
                                RLCore.Functions.Notify("Nobody owns this vehicle..", "error", 3500)
                            end
                        end, plate) 
                        --
                    end
                end ]]
            end
        end
        if not inGarageRange then
            TriggerEvent('menu:garageCloseF')
            Citizen.Wait(1000)
        end
    end
end)

RegisterNetEvent('rl-garages:client:garageClose')
AddEventHandler('rl-garages:client:garageClose', function()
    local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local inGarageRange = false

        for k, v in pairs(Garages) do
            
            local putDist = GetDistanceBetweenCoords(pos, Garages[k].putVehicle.x, Garages[k].putVehicle.y, Garages[k].putVehicle.z)

            if putDist <= 25 and IsPedInAnyVehicle(ped) then
                --inGarageRange = true
                TriggerEvent('menu:garageClose')

                    --DrawText3Ds(Garages[k].putVehicle.x, Garages[k].putVehicle.y, Garages[k].putVehicle.z + 0.5, '[E] Park Vehicle')
                    --if IsControlJustPressed(0, 38) then 
                        --
                        local curVeh = GetVehiclePedIsIn(ped)
                        local plate = GetVehicleNumberPlateText(curVeh)
                        RLCore.Functions.TriggerCallback('rl-garage:server:checkVehicleOwner', function(owned)
                            if owned then
                                TriggerServerEvent('rl-garage:server:updateComponents', GetVehicleProperties(curVeh), plate, k)
                                TriggerServerEvent('rl-garage:server:updateVehicleState', 1, plate, k)
                                TriggerServerEvent('vehiclemod:server:saveStatus', plate)
                                RLCore.Functions.DeleteVehicle(curVeh)
                                if plate ~= nil then
                                    OutsideVehicles[plate] = veh
                                    TriggerServerEvent('rl-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                                end
                                RLCore.Functions.Notify("Vehicle parked in, "..Garages[k].label, "primary", 4500)
                                Citizen.Wait(3500)
                                TriggerEvent('menu:garageCloseF')
                            else
                                RLCore.Functions.Notify("Nobody owns this vehicle..", "error", 3500)
                            end
                        end, plate) 

            end
        end
        if not inGarageRange then
            TriggerEvent('menu:garageCloseF')
            Citizen.Wait(1000)
        end
end)





Citizen.CreateThread(function()
    Citizen.Wait(2000)
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local inGarageRange = false

        if HouseGarages ~= nil and currentHouseGarage ~= nil then
            if hasGarageKey and HouseGarages[currentHouseGarage] ~= nil then
                local takeDist = GetDistanceBetweenCoords(pos, HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z)
                if takeDist <= 15 then
                    inGarageRange = true
                    DrawMarker(2, HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                    if takeDist < 2.0 then
                        if not IsPedInAnyVehicle(ped) then
                            DrawText3Ds(HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z + 0.5, '~g~E~w~ - Garage')
                            if IsControlJustPressed(1, 177) and not Menu.hidden then
                                close()
                                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                            end
                            if IsControlJustPressed(0, 38) then
                                MenuHouseGarage(currentHouseGarage)
                                Menu.hidden = not Menu.hidden
                            end
                        elseif IsPedInAnyVehicle(ped) then
                            DrawText3Ds(HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z + 0.5, '~g~E~w~ - To park')
                            if IsControlJustPressed(0, 38) then
                                local curVeh = GetVehiclePedIsIn(ped)
                                local plate = GetVehicleNumberPlateText(curVeh)
                                RLCore.Functions.TriggerCallback('rl-garage:server:checkVehicleHouseOwner', function(owned)
                                    if owned then
                                        local bodyDamage = round(GetVehicleBodyHealth(curVeh), 1)
                                        local engineDamage = round(GetVehicleEngineHealth(curVeh), 1)
                                        local totalFuel = exports['lj-fuel']:GetFuel(curVeh)
                
                                        TriggerServerEvent('rl-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, currentHouseGarage)
                                        TriggerServerEvent('rl-garage:server:updateVehicleState', 1, plate, currentHouseGarage)
                                        RLCore.Functions.DeleteVehicle(curVeh)
                                        if plate ~= nil then
                                            OutsideVehicles[plate] = veh
                                            TriggerServerEvent('rl-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                                        end
                                        RLCore.Functions.Notify("Vehicle parked in, "..HouseGarages[currentHouseGarage].label, "primary", 4500)
                                    else
                                        RLCore.Functions.Notify("Nobody owns this vehicle...", "error", 3500)
                                    end
                                end, plate, currentHouseGarage)
                            end
                        end
                        
                        Menu.renderGUI()
                    end

                    if takeDist > 1.99 and not Menu.hidden then
                        closeMenuFull()
                    end
                end
            end
        end
        
        if not inGarageRange then
            Citizen.Wait(5000)
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local inGarageRange = false

        for k, v in pairs(Depots) do
            local takeDist = GetDistanceBetweenCoords(pos, Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z)
            if takeDist <= 15 then
                inGarageRange = true
                DrawMarker(2, Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                if takeDist <= 1.5 then
                    if not IsPedInAnyVehicle(ped) then
                        DrawText3Ds(Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z + 0.5, '[E] Garage')
                        if IsControlJustPressed(1, 177) and not Menu.hidden then
                            close()
                            PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                        end
                        if IsControlJustPressed(0, 38) then
                            RLCore.Functions.TriggerCallback('bb-garages:server:hasFines', function(hasfines)
                                if hasfines == false then
                                    MenuDepot()
                                    Menu.hidden = not Menu.hidden
                                    currentGarage = k
                                else
                                    RLCore.Functions.Notify("You have unpaid state fines, Please pay your fines in the banking app before you can use the garage...", "error")
                                end
                            end)
                        end
                    end
                end

                Menu.renderGUI()

                if takeDist >= 4 and not Menu.hidden then
                    closeMenuFull()
                end
            end
        end

        if not inGarageRange then
            Citizen.Wait(5000)
        end
    end
end)

function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces>0 then
      local mult = 10^numDecimalPlaces
      return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end

SetVehicleProperties = function(vehicle, vehicleProps)
    vehicleProps = json.decode(vehicleProps)
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

    if vehicleProps["fuelLevel"] then
        exports["lj-fuel"]:SetFuel(vehicle, vehicleProps["fuelLevel"])
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

        local engineDamage = math.ceil(GetVehicleEngineHealth(vehicle))
        local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicle))
        local totalFuel = exports['lj-fuel']:GetFuel(vehicle)

        if engineDamage > 1000 then
            engineDamage = engineDamage / 1000
        end
    
        if bodyDamage > 1000 then
            bodyDamage = bodyDamage / 1000
        end

        vehicleProps["engineHealth"] = engineDamage
        vehicleProps["bodyHealth"] = bodyDamage
        vehicleProps["fuelLevel"] = GetVehicleFuelLevel(vehicle)

        return vehicleProps
    end
end