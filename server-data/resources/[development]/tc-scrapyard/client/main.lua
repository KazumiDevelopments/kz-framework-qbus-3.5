Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

RLCore = nil
xPlayer = nil
local disablecontrols = false
local allowedchop = true
payout = math.random(25,75)
local clientcooldown = false
local chopstarted = false

--[[ Door 1 ]]
local chopdoor1 = false
local door1gone = false
local door1delivered = false
--[[ Door 2 ]]
local chopdoor2 = false
local door2gone = false
local door2delivered = false
-- [[ Door 3 ]]
local chopdoor3 = false
local door3gone = false
local door3delivered = false

-- [[ Door 4 ]]
local chopdoor4 = false
local door4gone = false
local door4delivered = false

-- [[ Hood  ]]
local chopdoor5 = false
local door5gone = false
local door5delivered = false

-- [[ Hood  ]]
local chopdoor6 = false
local door6gone = false
local door6delivered = false

-- [[ Radio  ]]
local chopdoor7 = false
local door7gone = false
local door7delivered = false

-- [[ Battery  ]]
local chopdoor8 = false
local door8gone = false
local door8delivered = false

local deliveryspot = false

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

CarParts = {  --- 
    [1] = {["x"] = -558.62, ["y"] = -1695.93, ["z"] = 19.14}, --- Door 1
    [2] = {["x"] = -556.61, ["y"] = -1695.42, ["z"] = 19.14}, --- Door 2
    [3] = {["x"] = -558.29, ["y"] = -1697.21, ["z"] = 19.14}, --- Door 3
    [4] = {["x"] = -556.02, ["y"] = -1696.21, ["z"] = 19.14}, --- Door 4
    [5] = {["x"] = -559.48, ["y"] = -1695.28, ["z"] = 19.14}, --- Hood
	[6] = {["x"] = -557.68, ["y"] = -1698.03, ["z"] = 19.14}, --- Hood
	[7] = {["x"] = -559.48, ["y"] = -1695.28, ["z"] = 19.14}, --- Battery
}



ChopCarLocation = {  --- Coords [x] = Door Coords [x2] =location if need be
    [1] = {["x"] = -557.64, ["y"] = -1695.82, ["z"] = 19.16}, 
    [2] = {["x"] = -556.36, ["y"] = -1704.7, ["z"] = 19.04}, 
}


function CarryingPart(partID)
if DoesEntityExist(partID) then
		AttachEntityToEntity(partID, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)

		-- AttachEntityToEntity(partID, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

		ClearPedTasks(PlayerPedId())
	else
		return
	end

	local Packaging = true
	loadAnimDict("anim@heists@narcotics@trash")
--loadAnimDict("anim@heists@box_carry@")
	while Packaging do
		Citizen.Wait(5)
-- 
---RequestAnimDict("anim@heists@narcotics@trash") 

--[[ Carry
		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		end
]]
	if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@narcotics@trash", "walk", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@narcotics@trash", "walk", 8.0, 8.0, -1, 50, 0, false, false, false)
	end
		if not IsEntityAttachedToEntity(partID, PlayerPedId()) then
			Packaging = false
			DeleteEntity(partID)
		else
			local PedPosition = GetEntityCoords(PlayerPedId())
			local DistanceCheck = GetDistanceBetweenCoords(PedPosition, ChopCarLocation[2]["x"], ChopCarLocation[2]["y"], ChopCarLocation[2]["z"], true)
			Draw3DText2(ChopCarLocation[2]["x"], ChopCarLocation[2]["y"], ChopCarLocation[2]["z"] - 0.1, tostring("[E] Deliver Part"))
			if DistanceCheck <= 2.0 then
				if IsControlJustPressed(0, 38) then
					disablecontrols = true
					DeleteEntity(partID)
					ClearPedTasksImmediately(PlayerPedId())
					Packaging = false
						if door1gone then
							TriggerServerEvent('tp-scrapyard:success', payout)
							door1gone = false
							door1delivered = true
							disablecontrols = false
							RLCore.Functions.Notify('Part Successfully Chopped')
						end
						if door2gone then
							TriggerServerEvent('tp-scrapyard:success', payout)
							door2gone = false
							door2delivered = true
							disablecontrols = false
							RLCore.Functions.Notify('Part Successfully Chopped')
						end
						if door3gone then
							TriggerServerEvent('tp-scrapyard:success', payout)
							door3gone = false
							door3delivered = true
							disablecontrols = false
							RLCore.Functions.Notify('Part Successfully Chopped')
						end
						if door4gone then
							TriggerServerEvent('tp-scrapyard:success', payout)
							door4gone = false
							door4delivered = true
							disablecontrols = false
							RLCore.Functions.Notify('Part Successfully Chopped')
						end
				end
			end
			---- This

		end

	end
