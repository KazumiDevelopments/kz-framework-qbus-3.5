local currentHospital = 1
local menuItem = {}

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
      SetTextScale(0.30, 0.30)
      SetTextFont(4)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 215)
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      DrawText(_x,_y)
      local factor = (string.len(text)) / 370
      DrawRect(_x,_y+0.0120, factor, 0.026, 41, 11, 41, 68)
    end
end

Citizen.CreateThread(function()
    for k, v in pairs(Config.Vehicles) do
        menuItem[#menuItem + 1] = {
            title = v,
            description = "Take out " .. v,
            event = "rl-ems:client:takeOutVehicle",
            eventType = "client",
            args = {
                ["model"] = k
            },
            close = true,
            func = function()
                return true;
            end
        }
    end
end)

RegisterNetEvent('rl-ems:client:toggleDuty', function()
    onDuty = not onDuty
    TriggerServerEvent("RLCore:ToggleDuty")
    TriggerServerEvent("police:server:UpdateBlips")
end)

RegisterNetEvent('rl-ems:client:openStash', function()
    if onDuty then
        TriggerEvent("InteractSound_CL:PlayOnOne","zipper",0.5)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "emsstash_"..RLCore.Functions.GetPlayerData().citizenid)
        TriggerEvent("inventory:client:SetCurrentStash", "emsstash_"..RLCore.Functions.GetPlayerData().citizenid)
    end
end)

RegisterNetEvent('rl-ems:client:openBossMenu', function()
    if onDuty then
        TriggerServerEvent("rl-bossmenu:server:openMenu")
    end
end)

RegisterNetEvent('rl-ems:client:openArmory', function()
    if onDuty then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "hospital", Config.Items)
    end
end)

RegisterNetEvent('rl-ems:client:toRoof', function()
    Progressbar(10000,"Waiting For Elevator")
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end

    local coords = Config.Locations["roof"][currentHospital]
    SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, false)
    SetEntityHeading(PlayerPedId(), coords.h)

    Citizen.Wait(100)

    DoScreenFadeIn(1000)
end)

RegisterNetEvent('rl-ems:client:toMain', function()
    Progressbar(10000,"Waiting For Elevator")
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end

    local coords = Config.Locations["main"][currentHospital]
    SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, false)
    SetEntityHeading(PlayerPedId(), coords.h)

    Citizen.Wait(100)

    DoScreenFadeIn(1000)
end)

RegisterNetEvent('rl-ems:client:toBottom', function()
    Progressbar(10000,"Waiting For Elevator")
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end

    local coords = Config.Locations["bottom"][currentHospital]
    SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 0, 0, 0, false)
    SetEntityHeading(PlayerPedId(), coords.h)

    Citizen.Wait(100)

    DoScreenFadeIn(1000)
end)

