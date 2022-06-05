local ActiveParticles = {}
local BlacklistedParticles = {}

TriggerServerEvent("particles:player:ready")

function LoadParticleDictionary(dictionary)
    if not HasNamedPtfxAssetLoaded(dictionary) then
        RequestNamedPtfxAsset(dictionary)
        while not HasNamedPtfxAssetLoaded(dictionary) do
            Citizen.Wait(0)
        end
    end
end

function AddBlacklistedParticle(pDict, pName)
    BlacklistedParticles[('%s@%s'):format(pDict, pName)] = true
end

exports('AddBlacklistedParticle', AddBlacklistedParticle)

function RemoveBlacklistedParticle(pDict, pName)
    BlacklistedParticles[('%s@%s'):format(pDict, pName)] = nil
end

exports('RemoveBlacklistedParticle', RemoveBlacklistedParticle)

function IsParticleBlacklisted(pDict, pName)
    return BlacklistedParticles[('%s@%s'):format(pDict, pName)]
end

exports('IsParticleBlacklisted', IsParticleBlacklisted)

function StartParticleAtCoord(ptDict, ptName, looped, coords, rot, scale, alpha, color, duration)
    LoadParticleDictionary(ptDict)

    UseParticleFxAssetNextCall(ptDict)
    SetPtfxAssetNextCall(ptDict)

    local particleHandle

    if looped then
        particleHandle = StartParticleFxLoopedAtCoord(ptName, coords.x, coords.y, coords.z, rot.x, rot.y, rot.z, scale or 1.0)

        if color then
            SetParticleFxLoopedColour(particleHandle, color.r, color.g, color.b, false)
        end

        SetParticleFxLoopedAlpha(particleHandle, alpha or 10.0)

        if duration then
            Citizen.Wait(duration)
            StopParticleFxLooped(particleHandle, 0)
        end
    else
        SetParticleFxNonLoopedAlpha(alpha or 10.0)

        if color then
            SetParticleFxNonLoopedColour(color.r, color.g, color.b)
        end

        StartParticleFxNonLoopedAtCoord(ptName, coords.x, coords.y, coords.z, rot.x, rot.y, rot.z, scale or 1.0)
    end

    return particleHandle
end

function StartParticleOnEntity(ptDict, ptName, looped, entity, bone, offset, rot, scale, alpha, color, evolution, duration)
    LoadParticleDictionary(ptDict)

    UseParticleFxAssetNextCall(ptDict)

    local particleHandle, boneID

    if bone and GetEntityType(entity) == 1 then
        boneID = GetPedBoneIndex(entity, bone)
    elseif bone then
        boneID = GetEntityBoneIndexByName(entity, bone)
    end

    if looped then
        if bone then
            particleHandle = StartParticleFxLoopedOnEntityBone(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, boneID, scale)
        else
            particleHandle = StartParticleFxLoopedOnEntity(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, scale)
        end

        if evolution then
            SetParticleFxLoopedEvolution(particleHandle, evolution.name, evolution.amount, false)
        end

        if color then
            SetParticleFxLoopedColour(particleHandle, color.r, color.g, color.b, false)
        end

        SetParticleFxLoopedAlpha(particleHandle, alpha)

        if duration then
            Citizen.Wait(duration)
            StopParticleFxLooped(particleHandle, 0)
        end
    else
        SetParticleFxNonLoopedAlpha(alpha or 10.0)

        if color then
            SetParticleFxNonLoopedColour(color.r, color.g, color.b)
        end

        if bone then
            StartParticleFxNonLoopedOnPedBone(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, boneID, scale)
        else
            StartParticleFxNonLoopedOnEntity(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, scale)
        end
    end

    return particleHandle
end

