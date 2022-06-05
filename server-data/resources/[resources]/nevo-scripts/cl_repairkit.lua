local reapiring = false
RegisterNetEvent('nevo:repairing')
AddEventHandler('nevo:repairing', function(advanced)
    local playerped = PlayerPedId()
    local coordA = GetEntityCoords(playerped, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    local targetVehicle = getVehicleInDirection(coordA, coordB)

    if targetVehicle ~= 0 and not reapiring then
        reapiring = true

        local d1,d2 = GetModelDimensions(GetEntityModel(targetVehicle))
        local moveto = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0,d2["y"]+0.5,0.2)
        local dist = #(vector3(moveto["x"],moveto["y"],moveto["z"]) - GetEntityCoords(PlayerPedId()))
        local count = 1000
        local fueltankhealth = GetVehiclePetrolTankHealth(targetVehicle)
        local timeout = 20

        NetworkRequestControlOfEntity(targetVehicle)

        while not NetworkHasControlOfEntity(targetVehicle) and timeout > 0 do 
            NetworkRequestControlOfEntity(targetVehicle)
            Citizen.Wait(100)
            timeout = timeout -1
        end

        if dist < 1.5 then
            if (advanced and math.random(1,2) or math.random(1,4)) == 2 then
                TriggerServerEvent("nevo:RemoveItem",advanced and "advancedrepairkit" or "repairkit", 1)
            end

            TriggerEvent("nevo:repairanim",targetVehicle)
            local repairlength = 1000

            if advanced then
                local timeAdded = 0
                for i=0,5 do
                    if IsVehicleTyreBurst(targetVehicle, i, false) then
                        if IsVehicleTyreBurst(targetVehicle, i, true) then
                            timeAdded = timeAdded + 1200
                        else
                           timeAdded = timeAdded + 800
                        end
                    end
                end
                local fuelDamage = 48000 - (math.ceil(fueltankhealth)*12)
                repairlength = ((3500 - (GetVehicleEngineHealth(targetVehicle) * 3) - (GetVehicleBodyHealth(targetVehicle)) / 2) * 5) + 2000
                repairlength = repairlength + timeAdded + fuelDamage
            else
                local timeAdded = 0
                for i=0,5 do
                    if IsVehicleTyreBurst(targetVehicle, i, false) then
                        if IsVehicleTyreBurst(targetVehicle, i, true) then
                            timeAdded = timeAdded + 1600
                        else
                           timeAdded = timeAdded + 1200
                        end
                    end
                end
                local fuelDamage = 48000 - (math.ceil(fueltankhealth)*12)
                repairlength = ((3500 - (GetVehicleEngineHealth(targetVehicle) * 3) - (GetVehicleBodyHealth(targetVehicle)) / 2) * 3) + 2000
                repairlength = repairlength + timeAdded + fuelDamage
            end

            local finished = exports["rl-taskbarskill"]:taskBar(15000,math.random(10,20))
            if finished ~= 100 then
                reapiring = false
                ClearPedTasks(playerped)
                return
            end

            if advanced then
                if GetVehicleEngineHealth(targetVehicle) < 750.0 then
                    SetVehicleEngineHealth(targetVehicle, 750.0)
                end
                if GetVehicleBodyHealth(targetVehicle) < 500.0 then
                    SetVehicleBodyHealth(targetVehicle, 500.0)
                end

                if fueltankhealth < 3800.0 then
                    SetVehiclePetrolTankHealth(targetVehicle, 3800.0)
                end

				SetVehicleTyreFixed(targetVehicle,0)
				SetVehicleTyreFixed(targetVehicle,1)
				SetVehicleTyreFixed(targetVehicle,2)
				SetVehicleTyreFixed(targetVehicle,3)
				SetVehicleTyreFixed(targetVehicle,4)

            else
                local timer = math.ceil(GetVehicleEngineHealth(targetVehicle) * 5)
                if timer < 2000 then
                    timer = 2000
                end
                local finished = exports["rl-taskbarskill"]:taskBar(timer,math.random(5,15))
                if finished ~= 100 then
                    fixingvehicle = false
                    reapiring = false
                    ClearPedTasks(playerped)
                    return
                end


                if GetVehicleEngineHealth(targetVehicle) < 300.0 then
                    SetVehicleEngineHealth(targetVehicle, 250.0)
                end                    

                if GetEntityModel(targetVehicle) == `BLAZER` then
                    SetVehicleEngineHealth(targetVehicle, 600.0)
                    SetVehicleBodyHealth(targetVehicle, 800.0)
                end
            end                    
        end

        for i = 0, 5 do
            SetVehicleTyreFixed(targetVehicle, i) 
        end

        ClearPedTasks(playerped)
        reapiring = false
    end
end)

