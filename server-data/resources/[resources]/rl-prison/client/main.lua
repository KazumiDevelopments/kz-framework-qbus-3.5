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
Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

isLoggedIn = false
inJail = false
jailTime = 0
currentJob = "electrician"
CellsBlip = nil
TimeBlip = nil
ShopBlip = nil
PlayerJob = {}

Citizen.CreateThread(function()
    TriggerEvent('prison:client:JailAlarm', false)
	while true do 
		Citizen.Wait(7)
		if jailTime > 0 and inJail then 
			Citizen.Wait(1000 * 60)
			if jailTime > 0 and inJail then
				jailTime = jailTime - 1
				if jailTime <= 0 then
					jailTime = 0
					RLCore.Functions.Notify("Your time is up, check yourself out at the visitor center.", "success", 10000)
				end
				TriggerServerEvent("prison:server:SetJailStatus", jailTime)
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

RegisterNetEvent('RLCore:Client:OnPlayerLoaded')
AddEventHandler('RLCore:Client:OnPlayerLoaded', function()
	RLCore.Functions.TriggerCallback('prison:server:IsAlarmActive', function(active)
		if active then
			TriggerEvent('prison:client:JailAlarm', true)
		end
	end)
	PlayerJob = RLCore.Functions.GetPlayerData().job
end)

function CreateCellsBlip()
	if CellsBlip ~= nil then
		RemoveBlip(CellsBlip)
	end
	CellsBlip = AddBlipForCoord(Config.Locations["yard"].coords.x, Config.Locations["yard"].coords.y, Config.Locations["yard"].coords.z)

	SetBlipSprite (CellsBlip, 238)
	SetBlipDisplay(CellsBlip, 4)
	SetBlipScale  (CellsBlip, 0.8)
	SetBlipAsShortRange(CellsBlip, true)
	SetBlipColour(CellsBlip, 4)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Cells")
	EndTextCommandSetBlipName(CellsBlip)

	if TimeBlip ~= nil then
		RemoveBlip(TimeBlip)
	end
	TimeBlip = AddBlipForCoord(Config.Locations["freedom"].coords.x, Config.Locations["freedom"].coords.y, Config.Locations["freedom"].coords.z)

	SetBlipSprite (TimeBlip, 466)
	SetBlipDisplay(TimeBlip, 4)
	SetBlipScale  (TimeBlip, 0.8)
	SetBlipAsShortRange(TimeBlip, true)
	SetBlipColour(TimeBlip, 4)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Checking Time")
	EndTextCommandSetBlipName(TimeBlip)

	if ShopBlip ~= nil then
		RemoveBlip(ShopBlip)
	end
	ShopBlip = AddBlipForCoord(Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z)

	SetBlipSprite (ShopBlip, 52)
	SetBlipDisplay(ShopBlip, 4)
	SetBlipScale  (ShopBlip, 0.5)
	SetBlipAsShortRange(ShopBlip, true)
	SetBlipColour(ShopBlip, 0)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Canteen")
	EndTextCommandSetBlipName(ShopBlip)
end

--[[
	Locations n stuff
]]
Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		if isLoggedIn then
			if inJail then
				local pos = GetEntityCoords(GetPlayerPed(-1))
				if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["freedom"].coords.x, Config.Locations["freedom"].coords.y, Config.Locations["freedom"].coords.z, true) < 1.5) then
					RLCore.Functions.DrawText3D(Config.Locations["freedom"].coords.x, Config.Locations["freedom"].coords.y, Config.Locations["freedom"].coords.z, "~g~E~w~ - Check time")
					if IsControlJustReleased(0, Keys["E"]) then
						TriggerEvent("prison:client:Leave")
					end
				elseif (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["freedom"].coords.x, Config.Locations["freedom"].coords.y, Config.Locations["freedom"].coords.z, true) < 2.5) then
					RLCore.Functions.DrawText3D(Config.Locations["freedom"].coords.x, Config.Locations["freedom"].coords.y, Config.Locations["freedom"].coords.z, "Check time")
				end  

				if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, true) < 1.5) then
					RLCore.Functions.DrawText3D(Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, "~g~E~w~ - Canteen")
					if IsControlJustReleased(0, Keys["E"]) then
                        local ShopItems = {}
                        ShopItems.label = "Prison Canteen"
                        ShopItems.items = Config.CanteenItems
                        ShopItems.slots = #Config.CanteenItems
                        TriggerServerEvent("inventory:server:OpenInventory", "shop", "Canteen"..math.random(1, 99), ShopItems)
					end
					DrawMarker(2, Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 255, 55, 22, 222, false, false, false, 1, false, false, false)
				elseif (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, true) < 2.5) then
					RLCore.Functions.DrawText3D(Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, "Canteen")
					DrawMarker(2, Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 255, 55, 22, 222, false, false, false, 1, false, false, false)
				elseif (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, true) < 10) then
					DrawMarker(2, Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 255, 55, 22, 222, false, false, false, 1, false, false, false)
				end  
			end
		else
			Citizen.Wait(5000)
		end
	end
