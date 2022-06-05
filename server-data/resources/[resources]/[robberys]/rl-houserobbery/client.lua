local isLockpicking = false
local safe = 0
local safepos = {}
local isRobbing = false
local curHouseCoords = {x = 0, y = 0, z = 0}
local disturbance = 0
local isAgro = false
local myRobbableItems = {}
local robberyped = nil

local RLCore = nil
local PlayerData = {}
local pedSpawned = false

Citizen.CreateThread(function()
  while RLCore == nil do
    Citizen.Wait(100)
    TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
  end

  while RLCore.Functions.GetPlayerData().job == nil do
    Citizen.Wait(10)
  end
  
  PlayerData = RLCore.Functions.GetPlayerData()
end)

RegisterNetEvent("RLCore:Client:OnJobUpdate")
AddEventHandler("RLCore:Client:OnJobUpdate", function(jobInfo)
  PlayerData.job = jobInfo
end)


 RegisterCommand('breach', function(source, args)  
  local playerPed = PlayerPedId() 
  local playerCoords = GetEntityCoords(playerPed) 
  local found = false 
  if PlayerData.job ~= nil and PlayerData.job.name == 'police' then 
   for id,v in pairs(Config.RobbableHouses) do 
    if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 1.5 then
     loadAnimDict("anim@heists@ornate_bank@hostages@hit")
     TaskPlayAnim(playerPed, "anim@heists@ornate_bank@hostages@hit", "player_melee_long_rifle_kick_a", 3.0, 1.0, -1, 8, 0, 0, 0, 0)
     Citizen.Wait(1500)
     ClearPedTasks(playerPed)
     TriggerEvent("client:newStress",true,10)
     TriggerEvent('houseRobberies:createHouse', id, true) 
     found = true 
    end 
   end  
   if not found then  
    TriggerEvent('RLCore:Notify', "No house", "error") 
   end  
  else  
   TriggerEvent('RLCore:Notify', "You are not police", "error")  
  end 
 end)

local beenDone = false

function behave()
  beenDone = true
  Citizen.Wait(300000)
  beenDone = false
end

RegisterNetEvent('lockpicks:UseLockpick')
AddEventHandler('lockpicks:UseLockpick', function(advanced)
  if not advanced then
    return
  end

  if isRobbing and DoesEntityExist(safe) then
    local playerCoords = GetEntityCoords(PlayerPedId(), true)
    if GetDistanceBetweenCoords(playerCoords, safepos.x, safepos.y, safepos.z, true) <= 3.0 then

      if beenDone then
        TriggerEvent('RLCore:Notify', 'You have allready looted this safe', "error")
      else
        TriggerEvent("safecracking:loop",5)
        behave()

        if math.random(1, 20) == 1 then 
          TriggerServerEvent('houseRobberies:removeLockpick')
        end
      end
    end
  end


 if isNight() and not isRobbing then
  RLCore.Functions.TriggerCallback("houserob:checkcops", function(copsNum)
    if copsNum >= Config.MinCops then
      local playerCoords = GetEntityCoords(PlayerPedId(), true)
      for id,v in pairs(Config.RobbableHouses) do
        if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 2.5 then
          TriggerEvent('houseRobberies:lockpickAnimation')
          RLCore.Functions.Progressbar("lockpicking_property", "Lockpicking Property", 12000, false, true, {}, {}, {}, {}, function()
            isLockpicking = false
            pedSpawned = false
    
            if math.random(1, 10) <= 3 then
              TriggerEvent('dispatch:houseRobbery')
            end
    
            if math.random(1, 20) <= 5 then 
              TriggerServerEvent('houseRobberies:removeLockpick')
            end
    
            TriggerEvent('houseRobberies:createHouse', id)
          end)
        end
      end
    else
      TriggerEvent('RLCore:Notify', 'Not enough Police.', "error")
    end
  end)
end
  
  if not isNight() and not isRobbing then
    TriggerEvent('RLCore:Notify', 'Its too bright out.', "error")
  end
end)

