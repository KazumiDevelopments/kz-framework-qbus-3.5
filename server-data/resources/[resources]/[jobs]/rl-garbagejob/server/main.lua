RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local Bail = {}

RLCore.Functions.CreateCallback('rl-garbagejob:server:HasMoney', function(source, cb)
    local Player = RLCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid

    if Player.PlayerData.money.cash >= Config.BailPrice then
        Bail[CitizenId] = "cash"
        Player.Functions.RemoveMoney('cash', Config.BailPrice)
        cb(true)
    elseif Player.PlayerData.money.bank >= Config.BailPrice then
        Bail[CitizenId] = "bank"
        Player.Functions.RemoveMoney('bank', Config.BailPrice)
        cb(true)
    else
        cb(false)
    end
end)

RLCore.Functions.CreateCallback('rl-garbagejob:server:CheckBail', function(source, cb)
    local Player = RLCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid

    if Bail[CitizenId] ~= nil then
        Player.Functions.AddMoney(Bail[CitizenId], Config.BailPrice, 'rl-garbagejob:server:CheckBail')
        Bail[CitizenId] = nil
        cb(true)
    else
        cb(false)
    end
end)

local Materials = {
    "metalscrap",
    "plastic",
    "copper",
    "iron",
    "aluminum",
    "steel",
    "glass",
}

local canGetPaid = {}
RegisterServerEvent('bb-scripts:locationChange:a')
AddEventHandler('bb-scripts:locationChange:a', function()
    canGetPaid[source] = true
end)

RegisterServerEvent('rl-garbagejob:server:Pay')
AddEventHandler('rl-garbagejob:server:Pay', function(amount, location)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    if amount > 0 then
        Player.Functions.AddMoney('cash', amount)
        if location == #Config.Locations["vuilnisbakken"] then
            for i = 1, math.random(3, 5), 1 do
                local item = Materials[math.random(1, #Materials)]
                Player.Functions.AddItem(item, math.random(40, 70))
                TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items[item], 'add')
                Citizen.Wait(500)
            end
        end
        TriggerClientEvent('RLCore:Notify', src, "You recieved $"..amount.."", "success")
    else
        TriggerClientEvent('RLCore:Notify', src, "You haven't earned anything..", "error")
    end
end)