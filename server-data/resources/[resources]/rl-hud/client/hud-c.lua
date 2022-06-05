local oxygenTank = 25.0
local oxyOn = false
local attachedProp = 0
local attachedProp2 = 0
local lownotify = 0
local toghud = false
local mumbleInfo = 2
local svrId = GetPlayerServerId(PlayerId())
local zoomLevels = { 900, 1000, 1100, 1200, 1300, 1400 }
local currZoom = 1

local speed = 0.0
local seatbeltOn = false
local cruiseOn = false
local bleedingPercentage = 0
local hunger = 100
local thirst = 100
Fuel = 0
stress = 0

RegisterNetEvent("rl-hud-player:client:SpawnedIn")
AddEventHandler("rl-hud-player:client:SpawnedIn", function(bool) -- Handles setting hud once you have spawned in, instead of always 
    toghud = bool
end)

RegisterCommand('hud', function()
	if toghud then 
		TriggerEvent('hud:toggleui', false)
	else 
		TriggerEvent('hud:toggleui', true)
	end 
end)

RegisterNetEvent('hud:toggleui')
AddEventHandler('hud:toggleui', function(show)
    toghud = show
end)

RegisterNetEvent('mumble:updateMumbleInfo')
AddEventHandler('mumble:updateMumbleInfo', function(mode)
	mumbleInfo = mode
end)

RegisterNetEvent("hud:client:UpdateNeeds")
AddEventHandler("hud:client:UpdateNeeds", function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
end)

--General UI Updates
Citizen.CreateThread(function()
    -- Hide North Blip (Only need to call on resource start)
	local northBlip = GetNorthRadarBlip()
    SetBlipAlpha(northBlip, 0)

    Citizen.Wait(0)
    while true do
        local player = PlayerPedId()
        local health = (GetEntityHealth(player) - 100)
        local armor = GetPedArmour(player)
		local oxy = oxygenTank
        local talking = false
        local iTalking = exports['tokovoip_script']:getPlayerData(GetPlayerServerId(PlayerId()), 'radio:talking') ~= nil and 
		exports['tokovoip_script']:getPlayerData(GetPlayerServerId(PlayerId()), 'radio:talking') == true and 'radio' or 
		exports['tokovoip_script']:getPlayerData(GetPlayerServerId(PlayerId()), "voip:talking") ~= nil and 
		exports['tokovoip_script']:getPlayerData(GetPlayerServerId(PlayerId()), "voip:talking") == 1 and 'normal' or false
        
        SendNUIMessage({
            action = 'updateStatusHud',
            show = toghud, 
            health = health,
            armour = armor,
			oxygen = oxy,
			--mumble = mumbleInfo,
			talking = iTalking,
			proximity = exports['tokovoip_script']:getPlayerData(GetPlayerServerId(PlayerId()), "voip:mode")
		})
        Citizen.Wait(200)
    end
end)



--Food Thirst
Citizen.CreateThread(function()
	while true do
        SendNUIMessage({
            action = "updateStatusHud",
            show = toghud,
            hunger = hunger,
            thirst = thirst,
            stress = stress,
        })
        Citizen.Wait(2500)
    end
end)

-- Map Zoom Handler
Citizen.CreateThread(function()
    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
    Wait(500)
    SetRadarZoom(zoomLevels[currZoom])
end)

RegisterCommand( "map_zoom_in", function()
    if currZoom == 1 then
        currZoom = #zoomLevels
    else
        currZoom = currZoom - 1
    end
    SetRadarZoom(zoomLevels[currZoom])
end)

RegisterCommand( "map_zoom_out", function()
    if currZoom == #zoomLevels then
        currZoom = 1
    else
        currZoom = currZoom + 1
    end
    SetRadarZoom(zoomLevels[currZoom])
end)

RegisterKeyMapping( "map_zoom_in", "Zoom in your mini map", "keyboard", "")
RegisterKeyMapping( "map_zoom_out", "Zoom out your mini map", "keyboard", "")

--[[ Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        local health = (GetEntityHealth(player) - 100)
        print(health)
        Citizen.Wait(5000)
    end
end) ]]



oxygenTank = 25.0
oxyOn = false
attachedProp = 0
attachedProp2 = 0

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function VehicleInFront()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 3.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end

--[[ RegisterCommand('oxyy', function()
	TriggerEvent('police:woxy')
end) ]]



RegisterNetEvent('police:woxy')
AddEventHandler('police:woxy', function()
	local vehFront = VehicleInFront()
	if vehFront > 0 then
		TriggerServerEvent("oxygengear:RemoveGear")
		loadAnimDict('anim@narcotics@trash')
		TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',0.9, -8, 3800, 49, 3.0, 0, 0, 0)	
        RLCore.Functions.Progressbar("equip_gear", "Oxygen Tank", 10000, false, true, {}, {}, {}, {}, function()

        loadAnimDict('anim@narcotics@trash')
        TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',0.9, -8, 1900, 49, 3.0, 0, 0, 0)	  		
        TriggerEvent("UseOxygenTank")
        --SetEnableScuba(PlayerPedId(),true)
        end)

	else
        RLCore.Functions.Notify('You need to be near a vehicle to do this.', 'error')
	end
end)

RegisterNetEvent("RemoveOxyTank")
AddEventHandler("RemoveOxyTank",function()
	if oxygenTank > 25.0 then
		oxygenTank = 25.0
		TriggerEvent('menu:hasOxygenTank', false)
	end
end)

RegisterNetEvent("UseOxygenTank")
AddEventHandler("UseOxygenTank",function()
	oxygenTank = 100.0
	TriggerEvent('menu:hasOxygenTank', true) 
end)

Citizen.CreateThread(function()

	while true do
		Wait(1)
		if oxygenTank > 0 and IsPedSwimmingUnderWater(PlayerPedId()) then
			SetPedDiesInWater(PlayerPedId(), false)
			if oxygenTank > 25.0 then
				oxygenTank = oxygenTank - 0.005
			else
				oxygenTank = oxygenTank - 2.0
			end
		else
			if IsPedSwimmingUnderWater(PlayerPedId()) then
				oxygenTank = oxygenTank - 0.1
				SetPedDiesInWater(PlayerPedId(), true)
			end
		end

		if not IsPedSwimmingUnderWater( PlayerPedId() ) and oxygenTank < 25.0 then
			oxygenTank = oxygenTank + 0.01
			if oxygenTank > 25.0 then
				oxygenTank = 25.0
			end
		end

		if oxygenTank > 25.0 and not oxyOn then
			oxyOn = true
			attachProp("p_s_scuba_tank_s", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
			attachProp2("p_s_scuba_mask_s", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
		elseif oxyOn and oxygenTank <= 25.0 then
			oxyOn = false
			removeAttachedProp()
			removeAttachedProp2()
		end
		if not oxyOn then
			Wait(1000)
		end
	end
end)

function removeAttachedProp2()
	DeleteEntity(attachedProp2)
	attachedProp2 = 0
end
function removeAttachedProp()
	DeleteEntity(attachedProp)
	attachedProp = 0
end
function attachProp2(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp2()
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp2 = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	--exports["isPed"]:GlobalObject(attachedProp2)
	AttachEntityToEntity(attachedProp2, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded(attachModel)
end
function attachProp(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp()
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent 
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	--exports["isPed"]:GlobalObject(attachedProp)
	AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded(attachModel)
end