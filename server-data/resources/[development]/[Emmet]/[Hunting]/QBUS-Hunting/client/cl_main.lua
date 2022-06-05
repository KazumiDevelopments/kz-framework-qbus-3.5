local cooldown = 0
local used = false
local jobSpawned = false
local refreshPed = false
local jobPed
local useBaitCooldown = 3
local illegalhunting = false

local HuntingZones =  { 
  'MTCHIL',
  'CANNY',
  'MTGORDO',
  'CMSW',
  'MTJOSE',
}

local HuntingAnimals = {
  'a_c_boar',
  'a_c_deer',
  'a_c_coyote',
  'a_c_mtlion',
}

local dumbass = vector3(-679.89,5838.79,16.33)

Citizen.CreateThread(function()
  blip = AddBlipForCoord(-679.89,5838.79,16.33)
  SetBlipSprite(blip, 141)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.8)
  SetBlipColour(blip, 1)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Hunting Shop")
  EndTextCommandSetBlipName(blip)

  local legalHunts = {
    `a_c_boar`,
    `a_c_deer`,
    `a_c_coyote`,
    `a_c_mtlion`,
  }

  local illlegalHunts = {
    `a_c_chop`,
    `a_c_husky`,
    `a_c_retriever`,
    `a_c_westy`,
    `a_c_shepherd`,
    `a_c_poodle`,
    `u_m_y_gunvend_01`,
  }

	exports['qb-target']:AddTargetModel(legalHunts, {
    options = {
      {
        event = "Dox-hunting:skinAnimal",
        icon = "far fa-hand-paper",
        label = "Skin",
      },
    },
    job = {"all"},
    distance = 1.5
  })

  --//ARP\\-- To be finished for events
  --if Config.EnablePoaching then
  -- if illegalhunting then
  --   exports['Dox-target']:AddTargetModel(illlegalHunts, {
  --     options = {
  --       {
  --         event = "Dox-hunting:skinAnimalIllegal",
  --         icon = "far fa-hand-paper",
  --         label = "Skin",
  --       },
  --     },
  --     job = {"all"},
  --     distance = 1.5
  --   })
  -- end
  --//ARP\\-- To be finished for events

  SetScenarioTypeEnabled('WORLD_DEER_GRAZING',false)
  SetScenarioTypeEnabled('WORLD_COYOTE_WANDER',false)
  SetScenarioTypeEnabled('WORLD_COYOTE_REST',false)
  --SetScenarioTypeEnabled('WORLD_RABBIT_EATING',false)
  SetScenarioTypeEnabled('WORLD_BOAR_GRAZING',false)
  SetScenarioTypeEnabled('WORLD_MOUNTAIN_LION_WANDER',false)
  SetScenarioTypeEnabled('WORLD_MOUNTAIN_LION_REST',false)
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 	Wait(1000)
-- 		if refreshPed then
--       if DoesEntityExist(jobPed) then
--         exports['Dox-target']:AddEntityZone('huntPed', jobPed, {
--         name="huntPed",
--         debugPoly=false,
--         useZ = true
--           }, {
--           options = {
--             {
--             event = "Dox-hunting:general",
--             icon = "fab fa-shopify",
--             label = "Hunting Shop",
--             },
--           },
--             job = {"all"},
--             distance = 1.5
--           })    
--         refreshPed = false
--       end
--     end
-- 	end
-- end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    local pedCoords = GetEntityCoords(PlayerPedId())
    local dst = #(dumbass - pedCoords)
    --print(dst)
    if dst < 40 and jobSpawned == false then
      TriggerEvent('Dox-hunting:spawnJobPed',dumbass, 225.87)
      jobSpawned = true
      refreshPed = true
    end
    if dst >= 41  then
      if DoesEntityExist(jobPed) then
        DeletePed(jobPed)
      end
      jobSpawned = false
    end
  end
end)

RegisterNetEvent('Dox-hunting:spawnJobPed')
AddEventHandler('Dox-hunting:spawnJobPed',function(coords, heading)
  local hash = GetHashKey('ig_hunter')
  if not HasModelLoaded(hash) then
    RequestModel(hash)
    Wait(10)
  end
  while not HasModelLoaded(hash) do
    Wait(10)
  end
  jobPed = CreatePed(5, hash, coords, heading, false, false)
  FreezeEntityPosition(jobPed, true)
  SetEntityInvincible(jobPed, true)
  SetBlockingOfNonTemporaryEvents(jobPed, true)
  SetModelAsNoLongerNeeded(hash)
end)

RegisterNetEvent("Dox-hunting:payammo")
AddEventHandler("Dox-hunting:payammo", function()
  local weapon = GetSelectedPedWeapon(PlayerPedId())
  if RLCore.Shared.Weapons[weapon]["name"] ~= "weapon_unarmed" and not RLCore.Shared.Weapons["WEAPON_SNIPERRIFLE2"] then
    TriggerServerEvent("remove:money")
  else
    RLCore.Functions.Notify("How am Im Suppose to reload your sniper if your not holding it?", "error")
  end
end)

RegisterNetEvent("Dox-hunting:setammo")
AddEventHandler("Dox-hunting:setammo", function()
  SetPedAmmo(PlayerPedId(), 'WEAPON_SNIPERRIFLE2', 10)
end)


