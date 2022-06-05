local modifiedWeapons = {
  ["weapon_bat"] = 0.4,
  ["weapon_knife"] = 0.5,
  ["weapon_flashlight"] = 0.4,
  ["weapon_nightstick"] = 0.4,
  -- ["weapon_dagger"] = 0.3,
  -- ["weapon_bottle"] = 0.3,
  -- ["weapon_crowbar"] = 0.3,
  -- ["weapon_unarmed"] = 0.3,
  -- ["weapon_golfclub"] = 0.3,
  -- ["weapon_hammer"] = 0.3,
  -- ["weapon_hatchet"] = 0.3,
  -- ["weapon_knuckle"] = 0.3,
  -- ["weapon_machete"] = 0.3,
  -- ["weapon_switchblade"] = 0.3,
  -- ["weapon_wrench"] = 0.3,
  -- ["weapon_battleaxe"] = 0.3,
  -- ["weapon_poolcue"] = 0.3,
  -- ["weapon_stone_hatchet"] = 0.3,
}

local meleeEffects = {
  ["weapon_bat"] = "knockdown",
  ["weapon_unarmed"] = "knockdownlowhp",
  ["weapon_brick"] = "knockdown",
  ["weapon_shoe"] = "knockdownlowhp",
  ["weapon_book"] = "knockdownlowhp",
}

local CrashHash = -1553120962
local FallHash = -842959696
local RamHash = 133987706
local GrenadeHash = -1813897027
local cashHash = 571920712
local RecentlyRiding = false

CreateThread(function()
  for weapon, modifier in pairs(modifiedWeapons) do
    local hash = GetHashKey(weapon)
    SetWeaponDamageModifier(hash, modifier)
  end

  while true do
    Wait(5000)
    
    SetWeaponDamageModifier(-1813897027 --[[ Hash ]], 0.001)
    SetWeaponDamageModifier(CrashHash --[[ Hash ]], 0.01)
    SetWeaponDamageModifier(RamHash --[[ Hash ]], 0.01)

    local ped = PlayerPedId()
    local model = GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))

    RecentlyRiding = ( (IsThisModelABike(model) or IsThisModelAQuadbike(model) or IsThisModelABicycle(model)) and not (RecentlyRiding and IsEntityInAir(ped) and IsPedRagdoll(ped) and IsPedFalling(ped)))

    if RecentlyRiding then
      local BikeArmor = exports["np-inventory"]:hasEnoughOfItem("bikearmor", 1, false,true)
      if BikeArmor then
        SetWeaponDamageModifier(FallHash --[[ Hash ]], 0.01)
      else
        SetWeaponDamageModifier(FallHash --[[ Hash ]], 1.0)
      end
    end

  end

end)
-- WEAPON_RUN_OVER_BY_CAR  -1553120962
 
--133987706



function DoFlashBang()
    StartScreenEffect("Dont_tazeme_bro", 0, true)
    TriggerEvent('InteractSound_CL:PlayOnOne','flashbang', 0.05)
    ShakeGameplayCam("HAND_SHAKE",2.0)
    SetRunSprintMultiplierForPlayer(PlayerId(), 0.5)
    Wait(12500)
    ShakeGameplayCam("HAND_SHAKE",0.0)    
    StopScreenEffect("Dont_tazeme_bro")
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.00)
    StopGameplayCamShaking() 
end

function ProcessHitByCash(pAttacker)
  TriggerServerEvent("np-weapons:attackedByCash", pAttacker)
end
local DegApplied = false
AddEventHandler("DamageEvents:EntityDamaged", function(victim, attacker, pWeapon, isMelee)
  local playerPed = PlayerPedId()
  -- print(pWeapon)
  if victim ~= playerPed then
    return
  end
  -- print(pWeapon)
  if ( (pWeapon == CrashHash or pWeapon == RamHash or pWeapon == FallHash) and exports["np-inventory"]:hasEnoughOfItem("bikearmor", 1, false, true) and not DegApplied and RecentlyRiding) then
    DegApplied = true
    TriggerEvent("inventory:DegenItemType",10,"bikearmor")
    Wait(3000)
    DegApplied = false
    return
  end

  if pWeapon == GrenadeHash then
    DoFlashBang()
    return
  end

  if pWeapon == cashHash then
    ProcessHitByCash(GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker)))
    return
  end

  for weapon, effect in pairs(meleeEffects) do
    local hash = GetHashKey(weapon)

    if pWeapon == hash and effect == "knockdown" then
      local health = GetEntityHealth(PlayerPedId())
      local time = map_range(health, 0.0, 200.0, 3000, 0)
      PerformEffect(effect, ped, time)
      break
    end

    if pWeapon == hash and effect == "knockdownlowhp" then
      local health = GetEntityHealth(PlayerPedId())
      local time = map_range(health, 0.0, 150.0, 500, 0)
      PerformEffect("knockdown", ped, time)
      break
    end
  end
end)

local IsKnockedDown = false
function PerformEffect(effect, ped, time)
  local ped = PlayerPedId()
  if effect == "knockdown" then
    if time <= 0.0 then
      return
    end

    if not IsKnockedDown then
      IsKnockedDown = true

      Citizen.CreateThread(function()
        while IsKnockedDown do
          SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
          Citizen.Wait(50)
        end
      end)

      Citizen.Wait(time)

      IsKnockedDown = false
    end
  end
end

function map_range(s, a1, a2, b1, b2)
  return b1 + (s - a1) * (b2 - b1) / (a2 - a1)
end