end

function CarryingPartHood(partID)
if DoesEntityExist(partID) then
		-- AttachEntityToEntity(partID, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
		AttachEntityToEntity(partID, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

		ClearPedTasks(PlayerPedId())
	else
		return
	end

	local Packaging = true
	-- loadAnimDict("anim@heists@narcotics@trash")
	loadAnimDict("anim@heists@box_carry@")
	while Packaging do
		Citizen.Wait(5)
-- 
---RequestAnimDict("anim@heists@narcotics@trash") 

		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		end
	--[[ Drag
	if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@narcotics@trash", "walk", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@narcotics@trash", "walk", 8.0, 8.0, -1, 50, 0, false, false, false)
	end
	]]
		if not IsEntityAttachedToEntity(partID, PlayerPedId()) then
			Packaging = false
			DeleteEntity(partID)
		else
			local PedPosition = GetEntityCoords(PlayerPedId())
			local DistanceCheck = GetDistanceBetweenCoords(PedPosition, ChopCarLocation[2]["x"], ChopCarLocation[2]["y"], ChopCarLocation[2]["z"], true)
			Draw3DText2(ChopCarLocation[2]["x"], ChopCarLocation[2]["y"], ChopCarLocation[2]["z"] - 0.1, tostring("[E] Deliver Part"))
			if DistanceCheck <= 2.0 then
				if IsControlJustPressed(0, 38) then
					DeleteEntity(partID)
					disablecontrols = true
					ClearPedTasksImmediately(PlayerPedId())
					Packaging = false
						if door5gone then
							TriggerServerEvent('tp-scrapyard:success', payout)
							door5gone = false
							door5delivered = true
							disablecontrols = false
							disablecontrols = false
							RLCore.Functions.Notify('Part Successfully Chopped')
						end
						if door6gone then
							TriggerServerEvent('tp-scrapyard:success', payout)
							door6gone = false
							disablecontrols = false
							door6delivered = true
							disablecontrols = false
							RLCore.Functions.Notify('Part Successfully Chopped')
						end
						if door7gone then
							TriggerServerEvent('tp-scrapyard:success', payout)
							door7gone = false
							disablecontrols = false
							door7delivered = true
							disablecontrols = false
							RLCore.Functions.Notify('Part Successfully Chopped')
						end
						if door8gone then
							TriggerServerEvent('tp-scrapyard:success', payout)
							door7gone = false
							disablecontrols = false
							door7delivered = true
							disablecontrols = false
							RLCore.Functions.Notify('Part Successfully Chopped')
						end
				end
			end
			---- This

		end

	end
end




Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		if disablecontrols then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, Keys['W'], true) -- W
			DisableControlAction(0, Keys['A'], true) -- A
			DisableControlAction(0, Keys['E'], true) -- A
			DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			DisableControlAction(0, 30, true) -- D (fault in Keys table!)

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)



