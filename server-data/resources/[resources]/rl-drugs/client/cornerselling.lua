cornerselling = false
hasTarget = false
busySelling = false

startLocation = nil

currentPed = nil

lastPed = {}

stealingPed = nil

--
stealData = {}

availableDrugs = {}

RegisterNetEvent('rl-drugs:client:cornerselling')
AddEventHandler('rl-drugs:client:cornerselling', function(data)
    RLCore.Functions.TriggerCallback('rl-drugs:server:cornerselling:getAvailableDrugs', function(result)
        if result ~= nil then
            availableDrugs = result

            if not cornerselling then
                cornerselling = true
                RLCore.Functions.Notify('You are corner selling drugs.')
                startLocation = GetEntityCoords(GetPlayerPed(-1))
            else
                cornerselling = false
                RLCore.Functions.Notify('Sales Ended.' , "error")
            end
        else
            RLCore.Functions.Notify('Missing Drugs', 'error')
        end
    end)
end)

function toFarAway()
    RLCore.Functions.Notify('You are moving too much, start over again!', 'error')
    cornerselling = false
    hasTarget = false
    busySelling = false
    startLocation = nil
    currentPed = nil
    availableDrugs = {}
    Citizen.Wait(5000)
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(4)
        if stealingPed ~= nil and stealData ~= nil then
            if IsEntityDead(stealingPed) then
                local pos = GetEntityCoords(GetPlayerPed(-1))
                local pedpos = GetEntityCoords(stealingPed)
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, pedpos.x, pedpos.y, pedpos.z, true) < 1.5) then
                    DrawText3D(pedpos.x, pedpos.y, pedpos.z, "[E] Get stuff back")
                    if IsControlJustReleased(0, Keys["E"]) then
                        RequestAnimDict("pickup_object")
                        while not HasAnimDictLoaded("pickup_object") do
                            Citizen.Wait(7)
                        end
                        TaskPlayAnim(GetPlayerPed(-1), "pickup_object" ,"pickup_low" ,8.0, -8.0, -1, 1, 0, false, false, false )
                        Citizen.Wait(2000)
                        ClearPedTasks(GetPlayerPed(-1))
                        TriggerServerEvent("RLCore:Server:AddItem", stealData.item, stealData.amount)
                        TriggerEvent('inventory:client:ItemBox', RLCore.Shared.Items[stealData.item], "add")
                        stealingPed = nil
                        stealData = {}
                    end
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do

        if cornerselling then
            local player = GetPlayerPed(-1)
            local coords = GetEntityCoords(player)
            if not hasTarget then
                local PlayerPeds = {}
                if next(PlayerPeds) == nil then
                    for _, player in ipairs(GetActivePlayers()) do
                        local ped = GetPlayerPed(player)
                        table.insert(PlayerPeds, ped)
                    end
                end
                
                local closestPed, closestDistance = RLCore.Functions.GetClosestPed(coords, PlayerPeds)
                if closestDistance < 15.0 and closestPed ~= 0 then
                    SellToPed(closestPed)
                end
            end

            local startDist = GetDistanceBetweenCoords(startLocation, GetEntityCoords(GetPlayerPed(-1)))

            if startDist > 10 then
                toFarAway()
            end
        end

        if not cornerselling then
            Citizen.Wait(1000)
        end

        Citizen.Wait(3)
    end
end)

RegisterNetEvent('rl-drugs:client:refreshAvailableDrugs')
AddEventHandler('rl-drugs:client:refreshAvailableDrugs', function(items)
    availableDrugs = items
end)

