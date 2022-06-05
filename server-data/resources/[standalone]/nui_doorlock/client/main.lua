local RLCore = exports['rl-core']:GetCoreObject()
local PlayerData = RLCore.Functions.GetPlayerData()
local Config = Config
local playerCoords, lastCoords, arg
local nearbyDoors, closestDoor = {}, {}
local playerPed = PlayerPedId()
local Started = false
local paused = false
local usingAdvanced = false

------------------------------
-- Functions
------------------------------

local function SetTextCoords(data)
    local minDimension, maxDimension = GetModelDimensions(data.objHash)
    local dimensions = maxDimension - minDimension
    local dx, dy = tonumber(dimensions.x), tonumber(dimensions.y)
    if dy <= -1 or dy >= 1 then dx = dy end
    if data.fixText then
        return GetOffsetFromEntityInWorldCoords(data.object, dx/2, 0, 0)
    else
        return GetOffsetFromEntityInWorldCoords(data.object, -dx/2, 0, 0)
    end
end

local function UpdateDoors(specificDoor)
    playerCoords = GetEntityCoords(playerPed)
    for doorID, data in pairs(Config.DoorList) do
        if (not specificDoor or doorID == specificDoor) then
            if data.doors then
                for k,v in pairs(data.doors) do
                    if #(playerCoords - v.objCoords) < 30 then
                        Wait(0)
                        v.object = GetClosestObjectOfType(v.objCoords, 1.0, v.objHash, false, false, false)
                        if data.delete then
                            SetEntityAsMissionEntity(v.object, 1, 1)
                            DeleteObject(v.object)
                            v.object = nil
                        end
                        if v.object then
                            v.doorHash = 'l_'..doorID..'_'..k
                            if not IsDoorRegisteredWithSystem(v.doorHash) then
                                AddDoorToSystem(v.doorHash, v.objHash, v.objCoords, false, false, false)
                                nearbyDoors[doorID] = true
                                if data.locked then
                                    if data.oldMethod then FreezeEntityPosition(v.object, true)
                                    else DoorSystemSetDoorState(v.doorHash, 4, false, false) DoorSystemSetDoorState(v.doorHash, 1, false, false) end
                                else
                                    DoorSystemSetDoorState(v.doorHash, 0, false, false) if data.oldMethod then FreezeEntityPosition(v.object, false) end
                                end
                            end
                        end
                    elseif v.object then RemoveDoorFromSystem(v.doorHash) nearbyDoors[doorID] = nil end
                end
            elseif not data.doors then
                if #(playerCoords - data.objCoords) < 30 then Wait(0)
                    if data.slides then data.object = GetClosestObjectOfType(data.objCoords, 5.0, data.objHash, false, false, false) else
                        data.object = GetClosestObjectOfType(data.objCoords, 1.0, data.objHash, false, false, false)
                    end
                    if data.delete then
                        SetEntityAsMissionEntity(data.object, 1, 1)
                        DeleteObject(data.object)
                        data.object = nil
                    end
                    if data.object then
                        data.doorHash = 'l_'..doorID
                        if not IsDoorRegisteredWithSystem(data.doorHash) then
                            AddDoorToSystem(data.doorHash, data.objHash, data.objCoords, false, false, false)
                            nearbyDoors[doorID] = true
                            if data.locked then
                                if data.oldMethod then FreezeEntityPosition(data.object, true)
                                else DoorSystemSetDoorState(data.doorHash, 4, false, false) DoorSystemSetDoorState(data.doorHash, 1, false, false) end
                            else
                                DoorSystemSetDoorState(data.doorHash, 0, false, false) if data.oldMethod then FreezeEntityPosition(data.object, false) end
                            end
                        end
                    end
                elseif data.object then RemoveDoorFromSystem(data.doorHash) nearbyDoors[doorID] = false end
            end
            -- set text coords
            if not data.setText and data.doors then
                for k,v in pairs(data.doors) do
                    if k == 1 and DoesEntityExist(v.object) then
                        data.textCoords = v.objCoords
                    elseif k == 2 and DoesEntityExist(v.object) and data.textCoords then
                        local textDistance = data.textCoords - v.objCoords
                        data.textCoords = (data.textCoords - (textDistance / 2))
                        data.setText = true
                    end
                    if k == 2 and data.textCoords and data.slides then
                        if GetEntityHeightAboveGround(v.object) < 1 then
                            data.textCoords = vec3(data.textCoords.x, data.textCoords.y, data.textCoords.z+1.2)
                        end
                    end
                end
            elseif not data.setText and not data.doors and DoesEntityExist(data.object) then
                if data.garage == true then
                    data.textCoords = data.objCoords
                    data.setText = true
                else
                    data.textCoords = SetTextCoords(data)
                    data.setText = true
                end
                if data.slides then
                    if GetEntityHeightAboveGround(data.object) < 1 then
                        data.textCoords = vec3(data.textCoords.x, data.textCoords.y, data.textCoords.z + 1.6)
                    end
                end
            end
        end
    end
    lastCoords = playerCoords
