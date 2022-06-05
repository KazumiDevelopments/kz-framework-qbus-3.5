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

RLCore = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
        end
    end
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
	[1] =  { ['x'] = 79.85,['y'] = -1544.99,['z'] = 29.47,['h'] = 51.55, ['info'] = ' car 8' },
	[2] =  { ['x'] = 66.93,['y'] = -1561.73,['z'] = 29.47,['h'] = 45.73, ['info'] = ' car 1' },
	[3] =  { ['x'] = 68.57,['y'] = -1559.53,['z'] = 29.47,['h'] = 50.6, ['info'] = ' car 2' },
	[4] =  { ['x'] = 70.4,['y'] = -1557.12,['z'] = 29.47,['h'] = 51.18, ['info'] = ' car 3' },
	[5] =  { ['x'] = 72.22,['y'] = -1554.63,['z'] = 29.47,['h'] = 50.32, ['info'] = ' car 4' },
	[6] =  { ['x'] = 73.99,['y'] = -1552.22,['z'] = 29.47,['h'] = 52.47, ['info'] = ' car 5' },
	[7] =  { ['x'] = 76.06,['y'] = -1549.87,['z'] = 29.47,['h'] = 51.53, ['info'] = ' car 6' },
	[8] =  { ['x'] = 77.9,['y'] = -1547.45,['z'] = 29.47,['h'] = 53.24, ['info'] = ' car 7' },
}

local pillWorker = { ['x'] = 68.7,['y'] = -1569.87,['z'] = 29.6,['h'] = 230.65, ['info'] = 'boop bap' }

local rnd = 0
local blip = 0
local deliveryPed = 0

local oxyPeds = {
	'a_m_y_stwhi_02',
	'a_m_y_stwhi_01',
	'g_m_y_mexgang_01',
	'g_m_y_mexgoon_01',
	'g_m_y_mexgoon_02',
	'g_m_y_mexgoon_03'
}


local drugLocs = {
	[1] =  { ['x'] = 131.94,['y'] = -1937.95,['z'] = 20.61,['h'] = 118.59, ['info'] = ' Grove Stash' },
	[2] =  { ['x'] = 1390.84,['y'] = -1507.94,['z'] = 58.44,['h'] = 29.6, ['info'] = ' East Side' },
	[3] =  { ['x'] = -676.81,['y'] = -877.94,['z'] = 24.48,['h'] = 324.9, ['info'] = ' Wei Cheng' },
}

local carpick = {
    [1] = "speedo",
    [2] = "sultan",
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
    local plt = GetVehicleNumberPlateText(oxyVehicle)
	SetVehicleHasBeenOwnedByPlayer(oxyVehicle,true)
	
	local plate = GetVehicleNumberPlateText(oxyVehicle)
	
    TriggerEvent("vehiclekeys:client:SetOwner", plate, oxyVehicle)

    while true do
    	Citizen.Wait(1)
    	 DrawText3Ds(carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"], "Your Delivery Car (Stolen).")
    	 if #(GetEntityCoords(PlayerPedId()) - vector3(carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"])) < 8.0 then
    	 	return
    	 end
    end

end

function CreateOxyPed()

    local hashKey = `a_m_y_stwhi_01`

    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end


	deliveryPed = CreatePed(pedType, hashKey, OxyDropOffs[rnd]["x"],OxyDropOffs[rnd]["y"],OxyDropOffs[rnd]["z"], OxyDropOffs[rnd]["h"], 0, 0)
	

    ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)

    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    SetPedKeepTask(deliveryPed, true)

end

function DeleteCreatedPed()
	print("Deleting Ped?")
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

function playerAnim()
	loadAnimDict( "mp_safehouselost@" )
    TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

function giveAnim()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then 
        loadAnimDict( "mp_safehouselost@" )
        if ( IsEntityPlayingAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 3 ) ) then 
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        else
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        end     
    end
end

function DoDropOff()
	local success = true
	local OxyChance = math.random(1,1000)

	Citizen.Wait(1000)
	playerAnim()
	Citizen.Wait(800)

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
				TriggerServerEvent("oxydelivery:receiveBigRewarditem")
			else
				TriggerServerEvent("oxydelivery:receivemoneyyy")
			end

			Citizen.Wait(2000)
			RLCore.Functions.Notify('The delivery was on point, your pager will be updated with the next drop off')
		else
			RLCore.Functions.Notify('The drop off failed', 'error')
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
			RLCore.Functions.Notify('You are close to the drop off')
		end
		toolong = toolong - 1
		if toolong < 0 then

		    SetVehicleHasBeenOwnedByPlayer(oxyVehicle,false)
			SetEntityAsNoLongerNeeded(oxyVehicle)
			tasking = false
			OxyRun = false
			RLCore.Functions.Notify('You are no longer selling Oxy due to taking too long to drop off')
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

			DrawText3Ds(pillWorker["x"],pillWorker["y"],pillWorker["z"], "[E] $1500 - Delivery Job (Payment Cash + Oxy)") 
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

			if not DoesEntityExist(oxyVehicle) or GetVehicleEngineHealth(oxyVehicle) < 200.0 or GetVehicleBodyHealth(oxyVehicle) < 200.0 then
				OxyRun = false
				tasking = false
				RLCore.Functions.Notify('The dealer isnt giving you anymore locations due to the state of his car', 'error')
			else
				if tasking then
			        Citizen.Wait(30000)
			    else
			        TriggerEvent("oxydelivery:client")  
				    salecount = salecount + 1
				    if salecount == Config.RunAmount then
				    	Citizen.Wait(300000)
				    	OxyRun = false
				    end
				end
			end

	    else

	    	local close = false

	    	for i = 1, #drugLocs do

				local plycoords = GetEntityCoords(PlayerPedId())

				local dstcheck = #(plycoords - vector3(drugLocs[i]["x"],drugLocs[i]["y"],drugLocs[i]["z"])) 

			

				if dstcheck < 5.0 then

					close = true

					local job = exports["isPed"]:isPed("job")

					if job ~= "police" then

						local price = 100

			    		DrawText3Ds(drugLocs[i]["x"],drugLocs[i]["y"],drugLocs[i]["z"], "[E] $" .. price .. " offer to sell stolen goods (12).") 
				    	
				    	if IsControlJustReleased(0,38) then

				    		local countpolice = exports["isPed"]:isPed("countpolice")
							local daytime = GetClockHours()
							

							if daytime > 17 or daytime < 9 then
								RLCore.Functions.Notify('Its too late - noones buying shit!', 'error')
		            		else
		            			mygang = drugLocs[i]["gang"]
					    		TriggerServerEvent("drugdelivery:server",price,"robbery",50)
					    		Citizen.Wait(1500)
					    	end

				    	end

			    	else

			    		Citizen.Wait(60000)

			    	end

			    	Citizen.Wait(1)

			    end

			end
 
			if not close then
				Citizen.Wait(2000)
			end

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
	RLCore.Functions.Notify('A car has been left outside for you. Your pager will be updated with locations soon')
	CreateOxyVehicle()
end)