local VehicleList = {}

RLCore.Functions.CreateCallback('vehiclekeys:CheckHasKey', function(source, cb, plate, vehicle)
    local Player = RLCore.Functions.GetPlayer(source)
    cb(CheckOwner(plate, Player.PlayerData.citizenid, vehicle))
end)

RegisterServerEvent('vehiclekeys:server:SetVehicleOwner')
AddEventHandler('vehiclekeys:server:SetVehicleOwner', function(plate, vehicle)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if VehicleList ~= nil then
        if DoesPlateExist(plate, vehicle) then
            for k, val in pairs(VehicleList) do
                if val.plate == plate then
                    table.insert(VehicleList[k].owners, Player.PlayerData.citizenid)
                end
            end
        else
            local vehicleId = #VehicleList+1
            VehicleList[vehicleId] = {
                plate = plate, 
                vehicle = vehicle,
                owners = {},
            }
            VehicleList[vehicleId].owners[1] = Player.PlayerData.citizenid
        end
    else
        local vehicleId = #VehicleList+1
        VehicleList[vehicleId] = {
            plate = plate, 
            vehicle = vehicle,
            owners = {},
        }
        VehicleList[vehicleId].owners[1] = Player.PlayerData.citizenid
    end
end)

RegisterServerEvent('vehiclekeys:server:GiveVehicleKeys')
AddEventHandler('vehiclekeys:server:GiveVehicleKeys', function(plate, target)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if CheckOwner(plate, Player.PlayerData.citizenid) then
        if RLCore.Functions.GetPlayer(target) ~= nil then
            TriggerClientEvent('vehiclekeys:client:SetOwner', target, plate)
            TriggerClientEvent('RLCore:Notify', src, "You just gave keys to your vehicles!")
            TriggerClientEvent('RLCore:Notify', target, "You just received keys to a vehicle!")
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player is not online!")
        end
    else
        TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "You have no keys to this vehicle!")
    end
end)

RLCore.Commands.Add("motor", "Toggle engine on / off the vehicle", {}, false, function(source, args)
	TriggerClientEvent('vehiclekeys:client:ToggleEngine', source)
end)

RLCore.Commands.Add("givekeys", "Give keys to a vehicle", {}, true, function(source, args)
	local src = source
    TriggerClientEvent('vehiclekeys:client:GiveKeys', src)
end)

function DoesPlateExist(plate, vehicle)
    if VehicleList ~= nil then
        for k, val in pairs(VehicleList) do
            if val.vehicle == vehicle then
                return true
            end
        end
    end
    return false
end

function CheckOwner(plate, identifier, vehicle)
    local retval = false
    if VehicleList ~= nil then
        for k, val in pairs(VehicleList) do
            if (val.vehicle ~= nil and val.vehicle == vehicle) or val.plate == plate then
                for key, owner in pairs(VehicleList[k].owners) do
                    if owner == identifier then
                        retval = true
                    end
                end
            end
        end
    end
    return retval
end

RLCore.Functions.CreateUseableItem("lockpick", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("lockpicks:UseLockpick", source, false)
end)

RLCore.Functions.CreateUseableItem("advancedlockpick", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("lockpicks:UseLockpick", source, true)
end)