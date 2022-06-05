local chilled = false
local buffed = false
local staffEquipped = false
local manaTotal = 0
--setHudValue("manaShow", true)
--setHudValue("mana", 100)

--exports["np-ui"]:sendAppEvent("hud", {
--  true | false = currentValues["manaShow"], -- lmao
--  0 | 100 = currentValues["mana"],
--})
-- TriggerServerEvent("InteractSound_SV:PlayAudioAtPosition",position, 10.0, 'ArcaneEffect', 0.2)
-- TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'ArcaneLong', 0.2)
-- TriggerEvent('InteractSound_CL:PlayOnOne','ArcaneEffect', 0.2)

RegisterNetEvent("fx:spellcast")
AddEventHandler("fx:spellcast", function(Spell)
  if manaTotal > SpellList[Spell]["Base"]["Mana"] then
    staffEquipped = false
    manaTotal = manaTotal - SpellList[Spell]["Base"]["Mana"]
    exports["np-ui"]:sendAppEvent("hud", { mana = manaTotal })
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, '/Spells/' .. SpellList[Spell]["Base"]["SoundFile"], 0.4)
    SpellCast(Spell)
  else
    TriggerEvent('InteractSound_CL:PlayOnOne','/Spells/oom', 0.4)
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(500)
    if staffEquipped then
      SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 5)
      manaTotal = manaTotal + 1
      if manaTotal > 100 then
        manaTotal = 100
      end
      exports["np-ui"]:sendAppEvent("hud", { mana = manaTotal })
    else
      Wait(1500)
    end
  end
end)

function DoPoop()
  TriggerEvent("animation:PlayAnimation","shit")
  local timer = 1000
  while timer > 0 do
      DisableAllControlActions(0)
      DisableAllControlActions(1)
      Citizen.Wait(0)
      timer = timer - 1
  end
  TriggerEvent("animation:PlayAnimation","cancel") 
end

RegisterNetEvent("fx:spell:poop")
AddEventHandler("fx:spell:poop", function()
  TriggerEvent('InteractSound_CL:PlayOnOne','/Spells/FartNoise2', 0.1)
  DoPoop()
end)

RegisterNetEvent("fx:spellmana")
AddEventHandler("fx:spellmana", function()
  TriggerEvent('InteractSound_CL:PlayOnOne','/Spells/FairyEffect', 0.4)
  manaTotal = 100
  exports["np-ui"]:sendAppEvent("hud", { mana = manaTotal })
  TriggerServerEvent("fx:effect:start","buffed", GetRandomString(12))
  TriggerEvent('InteractSound_CL:PlayOnOne','/Spells/ArcaneEffect', 0.4)
end)

RegisterNetEvent("fx:staffused")
AddEventHandler("fx:staffused", function(equipped)
    staffEquipped = equipped
    TriggerEvent('InteractSound_CL:PlayOnOne','/Spells/FireEffect', 0.1)
    if equipped then
      SetPedArmour(PlayerPedId(),0)
    end
    exports["np-ui"]:sendAppEvent("hud", { manaShow = equipped })
    TriggerServerEvent("fx:effect:start","staffused", GetRandomString(12))
end)

RegisterNetEvent("fx:spell:effect")
AddEventHandler("fx:spell:effect", function(Spell)
    if not SpellList[Spell]["AreaEffect"]["Event"] then
      return
    end
    print("I was hit by spell : " .. SpellList[Spell]["AreaEffect"]["Event"])
    TriggerEvent(SpellList[Spell]["AreaEffect"]["Event"])
end)

RegisterNetEvent("fx:spell:buff")
AddEventHandler("fx:spell:buff", function()
  buffed = true
  TriggerServerEvent("fx:effect:start","buffed", GetRandomString(12))
  TriggerEvent('InteractSound_CL:PlayOnOne','/Spells/ArcaneEffect', 0.4)
end)

RegisterNetEvent("fx:spell:heal")
AddEventHandler("fx:spell:heal", function()
    SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 50)
    TriggerEvent('InteractSound_CL:PlayOnOne','/Spells/FairyEffect', 0.4)
    TextDraw("+50 Health")
    chilled = false
end)

RegisterNetEvent("fx:spell:slow")
AddEventHandler("fx:spell:slow", function()
    if buffed then 
      buffed = false
      return 
    end
    TriggerEvent('InteractSound_CL:PlayOnOne','/Spells/IceEffect', 0.4)
    local ped = PlayerPedId()
    TextDraw("You have been frozen!!")
    local timer = 500
    chilled = true
    FreezeEntityPosition(PlayerPedId(), true)
    SetPlayerInvincible(PlayerId(), true)

    TriggerServerEvent("fx:effect:start","slowed", GetRandomString(12))
    SetEntityHealth(ped, GetEntityHealth(ped) - 5)
    while timer > 0 and chilled do
        DisableControlAction(0, 21, true)
        Wait(1)
        timer = timer - 1
    end
    SetEntityHealth(ped, GetEntityHealth(ped) - 5)
    FreezeEntityPosition(PlayerPedId(), false)
    SetPlayerInvincible(PlayerId(), false)
    TextDraw("You are no longer frozen!")
end)

