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

Citizen.CreateThread(function()
    for k,v in pairs(Config.Locations) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipColour(blip, 0)

        SetBlipSprite(blip, 135)
        SetBlipScale(blip, 0.5)
        SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("NEWS STUFF")
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)
        local letSleep = true

        local distance = {}
        local whitelisted = (RLCore and RLCore.Functions.GetPlayerData().job and RLCore.Functions.GetPlayerData().job.name == 'reporter')
        local isboss = (RLCore and RLCore.Functions.GetPlayerData().job and RLCore.Functions.GetPlayerData().job.isboss)

        for k,v in pairs(Config.Locations) do
            distance[k] = Vdist2(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
            if (distance[k] < 20) then
                letSleep = false

                if (k == 'boss') then
                    if whitelisted and isboss then
                        DrawMarker(27, v.x, v.y, v.z-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.001, 1.0001, 0.5001, 0, 25, 165, 100, false, true, 2, false, false, false, false)
                    end
                elseif (whitelisted) then
                    if k == "helipad" then 
                        if isboss then
                            DrawMarker(27, v.x, v.y, v.z-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.001, 1.0001, 0.5001, 0, 25, 165, 100, false, true, 2, false, false, false, false)
                        end
                    else
                        DrawMarker(27, v.x, v.y, v.z-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.001, 1.0001, 0.5001, 0, 25, 165, 100, false, true, 2, false, false, false, false)
                    end
                end
            end
        end

        if (whitelisted) then
            if (distance['stash'] < 5) then
                DrawText3Ds(Config.Locations['stash'].x, Config.Locations['stash'].y, Config.Locations['stash'].z, "[E] - Stash")
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "news", {
                        maxweight = 4000000,
                        slots = 500,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", "news")
                end
            elseif (distance['shop'] < 5) then
                DrawText3Ds(Config.Locations['shop'].x, Config.Locations['shop'].y, Config.Locations['shop'].z, "[E] - Shop")
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent("inventory:server:OpenInventory", "shop", "news", Config.Shop)
                end
            elseif (distance['boss'] < 5 and isboss) then
                DrawText3Ds(Config.Locations['boss'].x, Config.Locations['boss'].y, Config.Locations['boss'].z, "[E] - Boss Menu")
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent("bb-bossmenu:server:openMenu")
                end
            elseif (distance['vehicles'] < 2.5) then
                DrawText3Ds(Config.Locations["vehicles"].x, Config.Locations["vehicles"].y, Config.Locations["vehicles"].z, IsPedInAnyVehicle(GetPlayerPed(-1), false) and "~g~E~w~ - Store vehicle" or "~g~E~w~ - Vehicles")
                if IsControlJustReleased(0, 38) then
                    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                        DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                    else
                        MenuGarage()
                        Menu.hidden = not Menu.hidden
                    end
                end
                Menu.renderGUI()
            elseif distance['helipad'] < 5 then
                if isboss then
                    DrawText3Ds(Config.Locations["helipad"].x, Config.Locations["helipad"].y, Config.Locations["helipad"].z, IsPedInAnyVehicle(PlayerPedId(), false) and "~g~E~w~ - Store Heli" or "~g~E~w~ - Spawn News Heli")
                    if IsControlJustReleased(0, 38) then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), false))
                        else
                            TakeOutVehicle("wnews3", {x = Config.Locations["helipad"].x, y = Config.Locations["helipad"].y, z = Config.Locations["helipad"].z, a = Config.Locations["helipad"].a})
                        end
                    end
                end
            end
        end

        if (letSleep) then
            Wait(1000)
        else
            Wait(1)
        end
    end
end)

function DrawText3Ds(x, y, z, text)
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

function MenuGarage()
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Vehicles", "VehicleList", nil)
    Menu.addButton("Close Menu", "closeMenuFull", nil) 
end

function VehicleList(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "Vehicle:"
    ClearMenu()
    for k, v in pairs(Config.Vehicles) do
        Menu.addButton(Config.Vehicles[k], "TakeOutVehicle", k, "Garage", " Motor: 100%", " Body: 100%", " Fuel: 100%")
    end
        
    Menu.addButton("Return", "MenuGarage",nil)
end

function TakeOutVehicle(vehicleInfo, coords)
    if not coords then
        coords = Config.Locations["vehicles"]
        coords.a = GetEntityHeading(PlayerPedId())
    end

    RLCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "NEWS"..tostring(math.random(1000, 9999)))
        exports["lj-fuel"]:SetFuel(veh, 100)
        closeMenuFull()
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
        SetVehicleEngineOn(veh, true, true)
        CurrentPlate = GetVehicleNumberPlateText(veh)
    end, coords, true)
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end