RegisterNetEvent('houseRobberies:createHouse')
AddEventHandler('houseRobberies:createHouse', function(id)
 local house = Config.RobbableHouses[id]

 myRobbableItems = Config.RobbableLocations

 for i=1,#myRobbableItems do
  myRobbableItems[i]['isSearched'] = false
 end

 DoScreenFadeOut(100)
 Citizen.Wait(100)

 buildBasicHouse({x = house.x, y = house.y, z = house.z-50})
 Citizen.Wait(3000)

 randomAI({x = house.x, y = house.y, z = house.z-50})

 curHouseCoords = {x = house.x, y = house.y, z = house.z-50}
 disturbance = 0
 isAgro = false


 if math.random(10, 10) < 2 then
  TriggerEvent('houseRobberies:createDog')
 end

 DoScreenFadeIn(100)
 Citizen.Wait(100)

 isRobbing = true

 while isRobbing do
  Citizen.Wait(5)
  local playerCoords = GetEntityCoords(PlayerPedId(), true)

  if GetDistanceBetweenCoords(playerCoords, house.x+3.6, house.y-15, house.z-50, true) < 2.5 then
   drawTxt(0.97, 1.43, 1.0,1.0,0.4, 'Press ~g~E~w~ To Exit House', 255, 255, 255, 255)
   if IsControlJustPressed(0, 38) then
    TriggerEvent('houseRobberies:deleteHouse', id)
   end
  end
 end
end)

RegisterNetEvent('houseRobberies:deleteHouse')
AddEventHandler('houseRobberies:deleteHouse', function(id)
 local house = Config.RobbableHouses[id]

 myRobbableItems = Config.RobbableLocations
 DoScreenFadeOut(100)
 Citizen.Wait(100)

  FreezeEntityPosition(PlayerPedId(), true)
  DeleteSpawnedHouse(id)

  Citizen.Wait(1000)

  SetEntityCoords(PlayerPedId(), house.x, house.y, house.z)
  FreezeEntityPosition(PlayerPedId(), false)

  Citizen.Wait(500)

  DoScreenFadeIn(100)
  Citizen.Wait(100)

  TriggerEvent("robbery:guiclose")
  disturbance = 0
  isRobbing = false
end)

function isNight()
  local hour = GetClockHours()
  if hour > 19 or hour < 5 then
    return true
  end
end

function randomAI(generator)
 local modelhash = GetHashKey("a_m_m_beach_02")
 RequestModel(modelhash)

 while not HasModelLoaded(modelhash) do
  Citizen.Wait(0)
 end

 local airoll = math.random(5)
 if airoll == 1 then
  robberyped = CreatePed(GetPedType(modelhash), modelhash, generator.x+6.86376900,generator.y+1.20651200,generator.z+1.36589100, 15.0, 1, 1)
  SetEntityCoords(robberyped, generator.x+6.86376900, generator.y+1.20651200, generator.z+1.36589100)
  SetEntityHeading(robberyped, 80.0)
  SetEntityAsMissionEntity(robberyped, false, true)
  loadAnimDict("dead")
  TaskPlayAnim(robberyped, "dead", 'dead_a', 100.0, 1.0, -1, 1, 0, 0, 0, 0)
  pedSpawned = true
 elseif airoll == 2 then
  robberyped = CreatePed(GetPedType(modelhash), modelhash, generator.x+6.86376900,generator.y+1.20651200,generator.z+1.36589100, 15.0, 1, 1)
  SetEntityCoords(robberyped, generator.x-1.48765600, generator.y+1.68100600, generator.z+1.21640500)
  SetEntityHeading(robberyped, 190.0)
  SetEntityAsMissionEntity(robberyped, false, true)
  loadAnimDict("dead")
  TaskPlayAnim(robberyped, "dead", 'dead_b', 100.0, 1.0, -1, 1, 0, 0, 0, 0)
  pedSpawned = true
 end
