RegisterServerEvent('Dox-hunting:skinReward')
AddEventHandler('Dox-hunting:skinReward', function()
  local src = source
  local Player = RLCore.Functions.GetPlayer(src)
  local randomAmount = math.random(1,30)
  if randomAmount > 1 and randomAmount < 15 then
    Player.Functions.AddItem("huntingcarcass1", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["huntingcarcass1"], "add")
  elseif randomAmount > 15 and randomAmount < 23 then
    Player.Functions.AddItem("huntingcarcass2", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["huntingcarcass2"], "add")
  elseif randomAmount > 23 and randomAmount < 29 then
    Player.Functions.AddItem("huntingcarcass3", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["huntingcarcass3"], "add")
  else 
    Player.Functions.AddItem("huntingcarcass4", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["huntingcarcass4"], "add")
  end

  --TriggerClientEvent('player:receiveItem', _source, 'meat',math.random(1,4))
end)

RegisterServerEvent('Dox-hunting:removeBait')
AddEventHandler('Dox-hunting:removeBait', function()
  local src = source
  local Player = RLCore.Functions.GetPlayer(src)
  Player.Functions.RemoveItem("huntingbait", 1)
end)

RegisterServerEvent('remove:money')
AddEventHandler('remove:money', function(totalCash)
  local src = source
  local Player = RLCore.Functions.GetPlayer(src)
  if Player.PlayerData.money['cash'] >= (500) then
    Player.Functions.RemoveMoney('cash', 500)
    TriggerClientEvent("Dox-hunting:setammo", src)
    TriggerClientEvent("RLCore:Notify", src, 'Reloaded.')
  else
    TriggerClientEvent("RLCore:Notify", src, 'Not enough cash on you.', 'error')
  end
end)

RLCore.Functions.CreateUseableItem("huntingbait", function(source, item)
  local Player = RLCore.Functions.GetPlayer(source)

  TriggerClientEvent('Dox-hunting:usedBait', source)
end)


local carcasses = {
  huntingcarcass1 = 200,
  huntingcarcass2 = 475,
  huntingcarcass3 = 725,
  huntingcarcass4 = 1000
}

RegisterServerEvent('Dox-hunting:server:sell')
AddEventHandler('Dox-hunting:server:sell', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    for k,v in pairs(carcasses) do
        local item = Player.Functions.GetItemByName(k)
        if item ~= nil then
            if Player.Functions.RemoveItem(k, item.amount) then
                Player.Functions.AddMoney('cash', v * item.amount)
            end
        end
    end
end)

local rifleprice = 500
local baitprice = 50
local knifeprice = 75

RegisterNetEvent('Dox-hunting:server:sell')
  AddEventHandler('Dox-hunting:server:sell', function(args)
	local src = source
    local Player = RLCore.Functions.GetPlayer(src)
	local args = tonumber(args)
	local bankBalance = Player.PlayerData.money["bank"]
  
	if args == 1 then 
		if bankBalance >= rifleprice then
			Player.Functions.RemoveMoney('bank', rifleprice, "CHANGEME")
			Player.Functions.AddItem('CHANGEME', 1, nil, {["quality"] = 100})
			TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items['CHANGEME'], "add", 1)
			--TriggerClientEvent("doj:client:buyFishingGear", source)
		else
			TriggerClientEvent('RLCore:Notify', src, "You dont have enough money..", "error")
		end 
	elseif args == 2 then 
		if bankBalance >= baitprice then
			Player.Functions.RemoveMoney('bank', baitprice, "huntingbait")
			Player.Functions.AddItem('huntingbait', 1, nil, {["quality"] = 100})
			TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items['huntingbait'], "add", 1)
			--TriggerClientEvent("doj:client:buyFishingGear", source)
		else
			TriggerClientEvent('RLCore:Notify', src, "You dont have enough money..", "error")
		end
	elseif args == 3 then 
		if bankBalance >= knifeprice then
			Player.Functions.RemoveMoney('bank', knifeprice, "WEAPON_KNIFE")
			Player.Functions.AddItem('WEAPON_KNIFE', 1, nil, {["quality"] = 100})
			TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items['WEAPON_KNIFE'], "add", 1) 
			--TriggerClientEvent("doj:client:buyFishingGear", source)
		else
			TriggerClientEvent('RLCore:Notify', src, "You dont have enough money..", "error")
		end
  end
end)