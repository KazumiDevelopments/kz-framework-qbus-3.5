RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent("nevo:ready")
AddEventHandler("nevo:ready", function()
    RLCore.Commands.Add("dev", "Toggle debug mode", {}, false, function(source, args)
        TriggerClientEvent('debug:toggle', source)
    end, 'god')
end)

RegisterServerEvent('RLCore:Server:OnPlayerLoaded')
AddEventHandler('RLCore:Server:OnPlayerLoaded', function()
    local src = source
    TriggerClientEvent('debug', -1, 'RLCore: ' .. GetPlayerName(source) .. ' (' .. source .. ') Loaded!', 'normal')
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    TriggerClientEvent('debug', -1, 'RLCore: ' .. GetPlayerName(src) .. ' (' .. src .. ') Dropped! (' .. reason .. ')', 'normal')
end)