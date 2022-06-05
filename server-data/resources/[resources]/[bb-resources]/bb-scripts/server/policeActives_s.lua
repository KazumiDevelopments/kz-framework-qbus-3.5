
RegisterServerEvent('bb-policeActives:server:createNUI')
AddEventHandler('bb-policeActives:server:createNUI', function(draggable)
    local src = source
    local players = RLCore.Functions.GetPlayers()
    local draggable = draggable.draggable
    local CopsInfo = {}
    for k, v in pairs(players) do
        local player = RLCore.Functions.GetPlayer(v).PlayerData
        if player.job.name == "police" and GetDiscord(player.source) then
            local callsignal = player.metadata["callsign"] ~= nil and player.metadata["callsign"] or "None"
            table.insert(CopsInfo, {name = player.charinfo.firstname .. ' ' .. player.charinfo.lastname, callsign = callsignal, onduty = player.job.onduty, grade = player.job.grade.name})
        end
    end
    TriggerClientEvent('bb-policeActives:client:createNUI', src, CopsInfo, draggable)
end)

RegisterServerEvent('bb-policeActives:server:updateOfficers')
AddEventHandler('bb-policeActives:server:updateOfficers', function()
    local players = RLCore.Functions.GetPlayers()
    local CopsInfo = {}
    for k, v in pairs(players) do
        local player = RLCore.Functions.GetPlayer(v).PlayerData
        if player.job.name == "police" and GetDiscord(player.source) then
            local callsignal = player.metadata["callsign"] ~= nil and player.metadata["callsign"] or "None"
            table.insert(CopsInfo, {name = player.charinfo.firstname .. ' ' .. player.charinfo.lastname, callsign = callsignal, onduty = player.job.onduty, grade = player.job.grade.name})
        end
    end

    TriggerEvent("bb-blips:server:updateBlips")
    TriggerClientEvent('bb-policeActives:client:updateOfficers', -1, CopsInfo)
end)

RLCore.Commands.Add('plist', 'Check the active officers', {{name = '1 - Draggable | 2 - Enable/Disable Permanent'}}, false, function(source, args)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    
    if xPlayer.PlayerData.job.name == "police" then
        local draggable = tonumber(args[1]) ~= nil and tonumber(args[1]) or 0

        local src = source
        local players = RLCore.Functions.GetPlayers()
        local CopsInfo = {}
        for k, v in pairs(players) do
            local player = RLCore.Functions.GetPlayer(v).PlayerData
            if player.job.name == "police" and GetDiscord(player.source) then
                local callsignal = player.metadata["callsign"] ~= nil and player.metadata["callsign"] or "None"
                table.insert(CopsInfo, {name = player.charinfo.firstname .. ' ' .. player.charinfo.lastname, callsign = callsignal, onduty = player.job.onduty, grade = player.job.grade.name})
            end
        end
        TriggerClientEvent('bb-policeActives:client:createNUI', src, CopsInfo, draggable)
        TriggerEvent('bb-logs:server:createLog', 'emergency', 'Command "plist"', "Used the command **plist** type " .. tostring(draggable), src)
    end
end)

function GetDiscord(src)
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if v == 'discord:519927907166978048' then
            --return false
        end
    end
    return true
end