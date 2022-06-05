local DoorLocked = false

CreateThread(function()
    Wait(500)
    TriggerServerEvent('rl-houses:server:doorState')
    while true do
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)
        local letSleep = true

        local distance = {}
        local whitelisted = (RLCore and RLCore.Functions.GetPlayerData().job and RLCore.Functions.GetPlayerData().job.name == 'realestate')
        local isboss = (RLCore and RLCore.Functions.GetPlayerData().job and RLCore.Functions.GetPlayerData().job.isboss)

        for k,v in pairs(Config.Locations) do
            distance[k] = Vdist2(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
            if (distance[k] < 20) then
                letSleep = false
                local draw = false
                if (k == 'enter' or k =='exit') then
                    draw = true
                elseif (k == 'boss') then
                    if whitelisted and isboss then
                        draw = true
                    end
                elseif whitelisted then
                    draw = true
                end

                if (draw) then
                    DrawMarker(27, v.x, v.y, v.z-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.001, 1.0001, 0.5001, 0, 25, 165, 100, false, true, 2, false, false, false, false)
                end
            end
        end

        if (distance['enter'] < 5) then
            if (whitelisted) then
                DrawText3Ds(Config.Locations['enter'].x, Config.Locations['enter'].y, Config.Locations['enter'].z, "[E] - Enter | [H] - " .. (DoorLocked and "Unlock" or "Lock"))
                if (IsControlJustPressed(0, 74)) then 
                    TriggerServerEvent('rl-houses:server:doorState', not DoorLocked)
                end
            else
                DrawText3Ds(Config.Locations['enter'].x, Config.Locations['enter'].y, Config.Locations['enter'].z, DoorLocked and "Locked" or "[E] - Leave")
            end

            if IsControlJustPressed(0, 38) and (whitelisted or not DoorLocked) then
                DoScreenFadeOut(500)
                while not IsScreenFadedOut() do
                    Wait(10)
                end
                SetEntityCoords(PlayerPedId(), Config.Locations['exit'].x, Config.Locations['exit'].y, Config.Locations['exit'].z)
                Wait(1000)
                DoScreenFadeIn(500)
            end
        elseif (distance['exit'] < 5) then
            if (whitelisted) then
                DrawText3Ds(Config.Locations['exit'].x, Config.Locations['exit'].y, Config.Locations['exit'].z, "[E] - Leave | [H] - " .. (DoorLocked and "Unlock" or "Lock"))
                if (IsControlJustPressed(0, 74)) then 
                    TriggerServerEvent('rl-houses:server:doorState', not DoorLocked)
                end
            else
                DrawText3Ds(Config.Locations['exit'].x, Config.Locations['exit'].y, Config.Locations['exit'].z, DoorLocked and "Locked" or "[E] - Enter")
            end

            if IsControlJustPressed(0, 38) and (whitelisted or not DoorLocked) then
                DoScreenFadeOut(500)
                while not IsScreenFadedOut() do
                    Wait(10)
                end
                SetEntityCoords(PlayerPedId(), Config.Locations['enter'].x, Config.Locations['enter'].y, Config.Locations['enter'].z)
                Wait(1000)
                DoScreenFadeIn(500)
            end
        elseif (whitelisted) then
            if (distance['stash'] < 5) then
                DrawText3Ds(Config.Locations['stash'].x, Config.Locations['stash'].y, Config.Locations['stash'].z, "[E] - Stash")
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "realestate", {
                        maxweight = 4000000,
                        slots = 500,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", "realestate")
                end
            elseif (distance['shop'] < 5) then
                DrawText3Ds(Config.Locations['shop'].x, Config.Locations['shop'].y, Config.Locations['shop'].z, "[E] - Shop")
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent("inventory:server:OpenInventory", "shop", "realestate", Config.Shop)
                end
            elseif (distance['boss'] < 5 and isboss) then
                DrawText3Ds(Config.Locations['boss'].x, Config.Locations['boss'].y, Config.Locations['boss'].z, "[E] - Boss Menu")
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent("bb-bossmenu:server:openMenu")
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

RegisterNetEvent('rl-houses:client:doorState')
AddEventHandler('rl-houses:client:doorState', function(bool)
    DoorLocked = bool
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