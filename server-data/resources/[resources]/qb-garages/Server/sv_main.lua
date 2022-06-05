local RLCore = exports['rl-core']:GetCoreObject()


local parkingLog = {}
local HouseGarLoc = {}
local OutsideVehicles = {}

RegisterNetEvent('qb-garages:server:houseGarageConfig', function(garageConfig)
    HouseGarLoc = garageConfig
end)

RegisterNetEvent('qb-garages:server:addHouseGarage', function(house, garageInfo)
    HouseGarLoc[house] = garageInfo
end)

RegisterNetEvent('onResourceStart', function(resource)
    Wait(2000)
    if resource == GetCurrentResourceName() then	
        exports.ghmattimysql:execute('SELECT * FROM shared_vehicles WHERE state = ?', {'Out'}, function(result)
            if result ~= nil then
                local stored = 0
                for i = 1, #result do
                    exports.ghmattimysql:execute('UPDATE shared_vehicles SET state = ? WHERE plate = ?', {'Stored', result[i].plate})
                    stored = i
                end
                print('^2 ['..GetCurrentResourceName()..'] Stored '..stored..' shared vehicles.^7')
            end
        end)
    end
end)

RegisterNetEvent('qb-garage:server:updateVehicleState', function(state, plate, garage)
    exports.ghmattimysql:execute('UPDATE player_vehicles SET state = ?, garage = ?, depotprice = ? WHERE plate = ?', {state, garage, 0, plate})
end)

RegisterNetEvent('qb-garage:server:updateSharedVehState', function(state, plate, garage)
    exports.ghmattimysql:execute('UPDATE shared_vehicles SET state = ?, garage = ? WHERE plate = ?', {state, garage, plate})
end)

RegisterNetEvent('qb-garage:server:updateVehicleStatus', function(fuel, engine, body, plate, garage, IsShared)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)

    if engine > 1000 then
        engine = engine / 1000
    end

    if body > 1000 then
        body = body / 1000
    end
    if IsShared then
        exports.ghmattimysql:execute('UPDATE shared_vehicles SET fuel = ?, engine = ?, body = ? WHERE plate = ? AND garage = ?', {fuel, engine, body, plate, garage})
    else
        exports.ghmattimysql:execute('UPDATE player_vehicles SET fuel = ?, engine = ?, body = ? WHERE plate = ? AND citizenid = ? AND garage = ?', {fuel, engine, body, plate, pData.PlayerData.citizenid, garage})
    end
end)

RegisterNetEvent('qb-garages:server:SaveSharedVehicle', function(plate, vehicle, category, hash, faction, garage, mods)
    exports.ghmattimysql:execute('INSERT INTO shared_vehicles (plate, vehicle, category, hash, fuel, engine, body, faction, garage, mods) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,?)', {plate, vehicle, category, hash, 100, 1000, 1000, faction, garage, mods})
end)

