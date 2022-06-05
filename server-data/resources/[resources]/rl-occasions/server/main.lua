RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RLCore.Functions.CreateCallback('rl-occasions:server:getVehicles', function(source, cb)
    RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `occasion_vehicles`', function(result)
        if result[1] ~= nil then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

RLCore.Functions.CreateCallback("rl-garage:server:checkVehicleOwner", function(source, cb, plate)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)

    exports['ghmattimysql']:execute('SELECT * FROM player_vehicles WHERE plate = @plate AND citizenid = @citizenid', {['@plate'] = plate, ['@citizenid'] = pData.PlayerData.citizenid}, function(result)
        if result[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RLCore.Functions.CreateCallback("rl-occasions:server:getSellerInformation", function(source, cb, citizenid)
    local src = source

    exports['ghmattimysql']:execute('SELECT * FROM players WHERE citizenid = @citizenid', {['@citizenid'] = citizenid}, function(result)
        if result[1] ~= nil then
            cb(result[1])
        else
            cb(nil)
        end
    end)
end)

RegisterServerEvent('rl-occasions:server:ReturnVehicle')
AddEventHandler('rl-occasions:server:ReturnVehicle', function(vehicleData)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `occasion_vehicles` WHERE `plate` = '"..vehicleData['plate'].."' AND `occasionid` = '"..vehicleData["oid"].."'", function(result)
        if result[1] ~= nil then 
            if result[1].seller == Player.PlayerData.citizenid then
                RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`) VALUES ('"..Player.PlayerData.steam.."', '"..Player.PlayerData.citizenid.."', '"..vehicleData["model"].."', '"..GetHashKey(vehicleData["model"]).."', '"..vehicleData["mods"].."', '"..vehicleData["plate"].."', '0')")
                RLCore.Functions.ExecuteSql(false, "DELETE FROM `occasion_vehicles` WHERE `occasionid` = '"..vehicleData["oid"].."' and `plate` = '"..vehicleData['plate'].."'")
                TriggerClientEvent("rl-occasions:client:ReturnOwnedVehicle", src, result[1])
                TriggerClientEvent('rl-occasion:client:refreshVehicles', -1)
            else
                TriggerClientEvent('RLCore:Notify', src, 'This is not your vehicle...', 'error', 3500)
            end
        else
            TriggerClientEvent('RLCore:Notify', src, 'Vehicle does not exist...', 'error', 3500)
        end
    end)
end)

RegisterServerEvent('rl-occasions:server:sellVehicle')
AddEventHandler('rl-occasions:server:sellVehicle', function(vehiclePrice, vehicleData)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    RLCore.Functions.ExecuteSql(true, "DELETE FROM `player_vehicles` WHERE `plate` = '"..vehicleData.plate.."' AND `vehicle` = '"..vehicleData.model.."'")
    RLCore.Functions.ExecuteSql(true, "INSERT INTO `occasion_vehicles` (`seller`, `price`, `description`, `plate`, `model`, `mods`, `occasionid`) VALUES ('"..Player.PlayerData.citizenid.."', '"..vehiclePrice.."', '"..escapeSqli(vehicleData.desc).."', '"..vehicleData.plate.."', '"..vehicleData.model.."', '"..json.encode(vehicleData.mods).."', '"..generateOID().."')")
    
    TriggerEvent("rl-log:server:sendLog", Player.PlayerData.citizenid, "vehiclesold", {model=vehicleData.model, vehiclePrice=vehiclePrice})
    TriggerEvent("bb-logs:server:createLog", "vehicleshop", "Vehicle for sale", "red", "**"..GetPlayerName(src) .. "** heeft een " .. vehicleData.model .. " te koop gezet voor "..vehiclePrice)

    TriggerClientEvent('rl-occasion:client:refreshVehicles', -1)
end)

RegisterServerEvent('rl-occasions:server:buyVehicle')
AddEventHandler('rl-occasions:server:buyVehicle', function(vehicleData)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `occasion_vehicles` WHERE `plate` = '"..vehicleData['plate'].."' AND `occasionid` = '"..vehicleData["oid"].."'", function(result)
        if result[1] ~= nil and next(result[1]) ~= nil then
            if Player.PlayerData.money.cash >= result[1].price then
                local SellerCitizenId = result[1].seller
                local SellerData = RLCore.Functions.GetPlayerByCitizenId(SellerCitizenId)
                -- New price calculation minus tax
                local NewPrice = math.ceil((result[1].price / 100) * 77)

                Player.Functions.RemoveMoney('cash', result[1].price)

                -- Insert vehicle for buyer
                RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`) VALUES ('"..Player.PlayerData.steam.."', '"..Player.PlayerData.citizenid.."', '"..result[1].model.."', '"..GetHashKey(result[1].model).."', '"..result[1].mods.."', '"..result[1].plate.."', '0')")
                
                -- Handle money transfer
                if SellerData ~= nil then
                    -- Add money for online
                    SellerData.Functions.AddMoney('bank', NewPrice)
                else
                    -- Add money for offline
                    RLCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..SellerCitizenId.."'", function(BuyerData)
                        if BuyerData[1] ~= nil then
                            local BuyerMoney = json.decode(BuyerData[1].money)
                            BuyerMoney.bank = BuyerMoney.bank + NewPrice
                            RLCore.Functions.ExecuteSql(false, "UPDATE `players` SET `money` = '"..json.encode(BuyerMoney).."' WHERE `citizenid` = '"..SellerCitizenId.."'")
                        end
                    end)
                end

                TriggerEvent("rl-log:server:sendLog", Player.PlayerData.citizenid, "vehiclebought", {model = result[1].model, from = SellerCitizenId, moneyType = "cash", vehiclePrice = result[1].price, plate = result[1].plate})
                TriggerEvent("bb-logs:server:createLog", "vehicleshop", "Bought occasion", "green", "**"..GetPlayerName(src) .. "** has bought an occasian for "..result[1].price .. " (" .. result[1].plate .. ") van **"..SellerCitizenId.."**")
                TriggerClientEvent('rl-occasion:client:refreshVehicles', -1)
            
                -- Delete vehicle from Occasion
                RLCore.Functions.ExecuteSql(false, "DELETE FROM `occasion_vehicles` WHERE `plate` = '"..result[1].plate.."' and `occasionid` = '"..result[1].occasionid.."'")

                -- Send selling mail to seller
                TriggerEvent('rl-phone:server:sendNewMailToOffline', SellerCitizenId, {
                    sender = "Mosleys Occasions",
                    subject = "You have sold a vehicle!",
                    message = RLCore.Shared.Vehicles[result[1].model].name.." is sold for $"..result[1].price..",-!"
                })
            elseif Player.PlayerData.money.bank >= result[1].price then
                local SellerCitizenId = result[1].seller
                local SellerData = RLCore.Functions.GetPlayerByCitizenId(SellerCitizenId)
                -- New price calculation minus tax
                local NewPrice = math.ceil((result[1].price / 100) * 77)

                Player.Functions.RemoveMoney('bank', result[1].price)

                -- Insert vehicle for buyer
                RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`) VALUES ('"..Player.PlayerData.steam.."', '"..Player.PlayerData.citizenid.."', '"..result[1].model.."', '"..GetHashKey(result[1].model).."', '"..result[1].mods.."', '"..result[1].plate.."', '0')")
                
                -- Handle money transfer
                if SellerData ~= nil then
                    -- Add money for online
                    SellerData.Functions.AddMoney('bank', NewPrice)
                else
                    -- Add money for offline
                    RLCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..SellerCitizenId.."'", function(BuyerData)
                        if BuyerData[1] ~= nil then
                            local BuyerMoney = json.decode(BuyerData[1].money)
                            BuyerMoney.bank = BuyerMoney.bank + NewPrice
                            RLCore.Functions.ExecuteSql(false, "UPDATE `players` SET `money` = '"..json.encode(BuyerMoney).."' WHERE `citizenid` = '"..SellerCitizenId.."'")
                        end
                    end)
                end

                TriggerEvent("rl-log:server:sendLog", Player.PlayerData.citizenid, "vehiclebought", {model = result[1].model, from = SellerCitizenId, moneyType = "cash", vehiclePrice = result[1].price, plate = result[1].plate})
                TriggerEvent("bb-logs:server:createLog", "vehicleshop", "Occasion gekocht", "green", "**"..GetPlayerName(src) .. "** heeft een occasian gekocht voor "..result[1].price .. " (" .. result[1].plate .. ") van **"..SellerCitizenId.."**")
                TriggerClientEvent('rl-occasion:client:refreshVehicles', -1)
            
                -- Delete vehicle from Occasion
                RLCore.Functions.ExecuteSql(false, "DELETE FROM `occasion_vehicles` WHERE `plate` = '"..result[1].plate.."' and `occasionid` = '"..result[1].occasionid.."'")

                -- Send selling mail to seller
                TriggerEvent('rl-phone:server:sendNewMailToOffline', SellerCitizenId, {
                    sender = "Mosleys Occasions",
                    subject = "U heeft een voertuig verkocht!",
                    message = "Je "..RLCore.Shared.Vehicles[result[1].model].name.." is verkocht voor $"..result[1].price..",-!"
                })
            else
                TriggerClientEvent('RLCore:Notify', src, 'You do not have enough money..', 'error', 3500)
            end
        end
    end)
end)

function generateOID()
    local num = math.random(1, 10)..math.random(111, 999)

    return "OC"..num
end

function round(number)
    return number - (number % 1)
end

function escapeSqli(str)
    local replacements = { ['"'] = '\\"', ["'"] = "\\'" }
    return str:gsub( "['\"]", replacements ) -- or string.gsub( source, "['\"]", replacements )
end