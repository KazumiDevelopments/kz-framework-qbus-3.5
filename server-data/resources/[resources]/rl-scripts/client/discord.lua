SetDiscordAppId(947262882016559165)
SetDiscordRichPresenceAsset('logo_name')

local WaitTime = 2000 -- How often do  you want to update the status (In MS)

local onlinePlayers = 0


Citizen.CreateThread(function()
	while true do
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
		local StreetHash = GetStreetNameAtCoord(x, y, z)

		onlinePlayers = #GetActivePlayers()

		Citizen.Wait(WaitTime)
		if StreetHash ~= nil then
			StreetName = GetStreetNameFromHashKey(StreetHash)
			if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
				  if not IsEntityInArea(PlayerPedId(),2631.851,2572.982,45.096,-2449.445,711.613,290.987,false,false,0) then
           if IsPedSprinting(PlayerPedId()) then
					SetRichPresence(onlinePlayers.."/90 | Sprinting down "..StreetName)
				elseif IsPedRunning(PlayerPedId()) then
					SetRichPresence(onlinePlayers.."/90 | Running down "..StreetName)
				elseif IsPedWalking(PlayerPedId()) then
					SetRichPresence(onlinePlayers.."/90 | Going down "..StreetName)
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence(onlinePlayers.."/90 | Standing on "..StreetName)
				end
				else
				if IsPedRunning(PlayerPedId()) or GetEntitySpeed(PlayerPedId()) > 2.0 then
					SetRichPresence(onlinePlayers.."/90 | Running scared around "..StreetName)
				elseif not IsPedRunning(PlayerPedId()) and GetEntitySpeed(PlayerPedId()) > 1.0 and GetEntitySpeed(PlayerPedId()) < 2.0 then
					SetRichPresence(onlinePlayers.."/90 | Searching around on your own "..StreetName)
				else
					SetRichPresence(onlinePlayers.."/90 | Relaxing on "..StreetName)
				end
				end
			elseif IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
				local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 2.23693629205)
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				if MPH > 50 and not IsPedOnAnyBike(PlayerPedId()) then
					SetRichPresence(onlinePlayers.."/90 | Blowing down "..StreetName)
				elseif MPH <= 50 and MPH > 0  then
					SetRichPresence(onlinePlayers.."/90 | Cruising down "..StreetName)
				elseif MPH == 0 then
					SetRichPresence(onlinePlayers.."/90 | Parked on "..StreetName)
				elseif MPH > 50 and IsPedOnAnyBike(PlayerPedId()) then
					SetRichPresence(onlinePlayers.."/90 | Driving around near "..StreetName)
				end
			elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
				local KT = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 1.9438444924406046)
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) and GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 25.0 and KT>90 then
					SetRichPresence(onlinePlayers.."/90 | Flying over "..StreetName.." in "..VehName)
				elseif IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) and GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) <= 25.0 and KT < 90 and KT>40 and GetLandingGearState(GetVehiclePedIsIn(PlayerPedId(), false)) == 0 then
					SetRichPresence(onlinePlayers.."/90 | Landing at "..StreetName.." in "..VehName)
				elseif GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) <= 25.0 and KT >= 90 and KT < 120 and GetLandingGearState(GetVehiclePedIsIn(PlayerPedId())) == 0 then
					SetRichPresence(onlinePlayers.."/90 | Started taking off at "..StreetName.." in "..VehName)
				else
					SetRichPresence(onlinePlayers.."/90 | Landed at "..StreetName.." in "..VehName)
				end
			elseif IsEntityInWater(PlayerPedId()) then
				SetRichPresence(onlinePlayers.."/90 | Swimming around")
			elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				SetRichPresence(onlinePlayers.."/90 | Sailing around with one "..VehName)
			elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence(onlinePlayers.."/90 | OCEAN MAN 🌊 😍 Take me by the hand ✋ lead me to the land that you understand 🙌 🌊")
			end
		end
	end
end)