RegisterNetEvent('qb-garages:server:SaveVehicleMods', function(plate, vehmods, isShared)
    local propeties = json.encode(vehmods)
    if isShared then
        exports.ghmattimysql:execute('UPDATE shared_vehicles SET mods = ? WHERE plate = ?', {propeties, plate})
    else
        exports.ghmattimysql:execute('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {propeties, plate})
    end
end)

RegisterServerEvent('qb-garages:server:modifystate')
AddEventHandler('qb-garages:server:modifystate', function(vehicleProps)
	local plate = vehicleProps.plate
    exports.ghmattimysql:execute('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(vehicleProps), plate})
end)

RegisterNetEvent('qb-garages:server:UpdateParkingLog', function(plate)
    local pData = RLCore.Functions.GetPlayer(source)
    local ctime = os.date('%H:%M %p')
    if parkingLog[plate] == nil then
        parkingLog[plate] =  {{
            id = pData.PlayerData.citizenid,
            name = pData.PlayerData.charinfo.firstname.." "..pData.PlayerData.charinfo.lastname,
            post = pData.PlayerData.job.grade.name,
            time = ctime
        }}
    else
    local log = parkingLog[plate]
    table.insert(log, {
        id = pData.PlayerData.citizenid,
        name = pData.PlayerData.charinfo.firstname.." "..pData.PlayerData.charinfo.lastname,
        post = pData.PlayerData.job.grade.name,
        time = ctime 
    })
    end
end)

RegisterNetEvent('qb-garages:server:UpdateOutsideVehicles', function(Vehicles)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)
    local CitizenId = Ply.PlayerData.citizenid

    OutsideVehicles[CitizenId] = Vehicles
end)

RLCore.Functions.CreateCallback("qb-garage:server:GetOutsideVehicles", function(source, cb)
    local Ply = RLCore.Functions.GetPlayer(source)
    local CitizenId = Ply.PlayerData.citizenid

    if OutsideVehicles[CitizenId] ~= nil and next(OutsideVehicles[CitizenId]) ~= nil then
        cb(OutsideVehicles[CitizenId])
    else
        cb(nil)
    end
end)

RLCore.Functions.CreateCallback('qb-garages:server:GetPlayerVehicles', function(source, cb, garage)
    local citizenid = RLCore.Functions.GetPlayer(source).PlayerData.citizenid
    exports.ghmattimysql:execute('SELECT * FROM player_vehicles WHERE citizenid = ? AND garage = ?', {citizenid, garage}, function(result)
        if result[1] ~= nil then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

RLCore.Functions.CreateCallback("qb-garage:server:GetVehicleProperties", function(source, cb, plate, isShared)
    local src = source
    local properties = {}
    if isShared then
        local result = exports.ghmattimysql:executeSync('SELECT mods FROM shared_vehicles WHERE plate = ?', {plate})
        if result[1] ~= nil then
            properties = json.decode(result[1].mods)
        end
    else
        local result = exports.ghmattimysql:executeSync('SELECT mods FROM player_vehicles WHERE plate = ?', {plate})
        if result[1] ~= nil then
            properties = json.decode(result[1].mods)
        end
    end
    cb(properties)
end)

RLCore.Functions.CreateCallback("qb-garage:server:checkVehicleOwner", function(source, cb, plate)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)
    exports.ghmattimysql:execute('SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = ?', {plate, pData.PlayerData.citizenid}, function(result)
        if result[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RLCore.Functions.CreateCallback("qb-garage:server:isVehicleOwned", function(source, cb, plate)
    exports.ghmattimysql:execute('SELECT * FROM player_vehicles WHERE plate = ?', {plate}, function(result)
        if result[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RLCore.Functions.CreateCallback("qb-garage:server:isVehicleShared", function(source, cb, plate)
    exports.ghmattimysql:execute('SELECT * FROM shared_vehicles WHERE plate = ?', {plate}, function(result)
        if result[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)


RLCore.Functions.CreateCallback("qb-garage:server:isSharedVehicle", function(source, cb, plate, garage)
    exports.ghmattimysql:execute('SELECT * FROM shared_vehicles WHERE plate = ? AND garage = ?', {plate, garage}, function(result)
        if result[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RLCore.Functions.CreateCallback('qb-garages:server:GetSharedVehicles', function(source, cb, garage, category)
    exports.ghmattimysql:execute('SELECT * FROM shared_vehicles WHERE garage = ? AND category = ?', {garage, category}, function(result)
        if result[1] ~= nil then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

RLCore.Functions.CreateCallback('qb-garages:server:GetSharedHeli', function(source, cb, garage)
    exports.ghmattimysql:execute('SELECT * FROM shared_vehicles WHERE garage = ?', {garage}, function(result)
        if result[1] ~= nil then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

RLCore.Functions.CreateCallback('qb-garages:server:GetDepotVehicles', function(source, cb)
    local citizenid = RLCore.Functions.GetPlayer(source).PlayerData.citizenid
    exports.ghmattimysql:execute('SELECT * FROM player_vehicles WHERE citizenid = ?', {citizenid}, function(result)
        if result[1] ~= nil then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

RLCore.Functions.CreateCallback("qb-garages:isAtHouseGar", function(source, cb)
    local src = source
    for k, v in pairs(HouseGarLoc) do
        if HouseGarLoc[k].takeVehicle.x ~= nil and HouseGarLoc[k].takeVehicle.y ~= nil and HouseGarLoc[k].takeVehicle.z ~= nil then
            if #(GetEntityCoords(GetPlayerPed(src)) - vector3(HouseGarLoc[k].takeVehicle.x, HouseGarLoc[k].takeVehicle.y, HouseGarLoc[k].takeVehicle.z)) < 5 then
                cb(true)
            end
        end
    end
end)

RLCore.Functions.CreateCallback("qb-garage:server:CheckSharedCategories", function(source, cb, garage)
    local result = exports.ghmattimysql:executeSync('SELECT category FROM shared_vehicles WHERE garage = ?', {garage})
    if result[1] ~= nil then
        cb(result)
    else
        cb(nil)
    end
end)

RLCore.Functions.CreateCallback("qb-garage:server:GetParkingLog", function(source, cb, plate)
    if parkingLog[plate] ~= nil then
        cb(parkingLog[plate])
    else
        cb(nil)
    end
end)

RLCore.Functions.CreateCallback('qb-garage:server:PayDepotPrice', function(source, cb, plate, amount)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local cashBalance = Player.PlayerData.money["cash"]
    local bankBalance = Player.PlayerData.money["bank"]
    if cashBalance >= amount then
        Player.Functions.RemoveMoney("cash", amount, "paid-depot")
        cb(true)
    elseif bankBalance >= amount then
        Player.Functions.RemoveMoney("bank", amount, "paid-depot")
        cb(true)
    else
        TriggerClientEvent('RLCore:Notify', src, "not enough money.", 'error')
        cb(false)
    end
end)

RLCore.Commands.Add("addsv", "Add Vehicle into Shared Garage.", {{name="garage", help="Garage Name"}, {name="faction", help="Vehicle Faction (e.g., police)"}, {name="category", help="Vehicle Category Name (e.g., Charger)"}}, true, function(source, args)
    TriggerClientEvent('qb-garages:client:AddSharedVehicle', source, args[1], args[2], args[3])
end, "admin")
-- Haritha#3955 --
-- Haritha#3955 --
-- Haritha#3955 --
-- Haritha#3955 --
-- Haritha#3955 --