end)

RegisterNetEvent('RLCore:Client:OnPlayerLoaded')
AddEventHandler('RLCore:Client:OnPlayerLoaded', function()
	isLoggedIn = true
	RLCore.Functions.GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] > 0 then
			TriggerEvent("prison:client:Enter", PlayerData.metadata["injail"])
		end
	end)
end)

RegisterNetEvent('RLCore:Client:OnPlayerUnload')
AddEventHandler('RLCore:Client:OnPlayerUnload', function()
	isLoggedIn = false
	inJail = false
	currentJob = nil
	RemoveBlip(currentBlip)
end)

RegisterNetEvent('prison:client:Enter')
AddEventHandler('prison:client:Enter', function(time)
	TriggerEvent("debug", 'Prison: Enter', 'success')

	RLCore.Functions.Notify("You are in jail for "..time.." months..", "error")
	RLCore.Functions.Notify("Your items has been confiscated, you get everything back when your time is up..")
	DoScreenFadeOut(500)
	while not IsScreenFadedOut() do
		Citizen.Wait(10)
	end
	local RandomStartPosition = Config.Locations.spawns[math.random(1, #Config.Locations.spawns)]
	SetEntityCoords(GetPlayerPed(-1), RandomStartPosition.coords.x, RandomStartPosition.coords.y, RandomStartPosition.coords.z - 0.9, 0, 0, 0, false)
	SetEntityHeading(GetPlayerPed(-1), RandomStartPosition.coords.h)
	Citizen.Wait(500)
	TriggerEvent('animations:client:EmoteCommandStart', {RandomStartPosition.animation})

	inJail = true
	jailTime = time
	currentJob = "electrician"
	TriggerServerEvent("prison:server:SetJailStatus", jailTime)
	TriggerServerEvent("prison:server:SaveJailItems", jailTime)

	TriggerServerEvent("InteractSound_SV:PlayOnSource", "jail", 0.5)

	CreateCellsBlip()
	
	Citizen.Wait(2000)

	DoScreenFadeIn(1000)
	RLCore.Functions.Notify("Do some work for a reduced sentence, current job: "..Config.Jobs[currentJob])
end)

RegisterNetEvent('prison:client:Leave')
AddEventHandler('prison:client:Leave', function()
	TriggerEvent("debug", 'Prison: Leave', 'error')

	if jailTime > 0 then 
		RLCore.Functions.Notify("You still have "..jailTime.." months..")
	else
		jailTime = 0
		TriggerServerEvent("prison:server:SetJailStatus", 0)
		TriggerServerEvent("prison:server:GiveJailItems")
		RLCore.Functions.Notify("You have received your items back.")
		inJail = false
		RemoveBlip(currentBlip)
		RemoveBlip(CellsBlip)
		CellsBlip = nil
		RemoveBlip(TimeBlip)
		TimeBlip = nil
		RemoveBlip(ShopBlip)
		ShopBlip = nil
		RLCore.Functions.Notify("You are free, dont do anything stupid..")
		DoScreenFadeOut(500)
		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end
		SetEntityCoords(PlayerPedId(), Config.Locations["outside"].coords.x, Config.Locations["outside"].coords.y, Config.Locations["outside"].coords.z, 0, 0, 0, false)
		SetEntityHeading(PlayerPedId(), Config.Locations["outside"].coords.h)

		Citizen.Wait(500)

		DoScreenFadeIn(1000)
	end
end)

RegisterNetEvent('prison:client:UnjailPerson')
AddEventHandler('prison:client:UnjailPerson', function()
	if jailTime > 0 then
		TriggerEvent("debug", 'Prison: Unjail', 'error')

		TriggerServerEvent("prison:server:SetJailStatus", 0)
		TriggerServerEvent("prison:server:GiveJailItems")
		RLCore.Functions.Notify("You have received your possessions.")
		inJail = false
		RemoveBlip(currentBlip)
		RemoveBlip(CellsBlip)
		CellsBlip = nil
		RemoveBlip(TimeBlip)
		TimeBlip = nil
		RemoveBlip(ShopBlip)
		ShopBlip = nil
		RLCore.Functions.Notify("You are free, dont do anything stupid..")
		DoScreenFadeOut(500)
		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end
		SetEntityCoords(PlayerPedId(), Config.Locations["outside"].coords.x, Config.Locations["outside"].coords.y, Config.Locations["outside"].coords.z, 0, 0, 0, false)
		SetEntityHeading(PlayerPedId(), Config.Locations["outside"].coords.h)

		Citizen.Wait(500)

		DoScreenFadeIn(1000)
	end
end)