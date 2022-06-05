RLCore = nil

local Keys = {
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

Citizen.CreateThread(function()
    while RLCore == nil do
        Citizen.Wait(10)
        TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
	end

	while RLCore.Functions.GetPlayerData().job == nil do
		Wait(10)
	end

	RefreshBlip()
end)

RegisterNetEvent('RLCore:Client:OnJobUpdate')
AddEventHandler('RLCore:Client:OnJobUpdate', function()
	RefreshBlip()
end)

local tasking = false
local drugStorePed = 0
local oxyVehicle = 0

local OxyDropOffs = {
	[1] =  { ['x'] = -1308.05,['y'] = -924.92,['z'] = 11.28,['h'] = 294.06, ['info'] = ' East Side 1' },
	[2] =  { ['x'] = -1229.20,['y'] = -1086.34,['z'] = 8.24,['h'] = 107.72, ['info'] = ' East Side 2' },
	[3] =  { ['x'] = -1156.28,['y'] = -1217.90,['z'] = 6.92,['h'] = 105.56, ['info'] = ' East Side 3' },
	[4] =  { ['x'] = -1105.34,['y'] = -1365.19,['z'] = 5.15,['h'] = 203.09, ['info'] = ' East Side 4' },
	[5] =  { ['x'] = -1092.91,['y'] = -1506.26,['z'] = 4.85,['h'] = 38.92, ['info'] = ' East Side 5' },
	[6] =  { ['x'] = -970.15,['y'] = -1579.94,['z'] = 5.17,['h'] = 193.12, ['info'] = ' East Side 6' },
	[7] =  { ['x'] = -1274.77,['y'] = -1365.29,['z'] = 4.30,['h'] = 287.63, ['info'] = ' East Side 7' },
	[8] =  { ['x'] = -1321.1,['y'] = -1251.65,['z'] = 4.59,['h'] = 234.40, ['info'] = ' East Side 8' },
	[9] =  { ['x'] = -1379.22,['y'] = -1069.07,['z'] = 4.29,['h'] = 111.52, ['info'] = ' East Side 9' },
	[10] =  { ['x'] = -1331.33,['y'] = -811.03,['z'] = 17.25,['h'] = 58.18, ['info'] = ' East Side 10' },
	[11] =  { ['x'] = -1398.35,['y'] = -656.08,['z'] = 28.67,['h'] = 305.60, ['info'] = ' East Side 11' },
	[12] =  { ['x'] = -1455.07,['y'] = -691.63,['z'] = 26.33,['h'] = 323.58, ['info'] = ' East Side 12' },
	[13] =  { ['x'] = -1305.76,['y'] = -613.01,['z'] = 27.44,['h'] = 217.23, ['info'] = ' East Side 13' },
	[14] =  { ['x'] = -1160.46,['y'] = -1270.30,['z'] = 6.17,['h'] = 201.10, ['info'] = ' East Side 14' },
	[15] =  { ['x'] = -1586.62,['y'] = -465.20,['z'] = 37.23,['h'] = 137.94, ['info'] = ' Central 1' },
	[16] =  { ['x'] = -1505.55,['y'] = -525.99,['z'] = 32.80,['h'] = 213.32, ['info'] = ' Central 2' },
	[17] =  { ['x'] = -1222.62,['y'] = -710.26,['z'] = 22.31,['h'] = 306.30, ['info'] = ' Central 3' },  -- stop here
	[18] =  { ['x'] = -951.75,['y'] = -1079.19,['z'] = 2.15,['h'] = 207.62, ['info'] = ' Central 4' },
	[19] =  { ['x'] = -1210.79,['y'] = -1070.46,['z'] = 8.34,['h'] = 293.15, ['info'] = ' Central 5' },
	[20] =  { ['x'] = -1348.62,['y'] = -760.21,['z'] = 22.45,['h'] = 308.75, ['info'] = ' Central 6' },
}

local carspawns = {
	[1] = { ['x'] = -602.80, ['y'] = -1211.50, ['z'] = 14.43, ['h'] = 309.22 },
	[2] = { ['x'] = -604.75, ['y'] = -1218.59, ['z'] = 14.46, ['h'] = 312.13 },
	[3] = { ['x'] = -607.56, ['y'] = -1216.22, ['z'] = 14.41, ['h'] = 307.54 },
	[4] = { ['x'] = -610.24, ['y'] = -1213.88, ['z'] = 14.36, ['h'] = 309.49 },
	[5] = { ['x'] = -612.57, ['y'] = -1210.93, ['z'] = 14.37, ['h'] = 310.95 },
	--[6] = { ['x'] = 438.24487, ['y'] = -1476.688, ['z'] = 29.030601, ['h'] = 288.40783 },
	--[7] = { ['x'] = 437.02474, ['y'] = -1473.884, ['z'] = 29.031976, ['h'] = 289.71829 },
}

local pillWorker = { ['x'] = -635.80, ['y'] = -1247.88, ['z'] = -32.14, ['h'] = 134.37 }

local rnd = 0
local blip = 0
local deliveryPed = 0

local oxyPeds = {
	'g_m_y_mexgang_01',
	'g_m_y_mexgoon_01',
	'g_m_y_mexgoon_02',
	'g_m_y_mexgoon_03'
}

local drugLocs = {
	[1] =  { ['x'] = 0.0,['y'] = 0.0,['z'] = 0.0,['h'] = 0.0, ['info'] = ' Grove Stash' },
	[2] =  { ['x'] = 0.0,['y'] = 0.0,['z'] = 0.0,['h'] = 0.0, ['info'] = ' East Side' },
	[3] =  { ['x'] = 0.0,['y'] = 0.0,['z'] = 0.0,['h'] = 0.0, ['info'] = ' Wei Cheng' },
}

local carpick = {
    [1] = "speedo",
}

function CreateOxyVehicle()

	if DoesEntityExist(oxyVehicle) then

	    SetVehicleHasBeenOwnedByPlayer(oxyVehicle,false)
		SetEntityAsNoLongerNeeded(oxyVehicle)
		DeleteEntity(oxyVehicle)
	end

    local car = GetHashKey(carpick[math.random(#carpick)])
    RequestModel(car)
    while not HasModelLoaded(car) do
        Citizen.Wait(0)
    end

    local spawnpoint = 1
    for i = 1, #carspawns do
	    local caisseo = GetClosestVehicle(carspawns[i]["x"], carspawns[i]["y"], carspawns[i]["z"], 3.500, 0, 70)
		if not DoesEntityExist(caisseo) then
			spawnpoint = i
		end
    end

    oxyVehicle = CreateVehicle(car, carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"], carspawns[spawnpoint]["h"], true, false)
	SetEntityInvincible(oxyVehicle, true)
    local plt = GetVehicleNumberPlateText(oxyVehicle)
	SetVehicleHasBeenOwnedByPlayer(oxyVehicle,true)
	TriggerEvent("vehiclekeys:client:SetOwner", plt, oxyVehicle)
	SetEntityInvincible(oxyVehicle, false)

    while true do
    	Citizen.Wait(1)
    	 DrawText3Ds(carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"], "Your Delivery Car (Stolen).")
    	 if #(GetEntityCoords(PlayerPedId()) - vector3(carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"])) < 8.0 then
    	 	return
    	 end
    end
end

function CreateOxyPed()

    local hashKey = `g_m_y_mexgoon_03`

    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end


	deliveryPed = CreatePed(pedType, hashKey, OxyDropOffs[rnd]["x"],OxyDropOffs[rnd]["y"],OxyDropOffs[rnd]["z"], OxyDropOffs[rnd]["h"], 1, 0)
	
    ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)

    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    searchPockets()
    SetPedKeepTask(deliveryPed, true)
end

function DeleteCreatedPed()
	print("suh wuss good?")
	if DoesEntityExist(deliveryPed) then 
		SetPedKeepTask(deliveryPed, false)
		TaskSetBlockingOfNonTemporaryEvents(deliveryPed, false)
		ClearPedTasks(deliveryPed)
		TaskWanderStandard(deliveryPed, 10.0, 10)
		SetPedAsNoLongerNeeded(deliveryPed)

		Citizen.Wait(20000)
		DeletePed(deliveryPed)
	end
end

function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

function CreateBlip()
	DeleteBlip()
	if OxyRun then
		blip = AddBlipForCoord(OxyDropOffs[rnd]["x"],OxyDropOffs[rnd]["y"],OxyDropOffs[rnd]["z"])
	end
    
    SetBlipSprite(blip, 514)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Drop Off")
    EndTextCommandSetBlipName(blip)
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function searchPockets()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then 
        loadAnimDict( "random@mugging4" )
        TaskPlayAnim( deliveryPed, "random@mugging4", "agitated_loop_a", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    end
end

function giveAnim()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then 
        loadAnimDict( "mp_safehouselost@" )
        if ( IsEntityPlayingAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 3 ) ) then 
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
			TriggerEvent("attachItemDrugs","cashcase01", deliveryPed)
        else
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
			TriggerEvent("attachItemDrugs","cashcase01", deliveryPed)
        end     
    end
end

function DoDropOff()
	local success = true
	local OxyChance = math.random(1,1000)

	searchPockets()
	Citizen.Wait(1500)

	PlayAmbientSpeech1(deliveryPed, "Chat_State", "Speech_Params_Force")

	if DoesEntityExist(deliveryPed) and not IsEntityDead(deliveryPed) then

		local counter = math.random(50,200)
		while counter > 0 do
			local crds = GetEntityCoords(deliveryPed)
			counter = counter - 1
			Citizen.Wait(1)
		end
	
		if success then
			local counter = math.random(100,300)
			while counter > 0 do
				local crds = GetEntityCoords(deliveryPed)
				counter = counter - 1
				Citizen.Wait(1)
			end
			giveAnim()
		end
	
		local crds = GetEntityCoords(deliveryPed)
		local crds2 = GetEntityCoords(PlayerPedId())
	
		if #(crds - crds2) > 3.0 or not DoesEntityExist(deliveryPed) or IsEntityDead(deliveryPed) then
			success = false
		end
		
		DeleteBlip()
		if success then

			if OxyChance <= Config.OxyChance then
				TriggerServerEvent("oxydelivery:receiveoxy")
			elseif OxyChance <= Config.BigRewarditemChance then
				TriggerServerEvent("oxydelivery:receiveoxy")
			else
				TriggerServerEvent("oxydelivery:receiveoxy")
			end

			Citizen.Wait(2000)
			RLCore.Functions.Notify('I got the call in, delivery was on point, go await the next one!', "error")
		else
			RLCore.Functions.Notify('The drop off failed.', "error")
		end
	
		DeleteCreatedPed()
	end
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

RegisterNetEvent("oxydelivery:client")
AddEventHandler("oxydelivery:client", function()

	if tasking then
		return
	end
	
	rnd = math.random(1,#OxyDropOffs)

	CreateBlip()

	local pedCreated = false

	tasking = true
	local toolong = 600000
	while tasking do

		Citizen.Wait(1)
		local plycoords = GetEntityCoords(PlayerPedId())
		local dstcheck = #(plycoords - vector3(OxyDropOffs[rnd]["x"],OxyDropOffs[rnd]["y"],OxyDropOffs[rnd]["z"])) 
		local oxyVehCoords = GetEntityCoords(oxyVehicle)
		local dstcheck2 = #(plycoords - oxyVehCoords) 

		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		if dstcheck < 40.0 and not pedCreated and (oxyVehicle == veh or dstcheck2 < 15.0) then
			pedCreated = true
			DeleteCreatedPed()
			CreateOxyPed()
			RLCore.Functions.Notify('You are close to the drop off.')
		end
		toolong = toolong - 1
		if toolong < 0 then

		    SetVehicleHasBeenOwnedByPlayer(oxyVehicle,false)
			SetEntityAsNoLongerNeeded(oxyVehicle)
			tasking = false
			OxyRun = false
			RLCore.Functions.Notify('You are no longer selling Oxy due to taking too long to drop off.', "error")
		end
		if dstcheck < 2.0 and pedCreated then

			local crds = GetEntityCoords(deliveryPed)
			DrawText3Ds(crds["x"],crds["y"],crds["z"], "[E]")  

			if not IsPedInAnyVehicle(PlayerPedId()) and IsControlJustReleased(0,38) then
				TaskTurnPedToFaceEntity(deliveryPed, PlayerPedId(), 1.0)
				Citizen.Wait(1500)
				PlayAmbientSpeech1(deliveryPed, "Generic_Hi", "Speech_Params_Force")
				DoDropOff()
				tasking = false
			end
		end
	end
	
	DeleteCreatedPed()
	DeleteBlip()
end)


Citizen.CreateThread(function()

    while true do

	    Citizen.Wait(1)
	    local dropOff6 = #(GetEntityCoords(PlayerPedId()) - vector3(pillWorker["x"],pillWorker["y"],pillWorker["z"]))

		if dropOff6 < 1.6 and not OxyRun then

			DrawText3Ds(pillWorker["x"],pillWorker["y"],pillWorker["z"], "[E] $2500 - Delivery Job (Payment Cash + Oxy)") 
			if IsControlJustReleased(0,38) then
				TriggerServerEvent("oxydelivery:server")
				Citizen.Wait(1000)
			end
		end
    end
end)

local firstdeal = false
Citizen.CreateThread(function()


	while true do
		Wait(1)
        if drugdealer then

	        Citizen.Wait(1000)

	        if firstdeal then
	        	Citizen.Wait(10000)
	        end

	        TriggerEvent("drugdelivery:client")  

		    salecount = salecount + 1
		    if salecount == 12 then
		    	Citizen.Wait(600000)
		    	drugdealer = false
		    end

		    Citizen.Wait(150000)
		    firstdeal = false

		elseif OxyRun then
            Citizen.Wait(100)

			--if not DoesEntityExist(oxyVehicle) or GetVehicleEngineHealth(oxyVehicle) < 20.0 or GetVehicleBodyHealth(oxyVehicle) < 20.0 then
			--	OxyRun = false
			--	tasking = false
			--	RLCore.Functions.Notify("The dealer isn't giving you anymore locations due to the state of his car", "error")
			--else
				if tasking then
			        Citizen.Wait(30000)
			    else
			        TriggerEvent("oxydelivery:client")  
				    salecount = salecount + 1
				    if salecount == Config.RunAmount then
                        RLCore.Functions.Notify("The dealer isn't giving you anymore locations thank you for the help! See you again soon and here is your deposit back.", "error")
                        TriggerServerEvent("oxy:server:doathing")
                        local math = math.random(1,1000)
                        if math <= 40 then
                            TriggerServerEvent("oxydelivery:receiveBigRewarditem")
                        end
				    	Citizen.Wait(300000)
				    	OxyRun = false
				    end
				end
			--end
	    end
    end
end)

RegisterNetEvent("oxydelivery:startDealing")
AddEventHandler("oxydelivery:startDealing", function()
    local NearNPC = GetClosestPed()

	PlayAmbientSpeech1(NearNPC, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
	salecount = 0
	OxyRun = true
	firstdeal = true
	RLCore.Functions.Notify('Your pager will be updated with locations soon, Finish all runs or im keeping your money.')
	CreateOxyVehicle()
end)

--[[RegisterNetEvent('oxydelivery:timer')
AddEventHandler('oxydelivery:timer', function(data)
	LastDelivery = data
end)]]--

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

inanim = false
cancelled = false

attachedProp = 0
function removeAttachedProp()
    DeleteEntity(attachedProp)
    attachedProp = 0
end

RegisterNetEvent('attachPropDrugsObjectnoanim')
AddEventHandler('attachPropDrugsObjectnoanim', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
    removeAttachedProp()

    attachModel = GetHashKey(attachModelSent)
    boneNumber = boneNumberSent
    SetCurrentPedWeapon(deliveryPed, 0xA2719263) 
    local bone = GetPedBoneIndex(deliveryPed, boneNumberSent)
    --local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
        Citizen.Wait(100)
    end
    attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedProp, deliveryPed, bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
    Citizen.Wait(5000)
    removeAttachedProp()
end)
RegisterNetEvent('attachPropDrugsObject')
AddEventHandler('attachPropDrugsObject', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
    removeAttachedProp()
    attachModel = GetHashKey(attachModelSent)
    boneNumber = boneNumberSent
    SetCurrentPedWeapon(PlayerPedId(), 0xA2719263) 
    local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
    --local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
        Citizen.Wait(100)
    end
    attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
    Citizen.Wait(5000)
    removeAttachedProp()
end)

RegisterNetEvent('attachPropDrugs')
AddEventHandler('attachPropDrugs', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
    removeAttachedProp()
    attachModel = GetHashKey(attachModelSent)
    boneNumber = boneNumberSent
    SetCurrentPedWeapon(deliveryPed, 0xA2719263) 
    local bone = GetPedBoneIndex(deliveryPed, boneNumberSent)
    --local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
        Citizen.Wait(100)
    end
    attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedProp, deliveryPed, bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
    Citizen.Wait(4000)
    removeAttachedProp()
end)

function attachPropCash(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
    removeAttachedProp()
    attachModel = GetHashKey(attachModelSent)
    boneNumber = boneNumberSent
    SetCurrentPedWeapon(PlayerPedId(), 0xA2719263) 
    local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
    --local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
        Citizen.Wait(100)
    end
    attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
    Citizen.Wait(2500)
    
    removeAttachedProp()
end

attachPropList = {

    ["crackpipe01"] = { 
        ["model"] = "prop_cs_crackpipe", ["bone"] = 28422, ["x"] = 0.0,["y"] = 0.05,["z"] = 0.0,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 0.0 
    },

    ["bong01"] = { 
        ["model"] = "prop_bong_01", ["bone"] = 18905, ["x"] = 0.11,["y"] = -0.23,["z"] = 0.01,["xR"] = -90.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["healthpack01"] = { 
        ["model"] = "prop_ld_health_pack", ["bone"] = 18905, ["x"] = 0.15,["y"] = 0.08,["z"] = 0.1,["xR"] = 180.0,["yR"] = 220.0, ["zR"] = 0.0 
    },

    ["briefcase01"] = { 
        ["model"] = "prop_ld_case_01", ["bone"] = 28422, ["x"] = 0.05,["y"] = 0.0,["z"] = 0.0,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 0.0 
    },

    ["prop_box_guncase_01a"] = { 
        ["model"] = "prop_box_guncase_01a", ["bone"] = 28422, ["x"] = 0.05,["y"] = 0.0,["z"] = 0.0,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 0.0 
    },

    ["cashcase3"] = { 
        ["model"] = "prop_cash_case_02", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["con1"] = { 
        ["model"] = "prop_police_id_board", ["bone"] = 28422, ["x"] = 0,["y"] = 0,["z"] = 0.1,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["EnginePart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["SuspensionPart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["DampenerPart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["TyrePart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["MetalPart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["AerodynamicsPart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["BrakingPart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["GearboxPart"] = { 
        ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },


    ["gunbox1"] = { 
        ["model"] = "prop_paper_bag_small", ["bone"] = 28422, ["x"] = 0.01,["y"] = 0.01,["z"] = 0.0,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["drugtest02"] = { 
        ["model"] = "prop_mp_drug_pack_blue", ["bone"] = 28422, ["x"] = 0.01,["y"] = 0.01,["z"] = 0.0,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["drugtest01"] = { 
        ["model"] = "prop_mp_drug_package", ["bone"] = 28422, ["x"] = 0.01,["y"] = 0.01,["z"] = 0.0,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["cashcase01"] = { 
        ["model"] = "prop_paper_bag_small", ["bone"] = 28422, ["x"] = 0.05,["y"] = 0.0,["z"] = 0.0,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 0.0 
    },

    ["cashbag02"] = { 
        ["model"] = "prop_cs_heist_bag_01", ["bone"] = 28422, ["x"] = 0.05,["y"] = 0.0,["z"] = 0.0,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 0.0 
    },

    ["cashbag01"] = { 
        ["model"] = "prop_cs_heist_bag_01", ["bone"] = 24816, ["x"] = 0.15,["y"] = -0.4,["z"] = -0.38,["xR"] = 90.0,["yR"] = 0.0, ["zR"] = 0.0 
    },

    ["drugpackage01"] = { 
        ["model"] = "prop_meth_bag_01", ["bone"] = 28422, ["x"] = 0.1,["y"] = 0.0,["z"] = -0.01,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 40.0 
    },


    ["drugpackage02"] = { 
        ["model"] = "prop_weed_bottle", ["bone"] = 28422, ["x"] = 0.09,["y"] = 0.0,["z"] = -0.03,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 40.0 
    },





    ["bomb01"] = { 
        ["model"] = "prop_ld_bomb", ["bone"] = 28422, ["x"] = 0.22,["y"] = -0.01,["z"] = 0.0,["xR"] = -25.0,["yR"] = -100.0, ["zR"] = 0.0 
    },

    ["phone01"] = { 
        ["model"] = "prop_amb_phone", ["bone"] = 28422, ["x"] = 0.1,["y"] = 0.01,["z"] = 0.0,["xR"] = -255.0,["yR"] = -120.0, ["zR"] = 40.0 
    },

    ["money01"] = { 
        ["model"] = "prop_anim_cash_note", ["bone"] = 28422, ["x"] = 0.1,["y"] = 0.04,["z"] = 0.0,["xR"] = 25.0,["yR"] = 0.0, ["zR"] = 10.0 
    },

    ["armor01"] = { 
        ["model"] = "prop_armour_pickup", ["bone"] = 28422, ["x"] = 0.3,["y"] = 0.01,["z"] = 0.0,["xR"] = 255.0,["yR"] = -90.0, ["zR"] = 10.0 
    },

    ["terd01"] = { 
        ["model"] = "prop_big_shit_01", ["bone"] = 61839, ["x"] = 0.015,["y"] = 0.0,["z"] = -0.01,["xR"] = 3.0,["yR"] = -90.0, ["zR"] = 180.0 
    },

    ["boombox01"] = { 
        ["model"] = "prop_boombox_01", ["bone"] = 28422, ["x"] = 0.2,["y"] = 0.0,["z"] = 0.0,["xR"] = -35.0,["yR"] = -100.0, ["zR"] = 0.0 
    },

    ["bowlball01"] = { 
        ["model"] = "prop_bowling_ball", ["bone"] = 28422, ["x"] = 0.12,["y"] = 0.0,["z"] = 0.0,["xR"] = 75.0,["yR"] = 280.0, ["zR"] = -80.0 
    },

    ["bowlpin01"] = { 
        ["model"] = "prop_bowling_pin", ["bone"] = 28422, ["x"] = 0.12,["y"] = 0.0,["z"] = 0.0,["xR"] = 75.0,["yR"] = 280.0, ["zR"] = -80.0 
    },

    ["crate01"] = { 
        ["model"] = "hei_prop_heist_wooden_box", ["bone"] = 24816, ["x"] = 0.13,["y"] = 0.50,["z"] = 0.05,["xR"] = 45.0,["yR"] = 280.0, ["zR"] = -80.0 
    },

    ["tvcamera01"] = { 
        ["model"] = "prop_v_cam_01", ["bone"] = 57005, ["x"] = 0.13,["y"] = 0.25,["z"] = -0.03,["xR"] = -85.0,["yR"] = 0.0, ["zR"] = -80.0 
    },


        -- 18905 left hand - 57005 right hand
    ["tvmic01"] = { 
        ["model"] = "p_ing_microphonel_01", ["bone"] = 18905, ["x"] = 0.1,["y"] = 0.05,["z"] = 0.0,["xR"] = -85.0,["yR"] = -80.0, ["zR"] = -80.0 
    },

    ["golfbag01"] = { 
        ["model"] = "prop_golf_bag_01", ["bone"] = 24816, ["x"] = 0.12,["y"] = -0.3,["z"] = 0.0,["xR"] = -75.0,["yR"] = 190.0, ["zR"] = 92.0 
    },

    ["golfputter01"] = { 
        ["model"] = "prop_golf_putter_01", ["bone"] = 57005, ["x"] = 0.0,["y"] = -0.05,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0 
    },

    ["golfiron01"] = { 
        ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.125,["y"] = 0.04,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0 
    },
    ["golfiron03"] = { 
        ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.126,["y"] = 0.041,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0 
    },
    ["golfiron05"] = { 
        ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.127,["y"] = 0.042,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0 
    },
    ["golfiron07"] = { 
        ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.128,["y"] = 0.043,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0 
    },      
    ["golfwedge01"] = { 
        ["model"] = "prop_golf_pitcher_01", ["bone"] = 57005, ["x"] = 0.17,["y"] = 0.04,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0 
    },

    ["golfdriver01"] = { 
        ["model"] = "prop_golf_driver", ["bone"] = 57005, ["x"] = 0.14,["y"] = 0.00,["z"] = 0.0,["xR"] = 160.0,["yR"] = -60.0, ["zR"] = 10.0 
    }
}

RegisterNetEvent('attachItemObject')
AddEventHandler('attachItemObject', function(item)
    TriggerEvent("attachPropDrugsObject",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
end)

RegisterNetEvent('attachItemObjectnoanim')
AddEventHandler('attachItemObjectnoanim', function(item)
    TriggerEvent("attachPropDrugsObjectnoanim",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
end)

RegisterNetEvent('attachItemDrugs')
AddEventHandler('attachItemDrugs', function(item)
    TriggerEvent("attachPropDrugs",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
end)

RegisterNetEvent('attachItemDrugs2')
AddEventHandler('attachItemDrugs2', function(item)
    TriggerEvent("attachPropDrugs2",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
end)