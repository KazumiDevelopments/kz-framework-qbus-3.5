MenuEnable = false

CreateThread(function()
    for k,v in pairs(Config.RentelLocations) do
        local RentalPoint = AddBlipForCoord(v["coords"][1], v["coords"][2], v["coords"][3])

        SetBlipSprite (RentalPoint, 379)
        SetBlipDisplay(RentalPoint, 4)
        SetBlipScale  (RentalPoint, 0.65)
        SetBlipAsShortRange(RentalPoint, true)
        SetBlipColour(RentalPoint, 3)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Rental")
        EndTextCommandSetBlipName(RentalPoint)
    end

    while true do
        local sleep = 500
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)
        local plyID = PlayerId()

        for k,v in pairs(Config.RentelLocations) do
            local distance = GetDistanceBetweenCoords(plyCoords, v['coords'][1], v['coords'][2], v['coords'][3])
            if distance < 1.5 then
                sleep = 1
                DrawMarker(20,v['coords'][1], v['coords'][2], v['coords'][3],0,0,0,0,0,0,0.701,1.0001,0.3001,222,50, 50,distance,0,0,0,0)
                DrawText3Ds(v['coords'][1], v['coords'][2], v['coords'][3], '[E] - Rent a Vehicle')
                if IsControlJustPressed(0, 38) then
                    ClearMenu()
                    MenuTitle = "Vehicle Rental"
                    MenuEnable = true

                    local coords = { x = v['coords'][1], y = v['coords'][2], z = v['coords'][3], h = v['coords'][4] }
                    for model, data in pairs(Config.RentelVehicles) do
                        if data.stored then
                            Menu.addButton(data.label .. ' - Stored',"SpawnVehicle", { model = model, price = 0, coords = coords }) 
                        else
                            Menu.addButton(data.label .. ' - $' .. data.price,"SpawnVehicle", { model = model, price = data.price, coords = coords }) 
                        end
                    end

                    Menu.addButton('Close Menu',"CloseMenu") 
                    Menu.hidden = false

                    while MenuEnable do
                        distance = GetDistanceBetweenCoords(plyCoords, v['coords'][1], v['coords'][2], v['coords'][3])
                        if distance > 2 then
                            CloseMenu()
                        end
                        Wait(1)
                        Menu.renderGUI()
                    end
                end
            elseif distance < 4 then
                sleep = 1
                DrawText3Ds(v['coords'][1], v['coords'][2], v['coords'][3], 'Rental')
                DrawMarker(20,v['coords'][1], v['coords'][2], v['coords'][3],0,0,0,0,0,0,0.701,1.0001,0.3001,222,50, 50,distance,0,0,0,0)
            elseif distance < 50 then
                sleep = 1
                DrawMarker(20,v['coords'][1], v['coords'][2], v['coords'][3],0,0,0,0,0,0,0.701,1.0001,0.3001,222,50, 50,distance,0,0,0,0)
            end
        end

        Wait(sleep)
    end
end)

function CloseMenu()
    ClearMenu()
    MenuEnable = false
    Menu.hidden = true
end

function SpawnVehicle(data)
    TriggerServerEvent('rl-phone:server:spawnVehicle', data)
    Wait(1500)
end

RegisterNetEvent('rl-phone:client:spawnVehicle')
AddEventHandler('rl-phone:client:spawnVehicle', function(data)
    CloseMenu()
        
    if Config.RentelVehicles[data.model]['stored'] then
        Config.RentelVehicles[data.model]['stored'] = false
    else
        TriggerServerEvent('rl-phone:server:removeMoney', 'cash', data.price)
    end

     RLCore.Functions.SpawnVehicle(data.model, function(veh)
        SetEntityHeading(veh, data.coords.h)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        SetVehicleNumberPlateText(veh, data.plate)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
    end, data.coords, true)
end)

function RestoreVehicle(model)
    local plyPed = PlayerPedId()
    local plyCoords = GetEntityCoords(plyPed)

    if Config.RentelVehicles[model] and Config.RentelVehicles[model]['stored'] then
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Rentel",
                text = "You returned the vehicle to " .. Config.RentelVehicles[model]['stored'] .. ".",
                icon = Config.RentelVehicles[model]['icon'],
                color = "#ee82ee",
                timeout = 1500,
            },
        })

        Config.RentelVehicles[model]['stored'] = false
        TriggerServerEvent('rl-phone:server:restoreRented', math.floor(Config.RentelVehicles[model]['price'] / 2))
    end
end

function RentVehicle(model)
    local plyPed = PlayerPedId()
    local plyCoords = GetEntityCoords(plyPed)
    local location, distance = nil, nil
    for k,v in pairs(Config.RentelLocations) do
        if not distance or GetDistanceBetweenCoords(plyCoords, v['coords'][1], v['coords'][2], v['coords'][3]) < distance then
            location = k
        end
    end

    if Config.RentelVehicles[model] and not Config.RentelVehicles[model]['stored'] and location and Config.RentelVehicles[model].price <= RLCore.Functions.GetPlayerData()['money']['bank'] then
        TriggerServerEvent('rl-phone:server:removeMoney', 'bank', Config.RentelVehicles[model]['price'])
        SetNewWaypoint(Config.RentelLocations[location]['coords'][1], Config.RentelLocations[location]['coords'][2])
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Rental",
                text = "Your rented vehicle is waiting for you at the " .. location .. '.',
                icon = Config.RentelVehicles[model]['icon'],
                color = "#ee82ee",
                timeout = 1500,
            },
        })
        Config.RentelVehicles[model]['stored'] = location
    else
        SendNUIMessage({
            action = "PhoneNotification",
            PhoneNotify = {
                title = "Rental",
                text = "You don't have enough bank balance.",
                icon = Config.RentelVehicles[model]['icon'],
                color = "#ee82ee",
                timeout = 1500,
            },
        })
    end
end

function DrawText3Ds(x, y, z, text)

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end