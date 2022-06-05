local ActiveParticles = {}

RegisterNetEvent("particles:player:ready")
AddEventHandler("particles:player:ready", function()
end)

function TriggerParticleOnEntity(ptDict, ptName, looped, target, bone, position, duration, ptID)
    for _, playerId in pairs(ptID) do
        TriggerClientEvent("particle:sync:entity", playerId, ptDict, ptName, looped, pDuration, ptID)
    end
end        

function TriggerParticleOnPlayer(ptDict, ptName, looped, target, bone, position, duration, ptID)
    for _, playerId in pairs(ptID) do
        TriggerClientEvent("particle:sync:player", playerId, ptDict, ptName, looped, target, bone, position, duration, ptID)
    end
end     

function TriggerParticleAtCoord(ptDict, ptName, looped, position, duration, ptID)
    for _, playerId in pairs(ptID) do
        TriggerClientEvent("particle:sync:coord", playerId, ptDict, ptName, looped, position, duration, ptID)
    end
end     

function RegisterParticleToggle(pServerId, ptID, players, timeout)
    ActiveParticles[ptID] = { players = players, id = ptID, owner = pServerId }

    Citizen.SetTimeout(timeout or 1000 * 90, function()
        StopParticleToggle(ptID)
    end)
end

function StopParticleToggle(ptID)
    if ActiveParticles[ptID] then
        for _, playerId in pairs(ActiveParticles[ptID]["players"]) do
            TriggerClientEvent("particle:sync:toggle:stop", playerId, ptID)
        end
        
        ActiveParticles[ptID] = nil
    end
end    

exports("TriggerParticleOnEntity", TriggerParticleOnEntity)
AddEventHandler("particle:sync:entity", TriggerParticleOnEntity)

exports("TriggerParticleOnPlayer", TriggerParticleOnPlayer)
AddEventHandler("particle:sync:bone", TriggerParticleOnPlayer)

exports("TriggerParticleAtCoord", TriggerParticleAtCoord)
AddEventHandler("particle:sync:coord", TriggerParticleAtCoord)

exports("RegisterParticleToggle", RegisterParticleToggle)
AddEventHandler("particle:sync:toggle:register", RegisterParticleToggle)

exports("StopParticleToggle", StopParticleToggle)
AddEventHandler("particle:sync:toggle:stop", StopParticleToggle)
