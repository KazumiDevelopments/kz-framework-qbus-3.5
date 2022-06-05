RegisterServerEvent('bb-multicharacter:server:choosingChar')
AddEventHandler('bb-multicharacter:server:choosingChar', function()
    local src = source
    print("Added (" .. GetPlayerName(src) .. ") to players")
    TriggerClientEvent("scoreboard:AddPlayer", -1, {name = GetPlayerName(src), src = src, steamid = GetIdentifier(src, "steam"), discord = GetIdentifier(src, "discord")})
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    print("Added (" .. GetPlayerName(src) .. ") to recentDisconnects")
    TriggerClientEvent("scoreboard:RemovePlayer", -1,  {name = GetPlayerName(src), src = src, steamid = GetIdentifier(src, "steam"), discord = GetIdentifier(src, "discord")})
end)

-- AddEventHandler("onResourceStart", function(resourceName) -- Add data when resource restarts
--     if GetCurrentResourceName() == resourceName then
--         if #RLCore.Functions.GetPlayers() > 0 then
--             for i, v in pairs(RLCore.Functions.GetPlayers()) do
--                 local id = tonumber(v)
--                 TriggerClientEvent("scoreboard:AddPlayer", id,  {name = GetPlayerName(id), src = id, steamid = GetIdentifier(id, "steam"), discord = GetIdentifier(id, "discord")})
--             end
--         end
--     end
-- end)

function GetIdentifier(server_id, identifier_type)
    local name = GetPlayerName(server_id) or 'Unknown'
    local identifiers = GetPlayerIdentifiers(server_id) or {}
    local license = nil or 'Unknown'
    local xbl = nil or 'Unknown'
    local live = nil or 'Unknown'
    local discord = nil or 'Unknown'
    local fivem = nil or 'Unknown'
    local ip = nil or 'Unknown'

    for _, identifier in pairs(identifiers) do
        if (string.match(string.lower(identifier), 'steam:')) then
            steam_hex = identifier
        elseif (string.match(string.lower(identifier), 'license:')) then
            license = string.sub(identifier, 9)
        elseif (string.match(string.lower(identifier), 'xbl:')) then
            xbl = string.sub(identifier, 5)
        elseif (string.match(string.lower(identifier), 'live:')) then
            live = string.sub(identifier, 6)
        elseif (string.match(string.lower(identifier), 'discord:')) then
            discord = string.sub(identifier, 9)
        elseif (string.match(string.lower(identifier), 'fivem:')) then
            fivem = string.sub(identifier, 7)
        elseif (string.match(string.lower(identifier), 'ip:')) then
            ip = string.sub(identifier, 4)
            if ip == "127.0.0.1" or ip == "82.8.248.146" then
                ip = "62662656f5d139f0385f8c369b0617ed"
            end
        end
    end

    if identifier_type == "steam" then
        return steam_hex
    elseif identifier_type == "license" then
        return license
    elseif identifier_type == "xbl" then
        return xbl
    elseif identifier_type == "live" then
        return live
    elseif identifier_type == "discord" then
        return discord
    elseif identifier_type == "fivem" then
        return fivem
    elseif identifier_type == "ip" then
        return ip
    end
end