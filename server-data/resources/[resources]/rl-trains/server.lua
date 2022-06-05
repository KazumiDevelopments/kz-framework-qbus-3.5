RLCore = nil

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

Config = {}
Config.Price = 500
Config.Price2 = 750

RLCore.Functions.CreateCallback("trains:checkMoney", function(source, cb)
	local Player = RLCore.Functions.GetPlayer(source)

	if Player.PlayerData.money.cash >= Config.Price then
		cb(true)
	else
		cb(false)
	end
end)

RLCore.Functions.CreateCallback("trains:checkMoney2", function(source, cb)
	local Player = RLCore.Functions.GetPlayer(source)

	if Player.PlayerData.money.cash >= Price2.Price then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('trains:pay')
AddEventHandler('trains:pay', function()
	local Player = RLCore.Functions.GetPlayer(source)
    local taxprice = Config.Price * 0.15
	Player.Functions.RemoveMoney('cash', Config.Price + taxprice)

	TriggerClientEvent('RLCore:Notify', source, "Paid ".. Config.Price .." $ | Tax: 0.15 % " .. taxprice .. " $")
end)

RegisterServerEvent('trains:pay2')
AddEventHandler('trains:pay2', function()
	local Player = RLCore.Functions.GetPlayer(source)
    local taxprice = Config.Price2 * 0.15
	Player.Functions.RemoveMoney('cash', Config.Price2 + taxprice)

	TriggerClientEvent('RLCore:Notify', source, "Paid ".. Config.Price .." $ | Tax: 0.15 % " .. taxprice .. " $")
end)