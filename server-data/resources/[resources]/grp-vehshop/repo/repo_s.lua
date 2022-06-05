RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

PlayerTable = {}

RegisterNetEvent('JAM_VehicleFinance:PlayerDropped')
AddEventHandler('JAM_VehicleFinance:PlayerDropped', function(startTime)
	local xPlayer = RLCore.Functions.GetPlayer(source)
	local tick = 0
	while not xPlayer and tick < 100 do
		Citizen.Wait(0)
		tick = tick + 1
		xPlayer = RLCore.Functions.GetPlayer(source)
	end

	local data = RLCore.Functions.ExecuteSql(false,'SELECT * FROM bbvehicles WHERE citizenid=@citizenid',{['@citizenid'] = xPlayer.PlayerData.citizenid})
	if not data then return; end

	local curTime =  ((GetGameTimer() / 1000) / 60) - startTime
	for k,v in pairs(data) do
		if v.finance > 0 then
			RLCore.Functions.ExecuteSql(false,'UPDATE bbvehicles SET financetimer=@financetimer WHERE plate=@plate',{['@financetimer'] = v.financetimer - curTime, ['@plate'] = v.plate})
		end
	end
end)

RegisterNetEvent('JAM_VehicleFinance:MarkVehicles')
AddEventHandler('JAM_VehicleFinance:MarkVehicles', function(vehicles)
	TriggerClientEvent('JAM_VehicleFinance:MarkForRepo', -1, vehicles)
end)

RLCore.Functions.CreateCallback('JAM_VehicleFinance:RepoVehicle', function(source,cb,vehicleProps)
	local data = RLCore.Functions.ExecuteSql(false,'SELECT * FROM bbvehicles WHERE plate=@plate',{['@plate'] = vehicleProps.plate})
	if not data or not data[1] then return; end
	local cbData = false
	for k,v in pairs(data) do
		if v.finance > 0 and v.financetimer <= 0 then cbData = true; end
	end	
	cb(cbData)
end)

RLCore.Functions.CreateCallback('JAM_VehicleFinance:RepoVehicleEnd', function(source, cb, vehicle)

	local canDel = true
	local val = 0
	local xPlayer = RLCore.Functions.GetPlayerData(source)

	print(json.encode(vehicle.plate))

	RLCore.Functions.ExecuteSql(false,"SELECT * FROM bbvehicles WHERE plate='"..vehicle.plate.."'",  function(data)
		if not data or not data[1] then 
			canDel = false  
			print("false1")
		end
		if data and data[1] then 
			if data[1].finance <= 0 or data[1].financetimer > 0 then 
				canDel = false 
				print("false2")
			end 
		end
	
		if canDel then
			vehicleProps = vehicle
			price = data[1].finance
			print(json.encode(price))
			local fuck = {damage = 10, fuel = 98}
			RLCore.Functions.ExecuteSql(false,"INSERT INTO repos_for_sale (plate, props, stats, state, drivingdistance, price) VALUES ('"..vehicle.plate.."', '"..json.encode(vehicleProps).."', '"..json.encode(fuck).."', 'unknown', '"..json.encode(vehicle.drivingdistance).."', '"..price.."')")

			RLCore.Functions.ExecuteSql(false,"DELETE FROM bbvehicles WHERE plate ='"..vehicle.plate.."'",function(data)
			TriggerClientEvent("tp_repocarsales:refreshVehicles", -1)
			TriggerClientEvent('JAM_VehicleFinance:RemoveRepo', -1, vehicle)
			cb(canDel, val)
			end)
		else 
			cb(false)
		end
	end)
end)

RLCore.Functions.CreateCallback('JAM_VehicleFinance:GetOwnedVehicles',function(source, cb)
	local xPlayer = RLCore.Functions.GetPlayerData(source)
	while not xPlayer do xPlayer = RLCore.Functions.GetPlayerData(source); Citizen.Wait(0);end
	local data = RLCore.Functions.ExecuteSql(false,"SELECT * FROM bbvehicles WHERE citizenid=@citizenid",{['@citizenid'] = xPlayer.PlayerData.citizenid})		
	cb(data)
end)

RegisterNetEvent('JAM_VehicleFinance:RemoveFromRepoList')
AddEventHandler('JAM_VehicleFinance:RemoveFromRepoList', function(vehicle)
	TriggerClientEvent('JAM_VehicleFinance:RemoveRepo', -1, vehicle)
end)

RLCore.Functions.CreateCallback('JAM_VehicleFinance:PlayerLogin', function(source,cb)
	local xPlayer = RLCore.Functions.GetPlayer(source)
	local tick = 0
	while not xPlayer and tick < 100 do
		Citizen.Wait(0)
		tick = tick + 1
		local xPlayer = RLCore.Functions.GetPlayer(source)
	end
	RLCore.Functions.ExecuteSql(false,"SELECT * FROM bbvehicles WHERE citizenid='"..xPlayer.PlayerData.citizenid.."'", function(data)
		if not data or not data[1] then 
			return 
		end

		local cbData = false
		for k,v in pairs(data) do
			if v.finance > 0 and v.financetimer <= 0 then 
				if not cbData then cbData = {}; end
				table.insert(cbData, v) 
			end
		end

		cb(cbData)

	end)

end)

