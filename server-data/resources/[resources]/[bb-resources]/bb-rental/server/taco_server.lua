RLCore = nil

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent('rl-taco:server:start:black')
AddEventHandler('rl-taco:server:start:black', function()
    local src = source
    
    TriggerClientEvent('rl-taco:start:black:job', src)
end)

RegisterServerEvent('rl-taco:server:reward:money')
AddEventHandler('rl-taco:server:reward:money', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    
    Player.Functions.AddMoney("cash", Config.PaymentTaco, "taco-reward-money")
    TriggerClientEvent('RLCore:Notify', src, "Taco delivered! Go back to the taco shop for a new delivery")
end)

RLCore.Functions.CreateCallback('rl-tacos:server:GetConfig', function(source, cb)
    cb(Config)
end)

RegisterServerEvent('rl-tacos:server:get:stuff')
AddEventHandler('rl-tacos:server:get:stuff', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    
    if Player ~= nil then
        Player.Functions.AddItem("taco-box", 1)
        TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items['taco-box'], "add")
    end
end)

RLCore.Functions.CreateCallback('rl-taco:server:get:ingredient', function(source, cb)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)
    local lettuce = Ply.Functions.GetItemByName("lettuce")
    local meat = Ply.Functions.GetItemByName("meat")
    if lettuce ~= nil and meat ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RLCore.Functions.CreateCallback('rl-taco:server:get:tacobox', function(source, cb)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)
    local box = Ply.Functions.GetItemByName("taco-box")
    if box ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RLCore.Functions.CreateCallback('rl-taco:server:get:tacos', function(source, cb)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)
    local taco = Ply.Functions.GetItemByName('taco')
    if taco ~= nil then
        cb(true)
    else
        cb(false)
    end
end)