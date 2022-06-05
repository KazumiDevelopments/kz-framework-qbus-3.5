RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

-- Code

local RentedVehicles = {}
local VehiclePlate = 0

RegisterServerEvent('rl-vehiclerental:server:SetVehicleRented')
AddEventHandler('rl-vehiclerental:server:SetVehicleRented', function(bool, vehicleData)
    local src = source
    local ply = RLCore.Functions.GetPlayer(src)
    local plyCid = ply.PlayerData.citizenid

    if bool then
        if ply.PlayerData.money.cash >= vehicleData.price then
            VehiclePlate = VehiclePlate + 1
            ply.Functions.RemoveMoney('cash', vehicleData.price, "vehicle-rentail-bail") 
            RentedVehicles[plyCid] = "RENT-" .. VehiclePlate
            TriggerClientEvent('RLCore:Notify', src, 'You paid the deposit of $ '.. vehicleData.price ..' in cash.', 'success', 3500)
            TriggerClientEvent('rl-vehiclerental:server:SpawnRentedVehicle', src, "RENT-" .. VehiclePlate, vehicleData) 
        elseif ply.PlayerData.money.bank >= vehicleData.price then 
            VehiclePlate = VehiclePlate + 1
            ply.Functions.RemoveMoney('bank', vehicleData.price, "vehicle-rentail-bail") 
            RentedVehicles[plyCid] = "RENT-" .. VehiclePlate
            TriggerClientEvent('RLCore:Notify', src, 'You paid the deposit of $ '.. vehicleData.price ..' through the bank.', 'success', 3500)
            TriggerClientEvent('rl-vehiclerental:server:SpawnRentedVehicle', src, "RENT-" .. VehiclePlate, vehicleData) 
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have enough money.', 'error', 3500)
        end
        return
    end
    TriggerClientEvent('RLCore:Notify', src, 'You have received your deposit of $ '.. vehicleData.price ..' back.', 'success', 3500)
    ply.Functions.AddMoney('cash', vehicleData.price, "vehicle-rentail-bail")
    RentedVehicles[plyCid] = nil
end)