end

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  local generator = {x = curHouseCoords["x"], y = curHouseCoords["y"], z = curHouseCoords["z"]}

  if isRobbing then
   for i=1,#myRobbableItems do
    if (GetDistanceBetweenCoords(generator.x + myRobbableItems[i]["x"], generator.y + myRobbableItems[i]["y"], generator.z + myRobbableItems[i]["z"], GetEntityCoords(GetPlayerPed(-1))) < 1.4) and not myRobbableItems[i]['isSearched'] then
     DrawText3Ds(generator.x + myRobbableItems[i]["x"], generator.y + myRobbableItems[i]["y"], generator.z + myRobbableItems[i]["z"], '~w~Press ~g~H~s~ To Search ' .. myRobbableItems[i]["name"])

     if IsControlJustReleased(1, 74) then
      myRobbableItems[i]['isSearched'] = true
      local distance, pedcount = closestNPC()
      local distadd = 0.1
      if pedcount > 0 then
       distadd = distadd + (pedcount / 100)
       local distancealter = (8.0 - distance) / 100
       distadd = distadd + distancealter
      end

      distadd = distadd * 100
      disturbance = disturbance + distadd
      if math.random(100) > 95 then
 			 disturbance = disturbance + 10
      end

      DisableAllControlActions(0)
      FreezeEntityPosition(PlayerPedId(), true)
      TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
      RLCore.Functions.Progressbar("search_"..myRobbableItems[i]['name'], "Searching "..myRobbableItems[i]['name'], 20000, false, true, {}, {}, {}, {}, function()
        EnableAllControlActions(0)
        ClearPedTasks(playerPed)
        TriggerServerEvent('houseRobberies:searchItem')
        FreezeEntityPosition(PlayerPedId(), false)
      end)
     end
    end
 	 end

   if IsPedShooting(PlayerPedId()) then
    disturbance = 90
    if not isAgro then
     agroNPC()
    end
   end

   TriggerEvent("robbery:guiupdate", math.ceil(disturbance))

   if disturbance > 85 then
    if not calledin then
     local num = 150 - disturbance
     num = math.random(math.ceil(num))
     local fuckup = math.ceil(num)

     if fuckup == 2 and GetEntitySpeed(GetPlayerPed(-1)) > 0.8 then
      calledin = true
      if not isAgro then
       agroNPC()
       TriggerEvent('dispatch:houseRobbery')

      end
     end
    end
   end

   if GetEntitySpeed(GetPlayerPed(-1)) > 1.4 then
    local distance, pedcount = closestNPC()
    local alteredsound = 0.1
    if pedcount > 0 then
     alteredsound = alteredsound + (pedcount / 100)
     local distancealter = (8.0 - distance) / 100
     alteredsound = alteredsound + distancealter
    end

    disturbance = disturbance + alteredsound
    if GetEntitySpeed(GetPlayerPed(-1)) > 2.0 then
     disturbance = disturbance + alteredsound
    end

    if GetEntitySpeed(GetPlayerPed(-1)) > 3.0 then
     disturbance = disturbance + alteredsound
    end
   else
    disturbance = disturbance - 0.01
    if disturbance < 0 then
     disturbance = 0
    end
   end
  end
 end
end)

