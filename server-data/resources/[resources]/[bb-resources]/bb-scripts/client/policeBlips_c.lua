local Blips = {}
RegisterNetEvent('bb-blips:client:updateBlips')
AddEventHandler('bb-blips:client:updateBlips', function(data)
    if not RLCore or not RLCore.Functions.GetPlayerData().job then
        return
    end
    
    for _, blip in pairs(Blips) do
        RemoveBlip(blip)
    end

    Blips = {}

    local job = RLCore.Functions.GetPlayerData().job.name
    if job ~= 'police' and job ~= 'ambulance' then
        return
    end

    for _, player in pairs(data) do
        local ped = GetPlayerPed(GetPlayerFromServerId(player[1]))

        blip = AddBlipForEntity(ped)
        SetBlipSprite(blip, 1)
        SetBlipScale(blip, 0.8)
        if player[2] == 'police' then
            SetBlipColour(blip, 3)
            --SetBlipShowCone(blip, true)
        else
            SetBlipColour(blip, 23)
        end
        SetBlipAsShortRange(blip, true)
        SetBlipDisplay(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(player[3])
        EndTextCommandSetBlipName(blip)

        table.insert(Blips, blip)
    end
end)