RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local VehicleStatus = {}

local VehicleDrivingDistance = {}

RLCore.Functions.CreateCallback('rs-vehicletuning:server:GetDrivingDistances', function(source, cb)
    cb(VehicleDrivingDistance)
end)

RLCore.Functions.CreateCallback('vehiclemod:server:setupVehicleStatus', function(source, cb, plate, engineHealth, bodyHealth)
	local src = source
    local engineHealth = engineHealth ~= nil and engineHealth or 1000.0
    local bodyHealth = bodyHealth ~= nil and bodyHealth or 1000.0
    if VehicleStatus[plate] == nil then 
        if IsVehicleOwned(plate) then
            local statusInfo = GetVehicleStatus(plate)
            if statusInfo == nil then 
                statusInfo =  {
                    ["engine"] = engineHealth,
                    ["body"] = bodyHealth,
                    ["radiator"] = Config.MaxStatusValues["radiator"],
                    ["axle"] = Config.MaxStatusValues["axle"],
                    ["brakes"] = Config.MaxStatusValues["brakes"],
                    ["clutch"] = Config.MaxStatusValues["clutch"],
                    ["fuel"] = Config.MaxStatusValues["fuel"],
                }
            end
            VehicleStatus[plate] = statusInfo
            TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, statusInfo)
        else
            local statusInfo = {
                ["engine"] = engineHealth,
                ["body"] = bodyHealth,
                ["radiator"] = Config.MaxStatusValues["radiator"],
                ["axle"] = Config.MaxStatusValues["axle"],
                ["brakes"] = Config.MaxStatusValues["brakes"],
                ["clutch"] = Config.MaxStatusValues["clutch"],
                ["fuel"] = Config.MaxStatusValues["fuel"],
            }
            VehicleStatus[plate] = statusInfo
            TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, statusInfo)
        end
    else
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RLCore.Functions.CreateCallback('rs-vehicletuning:server:UpdateDrivingDistance', function(source, cb, amount, plate)
	VehicleDrivingDistance[plate] = amount

    TriggerClientEvent('rs-vehicletuning:client:UpdateDrivingDistance', -1, VehicleDrivingDistance[plate], plate)

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `bbvehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            RLCore.Functions.ExecuteSql(false, "UPDATE `bbvehicles` SET `drivingdistance` = '"..amount.."' WHERE `plate` = '"..plate.."'")
        end
    end)
end)

RegisterServerEvent("vehiclemod:server:setupVehicleStatus")
AddEventHandler("vehiclemod:server:setupVehicleStatus", function(plate, engineHealth, bodyHealth)
    RLCore.Functions.BanInjection(source, 'rs-vehicletuning (setupVehicleStatus)')
end)

RegisterServerEvent('rs-vehicletuning:server:UpdateDrivingDistance')
AddEventHandler('rs-vehicletuning:server:UpdateDrivingDistance', function(amount, plate)
    RLCore.Functions.BanInjection(source, 'rs-vehicletuning (UpdateDrivingDistance)')
end)

RLCore.Functions.CreateCallback('rs-vehicletuning:server:IsVehicleOwned', function(source, cb, plate)
    local retval = false
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `bbvehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            retval = true
        end
        cb(retval)
    end)
end)


RLCore.Functions.CreateCallback('rs-vehicletuning:server:LoadStatus', function(source, cb, veh, plate)
	VehicleStatus[plate] = veh
    TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, veh)
end)

