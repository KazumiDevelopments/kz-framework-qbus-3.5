local inTrunk = false
local isKidnapped = false
local isKidnapping = false

local disabledTrunk = {
    [1] = "penetrator",
    [2] = "vacca",
    [3] = "monroe",
    [4] = "turismor",
    [5] = "osiris",
    [6] = "comet",
    [7] = "ardent",
    [8] = "jester",
    [9] = "nero",
    [10] = "nero2",
    [11] = "vagner",
    [12] = "infernus",
    [13] = "zentorno",
    [14] = "comet2",
    [15] = "comet3",
    [16] = "comet4",
    [17] = "lp700r",
    [18] = "r8ppi",
    [19] = "911turbos",
    [20] = "rx7rb",
    [21] = "fnfrx7",
    [22] = "delsoleg",
    [23] = "s15rb",
    [24] = "gtr",
    [25] = "fnf4r34",
    [26] = "ap2",
    [27] = "bullet",
}

function loadDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

function disabledCarCheck(veh)
    for i=1,#disabledTrunk do
        if GetEntityModel(veh) == GetHashKey(disabledTrunk[i]) then
            return true
        end
    end
    return false
end

RegisterNetEvent('rl-kidnapping:client:SetKidnapping')
AddEventHandler('rl-kidnapping:client:SetKidnapping', function(bool)
    isKidnapping = bool
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

local cam = nil

function getNearestVeh()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end

function TrunkCam(bool)
    local ped = GetPlayerPed(-1)
    local vehicle = GetEntityAttachedTo(PlayerPedId())
    local drawPos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -5.5, 0)

    local vehHeading = GetEntityHeading(vehicle)

    if bool then
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
        if not DoesCamExist(cam) then
            cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
            SetCamActive(cam, true)
            SetCamCoord(cam, drawPos.x, drawPos.y, drawPos.z + 2)
            SetCamRot(cam, -2.5, 0.0, vehHeading, 0.0)
            RenderScriptCams(true, false, 0, true, true)
        end
    else
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
        cam = nil
    end
end

Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        local vehicle = GetEntityAttachedTo(PlayerPedId())
        local drawPos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -5.5, 0)
    
        local vehHeading = GetEntityHeading(vehicle)

        if cam ~= nil then
            SetCamRot(cam, -2.5, 0.0, vehHeading, 0.0)
            SetCamCoord(cam, drawPos.x, drawPos.y, drawPos.z + 2)
        else
            Citizen.Wait(1000)
        end

        Citizen.Wait(1)
    end
end)

RegisterNetEvent('rl-trunk:client:KidnapTrunk')
AddEventHandler('rl-trunk:client:KidnapTrunk', function()
    closestPlayer, distance = RLCore.Functions.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if (distance ~= -1 and distance < 2) then
        if isKidnapping then
            local closestVehicle = getNearestVeh()
            if closestVehicle ~= 0 then
                TriggerEvent('police:client:KidnapPlayer')
                TriggerServerEvent("police:server:CuffPlayer", GetPlayerServerId(closestPlayer), false)
                Citizen.Wait(50)
                TriggerServerEvent("rl-trunk:server:KidnapTrunk", GetPlayerServerId(closestPlayer), closestVehicle)
            end
        else
            RLCore.Functions.Notify('You didn\'t kidnap this person!', 'error')
        end
    end
end)

