local RLCore = exports['rl-core']:GetCoreObject()
RLCore.Commands.Add("fix", "Repair your vehicle (Admin Only)", {}, false, function(source)
    TriggerClientEvent('iens:repaira', source)
    TriggerClientEvent('vehiclemod:client:fixEverything', source)
end, "admin")

RLCore.Functions.CreateUseableItem("repairkit", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("qb-vehiclefailure:client:RepairVehicle", source)
    end
end)

RLCore.Functions.CreateUseableItem("cleaningkit", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("qb-vehiclefailure:client:CleanVehicle", source)
    end
end)

RLCore.Functions.CreateUseableItem("advancedrepairkit", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("qb-vehiclefailure:client:RepairVehicleFull", source)
    end
end)

RegisterNetEvent('qb-vehiclefailure:removeItem', function(item)
    local src = source
    local ply = RLCore.Functions.GetPlayer(src)
    ply.Functions.RemoveItem(item, 1)
end)

RegisterNetEvent('qb-vehiclefailure:server:removewashingkit', function(veh)
    local src = source
    local ply = RLCore.Functions.GetPlayer(src)
    ply.Functions.RemoveItem("cleaningkit", 1)
    TriggerClientEvent('qb-vehiclefailure:client:SyncWash', -1, veh)
end)