local RLCore = exports['rl-core']:GetCoreObject()

local repairCost = vehicleBaseRepairCost

RegisterNetEvent('rl-customs:attemptPurchase', function(type, upgradeLevel)
    local source = source
    local Player = RLCore.Functions.GetPlayer(source)
    local balance = nil
    if Player.PlayerData.job.name == "mechanic" then
        balance = exports['qb-bossmenu']:GetAccount(Player.PlayerData.job.name)
    else
        balance = Player.Functions.GetMoney(moneyType)
    end
    if type == "repair" then
        if balance >= repairCost then
            if Player.PlayerData.job.name == "mechanic" then
                TriggerEvent('qb-bossmenu:server:removeAccountMoney', Player.PlayerData.job.name, repairCost)
            else
                Player.Functions.RemoveMoney(moneyType, repairCost, "bennys")
            end
            TriggerClientEvent('rl-customs:purchaseSuccessful', source)
        else
            TriggerClientEvent('rl-customs:purchaseFailed', source)
        end
    elseif type == "performance" then
        if balance >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('rl-customs:purchaseSuccessful', source)
            if Player.PlayerData.job.name == "mechanic" then
                TriggerEvent('qb-bossmenu:server:removeAccountMoney', Player.PlayerData.job.name,
                    vehicleCustomisationPrices[type].prices[upgradeLevel])
            else
                Player.Functions.RemoveMoney(moneyType, vehicleCustomisationPrices[type].prices[upgradeLevel], "bennys")
            end
        else
            TriggerClientEvent('rl-customs:purchaseFailed', source)
        end
    else
        if balance >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('rl-customs:purchaseSuccessful', source)
            if Player.PlayerData.job.name == "mechanic" then
                TriggerEvent('qb-bossmenu:server:removeAccountMoney', Player.PlayerData.job.name,
                    vehicleCustomisationPrices[type].price)
            else
                Player.Functions.RemoveMoney(moneyType, vehicleCustomisationPrices[type].price, "bennys")
            end
        else
            TriggerClientEvent('rl-customs:purchaseFailed', source)
        end
    end
end)

RegisterNetEvent('rl-customs:updateRepairCost', function(cost)
    repairCost = cost
end)

RegisterNetEvent("updateVehicle", function(myCar)
    local src = source
    if IsVehicleOwned(myCar.plate) then
        RLCore.Functions.ExecuteSql('UPDATE player_vehicles SET mods = ? WHERE plate = ?', { json.encode(myCar), myCar.plate })
    end
end)

function IsVehicleOwned(plate)
    local retval = false

    RLCore.Functions.ExecuteSql(false, "SELECT plate FROM `player_vehicles` WHERE `plate` LIKE '%".. plate .."%'", function(result)
        if result then
            retval = true
        end
    end)
    return retval
end
