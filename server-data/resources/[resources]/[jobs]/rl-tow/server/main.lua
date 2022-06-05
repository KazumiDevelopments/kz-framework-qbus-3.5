RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local PaymentTax = 15
local Bail = {}

RegisterServerEvent('rl-tow:server:DoBail')
AddEventHandler('rl-tow:server:DoBail', function(bool, vehInfo)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    if bool then
        if Player.PlayerData.money.cash >= Config.BailPrice then
            Bail[Player.PlayerData.citizenid] = Config.BailPrice
            Player.Functions.RemoveMoney('cash', Config.BailPrice, "tow-paid-bail")
            TriggerClientEvent('RLCore:Notify', src, 'You have paid the deposit of 1000, -', 'success')
            TriggerClientEvent('rl-tow:client:SpawnVehicle', src, vehInfo)
        elseif Player.PlayerData.money.bank >= Config.BailPrice then
            Bail[Player.PlayerData.citizenid] = Config.BailPrice
            Player.Functions.RemoveMoney('bank', Config.BailPrice, "tow-paid-bail")
            TriggerClientEvent('RLCore:Notify', src, 'You have paid the deposit of 1000, -', 'success')
            TriggerClientEvent('rl-tow:client:SpawnVehicle', src, vehInfo)
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have enough cash, the deposit is 1000, -', 'error')
        end
    else
        if Bail[Player.PlayerData.citizenid] ~= nil then
            Player.Functions.AddMoney('cash', Bail[Player.PlayerData.citizenid], "tow-bail-paid")
            Bail[Player.PlayerData.citizenid] = nil
            TriggerClientEvent('RLCore:Notify', src, 'You got the deposit of 1000, - back', 'success')
        end
    end
end)

RegisterNetEvent('rl-tow:server:11101110')
AddEventHandler('rl-tow:server:11101110', function(drops)
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src)
    local drops = tonumber(drops)
    local bonus = 0
    local DropPrice = math.random(450, 700)
    if drops > 5 then 
        bonus = math.ceil((DropPrice / 100) * 5)
    elseif drops > 10 then
        bonus = math.ceil((DropPrice / 100) * 7)
    elseif drops > 15 then
        bonus = math.ceil((DropPrice / 100) * 10)
    elseif drops > 20 then
        bonus = math.ceil((DropPrice / 100) * 12)
    end
    local price = (DropPrice * drops) + bonus
    local taxAmount = math.ceil((price / 100) * PaymentTax)
    local payment = price - taxAmount

    Player.Functions.AddJobReputation(1)
    Player.Functions.AddMoney("cash", payment, "tow-salary")
    TriggerClientEvent('chat:addMessage', source , {
        template = '<div class="chat-message server"><b>TOW:</b> {0}</div>',
        args = { "You received $"..payment.."" }
    })
end)

RLCore.Commands.Add("npc", "Toggle npc job option", {}, false, function(source, args)
	TriggerClientEvent("jobs:client:ToggleNpc", source)
end)

RLCore.Commands.Add("tow", "Put a carriage on the back of your flatbed", {}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "tow" then
        TriggerClientEvent("rl-tow:client:TowVehicle", source)
    end
end)

RLCore.Commands.Add('repair', 'Repair Vehicle Part (Tow Only)', {{name="part", help="Vehicle Part"},{name="level", help="Fix Level"}}, false, function(source, args)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local part = args[1]
    local level = tonumber(args[2]) ~= nil and tonumber(args[2]) or 10

    if Player and (Player.PlayerData.job.name == 'tow') then
        TriggerClientEvent('rl-tow:client:TriggerRepairs', src, part, level)
    end
    
end)