local currentGarage = 1
Citizen.CreateThread(function()

    for k, v in pairs(Config.Locations["duty"]) do
        exports['qb-target']:AddBoxZone("emsduty"..k, vector3(v.x, v.y, v.z), v.l, v.w, {
            name = "emsduty"..k,
            heading = v.h,
            debugPoly = false,
            minZ = v.minZ,
            maxZ = v.maxZ,
        }, {
            options = {
                {
                    event = 'rl-ems:client:toggleDuty',
                    icon = 'far fa-clipboard',
                    label = 'Toggle Duty',
                    job = {['ambulance'] = 0, ['doctor'] = 0}
                }
            },
            distance = 2.0
        })
    end

    for k, v in pairs(Config.Locations["stash"]) do
        exports['qb-target']:AddBoxZone("emsstash"..k, vector3(v.x, v.y, v.z), v.l, v.w, {
            name = "emsstash"..k,
            heading = v.h,
            debugPoly = false,
            minZ = v.minZ,
            maxZ = v.maxZ,
        }, {
            options = {
                {
                    event = 'rl-ems:client:openStash',
                    icon = 'fas fa-box',
                    label = 'Personal Locker',
                    job = {['ambulance'] = 0, ['doctor'] = 0}
                }
            },
            distance = 2.0
        })
    end

    --[[ for k, v in pairs(Config.Locations["boss"]) do
        exports['qb-target']:AddBoxZone("emsbossmenu"..k, vector3(v.x, v.y, v.z), v.l, v.w, {
            name = "emsbossmenu"..k,
            heading = v.h,
            debugPoly = false,
            minZ = v.minZ,
            maxZ = v.maxZ,
        }, {
            options = {
                {
                    event = 'rl-ems:client:openBossMenu',
                    icon = 'fas fa-user-tie',
                    label = 'Boss Menu',
                    job = {['ambulance'] = 0, ['doctor'] = 0},
                    canInteract = function()
                        if PlayerJob.isboss then
                            return true
                        else
                            return false
                        end
                    end,
                }
            },
            distance = 2.0
        })
    end ]]

    --[[ for k, v in pairs(Config.Locations["armory"]) do
        exports['qb-target']:AddBoxZone("emsarmory"..k, vector3(v.x, v.y, v.z), v.l, v.w, {
            name = "emsarmory"..k,
            heading = v.h,
            debugPoly = false,
            minZ = v.minZ,
            maxZ = v.maxZ,
        }, {
            options = {
                {
                    event = 'rl-ems:client:openArmory',
                    icon = 'far fa-clipboard',
                    label = 'Hospital Safe',
                    job = {['ambulance'] = 0, ['doctor'] = 0},
                }
            },
            distance = 2.0
        })
    end ]]

    exports['qb-target']:AddBoxZone('emsclothingoutfits', vector3(300.2009, -598.8107, 43.27745), 1.5, 2.5, {
        name = 'emsclothingoutfits',
        heading = 250.0,
        debugPoly = false,
        minZ = 42.0,
        maxZ = 44.4
    }, {
        options = {
            {
                action = function()
                    TriggerServerEvent("clothing:checkMoney", "clothesmenu")
                end,
                icon = 'fas fa-tshirt',
                label = 'Change Clothes',
                job = {['ambulance'] = 0, ['doctor'] = 0},
            },
            {
                type = "command",
                event = 'outfits',
                icon = 'fas fa-clipboard-list',
                label = 'Manage Outfits',
                job = {['ambulance'] = 0, ['doctor'] = 0},
            }
        },
        distance = 2.5
    })

    exports['qb-target']:AddBoxZone("emselevatormain", vector3(332.45095, -595.6943, 43.284053), 0.7, 2.5, {
        name = "emselevatormain",
        heading = 70.0,
        debugPoly = false,
        minZ = 42.5,
        maxZ = 44.6,
    }, {
        options = {
            {
                event = 'rl-ems:client:toRoof',
                icon = 'fas fa-arrow-circle-up',
                label = 'Elevator to roof',
            },
            {
                event = 'rl-ems:client:toBottom',
                icon = 'fas fa-arrow-circle-down',
                label = 'Elevator to bottom',
            }
        },
        distance = 2.0
    })

    exports['qb-target']:AddBoxZone("emselevatorroof", vector3(338.54479, -583.7456, 74.161705), 0.7, 2.8, {
        name = "emselevatorroof",
        heading = 250.0,
        debugPoly = false,
        minZ = 73.3,
        maxZ = 75.4,
    }, {
        options = {
            {
                event = 'rl-ems:client:toMain',
                icon = 'fas fa-arrow-circle-down',
                label = 'Elevator to main',
            }
        },
        distance = 2.0
    })

    exports['qb-target']:AddBoxZone("emselevatorroof", vector3(345.7102, -580.8406, 28.797988), 0.2, 0.2, {
        name = "emselevatorroof",
        heading = 250.0,
        debugPoly = false,
        minZ = 29.0,
        maxZ = 29.4,
    }, {
        options = {
            {
                event = 'rl-ems:client:toMain',
                icon = 'fas fa-arrow-circle-up',
                label = 'Elevator to main',
            }
        },
        distance = 2.0
    })

    while true do
        Citizen.Wait(1)
        if isLoggedIn then
            local pos = GetEntityCoords(PlayerPedId())
            if PlayerJob.name == "doctor" or PlayerJob.name == "ambulance" then

                for k, v in pairs(Config.Locations["vehicle"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 4.5) then
                        DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                            if IsPedInAnyVehicle(PlayerPedId(), false) then
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Store the vehicle")
                            else
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Vehicles")
                            end
                            if IsControlJustReleased(0, Keys["E"]) then
                                if IsPedInAnyVehicle(PlayerPedId(), false) then
                                    RLCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                                else
                                    exports["qb-menu"]:openMenu(menuItem)
                                end
                            end
                            Menu.renderGUI()
                        end
                    end
                end

                for k, v in pairs(Config.Locations["helicopter"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 7.5) then
                        if onDuty then
                            DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                if IsPedInAnyVehicle(PlayerPedId(), false) then
                                    DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Store the helicopter")
                                else
                                    DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Spawn Helicopter")
                                end
                                if IsControlJustReleased(0, Keys["E"]) then
                                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                                        RLCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                                    else
                                        local coords = Config.Locations["helicopter"][k]
                                        RLCore.Functions.SpawnVehicle(Config.Helicopter, function(veh)
                                            SetVehicleLivery(veh, 1)
                                            SetVehicleNumberPlateText(veh, "LIFE"..tostring(math.random(1000, 9999)))
                                            SetEntityHeading(veh, coords.h)
                                            exports['LegacyFuel']:SetFuel(veh, 100)
                                            closeMenuFull()
                                            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                                            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
                                            SetVehicleEngineOn(veh, true, true)
                                        end, coords, true)
                                    end
                                end
                            end
                        end
                    end
                end
            else
                Wait(2800)
            end

            currentHospital = 1

            for k, v in pairs(Config.Locations["main"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z))
                if dist < 10.0 then
                    currentHospital = k
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if isStatusChecking then
            for k, v in pairs(statusChecks) do
                local x,y,z = table.unpack(GetPedBoneCoords(statusCheckPed, v.bone))
                DrawText3D(x, y, z, v.label)
            end
        end

        if isHealingPerson then
            if not IsEntityPlayingAnim(PlayerPedId(), healAnimDict, healAnim, 3) then
                loadAnimDict(healAnimDict)	
                TaskPlayAnim(PlayerPedId(), healAnimDict, healAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
        end
    end
end)

RegisterNetEvent('hospital:client:SendAlert')
AddEventHandler('hospital:client:SendAlert', function(msg)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
    TriggerEvent("chatMessage", "PAGER", "error", msg)
end)

RegisterNetEvent("ems:stash")
AddEventHandler("ems:stash", function()
    if PlayerJob.name ~= 'ambulance' then return RLCore.Functions.Notify("You're not EMS lmfao..", "error") end
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "emsstash_"..RLCore.Functions.GetPlayerData().citizenid)
    TriggerEvent("inventory:client:SetCurrentStash", "emsstash_"..RLCore.Functions.GetPlayerData().citizenid)
end)

RegisterNetEvent("ems:duty")
AddEventHandler("ems:duty", function()
    if PlayerJob.name ~= 'ambulance' then return RLCore.Functions.Notify("You're not EMS lmfao..", "error") end
    TriggerServerEvent("RLCore:ToggleDuty")
    TriggerServerEvent("police:server:UpdateBlips")
end)

RegisterNetEvent("ems:armory")
AddEventHandler("ems:armory", function()
    if PlayerJob.name ~= 'ambulance' then return RLCore.Functions.Notify("You're not EMS lmfao..", "error") end
TriggerServerEvent("inventory:server:OpenInventory", "shop", "hospital", Config.Items)
end)

RegisterNetEvent('hospital:client:AiCall')
AddEventHandler('hospital:client:AiCall', function()
    local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(PlayerPeds, ped)
    end
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    local closestPed, closestDistance = RLCore.Functions.GetClosestPed(coords, PlayerPeds)
    local gender = RLCore.Functions.GetPlayerData().gender
    if closestDistance < 50.0 and closestPed ~= 0 then
        MakeCall(closestPed, gender)
    end
end)

function MakeCall(ped, male)
    local callAnimDict = "cellphone@"
    local callAnim = "cellphone_call_listen_base"
    local rand = (math.random(6,9) / 100) + 0.3
    local rand2 = (math.random(6,9) / 100) + 0.3
    local coords = GetEntityCoords(PlayerPedId())
    local blipsettings = {
        x = coords.x,
        y = coords.y,
        z = coords.z,
        sprite = 280,
        color = 4,
        scale = 0.9,
        text = "Injured person"
    }

    if math.random(10) > 5 then
        rand = 0.0 - rand
    end

    if math.random(10) > 5 then
        rand2 = 0.0 - rand2
    end

    local moveto = GetOffsetFromEntityInWorldCoords(PlayerPedId(), rand, rand2, 0.0)

    TaskGoStraightToCoord(ped, moveto, 2.5, -1, 0.0, 0.0)
    SetPedKeepTask(ped, true) 

    local dist = GetDistanceBetweenCoords(moveto, GetEntityCoords(ped), false)

    while dist > 3.5 and isDead do
        TaskGoStraightToCoord(ped, moveto, 2.5, -1, 0.0, 0.0)
        dist = GetDistanceBetweenCoords(moveto, GetEntityCoords(ped), false)
        Citizen.Wait(100)
    end

    ClearPedTasksImmediately(ped)
    TaskLookAtEntity(ped, PlayerPedId(), 5500.0, 2048, 3)
    TaskTurnPedToFaceEntity(ped, PlayerPedId(), 5500)

    Citizen.Wait(3000)

    --TaskStartScenarioInPlace(ped,"WORLD_HUMAN_STAND_MOBILE", 0, 1)
    loadAnimDict(callAnimDict)
    TaskPlayAnim(ped, callAnimDict, callAnim, 1.0, 1.0, -1, 49, 0, 0, 0, 0)

    SetPedKeepTask(ped, true) 

    Citizen.Wait(5000)

    TriggerServerEvent("hospital:server:MakeDeadCall", blipsettings, male)

    SetEntityAsNoLongerNeeded(ped)
    ClearPedTasks(ped)
end

RegisterNetEvent('hospital:client:RevivePlayer')
AddEventHandler('hospital:client:RevivePlayer', function()
    RLCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerJob.name == "ambulance" then
            local player, distance = RLCore.Functions.GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                isHealingPerson = true
                RLCore.Functions.Progressbar("hospital_revive", "Help person up..", 5000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = healAnimDict,
                    anim = healAnim,
                    flags = 16,
                }, {}, {}, function() -- Done
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    RLCore.Functions.Notify("You helped the person!")
                    TriggerServerEvent("hospital:server:RevivePlayer", playerId)
                end, function() -- Cancel
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    RLCore.Functions.Notify("Failed!", "error")
                end)
            end
        end
    end)
end)

