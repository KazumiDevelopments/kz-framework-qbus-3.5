RLCore = nil


Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
            Citizen.Wait(200)
        end
    end
end)
 
RegisterNUICallback("showroomPurchaseCurrentVehicle", function(data, cb)
  RLCore.Functions.TriggerCallback("showroom:purchaseVehicle", function(success, model, plate)
    print(success, model)
	if success then
    DoScreenFadeOut(0) 
    Wait(400)
    DoScreenFadeIn(1000)
    SetNuiFocus(false, false)
    ClearFocus()
    RenderScriptCams(false, false, 0, 1, 0)
    DeleteEntity(vehicle)
    TakeOutVehicle(model, plate)
		cb({
			data = {},
			meta = {
				ok = true,
			}
		});
	else
    print("nomoney")
		TriggerEvent("DoLongHudText", "Not enough money!", 2);
	end;
  end, data.model, data.price, data.zoneName)
end);


function TakeOutVehicle(vehicle, plate) 
      enginePercent = 100
      bodyPercent = 100
      currentFuel = 100
      model = vehicle

      RLCore.Functions.SpawnVehicle(model, vector3(-45.60, -1080.9, 26.706), 70.0, function(vehicle)
        SetVehicleNumberPlateText(veh, plate)
        SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
      end)
end

RegisterCommand("cord", function()
coords = GetEntityCoords(PlayerPedId())
head = GetEntityHeading(PlayerPedId())
print(coords, head)
end)