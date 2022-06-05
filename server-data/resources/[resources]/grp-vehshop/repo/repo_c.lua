-- Start Thread

function Start()
	if not self then 
		return
	end
	while not JUtils do
		Citizen.Wait(0)
	end
	while not JVS do 
		Citizen.Wait(0)
	end

	--FinanceCheck()
	Citizen.CreateThread(function(...) 
		PlayerUpdate(...)
	end)
end

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

	FinanceCheck()
end)

-- Player Functions

function FinanceCheck()
	RLCore.Functions.TriggerCallback('JAM_VehicleFinance:PlayerLogin', function(repo)
		if repo then 
			RLCore.Functions.Notify("One of your vehicles has been marked for reposession. <br/>Make a payment now by visiting the dealership and using the computer at the front desk.",'error')
			TriggerServerEvent('JAM_VehicleFinance:MarkVehicles', repo) 
		end
	end)
end

local gotem = false
local allreadyDone = false
local removeBlipu = false

function GetVecDist(v1,v2)
	if not v1 or not v2 or not v1.x or not v2.x then return 0; end
	return math.sqrt(  ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) )+( (v1.z or 0) - (v2.z or 0) )*( (v1.z or 0) - (v2.z or 0) )  )
  end


function MechanicUpdate()
	while not Towables do Citizen.Wait(0); end	
	local closestVeh,closestDist,closestRepo
	local tick = 0
	local timer = GetGameTimer()

	while true do
		Citizen.Wait(0)	
		tick = tick + 1
		if tick % 100 == 1 then
			closestVeh = false
			closestDist = false
			closestRepo = false

			local plyPos = GetEntityCoords(GetPlayerPed(-1))
			local allVehicles = RLCore.Functions.GetVehiclesInArea(plyPos, 800000.0) 

			for k,v in pairs(allVehicles) do
				local vehProps = RLCore.Functions.GetVehicleProperties(v)
				local vehPos = GetEntityCoords(v)
				local dist = GetVecDist(plyPos, vehPos)
				if not closestDist or closestDist > dist then
					for key,val in pairs(Towables) do
						if val.plate == vehProps.plate then
							closestDist = dist
							closestRepo = v
						end
					end
				end
			end
		end

		if closestRepo and closestDist then
			
				if closestDist < 500000.0 then
					local closestPos = GetEntityCoords(closestRepo)
					createBlip(closestRepo)
					local plate = GetVehicleNumberPlateText(closestRepo)
					local vehicleLabel = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(closestRepo)))
					local streetName = GetStreetNameAtCoord(closestPos.x, closestPos.y, closestPos.z)
					local readableStreetname = GetStreetNameFromHashKey(streetName)
					allreadyDone = true
					
					--DrawMarker(27, closestPos.x, closestPos.y, closestPos.z - 0.4, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 5.0, 255, 45, 45, 100, false, true, 2, false, false, false, false)
					--DrawMarker(29, closestPos.x, closestPos.y, closestPos.z + 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 45, 45, 100, false, true, 2, false, false, false, false)
					--createBlip()
					if gotem then
						-- do nothing
					else
							--[[ createBlip(closestRepo)
							local plate = GetVehicleNumberPlateText(closestRepo)
							local vehicleLabel = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(closestRepo)))
							local streetName = GetStreetNameAtCoord(closestPos.x, closestPos.y, closestPos.z)
							local readableStreetname = GetStreetNameFromHashKey(streetName)
							exports['mythic_notify']:SendAlert('inform', 'You are looking for;<br />Model: <span style="font-weight:bold;color:red;">' .. vehicleLabel .. '</span> <br />Plate: <span style="font-weight:bold;color:red;">' .. plate .. '</span><br/> Last seen on ' .. readableStreetname, 45000, { ['background-color'] = '#fcc200', ['color'] = '#000000' })
							gotem = true ]]
						end
					end
					--createBlip(closestRepo)

					DrawRepoMarker(closestRepo, timer)
				elseif closestDist > 50.0 then
					closestDist = false
					closestRepo = false
				
				end
			
	end

end


