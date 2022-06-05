RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
local VehicleNitrous = {}

RegisterServerEvent('tackle:server:TacklePlayer')
AddEventHandler('tackle:server:TacklePlayer', function(playerId)
    TriggerClientEvent("tackle:client:GetTackled", playerId)
end)

RLCore.Functions.CreateCallback('nos:GetNosLoadedVehs', function(source, cb)
    cb(VehicleNitrous)
end)

RLCore.Functions.CreateUseableItem("harness", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent('seatbelt:client:UseHarness', source, item)
end)

RegisterServerEvent('equip:harness')
AddEventHandler('equip:harness', function(item)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if Player.PlayerData.items[item.slot].info.uses - 1 == 0 then
        TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['harness'], "remove")
        Player.Functions.RemoveItem('harness', 1)
    else
        Player.PlayerData.items[item.slot].info.uses = Player.PlayerData.items[item.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterServerEvent('seatbelt:DoHarnessDamage')
AddEventHandler('seatbelt:DoHarnessDamage', function(hp, data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    if hp == 0 then
        Player.Functions.RemoveItem('harness', 1, data.slot)
    else
        Player.PlayerData.items[data.slot].info.uses = Player.PlayerData.items[data.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

Citizen.CreateThread(function()
    while true do
        local playersInfo = {}
        for k, v in pairs(GetPlayers()) do
            if v ~= nil then
                local identifier = GetPlayerIdentifier(v)
                local serverid = RLCore.Functions.GetSource(identifier)
                table.insert(playersInfo, serverid)
            end
        end

        print('^2[DiscordRich]^7 Updated server players. (' .. #playersInfo .. ')')
        TriggerClientEvent('rl-core:client:updatePlayers', -1, playersInfo)
        Wait(35000)
    end
end)

RegisterServerEvent("carhud:ejection:server")
AddEventHandler("carhud:ejection:server", function(plate)
    TriggerClientEvent("carhud:ejection:client", -1, plate)
end)