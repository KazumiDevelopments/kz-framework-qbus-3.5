RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent('tp-scrapyard:success')
AddEventHandler('tp-scrapyard:success', function(pay, item)
    local xPlayer = RLCore.Functions.GetPlayer(source)
    local math = math.random(1,7)
    xPlayer.Functions.AddMoney("cash", pay)

    if item then
        xPlayer.Functions.AddItem(item, math)
        TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items[item], "add")

    end
end)

RegisterServerEvent('tp-scrapyard:exitVehicle')
AddEventHandler('tp-scrapyard:exitVehicle', function(plate)
    local plate = plate
    TriggerClientEvent('tp-scrapyard:clExitVehicle', -1, plate)
end)