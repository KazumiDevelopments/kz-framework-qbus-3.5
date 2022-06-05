local ResetStress = false
RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RLCore.Commands.Add("cash", "Check your cash balance", {}, false, function(source, args)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	TriggerClientEvent('hud:client:ShowMoney', source, xPlayer['PlayerData']['money']['cash'])
end)

RLCore.Commands.Add("bank", "Check your bank balance", {}, false, function(source, args)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	TriggerClientEvent('hud:client:ShowMoney', source, xPlayer['PlayerData']['money']['bank'])
end)

RegisterServerEvent("rl-hud:Server:UpdateStress")
AddEventHandler('rl-hud:Server:UpdateStress', function(StressGain)
	local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] + StressGain
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData("stress", newStress)
		TriggerClientEvent("hud:client:UpdateStress", src, newStress)
	end
end)

RegisterServerEvent('hud:server:GainStress')
AddEventHandler('hud:server:GainStress', function(amount)
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] + amount
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData("stress", newStress)
        TriggerClientEvent("hud:client:UpdateStress", src, newStress)
        TriggerClientEvent('RLCore:Notify', src, 'Stress Gained', 'primary', 1500)
	end
end)

RegisterServerEvent('hud:server:RelieveStress')
AddEventHandler('hud:server:RelieveStress', function(amount)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] - amount
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData("stress", newStress)
        TriggerClientEvent("hud:client:UpdateStress", src, newStress)
        TriggerClientEvent('RLCore:Notify', src, 'Stress Relieved')
	end
end)

RLCore.Functions.CreateCallback('QBCore:HasMoney', function(source, cb, count)
	local retval = false
	local Player = RLCore.Functions.GetPlayer(source)
	if Player ~= nil then 
		if Player.Functions.RemoveMoney('cash', count, true) == true then
			retval = true
		end
	end
	
	cb(retval)
end)