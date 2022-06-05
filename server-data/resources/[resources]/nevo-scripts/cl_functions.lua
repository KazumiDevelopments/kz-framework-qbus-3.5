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

function DrawText3Ds(x,y,z, text)
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

local EventsTimer = {}
Citizen.CreateThread(function()
    local plyPed, plyCoords, inVehicle, lastVehicle, lastArmour, lastHealth, lastPed, lastInvincible = PlayerPedId(), GetEntityCoords(plyPed), IsPedInAnyVehicle(plyPed), 0, 0, 0, 0, false

    while true do
        Citizen.Wait(10)
        plyID = PlayerId()
        plyPed = PlayerPedId()
        plyCoords = GetEntityCoords(plyPed)
        inVehicle = IsPedInAnyVehicle(plyPed)
        invincible = GetPlayerInvincible(plyID)

        if invincible ~= lastInvincible then
            lastInvincible = invincible
            TriggerEvent('debug', 'System: RLCore:onInvincibleUpdate (' .. tostring(lastInvincible) .. ')', 'normal')
            TriggerEvent('RLCore:onInvincibleUpdate', lastInvincible)
        end

        if plyPed ~= lastPed then
            lastPed = plyPed
            TriggerEvent('debug', 'System: RLCore:onPedUpdate (' .. lastPed .. ')', 'normal', "fas fa-walking")
            TriggerEvent('RLCore:onPedUpdate', lastPed)
        end

        if GetEntityHealth(plyPed) ~= lastHealth then
            lastHealth = GetEntityHealth(plyPed)
            TriggerEvent('debug', 'System: RLCore:onHealthUpdate (' .. lastHealth .. ')', 'normal', 'fas fa-heartbeat')
            TriggerEvent('RLCore:onHealthUpdate', lastHealth)
        end

        if GetPedArmour(plyPed) ~= lastArmour then
            lastArmour = GetPedArmour(plyPed)
            TriggerEvent('debug', 'System: RLCore:onArmourUpdate (' .. lastArmour .. ')', 'normal', "fas fa-shield-alt")
            TriggerEvent('RLCore:onArmourUpdate', lastArmour)
        end

        if inVehicle then
            lastVehicle = GetVehiclePedIsIn(PlayerPedId())
            if not EventsTimer['RLCore:onEnterVehicle'] then
                EventsTimer['RLCore:onEnterVehicle'] = true
                TriggerEvent('debug', 'System: RLCore:onEnterVehicle (' .. lastVehicle .. ')', 'normal', "fas fa-car-alt")
                TriggerEvent('RLCore:onEnterVehicle', lastVehicle)
            end
        else
            if EventsTimer['RLCore:onEnterVehicle'] then
                EventsTimer['RLCore:onEnterVehicle'] = false
                TriggerEvent('debug', 'System: RLCore:onLeaveVehicle (' .. lastVehicle .. ')', 'error', "fas fa-car-alt")
                TriggerEvent('RLCore:onLeaveVehicle', lastVehicle)
            end
        end

        if not HasCollisionLoadedAroundEntity(plyPed) then
            RequestCollisionAtCoord(plyCoords.x, plyCoords.y, plyCoords.z)
        end
    end
end)

function Draw3DText(x,y,z, text)
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

local coords = { x = 2438.47, y = 4960.79, z = 46, h = 43.69 }, { x = -1144.0, y = 4908.53, z = 220.97, h = 213.16 }

CreateThread(function()
    TriggerServerEvent("nevo:discord")
    while true do
        TriggerServerEvent('nevo:uptime')
        Wait(15 * 1000)
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local plyCoords = GetEntityCoords(PlayerPedId(), 0)
        local distance = #(vector3(coords.x, coords.y, coords.z) - plyCoords)
        if distance < 10 then
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if distance < 3 then
			        Draw3DText(coords.x, coords.y, coords.z + 0.5, '[E] - Check In ($450)')
                        if IsControlJustReleased(0, 38) then
                            DisableControlAction(0, 38, true)
                            if (GetEntityHealth(PlayerPedId()) <= 200) then
                                TriggerEvent('animations:client:EmoteCommandStart', {"notepad"})
                                RLCore.Functions.Progressbar("grandmas_house", "Checking In", 10500, true, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    
                                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                                    StopAnimTask(GetPlayerPed(-1), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
                                    RLCore.Functions.Progressbar("grandmas_house", "Treating", 60000, false, false, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {}, {}, {}, function() -- Done
                                        TriggerEvent('hospital:client:Revive')
                                        TriggerServerEvent('hiddenheal:payBill')
                                        EnableControlAction(0, 38, true)
                                        EnableControlAction(0, 38, true)
                                        RLCore.Functions.Notify('You were billed For $450.')
                                    end, function()
                                        RLCore.Functions.Notify("Canceled.", "error")
                                    end)

                                end, function() -- Cancel
                                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                                    RLCore.Functions.Notify("Canceled.", "error")
                                end)
                            else
                                TriggerEvent('notification', 'You do not need medical attention', 2)
                            end
                        end
                    end
                end
            else
              Citizen.Wait(1000)
        end
    end
end)