AddEventHandler("playerConnecting", function()
	local src = source
	local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
	table.insert(PlayerTable, {sourceID = steamIdentifier, timeJoined = GetGameTimer()})
end)

AddEventHandler('playerDropped', function()
	local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
	local xPlayer =RLCore.Functions.GetPlayer(source) 
	while not xPlayer do xPlayer =RLCore.Functions.GetPlayer(source); Citizen.Wait(0);end
	for _, v in pairs(identifiers) do
		if string.find(v, "steam") then
			steamIdentifier = v
			break
		end
	end
	local timeJoined, ky
	for k,v in pairs(PlayerTable) do 
		if v.sourceID == steamIdentifier then timeJoined = v.timeJoined; ky = k; end
	end
	if not timeJoined then return; end

	local identifier = steamIdentifier
	exports['ghmattimysql']:execute("SELECT * FROM bbvehicles WHERE citizenid='"..xPlayer.PlayerData.citizenid.."'", function(result)

		if not result then 
			return 
		end


		for k,v in pairs(result) do
			local thingi = math.floor(v.financetimer - (((GetGameTimer() - timeJoined) / 1000) / 60))
			if v.finance and v.finance > 0 then
				RLCore.Functions.ExecuteSql(false, "UPDATE `bbvehicles` SET `financetimer` = '"..thingi.."' WHERE `plate` = '"..v.plate.."'")

				--RLCore.Functions.ExecuteSql(false,'UPDATE bbvehicles SET financetimer=@financetimer WHERE plate=@plate', {['@financetimer'] = math.floor(v.financetimer - (((GetGameTimer() - timeJoined) / 1000) / 60)), ['@plate'] = v.plate} )
			end
		end
		table.remove(PlayerTable, ky)
	end)
end)

--[[ RegisterCommand('joinwtf', function(source, args)
	local src = source
	local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
	table.insert(PlayerTable, {sourceID = steamIdentifier, timeJoined = GetGameTimer()})
end)
  ]]
--[[ RegisterCommand('doRepay', function(source, args)
    local src = source
    local pPlate = plate
    local xPlayer = RLCore.Functions.GetPlayer(source)
	if GetVehiclePedIsIn(GetPlayerPed(src), false) == 0 then 
		RLCore.Functions.Notify("Get in a vehicle first")
		return
	end

	local plyVeh = GetVehiclePedIsIn(GetPlayerPed(src), false)
	local pPlate = GetVehicleNumberPlateText(plyVeh)

    if pPlate ~= nil then

        RLCore.Functions.ExecuteSql(false,"SELECT buy_price, plate FROM bbvehicles WHERE plate= '" .. pPlate .. "'",function(pData)
			for k,v in pairs(pData) do
				if pData ~= nil then
					if pPlate == v.plate then
						local price = (v.buy_price / 10)
						if xPlayer.PlayerData.money['bank'] >= price then
							fuck = true
							TriggerClientEvent("RLCore:Notify",src, "You payed $'".. price .. "' on your vehicle.")
							--TriggerClientEvent('chatMessage', src, 'IMPORTANT: ', 1, 'Please see pdm dealer for reimbursement. Take a screen shot of the payment or you will not receive any money back!')
							--TriggerClientEvent('chatMessage', src, 'IMPORTANT: ', 1, 'You payed $'.. price .. ' on your vehicle.')
						else
							fuck = false
							TriggerClientEvent("RLCore:Notify",src, "You need $'".. price .. "' to pay your finance.")
							--TriggerClientEvent('DoLongHudText', src, 'You don\'t have enough money to pay on this vehicle!', 2)
							--TriggerClientEvent('DoLongHudText', src, 'You need $'.. price .. ' to pay for your vehicle!', 1)
						end

						if fuck then
							RLCore.Functions.ExecuteSql(false,"SELECT finance FROM bbvehicles WHERE plate= '" .. pPlate .. "'" ,function(data)
								if not data or not data[1] then 
									return
								end
								local prevAmount = data[1].finance
								if prevAmount - price <= 0 or prevAmount - price <= 0.0 then
									settimer = 0
								else
									settimer = repayTime
									xPlayer.Functions.RemoveMoney('bank',price)
								end
								if prevAmount < price then
									RLCore.Functions.ExecuteSql(false, "UPDATE `bbvehicles` SET `finance` = '0' WHERE `plate` = '"..pPlate.."'")
									RLCore.Functions.ExecuteSql(false, "UPDATE `bbvehicles` SET `financetimer` = '1440' WHERE `plate` = '"..pPlate.."'")
								else
									RLCore.Functions.ExecuteSql(false, "UPDATE `bbvehicles` SET `finance` = '"..prevAmount - price.."' WHERE `plate` = '"..pPlate.."'")
									RLCore.Functions.ExecuteSql(false, "UPDATE `bbvehicles` SET `financetimer` = '1440' WHERE `plate` = '"..pPlate.."'")
									TriggerEvent("bb-bossmenu:server:addAccountMoney", "cardealer", 250)

								end
								
							end)
						end
					end
					return
				end
			end
		end)
    end
end) ]]
