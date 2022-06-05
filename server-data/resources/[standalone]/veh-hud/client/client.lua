local enabled = false
local player = false
local veh = 0
local vehicle_fuel = 0

-- Main thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if veh ~= 0 then
            -- IsControlPressed(0, 21) and
            if enabled then
                refreshUI()
            end
        else
            Wait(100)
        end
    end
end)

RegisterNetEvent('veh:options')
AddEventHandler('veh:options', function()
    EnableGUI(true)
end)

Citizen.CreateThread(function()
    while true do
        player = GetPlayerPed(-1)
        veh = GetVehiclePedIsIn(player, false)
        if veh ~= 0 then
            local temp_veh_fuel = GetVehicleFuelLevel(veh)
            if temp_veh_fuel > 0 then
                vehicle_fuel = temp_veh_fuel
            end
        end
        Citizen.Wait(2000)
    end
end)

function EnableGUI(enable)
    enabled = enable

    SetNuiFocus(enable, enable)

    SendNUIMessage({
        type = "enablecarmenu",
        enable = enable
    })
end

function checkSeat(player, veh, seatIndex)
    local ped = GetPedInVehicleSeat(veh, seatIndex);
    if ped == player then
        return seatIndex;
    elseif ped ~= 0 then
        return false;
    else
        return true;
    end
end

-- Check vehicles doors etc and send to UI
function refreshUI()
    local settings = {}
    player = GetPlayerPed(-1)
    veh = GetVehiclePedIsIn(player, false)
    if veh ~= 0 then
        settings.seat1 = checkSeat(player, veh, -1)
        settings.seat2 = checkSeat(player, veh,  0)
        settings.seat3 = checkSeat(player, veh,  1)
        settings.seat4 = checkSeat(player, veh,  2)

        settings.doorAccess = settings.seat1 == -1 and true or false
        if GetVehicleDoorAngleRatio(veh, 0) ~= 0 then
            settings.door0 = true
        end
        if GetVehicleDoorAngleRatio(veh, 1) ~= 0 then
            settings.door1 = true
        end
        if GetVehicleDoorAngleRatio(veh, 2) ~= 0 then
            settings.door2 = true
        end
        if GetVehicleDoorAngleRatio(veh, 3) ~= 0 then
            settings.door3 = true
        end
        if GetVehicleDoorAngleRatio(veh, 4) ~= 0 then
            settings.hood = true
        end
        if GetVehicleDoorAngleRatio(veh, 5) ~= 0 then
            settings.trunk = true
        end

        if not IsVehicleWindowIntact(veh, 0) then
            settings.windowr1 = true
        end
        if not IsVehicleWindowIntact(veh, 1) then
            settings.windowl1 = true
        end
        if not IsVehicleWindowIntact(veh, 2) then
            settings.windowr2 = true
        end
        if not IsVehicleWindowIntact(veh, 3) then
            settings.windowl2 = true
        end

        local engine = GetIsVehicleEngineRunning(veh);
        -- local lockStatus = GetVehicleDoorLockStatus(veh)
        -- if (lockStatus == 1 or lockStatus == 0) and settings.seat1 == -1 then
        --     settings.engineAccess = true
        -- end
        if engine then
            settings.engine = true
        else
            settings.engine = false
        end

        SendNUIMessage({
            type = "refreshcarmenu",
            settings = settings
        })
    else
        SendNUIMessage({
            type = "resetcarmenu"
        })
    end
end

RegisterNUICallback('openDoor', function(data, cb)
    doorIndex = tonumber(data['doorIndex'])
    player = GetPlayerPed(-1)
    veh = GetVehiclePedIsIn(player, false)

    if veh ~= 0 then
        -- if doors are unlocked?
        -- if not GetVehicleDoorsLockedForPlayer(veh, player) then
        local lockStatus = GetVehicleDoorLockStatus(veh)
        if lockStatus == 1 or lockStatus == 0 then
            if (GetVehicleDoorAngleRatio(veh, doorIndex) == 0) then
                SetVehicleDoorOpen(veh, doorIndex, false, false)
            else
                SetVehicleDoorShut(veh, doorIndex, false)
            end
        end
    end
    cb('ok')
end)

RegisterNUICallback('switchSeat', function(data, cb)
    seatIndex = tonumber(data['seatIndex'])
    player = GetPlayerPed(-1)
    veh = GetVehiclePedIsIn(player, false)
    if veh ~= 0 then
        -- May need to check if another player is in seat?
        SetPedIntoVehicle(player, veh, seatIndex)
    end
    cb('ok')
end)

RegisterNUICallback('togglewindow', function(data, cb)
    windowIndex = tonumber(data['windowIndex'])
    player = GetPlayerPed(-1)
    veh = GetVehiclePedIsIn(player, false)
    if veh ~= 0 then
        if not IsVehicleWindowIntact(veh, windowIndex) then
            RollUpWindow(veh, windowIndex)
            if not IsVehicleWindowIntact(veh, windowIndex) then
                RollDownWindow(veh, windowIndex)
            end
        else
            RollDownWindow(veh, windowIndex)
        end
    end
    cb('ok')
end)

RegisterNUICallback('toggleengine', function(data, cb)
    player = GetPlayerPed(-1)
    veh = GetVehiclePedIsIn(player, false)
    if veh ~= 0 then
        local engine = not GetIsVehicleEngineRunning(veh)

        if not IsPedInAnyHeli(player) then
            SetVehicleEngineOn(veh, engine, false, true)
            SetVehicleJetEngineOn(veh, engine)
        else
            if engine then
                SetVehicleFuelLevel(veh, vehicle_fuel)
            else
                SetVehicleFuelLevel(veh, 0)
            end
        end
    end
    cb('ok')
end)