RegisterNetEvent('rl-trunk:client:KidnapGetIn')
AddEventHandler('rl-trunk:client:KidnapGetIn', function(veh)
    local ped = GetPlayerPed(-1)
    local closestVehicle = veh
    local vehClass = GetVehicleClass(closestVehicle)
    local plate = GetVehicleNumberPlateText(closestVehicle)

    if TrunkClasses[vehClass].allowed then
        RLCore.Functions.TriggerCallback('rl-trunk:server:getTrunkBusy', function(isBusy)
            if not disabledCarCheck(closestVehicle) then
                if not inTrunk then
                    if not isBusy then
                        if not isKidnapped then
                            offset = {
                                x = TrunkClasses[vehClass].x,
                                y = TrunkClasses[vehClass].y,
                                z = TrunkClasses[vehClass].z,
                            }
                            loadDict("fin_ext_p1-7")
                            TaskPlayAnim(ped, "fin_ext_p1-7", "cs_devin_dual-7", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
                            AttachEntityToEntity(ped, closestVehicle, 0, offset.x, offset.y, offset.z, 0, 0, 40.0, 1, 1, 1, 1, 1, 1)
                            TriggerServerEvent('rl-trunk:server:setTrunkBusy', plate, true)
                            inTrunk = true
                            Citizen.Wait(500)
                            SetVehicleDoorShut(closestVehicle, 5, false)
                            RLCore.Functions.Notify('You are in the trunk', 'success', 4000)
                            TrunkCam(true)

                            isKidnapped = true
                        else
                            local ped = GetPlayerPed(-1)
                            local vehicle = GetEntityAttachedTo(PlayerPedId())
                            local plate = GetVehicleNumberPlateText(vehicle)
            
                            if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
                                local vehCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0, -5.0, 0)
                                DetachEntity(ped, true, true)
                                ClearPedTasks(ped)
                                inTrunk = false
                                TriggerServerEvent('rl-smallresources:trunk:server:setTrunkBusy', plate, nil)
                                SetEntityCoords(ped, vehCoords.x, vehCoords.y, vehCoords.z)
                                SetEntityCollision(PlayerPedId(), true, true)
                                TrunkCam(false)
                            else
                                RLCore.Functions.Notify('Is the trunk closed?', 'error', 2500)
                            end
                        end
                    else
                        RLCore.Functions.Notify('Already see someone in it?', 'error', 2500)
                    end 
                else
                    RLCore.Functions.Notify('You are already in the trunk', 'error', 2500)
                end 
            else
                RLCore.Functions.Notify('You cannot put this vehicle in the trunk', 'error', 2500)
            end
        end, plate)
    else
        RLCore.Functions.Notify('You cannot put this vehicle in the trunk', 'error', 2500)
    end
end)

