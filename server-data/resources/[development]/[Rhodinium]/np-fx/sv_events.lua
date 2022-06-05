RegisterServerEvent("fx:ThermiteChargeEnt")
AddEventHandler("fx:ThermiteChargeEnt", function(pNetId)
    local pEntity = NetworkGetEntityFromNetworkId(pNetId)
    local pCoords = GetEntityCoords(pEntity)
    local players = GetNearbyPlayers(pCoords, 45)
    local ptDict, ptName = "core","veh_respray_smoke"
    local position = {
        coords = { { x = pCoords.x, y = pCoords.y, z = pCoords.z } },
        rot = { x = 0.0, y = 0.0, z = 0.0 },
        scale = 1.0,
        alpha = 1.0,
    }
    TriggerParticleAtCoord(ptDict, ptName, true, position, 7000, players)
end)

RegisterServerEvent("fx:puke")
AddEventHandler("fx:puke", function(pTarget)
    if pTarget then
        TriggerClientEvent("fx:run", pTarget)
    else
        local src = source
        TriggerClientEvent("fx:run", src)
    end
end)

RegisterServerEvent("fx:money:start")
AddEventHandler("fx:money:stop", RegisterParticleToggle)

RegisterServerEvent("fx:poo:start")
AddEventHandler("fx:poo:start", RegisterParticleToggle)

RegisterServerEvent("fx:pee:start")
AddEventHandler("fx:pee:start", RegisterParticleToggle)

RegisterServerEvent("fx:money:stop")
AddEventHandler("fx:money:stop", StopParticleToggle)

RegisterServerEvent("fx:poo:stop")
AddEventHandler("fx:poo:stop", StopParticleToggle)

RegisterServerEvent("fx:pee:stop")
AddEventHandler("fx:pee:stop", StopParticleToggle)

RegisterServerEvent("np-fx:setSteamId")
AddEventHandler("np-fx:setSteamId", function()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local steamId = user:getVar("steamid")
    TriggerClientEvent("np-fix:setSteamIdClient", src, steamId)
end)

RegisterServerEvent("np-fx:smoke:grenade")
AddEventHandler("np-fx:smoke:grenade", function(pCoords)
    local players = GetNearbyPlayers(pCoords, 100)
    local ptDict, ptName = "core", "exp_grd_grenade_smoke"
    local position = {
        coords = { { x = pCoords.x, y = pCoords.y, z = pCoords.z } },
        rot = { x = 0.0, y = 0.0, z = 0.0 },
        scale = 1.0,
        alpha = 10.0,
    }
    TriggerParticleAtCoord(ptDict, ptName, true, position, 15000, players)
    position.coords[1].z = position.coords[1].z + 1.0
    Wait(1000)
    TriggerParticleAtCoord(ptDict, ptName, true, position, 15000, players)
end)    

RegisterNetEvent("np-fx:chain:blingDiamonds", function(pCoords, pType, pSize, pStrength, pScale)
    local serverId = source
    local players = GetNearbyPlayers(pCoords, 25)
    local ptDict, ptName = "", ""

    if pType == "diamonds" then
        ptDict, ptName = "src_bike_adversary", "scr_adversary_weap_glow"
    end
    if pType == "ruby" then
        ptDict, ptName = "src_bike_adversary", "scr_adversary_foot_flames"
    end
    if pType == "tanzanite" then
        ptDict, ptName = "src_bike_adversary", "scr_adversary_gunsmith_weap_change"
    end

    local scale = (math.min(0.5, math.max(0.1, 0.025 * pSize))) * (pScale or 1.0)
    local alpha = 1.0 + (pStrength / 10)
    local position = {
        offset = {x = -0.04, y = 0.17, z = -0.1},
        rot = {x = -366.0, y = 19.0, z = -163.0},
        scale = scale,
        alpha = alpha,
    }
    TriggerParticleOnPlayer(ptDict, ptName, true, serverId, 10706, position, 2000, players)
end) 