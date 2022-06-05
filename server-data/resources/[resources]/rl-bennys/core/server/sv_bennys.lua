RLCore = nil

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local chicken = vehicleBaseRepairCost

RegisterServerEvent('rl-bennys:attemptPurchase')
AddEventHandler('rl-bennys:attemptPurchase', function(type, upgradeLevel)
    local source = source
    local Player = RLCore.Functions.GetPlayer(source)
    if type == "repair" then
        if Player.PlayerData.money.cash >= chicken then
            Player.Functions.RemoveMoney('cash', chicken)
            TriggerClientEvent('rl-bennys:purchaseSuccessful', source)
        else
            TriggerClientEvent('rl-bennys:purchaseFailed', source)
        end
    elseif type == "performance" then
        if Player.PlayerData.money.cash >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('rl-bennys:purchaseSuccessful', source)
            Player.Functions.RemoveMoney('cash', vehicleCustomisationPrices[type].prices[upgradeLevel])
        else
            TriggerClientEvent('rl-bennys:purchaseFailed', source)
        end
    else
        if Player.PlayerData.money.cash >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('rl-bennys:purchaseSuccessful', source)
            Player.Functions.RemoveMoney('cash', vehicleCustomisationPrices[type].price)
        else
            TriggerClientEvent('rl-bennys:purchaseFailed', source)
        end
    end
end)

RegisterServerEvent('rl-bennys:updateRepairCost')
AddEventHandler('rl-bennys:updateRepairCost', function(cost)
    chicken = cost
end)

RegisterServerEvent("updateVehicle")
AddEventHandler("updateVehicle", function(myCar)
	local src = source
    if IsVehicleOwned(myCar.plate) then
        RLCore.Functions.ExecuteSql(false, "UPDATE `bbvehicles` SET `props` = '"..json.encode(myCar).."' WHERE `plate` = '"..myCar.plate.."'")
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