function ChopDoors()
local player = PlayerId()
local plyPed = GetPlayerPed(player)
local veh = GetClosestVehicle(ChopCarLocation[1]["x"], ChopCarLocation[1]["y"], ChopCarLocation[1]["z"], 4.001, 0, 70)
	if chopdoor1 then
		SetVehicleDoorOpen(veh, 0, false, false)
		TaskStartScenarioInPlace(plyPed, "WORLD_HUMAN_WELDING", 0, true)
		
		RLCore.Functions.Progressbar("remove_door", "Taking off Door...", 10000, false, true, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function()
			SetVehicleDoorBroken(veh, 0, true)
			ClearPedTasksImmediately(plyPed)
			chopdoor1 = false
			door1gone = true
			disablecontrols = false
			local PackageObject = CreateObject(GetHashKey("prop_car_door_01"), CarParts[1]["x"], CarParts[1]["y"], CarParts[1]["z"], true)
			SetEntityCollision(PackageObject, false, false)
			PlaceObjectOnGroundProperly(PackageObject)
			Citizen.Wait(1000)
			CarryingPart(PackageObject)
			Citizen.Wait(500)
			TriggerServerEvent('tp-scrapyard:success', 0, "glass")
		end)
	end
	if chopdoor2 then
		SetVehicleDoorOpen(veh, 1, false, false)
		TaskStartScenarioInPlace(plyPed, "WORLD_HUMAN_WELDING", 0, true)
		RLCore.Functions.Progressbar("remove_door", "Taking off Door...", 10000, false, true, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function()
			SetVehicleDoorBroken(veh, 1, true)
			ClearPedTasksImmediately(plyPed)
			chopdoor2 = false
			door2gone = true
			disablecontrols = false
			local PackageObject = CreateObject(GetHashKey("prop_car_door_01"), CarParts[2]["x"], CarParts[2]["y"], CarParts[2]["z"], true)
			SetEntityCollision(PackageObject, false, false)
			PlaceObjectOnGroundProperly(PackageObject)
			Citizen.Wait(1000)
			CarryingPart(PackageObject)
			Citizen.Wait(500)
			TriggerServerEvent('tp-scrapyard:success', 0, "glass")
		end)

	 end
	 if chopdoor3 then
		SetVehicleDoorOpen(veh, 2, false, false)
		TaskStartScenarioInPlace(plyPed, "WORLD_HUMAN_WELDING", 0, true)

		RLCore.Functions.Progressbar("remove_door", "Taking off Door...", 10000, false, true, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function()
			SetVehicleDoorBroken(veh, 2, true)
			ClearPedTasksImmediately(plyPed)
			chopdoor3 = false
			door3gone = true
			disablecontrols = false
			local PackageObject = CreateObject(GetHashKey("prop_car_door_01"), CarParts[3]["x"], CarParts[3]["y"], CarParts[3]["z"], true)
			SetEntityCollision(PackageObject, false, false)
			PlaceObjectOnGroundProperly(PackageObject)
			Citizen.Wait(1000)
			CarryingPart(PackageObject)
			Citizen.Wait(500)
			TriggerServerEvent('tp-scrapyard:success', 0, "glass")
		end)
	 end
	 if chopdoor4 then
		SetVehicleDoorOpen(veh, 3, false, false)
		TaskStartScenarioInPlace(plyPed, "WORLD_HUMAN_WELDING", 0, true)

		RLCore.Functions.Progressbar("remove_door", "Taking off Door...", 10000, false, true, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function()
			SetVehicleDoorBroken(veh, 3, true)
			ClearPedTasksImmediately(plyPed)
			chopdoor4 = false
			door4gone = true
			disablecontrols = false
			local PackageObject = CreateObject(GetHashKey("prop_car_door_01"), CarParts[4]["x"], CarParts[4]["y"], CarParts[4]["z"], true)
			SetEntityCollision(PackageObject, false, false)
			PlaceObjectOnGroundProperly(PackageObject)
			Citizen.Wait(1000)
			CarryingPart(PackageObject)
			Citizen.Wait(500)
			TriggerServerEvent('tp-scrapyard:success', 0, "glass")
		end)
	end
	if chopdoor5 then
		SetVehicleDoorOpen(veh, 4, false, false)
		TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)

		RLCore.Functions.Progressbar("remove_door", "Taking off Hood...", 10000, false, true, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function()
			SetVehicleDoorBroken(veh, 4, true)
			ClearPedTasksImmediately(plyPed)
			chopdoor5 = false
			door5gone = true
			disablecontrols = false
			local PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), CarParts[5]["x"], CarParts[5]["y"], CarParts[5]["z"], true)
			SetEntityCollision(PackageObject, false, false)
			PlaceObjectOnGroundProperly(PackageObject)
			Citizen.Wait(1000)
			CarryingPartHood(PackageObject)
			Citizen.Wait(500)
			TriggerServerEvent('tp-scrapyard:success', 0, "metalscrap")
		end)
	 end
	if chopdoor6 then
		SetVehicleDoorOpen(veh, 5, false, false)
		TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
		RLCore.Functions.Progressbar("remove_door", "Taking off Trunk...", 10000, false, true, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function()
			SetVehicleDoorBroken(veh, 5, true)
			ClearPedTasksImmediately(plyPed)
			chopdoor6 = false
			door6gone = true
			disablecontrols = false
			local PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), CarParts[6]["x"], CarParts[6]["y"], CarParts[6]["z"], true)
			SetEntityCollision(PackageObject, false, false)
			PlaceObjectOnGroundProperly(PackageObject)
			Citizen.Wait(1000)
			CarryingPartHood(PackageObject)
			Citizen.Wait(500)
			TriggerServerEvent('tp-scrapyard:success', 0, "metalscrap")
			
		end)
	 end
	 if chopdoor7 then
		TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
		RLCore.Functions.Progressbar("remove_door", "Taking radio...", 10000, false, true, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function()
			ClearPedTasksImmediately(plyPed)
			chopdoor7 = false
			door7gone = true
			disablecontrols = false
			local PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), CarParts[1]["x"], CarParts[1]["y"] + 0.1, CarParts[1]["z"], true)
			SetEntityCollision(PackageObject, false, false)
			PlaceObjectOnGroundProperly(PackageObject)
			Citizen.Wait(1000)
			CarryingPartHood(PackageObject)
			Citizen.Wait(500)
			TriggerServerEvent('tp-scrapyard:success', 0, "copper")
		end)
	 end
	 if chopdoor8 then
		TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
		RLCore.Functions.Progressbar("remove_door", "Removing battery...", 10000, false, true, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function()
			ClearPedTasksImmediately(plyPed)
			chopdoor8 = false
			door8gone = true
			door8delivered = true-- 0 = no money
			TriggerServerEvent('tp-scrapyard:success', 0, "plastic")
			Citizen.Wait(500) 
			TriggerServerEvent('tp-scrapyard:success', 0, "rubber")
			Citizen.Wait(500)
			disablecontrols = false
		end)
	 end