RegisterNetEvent('hospital:client:CheckStatus')
AddEventHandler('hospital:client:CheckStatus', function()
    RLCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerJob.name == "doctor" or PlayerJob.name == "ambulance" or PlayerJob.name == "police" then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                statusCheckPed = GetPlayerPed(player)
            end
        end
    end)
end)

RegisterNetEvent('hospital:client:TreatWounds')
AddEventHandler('hospital:client:TreatWounds', function()
    RLCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.name == "doctor" or PlayerData.job.name == "ambulance" then
            local player, distance = RLCore.Functions.GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                isHealingPerson = true
                RLCore.Functions.Progressbar("hospital_heal", "Healing", 6000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = healAnimDict,
                    anim = healAnim,
                    flags = 16,
                }, {}, {}, function() -- Done
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    RLCore.Functions.Notify("You helped the person!")
                    TriggerServerEvent("hospital:server:TreatWounds", playerId)
                end, function() -- Cancel
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    RLCore.Functions.Notify("Failed!", "error")
                end)
            end
        end
    end)
end)

function MenuGarage(isDown)
    ped = PlayerPedId();
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Vehicles", "VehicleList", isDown)
    Menu.addButton("Close Menu", "closeMenuFull", nil) 
end

function VehicleList(isDown)
    ped = PlayerPedId();
    MenuTitle = "Vehicles:"
    ClearMenu()

    for k, v in pairs(Config.Vehicles) do
        Menu.addButton(Config.Vehicles[k], "TakeOutVehicle", {k, isDown}, "Garage", " Motor: 100%", " Body: 100%", " Fuel: 100%")
    end
        
    Menu.addButton("Back", "MenuGarage",nil)
