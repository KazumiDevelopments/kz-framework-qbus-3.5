RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent('rl-shops:server:UpdateShopItems')
AddEventHandler('rl-shops:server:UpdateShopItems', function(shop, itemData, amount)
    Config.Locations[shop]["products"][itemData.slot].amount =  Config.Locations[shop]["products"][itemData.slot].amount - amount
    if Config.Locations[shop]["products"][itemData.slot].amount <= 0 then 
        Config.Locations[shop]["products"][itemData.slot].amount = 0
    end
    TriggerClientEvent('rl-shops:client:SetShopItems', -1, shop, Config.Locations[shop]["products"])
end)

RegisterServerEvent('rl-shops:server:RestockShopItems')
AddEventHandler('rl-shops:server:RestockShopItems', function(shop)
    if Config.Locations[shop]["products"] ~= nil then 
        local randAmount = math.random(10, 50)
        for k, v in pairs(Config.Locations[shop]["products"]) do 
            Config.Locations[shop]["products"][k].amount = Config.Locations[shop]["products"][k].amount + randAmount
        end
        TriggerClientEvent('rl-shops:client:RestockShopItems', -1, shop, randAmount)
    end
end)

RegisterServerEvent('rl-shops:server:CheckGunLicence1')
AddEventHandler('rl-shops:server:CheckGunLicence1', function()
    local xPlayer = RLCore.Functions.GetPlayer(source)
    if xPlayer.PlayerData.metadata.licences['weapon1'] then
        TriggerClientEvent('rl-shops:client:callbackerino', source, true)
    else
        TriggerClientEvent('rl-shops:client:callbackerino', source, false)
    end
end)