end

local function CheckAuth(doorData)
    local hasitem = promise.new()

    if doorData.authorizedJobs then
        if doorData.authorizedJobs[PlayerData.job.name] and PlayerData.job.grade.level >= doorData.authorizedJobs[PlayerData.job.name] then
            return true
        end
    end

    if doorData.authorizedGangs then
        if doorData.authorizedGangs[PlayerData.gang.name] and PlayerData.gang.grade.level >= doorData.authorizedGangs[PlayerData.gang.name] then
            return true
        end
    end

    if doorData.authorizedCIDs then
        return doorData.authorizedCIDs[PlayerData.citizenid]
    end

    if doorData.items then
        RLCore.Functions.TriggerCallback('nui_doorlock:server:CheckItems', function(result)
            hasitem:resolve(result)
        end, doorData.items, doorData.locked)
        return Citizen.Await(hasitem)
    end

    if (not doorData.authorizedJobs or not next(doorData.authorizedJobs)) and (not doorData.authorizedGangs or not next(doorData.authorizedGangs)) and (not doorData.authorizedCIDs or not next(doorData.authorizedCIDs)) and not doorData.items then
	    return true
    end

    return false
end

local function displayNUIText(text)
    local selectedColor = closestDoor.data.locked and Config.LockedColor or Config.UnlockedColor
    SendNUIMessage({type = "display", text = text, color = selectedColor})
    Wait(1)
end

local function hideNUI()
    SendNUIMessage({type = "hide"})
    Wait(1)
end

local function DoorLoop()
    Started = true
    RLCore.Functions.TriggerCallback('nui_doorlock:server:getDoorList', function(doorList)
        Config.DoorList = doorList
    end)
    Wait(250)
    UpdateDoors()
    while LocalPlayer.state['isLoggedIn'] do
        playerPed = PlayerPedId()
        playerCoords = GetEntityCoords(playerPed)
        local doorSleep = 100
        if not closestDoor.id then
            local distance = #(playerCoords - lastCoords)
            if distance > 15 then
                UpdateDoors()
                doorSleep = 1000
            else
                closestDoor.distance = 15
                for k in pairs(nearbyDoors) do
                    local door = Config.DoorList[k]
                    if door.setText and door.textCoords then
                        distance = #(door.textCoords - playerCoords)
                        if distance < closestDoor.distance or 10 then
                            if distance < door.maxDistance then
                                closestDoor = {distance = distance, id = k, data = door}
                                doorSleep = 0
                            end
                        end
                    end
                end
            end
        end
        if closestDoor.id then
            while true do
                if Config.Debug then print(json.encode(closestDoor)) end
                if not paused and IsPauseMenuActive() then hideNUI() paused = true
                elseif paused then if not IsPauseMenuActive() then paused = false end
                else
                    playerCoords = GetEntityCoords(playerPed)
                    closestDoor.distance = #(closestDoor.data.textCoords - playerCoords)
                    if closestDoor.distance < closestDoor.data.maxDistance then
                        local canOpen = CheckAuth(closestDoor.data)
                        if not closestDoor.data.locked and not canOpen then
                            if Config.ShowUnlockedText and (closestDoor.data.showNUI == nil or closestDoor.data.showNUI) then displayNUIText('Unlocked') else hideNUI() end
                        elseif not closestDoor.data.locked and canOpen then
                            if Config.ShowUnlockedText and (closestDoor.data.showNUI == nil or closestDoor.data.showNUI) then displayNUIText('[E] - Unlocked') else hideNUI() end
                        elseif closestDoor.data.locked and not canOpen and (closestDoor.data.showNUI == nil or closestDoor.data.showNUI) then displayNUIText('Locked')
                        elseif closestDoor.data.locked and canOpen and (closestDoor.data.showNUI == nil or closestDoor.data.showNUI) then displayNUIText('[E] - Locked') end
                    else hideNUI() break end
                end
                Wait(100)
            end
            closestDoor = {}
            doorSleep = 0
        end
        Wait(doorSleep)
    end
    Started = false
