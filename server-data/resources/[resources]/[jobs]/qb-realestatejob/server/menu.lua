local RLCore = exports['rl-core']:GetCoreObject()

--Events

RegisterNetEvent('qb-realestate:server:changetier', function(tier, name, hasOwner)
    local src = source

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `houselocations` WHERE `name` = '"..name.."'", function(result)
        for k, v in pairs(result) do
            if v.owned == 1 then
                TriggerClientEvent('RLCore:Notify', src, "This house is owned by somebody. Tier cannot be changed")  
            else
                RLCore.Functions.ExecuteSql(false, "UPDATE `houselocations` SET `tier` = '"..tier.."' WHERE `name` = '"..name.."'")
                TriggerClientEvent('RLCore:Notify', src, "Tier updated to: " ..tier)
                TriggerEvent('qb-houses:server:updateTier')
            end
        end
    end)
end)

RegisterNetEvent('qb-realestate:server:changeprice', function(price, name, hasOwner)
    local src = source
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `houselocations` WHERE `name` = '"..name.."'", function(result)
        for k, v in pairs(result) do
            if v.owned == 1 then
                TriggerClientEvent('RLCore:Notify', src, "This house is already bought. Why would you change price?")
            else
                RLCore.Functions.ExecuteSql(false, "UPDATE `houselocations` SET `price` = '"..price.."' WHERE `name` = '"..name.."'")
                TriggerClientEvent('RLCore:Notify', src, "Price updated to: " ..price)
                TriggerEvent('qb-houses:server:updatePrice', price)
            end
        end
    end)
end)

-- Callbacks

RLCore.Functions.CreateCallback("qb-realestate:server:GetHouses", function(source, cb)
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `houselocations`", function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)