RLCore.Functions.CreateCallback('vehiclemod:server:updatePart', function(source, cb, plate, part, level)
	if VehicleStatus[plate] ~= nil then
        if part == "engine" or part == "body" then
            VehicleStatus[plate][part] = level
            if VehicleStatus[plate][part] < 0 then
                VehicleStatus[plate][part] = 0
            elseif VehicleStatus[plate][part] > 1000 then
                VehicleStatus[plate][part] = 1000.0
            end
        else
            VehicleStatus[plate][part] = level
            if VehicleStatus[plate][part] < 0 then
                VehicleStatus[plate][part] = 0
            elseif VehicleStatus[plate][part] > 100 then
                VehicleStatus[plate][part] = 100
            end
        end
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RLCore.Functions.CreateCallback('rs-vehicletuning:server:SetPartLevel', function(source, cb, plate, part, level)
	if VehicleStatus[plate] ~= nil then
        VehicleStatus[plate][part] = level
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RLCore.Functions.CreateCallback('vehiclemod:server:fixEverything', function(source, cb, plate)
	if VehicleStatus[plate] ~= nil then 
        for k, v in pairs(Config.MaxStatusValues) do
            VehicleStatus[plate][k] = v
        end
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RLCore.Functions.CreateCallback('vehiclemod:server:saveStatus', function(source, cb, plate)
	if VehicleStatus[plate] ~= nil then
        exports['ghmattimysql']:execute('UPDATE bbvehicles SET status = @status WHERE plate = @plate', {['@status'] = json.encode(VehicleStatus[plate]), ['@plate'] = plate})
    end
end)

RegisterServerEvent('rs-vehicletuning:server:LoadStatus')
AddEventHandler('rs-vehicletuning:server:LoadStatus', function(veh, plate)
    RLCore.Functions.BanInjection(source, 'rs-vehicletuning (LoadStatus)')
end)

RegisterServerEvent("vehiclemod:server:updatePart")
AddEventHandler("vehiclemod:server:updatePart", function(plate, part, level)
    RLCore.Functions.BanInjection(source, 'rs-vehicletuning (updatePart)')
end)

RegisterServerEvent('rs-vehicletuning:server:SetPartLevel')
AddEventHandler('rs-vehicletuning:server:SetPartLevel', function(plate, part, level)
    RLCore.Functions.BanInjection(source, 'rs-vehicletuning (SetPartLevel)')
end)

RegisterServerEvent("vehiclemod:server:fixEverything")
AddEventHandler("vehiclemod:server:fixEverything", function(plate)
    RLCore.Functions.BanInjection(source, 'rs-vehicletuning (fixEverything)')
end)

RegisterServerEvent("vehiclemod:server:saveStatus")
AddEventHandler("vehiclemod:server:saveStatus", function(plate)
    if VehicleStatus[plate] ~= nil then
        exports['ghmattimysql']:execute('UPDATE bbvehicles SET status = @status WHERE plate = @plate', {['@status'] = json.encode(VehicleStatus[plate]), ['@plate'] = plate})
    end
end)

function IsVehicleOwned(plate)
    local retval = false
    RLCore.Functions.ExecuteSql(true, "SELECT * FROM `bbvehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            retval = true
        end
    end)
    return retval
end

function GetVehicleStatus(plate)
    local retval = nil
    RLCore.Functions.ExecuteSql(true, "SELECT `status` FROM `bbvehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            retval = result[1].status ~= nil and json.decode(result[1].status) or nil
        end
    end)
    return retval
end

RLCore.Commands.Add("setvehiclestatus", "set vehicle status", {{name="part", help="Type of status you want to edit"}, {name="amount", help="Level of status"}}, true, function(source, args)
    local part = args[1]:lower()
    local level = tonumber(args[2])
    TriggerClientEvent("vehiclemod:client:setPartLevel", source, part, level)
end, "god")

RLCore.Functions.CreateCallback('rs-vehicletuning:server:GetAttachedVehicle', function(source, cb)
    cb(Config.Plates)
end)

RLCore.Functions.CreateCallback('rs-vehicletuning:server:IsMechanicAvailable', function(source, cb)
	local amount = 0
	for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "mechanic" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    cb(amount)
end)

RLCore.Functions.CreateCallback('rs-vehicletuning:server:SetAttachedVehicle', function(source, cb, veh, k)
	if veh ~= false then
        Config.Plates[k].AttachedVehicle = veh
        TriggerClientEvent('rs-vehicletuning:client:SetAttachedVehicle', -1, veh, k)
    else
        Config.Plates[k].AttachedVehicle = nil
        TriggerClientEvent('rs-vehicletuning:client:SetAttachedVehicle', -1, false, k)
    end
end)

RLCore.Functions.CreateCallback('rs-vehicletuning:server:CheckForItems', function(source, cb, part)
	local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local RepairPart = Player.Functions.GetItemByName(Config.RepairCostAmount[part].item)

    if RepairPart ~= nil then
        if RepairPart.amount >= Config.RepairCostAmount[part].costs then
            TriggerClientEvent('rs-vehicletuning:client:RepaireeePart', src, part)
            Player.Functions.RemoveItem(Config.RepairCostAmount[part].item, Config.RepairCostAmount[part].costs)

            for i = 1, Config.RepairCostAmount[part].costs, 1 do
                TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items[Config.RepairCostAmount[part].item], "remove")
                Citizen.Wait(500)
            end
        else
            TriggerClientEvent('RLCore:Notify', src, "Je hebt niet genoeg "..RLCore.Shared.Items[Config.RepairCostAmount[part].item]["label"].." (min. "..Config.RepairCostAmount[part].costs.."x)", "error")
        end
    else
        TriggerClientEvent('RLCore:Notify', src, "Je hebt geen "..RLCore.Shared.Items[Config.RepairCostAmount[part].item]["label"].." bij je!", "error")
    end
end)

RegisterServerEvent('rs-vehicletuning:server:SetAttachedVehicle')
AddEventHandler('rs-vehicletuning:server:SetAttachedVehicle', function(veh, k)
    RLCore.Functions.BanInjection(source, 'rs-vehicletuning (SetAttachedVehicle)')
end)

RegisterServerEvent('rs-vehicletuning:server:CheckForItems')
AddEventHandler('rs-vehicletuning:server:CheckForItems', function(part)
    RLCore.Functions.BanInjection(source, 'rs-vehicletuning (CheckForItems)')
end)

function IsAuthorized(CitizenId)
    local retval = false
    for _, cid in pairs(Config.AuthorizedIds) do
        if cid == CitizenId then
            retval = true
            break
        end
    end
    return retval
end

RLCore.Commands.Add("setmechanic", "Geef iemand Mechanic baan", {{name="id", help="ID van de speler"}}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)

    if IsAuthorized(Player.PlayerData.citizenid) then
        local TargetId = tonumber(args[1])
        if TargetId ~= nil then
            local TargetData = RLCore.Functions.GetPlayer(TargetId)
            if TargetData ~= nil then
                TargetData.Functions.SetJob("mechanic")
                TriggerClientEvent('RLCore:Notify', TargetData.PlayerData.source, "hired as Autocare employee!")
                TriggerClientEvent('RLCore:Notify', source, "Je hebt ("..TargetData.PlayerData.charinfo.firstname..") hired as Autocare employee!")
            end
        else
            TriggerClientEvent('RLCore:Notify', source, "You must provide a Player ID!")
        end
    else
        TriggerClientEvent('RLCore:Notify', source, "You cannot do this!", "error") 
    end
end)

RLCore.Commands.Add("takemechanic", "Take someone's Mechanic job off", {{name="id", help="ID of player"}}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)

    if IsAuthorized(Player.PlayerData.citizenid) then
        local TargetId = tonumber(args[1])
        if TargetId ~= nil then
            local TargetData = RLCore.Functions.GetPlayer(TargetId)
            if TargetData ~= nil then
                if TargetData.PlayerData.job.name == "mechanic" then
                    TargetData.Functions.SetJob("unemployed")
                    TriggerClientEvent('RLCore:Notify', TargetData.PlayerData.source, "You have been fired as an Autocare employee!")
                    TriggerClientEvent('RLCore:Notify', source, "Je hebt ("..TargetData.PlayerData.charinfo.firstname..") fired as an Autocare employee!")
                else
                    TriggerClientEvent('RLCore:Notify', source, "This is not an Autocare employee!", "error")
                end
            end
        else
            TriggerClientEvent('RLCore:Notify', source, "You must provide a Player ID!", "error")
        end
    else
        TriggerClientEvent('RLCore:Notify', source, "You cannot do this!", "error")
    end
end)

RLCore.Functions.CreateCallback('rs-vehicletuning:server:GetStatus', function(source, cb, plate)
    if VehicleStatus[plate] ~= nil and next(VehicleStatus[plate]) ~= nil then
        cb(VehicleStatus[plate])
    else
        cb(nil)
    end
end)