end

local function PlaySound(door, src, enableSounds)
    if enableSounds then
        local origin
        if src and src ~= playerPed then src = NetworkGetEntityFromNetworkId(src) end
        if not src then origin = door.textCoords elseif src == playerPed then origin = playerCoords else origin = NetworkGetPlayerCoords(src) end
        local distance = #(playerCoords - origin)
        if distance < 10 then
            if not door.audioLock then
                if door.audioRemote then
                    door.audioLock = {['file'] = 'button-remote.ogg', ['volume'] = 0.08}
                    door.audioUnlock = {['file'] = 'button-remote.ogg', ['volume'] = 0.08}
                else
                    door.audioLock = {['file'] = 'door-bolt-4.ogg', ['volume'] = 0.1}
                    door.audioUnlock = {['file'] = 'door-bolt-4.ogg', ['volume'] = 0.1}
                end
            end
            local sfx_level = GetProfileSetting(300)
            if door.locked then SendNUIMessage ({type = 'audio', audio = door.audioLock, distance = distance, sfx = sfx_level})
            else SendNUIMessage ({type = 'audio', audio = door.audioUnlock, distance = distance, sfx = sfx_level}) end
        end
    end
end

local function dooranim()
    CreateThread(function()
        RequestAnimDict("anim@heists@keycard@")
        while not HasAnimDictLoaded("anim@heists@keycard@") do
            Wait(0)
        end
        TaskPlayAnim(playerPed, "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 48, 0, 0, 0, 0)
        Wait(550)
        ClearPedTasks(playerPed)
    end)
end

local function LockpickFinish(success)
    if success then
		RLCore.Functions.Notify('Success!', 'success', 2500)
        if closestDoor.data.doors then
            TaskTurnPedToFaceCoord(playerPed, closestDoor.data.doors[1].objCoords.x, closestDoor.data.doors[1].objCoords.y, closestDoor.data.doors[1].objCoords.z, 0)
        else
		    TaskTurnPedToFaceCoord(playerPed, closestDoor.data.objCoords.x, closestDoor.data.objCoords.y, closestDoor.data.objCoords.z, 0)
        end
		Wait(300)
		local count = 0
		while GetIsTaskActive(playerPed, 225) do Wait(10) count = count + 1 if count == 150 then break end end
		Wait(1800)
		TriggerServerEvent('nui_doorlock:server:updateState', closestDoor.id, false, false, true, false) -- Broadcast new state of the door to everyone
    else
		if math.random(1, 100) <= 17 then
            if usingAdvanced then
                TriggerServerEvent("RLCore:Server:RemoveItem", "advancedlockpick", 1, false)
			    TriggerEvent('inventory:client:ItemBox', RLCore.Shared.Items["advancedlockpick"], "remove")
            else
			    TriggerServerEvent("RLCore:Server:RemoveItem", "lockpick", 1, false)
			    TriggerEvent('inventory:client:ItemBox', RLCore.Shared.Items["lockpick"], "remove")
            end
		end
        RLCore.Functions.Notify('Failed..', 'error', 2500)
    end
end

local function closeNUI()
    SetNuiFocus(false, false)
    SendNUIMessage({type = "newDoorSetup", enable = false})
    Wait(10)
    receivedDoorData = nil
end

local function Raycast()
    local offset = GetOffsetFromEntityInWorldCoords(GetCurrentPedWeaponEntityIndex(playerPed), 0, 0, -0.01)
    local direction = GetGameplayCamRot()
    direction = vec2(direction.x * math.pi / 180.0, direction.z * math.pi / 180.0)
    local num = math.abs(math.cos(direction.x))
    direction = vec3((-math.sin(direction.y) * num), (math.cos(direction.y) * num), math.sin(direction.x))
    local destination = vec3(offset.x + direction.x * 30, offset.y + direction.y * 30, offset.z + direction.z * 30)
    local rayHandle, result, hit, endCoords, surfaceNormal, entityHit = StartShapeTestLosProbe(offset, destination, -1, playerPed, 0)
    repeat
        result, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
        Wait(0)
    until result ~= 1
    if GetEntityType(entityHit) == 3 then return hit, entityHit else return false end
end

local function DrawInfos(text)
    SetTextColour(255, 255, 255, 255) -- Color
    SetTextFont(4) -- Font
    SetTextScale(0.4, 0.4) -- Scale
    SetTextWrap(0.0, 1.0) -- Wrap the text
    SetTextCentre(false) -- Align to center(?)
    SetTextDropshadow(0, 0, 0, 0, 255) -- Shadow. Distance, R, G, B, Alpha.
    SetTextEdge(50, 0, 0, 0, 255) -- Edge. Width, R, G, B, Alpha.
    SetTextOutline() -- Necessary to give it an outline.
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.015, 0.71) -- Position
end