end
--
--[[ Door 1 ]]
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if allowedchop and chopstarted and not door1gone and not door1delivered then 
				DrawMarker(27,CarParts[1]["x"], CarParts[1]["y"], CarParts[1]["z"] - 1.0, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[1]["x"], CarParts[1]["y"], CarParts[1]["z"], true ) < 1.2 and IsPedStill(GetPlayerPed(-1)) then 
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[1]["x"], CarParts[1]["y"], CarParts[1]["z"], true ) < 1.2 and not chopdoor1 then
					 Draw3DText2(CarParts[1]["x"], CarParts[1]["y"], CarParts[1]["z"] - 0.1, tostring("[E] Chop Door"))
					end 
				
					if(IsControlJustPressed(1, Keys["E"])) then
					disablecontrols = true
					chopdoor1 = true
					ChopDoors()
					end
			end
	  end
	  if allowedchop and chopstarted and not door2gone and door1delivered and not door2delivered then 
				DrawMarker(27,CarParts[2]["x"], CarParts[2]["y"], CarParts[2]["z"] - 0.8, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[2]["x"], CarParts[2]["y"], CarParts[2]["z"], true ) < 1.2 and IsPedStill(GetPlayerPed(-1)) then 
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[2]["x"], CarParts[2]["y"], CarParts[2]["z"], true ) < 1.2 and not chopdoor2 then
					 Draw3DText2(CarParts[2]["x"], CarParts[2]["y"], CarParts[2]["z"] - 0.1, tostring("[E] Chop Door"))
					end 
				
					if(IsControlJustPressed(1, Keys["E"])) then
					disablecontrols = true
					chopdoor2 = true
					ChopDoors()
					end
			end
	  end
	  if allowedchop and chopstarted and not door3gone and door2delivered and not door3delivered then 
				DrawMarker(27,CarParts[3]["x"], CarParts[3]["y"], CarParts[3]["z"] - 0.8, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[3]["x"], CarParts[3]["y"], CarParts[3]["z"], true ) < 1.2 and IsPedStill(GetPlayerPed(-1)) then 
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[3]["x"], CarParts[3]["y"], CarParts[3]["z"], true ) < 1.2 and not chopdoor3 then
					 Draw3DText2(CarParts[3]["x"], CarParts[3]["y"], CarParts[3]["z"] - 0.1, tostring("[E] Chop Door"))
					end 
				
					if(IsControlJustPressed(1, Keys["E"])) then
					disablecontrols = true
					chopdoor3 = true
					ChopDoors()
					end
			end
	  end
	  if allowedchop and chopstarted and not door4gone and door3delivered and not door4delivered then 
				DrawMarker(27,CarParts[4]["x"], CarParts[4]["y"], CarParts[4]["z"] - 0.8, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[4]["x"], CarParts[4]["y"], CarParts[4]["z"], true ) < 1.2 and IsPedStill(GetPlayerPed(-1)) then 
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[4]["x"], CarParts[4]["y"], CarParts[4]["z"], true ) < 1.2 and not chopdoor4 then
					 Draw3DText2(CarParts[4]["x"], CarParts[4]["y"], CarParts[4]["z"] - 0.1, tostring("[E] Chop Door"))
					end 
				
					if(IsControlJustPressed(1, Keys["E"])) then
					disablecontrols = true
					chopdoor4 = true
					ChopDoors()
					end
			end
	  end
	  if allowedchop and chopstarted and not door5gone and door4delivered and not door5delivered then 
				DrawMarker(27,CarParts[5]["x"], CarParts[5]["y"], CarParts[5]["z"] - 0.8, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[5]["x"], CarParts[5]["y"], CarParts[5]["z"], true ) < 1.2 and IsPedStill(GetPlayerPed(-1)) then 
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[5]["x"], CarParts[5]["y"], CarParts[5]["z"], true ) < 1.2 and not chopdoor5 then
					 Draw3DText2(CarParts[5]["x"], CarParts[5]["y"], CarParts[5]["z"] - 0.1, tostring("[E] Chop Hood"))
					end 
				
					if(IsControlJustPressed(1, Keys["E"])) then
					disablecontrols = true
					chopdoor5 = true
					ChopDoors()
					end
			end
	  end
	  if allowedchop and chopstarted and not door6gone and door5delivered and not door6delivered then 
				DrawMarker(27,CarParts[6]["x"], CarParts[6]["y"], CarParts[6]["z"] - 0.8, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[6]["x"], CarParts[6]["y"], CarParts[6]["z"], true ) < 1.2 and IsPedStill(GetPlayerPed(-1)) then 
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[6]["x"], CarParts[6]["y"], CarParts[6]["z"], true ) < 1.2 and not chopdoor6 then
					 Draw3DText2(CarParts[6]["x"], CarParts[6]["y"], CarParts[6]["z"] - 0.1, tostring("[E] Chop Trunk"))
					end 
				
					if(IsControlJustPressed(1, Keys["E"])) then
					disablecontrols = true
					chopdoor6 = true
					ChopDoors()
					end
			end
	  end
	  if allowedchop and chopstarted and not door7gone and door6delivered and not door7delivered then 
				DrawMarker(27,CarParts[1]["x"], CarParts[1]["y"], CarParts[1]["z"] - 0.8, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[1]["x"], CarParts[1]["y"], CarParts[1]["z"], true ) < 1.2 and IsPedStill(GetPlayerPed(-1)) then 
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[1]["x"], CarParts[1]["y"], CarParts[1]["z"], true ) < 1.2 and not chopdoor7 then
					 Draw3DText2(CarParts[1]["x"], CarParts[1]["y"], CarParts[1]["z"] - 0.1, tostring("[E] Take Radio"))
					end 
				
					if(IsControlJustPressed(1, Keys["E"])) then
					disablecontrols = true 
					chopdoor7 = true
					ChopDoors()
					end
			end
	  end
	  if allowedchop and chopstarted and not door8gone and door7delivered and not door8delivered then 
		DrawMarker(27,CarParts[1]["x"], CarParts[1]["y"], CarParts[1]["z"] - 0.8, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[1]["x"], CarParts[1]["y"], CarParts[1]["z"], true ) < 1.2 and IsPedStill(GetPlayerPed(-1)) then 
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[1]["x"], CarParts[1]["y"], CarParts[1]["z"], true ) < 1.2 and not chopdoor8 then
			 Draw3DText2(CarParts[1]["x"], CarParts[1]["y"], CarParts[1]["z"] - 0.1, tostring("[E] Take Battery"))
			end 
		
			if(IsControlJustPressed(1, Keys["E"])) and not chopdoor8 then
			disablecontrols = true 
			chopdoor8 = true
			ChopDoors()
			end
	end
