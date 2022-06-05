RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local jobDeliverys = {}

RegisterServerEvent('rl-jobs:server:readyForDelivery')
AddEventHandler('rl-jobs:server:readyForDelivery', function(job, item)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	local count = xPlayer.Functions.GetItemByName(item).amount

	if count >= 1 then
		xPlayer.Functions.RemoveItem(item, count)
		if jobDeliverys[job] ~= nil then
			jobDeliverys[job].count = jobDeliverys[job].count + count
		else
			jobDeliverys[job] = {}
			jobDeliverys[job].count = count
		end

		TriggerClientEvent('RLCore:Notify', src, "You put " .. tostring(count) .. " bags out for delivery.", "success")
	else
		TriggerClientEvent('RLCore:Notify', src, "You don't have any bags for that.", "error")
	end
end)

RegisterServerEvent('rl-jobs:server:startFromDelivery')
AddEventHandler('rl-jobs:server:startFromDelivery', function(job)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	local count = jobDeliverys[job] ~= nil and jobDeliverys[job].count or 0

	if count >= 1 then
		jobDeliverys[job].count = jobDeliverys[job].count - 1
		xPlayer.Functions.AddItem(Config.Jobs[job]['settings'].bag_item, 1)
		TriggerClientEvent("rl-jobs:client:startDelivery", src, job)
		TriggerClientEvent('RLCore:Notify', src, "You took a bag out to deliver.", "success")
	else
		TriggerClientEvent('RLCore:Notify', src, "There are no deliveries.", "error")
	end
end)

RegisterServerEvent('rl-jobs:server:dropoff')
AddEventHandler('rl-jobs:server:dropoff', function(job)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	local jobitem = Config.Jobs[job]['settings'].bag_item
	local count = xPlayer.Functions.GetItemByName(jobitem).amount

	if count >= 1 then
		local money = math.random(Config.Jobs[job]['settings'].payment[1], Config.Jobs[job]['settings'].payment[2])
		xPlayer.Functions.AddMoney('cash', math.floor(money * 0.65))
		xPlayer.Functions.RemoveItem(jobitem, count)
		TriggerClientEvent('RLCore:Notify', src, "Drop Off Completed", "success")
		TriggerEvent("bb-bossmenu:server:addAccountMoney", job, math.floor(money * 0.35))
	else
		TriggerClientEvent('RLCore:Notify', src, "Dropoff failed", "error")
	end
end)

RegisterServerEvent('rl-jobs:server:addItem')
AddEventHandler('rl-jobs:server:addItem', function(item, count)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	xPlayer.Functions.AddItem(item, count)

	TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items[item], "add")
end)

RegisterServerEvent('rl-jobs:server:removeItem')
AddEventHandler('rl-jobs:server:removeItem', function(item, count)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	xPlayer.Functions.RemoveItem(item, count)

	TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items[item], "remove")
end)

RLCore.Functions.CreateCallback('rl-jobs:server:getItemCount', function(source, cb, item, count)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	local qu = xPlayer.Functions.GetItemByName(item) ~= nil and xPlayer.Functions.GetItemByName(item).amount or 0
    if qu ~= nil and tonumber(qu) >= count then
        cb(true)
    else
        cb(false)
    end
end)