------------------------------
-- Events
------------------------------

RegisterNetEvent('nui_doorlock:client:setState', function(sid, doorID, locked, src, isScript, enableSounds)
    local serverid = PlayerData.source
    if enableSounds == nil then enableSounds = true end
    if sid == serverid and not isScript then dooranim() end
    if Config.DoorList[doorID] then
        Config.DoorList[doorID].locked = locked
        UpdateDoors(doorID)
        while true do
            if Config.DoorList[doorID].doors then
                for k, v in pairs(Config.DoorList[doorID].doors) do
                    if not IsDoorRegisteredWithSystem(v.doorHash) then -- If door is not registered end the loop
                        return
                    end
                    v.currentHeading = GetEntityHeading(v.object)
                    v.doorState = DoorSystemGetDoorState(v.doorHash)
                    if Config.DoorList[doorID].slides then
                        DoorSystemSetAutomaticRate(v.doorHash, v.doorRate or 1.0, false, false)
                        if Config.DoorList[doorID].locked then
                            DoorSystemSetDoorState(v.doorHash, 1, false, false) -- Set to locked
                            DoorSystemSetAutomaticDistance(v.doorHash, 0.0, false, false)
                            if k == 2 then
                                PlaySound(Config.DoorList[doorID], src, enableSounds)
                                return -- End the loop
                            end
                        else
                            DoorSystemSetDoorState(v.doorHash, 0, false, false) -- Set to unlocked
                            DoorSystemSetAutomaticDistance(v.doorHash, 30.0, false, false)
                            if k == 2 then
                                PlaySound(Config.DoorList[doorID], src, enableSounds)
                                return -- End the loop
                            end
                        end
                    elseif Config.DoorList[doorID].locked and (v.doorState == 4) then
                        if Config.DoorList[doorID].oldMethod then FreezeEntityPosition(v.object, true) end
                        DoorSystemSetDoorState(v.doorHash, 1, false, false) -- Set to locked
                        if Config.DoorList[doorID].doors[1].doorState == Config.DoorList[doorID].doors[2].doorState then
                            PlaySound(Config.DoorList[doorID], src, enableSounds)
                            return -- End the loop
                        end 
                    elseif not Config.DoorList[doorID].locked then
                        if Config.DoorList[doorID].oldMethod then FreezeEntityPosition(v.object, false) end
                        DoorSystemSetDoorState(v.doorHash, 0, false, false) -- Set to unlocked
                        if Config.DoorList[doorID].doors[1].doorState == Config.DoorList[doorID].doors[2].doorState then
                            PlaySound(Config.DoorList[doorID], src, enableSounds)
                            return -- End the loop
                        end
                    else
                        if RLCore.Shared.Round(v.currentHeading, 0) == RLCore.Shared.Round(v.objHeading, 0) then
                            DoorSystemSetDoorState(v.doorHash, 4, false, false) -- Force to close
                        end
                    end
                end
            else
                if not IsDoorRegisteredWithSystem(Config.DoorList[doorID].doorHash) then -- If door is not registered end the loop
                    return
                end
                Config.DoorList[doorID].currentHeading = GetEntityHeading(Config.DoorList[doorID].object)
                Config.DoorList[doorID].doorState = DoorSystemGetDoorState(Config.DoorList[doorID].doorHash)
                if Config.DoorList[doorID].slides then
                    DoorSystemSetAutomaticRate(Config.DoorList[doorID].doorHash, Config.DoorList[doorID].doorRate or 1.0, false, false)
                    if Config.DoorList[doorID].locked then
                        DoorSystemSetDoorState(Config.DoorList[doorID].doorHash, 1, false, false) -- Set to locked
                        DoorSystemSetAutomaticDistance(Config.DoorList[doorID].doorHash, 0.0, false, false)
                        PlaySound(Config.DoorList[doorID], src, enableSounds)
                        return -- End the loop
                    else
                        DoorSystemSetDoorState(Config.DoorList[doorID].doorHash, 0, false, false) -- Set to unlocked
                        DoorSystemSetAutomaticDistance(Config.DoorList[doorID].doorHash, 30.0, false, false)
                        PlaySound(Config.DoorList[doorID], src, enableSounds)
                        return -- End the loop
                    end
                elseif Config.DoorList[doorID].locked and (Config.DoorList[doorID].doorState == 4) then
                    if Config.DoorList[doorID].oldMethod then FreezeEntityPosition(Config.DoorList[doorID].object, true) end
                    DoorSystemSetDoorState(Config.DoorList[doorID].doorHash, 1, false, false) -- Set to locked
                    PlaySound(Config.DoorList[doorID], src, enableSounds)
                    return -- End the loop
                elseif not Config.DoorList[doorID].locked then
                    if Config.DoorList[doorID].oldMethod then FreezeEntityPosition(Config.DoorList[doorID].object, false) end
                    DoorSystemSetDoorState(Config.DoorList[doorID].doorHash, 0, false, false) -- Set to unlocked
                    PlaySound(Config.DoorList[doorID], src, enableSounds)
                    return -- End the loop
                else
                    if RLCore.Shared.Round(Config.DoorList [doorID].currentHeading, 0) == RLCore.Shared.Round(Config.DoorList[doorID].objHeading, 0) then
                        DoorSystemSetDoorState(Config.DoorList[doorID].doorHash, 4, false, false) -- Force to close
                    end
                end
            end
            Wait(0)
        end
    end
end)

