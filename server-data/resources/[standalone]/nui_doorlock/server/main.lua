local RLCore = exports['rl-core']:GetCoreObject()
local Config = Config

--------------------------
-- Functions
--------------------------

local function IsAuthorized(Player, doorID, usedLockpick, isScript)
    if isScript then return true end

    if doorID.lockpick and usedLockpick then
        return true
    end

    if doorID.authorizedJobs then
        if doorID.authorizedJobs[Player.PlayerData.job.name] and Player.PlayerData.job.grade.level >= doorID.authorizedJobs[Player.PlayerData.job.name] then
            return true
        end
    end

    if doorID.authorizedGangs then
        if doorID.authorizedGangs[Player.PlayerData.gang.name] and Player.PlayerData.gang.grade.level >= doorID.authorizedGangs[Player.PlayerData.gang.name] then
            return true
        end
    end

    if doorID.authorizedCIDs then
        return doorID.authorizedCIDs[Player.PlayerData.citizenid]
    end

    if doorID.items then
        for k, v in pairs(doorID.items) do
            local item = Player.Functions.GetItemByName(v)
            if item and item.amount > 0 then
                local consumables = { ['ticket']=1 } -- Add items you would like to be removed after use to this table
                if doorID.locked and consumables[v] then
                    Player.Functions.RemoveItem(v, consumables[v])
                end
                return true
            end
        end
    end

    if (not doorID.authorizedJobs or not next(doorID.authorizedJobs)) and (not doorID.authorizedGangs or not next(doorID.authorizedGangs)) and (not doorID.authorizedCIDs or not next(doorID.authorizedCIDs)) and (not doorID.items or not next(doorID.items)) and not doorID.lockpick then
        return true
    end

    if Config.AdminAccess.enabled and RLCore.Functions.HasPermission(Player.PlayerData.source, Config.AdminAccess.permission) then
        print(('^2%s (%s) opened a door using admin privileges'):format(Player.PlayerData.name, Player.PlayerData.license))
        return true
    end

    return false
end

--------------------------
-- Events
--------------------------

RegisterNetEvent('nui_doorlock:server:updateState', function(doorID, locked, src, usedLockpick, isScript, enableSounds, sentSource)
    local playerId = source or sentSource
    local Player = RLCore.Functions.GetPlayer(playerId)
    if Player then
        if type(doorID) ~= 'number' and type(doorID) ~= 'string' then
            print(('^3[Warning] ^7%s (%s) didn\'t send an appropriate doorID! (Sent %s)'):format(Player.PlayerData.name, Player.PlayerData.license, doorID))
            return
        end

        if type(locked) ~= 'boolean' then
            print(('^3[Warning] ^7%s (%s) attempted to update invalid state! (Sent %s)'):format(Player.PlayerData.name, Player.PlayerData.license, locked))
            return
        end

        if not Config.DoorList[doorID] then
            print(('^3[Warning] ^7%s (%s) attempted to update invalid door! (Sent %s)'):format(Player.PlayerData.name, Player.PlayerData.license, doorID))
            return
        end

        if not IsAuthorized(Player, Config.DoorList[doorID], usedLockpick, isScript) then
            print(('^3[Warning] ^7%s (%s) attempted to open a door without authorisation!'):format(Player.PlayerData.name, Player.PlayerData.license))
            return
        end

        Config.DoorList[doorID].locked = locked
        if not src then TriggerClientEvent('nui_doorlock:client:setState', -1, playerId, doorID, locked, false, isScript)
        else TriggerClientEvent('nui_doorlock:client:setState', -1, playerId, doorID, locked, src, isScript) end

        if Config.DoorList[doorID].autoLock then
            SetTimeout(Config.DoorList[doorID].autoLock, function()
                if Config.DoorList[doorID].locked then return end
                Config.DoorList[doorID].locked = true
                TriggerClientEvent('nui_doorlock:client:setState', -1, -1, doorID, true, src, isScript, enableSounds)
            end)
        end
    end
end)

