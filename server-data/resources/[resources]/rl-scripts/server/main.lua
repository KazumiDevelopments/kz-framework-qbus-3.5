RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent('CrashTackle')
AddEventHandler('CrashTackle', function(target)
	TriggerClientEvent("playerTackled", target)
end)

RLCore.Functions.CreateUseableItem("harness", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent('seatbelt:client:UseHarness', source, item)
end)

RLCore.Functions.CreateUseableItem("harness", function(source, item)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent('seatbelt:client:UseHarness', src, item)
end)

RegisterNetEvent('equip:harness', function(item)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if Player.PlayerData.items[item.slot].info.uses == 1 then
        TriggerClientEvent("inventory:client:ItemBox", src, RLCore.Shared.Items['harness'], "remove")
        Player.Functions.RemoveItem('harness', 1)
    else
        Player.PlayerData.items[item.slot].info.uses = Player.PlayerData.items[item.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterNetEvent('seatbelt:DoHarnessDamage', function(hp, data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    if hp == 0 then
        Player.Functions.RemoveItem('harness', 1, data.slot)
    else
        Player.PlayerData.items[data.slot].info.uses = Player.PlayerData.items[data.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)