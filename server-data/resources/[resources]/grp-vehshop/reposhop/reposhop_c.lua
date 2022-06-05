PlayerData = {}

RLCore = nil
Citizen.CreateThread(function() 
    while RLCore == nil do
        Citizen.Wait(10)
        TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
    end

    while not RLCore.Functions.GetPlayerData() do
        Wait(1)
    end

    while not RLCore.Functions.GetPlayerData().job do
        Wait(1)
    end

	PlayerData = RLCore.Functions.GetPlayerData()
	--[[ RemoveVehicles()
	LoadSellPlace()
	SpawnVehicles()  ]]
end)

RegisterNetEvent("LG_CLBan")
AddEventHandler("LG_CLBan", function()
	TriggerServerEvent('LG:BannedModdaFukka')
end)

RegisterNetEvent("tp_repocarsales:refreshVehicles")
AddEventHandler("tp_repocarsales:refreshVehicles", function()
	RemoveVehicles()
	Citizen.Wait(500)
	SpawnVehicles()
end)

function LoadSellPlace()
	Citizen.CreateThread(function()
		local SellPos = Config.SellPosition
		local Blip = AddBlipForCoord(448.978, -1146.853, 29.308)
		SetBlipSprite (Blip, 595)
		SetBlipDisplay(Blip, 4)
		SetBlipScale  (Blip, 0.8)
		SetBlipColour (Blip, 60)
		SetBlipAsShortRange(Blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Repo'd Vehicles")
		EndTextCommandSetBlipName(Blip)

		while true do
			local sleepThread = 500
			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)
			
			for i = 1, #Config.VehiclePositions, 1 do 
				if Config.VehiclePositions[i]["entityId"] ~= nil then
					local pedCoords = GetEntityCoords(ped)
					local vehCoords = GetEntityCoords(Config.VehiclePositions[i]["entityId"])					
					local props = RLCore.Functions.GetVehicleProperties(Config.VehiclePositions[i]["entityId"])
					local vehName1 = GetEntityModel(Config.VehiclePositions[i]["entityId"])
					local vehName2 = GetLabelText(GetDisplayNameFromVehicleModel(vehName1))
					if VehName2 == nil then
						vehName2 = GetDisplayNameFromVehicleModel(vehName1)
					end
					local turbs = 'No'
					local engine = 'Stock'
					local gearbox = 'Stock'
					local suspension = 'Stock'
					local randombool, Ground = GetGroundZFor_3dCoord(vehCoords.x, vehCoords.y, vehCoords.z)
					
					if props.modTurbo and props.modTurbo > 0 then 
						turbs = 'Yes'
					end
					if props.modEngine >= 0 then
						engine = ("Level " .. tostring(props.modEngine + 1))
					end
					if props.modTransmission >= 0 then
						gearbox = ("Level " .. tostring(props.modTransmission + 1))
					end
					if props.modSuspension >= 0 then
						suspension = ("Level " .. tostring(props.modSuspension + 1))
					end
					

					local dstCheck = GetDistanceBetweenCoords(pedCoords, vehCoords, true)
					if dstCheck <= 2.0 then
						sleepThread = 5
						drawTextA = "[" .. vehName2 .. " - $" .. Config.VehiclePositions[i]["price"] .. "]"
						drawTextB = "[Turbo: ~r~" .. turbs .. "~s~] [Engine: ~r~" .. engine .. "~s~]"
						drawTextC = "[Gearbox: ~r~" .. gearbox .. "~s~] [Suspension: ~r~" .. suspension .. "~s~]"
						DrawText3Db(vehCoords.x, vehCoords.y, Ground + 1.8, drawTextA)
						DrawText3Db(vehCoords.x, vehCoords.y, Ground + 1.7, drawTextB)
						DrawText3Db(vehCoords.x, vehCoords.y, Ground + 1.6, drawTextC)

						if IsControlJustPressed(0, 38) then
							RLCore.Functions.TriggerCallback('tp_repocarsales:buyVehicle', function(isPurchasable, totalMoney)
								if isPurchasable then
									print("Bought it")
								else
									RLCore.Functions.Notify("You cannot afford this car.", "success")
								end
							end,RLCore.Functions.GetVehicleProperties(Config.VehiclePositions[i]["entityId"]), price)
						end
					end
				end
			end
			Citizen.Wait(sleepThread)
		end
	end)