end
	   if allowedchop and chopstarted and door1delivered and door2delivered and door3delivered and door4delivered and door5delivered and door6delivered and door7delivered and door8delivered then 
				DrawMarker(27,ChopCarLocation[2]["x"], ChopCarLocation[2]["y"], ChopCarLocation[2]["z"] - 0.8, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), ChopCarLocation[2]["x"], ChopCarLocation[2]["y"], ChopCarLocation[2]["z"], true ) < 1.2 and IsPedStill(GetPlayerPed(-1)) then 
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), ChopCarLocation[2]["x"], ChopCarLocation[2]["y"], ChopCarLocation[2]["z"], true ) < 1.2 and not chopdoor7 then
					 Draw3DText2(ChopCarLocation[2]["x"], ChopCarLocation[2]["y"], ChopCarLocation[2]["z"] - 0.1, tostring("[E] Chop Entire Vehicle"))
					end 
				
					if(IsControlJustPressed(1, Keys["E"])) then
					disablecontrols = false
					FinishedChopping()
					end
			end
	  end
	  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), CarParts[1]["x"], CarParts[1]["y"], CarParts[1]["z"], true ) > 50 and chopstarted then 
	  	tofaraway()
	  end
	end
end)


Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if allowedchop and not chopstarted then 
            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and not IsPedOnAnyBike(GetPlayerPed(-1)) then              

                    DrawMarker(20,ChopCarLocation[1]["x"], ChopCarLocation[1]["y"], ChopCarLocation[1]["z"], 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), ChopCarLocation[1]["x"], ChopCarLocation[1]["y"], ChopCarLocation[1]["z"], true ) < 1.2 then 
                        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), ChopCarLocation[1]["x"], ChopCarLocation[1]["y"], ChopCarLocation[1]["z"], true ) < 1.2 then
                        Draw3DText2(ChopCarLocation[1]["x"], ChopCarLocation[1]["y"], ChopCarLocation[1]["z"] - 0.1, tostring("[E] Chop This Vehicle"))
                        end 
                    

                        local myped = GetPlayerPed(-1)
                        local vehicle2 = GetVehiclePedIsIn(myped, false)   

                        if(IsControlJustReleased(0, Keys["E"])) then
                            if (GetPedInVehicleSeat(vehicle2, -1) == myped) then
                                if not clientcooldown then

                                -- Force other peds out the vehicle server side
                                local plate = GetVehicleNumberPlateText(vehicle2)
                                TriggerServerEvent('tp-scrapyard:exitVehicle', plate)

                                StartChopThisCar()

                                Citizen.Wait(1000)
                                clientcooldown = true
                                end
                                if clientcooldown and not chopstarted then
									RLCore.Functions.Notify('There is currently a cooldown for you, You must wait longer before doing this again.', 'error')
                                end
                            else
								RLCore.Functions.Notify('You need to be the driver.', 'error')
                                print("no")
                            end
                        end
                    end
                    

			end
	  	end
	end