function buildBasicHouse(generator)
 SetEntityCoords(PlayerPedId(), 347.04724121094, -1000.2844848633, -99.194671630859)
 FreezeEntityPosition(PlayerPedId(), true)
 Citizen.Wait(2000)
 local building = CreateObject(GetHashKey("clrp_house_1"), generator.x, generator.y-0.05, generator.z+1.26253700-89.825, false, false, false)
 FreezeEntityPosition(building, true)
 Citizen.Wait(500)
 SetEntityCoords(PlayerPedId(), generator.x+3.6, generator.y-14.8, generator.z+2.9)
 SetEntityHeading(PlayerPedId(), 358.106)

 local dt = CreateObject(GetHashKey("V_16_DT"), generator.x-1.21854400, generator.y-1.04389600, generator.z+1.39068600, false, false, false)
 local mpmid01 = CreateObject(GetHashKey("V_16_mpmidapart01"), generator.x+0.52447510, generator.y-5.04953700, generator.z+1.32, false, false, false)
 local mpmid09 = CreateObject(GetHashKey("V_16_mpmidapart09"), generator.x+0.82202150, generator.y+2.29612000, generator.z+1.88, false, false, false)
 local mpmid07 = CreateObject(GetHashKey("V_16_mpmidapart07"), generator.x-1.91445900, generator.y-6.61911300, generator.z+1.45, false, false, false)
 local mpmid03 = CreateObject(GetHashKey("V_16_mpmidapart03"), generator.x-4.82565300, generator.y-6.86803900, generator.z+1.14, false, false, false)
 local midData = CreateObject(GetHashKey("V_16_midapartdeta"), generator.x+2.28558400, generator.y-1.94082100, generator.z+1.32, false, false, false)
 local glow = CreateObject(GetHashKey("V_16_treeglow"), generator.x-1.37408500, generator.y-0.95420070, generator.z+1.135, false, false, false)
 local curtins = CreateObject(GetHashKey("V_16_midapt_curts"), generator.x-1.96423300, generator.y-0.95958710, generator.z+1.280, false, false, false)
 local mpmid13 = CreateObject(GetHashKey("V_16_mpmidapart13"), generator.x-4.65580700, generator.y-6.61684000, generator.z+1.259, false, false, false)
 local mpcab = CreateObject(GetHashKey("V_16_midapt_cabinet"), generator.x-1.16177400, generator.y-0.97333810, generator.z+1.27, false, false, false)
 local mpdecal = CreateObject(GetHashKey("V_16_midapt_deca"), generator.x+2.311386000, generator.y-2.05385900, generator.z+1.297, false, false, false)
 local mpdelta = CreateObject(GetHashKey("V_16_mid_hall_mesh_delta"), generator.x+3.69693000, generator.y-5.80020100, generator.z+1.293, false, false, false)
 local beddelta = CreateObject(GetHashKey("V_16_mid_bed_delta"), generator.x+7.95187400, generator.y+1.04246500, generator.z+1.28402300, false, false, false)
 local bed = CreateObject(GetHashKey("V_16_mid_bed_bed"), generator.x+6.86376900, generator.y+1.20651200, generator.z+1.33589100, false, false, false)
 local beddecal = CreateObject(GetHashKey("V_16_MID_bed_over_decal"), generator.x+7.82861300, generator.y+1.04696700, generator.z+1.34753700, false, false, false)
 local bathDelta = CreateObject(GetHashKey("V_16_mid_bath_mesh_delta"), generator.x+4.45460500, generator.y+3.21322800, generator.z+1.21116100, false, false, false)
 local bathmirror = CreateObject(GetHashKey("V_16_mid_bath_mesh_mirror"), generator.x+3.57740800, generator.y+3.25032000, generator.z+1.48871300, false, false, false)

	--props
 local beerbot = CreateObject(GetHashKey("Prop_CS_Beer_Bot_01"), generator.x+1.73134600, generator.y-4.88520200, generator.z+1.91083000, false, false, false)
 local couch = CreateObject(GetHashKey("v_res_mp_sofa"), generator.x-1.48765600, generator.y+1.68100600, generator.z+1.33640500, false, false, false)
 local chair = CreateObject(GetHashKey("v_res_mp_stripchair"), generator.x-4.44770800, generator.y-1.78048800, generator.z+1.21640500, false, false, false)
 local chair2 = CreateObject(GetHashKey("v_res_tre_chair"), generator.x+2.91325400, generator.y-5.27835100, generator.z+1.22746400, false, false, false)
 local plant = CreateObject(GetHashKey("Prop_Plant_Int_04a"), generator.x+2.78941300, generator.y-4.39133900, generator.z+2.12746400, false, false, false)
 local lamp = CreateObject(GetHashKey("v_res_d_lampa"), generator.x-3.61473100, generator.y-6.61465100, generator.z+2.09373700, false, false, false)
 local fridge = CreateObject(GetHashKey("v_res_fridgemodsml"), generator.x+1.90339700, generator.y-3.80026800, generator.z+1.29917900, false, false, false)
 local micro = CreateObject(GetHashKey("prop_micro_01"), generator.x+2.03442400, generator.y-4.64585100, generator.z+2.28995600, false, false, false)
 local sideBoard = CreateObject(GetHashKey("V_Res_Tre_SideBoard"), generator.x+2.84053000, generator.y-4.30947100, generator.z+1.24577300, false, false, false)
 local bedSide = CreateObject(GetHashKey("V_Res_Tre_BedSideTable"), generator.x-3.50363200, generator.y-6.55289400, generator.z+1.30625800, false, false, false)
 local lamp2 = CreateObject(GetHashKey("v_res_d_lampa"), generator.x+2.69674700, generator.y-3.83123500, generator.z+2.09373700, false, false, false)
 local plant2 = CreateObject(GetHashKey("v_res_tre_tree"), generator.x-4.96064800, generator.y-6.09898500, generator.z+1.31631400, false, false, false)
 local table = CreateObject(GetHashKey("V_Res_M_DineTble_replace"), generator.x-3.50712600, generator.y-4.13621600, generator.z+1.29625800, false, false, false)
 local tv = CreateObject(GetHashKey("Prop_TV_Flat_01"), generator.x-5.53120400, generator.y+0.76299670, generator.z+2.17236000, false, false, false)
 local plant3 = CreateObject(GetHashKey("v_res_tre_plant"), generator.x-5.14112800, generator.y-2.78951000, generator.z+1.25950800, false, false, false)
 local chair3 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-3.04652400, generator.y-4.95971200, generator.z+1.19625800, false, false, false)
 local lampStand = CreateObject(GetHashKey("v_res_m_lampstand"), generator.x+1.26588400, generator.y+3.68883900, generator.z+1.35556700, false, false, false)
 local stool = CreateObject(GetHashKey("V_Res_M_Stool_REPLACED"), generator.x-3.23216300, generator.y+2.06159000, generator.z+1.20556700, false, false, false)
 local chair4 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-2.82237200, generator.y-3.59831300, generator.z+1.25950800, false, false, false)
 local chair5 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-4.14955100, generator.y-4.71316600, generator.z+1.19625800, false, false, false)
 local chair6 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-3.80622900, generator.y-3.37648300, generator.z+1.19625800, false, false, false)
 local plant4 = CreateObject(GetHashKey("v_res_fa_plant01"), generator.x+2.97859200, generator.y+2.55307400, generator.z+1.85796300, false, false, false)
 local storage = CreateObject(GetHashKey("v_res_tre_storageunit"), generator.x+8.47819500, generator.y-2.50979300, generator.z+1.19712300, false, false, false)
 local storage2 = CreateObject(GetHashKey("v_res_tre_storagebox"), generator.x+9.75982700, generator.y-1.35874100, generator.z+1.29625800, false, false, false)
 local basketmess = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x+8.70730600, generator.y-2.55503600, generator.z+1.94059590, false, false, false)
 local lampStand2 = CreateObject(GetHashKey("v_res_m_lampstand"), generator.x+9.54306000, generator.y-2.50427700, generator.z+1.30556700, false, false, false)
 local plant4 = CreateObject(GetHashKey("Prop_Plant_Int_03a"), generator.x+9.87521400, generator.y+3.90917400, generator.z+1.20829700, false, false, false)
 local basket = CreateObject(GetHashKey("v_res_tre_washbasket"), generator.x+9.39091500, generator.y+4.49676300, generator.z+1.19625800, false, false, false)
 local wardrobe = CreateObject(GetHashKey("V_Res_Tre_Wardrobe"), generator.x+8.46626300, generator.y+4.53223600, generator.z+1.19425800, false, false, false)
 local basket2 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+8.51593000, generator.y+4.55647300, generator.z+3.46737300, false, false, false)
 local basket3 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x+7.57797200, generator.y+4.55198800, generator.z+3.46737300, false, false, false)
 local basket4 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+7.12286400, generator.y+4.54689200, generator.z+3.46737300, false, false, false)
 local wardrobe2 = CreateObject(GetHashKey("V_Res_Tre_Wardrobe"), generator.x+7.24382000, generator.y+4.53423500, generator.z+1.19625800, false, false, false)
 local basket5 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+8.03364600, generator.y+4.54835500, generator.z+3.46737300, false, false, false)
 local switch = CreateObject(GetHashKey("v_serv_switch_2"), generator.x+6.28086900, generator.y-0.68169880, generator.z+2.30326000, false, false, false)
 local table2 = CreateObject(GetHashKey("V_Res_Tre_BedSideTable"), generator.x+5.84416200, generator.y+2.57377400, generator.z+1.22089100, false, false, false)
 local lamp3 = CreateObject(GetHashKey("v_res_d_lampa"), generator.x+5.84912100, generator.y+2.58001100, generator.z+1.95311890, false, false, false)
 --local laundry = CreateObject(GetHashKey("v_res_mlaundry"), generator.x+5.77729800, generator.y+4.60211400, generator.z+1.19674400, false, false, false)
 local ashtray = CreateObject(GetHashKey("Prop_ashtray_01"), generator.x-1.24716200, generator.y+1.07820500, generator.z+1.87089300, false, false, false)
 local candle1 = CreateObject(GetHashKey("v_res_fa_candle03"), generator.x-2.89289900, generator.y-4.35329700, generator.z+2.02881310, false, false, false)
 local candle2 = CreateObject(GetHashKey("v_res_fa_candle02"), generator.x-3.99865700, generator.y-4.06048500, generator.z+2.02530190, false, false, false)
 local candle3 = CreateObject(GetHashKey("v_res_fa_candle01"), generator.x-3.37733400, generator.y-3.66639800, generator.z+2.02526200, false, false, false)
 local woodbowl = CreateObject(GetHashKey("v_res_m_woodbowl"), generator.x-3.50787400, generator.y-4.11983000, generator.z+2.02589900, false, false, false)
 local tablod = CreateObject(GetHashKey("V_Res_TabloidsA"), generator.x-0.80513000, generator.y+0.51389600, generator.z+1.18418800, false, false, false)
 local tapeplayer = CreateObject(GetHashKey("Prop_Tapeplayer_01"), generator.x-1.26010100, generator.y-3.62966400, generator.z+2.37883200, false, false, false)
 local woodbowl2 = CreateObject(GetHashKey("v_res_tre_fruitbowl"), generator.x+2.77764900, generator.y-4.138297000, generator.z+2.10340100, false, false, false)
 local sculpt = CreateObject(GetHashKey("v_res_sculpt_dec"), generator.x+3.03932200, generator.y+1.62726400, generator.z+3.58363900, false, false, false)
 local jewlry = CreateObject(GetHashKey("v_res_jewelbox"), generator.x+3.04164100, generator.y+0.31671810, generator.z+3.58363900, false, false, false)
 local basket6 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x-1.64906300, generator.y+1.62675900, generator.z+1.39038500, false, false, false)
 local basket7 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x-1.63938900, generator.y+0.91133310, generator.z+1.39038500, false, false, false)
 local basket8 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x-1.19923400, generator.y+1.69598600, generator.z+1.39038500, false, false, false)
 local basket9 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x-1.18293800, generator.y+0.91436380, generator.z+1.39038500, false, false, false)
 local bowl = CreateObject(GetHashKey("v_res_r_sugarbowl"), generator.x-0.26029210, generator.y-6.66716800, generator.z+3.77324900, false, false, false)
 local breadbin = CreateObject(GetHashKey("Prop_Breadbin_01"), generator.x+2.09788500, generator.y-6.57634000, generator.z+2.24041900, false, false, false)
 local knifeblock = CreateObject(GetHashKey("v_res_mknifeblock"), generator.x+1.82084700, generator.y-6.58438500, generator.z+2.27399500, false, false, false)
 local toaster = CreateObject(GetHashKey("prop_toaster_01"), generator.x-1.05790700, generator.y-6.59017400, generator.z+2.26793200, false, false, false)
 local wok = CreateObject(GetHashKey("prop_wok"), generator.x+2.01728800, generator.y-5.57091500, generator.z+2.31793200, false, false, false)
 local plant5 = CreateObject(GetHashKey("Prop_Plant_Int_03a"), generator.x+2.55015600, generator.y+4.60183900, generator.z+1.20829700, false, false, false)
 local tumbler = CreateObject(GetHashKey("p_tumbler_cs2_s"), generator.x-0.90916440, generator.y-4.24099100, generator.z+2.24693200, false, false, false)
 local wisky = CreateObject(GetHashKey("p_whiskey_bottle_s"), generator.x-0.92809300, generator.y-3.99099100, generator.z+2.24693200, false, false, false)
 local tissue = CreateObject(GetHashKey("v_res_tissues"), generator.x+7.95889300, generator.y-2.54847100, generator.z+1.94013400, false, false, false)
 local pants = CreateObject(GetHashKey("V_16_Ap_Mid_Pants4"), generator.x+7.55366500, generator.y-0.25457100, generator.z+1.33009200, false, false, false)
 local pants2 = CreateObject(GetHashKey("V_16_Ap_Mid_Pants5"), generator.x+7.76753200, generator.y+3.00476500, generator.z+1.33052800, false, false, false)
 local hairdryer = CreateObject(GetHashKey("v_club_vuhairdryer"), generator.x+8.12616000, generator.y-2.50562000, generator.z+1.96009390, false, false, false)

 FreezeEntityPosition(dt,true)
 FreezeEntityPosition(mpmid01,true)
 FreezeEntityPosition(mpmid09,true)
 FreezeEntityPosition(mpmid07,true)
 FreezeEntityPosition(mpmid03,true)
 FreezeEntityPosition(midData,true)
 FreezeEntityPosition(glow,true)
 FreezeEntityPosition(curtins,true)
 FreezeEntityPosition(mpmid13,true)
 FreezeEntityPosition(mpcab,true)
 FreezeEntityPosition(mpdecal,true)
 FreezeEntityPosition(mpdelta,true)
 FreezeEntityPosition(couch,true)
 FreezeEntityPosition(chair,true)
 FreezeEntityPosition(chair2,true)
 FreezeEntityPosition(plant,true)
 FreezeEntityPosition(lamp,true)
 FreezeEntityPosition(fridge,true)
 FreezeEntityPosition(micro,true)
 FreezeEntityPosition(sideBoard,true)
 FreezeEntityPosition(bedSide,true)
 FreezeEntityPosition(plant2,true)
 FreezeEntityPosition(table,true)
 FreezeEntityPosition(tv,true)
 FreezeEntityPosition(plant3,true)
 FreezeEntityPosition(chair3,true)
 FreezeEntityPosition(lampStand,true)
 FreezeEntityPosition(chair4,true)
 FreezeEntityPosition(chair5,true)
 FreezeEntityPosition(chair6,true)
 FreezeEntityPosition(plant4,true)
 FreezeEntityPosition(storage2,true)
 FreezeEntityPosition(basket,true)
 FreezeEntityPosition(wardrobe,true)
 FreezeEntityPosition(wardrobe2,true)
 FreezeEntityPosition(table2,true)
 FreezeEntityPosition(lamp3,true)
 -- FreezeEntityPosition(laundry,true)
 FreezeEntityPosition(beddelta,true)
 FreezeEntityPosition(bed,true)
 FreezeEntityPosition(beddecal,true)
 FreezeEntityPosition(tapeplayer,true)
 FreezeEntityPosition(basket7,true)
 FreezeEntityPosition(basket6,true)
 FreezeEntityPosition(basket8,true)
 FreezeEntityPosition(basket9,true)

 if math.random(1, 10) >= 6 then
  CreateSafe(generator.x+6.2,generator.y+4.52972300,generator.z+1.32609800)
 end

 SetEntityHeading(beerbot,GetEntityHeading(beerbot)+90)
 SetEntityHeading(couch,GetEntityHeading(couch)-90)
 SetEntityHeading(chair,GetEntityHeading(chair)+getRotation(0.28045480))
 SetEntityHeading(chair2,GetEntityHeading(chair2)+getRotation(0.3276100))
 SetEntityHeading(fridge,GetEntityHeading(chair2)+160)
 SetEntityHeading(micro,GetEntityHeading(micro)-90)
 SetEntityHeading(sideBoard,GetEntityHeading(sideBoard)+90)
 SetEntityHeading(bedSide,GetEntityHeading(bedSide)+180)
 SetEntityHeading(tv,GetEntityHeading(tv)+90)
 SetEntityHeading(plant3,GetEntityHeading(plant3)+90)
 SetEntityHeading(chair3,GetEntityHeading(chair3)+200)
 SetEntityHeading(chair4,GetEntityHeading(chair3)+100)
 SetEntityHeading(chair5,GetEntityHeading(chair5)+135)
 SetEntityHeading(chair6,GetEntityHeading(chair6)+10)
 SetEntityHeading(storage,GetEntityHeading(storage)+180)
 SetEntityHeading(storage2,GetEntityHeading(storage2)-90)
 SetEntityHeading(table2,GetEntityHeading(table2)+90)
 SetEntityHeading(tapeplayer,GetEntityHeading(tapeplayer)+90)
 SetEntityHeading(knifeblock,GetEntityHeading(knifeblock)+180)
 FreezeEntityPosition(PlayerPedId(),false)