RegisterNetEvent('rl-trunk:client:GetIn')
AddEventHandler('rl-trunk:client:GetIn', function(isKidnapped)
    local ped = GetPlayerPed(-1)
    local closestVehicle = getNearestVeh()

    if closestVehicle ~= 0 then
        local vehClass = GetVehicleClass(closestVehicle)
        local plate = GetVehicleNumberPlateText(closestVehicle)
        if TrunkClasses[vehClass].allowed then
            RLCore.Functions.TriggerCallback('rl-trunk:server:getTrunkBusy', function(isBusy)
                if not disabledCarCheck(closestVehicle) then
                    if not inTrunk then
                        if not isBusy then
                            if GetVehicleDoorAngleRatio(closestVehicle, 5) > 0 then
                                offset = {
                                    x = TrunkClasses[vehClass].x,
                                    y = TrunkClasses[vehClass].y,
                                    z = TrunkClasses[vehClass].z,
                                }
                                loadDict("fin_ext_p1-7")
                                TaskPlayAnim(ped, "fin_ext_p1-7", "cs_devin_dual-7", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
                                -- AttachEntityToEntity(ped, closestVehicle, -1, 0.0, -2.0, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                                AttachEntityToEntity(ped, closestVehicle, 0, offset.x, offset.y, offset.z, 0, 0, 40.0, 1, 1, 1, 1, 1, 1)
                                TriggerServerEvent('rl-trunk:server:setTrunkBusy', plate, true)
                                inTrunk = true
                                Citizen.Wait(500)
                                SetVehicleDoorShut(closestVehicle, 5, false)
                                RLCore.Functions.Notify('You are in the trunk.', 'success', 4000)
                                TrunkCam(true)
                            else
                                RLCore.Functions.Notify('Is the trunk closed?', 'error', 2500)
                            end
                        else
                            RLCore.Functions.Notify('Anyone in there yet?', 'error', 2500)
                        end 
                    else
                        RLCore.Functions.Notify('You are already in the trunk', 'error', 2500)
                    end 
                else
                    RLCore.Functions.Notify('You can\'t put this vehicle in the trunk ..', 'error', 2500)
                end
            end, plate)
        else
            RLCore.Functions.Notify('You can\'t put this vehicle in the trunk ..', 'error', 2500)
        end
    else
        RLCore.Functions.Notify('No vehicle to be seen ..', 'error', 2500)
    end
end)

Citizen.CreateThread(function()
    while true do

        if inTrunk then
            if not isKidnapped then
                local ped = GetPlayerPed(-1)
                local vehicle = GetEntityAttachedTo(PlayerPedId())
                local drawPos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                local plate = GetVehicleNumberPlateText(vehicle)

                if DoesEntityExist(vehicle) then
                    DrawText3Ds(drawPos.x, drawPos.y, drawPos.z + 0.75, '[E] To get out of the trunk')

                    if IsControlJustPressed(0, 38) then
                        if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
                            local vehCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0, -5.0, 0)
                            DetachEntity(ped, true, true)
                            ClearPedTasks(ped)
                            inTrunk = false
                            TriggerServerEvent('rl-trunk:server:setTrunkBusy', plate, false)
                            SetEntityCoords(ped, vehCoords.x, vehCoords.y, vehCoords.z)
                            SetEntityCollision(PlayerPedId(), true, true)
                            TrunkCam(false)
                        else
                            RLCore.Functions.Notify('Is the trunk closed?', 'error', 2500)
                        end
                    end

                    if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
                        DrawText3Ds(drawPos.x, drawPos.y, drawPos.z + 0.5, '[G] Close Trunk')
                        if IsControlJustPressed(0, 47) then
                            if not IsVehicleSeatFree(vehicle, -1) then
                                TriggerServerEvent('rl-radialmenu:trunk:server:Door', false, plate, 5)
                            else
                                SetVehicleDoorShut(vehicle, 5, false)
                            end
                        end
                    else
                        DrawText3Ds(drawPos.x, drawPos.y, drawPos.z + 0.5, '[G] Open Trunk')
                        if IsControlJustPressed(0, 47) then
                            if not IsVehicleSeatFree(vehicle, -1) then
                                TriggerServerEvent('rl-radialmenu:trunk:server:Door', true, plate, 5)
                            else
                                SetVehicleDoorOpen(vehicle, 5, false, false)
                            end
                        end
                    end
                end
            end
        end

        if not inTrunk then
            Citizen.Wait(1000)
        end

        Citizen.Wait(3)
    end
end)

RegisterNetEvent('vehicle:flipit')
AddEventHandler('vehicle:flipit', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = nil
    if IsPedInAnyVehicle(ped, false) then vehicle = GetVehiclePedIsIn(ped, false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end
        if DoesEntityExist(vehicle) then
        exports['progressbar']:Progress({
            name = "flipping_vehicle",
            duration = 20000,
            label = "Flipping Vehicle Over",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "random@mugging4",
                anim = "struggle_loop_b_thief",
                flags = 49,
            }
        }, function(status)

            local playerped = PlayerPedId()
            local coordA = GetEntityCoords(playerped, 1)
            local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
            local targetVehicle = getVehicleInDirection(coordA, coordB)
            SetVehicleOnGroundProperly(targetVehicle)
        end)
    else
        TriggerEvent('notification', "No vehicle nearby.", 2) 
    end
end)

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

RegisterNetEvent('police:client:AddWep')
AddEventHandler('police:client:AddWep', function()
    local player, distance = RLCore.Functions.GetClosestPlayer()
    if player ~= -1 then
        if distance < 2.5 then
            local playerId = GetPlayerServerId(player)
            TriggerServerEvent("police:server:AddWep", playerId)
        else
            RLCore.Functions.Notify("You aren't close enough to this person!", "error")
        end
    else
        RLCore.Functions.Notify("No one found!", "error")
    end
end)