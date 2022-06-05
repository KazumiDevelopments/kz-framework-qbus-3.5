RLCore.Functions.CreateCallback('rl-drugs:server:cornerselling:getAvailableDrugs', function(source, cb)
    local AvailableDrugs = {}
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    for i = 1, #Config.CornerSellingDrugsList, 1 do
        local item = Player.Functions.GetItemByName(Config.CornerSellingDrugsList[i])

        if item ~= nil then
            table.insert(AvailableDrugs, {
                item = item.name,
                amount = item.amount,
                label = RLCore.Shared.Items[item.name]["label"]
            })
        end
    end

    if next(AvailableDrugs) ~= nil then
        cb(AvailableDrugs)
    else
        cb(nil)
    end
end)

RegisterServerEvent('rl-drugs:server:sellCornerDrugs')
AddEventHandler('rl-drugs:server:sellCornerDrugs', function(item, amount, price)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local AvailableDrugs = {}

    if Player.Functions.RemoveItem(item, amount) then
        Player.Functions.AddMoney('cash', price, "sold-cornerdrugs")

        TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items[item], "remove")

        for i = 1, #Config.CornerSellingDrugsList, 1 do
            local item = Player.Functions.GetItemByName(Config.CornerSellingDrugsList[i])

            if item ~= nil then
                table.insert(AvailableDrugs, {
                    item = item.name,
                    amount = item.amount,
                    label = RLCore.Shared.Items[item.name]["label"]
                })
            end
        end
    end

    TriggerClientEvent('rl-drugs:client:refreshAvailableDrugs', src, AvailableDrugs)
end)

RegisterServerEvent('rl-drugs:server:robCornerDrugs')
AddEventHandler('rl-drugs:server:robCornerDrugs', function(item, amount, price)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local AvailableDrugs = {}

    Player.Functions.RemoveItem(item, amount)

    TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items[item], "remove")

    for i = 1, #Config.CornerSellingDrugsList, 1 do
        local item = Player.Functions.GetItemByName(Config.CornerSellingDrugsList[i])

        if item ~= nil then
            table.insert(AvailableDrugs, {
                item = item.name,
                amount = item.amount,
                label = RLCore.Shared.Items[item.name]["label"]
            })
        end
    end

    TriggerClientEvent('rl-drugs:client:refreshAvailableDrugs', src, AvailableDrugs)
end)