function createBlip(closestRepo)
	if allreadyDone == false then
		local closestPos = GetEntityCoords(closestRepo)
		local plate = GetVehicleNumberPlateText(closestRepo)
		local vehicleLabel = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(closestRepo)))
		local streetName = GetStreetNameAtCoord(closestPos.x, closestPos.y, closestPos.z)
		local readableStreetname = GetStreetNameFromHashKey(streetName)

		RLCore.Functions.Notify('You are looking for:<br />Model: <span style="font-weight:bold;color:red;">' .. vehicleLabel .. '</span> <br />Plate: <span style="font-weight:bold;color:red;">' .. plate .. '</span><br/> Last seen on ' .. readableStreetname,'repo', 25000) 

		blip = AddBlipForEntity(closestRepo)
		SetBlipSprite(blip, 1)
		SetBlipColour(blip, 5)
		SetBlipFlashes(blip, true)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Car for repo')
		EndTextCommandSetBlipName(blip)
		SetBlipScale(blip, 0.8) -- set scale
		SetBlipAsShortRange(blip, true)
	end
end

local RepoPoint = vector3(421.850, -1149.630, 28)

function DrawRepoMarker(closestRepo, timer)
	local plyPos = GetEntityCoords(GetPlayerPed(-1))
	local dist = GetVecDist(RepoPoint, plyPos)
	if dist < 30.0 then
		DrawMarker(2, RepoPoint.x, RepoPoint.y, RepoPoint.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
		if dist < 3.0 then
			DrawText3D(RepoPoint.x, RepoPoint.y, RepoPoint.z +1.2,"[E] To Repo") 
			--ESX.ShowHelpNotification("Press ~INPUT_PICKUP~ to repossess the nearest vehicle.") 
			if (IsControlJustPressed(0, 86) or IsDisabledControlJustPressed(0, 86)) and (GetGameTimer() - timer > 200) then
				timer = GetGameTimer()
				local vehProps = RLCore.Functions.GetVehicleProperties(closestRepo)
				RLCore.Functions.TriggerCallback('JAM_VehicleFinance:RepoVehicleEnd', function(valid, val)
					if valid then 
						local maxPassengers = GetVehicleMaxNumberOfPassengers(closestRepo)
				    for seat = -1,maxPassengers-1,1 do
				      local ped = GetPedInVehicleSeat(closestRepo,seat)
				    if ped and ped ~= 0 then TaskLeaveVehicle(ped,closestRepo,16); end
				    end 
					RLCore.Functions.DeleteVehicle(closestRepo)
					RLCore.Functions.Notify('You earnt $1000 for the repossession.', "success")
						--ESX.ShowNotification('You earnt $~g~'..val..'~s~ for the repossession.')
					xPlayer.Functions.AddMoney("bank", 1000)
						

						table.remove(Towables,k)
					else
						RLCore.Functions.Notify("You can't repossess this vehicle.",'inform')
						--ESX.ShowNotification("You can't repossess this vehicle.")
					end
				end, vehProps)
			end
		end
	end
end



function DrawText3D(x,y,z, text)
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

-- Repo Events

RegisterNetEvent('JAM_VehicleFinance:RemoveRepo')
AddEventHandler('JAM_VehicleFinance:RemoveRepo', function(vehicle)
	--if not JVF or not Towables or not Towables[1] then return; end
	for k,v in pairs(Towables) do
		if v.plate == vehicle then
			table.remove(Towables,k)
		end	
	end
end)

RegisterNetEvent('JAM_VehicleFinance:MarkForRepo')
AddEventHandler('JAM_VehicleFinance:MarkForRepo', function(vehicles)
	while not RLCore do 
		Citizen.Wait(0) 
	end
	local pData = RLCore.Functions.GetPlayerData()
	if pData.job.name ~= 'mechanic' then 
		return
	end
	Towables = Towables or {}
	for k,v in pairs(vehicles) do 
		table.insert(Towables, v)
	end
end)

--[[ RegisterCommand('checkRepos', function(...) 
	local pData = RLCore.Functions.GetPlayerData()
	allreadyDone = false
	RLCore.Functions.Notify("If you dont see a message after this, That means there are currently no repos on the streets <br/ > <br/ >Try again in a short while.",'error')
	--exports['mythic_notify']:SendAlert('error', 'If you dont see a message after this, That means there are currently no repos on the streets <br/ > <br/ >Try again in a short while.', 10000)
	if pData.job.name == 'mechanic' then
		if not Towables then 
			RLCore.Functions.Notify("There are no vehicles marked for reposession at the moment.",'error')
			--exports['mythic_notify']:SendAlert('error', 'There are no vehicles marked for reposession at the moment.', 10000)
			return
		end
		local compString = ''
		for k,v in pairs(Towables) do
			local str = 'Plate : '..v.plate..'\nOwed : '..v.finance..'\n'
			print(str)
			MechanicUpdate()
		end
	end
end) ]]


RegisterNetEvent('mechanic:client:repoCheck')
AddEventHandler('mechanic:client:repoCheck', function()
	local pData = RLCore.Functions.GetPlayerData()
	allreadyDone = false
	RLCore.Functions.Notify("If you dont see a message after this, That means there are currently no repos on the streets <br/ > <br/ >Try again in a short while.",'error')
	if pData.job.name == 'mechanic' then
		if not Towables then 
			RLCore.Functions.Notify("There are no vehicles marked for reposession at the moment.",'error')
			return
		end
		local compString = ''
		for k,v in pairs(Towables) do
			local str = 'Plate : '..v.plate..'\nOwed : '..v.finance..'\n'
			print(str)
			MechanicUpdate()
		end
	end
end)


Citizen.CreateThread(function(...) Start(); end)


RegisterCommand('checkRepay', function(source, args)
	local plyPed = GetPlayerPed(-1)
	if not IsPedInAnyVehicle(plyPed, false) then RLCore.Functions.Notify('Get in a vehicle first.')
		return
	end
	local plyVeh = GetVehiclePedIsIn(plyPed, true)
	local vehProps = RLCore.Functions.GetVehicleProperties(plyVeh)

	RLCore.Functions.TriggerCallback('tc-finance:GetOwnedVehicles', function(data)
		if not data then RLCore.Functions.Notify("You dont own any vehicles", 'error') 
			return
		end
		local matched = false
		for k,v in pairs(data) do
			if vehProps.plate == v.plate then 
				matched = true
				print(vehProps.plate,v.plate)
				if v.finance then
					if v.finance < 1 then
						
						
						RLCore.Functions.Notify("You own this vehicle", 'error') 
					else
						local fprice = v.financetimer / 60
						local pprice = round(fprice)
						RLCore.Functions.Notify("You owe $"..v.finance..". You have "..(pprice).." minutes remaining to make a repayment.") 
					end
				end
			end
		end
		if not matched then RLCore.Functions.Notify("You dont own this vehicle", 'error'); end
	end)
end)

function round(num)
    under = math.floor(num)
    upper = math.floor(num) + 1
    underV = -(under - num)
    upperV = upper - num
    if (upperV > underV) then
        return under
    else
        return upper
    end
end

--[[ RegisterCommand('doRepay', function(source, args)
	if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
		RLCore.Functions.Notify("Get in a vehicle first")
		return
	end
	if not args then 
		RLCore.Functions.Notify("You need to enter a valid amount", 'error')
		return
	end
	local repayAmount = tonumber(args[1])
	if not repayAmount or repayAmount == nil or repayAmount < 1 then 
		RLCore.Functions.Notify("You need to enter a valid amount", 'error')
	end
	
	local plyPed = GetPlayerPed(-1)
	local plyVeh = GetVehiclePedIsIn(plyPed, true)
	local vehProps = RLCore.Functions.GetVehicleProperties(plyVeh)

	local lowestAmount
	local vehPrice

	for k,v in pairs(JVS.ShopData) do
		for k,v in pairs(v) do
			if GetHashKey(v.model)%0x100000000 == vehProps.model%0x100000000 then 
				lowestAmount = (v.price / JVF.MaxRepayments)
				vehPrice = v.price
			end
		end
	end

	RLCore.Function.TriggerCallback('tc-finance:GetOwnedVehicles', function(data)
		if not data then return; end
		local matched = false
		for k,v in pairs(data) do
			if vehProps.plate == v.plate then 
				matched = true
				if not v.finance or (v.finance and v.finance < 1) then
					RLCore.Functions.Notify("This vehicle has already been paid for.")
					--ESX.ShowNotification("This vehicle has already been paid for.")
				else
					local diff = 0
					local calc = v.finance + lowestAmount
					if calc > vehPrice then diff = calc - vehPrice; else diff = lowestAmount; end
					if repayAmount < diff then 
						RLCore.Functions.Notify("You need to pay at least $~r~"..diff.."~s~ at a time.")
						return 
					else
						RLCore.Functions.TriggerCallback('tc-finance:RepayLoan', function(valid) 
							if valid then 
								RLCore.Functions.Notify("You have payed $~g~"..repayAmount.." ~s~towards this vehicles loan.")
								TriggerServerEvent('JAM_VehicleFinance:RemoveFromRepoList', vehProps.plate)
								return 
							else 
								RLCore.Functions.Notify("You don't have enough money.", 'error')
								return
							end
						end, vehProps.plate, repayAmount)
					end
				end
			end
		end
		if not matched then RLCore.Functions.Notify("No body owns this vehicle", 'error'); end
	end)
end)  ]]
