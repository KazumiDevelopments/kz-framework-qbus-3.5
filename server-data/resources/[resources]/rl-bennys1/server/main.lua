RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

-- Code

RegisterServerEvent('rl-bennys:server:UpdateBusyState')
AddEventHandler('rl-bennys:server:UpdateBusyState', function(k, bool)
    RLCustoms.Locations[k]["busy"] = bool
    TriggerClientEvent('rl-bennys:client:UpdateBusyState', -1, k, bool)
end)

RegisterServerEvent('rl-bennys:print')
AddEventHandler('rl-bennys:print', function(data)
    print(data)
end)

RLCore.Functions.CreateCallback('rl-bennys:server:CanPurchase', function(source, cb, price)
    local Player = RLCore.Functions.GetPlayer(source)
    local CanBuy = false

    if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney('cash', price)
        CanBuy = true
    elseif Player.PlayerData.money.bank >= price then
        Player.Functions.RemoveMoney('bank', price)
        CanBuy = true
    else
        CanBuy = false
    end

    cb(CanBuy)
end)

RegisterServerEvent("rl-bennys:server:SaveVehicleProps")
AddEventHandler("rl-bennys:server:SaveVehicleProps", function(vehicleProps)
	local src = source
    if IsVehicleOwned(vehicleProps.plate) then
        RLCore.Functions.ExecuteSql(false, "UPDATE `bbvehicles` SET `props` = '"..json.encode(vehicleProps).."' WHERE `plate` = '"..vehicleProps.plate.."'")
    end
end)

function IsVehicleOwned(plate)
    local retval = false
    RLCore.Functions.ExecuteSql(true, "SELECT * FROM `bbvehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            retval = true
        end
    end)
    return retval
end

RLCore.Functions.CreateCallback('rl-bennys:server:IsMechanicAvailable', function(source, cb)
	local amount = 0
	for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "mechanic" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    cb(amount)
end)