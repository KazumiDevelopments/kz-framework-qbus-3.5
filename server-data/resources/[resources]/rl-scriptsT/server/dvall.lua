RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RLCore.Commands.Add('dvall', 'Delete All Vehicles', {}, false, function(source, args)
    TriggerClientEvent("wld:delallveh", -1)
end, 'god')