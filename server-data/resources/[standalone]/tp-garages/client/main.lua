RLCore = nil

cachedData = {}

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

RegisterNetEvent("RLCore:playerLoaded")
AddEventHandler("RLCore:playerLoaded", function(playerData)
	RLCore.PlayerData = playerData
end)

local garages = {
	{name="Garage A",215.92279052734,-809.75280761719,30.730318069458,600},
    {name="Garage B",273.67422485352, -344.15573120117, 44.919834136963,600},
    {name="Garage C",-1803.8967285156, -341.45928955078, 43.986347198486,900},
    {name="Garage D",-69.272, -1831.736, 26.942,900},
    {name="Garage E",1738.005, 3711.975, 34.133,1500},
    {name="Garage F",125.202, 6644.688, 31.784,1500},
    {name="Garage MC",953.53881835938,-122.51171112061,74.353179931641,1200},
    {name="Garage Boat",-734.872, -1325.817, 1.595,900},
    {name="Garage Aircraft",-1237.556, -3384.547, 13.940,1200}, 
	{name="Garage Truck",913.513, -1273.216, 27.092,600}
	
	
}

local showGarages = false

RegisterNetEvent('Garages:ToggleGarageBlip')
AddEventHandler('Garages:ToggleGarageBlip', function() 
    showGarages = not showGarages
   for _, item in pairs(garages) do
        if not showGarages then 
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
		else
            item.blip = AddBlipForCoord(item[1], item[2], item[3])
            SetBlipSprite(item.blip, 357)
			SetBlipScale(item.blip, 0.65)
			SetBlipColour(item.blip, 67)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(item.name)
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

Citizen.CreateThread(function()
    showGarages = true
    TriggerEvent('Garages:ToggleGarageBlip')
end)

Citizen.CreateThread(function()
	local CanDraw = function(action)
		if action == "vehicle" then
			if IsPedInAnyVehicle(PlayerPedId()) then
				local vehicle = GetVehiclePedIsIn(PlayerPedId())

				if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
					return true
				else
					return false
				end
			else
				return false
			end
		end

		return true
	end

	while true do
		local sleepThread = 500

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		for garage, garageData in pairs(Config.Garages) do
			for action, actionData in pairs(garageData["positions"]) do
				local dstCheck = #(pedCoords - actionData["position"])

				if dstCheck <= 10.0 then
					sleepThread = 5
					local draw = CanDraw(action)

					if draw then
						local markerSize = action == "vehicle" and 4.0 or 1.5
						if dstCheck <= markerSize - 0.1 then
							local usable = not DoesCamExist(cachedData["cam"])
							if Menu.hidden then
								--DrawText3Ds(actionData["position"].x,actionData["position"].y,actionData["position"].z, actionData["text"])
							end
							if IsControlJustPressed(1, 177) and not Menu.hidden then
								CloseMenu()
								PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
							end
							if usable then
								if IsControlJustPressed(0, 38) and Menu.hidden then
									cachedData["currentGarage"] = garage
									RLCore.Functions.TriggerCallback("betrayed_garage:obtenerVehiculos", function(fetchedVehicles)
										EnvioVehLocal(fetchedVehicles[1])
										if fetchedVehicles[2] then
											print("send")
											EnvioVehFuera(fetchedVehicles[2])
										end
									end,garage)
									Menu.hidden = not Menu.hidden
									MenuGarage(action)
									TriggerEvent("inmenu",true)
								end
								
							end
						end
						DrawScriptMarker({
							["type"] = 27,
							["pos"] = actionData["position"] - vector3(0.0, 0.0, 0.0),
							["sizeX"] = markerSize,
							["sizeY"] = markerSize,
							["sizeZ"] = markerSize,
							["r"] = 0,
							["g"] = 0,
							["b"] = 0
						})
					end
				elseif (dstCheck > 10.0 and dentro == garage) then
					print(dentro)
					print(garage)
					dentro = nil
				end
			end
		end
		Menu.renderGUI()
		Citizen.Wait(sleepThread)
	end
end)
-------------------------------------------------------------------------------------------------------------------------
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
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 0, 0, 0, 100)
end