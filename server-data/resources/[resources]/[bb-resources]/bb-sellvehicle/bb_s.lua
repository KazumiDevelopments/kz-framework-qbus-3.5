--[[
    BarBaroNN's Sell Vehicles, Made by BarBaroNN#0006.
    All rights reserved.
]]--

RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)


RLCore.Functions.CreateCallback('bb-sellveh:checkOwner', function(source, cb, plate)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local citizenid = xPlayer.PlayerData['citizenid']
    --local fixedplate = plate:gsub(" ", "")
    exports['ghmattimysql']:execute("SELECT * FROM `bbvehicles` WHERE `citizenid` = '" .. citizenid .. "' AND `plate` = '" .. plate .. "'", {}, function(results)
        cb(#results > 0)
    end)
end)

RegisterServerEvent('bb-sellveh:transferVehicle')
AddEventHandler('bb-sellveh:transferVehicle', function(plate, sellerID, amount)
    local buyer, seller = source, sellerID
    local xBuyer, xSeller = RLCore.Functions.GetPlayer(buyer), RLCore.Functions.GetPlayer(seller)
    local buyerCitizenID = xBuyer.PlayerData['citizenid']
    local buyerIdentifier = GetPlayerIdentifiers(source)[1]
    --local fixedplate = plate:gsub(" ", "")

    xBuyer.Functions.RemoveMoney('cash', amount)
    xSeller.Functions.AddMoney('cash', amount)

    TriggerEvent('bb-logs:server:createLog', 'sellvehicle', 'Vehicle boughted', "**[Plate]** " .. plate .. ' **[Seller]** ' .. GetPlayerName(sellerID) .. ' **[Price]** ' .. amount, buyer)

    exports['ghmattimysql']:execute("UPDATE `bbvehicles` SET `citizenid` = '" .. buyerCitizenID .. "' WHERE `plate` = '" .. plate .. "'", {}, function(rows)
        print(rows)
    end)
	
    TriggerClientEvent('RLCore:Notify', seller, 'Someone bought your car!')
end)

RLCore.Functions.CreateCallback('bb-sellveh:checkMoney', function(source, cb, count)
    local xPlayer = RLCore.Functions.GetPlayer(source)
    local money = xPlayer.PlayerData['money']['cash']
    if money ~= nil then
        if money >= count then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterServerEvent('bb-sellveh:updateList')
AddEventHandler('bb-sellveh:updateList', function(plate, name, model, price, vehicle)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent('bb-sellveh:client:updateList', -1, plate, name, model, price, vehicle, tonumber(src), xPlayer.PlayerData['citizenid'])
    TriggerEvent('bb-logs:server:createLog', 'sellvehicle', 'Vehicle added to the list', "**[Plate]** " .. plate .. ' **[Model]** ' .. model .. ' **[Price]** ' .. price, src)
end)

RegisterServerEvent('bb-sellveh:removeList')
AddEventHandler('bb-sellveh:removeList', function(plate, canceled)
    TriggerClientEvent('bb-sellveh:client:removeList', -1, plate)
    if canceled then
        TriggerEvent('bb-logs:server:createLog', 'sellvehicle', 'Vehicle removed from the list', "**[Plate]** " .. plate, source)
    end
end)

RLCore.Commands.Add("sellvehicle", "Sell owned vehicle", {{name="price", help="Price to sell"}}, false, function(source, args)
    local price = tonumber(args[1])
    TriggerClientEvent('bb-sellveh:client:sellvehicle', source, price)
end)