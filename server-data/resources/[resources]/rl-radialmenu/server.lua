RLCore = nil
TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    

local trunkBusy = {}

RegisterServerEvent('rl-trunk:server:setTrunkBusy')
AddEventHandler('rl-trunk:server:setTrunkBusy', function(plate, busy)
    trunkBusy[plate] = busy
end)

RLCore.Functions.CreateCallback('rl-trunk:server:getTrunkBusy', function(source, cb, plate)
    if trunkBusy[plate] then
        cb(true)
    end
    cb(false)
end)

RegisterServerEvent('rl-trunk:server:KidnapTrunk')
AddEventHandler('rl-trunk:server:KidnapTrunk', function(targetId, closestVehicle)
    TriggerClientEvent('rl-trunk:client:KidnapGetIn', targetId, closestVehicle)
end)

RegisterNetEvent('vehicle:flipit')
AddEventHandler('vehicle:flipit', function()
	TriggerClientEvent('vehicle:flipit')
end)

RegisterNetEvent('police:server:AddWep')
AddEventHandler('police:server:AddWep', function(p)
    local blacky = RLCore.Functions.GetPlayer(source)
    if blacky.PlayerData.job.name == "police" then
        RLCore.AddLicence(p, 'weapon1')
        TriggerClientEvent('RLCore:Notify', p, "You Have Been Given A Weapons Licence!")
    else
        RLCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', 'Why u tryna add a weapons licence?', 2145913200, '"..GetPlayerName(src).."')")
        DropPlayer(source, "Why u tryna add a weapons licence?")
        TriggerEvent('banCheater', source, "Why u tryna add a weapons licence?")
    end
end)