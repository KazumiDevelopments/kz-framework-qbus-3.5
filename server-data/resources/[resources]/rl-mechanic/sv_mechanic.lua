RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent("rl-mechanic:attemptPurchase")
AddEventHandler("rl-mechanic:attemptPurchase", function(cheap, type, upgradeLevel)
    local src = source
    local price = 0

    if vehicleCustomisationPrices[type] and vehicleCustomisationPrices[type].prices and upgradeLevel then
        price = vehicleCustomisationPrices[type].prices[upgradeLevel]
    elseif vehicleCustomisationPrices[type] and vehicleCustomisationPrices[type].price then 
        price = vehicleCustomisationPrices[type].price
    end

    if exports['bb-bossmenu']:GetAccount("mechanic") >= price then
        TriggerEvent("bb-bossmenu:server:removeAccountMoney", "mechanic", price)
        TriggerClientEvent("rl-mechanic:purchaseSuccessful", src)
    else
        TriggerClientEvent("rl-mechanic:purchaseFailed", src)
    end
end)

RegisterServerEvent("rl-mechanic:updateVehicle")
AddEventHandler("rl-mechanic:updateVehicle", function(plate, vehicleMods)
    RLCore.Functions.ExecuteSql(false, "UPDATE `bbvehicles` SET `props` = '" .. json.encode(vehicleMods) .. "' WHERE `plate` = '" .. plate .. "'")
end)

function IsAuthorized(CitizenId)
    local retval = false
    for _, cid in pairs(Config.AuthorizedIds) do
        if cid == CitizenId then
            retval = true
            break
        end
    end
    return retval
end