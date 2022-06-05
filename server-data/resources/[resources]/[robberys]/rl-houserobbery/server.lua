local RLCore = nil

RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
 local source = tonumber(source)
 local xPlayer = RLCore.Functions.GetPlayer(source)
 xPlayer.Functions.RemoveItem('advancedlockpick', 1)
 TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items['advancedlockpick'], "remove")
 TriggerClientEvent('RLCore:Notify', source, 'The lockpick bent out of shape.', "error")
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
 local source = tonumber(source)
 local xPlayer = RLCore.Functions.GetPlayer(source)
 local cash = math.random(500, 1200)
 xPlayer.Functions.AddMoney('cash', cash)
 PerformHttpRequest('https://discord.com/api/webhooks/815275240401797220/yZWUYsgGqNZc8SASpUTNz2O4eno_S7iB94ZJLxWobfUrxRj0_8gcki2kcP7xcP530k5m', function(err, text, headers) end, 'POST', json.encode({username = "House Robberies Log", content = "__**" .. GetPlayerName(source) .. "**__ Got Money: **" .. cash .. "** **.** "}), { ['Content-Type'] = 'application/json' })
 TriggerClientEvent('RLCore:Notify', source, 'You found $'..cash)
end)

RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
 local source = tonumber(source)
 local item = {}
 local xPlayer = RLCore.Functions.GetPlayer(source) 
 local gotID = {}

 

 for i=1, math.random(1, 2) do
  item = Config.RobbableItems[math.random(1, #Config.RobbableItems)]
  if math.random(1, 10) >= item.chance then
   if tonumber(item.id) == 0 and not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.Functions.AddMoney('cash', item.quantity)
    PerformHttpRequest('https://discord.com/api/webhooks/815275240401797220/yZWUYsgGqNZc8SASpUTNz2O4eno_S7iB94ZJLxWobfUrxRj0_8gcki2kcP7xcP530k5m', function(err, text, headers) end, 'POST', json.encode({username = "House Robberies Log", content = "__**" .. GetPlayerName(source) .. "**__ Found: **" .. item.isWeapon .. "** **.** "}), { ['Content-Type'] = 'application/json' })
    TriggerClientEvent('RLCore:Notify', source, 'You found $'..item.quantity)
   elseif not gotID[item.id] then
    gotID[item.id] = true

    xPlayer.Functions.AddItem(item.id, item.quantity) 
    TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items[item.id], "add")
    PerformHttpRequest('https://discord.com/api/webhooks/815275240401797220/yZWUYsgGqNZc8SASpUTNz2O4eno_S7iB94ZJLxWobfUrxRj0_8gcki2kcP7xcP530k5m', function(err, text, headers) end, 'POST', json.encode({username = "House Robberies Log", content = "__**" .. GetPlayerName(source) .. "**__ Found: **" .. item.id .. "** **.** "}), { ['Content-Type'] = 'application/json' })
    TriggerClientEvent('RLCore:Notify', source, 'Item Added!')

    local math = math.random(1,100)
    local mathChance = math.random(1,100)
    if math <= 10 then 
      if mathChance <= 15 then
        xPlayer.Functions.AddItem("weed_white-widow_seed", 1) 
        TriggerClientEvent('inventory:client:ItemBox', source, "weed_white-widow_seed", "add")
      elseif mathChance <= 12 then
        xPlayer.Functions.AddItem("weed_skunk_seed", 1) 
        TriggerClientEvent('inventory:client:ItemBox', source, "weed_skunk_seed", "add")
      elseif mathChance <= 10 then
        xPlayer.Functions.AddItem("weed_purple-haze_seed", 1) 
        TriggerClientEvent('inventory:client:ItemBox', source, "weed_purple-haze_seed", "add")
      elseif mathChance <= 8 then
        xPlayer.Functions.AddItem("weed_og-kush_seed", 1) 
        TriggerClientEvent('inventory:client:ItemBox', source, "weed_og-kush_seed", "add")
      elseif mathChance <= 6 then 
        xPlayer.Functions.AddItem("weed_amnesia_seed", 1) 
        TriggerClientEvent('inventory:client:ItemBox', source, "weed_amnesia_seed", "add")
      elseif mathChance <= 4 then
        xPlayer.Functions.AddItem("weed_ak47_seed", 1) 
        TriggerClientEvent('inventory:client:ItemBox', source, "weed_ak47_seed", "add")
      end
    end
   end 
  end
 end
end)

RLCore.Functions.CreateCallback('houserob:checkcops', function(source, cb)
  local currentplayers = RLCore.Functions.GetPlayers()
  local cops = 0

  for i = 1, #currentplayers, 1 do
    local xPlayer = RLCore.Functions.GetPlayer(currentplayers[i])
    if xPlayer.PlayerData.job ~= nil and xPlayer.PlayerData.job.name == "police" then
      cops = cops + 1
    end
  end

  cb(cops)
end)
