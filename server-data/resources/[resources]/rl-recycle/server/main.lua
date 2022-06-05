RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local ItemTable = {
    "metalscrap",
    "plastic",
    "copper",
    "iron",
    "aluminum",
    "steel",
    "glass",
}

RegisterServerEvent("rl-recycle:server:getItem")
AddEventHandler("rl-recycle:server:getItem", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    for i = 1, 1, 1 do
        local randItem = ItemTable[math.random(1, #ItemTable)]
        local amount = math.random(2,10)
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items[randItem], 'add')
        Citizen.Wait(500)
    end

    local Luck = math.random(1, 10)
    local Odd = math.random(1, 10)
    if Luck == Odd then
        local random = math.random(3, 10)
        Player.Functions.AddItem("rubber", random)
        TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["rubber"], 'add')
    end
end)