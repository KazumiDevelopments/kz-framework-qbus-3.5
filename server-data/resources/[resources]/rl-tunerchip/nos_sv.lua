RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local VehicleNitrous = {}

RLCore.Functions.CreateUseableItem('nitrous', function(source)
    TriggerClientEvent('smallresource:client:LoadNitrous', source)
end)

RLCore.Functions.CreateCallback('nitrous:GetNosLoadedVehs', function(source, cb)
    cb(VehicleNitrous)
end)

RegisterServerEvent('nitrous:server:LoadNitrous')
AddEventHandler('nitrous:server:LoadNitrous', function(Plate)
    VehicleNitrous[Plate] = {
        hasnitro = true,
        level = 100,
    }
    TriggerClientEvent('nitrous:client:LoadNitrous', -1, Plate)
end)

RegisterServerEvent('nitrous:server:SyncFlames')
AddEventHandler('nitrous:server:SyncFlames', function(netId)
    TriggerClientEvent('nitrous:client:SyncFlames', -1, netId, source)
end)

RegisterServerEvent('removenitro')
AddEventHandler('removenitro', function()
    local src = source
    local ply = RLCore.Functions.GetPlayer(src)
    ply.Functions.RemoveItem('nitrous', 1)
end)

RegisterServerEvent('nitrous:server:UnloadNitrous')
AddEventHandler('nitrous:server:UnloadNitrous', function(Plate)
    VehicleNitrous[Plate] = nil
    TriggerClientEvent('nitrous:client:UnloadNitrous', -1, Plate)
end)

RegisterServerEvent('nitrous:server:UpdateNitroLevel')
AddEventHandler('nitrous:server:UpdateNitroLevel', function(Plate, level)
    VehicleNitrous[Plate].level = level
    TriggerClientEvent('nitrous:client:UpdateNitroLevel', -1, Plate, level)
end)

RegisterServerEvent('nitrous:server:StopSync')
AddEventHandler('nitrous:server:StopSync', function(plate)
    TriggerClientEvent('nitrous:client:StopSync', -1, plate)
end)