RegisterNetEvent("hidemenu")
AddEventHandler("hidemenu", function()
    EnableGUI(false)
end)

RegisterNUICallback('escape', function(data, cb)
    EnableGUI(false)
    cb('ok')
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

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
    
    if distance > 3000 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function DrawText3D(x,y,z, text)
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

RegisterNetEvent('car:windowsup')
AddEventHandler('car:windowsup', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())	
	for i = -1, 6 do
		if GetPedInVehicleSeat(veh, i) == PlayerPedId() then
			RollUpWindow(veh, i+1)
		end
	end
end)

RegisterNetEvent('car:windows')
AddEventHandler('car:windows', function(closeType,window)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if tonumber(window) == nil then
		return
	end
	if veh ~= nil then
		if window == "all" or window == "All" then
			if closeType == "open" or closeType == "Open" or closeType == "OPEN" then	
				for i=0,4 do
					RollDownWindow(veh, i)
				end
			else
				for i=0,4 do
					RollUpWindow(veh, i)
				end
			end
		else
			local window = tonumber(window)
			if window < 0 or window > 4  then
				return
			end
			if closeType == "open" or closeType == "Open" or closeType == "OPEN" then	
				RollDownWindow(veh, window)
			else
				RollUpWindow(veh, window)
			end
		end
	end
end)

RegisterNetEvent('car:swapseat')
AddEventHandler('car:swapseat', function(num)
	local num = tonumber(num)
	local veh = GetVehiclePedIsUsing(PlayerPedId())

	SetPedIntoVehicle(PlayerPedId(),veh,num)
end)

RegisterNetEvent('car:doors')
AddEventHandler('car:doors', function(closeType,door)

	local isInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	local door = tonumber(door)

	if not isInVehicle then

        lastPlayerPos = GetEntityCoords(PlayerPedId(), 1)
        coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
        veh = getVehicleInDirection(lastPlayerPos, coordB)
        
	    local Driver = GetPedInVehicleSeat(veh, -1)

	    if DoesEntityExist(Driver) and not IsPedAPlayer(Driver) then
	        RLCore.Functions.Notify('The vehicle is locked!', "error")
	        return
	    end

	    local lockStatus = GetVehicleDoorLockStatus(veh) 
	    if lockStatus ~= 1 and lockStatus ~= 0 then 
	        RLCore.Functions.Notify('The vehicle is locked!', "error")
	        return
	    end

        if veh then

        	local d1,d2 = GetModelDimensions(GetEntityModel(veh))
	        local front = GetOffsetFromEntityInWorldCoords(veh, 0.0,d2["y"]+0.5,0.0)
	        local back = GetOffsetFromEntityInWorldCoords(veh, 0.0,d1["y"]-0.5,0.0)

	        local leftfront = GetOffsetFromEntityInWorldCoords(veh, d1["x"]-0.25,0.25,0.0)
	        local rightfront = GetOffsetFromEntityInWorldCoords(veh, d2["x"]+0.25,0.25,0.0)

	        local leftback = GetOffsetFromEntityInWorldCoords(veh, d1["x"]-0.25,-0.85,0.0)
	        local rightback = GetOffsetFromEntityInWorldCoords(veh, d2["x"]+0.25,-0.85,0.0)

	        local drawinfo = leftfront

	        if door == 4 then
	        	drawInfo = front
	        end

	        if door == 5 then
	        	drawInfo = back
	        end

	   	    if door == 0 then
	        	drawInfo = leftfront
	        end

	        if door == 1 then
	        	drawInfo = rightfront
	        end  

	   	    if door == 2 then
	        	drawInfo = leftback
	        end

	        if door == 3 then
	        	drawInfo = rightback
	        end  

	        local dist = #(vector3(drawInfo["x"],drawInfo["y"],drawInfo["z"]) - lastPlayerPos)
            local count = 1000
            while dist > 1.0 and count > 0 do
                dist = #(vector3(drawInfo["x"],drawInfo["y"],drawInfo["z"]) - lastPlayerPos)
                Citizen.Wait(1)
                count = count - 1
                DrawText3D(drawInfo["x"],drawInfo["y"],drawInfo["z"],"Move here to " .. closeType .. ".")
            end

            local distfin = #(GetEntityCoords(veh) - lastPlayerPos)
            if distfin > 5.0 or GetEntitySpeed(veh) > 5 then
            	return
            end
            loadAnimDict('anim@narcotics@trash')
            TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',0.9, -8, 1500, 49, 3.0, 0, 0, 0)
            TaskTurnPedToFaceEntity(PlayerPedId(), veh, 1.0)
    		Citizen.Wait(1600)
    		ClearPedTasks(PlayerPedId())
	    end
	end
	if veh ~= nil then
		if closeType == "open" or closeType == "Open" then	
			SetVehicleDoorOpen(veh, door, 1, 1)
		else
			SetVehicleDoorShut(veh, door, 1, 1)
		end
	end
end)

RegisterCommand("window", function(src, args, raw)
    local closetype = args[1]
    local door = args[2]

    TriggerEvent('car:windows',closetype, door)
end)

RegisterCommand("door", function(src, args, raw)
    local closetype = args[1]
    local door = args[2]

    TriggerEvent('car:doors',closetype, door)
end)

RegisterCommand("seat", function(src, args, raw)
    local seat = args[1]

    TriggerEvent('car:swapseat',seat)
end)