local trackedVehicles = {}
RegisterServerEvent('rl-tow:updateVehicleDegredationServer')
AddEventHandler('rl-tow:updateVehicleDegredationServer', function(plate,br,ax,rad,cl,tra,elec,fi,ft)
    local src = source

    if plate:gsub(" ", "") == "" then
        return
    end

    local degHealth = {
        ["breaks"] = br,
        ["axle"] = ax,
        ["radiator"] = rad,
        ["clutch"] = cl,
        ["transmission"] = tra,
        ["electronics"] = elec,
        ["fuel_injector"] = fi,
        ["fuel_tank"] = ft 
    }

    trackedVehicles[plate] = degHealth

    RLCore.Functions.ExecuteSql(true, "UPDATE `bbvehicles` SET `parts` = '"..json.encode(degHealth).."' WHERE `plate` = '"..plate.."'", function()
        TriggerClientEvent('rl-tow:getSQL', src, degHealth)
    end)
end)

RegisterServerEvent('rl-tow:callDegredation')
AddEventHandler('rl-tow:callDegredation', function(plate)
    local src = source
    local data = Config.MaxStatusValues

    if trackedVehicles[plate] ~= nil then
        data = trackedVehicles[plate]
    end

    TriggerClientEvent('rl-tow:getSQL', src, data)
end)

RegisterServerEvent('rl-tow:server:fixVehicle')
AddEventHandler('rl-tow:server:fixVehicle', function(plate,degname,amount,itemname, current)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local item = GetItem(src, itemname:lower())

    if item ~= nil and item.amount > (amount < 1 and 1 or math.floor(amount)) then
        if trackedVehicles[plate] == nil then
            trackedVehicles[plate] = Config.MaxStatusValues
        end

        if degname == 'body' then
            TriggerClientEvent('rl-tow:client:setBodyHealth', src, (current + amount*100) <= 1000 and current + amount*100 or 1000)
        elseif degname == 'engine' then
            TriggerClientEvent('rl-tow:client:setEngineHealth', src, (current + amount*100) <= 1000 and current + amount*100 or 1000)

        else
            trackedVehicles[plate][degname] = trackedVehicles[plate][degname] + amount*10

            if trackedVehicles[plate][degname] > Config.MaxStatusValues[degname] then
                trackedVehicles[plate][degname] = Config.MaxStatusValues[degname]
            end
        end

        xPlayer.Functions.RemoveItem(itemname, 1)
        TriggerClientEvent('rl-tow:getSQL', src, trackedVehicles[plate])
    else
        TriggerClientEvent('chat:addMessage', src, {
            template = "<div class='chat-message server'>SYSTEM: You dont have enough of " .. itemname .. ".</div>",
            args = {}
        })
    end
end)

Citizen.CreateThread(function()
    RLCore.Functions.ExecuteSql(false, "SELECT `plate`,`parts` FROM `bbvehicles`", function(result)
        for k,v in pairs(result) do
            if result[k] and result[k].parts then
                local data = json.decode(result[k].parts)
                local plate = result[k].plate
                if data then
                    trackedVehicles[plate] = Config.MaxStatusValues
                    if data["breaks"] then
                        trackedVehicles[plate]["breaks"] = data["breaks"]
                    end
                
                    if data["axle"] then
                        trackedVehicles[plate]["axle"] = data["axle"]
                    end
                
                    if data["radiator"] then
                        trackedVehicles[plate]["radiator"] = data["radiator"]
                    end
                
                    if data["clutch"] then
                        trackedVehicles[plate]["clutch"] = data["clutch"]
                    end
                
                    if data["transmission"] then
                        trackedVehicles[plate]["transmission"] = data["transmission"]
                    end
                
                    if data["electronics"] then
                        trackedVehicles[plate]["electronics"] = data["electronics"]
                    end
                
                    if data["fuel_injector"] then
                        trackedVehicles[plate]["fuel_injector"] = data["fuel_injector"]
                    end
                
                    if data["fuel_tank"] then
                        trackedVehicles[plate]["fuel_tank"] = data["fuel_tank"]
                    end
                end
            end
        end
    end)
end)

function GetItem(source, item)
    local xPlayer = RLCore.Functions.GetPlayer(source)
    local count = 0

    for k,v in pairs(xPlayer['PlayerData']['items']) do
        if v.name == item then
            count = count + v.amount
        end
    end
    
    return { name = item, amount = count }
end
