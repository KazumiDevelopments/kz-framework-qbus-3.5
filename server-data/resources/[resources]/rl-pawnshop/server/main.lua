RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local ItemList = {
    ["goldchain"] = math.random(100, 250),
	["goldcoin"] = math.random(100, 200),
	["goldbar"] = math.random(100, 300),
    ["Watch"] = math.random(100, 200),
	["diamond_ring"] = math.random(200, 350),
    ["rolex"] = math.random(600, 700),
	["markedbills"] = math.random(11700, 15000),
	["cashroll"] = math.random(1000, 2000),
	["cashstack"] = math.random(575, 1125),
	["10kgoldchain"] = math.random(200, 300),
}

local ItemListHardware = {
    ["tablet"] = math.random(250, 400),
    ["iphone"] = math.random(250, 400),
    ["samsungphone"] = math.random(250, 400),
    ["laptop"] = math.random(250, 400),
}

local MeltItems = {
    ["rolex"] = 15,
    ["goldchain"] = 30,
}

local GoldBarsAmount = 0
RegisterServerEvent("rl-pawnshop:server:sellPawnItems")
AddEventHandler("rl-pawnshop:server:sellPawnItems", function()
    local src = source
    local price = 0
    local Player = RLCore.Functions.GetPlayer(src)
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Player.PlayerData.items[k].info.cansell ~= false and ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price + (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                end
            end
        end
        Player.Functions.AddMoney("cash", price, "sold-pawn-items")
        TriggerClientEvent('RLCore:Notify', src, "Items Sold!", "error")
    end
end)

RegisterServerEvent("rl-pawnshop:server:sellHardwarePawnItems")
AddEventHandler("rl-pawnshop:server:sellHardwarePawnItems", function()
    local src = source
    local price = 0
    local totalAmount = 0
    local Player = RLCore.Functions.GetPlayer(src)
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Player.PlayerData.items[k].info.cansell ~= false and ItemListHardware[Player.PlayerData.items[k].name] ~= nil then 
                    price = price + (ItemListHardware[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    totalAmount = totalAmount + Player.PlayerData.items[k].amount
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                end
            end
        end
        Player.Functions.RemoveItem("certificate", totalAmount)
        Player.Functions.AddMoney("cash", price, "sold-hardware-pawn-items")
        TriggerClientEvent('RLCore:Notify', src, "Items Sold!", "error")
    end
end)

RegisterServerEvent("rl-pawnshop:server:getGoldBars")
AddEventHandler("rl-pawnshop:server:getGoldBars", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if GoldBarsAmount > 0 then
        if Player.Functions.AddItem("goldbar", GoldBarsAmount) then
            GoldBarsAmount = 0
            TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["goldbar"], "add")
            Config.IsMelting = false
            Config.CanTake = false
            Config.MeltTime = 300
            TriggerClientEvent("rl-pawnshop:client:SetTakeState", -1, false)
        else
            TriggerClientEvent('RLCore:Notify', src, "You have no space in your inventory", "error")
        end
    end
end)

RegisterServerEvent("rl-pawnshop:server:sellGold")
AddEventHandler("rl-pawnshop:server:sellGold", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local price = 0
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Player.PlayerData.items[k].name == "goldbar" then 
                    price = price + (math.random(100, 200) * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                end
            end
        end
        Player.Functions.AddMoney("cash", price, "sold-gold")
        TriggerClientEvent('RLCore:Notify', src, "Items Sold!")
    end
end)

RegisterServerEvent("rl-pawnshop:server:meltItems")
AddEventHandler("rl-pawnshop:server:meltItems", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local goldbars = 0
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Player.PlayerData.items[k].info.cansell ~= false and MeltItems[Player.PlayerData.items[k].name] ~= nil then 
                    local amount = (Player.PlayerData.items[k].amount / MeltItems[Player.PlayerData.items[k].name])
                    if amount < 1 then
                        TriggerClientEvent('RLCore:Notify', src, "You don't have enough " .. Player.PlayerData.items[k].label, "error")
                    else
                        amount = math.ceil(Player.PlayerData.items[k].amount / MeltItems[Player.PlayerData.items[k].name])
                        if amount > 0 then
                            if Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k) then
                                goldbars = goldbars + amount
                            end
                        end
                    end
                end
            end
        end
        if goldbars > 0 then
            GoldBarsAmount = goldbars
            TriggerClientEvent('rl-pawnshop:client:startMelting', -1)
            Config.IsMelting = true
            Config.MeltTime = 300
            Citizen.CreateThread(function()
                while Config.IsMelting do
                    Config.MeltTime = Config.MeltTime - 1
                    if Config.MeltTime <= 0 then
                        Config.IsMelting = false
                        Config.CanTake = true
                        Config.MeltTime = 300
                        TriggerClientEvent('rl-pawnshop:client:SetTakeState', -1, true)
                    end
                    Citizen.Wait(1000)
                end
            end)
        end
    end
end)

RLCore.Functions.CreateCallback('rl-pawnshop:server:getSellPrice', function(source, cb)
    local retval = 0
    local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Player.PlayerData.items[k].info.cansell ~= false and ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    retval = retval + (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                end
            end
        end
    end
    cb(retval)
end)

RLCore.Functions.CreateCallback('rl-pawnshop:melting:server:GetConfig', function(source, cb)
    cb(Config.IsMelting, Config.MeltTime, Config.CanTake)
end)

RLCore.Functions.CreateCallback('rl-pawnshop:server:getSellHardwarePrice', function(source, cb)
    local retval = 0
    local amount = 0
    local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Player.PlayerData.items[k].info.cansell ~= false and ItemListHardware[Player.PlayerData.items[k].name] ~= nil then 
                    retval = retval + (ItemListHardware[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    amount = amount + Player.PlayerData.items[k].amount
                end
            end
        end
        local certificates = Player.Functions.GetItemByName("certificate")
        if certificates ~= nil then
            if certificates.amount < amount then 
                retval = 0
            end
        else
            retval = 0
        end
    end
    cb(retval)
end)

RLCore.Functions.CreateCallback('rl-pawnshop:server:hasGold', function(source, cb)
	local retval = false
    local Player = RLCore.Functions.GetPlayer(source)
    local gold = Player.Functions.GetItemByName('goldbar')
    if gold ~= nil and gold.amount > 0 then
        retval = true
    end
    cb(retval)
end)