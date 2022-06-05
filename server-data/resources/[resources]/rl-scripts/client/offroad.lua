local OnDebug = false
local GripAmount = 5.8000001907349 -- Max amount = 9.8000001907349 | Default = 5.8000001907349 (Grip amount when on drift)


Citizen.CreateThread(function()
	while true do
		local veh = GetVehiclePedIsIn(PlayerPedId())

		if veh == 0 then -- Player isnt in a vehicle
			Citizen.Wait(500)

		else -- Player is in a vehicle

			local material_id = GetVehicleWheelSurfaceMaterial(veh, 1)
			local wheel_type = GetVehicleWheelType(veh)

			if wheel_type == 3 or wheel_type == 4 or wheel_type == 6 then -- If have Off-road/Suv's/Motorcycles wheel grip its equal
			else
				if material_id == 4 or material_id == 1 or material_id == 3 then -- All road (sandy/los santos/paleto bay)
					-- On road
					SetVehicleGravityAmount(veh, 9.8000001907349)
					if OnDebug then
						text = "You are on the road"
					end
				else
					-- Off road
					if GripAmount >= 9.8000001907349 then
						GripAmount = 5.8000001907349
					end

					SetVehicleGravityAmount(veh, GripAmount)
					if OnDebug then
						text = "You aren't on the road"
					end
				end
			end

			if OnDebug then
				Drawtext()
				Citizen.Wait(1)
			else
				Citizen.Wait(200)
			end
		end
	end
end)

function Drawtext()
	SetTextScale(0.7, 0.7)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
    DrawText(0.5, 0.9)
end