end)

RegisterNetEvent('tp-scrapyard:clExitVehicle')
AddEventHandler('tp-scrapyard:clExitVehicle', function(plate)
    local myped = GetPlayerPed(-1)
    local myvehicle = GetVehiclePedIsIn(myped, false)
    local myPlate = GetVehicleNumberPlateText(myvehicle)
    print(json.encode(myPlate))
    print(json.encode(plate))
    if myPlate == plate then
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), ChopCarLocation[1]["x"], ChopCarLocation[1]["y"], ChopCarLocation[1]["z"], true ) < 5.0 then 
            TaskLeaveAnyVehicle(myped)
            print("exiting")
        end
    end
end)

Citizen.CreateThread(function ()
	while true do
	Citizen.Wait(0)
	if clientcooldown then
		Citizen.Wait(900000)
		clientcooldown = false
	end 

	end

end)


function FinishedChopping()
	TriggerServerEvent('tp-scrapyard:success', math.random(30,100))
	local vehchopping = GetClosestVehicle(ChopCarLocation[1]["x"], ChopCarLocation[1]["y"], ChopCarLocation[1]["z"], 4.001, 0, 70)
	chopstarted = false
	SetEntityAsNoLongerNeeded(vehchopping)
	DeleteEntity(vehchopping)
	RLCore.Functions.Notify('Sucessfully Chopped The Vehicle.', 'success')
	ResetChopping()