function SellToPed(ped)
    hasTarget = true
    for i = 1, #lastPed, 1 do
        if lastPed[i] == ped then
            print(ped)
            hasTarget = false
            return
        end
    end

    local succesChance = math.random(1, 30)

    local scamChance = math.random(1, 5)
    local player = GetPlayerPed(-1)
    local getRobbed = math.random(1, 20)


    local drugType = math.random(1, #availableDrugs)
    local bagAmount = math.random(1, 30)

    currentOfferDrug = availableDrugs[drugType]

    local ddata = Config.DrugsPrice[currentOfferDrug.item]
    local randomPrice = math.random(ddata.min, ddata.max) * bagAmount
    if scamChance == 5 then
       randomPrice = math.random(3, 10) * bagAmount
    end

    SetEntityAsNoLongerNeeded(ped)
    ClearPedTasks(ped)

    local coords = GetEntityCoords(GetPlayerPed(-1), true)
    local pedCoords = GetEntityCoords(ped)
    local pedDist = GetDistanceBetweenCoords(coords, pedCoords)

    if getRobbed == 18 or getRobbed == 9 then
        TaskGoStraightToCoord(ped, coords, 15.0, -1, 0.0, 0.0)
    else
        TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
    end

    while pedDist > 1.5 do
        coords = GetEntityCoords(GetPlayerPed(-1), true)
        pedCoords = GetEntityCoords(ped)    
        if getRobbed == 18 or getRobbed == 9 then
            TaskGoStraightToCoord(ped, coords, 15.0, -1, 0.0, 0.0)
        else
            TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
        end
        TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
        pedDist = GetDistanceBetweenCoords(coords, pedCoords)

        Citizen.Wait(100)
    end

    TaskLookAtEntity(ped, GetPlayerPed(-1), 5500.0, 2048, 3)
    TaskTurnPedToFaceEntity(ped, GetPlayerPed(-1), 5500)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false)
    currentPed = ped

    if hasTarget then
        while pedDist < 1.5 do
            coords = GetEntityCoords(GetPlayerPed(-1), true)
            pedCoords = GetEntityCoords(ped)
            pedDist = GetDistanceBetweenCoords(coords, pedCoords)

            if getRobbed == 18 or getRobbed == 9 then
                TriggerServerEvent('rl-drugs:server:robCornerDrugs', availableDrugs[drugType].item, bagAmount)
                RLCore.Functions.Notify('You have been robbed of '..bagAmount..' sachet(\'s) '..availableDrugs[drugType].label, 'error')
                stealingPed = ped
                stealData = {
                    item = availableDrugs[drugType].item,
                    amount = bagAmount,
                }

                hasTarget = false

                local rand = (math.random(6,9) / 100) + 0.3
                local rand2 = (math.random(6,9) / 100) + 0.3
                if math.random(10) > 5 then
                    rand = 0.0 - rand
                end
            
                if math.random(10) > 5 then
                    rand2 = 0.0 - rand2
                end
            
                local moveto = GetEntityCoords(GetPlayerPed(-1))
                local movetoCoords = {x = moveto.x + math.random(100, 500), y = moveto.y + math.random(100, 500), z = moveto.z, }
                ClearPedTasksImmediately(ped)
                TaskGoStraightToCoord(ped, movetoCoords.x, movetoCoords.y, movetoCoords.z, 15.0, -1, 0.0, 0.0)

                table.insert(lastPed, ped)
                break
            else
                if pedDist < 1.5 then
                    RLCore.Functions.DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z, '~g~E~w~ '..bagAmount..'x '..currentOfferDrug.label..' in front of $'..randomPrice..'? / ~g~G~w~ Decline offer')
                    if IsControlJustPressed(0, Keys["E"]) then
                        TriggerServerEvent('rl-drugs:server:sellCornerDrugs', availableDrugs[drugType].item, bagAmount, randomPrice)
                        hasTarget = false
		
                        --loadAnimDict("gestures@f@standing@casual")
                        --TaskPlayAnim(GetPlayerPed(-1), "gestures@f@standing@casual", "gesture_point", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
                        loadAnimDict("mp_safehouselost@")
                        TaskPlayAnim(player, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
						Citizen.Wait(1000)
                        TaskPlayAnim(ped, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
                        Citizen.Wait(1000)
                        ClearPedTasks(GetPlayerPed(-1))
                        SetPedKeepTask(ped, false)
                        SetEntityAsNoLongerNeeded(ped)
                        ClearPedTasksImmediately(ped)
                        table.insert(lastPed, ped)
                        break
                    end

                    if IsControlJustPressed(0, Keys["G"]) then
                        RLCore.Functions.Notify('Offer refused.', 'error')
                        hasTarget = false

                        SetPedKeepTask(ped, false)
                        SetEntityAsNoLongerNeeded(ped)
                        ClearPedTasksImmediately(ped)
                        table.insert(lastPed, ped)
                        break
                    end
                else
                    hasTarget = false
                    SetPedKeepTask(ped, false)
                    SetEntityAsNoLongerNeeded(ped)
                    ClearPedTasksImmediately(ped)
                    table.insert(lastPed, ped)
                end
            end
            
            Citizen.Wait(3)
        end
        
        Citizen.Wait(math.random(4000, 7000))
    end
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end 

function runAnimation(target)
    RequestAnimDict("mp_character_creation@lineup@male_a")
    while not HasAnimDictLoaded("mp_character_creation@lineup@male_a") do
    Citizen.Wait(0)
    end
    if not IsEntityPlayingAnim(target, "mp_character_creation@lineup@male_a", "loop_raised", 3) then
        TaskPlayAnim(target, "mp_character_creation@lineup@male_a", "loop_raised", 8.0, -8, -1, 49, 0, 0, 0, 0)
    end
end