RegisterNetEvent("particle:sync:coord")
AddEventHandler("particle:sync:coord", function(ptDict, ptName, looped, position, duration, ptID)
    if type(position.coords) == "table" then
        local particles = {}

        if IsParticleBlacklisted(ptDict, ptName) then return end

        for _, coords in ipairs(position.coords) do
            local particle = promise:new()

            Citizen.CreateThread(function()
                local particleHandle = StartParticleAtCoord(ptDict, ptName, looped, coords, position.rot, position.scale, position.alpha, position.color, duration)
                particle:resolve(particleHandle)
            end)

            particles[#particles + 1] = particle
        end

        if not duration and ptID then
            ActiveParticles[ptID] = particles
        end
    else
        local particleHandle = StartParticleAtCoord(ptDict, ptName, looped, position.coords, position.rot, position.scale, position.alpha, position.color, duration)

        if not duration and ptID then
            ActiveParticles[ptID] = particleHandle
        end
    end
end)

RegisterNetEvent("particle:explosion:coord")
AddEventHandler("particle:explosion:coord", function(position)
  -- local i = 0
  -- local try = {
  --   -- [6] = true,
  --   -- [9] = true,
  --   -- [15] = true,
  --   [29] = true,
  --   [37] = true,
  -- --   [49] = true,
  -- --   [50] = true,
  -- --   [59] = true,
  -- --   [60] = true,
  -- }
  -- while i < 100 do
  --   if try[i] == true then
  --     AddExplosion(position, i, 5.0, 1, 0, 1)
  --     print(i)
  --     Wait(2500)
  --   end
  --   i = i + 1
  -- end
  AddExplosion(position, 29, 5.0, 1, 0, 1, 1)
  Wait(500)
  StopFireInRange(position, 5.0)
end)

RegisterNetEvent("particle:sync:entity")
AddEventHandler("particle:sync:entity", function(ptDict, ptName, looped, target, bone, position, duration, ptID)
    local entity = NetworkGetEntityFromNetworkId(target)

    if IsParticleBlacklisted(ptDict, ptName) then return end

    if type(bone) == "table" then
        local particles = {}

        for _, boneName in ipairs(bone) do
            local particle = promise:new()

            Citizen.CreateThread(function()
                local particleHandle = StartParticleOnEntity(ptDict, ptName, looped, entity, boneName, position.offset, position.rot, position.scale, position.alpha, position.color, position.evolution, duration)
                particle:resolve(particleHandle)
            end)

            particles[#particles + 1] = particle
        end

        if not duration and ptID then
            ActiveParticles[ptID] = particles
        end
    else
        local particleHandle = StartParticleOnEntity(ptDict, ptName, looped, entity, bone, position.offset, position.rot, position.scale, position.alpha, position.color, position.evolution, duration)

        if not duration and ptID then
            ActiveParticles[ptID] = particleHandle
        end
    end
end)

RegisterNetEvent("particle:sync:player")
AddEventHandler("particle:sync:player", function(ptDict, ptName, looped, target, bone, position, duration, ptID)
    local entity = GetPlayerPed(GetPlayerFromServerId(target))

    if IsParticleBlacklisted(ptDict, ptName) then return end

    if type(bone) == "table" then
        local particles = {}

        for _, boneName in ipairs(bone) do
            local particle = promise:new()

            Citizen.CreateThread(function()
                local particleHandle = StartParticleOnEntity(ptDict, ptName, looped, entity, boneName, position.offset, position.rot, position.scale, position.alpha, position.color, position.evolution, duration)
                particle:resolve(particleHandle)
            end)

            particles[#particles + 1] = particle
        end

        if not duration and ptID then
            ActiveParticles[ptID] = particles
        end
    else
        local particleHandle = StartParticleOnEntity(ptDict, ptName, looped, entity, bone, position.offset, position.rot, position.scale, position.alpha, position.color, position.evolution, duration)

        if not duration and ptID then
            ActiveParticles[ptID] = particleHandle
        end
    end
end)

RegisterNetEvent("particle:sync:toggle:stop")
AddEventHandler("particle:sync:toggle:stop", function(ptID)
    if ActiveParticles[ptID] then
        if type(ActiveParticles[ptID]) == "table" then
            for _, particleHandle in ipairs(ActiveParticles[ptID]) do
                StopParticleFxLooped(Citizen.Await(particleHandle), 0)
            end
        else
            StopParticleFxLooped(ActiveParticles[ptID], 0)
        end
        ActiveParticles[ptID] = nil
    end
end)

-- Useful for local particles
exports("StartParticleAtCoord", StartParticleAtCoord)
exports("StartParticleOnEntity", StartParticleOnEntity)

AddEventHandler("drawPortal", function(pCoords)
  local coords = vector3(pCoords.x, pCoords.y, pCoords.z)
  local radius = 1.5
  Citizen.CreateThread(function()
    while true do
      DrawMarker(
        28,
        coords.x,
        coords.y,
        coords.z + (radius / 2) + 0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        radius,
        radius,
        radius,
        0, -- r
        0, -- g
        0, -- b
        100, -- a
        false,
        false,
        2,
        nil,
        nil,
        false
      )
      Citizen.Wait(0)
    end
  end)
  Citizen.CreateThread(function()
    local portalCoords = { x = pCoords.x, y = pCoords.y, z = pCoords.z + (radius / 2) + 0.0 }
    local scale = 0.335
    local x1, y1, z1 = 0.0, 0.0, 0.0
    local x2, y2, z2 = 180.0, 90.0, 270.0
    local x3, y3, z3 = 90.0, 270.0, 180.0
    while true do
      StartParticleAtCoord(
        "veh_xs_vehicle_mods",
        "exp_xs_mine_emp",
        true,
        portalCoords,
        { x = x1, y = y1, z = z1 },
        scale,
        10.0,
        nil,
        0
      )
      x1 = x1 + 1.0 + 0.0
      y1 = y1 + 1.0 + 0.0
      z1 = z1 + 1.0 + 0.0
      StartParticleAtCoord(
        "veh_xs_vehicle_mods",
        "exp_xs_mine_emp",
        true,
        portalCoords,
        { x = x2, y = y2, z = z2 },
        scale,
        10.0,
        nil,
        0
      )
      x2 = x2 + 1.0 + 0.0
      y2 = y2 + 1.0 + 0.0
      z2 = z2 + 1.0 + 0.0
      StartParticleAtCoord(
        "veh_xs_vehicle_mods",
        "exp_xs_mine_emp",
        true,
        portalCoords,
        { x = x3, y = y3, z = z3 },
        scale,
        10.0,
        nil,
        0
      )
      x3 = x3 + 1.0 + 0.0
      y3 = y3 + 1.0 + 0.0
      z3 = z3 + 1.0 + 0.0
      Citizen.Wait(0)
    end
  end)
end)

-- Citizen.CreateThread(function()
--   Citizen.Wait(1000)
--   TriggerEvent("drawPortal", { x = -75.98, y = -818.76, z = 326.18 })
--   -- Citizen.CreateThread(function()
--   --   Citizen.Wait(5000)
--   --   PlaySoundFrontend(-1, "ON", "NOIR_FILTER_SOUNDS", true)
--   --   SetExtraTimecycleModifier("NG_filmnoir_BW01")
--   --   while true do
--   --     RegisterNoirScreenEffectThisFrame()
--   --     Wait(0)
--   --   end
--   -- end)
-- end)
