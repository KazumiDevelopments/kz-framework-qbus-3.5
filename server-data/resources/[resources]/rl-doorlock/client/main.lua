RLCore = nil

Citizen.CreateThread(function()
	while RLCore == nil do
		TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
		Citizen.Wait(0)
	end
end)

local closestDoorKey, closestDoorValue = nil, nil

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

Citizen.CreateThread(function()
	while true do
		for key, doorID in ipairs(RLConfig.Doors) do
			if doorID.doors then
				for k,v in ipairs(doorID.doors) do
					if not v.object or not DoesEntityExist(v.object) then
						v.object = GetClosestObjectOfType(v.objCoords, 1.0, (type(v.objName) == 'number' and v.objName or GetHashKey(v.objName)), false, false, false)
					end
				end
			else
				if not doorID.object or not DoesEntityExist(doorID.object) then
					doorID.object = GetClosestObjectOfType(doorID.objCoords, 1.0, (type(doorID.objName) == 'number' and doorID.objName or GetHashKey(doorID.objName)), false, false, false)
				end
			end
		end

		Citizen.Wait(2500)
	end
end)

local maxDistance = 1.25

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords, awayFromDoors = GetEntityCoords(GetPlayerPed(-1)), true

		for k,doorID in ipairs(RLConfig.Doors) do
			local distance

			if doorID.doors then
				distance = #(playerCoords - doorID.doors[1].objCoords)
			else
				distance = #(playerCoords - doorID.objCoords)
			end

			if doorID.distance then
				maxDistance = doorID.distance
			end
			
			if distance < 50 then
				awayFromDoors = false
				if doorID.doors then
					for _,v in ipairs(doorID.doors) do
						FreezeEntityPosition(v.object, doorID.locked)

						if doorID.locked and v.objYaw and GetEntityRotation(v.object).z ~= v.objYaw then
							SetEntityRotation(v.object, 0.0, 0.0, v.objYaw, 2, true)
						end
					end
				else
					FreezeEntityPosition(doorID.object, doorID.locked)

					if doorID.locked and doorID.objYaw and GetEntityRotation(doorID.object).z ~= doorID.objYaw then
						SetEntityRotation(doorID.object, 0.0, 0.0, doorID.objYaw, 2, true)
					end
				end
			end

			if distance < maxDistance then
				awayFromDoors = false
				if doorID.size then
					size = doorID.size
				end

				local isAuthorized = IsAuthorized(doorID)

				if isAuthorized then
					if doorID.locked then
						displayText = "[E] - Locked " .. k
					elseif not doorID.locked then
						displayText = "[E] - Unlocked " .. k
					end
				elseif not isAuthorized then
					if doorID.locked then
						displayText = "Locked " .. k
					elseif not doorID.locked then
						displayText = "Unlocked " .. k
					end
				end

				if doorID.locking then
					if doorID.locked then
						displayText = "Unlocking"
					else
						displayText = "Locking"
					end
				end

				if doorID.objCoords == nil then
					doorID.objCoords = doorID.textCoords
				end

				DrawText3Ds(doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, displayText)

				if IsControlJustReleased(0, 38) then
					if isAuthorized then
						setDoorLocking(doorID, k)
					end
				end
			end
		end

		if awayFromDoors then
			Citizen.Wait(1250)
		end
	end
end)


function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

RegisterNetEvent('lockpicks:UseLockpick')
AddEventHandler('lockpicks:UseLockpick', function()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped)
	for k, v in pairs(RLConfig.Doors) do
		local dist = GetDistanceBetweenCoords(pos, RLConfig.Doors[k].textCoords.x, RLConfig.Doors[k].textCoords.y, RLConfig.Doors[k].textCoords.z)
		if dist < 1.5 then
			if RLConfig.Doors[k].pickable then
				if RLConfig.Doors[k].locked then
					closestDoorKey, closestDoorValue = k, v
					TriggerEvent('rl-lockpick:client:openLockpick', lockpickFinish)
					TriggerEvent("debug", 'Doors: Lockpick ' .. closestDoorKey, 'success')
				else
					RLCore.Functions.Notify('Door is already unlocked', 'error', 2500)
				end
			else
				RLCore.Functions.Notify('This door has a stronger lock than you can actually unlock.', 'error', 2500)
			end
		end
	end
end)

function lockpickFinish(success)
	local chance = math.random(1,100)
    if success then
		RLCore.Functions.Notify('Success', 'success', 2500)
		setDoorLocking(closestDoorValue, closestDoorKey)
    elseif chance >= 15 then
        RLCore.Functions.Notify('Lockpick bent out of shape.', 'error', 2500)
		TriggerServerEvent('RLCore:Server:RemoveItem', 'lockpick', 1)
    end
end

function setDoorLocking(doorId, key)
	doorId.locking = true
	--openDoorAnim()
    SetTimeout(400, function()
		doorId.locking = false
		doorId.locked = not doorId.locked
		TriggerServerEvent('rl-doorlock:server:updateState', key, doorId.locked)
	end)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function IsAuthorized(doorID)
	local PlayerData = RLCore.Functions.GetPlayerData()

	for _,job in pairs(doorID.authorizedJobs) do
		if job == PlayerData.job.name then
			return true
		end
	end
	
	return false
end

function openDoorAnim()
    loadAnimDict("anim@heists@keycard@") 
    TaskPlayAnim( GetPlayerPed(-1), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
	SetTimeout(400, function()
		ClearPedTasks(GetPlayerPed(-1))
	end)
end

RegisterNetEvent('rl-doorlock:client:setState')
AddEventHandler('rl-doorlock:client:setState', function(doorID, state)
	RLConfig.Doors[doorID].locked = state
	TriggerEvent("debug", 'Doors: Update ' .. doorID .. ' (' .. (state and 'Locked' or 'Unlocked') .. ')', 'success')
end)

RegisterNetEvent('rl-doorlock:client:setDoors')
AddEventHandler('rl-doorlock:client:setDoors', function(doorList)
	RLConfig.Doors = doorList
	TriggerEvent("debug", 'Doors: Received', 'success')
end)

RegisterNetEvent('RLCore:Client:OnPlayerLoaded')
AddEventHandler('RLCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent("rl-doorlock:server:setupDoors")
end)