RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

-- Code

RegisterServerEvent('rl-taxi:server:NpcPay')
AddEventHandler('rl-taxi:server:NpcPay', function(Payment)
    local fooikansasah = math.random(1, 5)
    local r1, r2 = math.random(1, 5), math.random(1, 5)

    if fooikansasah == r1 or fooikansasah == r2 then
        Payment = Payment + math.random(5, 10)
    end

    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    Player.Functions.AddMoney('cash', Payment)
end)