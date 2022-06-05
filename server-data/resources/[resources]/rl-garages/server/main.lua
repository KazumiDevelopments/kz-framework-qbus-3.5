RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local OutsideVehicles = {}

RegisterServerEvent('rl-garages:server:RemoveVehicle')
AddEventHandler('rl-garages:server:RemoveVehicle', function(CitizenId, Plate)
    if OutsideVehicles[CitizenId] ~= nil then
        OutsideVehicles[CitizenId][Plate] = nil
    end
end)

RegisterServerEvent('rl-garages:server:UpdateOutsideVehicles')
AddEventHandler('rl-garages:server:UpdateOutsideVehicles', function(Vehicles)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)
    local CitizenId = Ply.PlayerData.citizenid

    OutsideVehicles[CitizenId] = Vehicles
end)

RegisterServerEvent('bb-garages:server:updateProps')
AddEventHandler('bb-garages:server:updateProps', function(props)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    RLCore.Functions.ExecuteSql(false, "UPDATE `bbvehicles` SET `stats` = '" .. json.encode(stats) .. "', `state` = 'garage', `parking` = '" .. json.encode(jsonz) .. "' WHERE `citizenid` = '" .. xPlayer.PlayerData.citizenid .. "' AND `plate` = '" .. plate .. "'")
    RLCore.Functions.ExecuteSql(false, "UPDATE `bbvehicles` (`props`) VALUES ('" .. xPlayer.PlayerData.citizenid .. "', '" .. props.plate .. "', '" .. model .. "', '" .. json.encode(props) .. "', '" .. json.encode(stats) .. "', 'unknown')")
end)

RLCore.Functions.CreateCallback("rl-garage:server:GetOutsideVehicles", function(source, cb)
    local Ply = RLCore.Functions.GetPlayer(source)
    local CitizenId = Ply.PlayerData.citizenid

    if OutsideVehicles[CitizenId] ~= nil and next(OutsideVehicles[CitizenId]) ~= nil then
        cb(OutsideVehicles[CitizenId])
    else
        cb(nil)
    end
end)

RLCore.Functions.CreateCallback("rl-garage:server:GetUserVehicles", function(source, cb, garage)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)

    exports['ghmattimysql']:execute('SELECT * FROM bbvehicles WHERE citizenid = @citizenid AND garage = @garage', {['@citizenid'] = pData.PlayerData.citizenid, ['@garage'] = garage}, function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                if v.status ~= nil then
                    v.status = json.decode(v.status)
                end
            end
            cb(result)
        else
            cb(nil)
        end
    end)
end)

RLCore.Functions.CreateCallback("rl-garage:server:GetVehicleProperties", function(source, cb, plate)
    local src = source
    local properties = {}
    RLCore.Functions.ExecuteSql(false, "SELECT `mods` FROM `bbvehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            properties = json.decode(result[1].mods)
        end
        cb(properties)
    end)
end)

RLCore.Functions.CreateCallback("rl-garage:server:GetDepotVehicles", function(source, cb)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)

    exports['ghmattimysql']:execute('SELECT * FROM bbvehicles WHERE citizenid = @citizenid AND state = @state', {['@citizenid'] = pData.PlayerData.citizenid, ['@state'] = 0}, function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                if v.props ~= nil then
                    v.props = json.decode(v.props)
                end
            end
            cb(result)
        else
            cb(nil)
        end
    end)
end)

RLCore.Functions.CreateCallback("rl-garage:server:GetHouseVehicles", function(source, cb, house)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)

    exports['ghmattimysql']:execute('SELECT * FROM bbvehicles WHERE garage = @garage', {['@garage'] = house}, function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                if v.status ~= nil then
                    v.status = json.decode(v.status)
                end
            end
            cb(result)
        else
            cb(nil)
        end
    end)
end)

RLCore.Functions.CreateCallback("rl-garage:server:checkVehicleHouseOwner", function(source, cb, plate, house)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)
    exports['ghmattimysql']:execute('SELECT * FROM bbvehicles WHERE plate = @plate', {['@plate'] = plate}, function(result)
        if result[1] ~= nil then
            local hasHouseKey = exports['rl-houses']:hasKey(result[1].steam, result[1].citizenid, house)
            if hasHouseKey then
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    end)
end)

RLCore.Functions.CreateCallback("rl-garage:server:checkVehicleOwner", function(source, cb, plate)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)
    exports['ghmattimysql']:execute('SELECT * FROM bbvehicles WHERE plate = @plate', {['@plate'] = plate}, function(result)
        if result[1] ~= nil then
            if result then
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    end)
end)

RegisterServerEvent('rl-garage:server:PayDepotPrice')
AddEventHandler('rl-garage:server:PayDepotPrice', function(vehicle, garage)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local bankBalance = Player.PlayerData.money["bank"]
    exports['ghmattimysql']:execute('SELECT * FROM bbvehicles WHERE plate = @plate', {['@plate'] = vehicle.plate}, function(result)
        if result[1] ~= nil then
            if Player.Functions.RemoveMoney("cash", result[1].depotprice, "paid-depot") then
                TriggerClientEvent("rl-garages:client:takeOutDepot", src, vehicle, garage)
            elseif bankBalance >= result[1].depotprice then
                Player.Functions.RemoveMoney("bank", result[1].depotprice, "paid-depot")
                TriggerClientEvent("rl-garages:client:takeOutDepot", src, vehicle, garage)
            end
        end
    end)
end)

RegisterServerEvent('rl-garage:server:updateVehicleState')
AddEventHandler('rl-garage:server:updateVehicleState', function(state, plate, garage)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)

    exports['ghmattimysql']:execute('UPDATE bbvehicles SET state = @state, garage = @garage, depotprice = @depotprice WHERE plate = @plate', {['@state'] = state, ['@plate'] = plate, ['@depotprice'] = 0, ['@citizenid'] = pData.PlayerData.citizenid, ['@garage'] = garage})
end)

RegisterServerEvent('rl-garage:server:updateComponents')
AddEventHandler('rl-garage:server:updateComponents', function(components, plate, garage)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)

    exports['ghmattimysql']:execute('UPDATE bbvehicles SET props = @props WHERE plate = @plate AND citizenid = @citizenid AND garage = @garage', {
        ['@props'] = json.encode(components),
        ['@plate'] = plate,
        ['@garage'] = garage,
        ['@citizenid'] = pData.PlayerData.citizenid
    })
end)

RLCore.Functions.CreateCallback('bb-garages:server:hasFines', function(source, cb)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '" .. xPlayer.PlayerData.citizenid .. "'", function(result)
        if result[1] ~= nil and #result > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RegisterServerEvent('bb-garages:server:setVehicleOwned')
AddEventHandler('bb-garages:server:setVehicleOwned', function(props, stats, model)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    RLCore.Functions.ExecuteSql(false, "INSERT INTO `bbvehicles` (`citizenid`, `plate`, `model`, `props`, `stats`, `state`) VALUES ('" .. xPlayer.PlayerData.citizenid .. "', '" .. props.plate .. "', '" .. model .. "', '" .. json.encode(props) .. "', '" .. json.encode(stats) .. "', 'unknown')")
end)