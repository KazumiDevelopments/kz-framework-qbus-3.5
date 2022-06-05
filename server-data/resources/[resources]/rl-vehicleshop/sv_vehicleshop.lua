local RLCore = nil
local Charset = {}
local NumberCharset = {}
local VehicleCategorys = {}

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

CreateThread(function()
    for i = 48,  57 do 
        table.insert(NumberCharset, string.char(i)) 
    end

    for i = 65,  90 do 
        table.insert(Charset, string.char(i)) 
    end

    for i = 97, 122 do 
        table.insert(Charset, string.char(i)) 
    end
end)

RegisterServerEvent("carshop:requesttable")
AddEventHandler("carshop:requesttable", function()
    TriggerClientEvent("veh_shop:returnTable", source, Config.CarTable)
end)

RegisterServerEvent("carshop:table")
AddEventHandler("carshop:table", function(data)
    Config.CarTable = data
    TriggerClientEvent("veh_shop:returnTable", -1, Config.CarTable)
end)

RegisterServerEvent("carshop:updateCarTable")
AddEventHandler("carshop:updateCarTable", function(currentCarSpawnLocation, model,price,name)
    Config.CarTable[currentCarSpawnLocation]["model"] = model
	Config.CarTable[currentCarSpawnLocation]["costs"] = price
	Config.CarTable[currentCarSpawnLocation]["name"] = name
    TriggerClientEvent("veh_shop:returnTable", -1, Config.CarTable)
end)

RegisterServerEvent("CheckMoneyForVeh")
AddEventHandler("CheckMoneyForVeh", function(name, model, price)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveMoney('cash', price) then
        TriggerClientEvent("FinishMoneyCheckForVeh", src, name, model, price)
        TriggerClientEvent("RLCore:Notify", src, "You successfully bought this vehicle.")
    else
        TriggerClientEvent("carshop:failedpurchase", src)
        TriggerClientEvent("RLCore:Notify", src, "Not enough money.", "error")
    end
end)

--[[
RegisterServerEvent("BuyForVeh")
AddEventHandler("BuyForVeh", function(name, )
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    TriggxxxxxerClientEvent("veh_shop:setPlate", src, personalvehicle, GeneratePlate())
end)xxxx]]

RegisterServerEvent('veh_shop:setVehicleOwned')
AddEventHandler('veh_shop:setVehicleOwned', function(props, stats, model)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    RLCore.Functions.ExecuteSql(false, "INSERT INTO `bbvehicles` (`citizenid`, `plate`, `model`, `props`, `stats`, `state`) VALUES ('" .. xPlayer.PlayerData.citizenid .. "', '" .. props.plate .. "', '" .. model .. "', '" .. json.encode(props) .. "', '" .. json.encode(stats) .. "', 'unknown')")
end)

RegisterServerEvent("veh_shop:requestStopTestDrive")
AddEventHandler("veh_shop:requestStopTestDrive", function(id)
    TriggerClientEvent("veh_shop:stopTestDrive", id)
end)


function GeneratePlate()
    local plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
    RLCore.Functions.ExecuteSql(true, "SELECT * FROM `bbvehicles` WHERE `plate` = '"..plate.."'", function(result)
        while (result[1] ~= nil) do
            plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
        end
        return plate
    end)
    return plate:upper()
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end