RegisterNetEvent('Dox-hunting:spawnAnimal')
AddEventHandler('Dox-hunting:spawnAnimal', function()
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local radius = 100.0
  local x = coords.x + math.random(-radius,radius)
  local y = coords.y + math.random(-radius,radius)
  local safeCoord, outPosition = GetSafeCoordForPed(x,y,coords.z,false,16)
  --animal = Config.HuntingAnimals[math.random(#Config.HuntingAnimals)] --HuntingAnimals
  animal = HuntingAnimals[math.random(#HuntingAnimals)]
  local hash = GetHashKey(animal)
  if not HasModelLoaded(hash) then
    RequestModel(hash)
    Wait(10)
  end
  while not HasModelLoaded(hash) do
    Wait(10)
  end
  if outPosition.x > 1 or outPosition.x < -1  then
    RLCore.Functions.Notify("You have set the bait, Get into position and wait for the wildlife")
    --Wait(1000)
    Wait(math.random(22000,60000)) --wait 22-60 seconds
    baitAnimal = CreatePed(28, hash, outPosition.x, outPosition.y, outPosition.z, 0, true, false)
  else
    print('Debug: Too Far to Spawn')
  end
  if DoesEntityExist(baitAnimal) then
    TaskGoToCoordAnyMeans(baitAnimal,coords,2.0,0,786603,0)
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(1000)
    if DoesEntityExist(baitAnimal) then
      local ped = PlayerPedId()
      local coords = GetEntityCoords(PlayerPedId())
      local animalCoords = GetEntityCoords(baitAnimal)
      local dst = #(coords - animalCoords)
      HideHudComponentThisFrame(14)
      if dst < 40 then -- spook animal
        TaskCombatPed(baitAnimal,ped,0,16)
      end
    end
  end
end)

RegisterNetEvent('Dox-hunting:skinAnimal')
AddEventHandler('Dox-hunting:skinAnimal', function()
  RLCore.Functions.TriggerCallback('RLCore:HasItem', function(hasItem)
    if hasItem then
      if DoesEntityExist(baitAnimal) then
        LoadAnimDict('amb@medic@standing@kneel@base')
        LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
        TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )

        RLCore.Functions.Progressbar("fuckoff", "Skinning", 10000, false, true, {
          disableMovement = false,
          disableCarMovement = false,
          disableMouse = false,
          disableCombat = true,
        }, {}, {}, {}, function()
          ClearPedTasksImmediately(PlayerPedId())
          DeleteEntity(baitAnimal) 
          TriggerServerEvent('Dox-hunting:skinReward')
        end)

      else
        print('Not your shit Bitch')
      end
    else
      RLCore.Functions.Notify("You need a knife", "error")
    end
  end, "WEAPON_KNIFE")
end)

RegisterNetEvent('Dox-hunting:usedBait')
AddEventHandler('Dox-hunting:usedBait', function()
  for k,v in pairs (HuntingZones) do
    if IsEntityInZone(PlayerPedId(),v) then
      if cooldown <= 0 then
        LoadAnimDict('amb@medic@standing@kneel@base')
        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )


        RLCore.Functions.Progressbar("fuckoff", "Placing Bait", 7500, false, true, {
          disableMovement = false,
          disableCarMovement = false,
          disableMouse = false,
          disableCombat = true,
        }, {}, {}, {}, function()
          Citizen.Wait(500)
          cooldown = useBaitCooldown * 10000
          used = true
          usedBait()
          --TriggerEvent('Dox-hunting:spawnAnimal')
          TriggerServerEvent('Dox-hunting:removeBait')
          baitCooldown()
          Citizen.Wait(1500)
          ClearPedTasksImmediately(PlayerPedId())
        end)
      end
    else
      --RLCore.Functions.Notify("There is no wildlife here", "error")
    end
  end
end)

function baitCooldown()
  Citizen.CreateThread(function()
    while cooldown > 0 do
      Wait(2000)
      cooldown = cooldown - 1000
    end
  end)
end

function usedBait()
  Citizen.CreateThread(function()
    while used do
      print('waiting to spawn')
      Wait(500)
      print('spawning')
      TriggerEvent('Dox-hunting:spawnAnimal')
      used = false
    end
  end)
end

function playerAnim()
	LoadAnimDict( "mp_safehouselost@" )
  TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

function LoadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
    RequestAnimDict(dict)
    Citizen.Wait(10)
  end
end





RegisterCommand('getzone', function()
  Coords = GetEntityCoords(PlayerPedId())
  ZoneName = GetNameOfZone(Coords)
  print(ZoneName)
end)

RegisterCommand('testhuntingspawn',function()
   TriggerEvent('Dox-hunting:spawnAnimal')
end)

RegisterNetEvent('Dox-hunting:client:openShop')
AddEventHandler('Dox-hunting:client:openShop', function()
    exports['qb-menu']:openMenu({
		{
            header = "Hunting Store",
            isMenuHeader = true
        },
        {
            header = "Buy Hunting Rifle",
            txt = "Current Price: $500",
            params = {
				    isServer = true,
            event = "Dox-hunting:server:sell", 
			      args = 1
            }
        },
        {
            header = "Buy Hunting Bait",
            txt = "Current Price: $CHANGEME each",
            params = {
				    isServer = true,
            event = "Dox-hunting:server:sell",
				    args = 2
            }
        },
		    {
            header = "Buy Hunting Knife",
            txt = "Current Price: $CHANGEME each",
            params = {
				    isServer = true,
            event = "Dox-hunting:server:sell",
				    args = 3 
            }
        },
    })
end)