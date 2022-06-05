RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

-- Code

RLCore.Commands.Add("binds", "Open commandbinding menu", {}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
	TriggerClientEvent("rl-commandbinding:client:openUI", source)
end)

RegisterServerEvent('rl-commandbinding:server:setKeyMeta')
AddEventHandler('rl-commandbinding:server:setKeyMeta', function(keyMeta)
    local src = source
    local ply = RLCore.Functions.GetPlayer(src)

    ply.Functions.SetMetaData("commandbinds", keyMeta)
end)