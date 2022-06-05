RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RLCore.Commands.Add("tow", "Tow a vehicle on the back of your flatbed", {}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "tow" then
        TriggerClientEvent("rl-tow:client:TowVehicle", source)
    end
end)