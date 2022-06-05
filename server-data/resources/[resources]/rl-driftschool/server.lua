RLCore = nil

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent('rl-driftschool:takemoney')
AddEventHandler('rl-driftschool:takemoney', function(money)
    local source = source
    local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.money.cash >= money then
        Player.Functions.RemoveMoney('cash', money)
        TriggerClientEvent('rl-driftschool:tookmoney', source, true)
    else
        TriggerClientEvent('RLCore:Notify', source, "Not enough money", "error")
    end
end)