end

function DeleteSpawnedHouse(id)
 local housePosition = Config.RobbableHouses[id]
 local handle, ObjectFound = FindFirstObject()
 local success
 repeat
  local pos = GetEntityCoords(ObjectFound)
  local distance = GetDistanceBetweenCoords(housePosition["x"], housePosition["y"], (housePosition["z"] - 24.0), pos, true)
  if distance < 35.0 and ObjectFound ~= PlayerPedId() then
   if IsEntityAPed(ObjectFound) then
    if not IsPedAPlayer(ObjectFound) then
     DeleteObject(ObjectFound)
    end
   else
    DeleteObject(ObjectFound)
   end
  end
  success, ObjectFound = FindNextObject(handle)
 until not success
 EndFindObject(handle)
end

function getRotation(input)
	return 360/(10*input)
end

RegisterNetEvent('houseRobberies:lockpickAnimation')
AddEventHandler('houseRobberies:lockpickAnimation', function()
 isLockpicking = true
 loadAnimDict('veh@break_in@0h@p_m_one@')
 while isLockpicking do
  if not IsEntityPlayingAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3) then
   TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
   Citizen.Wait(1500)
   ClearPedTasks(PlayerPedId())
  end
  Citizen.Wait(1)
 end
 ClearPedTasks(PlayerPedId())