end

RegisterNetEvent("rl-ems:client:takeOutVehicle", function(data)
    if(currentGarage ~= nil) then
        local coords = Config.Locations["vehicle"][currentGarage]

        if not IsModelValid(data.model) then
            RLCore.Functions.Notify("Invaild Vehicle Model", "error")
            return false
        end
    
        RLCore.Functions.SpawnVehicle(data.model, function(veh)
            SetVehicleNumberPlateText(veh, "AMBU"..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, coords.h)
            exports['LegacyFuel']:SetFuel(veh, 100)
            closeMenuFull()
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
            SetVehicleEngineOn(veh, true, true)
        end, coords, true)
    end
end)

function TakeOutVehicle(model)
    local coords = Config.Locations["vehicle"][currentGarage]

    if not IsModelValid(model) then
        RLCore.Functions.Notify("Invaild Vehicle Model", "error")
        return false
    end

    RLCore.Functions.SpawnVehicle(model, function(veh)
        SetVehicleNumberPlateText(veh, "AMBU"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.h)
        exports['LegacyFuel']:SetFuel(veh, 100)
        closeMenuFull()
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)

    return true
end

function closeMenuFull()
    Menu.hidden = true
    ClearMenu()
end

function Progressbar(duration, label)
	local retval = nil
	RLCore.Functions.Progressbar("ems", label, duration, false, false, {
		disableMovement = true,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
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