RegisterNetEvent('nui_doorlock:client:newDoorSetup', function(args)
    if not args[1] then
        receivedDoorData = false
        SetNuiFocus(true, true)
        SendNUIMessage({type = "newDoorSetup", enable = true})
        while receivedDoorData == false do DisableAllControlActions(0) Wait(0) end
        if receivedDoorData == nil then return end
    end
    if arg then doorname = arg.doorname else doorname = args[1] end
    if arg then doorType = arg.doortype else doorType = args[2] end
    if arg then doorLocked = arg.doorlocked else doorLocked = not not args[3] end
    if arg then configname = arg.configname else configname = '' end
    local validTypes = {['door']=true, ['sliding']=true, ['garage']=true, ['double']=true, ['doublesliding']=true}
    if not validTypes[doorType] then print(doorType.. ' is not a valid doortype') return end
    if args[7] then print('You can only set three authorised jobs - if you want more, add them to the config later') return end
    if doorType == 'door' or doorType == 'sliding' or doorType == 'garage' then
        local entity, coords, heading, model = nil, nil, nil, nil
        local result = false
        print('Aim at your desired door and press left mouse button')
        while true do
            if IsPlayerFreeAiming(PlayerId()) then
                local result, object = Raycast()
                if result and object ~= entity then
                    SetEntityDrawOutline(entity, false)
                    SetEntityDrawOutline(object, true)
                    entity = object
                    coords = GetEntityCoords(entity)
                    model = GetEntityModel(entity)
                    heading = GetEntityHeading(entity)
                end
            end
            if result then
                DrawInfos("Coordinates: " .. coords .. "\nHeading: " .. heading .. "\nHash: " .. model)
            else
                DrawInfos("Aim at your desired door and shoot")
            end
            if entity and IsControlPressed(0, 24) then break end
            Wait(0)
        end
        SetEntityDrawOutline(entity, false)
        if not model or model == 0 then print('Did not receive a model hash\nIf the door is transparent, make sure you aim at the frame') return end
        result = DoorSystemFindExistingDoor(coords.x, coords.y, coords.z, model)
        if result then return print('This door is already registered') end
        local jobs, gangs, cids = {}, {}, {}
        if args[4] then
            jobs[1] = args[4]
            jobs[2] = args[5]
            jobs[3] = args[6]
            item = false
        else
            if arg.job1 ~= '' then jobs[1] = arg.job1 end
            if arg.job2 ~= '' then jobs[2] = arg.job2 end
            if arg.job3 ~= '' then jobs[3] = arg.job3 end
            if arg.gang1 ~= '' then gangs[1] = arg.gang1 end
            if arg.gang2 ~= '' then gangs[2] = arg.gang2 end
            if arg.gang3 ~= '' then gangs[3] = arg.gang3 end
            if arg.cid1 ~= '' then cids[1] = arg.cid1 end
            if arg.cid2 ~= '' then cids[2] = arg.cid2 end
            if arg.cid3 ~= '' then cids[3] = arg.cid3 end
            if arg.item ~= '' then item = arg.item else item = false end
        end
        local maxDistance, slides, garage = 2.0, false, false
        if doorType == 'sliding' then slides = true
        elseif doorType == 'garage' then maxDistance, slides, garage = 6.0, true, true end
        if slides then maxDistance = 6.0 end
        local doorHash = 'l_'..doorname
        AddDoorToSystem(doorHash, model, coords, false, false, false)
        DoorSystemSetDoorState(doorHash, 4, false, false)
        coords = GetEntityCoords(entity)
        heading = GetEntityHeading(entity)
        RemoveDoorFromSystem(doorHash)
        TriggerServerEvent('nui_doorlock:server:newDoorCreate', configname, model, heading, coords, jobs, gangs, cids, item, doorLocked, maxDistance, slides, garage, false, doorname)
        print('Successfully sent door data to the server')
    elseif doorType == 'double' or doorType == 'doublesliding' then
        local entity, coords, heading, model = {}, {}, {}, {}
        local result = false
        print('Aim at each desired door and press left mouse button')
        for i = 1, 2 do
            while true do
                if IsPlayerFreeAiming(PlayerId()) then
                    local result, object = Raycast()
                    if result and object ~= entity[i] then
                        SetEntityDrawOutline(entity[i], false)
                        SetEntityDrawOutline(object, true)
                        entity[i] = object
                        coords[i] = GetEntityCoords(object)
                        model[i] = GetEntityModel(object)
                        heading[i] = GetEntityHeading(object)
                    end
                else Wait(0) end
                if result then DrawInfos("Coordinates: " .. coords[i] .. "\nHeading: " .. heading[i] .. "\nHash: " .. model[i])
            else DrawInfos("Aim at your desired door and shoot") end
                if entity[i] and IsControlPressed(0, 24) then break end
            end
            Wait(200)
        end
        SetEntityDrawOutline(entity[1], false)
        SetEntityDrawOutline(entity[2], false)
        if not model[1] or model[1] == 0 or not model[2] or model[2] == 0 then print('Did not receive a model hash\nIf the door is transparent, make sure you aim at the frame') return end
        if entity[1] == entity[2] then print('Can not add double door if entities are the same') return end
        for i = 1, 2 do
            result = DoorSystemFindExistingDoor(coords[i].x, coords[i].y, coords[i].z, model[i])
            if result then return print('This door is already registered') end
        end
        local jobs, gangs, cids = {}, {}, {}
        if args[4] then
            jobs[1] = args[4]
            jobs[2] = args[5]
            jobs[3] = args[6]
            item = false
        else
            if arg.job1 ~= '' then jobs[1] = arg.job1 end
            if arg.job2 ~= '' then jobs[2] = arg.job2 end
            if arg.job3 ~= '' then jobs[3] = arg.job3 end
            if arg.gang1 ~= '' then gangs[1] = arg.gang1 end
            if arg.gang2 ~= '' then gangs[2] = arg.gang2 end
            if arg.gang3 ~= '' then gangs[3] = arg.gang3 end
            if arg.cid1 ~= '' then cids[1] = arg.cid1 end
            if arg.cid2 ~= '' then cids[2] = arg.cid2 end
            if arg.cid3 ~= '' then cids[3] = arg.cid3 end
            if arg.item ~= '' then item = arg.item else item = false end
        end
        local maxDistance, slides, garage = 2.5, false, false
        if doorType == 'sliding' or doorType == 'doublesliding' then slides = true end
        if slides then maxDistance = 6.0 end

        local doors = #Config.DoorList + 1
        local doorHash = {}
        doorHash[1] = 'l_'..doors..'_'..'1'
        doorHash[2] = 'l_'..doors..'_'..'2'
        for i=1, #doorHash do
            AddDoorToSystem(doorHash[i], model[i], coords[i], false, false, false)
            DoorSystemSetDoorState(doorHash[i], 4, false, false)
            coords[i] = GetEntityCoords(entity[i])
            heading[i] = GetEntityHeading(entity[i])
            RemoveDoorFromSystem(doorHash[i])
        end
        TriggerServerEvent('nui_doorlock:server:newDoorCreate', configname, model, heading, coords, jobs, gangs, cids, item, doorLocked, maxDistance, slides, garage, true, doorname)
        print('Successfully sent door data to the server')
        arg = nil
    end
end)