end)

function loadAnimDict(dict)
 RequestAnimDict(dict)
 while not HasAnimDictLoaded(dict) do
  Citizen.Wait(5)
 end
end


function DrawText3Ds(x,y,z, text)
 local onScreen,_x,_y=World3dToScreen2d(x,y,z)
 local px,py,pz=table.unpack(GetGameplayCamCoords())
 SetTextScale(0.35, 0.35)
 SetTextFont(4)
 SetTextProportional(1)
 SetTextColour(255, 255, 255, 215)
 SetTextEntry("STRING")
 SetTextCentre(1)
 AddTextComponentString(text)
 DrawText(_x,_y)
 local factor = (string.len(text)) / 370
 DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function closestNPC()
 local playerCoords = GetEntityCoords(GetPlayerPed(-1))
 local handle, ped = FindFirstPed()
 local success
 local rped = nil
 local distanceFrom = 999.0
 local pedcount = 0
 repeat
  local pos = GetEntityCoords(ped)
  local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
  if distance < 25.0 and ped ~= GetPlayerPed(-1) and not IsPedAPlayer(ped) then
   pedcount = pedcount + 1
   if (distance < distanceFrom) then
    distanceFrom = distance
    rped = ped
   end
  end
 success, ped = FindNextPed(handle)
 until not success
  EndFindPed(handle)
 return distanceFrom, pedcount