RegisterNetEvent("fx:teleport:location")
AddEventHandler("fx:teleport:location", function()
    SetEntityCoords(PlayerPedId(),GetTargetCoords())
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, '/Spells/ArcaneEffect', 0.4)
end)

RegisterNetEvent("fx:spell:shock")
AddEventHandler("fx:spell:shock", function()
    if buffed then 
      buffed = false
      return 
    end
    TriggerEvent('InteractSound_CL:PlayOnOne','/Spells/ArcaneEffect', 0.4)
    TriggerServerEvent("fx:effect:start","arcane", GetRandomString(12))
    local ped = PlayerPedId()
    TextDraw("You have been mini-stunned")
    SetPedToRagdoll(ped, 1000, 1000, 3, 0, 0, 0)
    SetEntityHealth(ped, GetEntityHealth(ped) - 33)
end)

RegisterNetEvent("fx:spell:speed")
AddEventHandler("fx:spell:speed", function()
    TextDraw("Wind Effect!!")
    TriggerEvent('InteractSound_CL:PlayOnOne','/Spells/FairyEffect', 0.2)
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    --SetPedConfigFlag(PlayerPedId(),223,true)
    TriggerServerEvent("fx:effect:start","speed", GetRandomString(12))
    Wait(10000)
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
  --  SetPedConfigFlag(PlayerPedId(),223,false)
    TextDraw("You are no longer fast!")
end)

function TextDraw(text)
    -- lazy, would be cool to make a hud thing with scrolling combat text
    TriggerEvent('chatMessage', 'Magic Effect: ', 1, text )
end

-- remove this shit later - replace with export..

function RayCast(origin, target, options, ignoreEntity, radius)
  local handle = StartShapeTestRay(origin.x, origin.y, origin.z, target.x, target.y, target.z, options, ignoreEntity, 0)
  return GetShapeTestResult(handle)
end

function GetForwardVector(rotation)
  local rot = (math.pi / 180.0) * rotation
  return vector3(-math.sin(rot.z) * math.abs(math.cos(rot.x)), math.cos(rot.z) * math.abs(math.cos(rot.x)), math.sin(rot.x))
end

function GetTargetCoords()
  local CameraCoords = GetGameplayCamCoord()
  local ForwardVectors = GetForwardVector(GetGameplayCamRot(2))
  local ForwardCoords = CameraCoords + (ForwardVectors * (IsInVehicle and 21.5 or 40.0))
  local TargetCoords = vector3(0.0, 0.0, 0.0)
  if ForwardVectors then
      local _, hit, targetCoords, _, _ = RayCast(CameraCoords, ForwardCoords, 17, nil, 0.1)
      TargetCoords = targetCoords
  end
  return TargetCoords
end

function SpellTargeting(dist,timer)
    local reply = false
    local timer = math.ceil(timer * 0.25)
    TriggerEvent("animation:PlayAnimation","mindcontrol2")
    while timer > 0 do
      timer = timer - 1
      Wait(0)
      local coords = GetTargetCoords()
      DrawMarker(27, coords.x, coords.y, coords.z + 0.10, 0, 0, 0, 0, 0, 0, dist, dist, dist, 0, 225, 165, 215, 1,1, 1,1)
    end
    if GetDistanceBetweenCoords(GetTargetCoords(),GetEntityCoords(PlayerPedId())) < 41.0 then
      reply = true
    end
    return reply
end

local casting = false
function SpellCast(SpellCast)

    if casting then return end
    casting = true
    -- mana check and use
    -- check if its a target use skill
    local table = SpellList[SpellCast]
    local base = table["Base"]

    SpellID = GetRandomString(12)
    StartID = GetRandomString(12) 
    TriggerServerEvent("fx:spell:start", SpellCast, SpellID, StartID)

    if base["Target"] and not base["ClientEffect"] then
      local success = SpellTargeting(base["Targetdist"],base["Casttime"])
      if success then
        local coords = OffsetCoords(table["AreaEffect"]["OffSets"].offset)
        TriggerServerEvent("fx:spell:target", coords, SpellCast, 1500)
      end
    elseif base["Target"] and base["ClientEffect"] then
      -- do client effect
      local success = SpellTargeting(base["Targetdist"],base["Casttime"])
      if success then
        TriggerEvent(base["ClientEffect"])
        local coords = OffsetCoords(table["AreaEffect"]["OffSets"].offset)
        TriggerServerEvent("fx:spell:target", coords, SpellCast, 1500)
      end

    end
    TriggerEvent("animation:PlayAnimation","Cancel")
    Wait(table["Base"]["GCD"])
    
    casting = false
end

function OffsetCoords(offset)
  local coords = GetTargetCoords()
  return vector3(coords.x + offset.x,coords.y + offset.y,coords.z + offset.z)
end

function SpellStop()
  if not IsPeePooWhitelist() then return end
  if SpellID == nil then return end
  TriggerEvent("animation:PlayAnimation","cancel")
  TriggerServerEvent("fx:spell:stop", SpellID)
  SpellID = nil
end