RegisterNetEvent('nui_doorlock:client:newDoorAdded', function(newDoor, doorID, locked)
    Config.DoorList[doorID] = newDoor
    Config.DoorList[doorID].locked = locked
    TriggerEvent('nui_doorlock:client:setState', PlayerData.source, doorID, locked, false, true)
end)

RegisterNetEvent('RLCore:Client:OnPlayerLoaded', function()
    PlayerData = RLCore.Functions.GetPlayerData()
    playerPed = PlayerPedId()
    if not Started then
        CreateThread(DoorLoop)
    end
end)

RegisterNetEvent('RLCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

RegisterNetEvent('RLCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('RLCore:Client:OnGangUpdate', function(GangInfo)
    PlayerData.gang = GangInfo
end)

RegisterNetEvent('RLCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

------------------------------
-- Commands
------------------------------

RegisterCommand('doorlock', function()
    if closestDoor.id and not PlayerData.metadata['isdead'] and not PlayerData.metadata['inlaststand'] and not PlayerData.metadata['ishandcuffed'] then
        playerPed = PlayerPedId()
        local veh = GetVehiclePedIsIn(playerPed)
        if veh then
            CreateThread(function()
                local counter = 0
                local siren = IsVehicleSirenOn(veh)
                repeat
                    DisableControlAction(0, 86, true)
                    SetHornEnabled(veh, false)
                    if not siren then SetVehicleSiren(veh, false) end
                    counter = counter + 1
                    Wait(0)
                until counter == 100
                SetHornEnabled(veh, true)
            end)
        end
        local locked = not closestDoor.data.locked
        if closestDoor.data.audioRemote then src = NetworkGetNetworkIdFromEntity(playerPed) else src = false end
        TriggerServerEvent('nui_doorlock:server:updateState', closestDoor.id, locked, src, false, false, true) -- Broadcast new state of the door to everyone
    end
end)
TriggerEvent("chat:removeSuggestion", "/doorlock")
RegisterKeyMapping('doorlock', 'Interact with doorlock', 'keyboard', 'E')

RegisterNetEvent('lockpicks:UseLockpick', function(isAdvanced)
	if closestDoor.data and next(closestDoor.data) then
		if not PlayerData.metadata["isdead"] and not PlayerData.metadata["ishandcuffed"] and closestDoor.data.lockpick and closestDoor.data.locked then
			usingAdvanced = isAdvanced
			TriggerEvent('rl-lockpick:client:openLockpick', LockpickFinish)
		end
	end
end)

RegisterCommand('-nui', function()
    closeNUI()
end, false)

------------------------------
-- NUI Callbacks
------------------------------

RegisterNUICallback('newDoor', function(data, cb)
    receivedDoorData = true
    arg = data
    closeNUI()
    cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
    closeNUI()
    cb('ok')
end)

------------------------------
-- Threads
------------------------------

CreateThread(function()
    if LocalPlayer.state['isLoggedIn'] and not Started then
        CreateThread(DoorLoop)
    end
end)