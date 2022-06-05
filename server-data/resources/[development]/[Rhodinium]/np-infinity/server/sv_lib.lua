RegisterServerEvent('np:infinity:player:ready')
AddEventHandler('np:infinity:player:ready', function()
    local sexinthetube = GetEntityCoords(GetPlayerPed(source))
    
    TriggerClientEvent('np:infinity:player:coords', -1, sexinthetube)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        local sexinthetube = GetEntityCoords(source)

        TriggerClientEvent('np:infinity:player:coords', -1, sexinthetube)
        TriggerEvent("ethical-base:updatecoords", sexinthetube.x, sexinthetube.y, sexinthetube.z)
        -- print("[^2np-infinity^0]^3 Sync Successful.^0")
    end
end)