RegisterNetEvent('nevo:repairings')
AddEventHandler('nevo:repairings', function(advanced)
    local playerped = PlayerPedId()
    local coordA = GetEntityCoords(playerped, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    local targetVehicle = getVehicleInDirection(coordA, coordB)

    if targetVehicle ~= 0 and not reapiring then
        reapiring = true

        local d1,d2 = GetModelDimensions(GetEntityModel(targetVehicle))
        local moveto = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0,d2["y"]+0.5,0.2)
        local dist = #(vector3(moveto["x"],moveto["y"],moveto["z"]) - GetEntityCoords(PlayerPedId()))
        local count = 1000
        local fueltankhealth = GetVehiclePetrolTankHealth(targetVehicle)
        local timeout = 20

        NetworkRequestControlOfEntity(targetVehicle)

        while not NetworkHasControlOfEntity(targetVehicle) and timeout > 0 do 
            NetworkRequestControlOfEntity(targetVehicle)
            Citizen.Wait(100)
            timeout = timeout -1
        end

        if dist < 1.5 then
            --if (advanced and math.random(1,2) or math.random(1,4)) == 2 then
            --    TriggerServerEvent("nevo:RemoveItem",advanced and "advancedrepairkit" or "repairkit", 1)
            --end

            TriggerEvent("nevo:repairanim",targetVehicle)
            local repairlength = 1000

            local timeAdded = 0
            for i=0,5 do
                if IsVehicleTyreBurst(targetVehicle, i, false) then
                    if IsVehicleTyreBurst(targetVehicle, i, true) then
                        timeAdded = timeAdded + 1200
                    else
                        timeAdded = timeAdded + 800
                    end
                end
            end
            local fuelDamage = 48000 - (math.ceil(fueltankhealth)*12)
            repairlength = ((3500 - (GetVehicleEngineHealth(targetVehicle) * 3) - (GetVehicleBodyHealth(targetVehicle)) / 2) * 5) + 2000
            repairlength = repairlength + timeAdded + fuelDamage

            if GetVehicleEngineHealth(targetVehicle) < 750.0 then
                SetVehicleEngineHealth(targetVehicle, 750.0)
            end
            if GetVehicleBodyHealth(targetVehicle) < 500.0 then
                SetVehicleBodyHealth(targetVehicle, 500.0)
            end

            if fueltankhealth < 3800.0 then
                SetVehiclePetrolTankHealth(targetVehicle, 3800.0)
            end

            SetVehicleTyreFixed(targetVehicle,0)
            SetVehicleTyreFixed(targetVehicle,1)
            SetVehicleTyreFixed(targetVehicle,2)
            SetVehicleTyreFixed(targetVehicle,3)
            SetVehicleTyreFixed(targetVehicle,4)                  
        end

        for i = 0, 5 do
            SetVehicleTyreFixed(targetVehicle, i) 
        end

        ClearPedTasks(playerped)
        reapiring = false
    end
end)

RegisterNetEvent('nevo:repairanim')
AddEventHandler('nevo:repairanim', function(veh)
    SetVehicleDoorOpen(veh, 4, 0, 0)
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    TaskTurnPedToFaceEntity(PlayerPedId(), veh, 1.0)
    Citizen.Wait(200)

    while reapiring do
        if not IsEntityPlayingAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 3) then
            TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        
        Citizen.Wait(1)
    end

    SetVehicleDoorShut(veh, 4, 1, 1)
end)