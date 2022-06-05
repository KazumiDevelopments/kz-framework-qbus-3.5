function DrawText3D(x, y, z, text)
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

local currentGarage = 1
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if isLoggedIn then
            if PlayerJob.name == "police" then
                local pos = GetEntityCoords(GetPlayerPed(-1))
                --[[ for k, v in pairs(Config.Locations["duty"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 5) then
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                            if not onDuty then
                                DrawText3D(v.x, v.y, v.z, "~r~E~w~ On Duty")
                            else
                                DrawText3D(v.x, v.y, v.z, "~r~E~w~ - Off Duty")
                            end
                            if IsControlJustReleased(0, Keys["E"]) then
                                onDuty = not onDuty
                                TriggerServerEvent("police:server:UpdateCurrentCops")
                                TriggerServerEvent("RLCore:ToggleDuty")
                                TriggerServerEvent("police:server:UpdateBlips")
                                TriggerEvent('rl-policealerts:ToggleDuty', onDuty)
                            end
                        end
                    end
                end ]]
                
                for k, v in pairs(Config.Locations["evidence"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                            DrawText3D(v.x, v.y, v.z, "~r~E~w~ Open Evidence Locker - use /evidence case# ")
                            if IsControlJustReleased(0, Keys["E"]) then
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", "policeevidence", {
                                    maxweight = 4000000,
                                    slots = 500,
                                })
                                TriggerEvent("inventory:client:SetCurrentStash", "policeevidence")
                            end
                        end
                    end
                end

                for k, v in pairs(Config.Locations["evidence2"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                            DrawText3D(v.x, v.y, v.z, "~r~E~w~ Open Evidence Locker - use /evidence case# ")
                            if IsControlJustReleased(0, Keys["E"]) then
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", "policeevidence2", {
                                    maxweight = 4000000,
                                    slots = 500,
                                })
                                TriggerEvent("inventory:client:SetCurrentStash", "policeevidence2")
                            end
                        end
                    end
                end

                for k, v in pairs(Config.Locations["evidence3"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                            DrawText3D(v.x, v.y, v.z, "~r~E~w~ Open Evidence Locker - use /evidence case# ")
                            if IsControlJustReleased(0, Keys["E"]) then
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", "policeevidence3", {
                                    maxweight = 4000000,
                                    slots = 500,
                                })
                                TriggerEvent("inventory:client:SetCurrentStash", "policeevidence3")
                            end
                        end
                    end
                end

                for k, v in pairs(Config.Locations["csi"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                            DrawText3D(v.x, v.y, v.z, "~r~E~w~ Open CSI Locker")
                            if IsControlJustReleased(0, Keys["E"]) then
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", "cislocker", {
                                    maxweight = 4000000,
                                    slots = 500,
                                })
                                TriggerEvent("inventory:client:SetCurrentStash", "cislocker")
                            end
                        end
                    end
                end

                for k, v in pairs(Config.Locations["trash"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                            DrawText3D(v.x, v.y, v.z, "~r~E~w~ Open Trash Locker")
                            if IsControlJustReleased(0, Keys["E"]) then
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", "policetrash", {
                                    maxweight = 4000000,
                                    slots = 300,
                                })
                                TriggerEvent("inventory:client:SetCurrentStash", "policetrash")
                            end
                        end
                    end
                end
				
                for k, v in pairs(Config.Locations["property"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                            DrawText3D(v.x, v.y, v.z, "~r~E~w~ Open Property Locker")
                            if IsControlJustReleased(0, Keys["E"]) then
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", "propertylocker", {
                                    maxweight = 4000000,
                                    slots = 500,
                                })
                                TriggerEvent("inventory:client:SetCurrentStash", "propertylocker")
                            end
                        end
                    end
                end

                --[[ for k, v in pairs(Config.Locations["vehicle"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 7.5) then
                         if onDuty then
                             DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                             if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                 if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                     DrawText3D(v.x, v.y, v.z, "~r~E~w~ Store the vehicle")
                                 else
                                     DrawText3D(v.x, v.y, v.z, "~r~E~w~ Vehicles")
                                 end
                                 if IsControlJustReleased(0, Keys["E"]) then
                                     if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                         RLCore.Functions.DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                                     else
                                         MenuGarage()
                                         currentGarage = k
                                         Menu.hidden = not Menu.hidden
                                     end
                                 end
                                 Menu.renderGUI()
                             end  
                         end
                     end
                end ]]

                for k, v in pairs(Config.Locations["impound"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 7.5) then
                        if onDuty then
                            DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                    DrawText3D(v.x, v.y, v.z, "~r~E~w~ Store the vehicle")
                                else
                                    DrawText3D(v.x, v.y, v.z, "~r~E~w~ Vehicles")
                                end
                                if IsControlJustReleased(0, Keys["E"]) then
                                    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                        RLCore.Functions.DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                                    else
                                        MenuImpound()
                                        currentGarage = k
                                        Menu.hidden = not Menu.hidden
                                    end
                                end
                                Menu.renderGUI()
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["helicopter"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 7.5) then
                        if onDuty then
                            DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                    DrawText3D(v.x, v.y, v.z, "~r~E~w~ Store the helicopter")
                                else
                                    DrawText3D(v.x, v.y, v.z, "~r~E~w~ Spawn Helicopter")
                                end
                                if IsControlJustReleased(0, Keys["E"]) then
                                    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                        RLCore.Functions.DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                                    else
                                        local coords = Config.Locations["helicopter"][k]
                                        if not IsModelValid(Config.Helicopter) then
                                            RLCore.Functions.Notify("Invaild Vehicle Model", "error")
                                            return false
                                        end

                                        RLCore.Functions.SpawnVehicle(Config.Helicopter, function(veh)
                                            SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
                                            SetEntityHeading(veh, coords.h)
                                            exports['lj-fuel']:SetFuel(veh, 100)
                                            closeMenuFull()
                                            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                                            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
                                            SetVehicleEngineOn(veh, true, true)
                                        end, coords, true)
                                    end
                                end
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["boat"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 7.5) then
                        if onDuty then
                            DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                    DrawText3D(v.x, v.y, v.z, "~r~E~w~ Store the boat")
                                else
                                    DrawText3D(v.x, v.y, v.z, "~r~E~w~ Spawn Boat")
                                end
                                if IsControlJustReleased(0, Keys["E"]) then
                                    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                        RLCore.Functions.DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                                    else
                                        local coords = Config.Locations["boat"][k]
                                        if not IsModelValid(Config.Boat) then
                                            RLCore.Functions.Notify("Invaild Vehicle Model", "error")
                                            return false
                                        end

                                        RLCore.Functions.SpawnVehicle(Config.Boat, function(veh)
                                            SetVehicleNumberPlateText(veh, "BOAT"..tostring(math.random(1000, 9999)))
                                            SetEntityHeading(veh, coords.h)
                                            exports['lj-fuel']:SetFuel(veh, 100)
                                            closeMenuFull()
                                            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                                            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
                                            SetVehicleEngineOn(veh, true, true)
                                        end, coords, true)
                                    end
                                end
                            end  
                        end
                    end
                end

                --[[ for k, v in pairs(Config.Locations["armory"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 4.5) then
                        if onDuty then
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                                DrawText3D(v.x, v.y, v.z, "~r~E~w~ Weapon safe")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    local items = GenerateItemsForGrade(PlayerJob.grade.level)
                                    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", items)
                                end
                            end  
                        end
                    end
                end ]]

                --[[ for k, v in pairs(Config.Locations["vest"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 4.5) then
                        if onDuty then
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                                DrawText3D(v.x, v.y, v.z, "~r~E~w~ Use Vest")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    local playerPed = PlayerPedId()
                                    Citizen.Wait(2500)
                                    SetPedArmour(playerPed, 100)
                                end
                            end  
                        end
                    end
                end ]]

                for k, v in pairs(Config.Locations["jail"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 4.5) then
                        if onDuty then
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                                DrawText3D(v.x, v.y, v.z, "~r~E~w~ Weapon safe")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    local items = GenerateItemsForGradeJail(PlayerJob.grade.level)
                                    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", items)
                                end
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["stash"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 4.5) then
                        if onDuty then
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                                DrawText3D(v.x, v.y, v.z,"~r~E~w~ Open Personal Locker")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "policestash_"..RLCore.Functions.GetPlayerData().citizenid)
                                    TriggerEvent("inventory:client:SetCurrentStash", "policestash_"..RLCore.Functions.GetPlayerData().citizenid)
                                end
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["fingerprint"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 4.5) then
                        if onDuty then
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                                DrawText3D(v.x, v.y, v.z, "~r~E~w~ Scan fingerprint")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    local player, distance = GetClosestPlayer()
                                    if player ~= -1 and distance < 2.5 then
                                        local playerId = GetPlayerServerId(player)
                                        TriggerServerEvent("police:server:showFingerprint", playerId)
                                    else
                                        RLCore.Functions.Notify("No one around!", "error")
                                    end
                                end
                            end  
                        end
                    end
                end

               --[[  for k, v in pairs(Config.Locations["boss"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 4.5) then
                        if onDuty and PlayerJob.isboss then
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                DrawText3D(v.x, v.y, v.z, "~r~E~w~ Boss Menu")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    TriggerServerEvent("bb-bossmenu:server:openMenu")
                                end
                            end  
                        end
                    end
                end ]]
            else
                Citizen.Wait(2000)
            end
        end
    end
end)

function WeaponAlreadyInArmory(items, nna)
    for k, v in pairs(items) do
        if v.name == nna then
            return true
        end
    end
    return false
end

function GenerateItemsForGrade(grade)
    local playerArmoryItems = Config.Items
    local grade = tonumber(grade) ~= nil and tonumber(grade) or 1
    if grade > 1 then
        if not WeaponAlreadyInArmory(playerArmoryItems.items, "weapon_smg") then
            playerArmoryItems.items[#playerArmoryItems.items + 1] = {
                name = "weapon_smg",
                price = 0,
                amount = 1,
                info = {
                    serie = "",                
                    attachments = {
                        {component = "COMPONENT_AT_SCOPE_MACRO_02", label = "1x Scope"},
                        {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    }
                },
                type = "weapon",
                slot = #playerArmoryItems.items + 1,
            }

            playerArmoryItems.items[#playerArmoryItems.items + 1] = {
                name = "smg_ammo",
                price = 0,
                amount = 5,
                info = {},
                type = "item",
                slot = #playerArmoryItems.items + 1,
            }
        end
    end

    if grade > 4 then
        if not WeaponAlreadyInArmory(playerArmoryItems.items, "weapon_carbinerifle") then
            playerArmoryItems.items[#playerArmoryItems.items + 1] = {
                name = "weapon_carbinerifle",
                price = 0,
                amount = 1,
                info = {
                    serie = "",
                    attachments = {
                        {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                        {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "3x Scope"},
                    }
                },
                type = "weapon",
                slot = #playerArmoryItems.items + 1,
            }

            playerArmoryItems.items[#playerArmoryItems.items + 1] = {
                name = "rifle_ammo",
                price = 0,
                amount = 5,
                info = {},
                type = "item",
                slot = #playerArmoryItems.items + 1,
            }
        end
    end

    playerArmoryItems.slots = #playerArmoryItems.items

    for k, v in pairs(playerArmoryItems.items) do
        if v.type == 'weapon' then
            playerArmoryItems.items[k].info.serie = tostring(Config.RandomInt(2) .. Config.RandomStr(3) .. Config.RandomInt(1) .. Config.RandomStr(2) .. Config.RandomInt(3) .. Config.RandomStr(4))
        end
    end

    return playerArmoryItems
end

function GenerateItemsForGradeJail(grade)
    local playerArmoryItems = Config.JailItems
    local grade = tonumber(grade) ~= nil and tonumber(grade) or 1
    if grade > 1 then
        if not WeaponAlreadyInArmory(playerArmoryItems.items, "weapon_pumpshotgun") then
            playerArmoryItems.items[#playerArmoryItems.items + 1] = {
                name = "shotgun_ammo",
                price = 0,
                amount = 5,
                info = {},
                type = "item",
                slot = #playerArmoryItems.items + 1,
            }

            playerArmoryItems.items[#playerArmoryItems.items + 1] = {
                name = "medkit",
                price = 10,
                amount = 5,
                info = {},
                type = "item",
                slot = #playerArmoryItems.items + 1,
            }
        end
    end

    playerArmoryItems.slots = #playerArmoryItems.items

    for k, v in pairs(playerArmoryItems.items) do
        if v.type == 'weapon' then
            playerArmoryItems.items[k].info.serie = tostring(Config.RandomInt(2) .. Config.RandomStr(3) .. Config.RandomInt(1) .. Config.RandomStr(2) .. Config.RandomInt(3) .. Config.RandomStr(4))
        end
    end

    return playerArmoryItems
end

local inFingerprint = false
local FingerPrintSessionId = nil

RegisterNetEvent('police:client:showFingerprint')
AddEventHandler('police:client:showFingerprint', function(playerId)
    openFingerprintUI()
    FingerPrintSessionId = playerId
end)

RegisterNetEvent('police:client:showFingerprintId')
AddEventHandler('police:client:showFingerprintId', function(fid, name)
    SendNUIMessage({
        type = "updateFingerprintId",
        fingerprintId = fid,
        name = name
    })
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNUICallback('doFingerScan', function(data)
    TriggerServerEvent('police:server:showFingerprintId', FingerPrintSessionId)
end)

function openFingerprintUI()
    SendNUIMessage({
        type = "fingerprintOpen"
    })
    inFingerprint = true
    SetNuiFocus(true, true)
end

RegisterNUICallback('closeFingerprint', function()
    SetNuiFocus(false, false)
    inFingerprint = false
end)

RegisterNetEvent('police:client:SendEmergencyMessage')
AddEventHandler('police:client:SendEmergencyMessage', function(message)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    
    TriggerServerEvent("police:server:SendEmergencyMessage", coords, message)
    TriggerEvent("police:client:CallAnim")
end)

RegisterNetEvent('police:client:EmergencySound')
AddEventHandler('police:client:EmergencySound', function()
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNetEvent('police:client:CallAnim')
AddEventHandler('police:client:CallAnim', function()
    local isCalling = true
    local callCount = 5
    loadAnimDict("cellphone@")   
    TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 3.0, -1, -1, 49, 0, false, false, false)
    Citizen.Wait(1000)
    Citizen.CreateThread(function()
        while isCalling do
            Citizen.Wait(1000)
            callCount = callCount - 1
            if callCount <= 0 then
                isCalling = false
                StopAnimTask(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 1.0)
            end
        end
    end)
end)

RegisterNetEvent('police:client:ImpoundVehicle')
AddEventHandler('police:client:ImpoundVehicle', function(fullImpound, price)
    local vehicle = RLCore.Functions.GetClosestVehicle()
    if vehicle ~= 0 and vehicle ~= nil then
        local pos = GetEntityCoords(GetPlayerPed(-1))
        local vehpos = GetEntityCoords(vehicle)
        if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 5.0) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
            local plate = GetVehicleNumberPlateText(vehicle)
			local ped = GetPlayerPed(-1)
			TaskStartScenarioInPlace(ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
			Progressbar(5000,"Impounding")
            TriggerServerEvent("police:server:Impound", plate, fullImpound, price)
            RLCore.Functions.DeleteVehicle(vehicle)
        end
    end
end)

function Progressbar(duration, label)
	local retval = nil
	RLCore.Functions.Progressbar("drugs", label, duration, false, false, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = false,
	}, {}, {}, {}, function()
		retval = true
	end, function()
		retval = false
	end)

	while retval == nil do
		Wait(1)
	end

	return retval
end

RegisterNetEvent('police:client:CheckStatus')
AddEventHandler('police:client:CheckStatus', function()
    RLCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.name == "police" then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                RLCore.Functions.TriggerCallback('police:GetPlayerStatus', function(result)
                    if result ~= nil then
                        for k, v in pairs(result) do
                            TriggerEvent("chatMessage", "STATUS", "warning", v)
                        end
                    end
                end, playerId)
            end
        end
    end)
end)

function MenuImpound()
    ped = GetPlayerPed(-1);
    MenuTitle = "Impound"
    ClearMenu()
    Menu.addButton("Vehicles", "ImpoundVehicleList", nil)
    Menu.addButton("Close Menu", "closeMenuFull", nil) 
end

function ImpoundVehicleList()
    RLCore.Functions.TriggerCallback("police:GetImpoundedVehicles", function(result)
        ped = GetPlayerPed(-1);
        MenuTitle = "Vehicles:"
        ClearMenu()

        if result == nil then
            RLCore.Functions.Notify("There are no seized vehicles", "error", 5000)
            closeMenuFull()
        else
            for k, v in pairs(result) do
                enginePercent = round(v.engine / 10, 0)
                bodyPercent = round(v.body / 10, 0)
                currentFuel = v.fuel

                Menu.addButton(RLCore.Shared.Vehicles[v.vehicle]["name"], "TakeOutImpound", v, "Confiscated", " Motor: " .. enginePercent .. "%", " Body: " .. bodyPercent.. "%", " Fuel: "..currentFuel.. "%")
            end
        end
            
        Menu.addButton("Back", "MenuImpound",nil)
    end)
end

function TakeOutImpound(vehicle)
    enginePercent = round(vehicle.engine / 10, 0)
    bodyPercent = round(vehicle.body / 10, 0)
    currentFuel = vehicle.fuel
    local coords = Config.Locations["impound"][currentGarage]
    RLCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
        RLCore.Functions.TriggerCallback('rl-garage:server:GetVehicleProperties', function(properties)
            RLCore.Functions.SetVehicleProperties(veh, properties)
            SetVehicleNumberPlateText(veh, vehicle.plate)
            SetEntityHeading(veh, coords.h)
            exports['rl-hud']:SetFuel(veh, vehicle.fuel)
            doCarDamage(veh, vehicle)
            closeMenuFull()
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
            SetVehicleEngineOn(veh, true, true)
        end, vehicle.plate)
    end, coords, true)
end

function MenuOutfits()
    ped = GetPlayerPed(-1);
    MenuTitle = "Outfits"
    ClearMenu()
    Menu.addButton("My Outfits", "OutfitsLijst", nil)
    Menu.addButton("Close Menu", "closeMenuFull", nil) 
end

function changeOutfit()
    Wait(200)
    loadAnimDict("clothingshirt")       
    TaskPlayAnim(GetPlayerPed(-1), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Wait(3100)
    TaskPlayAnim(GetPlayerPed(-1), "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

function OutfitsLijst()
    RLCore.Functions.TriggerCallback('apartments:GetOutfits', function(outfits)
        ped = GetPlayerPed(-1);
        MenuTitle = "My Outfits :"
        ClearMenu()

        if outfits == nil then
            RLCore.Functions.Notify("You have no outfits saved...", "error", 3500)
            closeMenuFull()
        else
            for k, v in pairs(outfits) do
                Menu.addButton(outfits[k].outfitname, "optionMenu", outfits[k]) 
            end
        end
        Menu.addButton("Back", "MenuOutfits",nil)
    end)
end

function optionMenu(outfitData)
    ped = GetPlayerPed(-1);
    MenuTitle = "What now?"
    ClearMenu()

    Menu.addButton("Choose Outfit", "selectOutfit", outfitData) 
    Menu.addButton("Remove Outfit", "removeOutfit", outfitData) 
    Menu.addButton("Back", "OutfitsLijst",nil)
end

function selectOutfit(oData)
    TriggerServerEvent('clothes:selectOutfit', oData.model, oData.skin)
    RLCore.Functions.Notify(oData.outfitname.." chosen", "success", 2500)
    closeMenuFull()
    changeOutfit()
end

function removeOutfit(oData)
    TriggerServerEvent('clothes:removeOutfit', oData.outfitname)
    RLCore.Functions.Notify(oData.outfitname.." is removed", "success", 2500)
    closeMenuFull()
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
    if IsArmoryWhitelist() then
        for veh, label in pairs(Config.WhitelistedVehicles) do
            Menu.addButton(label, "TakeOutVehicle", veh, "Garage", " Motor: 100%", " Body: 100%", " Fuel: 100%")
        end
    end
        
    Menu.addButton("Back", "MenuGarage",nil)
end

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["vehicle"][currentGarage]

    if not IsModelValid(vehicleInfo) then
        RLCore.Functions.Notify("Invaild Vehicle Model", "error")
        return false
    end

    RLCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "PLZI"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.h)
        closeMenuFull()
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
        TriggerServerEvent("inventory:server:addTrunkItems", GetVehicleNumberPlateText(veh), Config.CarItems)
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
    return true
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end

function doCarDamage(currentVehicle, veh)
    smash = false
    damageOutside = false
    damageOutside2 = false 
    local engine = veh.engine + 0.0
    local body = veh.body + 0.0
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

function SetCarItemsInfo()
    local items = {}
    for k, item in pairs(Config.CarItems) do
        local itemInfo = RLCore.Shared.Items[item.name:lower()]
        items[item.slot] = {
            name = itemInfo["name"],
            amount = tonumber(item.amount),
            info = item.info,
            label = itemInfo["label"],
            description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
            weight = itemInfo["weight"], 
            type = itemInfo["type"], 
            unique = itemInfo["unique"], 
            useable = itemInfo["useable"], 
            image = itemInfo["image"],
            slot = item.slot,
        }
    end
    Config.CarItems = items
end

function IsArmoryWhitelist()
    local playerData = RLCore.Functions.GetPlayerData().job
    if playerData.isowner == true then
        return true
    end
    
    return false
end

function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

RegisterCommand( "unseat_nearest_player", function()
    if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
        if PlayerJob.name == "police" or PlayerJob.name == "ambulance" then
            TriggerEvent("police:client:SetPlayerOutVehicle")
        end
    end
end ) 

RegisterCommand( "seat_nearest_player", function()
    if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
        if PlayerJob.name == "police" or PlayerJob.name == "ambulance" then
            TriggerEvent("police:client:PutPlayerInVehicle")
        end
    end
end ) 

RegisterCommand( "escort_nearest_player", function()
    if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
        if PlayerJob.name == "police" or PlayerJob.name == "ambulance" then
            TriggerEvent("police:client:EscortPlayer")
        end
    end
end ) 

RegisterKeyMapping( "unseat_nearest_player", "Unseat nearest (EMERGENCY)", "keyboard", "")
RegisterKeyMapping( "seat_nearest_player", "Seat nearest (EMERGENCY)", "keyboard", "")
RegisterKeyMapping( "escort_nearest_player", "Escort Nearest (EMERGENCY)", "keyboard", "")


RegisterNetEvent('police:duty', function()
    exports['qb-menu']:openMenu({ 
        {
            id = 1,
            header = "Set Your Status",
            txt = ""
        },
        {
            id = 2,
            header = "Clock In",
            txt = "Start Work",
            params = {
                event = "police:client:on",
            }
        },
        {
            id = 3,
            header = "Clock Out",
            txt = "Time For Some Netflix",
            params = {
                event = "police:client:off",
            }
        },        
    })
end)

RegisterNetEvent('police:client:on')
AddEventHandler('police:client:on', function()
    TriggerServerEvent('RLCore:ToggleDuty:on')
end)

RegisterNetEvent('police:client:off')
AddEventHandler('police:client:off', function()
    TriggerServerEvent('RLCore:ToggleDuty:off')
end)
