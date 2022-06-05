RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent('rl-carwash:server:washCar')
AddEventHandler('rl-carwash:server:washCar', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveMoney('cash', Config.DefaultPrice, "car-washed") then
        TriggerEvent('bb-bossmenu:server:addAccountMoney', 'dedeshop', Config.DefaultPrice)
        TriggerClientEvent('rl-carwash:client:washCar', src)
    elseif Player.Functions.RemoveMoney('bank', Config.DefaultPrice, "car-washed") then
        TriggerEvent('bb-bossmenu:server:addAccountMoney', 'dedeshop', Config.DefaultPrice)
        TriggerClientEvent('rl-carwash:client:washCar', src)
    else
        TriggerClientEvent('RLCore:Notify', src, 'Not enough money.', 'error')
    end
end)

RLCore.Functions.CreateUseableItem("cleaningkit", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("clean:kit", source)
end)