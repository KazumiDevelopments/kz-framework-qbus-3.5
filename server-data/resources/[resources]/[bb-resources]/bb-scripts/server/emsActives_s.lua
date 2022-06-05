
RegisterServerEvent('bb-emsActives:server:createNUI')
AddEventHandler('bb-emsActives:server:createNUI', function(draggable)
    local src = source
    local players = RLCore.Functions.GetPlayers()
    local draggable = draggable.draggable
    local CopsInfo = {}
    for k, v in pairs(players) do
        local player = RLCore.Functions.GetPlayer(v).PlayerData
        if player.job.name == "ambulance" then
            local callsignal = player.metadata["callsign"] ~= nil and player.metadata["callsign"] or "None"
            table.insert(CopsInfo, {name = player.charinfo.firstname .. ' ' .. player.charinfo.lastname, callsign = callsignal, onduty = player.job.onduty, grade = player.job.grade.name})
        end
    end
    TriggerClientEvent('bb-emsActives:client:createNUI', src, CopsInfo, draggable)
end)

RegisterServerEvent('bb-emsActives:server:updateParamedics')
AddEventHandler('bb-emsActives:server:updateParamedics', function()
    local players = RLCore.Functions.GetPlayers()
    local CopsInfo = {}
    for k, v in pairs(players) do
        local player = RLCore.Functions.GetPlayer(v).PlayerData
        if player.job.name == "ambulance" then
            local callsignal = player.metadata["callsign"] ~= nil and player.metadata["callsign"] or "None"
            table.insert(CopsInfo, {name = player.charinfo.firstname .. ' ' .. player.charinfo.lastname, callsign = callsignal, onduty = player.job.onduty, grade = player.job.grade.name})
        end
    end

    TriggerClientEvent('bb-emsActives:client:updateParamedics', -1, CopsInfo)
end)

RLCore.Commands.Add('mlist', 'Check the active paramedics', {{name = '1 - Draggable | 2 - Enable/Disable Permanent'}}, false, function(source, args)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    
    if xPlayer.PlayerData.job.name == "ambulance" then
        local draggable = tonumber(args[1]) ~= nil and tonumber(args[1]) or 0

        local src = source
        local players = RLCore.Functions.GetPlayers()
        local CopsInfo = {}
        for k, v in pairs(players) do
            local player = RLCore.Functions.GetPlayer(v).PlayerData
            if player.job.name == "ambulance" then
                local callsignal = player.metadata["callsign"] ~= nil and player.metadata["callsign"] or "None"
                table.insert(CopsInfo, {name = player.charinfo.firstname .. ' ' .. player.charinfo.lastname, callsign = callsignal, onduty = player.job.onduty, grade = player.job.grade.name})
            end
        end
        TriggerClientEvent('bb-emsActives:client:createNUI', src, CopsInfo, draggable)
        TriggerEvent('bb-logs:server:createLog', GetCurrentResourceName(), 'Command "mlist"', "Used the command **mlist** type " .. tostring(draggable), src)
    end
end)