RegisterNetEvent('nui_doorlock:server:newDoorCreate', function(config, model, heading, coords, jobs, gangs, cids, item, doorLocked, maxDistance, slides, garage, doubleDoor, doorname)
    local Player = RLCore.Functions.GetPlayer(source)
    if Player then
        if not RLCore.Functions.HasPermission(source, Config.CommandPermission) then print(('^3[Warning] ^7%s (%s) attempted to create a new door but does not have permission'):format(Player.PlayerData.name, Player.PlayerData.license)) return end
        local newDoor, auth1, auth2, auth3 = {}, nil, nil, nil
        if jobs[1] then auth1 = tostring("['"..jobs[1].."']=0") end
        if jobs[2] then auth1 = auth1..', '..tostring("['"..jobs[2].."']=0") end
        if jobs[3] then auth1 = auth1..', '..tostring("['"..jobs[3].."']=0") end
        if gangs[1] then auth2 = tostring("['"..gangs[1].."']=0") end
        if gangs[2] then auth2 = auth2..', '..tostring("['"..gangs[2].."']=0") end
        if gangs[3] then auth2 = auth2..', '..tostring("['"..gangs[3].."']=0") end
        if cids[1] then auth3 = tostring("['"..cids[1].."']=true") end
        if cids[2] then auth3 = auth3..', '..tostring("['"..cids[2].."']=true") end
        if cids[3] then auth3 = auth3..', '..tostring("['"..cids[3].."']=true") end
        if auth1 then newDoor.authorizedJobs = { auth1 } end
        if auth2 then newDoor.authorizedGangs = { auth2 } end
        if auth3 then newDoor.authorizedCIDs = { auth3 } end
        if item then newDoor.items = { item } end
        newDoor.locked = doorLocked
        newDoor.maxDistance = maxDistance
        newDoor.slides = slides
        if not doubleDoor then
            newDoor.garage = garage
            newDoor.objHash = model
            newDoor.objHeading = heading
            newDoor.objCoords = coords
            newDoor.fixText = false
        else
            newDoor.doors = {
                {objHash = model[1], objHeading = heading[1], objCoords = coords[1]},
                {objHash = model[2], objHeading = heading[2], objCoords = coords[2]}
            }
        end
        newDoor.audioRemote = false
        newDoor.lockpick = false
        local path = GetResourcePath(GetCurrentResourceName())

        if config ~= '' then
            path = path:gsub('//', '/')..'/configs/'..string.gsub(config, ".lua", "")..'.lua'
        else
            path = path:gsub('//', '/')..'/config.lua'
        end

        local file = io.open(path, 'a+')
        local label
        label = '\n\n-- '..doorname.. ' created by '..Player.PlayerData.name..'\nConfig.DoorList[\''..doorname..'\'] = {'
        file:write(label)
        for k, v in pairs(newDoor) do
            if k == 'authorizedJobs' or k == 'authorizedGangs' or k == 'authorizedCIDs' then
                local putauth = auth1
                if k == 'authorizedGangs' then
                    putauth = auth2
                elseif k == 'authorizedCIDs' then
                    putauth = auth3
                end
                local str =  ('\n    %s = { %s },'):format(k, putauth)
                file:write(str)
            elseif k == 'doors' then
                local doorStr = {}
                for i=1, 2 do
                    doorStr[#doorStr+1] = ('    {objHash = %s, objHeading = %s, objCoords = %s}'):format(model[i], heading[i], coords[i])
                end
                local str = ('\n    %s = {\n    %s,\n    %s\n    },'):format(k, doorStr[1], doorStr[2])
                file:write(str)
            elseif k == 'items' then
                local str = ('\n    %s = { \'%s\' },'):format(k, item)
                file:write(str)
            else
                local str = ('\n    %s = %s,'):format(k, v)
                file:write(str)
            end
        end
        file:write('\n    --oldMethod = true,\n    --audioLock = {[\'file\'] = \'metal-locker.ogg\', [\'volume\'] = 0.6},\n    --audioUnlock = {[\'file\'] = \'metallic-creak.ogg\', [\'volume\'] = 0.7},\n    --autoLock = 1000,\n    --doorRate = 1.0,\n    --showNUI = true\n}')
        file:close()

        if jobs[3] then newDoor.authorizedJobs = { [jobs[1]] = 0, [jobs[2]] = 0, [jobs[3]] = 0 }
        elseif jobs[2] then newDoor.authorizedJobs = { [jobs[1]] = 0, [jobs[2]] = 0 }
        elseif jobs[1] then newDoor.authorizedJobs = { [jobs[1]] = 0 } end

        if gangs[3] then newDoor.authorizedGangs = { [gangs[1]] = 0, [gangs[2]] = 0, [gangs[3]] = 0 }
        elseif gangs[2] then newDoor.authorizedGangs = { [gangs[1]] = 0, [gangs[2]] = 0 }
        elseif gangs[1] then newDoor.authorizedGangs = { [gangs[1]] = 0 } end

        if cids[3] then newDoor.authorizedCIDs = { [cids[1]] = true, [cids[2]] = true, [cids[3]] = true }
        elseif cids[2] then newDoor.authorizedCIDs = { [cids[1]] = true, [cids[2]] = true }
        elseif cids[1] then newDoor.authorizedCIDs = { [cids[1]] = true } end

        Config.DoorList[doorname] = newDoor
        TriggerClientEvent('nui_doorlock:client:newDoorAdded', -1, newDoor, doorname, doorLocked)
    end
end)

--------------------------
-- Callbacks
--------------------------

RLCore.Functions.CreateCallback('nui_doorlock:server:getDoorList', function(source, cb)
    cb(Config.DoorList)
end)

RLCore.Functions.CreateCallback('nui_doorlock:server:CheckItems', function(source, cb, items, locked)
	local Player = RLCore.Functions.GetPlayer(source)
	if Player then
		local canOpen = false
		local count = false
		for k,v in pairs(items) do
			if Player.Functions.GetItemByName(v) then
				count = true
			else
				count = false
			end
			if count then
				canOpen = true
				local consumables = { ['ticket']=1 }
				if locked and consumables[v] then
					Player.Functions.RemoveItem(v, 1)
				end
				break
			end
		end
		if not count then canOpen = false end
		cb(canOpen)
	else
		cb(false)
	end
end)

--------------------------
-- Commands
--------------------------

RLCore.Commands.Add('newdoor', 'Create a new door using a gun', { { name = 'doorname', help = 'Name of the door' }, { name = 'doortype', help = 'door/double/sliding/garage/doublesliding' }, { name = 'locked', help = 'true/false' }, { name = 'jobs', help = 'Add up to 3 jobs to this, seperate with spaces and no commas' } }, false, function(source, args)
    TriggerClientEvent('nui_doorlock:client:newDoorSetup', source, args)
end, Config.CommandPermission)