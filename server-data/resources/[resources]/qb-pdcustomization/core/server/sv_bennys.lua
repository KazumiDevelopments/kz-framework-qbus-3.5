RLCore = nil

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local chicken = vehicleBaseRepairCost

RegisterServerEvent('pdcustomization:attemptPurchase')
AddEventHandler('pdcustomization:attemptPurchase', function(cheap, type, upgradeLevel)
    local source = source
    local Player = RLCore.Functions.GetPlayer(source)
    if type == "repair" then
        if Player.PlayerData.money.cash >= chicken then
            Player.Functions.RemoveMoney('cash', chicken)
            TriggerClientEvent('pdcustomization:purchaseSuccessful', source)
        else
            TriggerClientEvent('pdcustomization:purchaseFailed', source)
        end
    elseif type == "performance" then
        if Player.PlayerData.money.cash >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('pdcustomization:purchaseSuccessful', source)
            Player.Functions.RemoveMoney('cash', vehicleCustomisationPrices[type].prices[upgradeLevel])
        else
            TriggerClientEvent('pdcustomization:purchaseFailed', source)
        end
    else
        if Player.PlayerData.money.cash >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('pdcustomization:purchaseSuccessful', source)
            Player.Functions.RemoveMoney('cash', vehicleCustomisationPrices[type].price)
        else
            TriggerClientEvent('pdcustomization:purchaseFailed', source)
        end
    end
end)

RegisterServerEvent('pdcustomization:updateRepairCost')
AddEventHandler('pdcustomization:updateRepairCost', function(cost)
    chicken = cost
end)

--[[ RegisterServerEvent("updateVehicle")
AddEventHandler("updateVehicle", function(myCar)
	local src = source
    if IsVehicleOwned(myCar.plate) then
        exports.oxmysql:execute("UPDATE `xzvehicles` SET `props` = ? WHERE `plate` = ?", { json.encode(myCar), myCar.plate })
    end
end)

function IsVehicleOwned(plate)
    local retval = false
    exports.oxmysql:fetch("SELECT * FROM `xzvehicles` WHERE `plate` = ?", { plate }, function(result)
        if result[1] ~= nil then
            retval = true
        end
    end)
    return retval
end ]]