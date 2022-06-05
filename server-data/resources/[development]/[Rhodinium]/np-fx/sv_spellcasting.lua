local SpellList = {}

RegisterNetEvent("fx:spell:stop")
AddEventHandler("fx:spell:stop", StopParticleToggle)

RegisterNetEvent("fx:spell:start")
AddEventHandler("fx:spell:start", function(SpellCast, SpellID, StartID)
    local serverID = source or targetID
    local playerCoords = GetPlayerCoords(serverID)
    local players = GetNearbyPlayers(playerCoords, 50)
    local SpellBase = SpellList[SpellCast]["StartEffect"]
    local SpellBaseStart = SpellList[SpellCast]["StartEffect"]
    local position = SpellBaseStart["Offsets"]

    TriggerParticalOnPlayer(SpellBaseStart["Lib"], SpellBaseStart["Part"], true, serveID, SpellBaseStart["Bone"], position, nil, players, SpellID)
    RegisterParticalToggle(serverID, SpellID, players, 1000 * 3)
    Wait(2500)

    if SpellBase["Display"] then
        position = SpellBase["Offsets"]
        TriggerParticalOnPlayer(SpellBaseStart["Lib"], SpellBaseStart["Part"], true, serverID, SpellBaseStart["Bone"], position, nil, players, StartID)
        RegisterParticalToggle(serverID, StartID, players, 1000 * 3)
    end
end)

RegisterNetEvent("fx:spell:target")
AddEventHandler("fx:spell:target", function(pCoords, SpellCast)
    local SpellEffect = SpellList[SpellCast]["AreaEffect"]
    local players = GetNearbyPlayers(pCoords, 100)
    local playersEffected = GetNearbyPlayers(pCoords, SpellEffect["Targetdist"])
    local position = {
        coords = pCoords,
        rot = SpellEffect["Offsets"].rot,
        scale = SpellEffect["Offsets"].scale,   
        alpha = SpellEffect["Offsets"].alpha,   
    }

    TriggerParticalAtCoord(SpellEffect["Lib"], SpellEffect["Part"], true, position, 1500, players)
    
    for _, serverID in ipairs(playersEffected) do
        TriggerClientEvent("fx:spell:effect", serverID, SpellCast)
    end
end)