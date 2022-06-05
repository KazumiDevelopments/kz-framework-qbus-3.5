myBlips = {}
local currentJob = ""

local blipSprites = {
  AIcall24 = 487, -- Robbery
  Aicall23 = 436,
  AIcall22 = 461, -- Prison Break
  AIcall21 = 126, -- restricted area
  AIcall20 = 472, -- power grid
  AIcall19 = 487, -- bank
  AIcall18 = 487, -- bank
  AIcall17 = 487, -- bank
  AIcall9 = 51,
  AIcall8 = 469,
  AIcall7 = 488, 
  AIcall6 = 433, 
  AIcall4 = 403, 
  AIcall3 = 126, 
  AIcall3a = 126,
  AIcall5 = 225, 
  AIcall2 = 110,
  AIcall10 = 189, 
  AIcall25 = 147,
  AIcall26 = 487,
  AIcall27 = 487, -- bank
  AIcall = 304, 
  ems = 364, 
  taxi = 280, 
  tow = 380
}

local job = nil

RLCore = nil

AddEventHandler("RLCore:Client:OnPlayerLoaded", function()
  if RLCore == nil then
      TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
      Citizen.Wait(200)
  end

  while RLCore.Functions.GetPlayerData() == nil do
    Wait(0)
  end

  while RLCore.Functions.GetPlayerData().job == nil do
    Wait(0)
  end

  PlayerJob = RLCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('RLCore:Client:OnJobUpdate')
AddEventHandler('RLCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)


local blipTxts = {
  AIcall9 = '911 Drug Sales', 
  AIcall8 = '911 Drug Use / Drug Possession / Intoxicated Person(s)', 
  AIcall4 = '911 Injured Body', 
  AIcall = '911 Complaint',
  AIcall3 = '911 Physical Fight', 
  AIcall3a = '911 Assault w/ Deadly Weapon', 
  AIcall5 = '911 GTA Related', 
  AIcall2 = '911 Firearm Related', 
  AIcall6 = '911 Gunshots',
  AIcall7 = '911 Vehicle Crash',
  AIcall10 = '911 Suspicious Activity',
  AIcall17 = '911 Paleto Bank Robbery',
  AIcall18 = '911 City Bank Robbery',
  AIcall19 = '911 Jewelry Store Robbery',
  AIcall20 = '911 Disturbance at power grid',
  AIcall21 = '911 Individual in restricted area.',
  AIcall22 = '911 Prison Break.',
  AIcall23 = '911 Explosion',
  AIcall24 = '911 Robbery',
  AIcall25 = '911 10-94 - Speeding Driver',
  AIcall26 = '911 Person Recently Robbed',
  AIcall27 = '911 Security Van Alarm',
  ems = 'EMS Requested', 
  taxi = 'Taxi Requested', 
  tow = 'Tow Requested'
}

-- Callbacks
RegisterNUICallback('assistance', function(data, cb)
  SendNUIMessage({openSection = "assistance"})
  cb('ok')
end)

RegisterNUICallback('google', function(data, cb)
  SendNUIMessage({openSection = "google"})
  cb('ok')
end)

RegisterNUICallback('assistEMS', function(data, cb)
  TriggerEvent('phone:assistRequest', 'ems', data.message)
  cb('ok')
end)

RegisterNUICallback('assistTaxi', function(data, cb)
  TriggerEvent('phone:assistRequest', 'taxi', data.message)
  cb('ok')
end)

RegisterNUICallback('assistTow', function(data, cb)
  TriggerEvent("canItow")
  cb('ok')
end)

RegisterNUICallback('assistAlerts', function(data, cb)
  SendNUIMessage({openSection = "alerts"})
  cb('ok')
end)

RegisterNUICallback('assistRoute', function(data, cb)
  local myBlip = myBlips[data.id]

  if myBlip ~= nil then
    local pedb = myBlip.blip
    if pedb ~= nil and DoesBlipExist(pedb) then
      myBlip.onRoute = true
      SetBlipRoute(pedb, 1)
    end
  end

  TriggerEvent('phone:close')
  cb('ok')
end)

-- Events
RegisterNetEvent('phoneGui')
AddEventHandler('phoneGui', function()
  TriggerEvent('jobssystem:current', function(job)
    if PlayerJob.name == nil or PlayerJob.name == "unemployed" or PlayerJob.name == "trucker" then
      SendNUIMessage({ toggleAlerts = true, status = false })
    else
      SendNUIMessage({ toggleAlerts = true, status = true })
    end
  end)
end)

RegisterNetEvent('phone:assistResponse')
AddEventHandler('phone:assistResponse', function(service, message)
  TriggerEvent("DoLongHudText", "Assistance is on its way!",1)
end)

RegisterNetEvent('phone:assistNotify')
AddEventHandler('phone:assistNotify', function(id, service, player)
  TriggerEvent('jobssystem:current', function(job)
    if PlayerJob.name == 'ambulance' and service == 'AIcall7' then
      addBlip({service = service, player = player, id = id,jobType = "ems"})
      TriggerEvent("chatMessage", "DISPATCH ", 3, 'A vehicular accident has been reported!')
    end
    if (PlayerJob.name 'ambulance' or PlayerJob.name == 'news') and (service == 'ems' or service =='AIcall23') or (PlayerJob.name == 'ambulance' and service == 'AIcall4') then
      if job == 'news' then
        addBlip({service = service, player = player, id = id,jobType = "news"})
         TriggerEvent("chatMessage", "DISPATCH ", 3, 'Report: Citizen requested medic!')
      elseif job == 'ems' then
          addBlip({service = service, player = player, id = id,jobType = "ems"})
          TriggerEvent("chatMessage", "DISPATCH ", 3, 'Medical assistance has been requested!')
      end
    elseif (PlayerJob.name == 'taxi' and service == 'taxi') then
      addBlip({service = service, player = player, id = id,jobType = "taxi"})
      TriggerEvent("chatMessage", "DISPATCH ", 3, 'Taxi service has been requested!')
    elseif (PlayerJob.name == 'police' or PlayerJob.name == 'news') and (service == 'AIcall27' or service == 'AIcall26' or service == 'AIcall25' or service == 'AIcall24' or service == 'AIcall23' or service == 'AIcall' or service == 'AIcall2' or service == 'AIcall3a' or service == 'AIcall3' or service == 'AIcall4' or service == 'AIcall5' or service == 'AIcall6' or service == 'AIcall7' or service == 'AIcall8' or service == 'AIcall17' or service == 'AIcall18' or service == 'AIcall19' or service == 'AIcall20' or service == 'AIcall21' or service == 'AIcall22' or service == 'AIcall9') then
      if PlayerJob.name == 'news' then
        addBlip({service = service, player = player, id = id,jobType = "news"})
        local radiocount = exports["np-inventory"]:getQuantity("scanner")
        if radiocount > 0 then
          TriggerEvent("chatMessage", "RADIO CHATTER: ", {255, 0, 0}, "A 911 call has been picked up on your radio scanner!")
        end
      else
        addBlip({service = service, player = player, id = id,jobType = "911"})
        if service == 'AIcall27' then
          TriggerEvent("chatMessage", "RADIO CHATTER: ", {255, 0, 0}, "A security van alarm has been triggered!")
        end
      end
    elseif PlayerJob.name == 'towtruck' and service == 'tow' then
      addBlip({service = service, player = player, id = id,jobType = "tow"})
      TriggerEvent("chatMessage", "DISPATCH ", 3, 'A tow truck has been requested!')
    end
  end)
end)

RegisterNetEvent('phone:assistRequest')
AddEventHandler('phone:assistRequest', function(service, message)
  if(service ~= nil and message ~= nil) then
    TriggerServerEvent('phone:assistRequest', service, message)
    TriggerEvent('phone:close')
    TriggerEvent('animation:phonecall')
  else
    TriggerEvent("DoLongHudText", "You must fill in a service to request and message!",2)
  end
end)


RegisterNetEvent('phone:assistClear')
AddEventHandler('phone:assistClear', function(id,jobsent)
  TriggerEvent('jobssystem:current', function(job)
    if myBlips[id] ~= nil and not myBlips[id].onRoute and (job == jobsent or (ESX.PlayerData.job.name == "police" and jobsent == "911")) then
      clearBlip(myBlips[id])
    end
  end)
end)
local holding = false
RegisterNetEvent('phone:currentNewsState')
AddEventHandler('phone:currentNewsState', function(isHolding)
  holding = isHolding
end)

local lastBlip = {}
local newsPayment = 0
local blipcount = 0

RegisterNetEvent('phone:assistPayJ')
AddEventHandler('phone:assistPayJ', function(name)

    if PlayerJob.name == 'taxi' then
      
      local ped = PlayerPedId()
      local currentVehicle = GetVehiclePedIsIn(ped, false)
      local driverPed = GetPedInVehicleSeat(currentVehicle, -1)

      if driverPed then
        if IsPedInAnyTaxi(ped) then
          TriggerServerEvent("server:givepayJob", "Taxi Service", math.random(1,300))
        else
          TriggerEvent("DoLongHudText","Please use a taxi or sign off duty.",2)
        end   
      end

    elseif PlayerJob.name == 'towtruck' then
      TriggerServerEvent("server:givepayJob", "Tow Service", math.random(1,300))

    elseif PlayerJob.name == 'news' then
      blipcount = blipcount + 1
      lastBlip = GetEntityCoords(ped)
      newsPayment = newsPayment +  math.random(1,200)
      TriggerEvent("DoLongHudText","Payment added to next payout.",2)

   else
      TriggerServerEvent("server:givepayJob", "Assist Blip Payment (Emergency)", math.random(1,300))

   end

end)
 



-- entertainer locations for job

nearEntertainments = {
  {x=377.01,y=-991.37,z=-98.6},
  {x=-551.63,y=284.18,z=82.98},
  {x=684.34,y=571.87,z=130.47},
}

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end
function GetClosestPlayers()
  local players = GetPlayers()
  local ply = PlayerPedId()
  local plyCoords = GetEntityCoords(ply, 0)
  local closestplayers = {}
  for index,value in ipairs(players) do
    local target = GetPlayerPed(value)
    if(target ~= ply) then
      local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
      local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
      if(distance < 25) then
        closestplayers[#closestplayers+1]=target
      end
    end
  end
  return #closestplayers
end

function CountPlayers() -- function to get players
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return #players
end

function nearEntertainment()

  for _,k in pairs(nearEntertainments) do

    local distance = #(GetEntityCoords(PlayerPedId()) - vector3(k.x,k.y,k.z))

    if(distance < 3.0) then
      return true
    end

  end

  return false
end


Citizen.CreateThread(function()
  local timer = 0
  local canPay = true

  while true do

    Citizen.Wait(60000)

    if nearEntertainment() and PlayerJob.name == "entertainer" then

      playerCount = GetClosestPlayers()
      local payment = math.ceil(8 * playerCount)
      if payment > 50 then
        payment = 50
      end
      TriggerServerEvent("server:givepayJob", "Entertainer Payment - Near Players = " .. playerCount, payment) 
    elseif PlayerJob.name == "news" then
      local dist = 0
      if lastBlip.x then 
        dist = #(vector3(GetEntityCoords(PlayerPedId())) - vector3(lastBlip.x,lastBlip.y,lastBlip.z))
      end
      if holding and dist < 130 and dist ~= 0 and blipcount >= 1 then
        playerCount = GetClosestPlayers()
        local pay = newsPayment + (25 * playerCount)
        TriggerServerEvent("server:givepayJob", "News Reporter",pay) 
        newsPayment = 0
        blipcount = 0 
        TriggerEvent("DoLongHudText","You have been paid a bonus for your dedication.",2)
      else
        if newsPayment ~= 0 then
          TriggerServerEvent("server:givepayJob", "News Reporter",newsPayment) 
          newsPayment = 0
        end
      end
      Citizen.Wait(2400000)
    else
      if PlayerJob.name == "entertainer" then
        Citizen.Wait(300000)
      end
    end

  end

end)


-- entertainer shit ^^

nearDOJPlaces = {
  {325.8117980957,-1583.9194335938,-62.021297454834,35}, -- court
  {340.43344116211,-1559.4678955078,29.981796264648,10}, -- front court
  {-1006.8497924805,-477.88690185547,50.028263092041,15}, -- office
  {448.45831298828,-987.85784912109,30.689596176147,50}, -- mission row
  {1713.1795654297,2586.6862792969,59.880760192871,250}, -- prison
  {1702.4781494141,2575.09765625,-69.406105041504,50}, -- visitors center
  {1793.4498291016,2483.2341308594,-122.70143127441,50}, -- jail cells
  {1854.3596191406,3686.5041503906,34.267040252686,30}, -- sandy shores pd
  {1861.2335205078,3668.6403808594,-116.78997802734,50}, -- sand shores cells
  {-445.88272094727,6013.3442382813,31.716373443604,30}, -- paleto pd
  {1690.7204589844,2518.3527832031,-120.84964752197,30}, -- paleto cells
  {2043.1849365234,2974.0278320313,-62.701934814453,30},
  {244.66287231445,-386.37911987305,45.403759002686,30},
  {645.98425292969,-7.8518662452698,82.756011962891,30},
}


function nearDOJ()

  for _,k in pairs(nearDOJPlaces) do

    local distance = #(GetEntityCoords(PlayerPedId()) - vector3(k[1],k[2],k[3]))

    if(distance < k[4]) then
      return true
    end

  end

  return false
end



-- public defender shit ^^


Citizen.CreateThread(function()
  local timer = 0
  local canPay = true
  while true do
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local curTime = GetGameTimer()
    if timer >= 300 then canPay = true end -- Time limit ,300 = 5 min ,1000 ms * 300 = 5 min 
    timer = timer +1

    for key, item in pairs(myBlips) do
      if (key ~= nil and item ~= nil) then
        -- If we are within 10 units of a blip that is not our own, clear the blip and message the server to clear for everyone
        if #(pos - vector3( item.pos.x, item.pos.y, item.pos.z)) < 50.0001 then
          if item.jobType == "ems" then
            if PlayerJob.name == "ambulance" then
              TriggerServerEvent('phone:assistRemove', item.id, item.jobType) -- Send message of clear to others
              clearBlip(item)
              if GetTimeDifference(curTime, item.timestamp) > 2000 then
                if canPay then
                  canPay = false
                  timer = 0
                  TriggerServerEvent('phone:checkJob')
                end

              end
            end
          elseif item.jobType == "news" then 
            if PlayerJob.name == "news" then
              TriggerServerEvent('phone:assistRemove', item.id, item.jobType) -- Send message of clear to others
              clearBlip(item)
              if GetTimeDifference(curTime, item.timestamp) > 2000 then
                if canPay then
                  canPay = false
                  timer = 0
                  TriggerServerEvent('phone:checkJob')
                end
              end
            end
          else
             TriggerServerEvent('phone:assistRemove', item.id, item.jobType) -- Send message of clear to others
              clearBlip(item)
              if GetTimeDifference(curTime, item.timestamp) > 2000 then
                if canPay then
                  canPay = false
                  timer = 0
                  TriggerServerEvent('phone:checkJob')
                end

              end
          end
        elseif GetTimeDifference(curTime, item.timestamp) > 600000 and not item.onRoute then
          -- If its been passed 10 minutes, clear the bip locally unless it's a blip we are on route to
          clearBlip(item)
        end
      end
    end

    Citizen.Wait(1000)
  end
end)

RegisterNetEvent("clearJobBlips")
AddEventHandler("clearJobBlips", function()
  -- Clear all our blips as our job has changed
  for key, item in pairs(myBlips) do
    if (key ~= nil and item ~= nil) then
      clearBlip(item)
    end
  end
end)

function addBlip(data)
  -- Don't add a blip if its for our own user
--[[   if PlayerPedId() == GetPlayerPed(GetPlayerFromServerId(tonumber(data.player.source))) then
    return
  end ]]
  local luck = math.random(2)
  local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(data.player.source))), 0.0, math.random(25) + 0.0, 0.0))
  if luck == 1 then
    x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(data.player.source))), math.random(25) + 0.0, 0.0, 0.0))
  end

  local blip = AddBlipForCoord(x, y, z)
  print(data.service)
  print("blipped")
  SetBlipScale(blip,2.5)
  if data.service == "AIcall17" or data.service == "AIcall18" or data.service == "AIcall19" or data.service == "AIcall22" then
    SetBlipFlashesAlternate(blip,true)
  end
  SetBlipSprite(blip, blipSprites[data.service])
  if PlayerJob.name == "news" then
    SetBlipSprite(blip,459)
  end
  SetBlipAlpha(blip,80)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(blipTxts[data.service])
  EndTextCommandSetBlipName(blip)

  local street = table.pack(GetStreetNameAtCoord(x, y, z))
  if street[2] ~= 0 and street[2] ~= nil then
    loc = string.format("%s, nearby %s", GetStreetNameFromHashKey(street[1]), GetStreetNameFromHashKey(street[2]))
  else
    loc = string.format("%s", GetStreetNameFromHashKey(street[1]))
  end

  SendNUIMessage({
    newAlert = true,
    alert = {
      id = data.id,
      location = loc,
      number = tonumber(data.player.phone_number),
    },
  })

  myBlips[data.id] = {service = data.service, timestamp = GetGameTimer(), loc = loc, onRoute = false, pos = {x=x,y=y,z=z}, blip = blip, id = data.id,jobType = data.type}
  PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
end

function clearBlip(item)
  if item == nil then
    return
  end

  local id = item.id
  local pedb = item.blip

  SendNUIMessage({
    removeAlert = true,
    alert = {
      id = id,
      location = item.loc,
    },
  })

  if item.onRoute then
    SetBlipRoute(pedb, false) 
  end

  if pedb ~= nil and DoesBlipExist(pedb) then
    myBlips[id] = nil
    SetBlipSprite(pedb, 2)
    SetBlipDisplay(pedb, 3)
    RemoveBlip(dblip)
  end
end