end

function ResetChopping()
	disablecontrols = false
	allowedchop = true
	payout = math.random(25,75)
	chopstarted = false
	chopdoor1 = false
	door1gone = false
	door1delivered = false
	chopdoor2 = false
	door2gone = false
	door2delivered = false
	chopdoor3 = false
	door3gone = false
	door3delivered = false
	chopdoor4 = false
	door4gone = false
	door4delivered = false
	chopdoor5 = false
	door5gone = false
	door5delivered = false
	chopdoor6 = false
	door6gone = false
	door6delivered = false
	chopdoor7 = false
	door7gone = false
	door7delivered = false
	chopdoor8 = false
	door8gone = false
	door8delivered = false
	deliveryspot = false
end

function tofaraway()
	local vehchopping = GetClosestVehicle(ChopCarLocation[1]["x"], ChopCarLocation[1]["y"], ChopCarLocation[1]["z"], 4.001, 0, 70)
	chopstarted = false
	DeleteEntity(vehchopping)
	RLCore.Functions.Notify('You moved to far away.', 'error')
end


function StartChopThisCar()
	local ped = GetPlayerPed(-1)
	local veh2 = GetVehiclePedIsIn (GetPlayerPed (-1), true)
	local vehiclePedIsIn = GetVehiclePedIsIn(ped, false)
	SetEntityCoords(veh2, ChopCarLocation[1]["x"], ChopCarLocation[1]["y"], ChopCarLocation[1]["z"])
	SetEntityHeading(veh2, 27.77)
	Citizen.Wait(1)
	SetVehicleEngineOn(veh2, false, true)
	Citizen.Wait(1)
	SetVehicleDoorOpen(veh2, 0, false, true)
	Citizen.Wait(1)
	SetVehicleDoorOpen(veh2, 1, false, true)
	Citizen.Wait(1)
	SetVehicleDoorOpen(veh2, 2, false, true)
	Citizen.Wait(1)
	SetVehicleDoorOpen(veh2, 3, false, true)
	Citizen.Wait(1)
	SetVehicleDoorOpen(veh2, 4, false, true)
	Citizen.Wait(1)
	SetVehicleDoorOpen(veh2, 5, false, true)
	Citizen.Wait(1)
	FreezeEntityPosition(veh2, true)
	Citizen.Wait(1)
	TaskLeaveVehicle(ped, vehiclePedIsIn, 256)
	SetVehicleDoorsLocked(veh2, 2)
	SetEntityAsMissionEntity(veh2)
	Citizen.Wait(1000)
	chopstarted = true
end

function Draw3DText2(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*1
    local fov = (1/GetGameplayCamFov())*100
    local scale = 0.9
   
    if onScreen then
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
end


function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end
