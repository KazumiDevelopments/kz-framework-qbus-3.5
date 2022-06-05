RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local cachedData = {}

RLCore.Functions.CreateCallback("betrayed_garage:obtenerVehiculos", function(source, callback, garage)
	print("YES")
	local player = RLCore.Functions.GetPlayer(source)

	if player then
		local sqlQuery = [[SELECT plate, model FROM bbvehicles WHERE citizenid = @cid]]

		if garage then
			sqlQuery = [[SELECT plate, model FROM bbvehicles WHERE citizenid = @cid and garage = @garage]]
		end

		RLCore.Functions.ExecuteSql(false, sqlQuery, {
			["@cid"] = player.PlayerData.citizenid, 
			["@garage"] = garage
		}, function(responses)
			--[[ for c,v in pairs(responses) do
				print(v.plate)
			end ]]
			getPlayerVehiclesOut(player.identifier ,function(data)
				enviar = {responses,data}
				callback(enviar)
			end)
		end)
	else
		callback(false)
	end
end)

function getPlayerVehiclesOut(identifier,cb)
	local vehicles = {}
	local data = RLCore.Functions.ExecuteSql(false, "SELECT * FROM bbvehicles WHERE citizenid=@identifier",{['@identifier'] = identifier})	
	cb(data)
end

RLCore.Functions.CreateCallback("betrayed_garage:validateVehicle", function(source, callback, vehicleProps, garage)
	local player = RLCore.Functions.GetPlayer(source)

	if player then
		local sqlQuery = [[SELECT citizenid FROM bbvehicles WHERE plate = @plate]]

		RLCore.Functions.ExecuteSql(false, sqlQuery, {
			["@plate"] = vehicleProps["plate"]
		}, function(responses)
			if responses[1] then
				callback(true)
			else
				callback(false)
			end
		end)
	else
		callback(false)
	end
end)

RLCore.Functions.CreateCallback('betrayed_garage:checkMoney', function(source, cb)
	local xPlayer = RLCore.Functions.GetPlayer(source)
	local deudas = 0
	local result = RLCore.Functions.ExecuteSql(false, 'SELECT * FROM billing WHERE identifier = @identifier',{['@identifier'] = xPlayer.identifier})
	for i=1, #result, 1 do
		amount = result[i].amount
		deudas = deudas + amount
    end
    if deudas >= 2000 then
        cb("deudas")
        return
    end
	if xPlayer.get('money') >= 200 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('betrayed_garage:pay')
AddEventHandler('betrayed_garage:pay', function()
	local xPlayer = RLCore.Functions.GetPlayer(source)
	--xPlayer.removeMoney(200) 
	--TriggerClientEvent("banking:removeBalance", source, 200)  
end)

RegisterServerEvent('betrayed_garage:modifystate')
AddEventHandler('betrayed_garage:modifystate', function(vehicleProps, state, garage)
	local xPlayer = RLCore.Functions.GetPlayer(source) 
	local plate = vehicleProps.plate

	if garage == nil then
		RLCore.Functions.ExecuteSql(false, "UPDATE bbvehicles SET garage=@garage WHERE plate=@plate",{['@garage'] = "OUT" , ['@plate'] = plate})
		RLCore.Functions.ExecuteSql(false, "UPDATE bbvehicles SET vehicle=@vehicle WHERE plate=@plate",{['@vehicle'] = json.encode(vehicleProps) , ['@plate'] = plate})
		RLCore.Functions.ExecuteSql(false, "UPDATE bbvehicles SET state=@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})
	else 

		RLCore.Functions.ExecuteSql(false, "UPDATE bbvehicles SET garage=@garage WHERE plate=@plate",{['@garage'] = garage , ['@plate'] = plate})
		RLCore.Functions.ExecuteSql(false, "UPDATE bbvehicles SET vehicle=@vehicle WHERE plate=@plate",{['@vehicle'] = json.encode(vehicleProps) , ['@plate'] = plate})
		RLCore.Functions.ExecuteSql(false, "UPDATE bbvehicles SET state=@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})

	end
end)

RegisterServerEvent('betrayed_garage:modifyHouse')
AddEventHandler('betrayed_garage:modifyHouse', function(vehicleProps)
	local _source = source
	local xPlayer = RLCore.Functions.GetPlayer(source)
	local plate = vehicleProps.plate
	print(json.encode(plate))

	--MySQL.Sync.execute("UPDATE bbvehicles SET garage=@garage WHERE plate=@plate",{['@garage'] = garage , ['@plate'] = plate})
	RLCore.Functions.ExecuteSql(false, "UPDATE bbvehicles SET vehicle=@vehicle WHERE plate=@plate",{['@vehicle'] = json.encode(vehicleProps) , ['@plate'] = plate})

	
end)

RegisterServerEvent("betrayed_garage:sacarometer")
AddEventHandler("betrayed_garage:sacarometer", function(vehicle,state,source1)
	local source = source
	if source1 then
		source = source1
	end
	local xPlayer = RLCore.Functions.GetPlayer(source)
	while xPlayer == nil do Citizen.Wait(1); end
	local plate = all_trim(vehicle)
	local state = state
	RLCore.Functions.ExecuteSql(false, "UPDATE bbvehicles SET state =@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})
end)

function all_trim(s)
	return s:match( "^%s*(.-)%s*$" )
end

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
  end

 RegisterNetEvent("garages:CheckGarageForVeh")
AddEventHandler("garages:CheckGarageForVeh", function()
    local source = source
    local xPlayer = RLCore.Functions.GetPlayer(source)
    local identifier = xPlayer.identifier
    
    print(identifier)
    RLCore.Functions.ExecuteSql(false, 'SELECT * FROM bbvehicles WHERE citizenid = @identifier', { ['@identifier'] = identifier }, function(vehicles)
        TriggerClientEvent('phone:Garage', source, vehicles)
    end)
end)