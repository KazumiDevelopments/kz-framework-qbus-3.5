RLCore = nil
Timers = {}

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function()
	local src = source
    local Player = RLCore.Functions.GetPlayer(src)

	if Timers[src] and Timers[src]+(1000 * 60 * 30) >= GetGameTimer() then
		TriggerClientEvent("rl-oxyruns:client:nope", src)
		return
	end

	if Player.PlayerData.money.cash >= Config.StartOxyPayment then
		Timers[src] = GetGameTimer()
		Player.Functions.RemoveMoney("cash", Config.StartOxyPayment)
		--TriggerEvent("bb-bossmenu:server:addAccountMoney", "drugdealer", 2500)
		TriggerClientEvent("oxydelivery:startDealing", src)
		TriggerClientEvent("rl-oxyruns:client:AcceptBribe", src)
		--PerformHttpRequest('WEBHOOK_HERE', function(err, text, headers) end, 'POST', json.encode({username = "Oxy Runs Log", content = "__**" .. GetPlayerName(source) .. "**__ Started Oxy Run"}), { ['Content-Type'] = 'application/json' })
	else
		TriggerClientEvent('RLCore:Notify', src, 'Not enough money.', 'error')
	end
end)

RegisterServerEvent('oxydelivery:receiveBigRewarditem')
AddEventHandler('oxydelivery:receiveBigRewarditem', function()
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	Player.Functions.AddItem("security_card_03", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["security_card_03"], "add")
end)

RegisterServerEvent('oxy:server:doathing')
AddEventHandler('oxy:server:doathing', function()
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	Player.Functions.AddMoney("cash", 2500)
end)

RegisterServerEvent('oxydelivery:receiveoxy')
AddEventHandler('oxydelivery:receiveoxy', function()
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	local oxy = math.random(1, 5)

	Player.Functions.AddItem("oxy", oxy)
	TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["oxy"], "add")
end)

local DoorLocked = true
RegisterServerEvent('rl-oxyruns:server:doorState')
AddEventHandler('rl-oxyruns:server:doorState', function(bool)
	if bool == nil then
		TriggerClientEvent('rl-oxyruns:client:doorState', source, DoorLocked)
		return
	end

	DoorLocked = bool
	TriggerClientEvent('rl-oxyruns:client:doorState', -1, DoorLocked)
end)