end

local attackDog = nil

function agroNPC()
 local playerCoords = GetEntityCoords(GetPlayerPed(-1))
 local handle, ped = FindFirstPed()
 local success
 local rped = nil
 local distanceFrom = 999.0
 local pedcount = 0
 repeat
  local pos = GetEntityCoords(ped)
  local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
  if distance < 35.0 and ped ~= GetPlayerPed(-1) and not IsPedAPlayer(ped) then
   ClearPedTasksImmediately(ped)
   SetPedDropsWeaponsWhenDead(ped,false)
   GiveWeaponToPed(ped, GetHashKey('WEAPON_BAT'), 150, 0, 1)
   TaskCombatPed(ped, GetPlayerPed(-1), 0, 16)
   SetPedKeepTask(ped, true)
   isAgro = true
  end
  success, ped = FindNextPed(handle)
 until not success
 EndFindPed(handle)
end

AddEventHandler('houseRobberies:createDog', function()
 if not DoesEntityExist(attackDog) then
  local model = GetHashKey("A_C_Rottweiler")

  RequestModel(model)
  while not HasModelLoaded(model) do
   RequestModel(model)
   Citizen.Wait(100)
  end

  TriggerEvent('dispatch:houseRobbery')
  attackDog = CreatePed(GetPedType(model), model, curHouseCoords.x+3.70339700, curHouseCoords.y+-3.80026800, curHouseCoords.z+2.29917900, 90, 1, 0)
  Citizen.Wait(1500)
  TaskCombatPed(attackDog, GetPlayerPed(-1), 0, 16)
  SetPedKeepTask(attackDog, true)
  Citizen.Wait(45000)
  SetEntityAsNoLongerNeeded(attackDog)
  attackDog = 0
 end
end)

function CreateSafe(x,y,z)
	safespawned = true
	safepos = {["x"] = x, ["y"] = y, ["z"] = z}

	RequestModel(GetHashKey("prop_ld_int_safe_01"))
	while not HasModelLoaded(GetHashKey("prop_ld_int_safe_01")) do
   Citizen.Wait(100)
	end

	safe = CreateObject(GetHashKey("prop_ld_int_safe_01"), x, y, z,true, false, false)
	FreezeEntityPosition(safe,true)
end

RegisterNetEvent('safe:success')
AddEventHandler('safe:success', function()
 DeleteEntity(safe)
 DeleteObject(safe)
 SetEntityAsNoLongerNeeded(safe)
 safepos = {["x"] = 0, ["y"] = 0, ["z"] = 0}
 TriggerServerEvent('houseRobberies:giveMoney')
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
  SetTextFont(4)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,15)
  SetTextEdge(2, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x - width/2, y - height/2)
end