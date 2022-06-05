local RLCore = exports['rl-core']:GetCoreObject()


local ResetStress = false

RLCore.Commands.Add("cash", "Check your cash balance", {}, false, function(source, args)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	TriggerClientEvent('hud:client:ShowMoney', source, xPlayer['PlayerData']['money']['cash'])
end)
--[[ 
RLCore.Commands.Add("bank", "Check your bank balance", {}, false, function(source, args)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	TriggerClientEvent('hud:client:ShowMoney', source, xPlayer['PlayerData']['money']['bank'])
end) ]]

RLCore.Commands.Add("dev", "Enable/Disable developer Mode", {}, false, function(source, args)
    TriggerClientEvent("rl-admin:client:ToggleDevmode", source)
end, 'admin')

RegisterNetEvent('hud:server:GainStress', function(amount)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local newStress
    if not Player or (Config.DisablePoliceStress and Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'ambulance') then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] + amount / 2
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    --TriggerClientEvent('RLCore:Notify', src, ("Feeling More Stressed!"), 'error', 1500)
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local newStress
    if not Player then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] - amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    TriggerClientEvent('RLCore:Notify', src, ("Feeling More Relaxed!"))
end)

RLCore.Functions.CreateCallback('hud:server:HasHarness', function(source, cb)
    local Ply = RLCore.Functions.GetPlayer(source)
    local Harness = Ply.Functions.GetItemByName("harness")
    if Harness ~= nil then
        cb(true)
    else
        cb(false)
    end
end)
RLCore.Functions.CreateCallback('hud:server:getMenu', function(source, cb)
    cb(Config.Menu)
end) 