end

function OpenSellMenu(veh, price, buyVehicle, owner)
	local elements = {}

	if not buyVehicle then
		return
	else
		table.insert(elements, {["label"] = "Buy using bank balance - $" .. price, ["value"] = "buy"})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_veh',
		{
			title = "Repo Car Sales",
			align = 'bottom-right',
			elements = elements
		},
		function(data, menu)
			local action = data.current.value
			if action == "buy" then
				ESX.TriggerCallback('tp_repocarsales:buyVehicle', function(isPurchasable, totalMoney)
					if isPurchasable then
						menu.close()
					else
						RLCore.Functions.Notify("You cannot afford this car.", "success")
						menu.close()
					end
				end,ESX.Game.GetVehicleProperties(veh), price)
			end
		end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent("reposales_DeleteVehicle")
AddEventHandler("reposales_DeleteVehicle", function(price)
	DeleteVehicle(GetVehiclePedIsUsing(PlayerPedId()))
	RLCore.Functions.Notify("You bought the vehicle for $'" .. price .. "'.", "success")
	Citizen.Wait(5000)
	RLCore.Functions.Notify("Your vehicle is now ready to collect from your garage", "success")
end)

function RemoveVehicles()
	local VehPos = Config.VehiclePositions
	for i = 1, #VehPos, 1 do
		local veh, distance = RLCore.Functions.GetClosestVehicle(VehPos[i])
		if DoesEntityExist(veh) and distance <= 1.0 then
			DeleteEntity(veh)
		end
	end
end

RegisterCommand('ff', function() 
	--RemoveVehicles()
	LoadSellPlace()
	SpawnVehicles()
end)

function SpawnVehicles()
	local VehPos = Config.VehiclePositions
	RLCore.Functions.TriggerCallback("tp_repocarsales:retrieveVehicles", function(vehicles)
		print("Callback Got")
		for i = 1, #vehicles, 1 do
			local props = vehicles[i]["props"]
			LoadModel(props["model"])
			VehPos[i]["entityId"] = CreateVehicle(props["model"], VehPos[i]["x"], VehPos[i]["y"], VehPos[i]["z"], VehPos[i]["h"], false)
			VehPos[i]["price"] = vehicles[i]["price"]
			--VehPos[i]["owner"] = vehicles[i]["owner"]
			RLCore.Functions.SetVehicleProperties(VehPos[i]["entityId"], props)
			SetVehicleOnGroundProperly(VehPos[i]["entityId"])
			FreezeEntityPosition(VehPos[i]["entityId"], true)
			SetEntityAsMissionEntity(VehPos[i]["entityId"], true, true)
			SetModelAsNoLongerNeeded(props["model"])
		end
	end)
end

LoadModel = function(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		Citizen.Wait(1)
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

function DrawText3Db(x,y,z, text, scaleB)
	if not scaleB then scaleB = 1.2; end
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	local px,py,pz = table.unpack(GetGameplayCamCoord())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local scale = (((1/dist)*2)*(1/GetGameplayCamFov())*100)*scaleB
  
	if onScreen then
	  -- Formalize the text
	  SetTextColour(220, 220, 220, 255)
	  SetTextScale(0.0*scale, 0.40*scale)
	  SetTextFont(4)
	  SetTextProportional(1)
	  SetTextCentre(true)
  
	  -- Diplay the text
	  SetTextEntry("STRING")
	  AddTextComponentString(text)
	  EndTextCommandDisplayText(_x, _y)
	end
  end