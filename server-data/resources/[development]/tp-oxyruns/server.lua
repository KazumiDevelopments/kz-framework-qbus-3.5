RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

-- Oxy Run
RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function()
	local xPlayer = RLCore.Functions.GetPlayer(source)
	local money   = xPlayer.PlayerData.money['cash'] 

	if money >= Config.StartOxyPayment then
		xPlayer.Functions.RemoveMoney('cash',Config.StartOxyPayment) 
		TriggerClientEvent("banking:removeBalance", source, Config.StartOxyPayment)
		
		TriggerClientEvent("oxydelivery:startDealing", source)
	else
		TriggerClientEvent('RLCore:Notify', source, 'You dont have enough money to start an oxy run')
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough money to start an oxy run', length = 10000})
	end
end)

RegisterServerEvent('oxydelivery:receiveBigRewarditem')
AddEventHandler('oxydelivery:receiveBigRewarditem', function()
	local xPlayer = RLCore.Functions.GetPlayer(source)

	xPlayer.Functions.AddItem("security_card_01", Config.OxyAmount)
    TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items['security_card_01'], "add")
end)

RegisterServerEvent('oxydelivery:receiveoxy')
AddEventHandler('oxydelivery:receiveoxy', function()
	local xPlayer = RLCore.Functions.GetPlayer(source)
	xPlayer.Functions.AddMoney('cash',Config.Payment)
	Citizen.Wait(100)
	xPlayer.Functions.AddItem("oxy", Config.OxyAmount)
    TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items['oxy'], "add")
	TriggerClientEvent('RLCore:Notify', source, 'You were handed $'..Config.Payment.. 'and some oxy!')
end)

RegisterServerEvent('oxydelivery:receivemoneyyy')
AddEventHandler('oxydelivery:receivemoneyyy', function()
	local xPlayer = RLCore.Functions.GetPlayer(source)
	TriggerClientEvent('RLCore:Notify', source, 'You were handed $'..Config.Payment)
	xPlayer.Functions.AddMoney("cash", Config.Payment)
end)