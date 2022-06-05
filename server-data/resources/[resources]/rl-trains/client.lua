RLCore = nil

	Citizen.CreateThread(function()
	    while true do
	        Citizen.Wait(10)
	        if RLCore == nil then
	            TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
	            Citizen.Wait(200)
	        end
	    end
	end)

	RegisterNetEvent("curTrains")
	RegisterNetEvent("StartTrain")
	RegisterNetEvent("StartTrain2")
	RegisterNetEvent("AskForTrainConfirmed")
	RegisterNetEvent("CanIHost")
	imhost = false

	function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
		SetTextFont(0)
		SetTextProportional(0)
		SetTextScale(scale, scale)
		SetTextColour(r, g, b, a)
		SetTextDropShadow(0, 0, 0, 0,255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(x - width/2, y - height/2 + 0.005)
	end

	function Progressbar(duration, label)
		local retval = nil
		RLCore.Functions.Progressbar("train", label, duration, false, false, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = false,
		}, {}, {}, {}, function()
			retval = true
		end, function()
			retval = false
		end)

		while retval == nil do
			Wait(1)
		end

		return retval
	end

	function getVehicleInDirection()

		playerped = PlayerPedId()
		coordFrom = GetEntityCoords(playerped, 1)
		coordTo = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)

		local offset = 0
		local rayHandle
		local vehicle

		for i = 0, 100 do
			rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
			a, b, c, d, vehicle = GetRaycastResult(rayHandle)
			
			offset = offset - 1

			if vehicle ~= 0 then break end
		end
		
		local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
		
		if distance > 25 then vehicle = nil end

		return vehicle ~= nil and vehicle or 0
	end

	Citizen.CreateThread(function()
		while true do

			if not imhost2 then
				Citizen.Wait(1000)
			else

				Citizen.Wait(0)

				if stopsrunning2 and Train ~= nil then

					curDistance1 = math.ceil(runStop2()) 
					if curDistance1 < 250  then
						maxSpeed2 = curDistance1 * 0.7
					else
						if nextStop2 == 2 then
							maxSpeed2 = 45.0
						else
							maxSpeed2 = 100.0
						end
					end

					if TrainSpeed2 > maxSpeed2 then
						TrainSpeed2 = TrainSpeed2 - 1.0
						SetTrainSpeed(Train,TrainSpeed2)
						SetTrainCruiseSpeed(Train,TrainSpeed2)
					end

					if TrainSpeed2 < maxSpeed2 then
						TrainSpeed2 = TrainSpeed2 + 1.0
						SetTrainSpeed(Train,TrainSpeed2)
						SetTrainCruiseSpeed(Train,TrainSpeed2)
					end

					if curDistance1 < 5 then
						maxSpeed2 = 0.0
						SetTrainSpeed(Train,0.0)
						SetTrainCruiseSpeed(Train,0.0)
						Citizen.Wait(10000)
						checkKillcountry()
						nextStop2 = nextStop2 + 1
						if nextStop2 > #trainstations2 then
							nextStop2 = 1
						end
						--TriggerServerEvent("TrainStation:addblipCountry",trainstations2[nextStop2][1],trainstations2[nextStop2][2],trainstations2[nextStop2][3])
					end
				else
					stopsrunning2=false
					imhost2=false
				end
			end
		end
	end)

	Citizen.CreateThread(function()
		while true do

			if not imhost then
				Citizen.Wait(1000)
			else

				Citizen.Wait(0)

				if stopsrunning and MetroTrain ~= nil then

					curDistance = math.ceil(runStop1()) 
					if curDistance < 80  then
						maxSpeed1 = curDistance * 0.5
					else
					--	Citizen.Trace(maxSpeed1)
					--	Citizen.Trace(TrainSpeed1)
					--	Citizen.Trace(curDistance)
						maxSpeed1 = 35.0
					end
				--	stringmsg = "Distance to stop = " .. curDistance .. " Current Speed Setting = " .. maxSpeed1 .. " Travelling @ = " .. TrainSpeed1 .. ""
				--	drawTxt(0.63, 1.230, 1.0,1.0,0.40, stringmsg, 255, 255, 255, 255)

					if TrainSpeed1 > maxSpeed1 then
						TrainSpeed1 = TrainSpeed1 - 2.0
						SetTrainSpeed(MetroTrain,TrainSpeed1)
						SetTrainCruiseSpeed(MetroTrain,TrainSpeed1)
					end

					if TrainSpeed1 < maxSpeed1 then
						TrainSpeed1 = TrainSpeed1 + 2.0
						SetTrainSpeed(MetroTrain,TrainSpeed1)
						SetTrainCruiseSpeed(MetroTrain,TrainSpeed1)
					end

					if curDistance < 5 then
						maxSpeed1 = 0.0
						SetTrainSpeed(MetroTrain,0.0)
						SetTrainCruiseSpeed(MetroTrain,0.0)	
						checkKillmetro()
						Citizen.Wait(10000)
						nextStop1 = nextStop1 + 1
						if nextStop1 > #trainstations then
							nextStop1 = 1
						end		
						--TriggerServerEvent("TrainStation:addblipMetro",trainstations[nextStop1][1],trainstations[nextStop1][2],trainstations[nextStop1][3])
					end
				else
					stopsrunning=false
					imhost=false
				end
			end
		end
	end)

	function checkKillcountry()
		dontdeletec = false
		for i = 1, 2 do
			if not IsVehicleSeatFree(Train, i) then
				dontdeletec = true
			end
		end

		local targetVehicle = GetTrainCarriage(Train, 1)
		for i = 1, 2 do
			if not IsVehicleSeatFree(targetVehicle, i) then
				dontdeletec = true
			end
		end
		if not dontdeletec then
			local trailer = GetTrainCarriage(Train, 1)
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(trailer))
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(Train))
			stopsrunning2=false
			imhost2=false	
		end
	end

	function checkKillmetro()
		dontdelete = false
		for i = 1, 2 do
			if not IsVehicleSeatFree(MetroTrain, i) then
				dontdelete = true
			end
		end

		local targetVehicle = GetTrainCarriage(MetroTrain, 1)
		for i = 1, 2 do
			if not IsVehicleSeatFree(targetVehicle, i) then
				dontdelete = true
			end
		end
		if not dontdelete then

			local trailer = GetTrainCarriage(MetroTrain, 1)
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(trailer))
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(MetroTrain))
			stopsrunning=false
			imhost=false
		
		end
	end

	nextStop1 = 1

	function runStop1()
		if MetroTrain ~= nil then
			CoordCheck1 = GetEntityCoords(MetroTrain)
			closestDist1 = #(vector3(trainstations[nextStop1][1],trainstations[nextStop1][2],trainstations[nextStop1][3]) - CoordCheck1)
			return closestDist1
		end
	end

	nextStop2 = 1

	function runStop2()
		if Train ~= nil then
			CoordCheck2 = GetEntityCoords(Train)
			closestDist2 = #(vector3(trainstations2[nextStop2][1],trainstations2[nextStop2][2],trainstations2[nextStop2][3]) - CoordCheck2)
			return closestDist2
		end
	end

	function getClosestCountrySpawn()
		prevClosest2 = 99999.9
		for i = 1, #trainstations2 do
			Citizen.Trace(i)
			CoordC = GetEntityCoords(PlayerPedId())
			closestDist2 = #(vector3(trainstations2[i][1],trainstations2[i][2],trainstations2[i][3]) - CoordC)
			if closestDist2 < prevClosest2 then 
				prevClosest2 = closestDist2
				returninfo = trainstations2[i]
				nextStop2 = i + 1
				if nextStop2 > #trainstations2 then
					nextStop2 = 1
				end
			end		
		end
		return returninfo
	end

	function getClosestMetroSpawn()
		prevClosest = 99999.9
		for i = 1, #trainstations do
			Citizen.Trace(i)
			CoordC = GetEntityCoords(PlayerPedId())
			closestDist = #(vector3(trainstations[i][1],trainstations[i][2],trainstations[i][3]) - CoordC)
			Citizen.Trace(closestDist .. " | " .. prevClosest)
			if closestDist < prevClosest then 
				Citizen.Trace(closestDist .. " | " .. i)
				prevClosest = closestDist
				returninfo = trainstations[i]
				nextStop1 = i+1
				if nextStop1 > #trainstations then
					nextStop1 = 1
				end
				Citizen.Trace(nextStop1)
			end		
		end

		return returninfo
	end

	function getClosestMetroStop()
		prevClosest = 99999.9
		for i = 1, #train1platforms do
			CoordC = GetEntityCoords(PlayerPedId())
			closestDist2 = #(vector3(train1platforms[i][1],train1platforms[i][2],train1platforms[i][3]) - CoordC)
			if closestDist2 < prevClosest then 
				prevClosest = closestDist2
				returninfo = train1platforms[i]
			end		
		end
		return returninfo
	end


	RegisterCommand('train', function(args, raw)
		TriggerEvent('AskForTrainConfirmed')
	end)

	RegisterNetEvent("AskForTrainConfirmed")
	AddEventHandler("AskForTrainConfirmed", function()

		local closestMetro = getClosestMetroSpawn()
		local closestCountry = getClosestCountrySpawn()
		local countryDist = #(vector3(closestCountry[1],closestCountry[2],closestCountry[3]) - GetEntityCoords(PlayerPedId()))
		local metroDist = #(vector3(closestMetro[1],closestMetro[2],closestMetro[3]) - GetEntityCoords(PlayerPedId()))


		if metroDist < countryDist then
			if metroDist < 25.0 then 
				RLCore.Functions.TriggerCallback('trains:checkMoney', function(hasEnoughMoney)
				if hasEnoughMoney then
					TriggerServerEvent('trains:pay')
					Progressbar(60000,"Waiting for Train")
					StartMetro(closestMetro)
					 playerped = PlayerPedId(-1)
					 RLCore.Functions.Notify('Train is here! Press E to board')
						if IsPedInAnyTrain(playerped) then
							RLCore.Functions.Notify('You boarded the train!')
						else
							RLCore.Functions.Notify('Sorry, this carriage is full!')
					end
				else
					RLCore.Functions.Notify("Sorry, You don't have enough money!", 'error')
				end
				end)
			else
				RLCore.Functions.Notify("Sorry, you are way too far from train station!", 'error')
			end
		else
			if countryDist < 25.0 then 	
				RLCore.Functions.TriggerCallback('trains:checkMoney', function(hasEnoughMoney2)
				if hasEnoughMoney2 then
					TriggerServerEvent('trains:pay2')
					Progressbar(60000,"Waiting for Train")
					StartCountry(closestCountry)
					playerped = PlayerPedId(-1)
					RLCore.Functions.Notify('Train is here! Press E to board')
						if IsPedInAnyTrain(playerped) then
							RLCore.Functions.Notify('You boarded the train!')
						else
							RLCore.Functions.Notify('Sorry, this carriage is full!')
						end
				else
					RLCore.Functions.Notify("Sorry, You don't have enough money!", 'error')
				end
				end)
			else
				RLCore.Functions.Notify("Sorry, you are way too far from train station!", 'error')
			end
		end
	end)

	-- inner city trains
	trainstations = {
		{-547.34057617188,-1286.1752929688,25.3059978411511},
		{-892.66284179688,-2322.5168457031,-13.246466636658},
		{-1100.2299804688,-2724.037109375,-8.3086919784546},
		{-1071.4924316406,-2713.189453125,-8.9240007400513},
		{-875.61907958984,-2319.8686523438,-13.241264343262},
		{-536.62890625,-1285.0009765625,25.301458358765},
		{270.09558105469,-1209.9177246094,37.465930938721},
		{-287.13568115234,-327.40936279297,8.5491418838501},
		{-821.34295654297,-132.45257568359,18.436864852905},
		{-1359.9794921875,-465.32354736328,13.531299591064},
		{-498.96591186523,-680.65930175781,10.295949935913},
		{-217.97073364258,-1032.1605224609,28.724565505981},
		{113.90325164795,-1729.9976806641,28.453630447388},
		{117.33223724365,-1721.9318847656,28.527353286743},
		{-209.84713745117,-1037.2414550781,28.722997665405},
		{-499.3971862793,-665.58514404297,10.295639038086},
		{-1344.5224609375,-462.10494995117,13.531820297241},
		{-806.85192871094,-141.39852905273,18.436403274536},
		{-302.21514892578,-327.28854370117,8.5495929718018},
		{262.01733398438,-1198.6135253906,37.448017120361}
	}

	train1platforms = {
		{-543.84686279297,-1287.7620849609,26.901607513428},
		{-883.95007324219,-2318.7321777344,-11.732789993286},
		{-1089.8125,-2721.6364746094,-7.410135269165},
		{273.87789916992,-1204.3369140625,38.899459838867},
		{-294.69540405273,-327.75311279297,10.063080787659},
		{-845.41217041016,-155.26510620117,19.950351715088},
		{-1354.9700927734,-459.91235351563,15.045303344727},
		{-498.40017700195,-673.51654052734,11.809022903442},
		{-213.34342956543,-1029.0593261719,30.140535354614},
		{118.84923553467,-1730.1706542969,30.111122131348},
		{-212.40980529785,-1035.8253173828,30.139507293701}
	}
	-- outer city trains
	trainstations2 = {
		{664.93090820313,-997.59942626953,22.261747360229},
		{190.62687683105,-1956.8131103516,19.520135879517},
		{2615.3901367188,2934.8666992188,39.312232971191},
		{2885.5346679688,4862.0146484375,62.551517486572},
		{47.061096191406,6280.8969726563,31.580261230469},
		{2002.3624267578,3619.8029785156,38.568252563477},
		{2609.7016601563,2937.11328125,39.418235778809}
	}

	trainstations2blip = {
		vector3(664.93090820313,-997.59942626953,22.261747360229),
		vector3(190.62687683105,-1956.8131103516,19.520135879517),
		vector3(2615.3901367188,2934.8666992188,39.312232971191),
		vector3(2885.5346679688,4862.0146484375,62.551517486572),
		vector3(47.061096191406,6280.8969726563,31.580261230469),
		vector3(2002.3624267578,3619.8029785156,38.568252563477),
		vector3(2609.7016601563,2937.11328125,39.418235778809)
	}

	trainstationsblip = {
		vector3(-547.34057617188,-1286.1752929688,25.3059978411511),
		vector3(-892.66284179688,-2322.5168457031,-13.246466636658),
		vector3(-1100.2299804688,-2724.037109375,-8.3086919784546),
		vector3(-1071.4924316406,-2713.189453125,-8.9240007400513),
		vector3(-875.61907958984,-2319.8686523438,-13.241264343262),
		vector3(-536.62890625,-1285.0009765625,25.301458358765),
		vector3(270.09558105469,-1209.9177246094,37.465930938721),
		vector3(-287.13568115234,-327.40936279297,8.5491418838501),
		vector3(-821.34295654297,-132.45257568359,18.436864852905),
		vector3(-1359.9794921875,-465.32354736328,13.531299591064),
		vector3(-498.96591186523,-680.65930175781,10.295949935913),
		vector3(-217.97073364258,-1032.1605224609,28.724565505981),
		vector3(113.90325164795,-1729.9976806641,28.453630447388),
		vector3(117.33223724365,-1721.9318847656,28.527353286743),
		vector3(-209.84713745117,-1037.2414550781,28.722997665405),
		vector3(-499.3971862793,-665.58514404297,10.295639038086),
		vector3(-1344.5224609375,-462.10494995117,13.531820297241),
		vector3(-806.85192871094,-141.39852905273,18.436403274536),
		vector3(-302.21514892578,-327.28854370117,8.5495929718018),
		vector3(262.01733398438,-1198.6135253906,37.448017120361)
	}


	function CreateBlip(trainstationsblip)
		local blip = AddBlipForCoord(trainstationsblip)

		SetBlipSprite(blip, 36)
		SetBlipScale(blip, 0.75)
		SetBlipColour(blip, 2)
		SetBlipDisplay(blip, 4)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Metro Train Station")
		EndTextCommandSetBlipName(blip)

		return blip
	end

	function CreateBlip2(trainstations2blip)
		local blip = AddBlipForCoord(trainstations2blip)

		SetBlipSprite(blip, 36)
		SetBlipScale(blip, 0.75)
		SetBlipColour(blip, 1)
		SetBlipDisplay(blip, 4)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Country Train Station")
		EndTextCommandSetBlipName(blip)

		return blip
	end

	Citizen.CreateThread(function()
			local currentGasBlip = 0

			while true do
				local coords = GetEntityCoords(PlayerPedId())
				local closest = 1000
				local closestCoords

				for _, stationCoords in pairs(trainstationsblip)  do
					local dstcheck = GetDistanceBetweenCoords(coords, stationCoords)

					if dstcheck < closest then
						closest = dstcheck
						closestCoords = stationCoords
					end
				end

				if DoesBlipExist(currentGasBlip) then
					RemoveBlip(currentGasBlip)
				end


				currentGasBlip = CreateBlip(closestCoords)

				Citizen.Wait(10000)
			end
	end)


	Citizen.CreateThread(function()
			local currentGasBlip = 0

			while true do
				local coords = GetEntityCoords(PlayerPedId())
				local closest = 1000
				local closestCoords2

				for _, stationCoords2 in pairs(trainstations2blip)  do
					local dstcheck = GetDistanceBetweenCoords(coords, stationCoords2)

					if dstcheck < closest then
						closest = dstcheck
						closestCoords2 = stationCoords2
					end
				end

				if DoesBlipExist(currentGasBlip) then
					RemoveBlip(currentGasBlip)
				end

				currentGasBlip = CreateBlip2(closestCoords2)

				Citizen.Wait(10000)
			end
	end)



	intrain = false
	justborded = false
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)

			if(IsControlJustReleased(1,  38))then

				playerped = PlayerPedId()
				targetVehicle = getVehicleInDirection()
				seats = GetVehicleModelNumberOfSeats(GetEntityModel(targetVehicle))

				if IsThisModelATrain( GetEntityModel(targetVehicle) ) and not intrain then
					
					for i = 1, 2 do
						if IsVehicleSeatFree(targetVehicle, i) then
							if not IsPedInAnyTrain(playerped) then
								SetPedIntoVehicle(playerped, targetVehicle, i)
								 FreezeEntityPosition(PlayerPedId(), true)
								 justborded = true
							end
						end
					end


					local targetVehicle = GetTrainCarriage(targetVehicle, 1)
					for i = 1, 2 do
						if IsVehicleSeatFree(targetVehicle, i) then
							if not IsPedInAnyTrain(playerped) then
								SetPedIntoVehicle(playerped, targetVehicle, i)	
								FreezeEntityPosition(PlayerPedId(), true)		
								justborded = true			
							end
						end
					end


					if IsPedInAnyTrain(playerped) then
						intrain = true
						RLCore.Functions.Notify('You boarded the train!')
				else
						RLCore.Functions.Notify('Sorry, this carriage is full!')
					end
					Citizen.Wait(1500)
					justborded = false
				else
					if (intrain or IsPedInAnyTrain(PlayerPedId())) and GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 3.6 then

						--local speeds = GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId()))
						if not justborded then
							nearestStop = getClosestMetroStop()
							CoordC = GetEntityCoords(PlayerPedId())
							if #(vector3(nearestStop[1],nearestStop[2],nearestStop[3]) - CoordC) < 20 then
								SetEntityCoords(playerped,nearestStop[1],nearestStop[2],nearestStop[3])
								FreezeEntityPosition(PlayerPedId(), false)
							else
								coordTo = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 3.0, 0.0)
								SetEntityCoords(playerped,coordTo)
								FreezeEntityPosition(PlayerPedId(), false)
							end
							intrain = false
						end
					end
				end
			end
		end
	end)

	function StartMetro(coords)

		stopsrunning = false
		imhost = false

		if MetroTrain ~= nil then
			local trailer = GetTrainCarriage(MetroTrain, 1)

			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(trailer))
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(MetroTrain))
		end

		TrainSpeed1 = 0.0
		maxSpeed1 = 0.0


		local models = { "freight", "freightcar", "freightgrain", "freightcont1", "freightcont2",
				"freighttrailer", "tankercar", "metrotrain", "s_m_m_lsmetro_01" }
		for  _,model in ipairs(models) do
			tempmodel = GetHashKey(model)
			RequestModel(tempmodel)
			while not HasModelLoaded(tempmodel) do
				RequestModel(tempmodel)
				Citizen.Wait(0)
			end
		end

		MetroTrain = CreateMissionTrain(24,coords[1],coords[2],coords[3],true) -- these ones have pre-defined spawns since they are a pain to set up


		SetTrainSpeed(MetroTrain,0.0)	
		SetTrainCruiseSpeed(MetroTrain,0.0)

		local trailer = GetTrainCarriage(MetroTrain, 1)

		SetVehicleHasBeenOwnedByPlayer(MetroTrain,true)
		local id = NetworkGetNetworkIdFromEntity(MetroTrain)
		SetNetworkIdCanMigrate(id, false)

		SetVehicleHasBeenOwnedByPlayer(trailer,true)
		local id = NetworkGetNetworkIdFromEntity(trailer)
		SetNetworkIdCanMigrate(id, false)

		RLCore.Functions.Notify('Train will depart in 30 seconds.')
		
		Citizen.Wait(30000)
		stopsrunning = true
		imhost = true
	end

	function StartCountry(coords)

		stopsrunning2 = false
		imhost2 = false

		if Train ~= nil then
			local trailer = GetTrainCarriage(Train, 1)
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(trailer))
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(Train))
		end

		TrainSpeed2 = 0.0
		maxSpeed2 = 0.0

		local models = { "freight", "freightcar", "freightgrain", "freightcont1", "freightcont2",
				"freighttrailer", "tankercar", "metrotrain", "s_m_m_lsmetro_01" }
		for  _,model in ipairs(models) do
			tempmodel = GetHashKey(model)
			RequestModel(tempmodel)
			while not HasModelLoaded(tempmodel) do
				RequestModel(tempmodel)
				Citizen.Wait(0)
			end
		end

		Train = CreateMissionTrain(24,coords[1],coords[2],coords[3],false)

		SetTrainSpeed(Train,0.0)
		SetTrainCruiseSpeed(Train,0.0)
		SetVehicleHasBeenOwnedByPlayer(Train,true)
		local id = NetworkGetNetworkIdFromEntity(Train)
		SetNetworkIdCanMigrate(id, false)


		local trailer = GetTrainCarriage(Train, 1)

		SetVehicleHasBeenOwnedByPlayer(trailer,true)
		local id = NetworkGetNetworkIdFromEntity(trailer)
		SetNetworkIdCanMigrate(id, false)

		RLCore.Functions.Notify('Train will depart in 30 seconds.')

		Citizen.Wait(30000)
		stopsrunning2 = true
		imhost2 = true
	end