Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isEscorted then
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, Keys['T'], true)
            EnableControlAction(0, Keys['E'], true)
            EnableControlAction(0, Keys['ESC'], true)
        end

        if isHandcuffed then
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1

            DisableControlAction(0, Keys['R'], true) -- Reload
            DisableControlAction(0, Keys['SPACE'], true) -- Jump
            DisableControlAction(0, Keys['Q'], true) -- Cover
            DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
            DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

            DisableControlAction(0, Keys['F1'], true) -- Disable phone
            DisableControlAction(0, Keys['F2'], true) -- Inventory
            DisableControlAction(0, Keys['F3'], true) -- Animations
            DisableControlAction(0, Keys['F6'], true) -- Job

            DisableControlAction(0, Keys['C'], true) -- Disable looking behind
            DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
            DisableControlAction(2, Keys['P'], true) -- Disable pause screen

            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle

            DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle

            DisableControlAction(0, 82, true) -- comma - ragdoll

            if (not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arrest_paired", "crook_p2_back_right", 3)) and not RLCore.Functions.GetPlayerData().metadata["isdead"] then
                loadAnimDict("mp_arresting")
                TaskPlayAnim(GetPlayerPed(-1), "mp_arresting", "idle", 8.0, -8, -1, cuffType, 0, 0, 0, 0)
            end
        end
        if not isHandcuffed and not isEscorted then
            Citizen.Wait(2000)
        end
    end
end)

RegisterNetEvent('police:client:SetOutVehicle')
AddEventHandler('police:client:SetOutVehicle', function()
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        TaskLeaveVehicle(GetPlayerPed(-1), vehicle, 16)
    end
end)

RegisterNetEvent('police:client:PutInVehicle')
AddEventHandler('police:client:PutInVehicle', function()
    if isHandcuffed or isEscorted then
        local vehicle, distance = RLCore.Functions.GetClosestVehicle()
        if DoesEntityExist(vehicle) then
            if distance <= 5.0 then
                local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)
                if maxSeats > 0 then
                    local ped = PlayerPedId()
                    local seats = {}
                    for i = 1, maxSeats, 1 do -- Loop through all seats and add them into seats table
                        table.insert(seats, i)
                    end
    
                    table.sort(seats, function(a, b) return a > b end) -- Sort the amount of seats available highest to lowest, so it places them in highest seat first.
    
                    if #seats > 1 then -- If our vehicle has more than one passenger seat
                        for index, seat in pairs(seats) do
                            if IsVehicleSeatFree(vehicle, seat) then
                                freeSeat = seat
                                break
                            end
                        end
                    else
                        freeSeat = 0 -- Set seat to front right passenger seat
                    end
                    
                    if freeSeat then
                        isEscorted = false
                        TriggerEvent('hospital:client:isEscorted', isEscorted)
                        ClearPedTasks(ped)
                        DetachEntity(ped, true, false)
                        Wait(100)
                        TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
                        if isHandcuffed then -- If handcuffed do the handcuff sit animation
                            loadAnimDict("mp_arresting")
                            TaskPlayAnim(ped, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0) -- Play arrest animation in vehicle, rather than just sitting
                        end
                    end
                else
                    RLCore.Functions.Notify("No passenger seat found!", "error")
                end
            end
        end
    end
end)

RegisterNetEvent('police:client:checkBank')
AddEventHandler('police:client:checkBank', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:checkBank", playerId)
    else
        RLCore.Functions.Notify("No one around!", "error")
    end
end)

RegisterNetEvent('police:client:checkLicenses')
AddEventHandler('police:client:checkLicenses', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:checkLicenses", playerId)
    else
        RLCore.Functions.Notify("No one around!", "error")
    end
end)

RegisterNetEvent('police:client:checkFines')
AddEventHandler('police:client:checkFines', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:checkFines", playerId)
    else
        RLCore.Functions.Notify("No one around!", "error")
    end
end)

RegisterNetEvent('police:client:SearchPlayer')
AddEventHandler('police:client:SearchPlayer', function()
    local player, distance = GetClosestPlayer() 
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerId)
        TriggerServerEvent("police:server:SearchPlayer", playerId)
    else
        RLCore.Functions.Notify("No one around!", "error")
    end
end)

RegisterNetEvent('police:client:SeizeCash')
AddEventHandler('police:client:SeizeCash', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:SeizeCash", playerId)
    else
        RLCore.Functions.Notify("No one around!", "error")
    end
end)

RegisterNetEvent('police:client:SeizeDriverLicense')
AddEventHandler('police:client:SeizeDriverLicense', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:SeizeDriverLicense", playerId)
    else
        RLCore.Functions.Notify("No one around!", "error")
    end
end)


RegisterNetEvent('police:client:RobPlayer')
AddEventHandler('police:client:RobPlayer', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerPed = GetPlayerPed(player)
        local playerId = GetPlayerServerId(player)
        if IsEntityPlayingAnim(playerPed, "missminuteman_1ig_2", "handsup_base", 3) or IsEntityPlayingAnim(playerPed, "mp_arresting", "idle", 3) or IsTargetDead(playerId) then
            RLCore.Functions.Progressbar("robbing_player", "Robbing", 3500, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "random@shop_robbery",
                anim = "robbery_action_b",
                flags = 16,
            }, {}, {}, function() -- Done
                local plyCoords = GetEntityCoords(playerPed)
                local pos = GetEntityCoords(GetPlayerPed(-1))
                local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, plyCoords.x, plyCoords.y, plyCoords.z, true)
                if dist < 2.5 then
                    StopAnimTask(GetPlayerPed(-1), "random@shop_robbery", "robbery_action_b", 1.0)
                    TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerId)
                    TriggerEvent("inventory:server:RobPlayer", playerId)
                else
                    RLCore.Functions.Notify("No one around!", "error")
                end
            end, function() -- Cancel
                StopAnimTask(GetPlayerPed(-1), "random@shop_robbery", "robbery_action_b", 1.0)
                RLCore.Functions.Notify("Canceled..", "error")
            end)
        end
    else
        RLCore.Functions.Notify("No one around!", "error")
    end
end)

RegisterNetEvent('police:client:JailCommand')
AddEventHandler('police:client:JailCommand', function(playerId, time)
    TriggerServerEvent("police:server:JailPlayer", playerId, tonumber(time))
end)

RegisterNetEvent('police:client:BillCommand')
AddEventHandler('police:client:BillCommand', function(playerId, price)
    TriggerServerEvent("police:server:BillPlayer", playerId, tonumber(price))
end)

RegisterNetEvent('police:client:JailPlayer')
AddEventHandler('police:client:JailPlayer', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        DisplayOnscreenKeyboard(1, "", "", "", "", "", "", 20)
        while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
            Citizen.Wait(7)
        end
        local time = GetOnscreenKeyboardResult()
        if tonumber(time) > 0 then
            TriggerServerEvent("police:server:JailPlayer", playerId, tonumber(time))
        else
            RLCore.Functions.Notify("Time must be greater than 0..", "error")
        end
    else
        RLCore.Functions.Notify("No one around!", "error")
    end
end)

RegisterNetEvent('police:client:BillPlayer')
AddEventHandler('police:client:BillPlayer', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        DisplayOnscreenKeyboard(1, "", "", "", "", "", "", 20)
        while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
            Citizen.Wait(7)
        end
        local price = GetOnscreenKeyboardResult()
        if tonumber(price) > 0 then
            TriggerServerEvent("police:server:BillPlayer", playerId, tonumber(price))
        else
            RLCore.Functions.Notify("Price must be higher than 0..", "error")
        end
    else
        RLCore.Functions.Notify("No one around!", "error")
    end
end)

RegisterNetEvent('police:client:PutPlayerInVehicle')
AddEventHandler('police:client:PutPlayerInVehicle', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isEscorted then
            TriggerServerEvent("police:server:PutPlayerInVehicle", playerId)
        end
    else
        RLCore.Functions.Notify("No one around!", "error")
    end
end)

RegisterNetEvent('police:client:SetPlayerOutVehicle')
AddEventHandler('police:client:SetPlayerOutVehicle', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isEscorted then
            TriggerServerEvent("police:server:SetPlayerOutVehicle", playerId)
        end
    else
        RLCore.Functions.Notify("No one around!", "error")
    end
end)
 
RegisterNetEvent('police:client:EscortPlayer')
AddEventHandler('police:client:EscortPlayer', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isEscorted then 
            TriggerServerEvent("police:server:EscortPlayer", playerId)
        end
    else
        RLCore.Functions.Notify("No one around!", "error")
    end
end)

function IsHandcuffed()
    return isHandcuffed
end

RegisterNetEvent('police:client:KidnapPlayer')
AddEventHandler('police:client:KidnapPlayer', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not IsPedInAnyVehicle(GetPlayerPed(player)) then
            if not isHandcuffed and not isEscorted then
                TriggerServerEvent("police:server:KidnapPlayer", playerId)
            end
        end
    else
        RLCore.Functions.Notify("No one around!", "error")
    end
end)

RegisterNetEvent('police:client:GetEscorted')
AddEventHandler('police:client:GetEscorted', function(playerId)
    RLCore.Functions.GetPlayerData(function(PlayerData)
        --if PlayerData.metadata["isdead"] or isHandcuffed or PlayerData.metadata["inlaststand"] then
            if not isEscorted then
                isEscorted = true
                draggerId = playerId
                local dragger = GetPlayerPed(GetPlayerFromServerId(playerId))
                local heading = GetEntityHeading(dragger)
                SetEntityCoords(GetPlayerPed(-1), GetOffsetFromEntityInWorldCoords(dragger, 0.0, 0.45, 0.0))
                AttachEntityToEntity(GetPlayerPed(-1), dragger, 11816, 0.45, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            else
                isEscorted = false
                DetachEntity(GetPlayerPed(-1), true, false)
            end
            TriggerEvent('hospital:client:isEscorted', isEscorted)
        --end
    end)
end)

RegisterNetEvent('police:client:DeEscort')
AddEventHandler('police:client:DeEscort', function()
    isEscorted = false
    TriggerEvent('hospital:client:isEscorted', isEscorted)
    DetachEntity(GetPlayerPed(-1), true, false)
end)

RegisterNetEvent('police:client:GetKidnappedTarget')
AddEventHandler('police:client:GetKidnappedTarget', function(playerId)
    RLCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] or isHandcuffed then
            if not isEscorted then
                isEscorted = true
                draggerId = playerId
                local dragger = GetPlayerPed(GetPlayerFromServerId(playerId))
                local heading = GetEntityHeading(dragger)
                RequestAnimDict("nm")

                while not HasAnimDictLoaded("nm") do
                    Citizen.Wait(10)
                end
                -- AttachEntityToEntity(GetPlayerPed(-1), dragger, 11816, 0.45, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                AttachEntityToEntity(GetPlayerPed(-1), dragger, 0, 0.27, 0.15, 0.63, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
                TaskPlayAnim(GetPlayerPed(-1), "nm", "firemans_carry", 8.0, -8.0, 100000, 33, 0, false, false, false)
            else
                isEscorted = false
                DetachEntity(GetPlayerPed(-1), true, false)
                ClearPedTasksImmediately(GetPlayerPed(-1))
            end
            TriggerEvent('hospital:client:isEscorted', isEscorted)
        end
    end)
end)

local isEscorting = false

RegisterNetEvent('police:client:GetKidnappedDragger')
AddEventHandler('police:client:GetKidnappedDragger', function(playerId)
    RLCore.Functions.GetPlayerData(function(PlayerData)
        if not isEscorting then
            draggerId = playerId
            local dragger = GetPlayerPed(-1)
            RequestAnimDict("missfinale_c2mcs_1")

            while not HasAnimDictLoaded("missfinale_c2mcs_1") do
                Citizen.Wait(10)
            end
            TaskPlayAnim(dragger, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 8.0, -8.0, 100000, 49, 0, false, false, false)
            isEscorting = true
        else
            local dragger = GetPlayerPed(-1)
            ClearPedSecondaryTask(dragger)
            ClearPedTasksImmediately(dragger)
            isEscorting = false
        end
        TriggerEvent('hospital:client:SetEscortingState', isEscorting)
        TriggerEvent('rl-kidnapping:client:SetKidnapping', isEscorting)
    end)
end)

RegisterNetEvent('police:client:CuffPlayer')
AddEventHandler('police:client:CuffPlayer', function(softCuff)
    if not IsPedRagdoll(GetPlayerPed(-1)) then
        local player, distance = GetClosestPlayer()
        if player ~= -1 and distance < 1.5 then
            RLCore.Functions.TriggerCallback('RLCore:HasItem', function(hasCuffs)
                if hasCuffs then
                    local playerId = GetPlayerServerId(player)
                    if not IsPedInAnyVehicle(GetPlayerPed(player), false) and not IsPedInAnyVehicle(PlayerPedId(), false) then
                        RLCore.Functions.TriggerCallback('police:server:isPlayerCuffed', function(isCuffed)
                            if not isCuffed then
                                RLCore.Functions.Notify("Handcuffing")
                            else
                                RLCore.Functions.Notify("Uncuffing")
                            end
                            TriggerServerEvent("police:server:CuffPlayer", playerId, softCuff)
                        end, playerId)
                    else
                        RLCore.Functions.Notify("You cannot soft cuff in a vehicle", "error")
                    end
                else
                    RLCore.Functions.Notify("You have no handcuffs with you", "error")
                end
            end, "handcuffs")
        else
            RLCore.Functions.Notify("No one around!", "error")
        end
    else
        Citizen.Wait(2000)
    end
end)

RegisterNetEvent("police:client:Hardcuff")
AddEventHandler("police:client:Hardcuff", function()
    TriggerEvent("police:client:CuffPlayer", false)
end)  

RegisterNetEvent("police:client:Softcuff")
AddEventHandler("police:client:Softcuff", function()
    TriggerEvent("police:client:CuffPlayer", true)
end)    

RegisterNetEvent("police:client:CufferAnimation")
AddEventHandler("police:client:CufferAnimation", function(cuffeeId, animType)
    local ped = PlayerPedId()
    
    if animType == "cuff" then
        loadAnimDict("mp_arrest_paired")
        TaskPlayAnim(ped, "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, -1, 48, 0, 0, 0, 0)
        Wait(3200)
        ClearPedSecondaryTask(ped)
    elseif animType == "uncuff" then
        loadAnimDict("mp_arresting")
        local bone = GetPedBoneIndex(ped, 0xFA11)
		handcuffKeys = CreateObject(GetHashKey("prop_cuff_keys_01"), GetEntityCoords(ped, false))
		AttachEntityToEntity(handcuffKeys, ped, bone, 0.02, 0.005, 0.01, 100.0, 280.0, 70.0, true, true, false, true, 1, true)
        TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 8.0, -8, -1, 49, 0, 0, 0, 0)
        Wait(2000)
        DeleteObject(handcuffKeys)
        handcuffKeys = nil
        ClearPedTasks(ped)
    end
end)

RegisterNetEvent('police:client:GetCuffed')
AddEventHandler('police:client:GetCuffed', function(playerId, softCuff)
    local ped = PlayerPedId()
    local finished = 0

    loadAnimDict("mp_arresting")
    if not isHandcuffed then
        if not RLCore.Functions.GetPlayerData().metadata["isdead"] then
            finished = exports["tgiann-skillbar"]:taskBar(math.random(1,2))  
        else
            finished = 100
        end

        print(finished)

        if softCuff then
            cuffType = 49
        else
            cuffType = 16
        end

        if finished then 
            RLCore.Functions.Notify("You broke free!!")
            return 
        end
        isHandcuffed = true
        TriggerEvent("tokovoip_script:ToggleRadioTalk", true)
        TriggerServerEvent("police:server:SetHandcuffStatus", true)
        TriggerServerEvent("police:server:CufferAnimation", playerId, "cuff")
        local cuffer = GetPlayerPed(GetPlayerFromServerId(playerId))
        local heading = GetEntityHeading(cuffer)
        loadAnimDict("mp_arrest_paired")
        SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(cuffer, 0.0, 0.45, 0.0))
        Citizen.Wait(100)
        SetEntityHeading(ped, heading)
        TaskPlayAnim(ped, "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 32, 0, 0, 0, 0)
        Wait(1500)
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'handcuff', 0.9)
        Wait(2000)
        if handcuffsProp == nil then
            local bone = GetPedBoneIndex(ped, 18905)
            handcuffsProp = CreateObject(GetHashKey("p_cs_cuffs_02_s"), GetEntityCoords(ped, false), true, false, true) 
            AttachEntityToEntity(handcuffsProp, ped, bone, 0.005, 0.060, 0.03, -180.0, 280.0, 70.0, true, true, false, true, 1, true)
            if not NetworkGetEntityIsNetworked(handcuffsProp) then
                NetworkRegisterEntityAsNetworked(handcuffsProp)
            end
        end
        SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
        RLCore.Functions.Notify("Handcuffed")
    else
        TriggerServerEvent("police:server:CufferAnimation", playerId, "uncuff")
        Wait(2000)
        isHandcuffed = false
        DeleteEntity(handcuffsProp)
        handcuffsProp = nil
        TriggerServerEvent("police:server:SetHandcuffStatus", false)
        TriggerEvent("tokovoip_script:ToggleRadioTalk", false)
        ClearPedTasks(ped)
        RLCore.Functions.Notify("You are uncuffed!")
    end
end)    

RegisterNetEvent('police:client:Uncuffed')
AddEventHandler('police:client:Uncuffed', function()
    isHandcuffed = false
    isEscorted = false
    TriggerEvent("tokovoip_script:ToggleRadioTalk", false)
    TriggerEvent('hospital:client:isEscorted', isEscorted)
    DetachEntity(GetPlayerPed(-1), true, false)
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    RLCore.Functions.Notify("You are untied!")
end)

RegisterNetEvent('police:client:UseShitLockpick')
AddEventHandler('police:client:UseShitLockpick', function(item)
    if isHandcuffed then
        TriggerServerEvent('RLCore:Server:RemoveItem', 'shitlockpick', 1)
        TriggerEvent('inventory:client:ItemBox', RLCore.Shared.Items["shitlockpick"], "remove")
        Wait(1200)
        if exports["rl-taskbarskill"]:taskBar(2500,math.random(5,20)) then
            TriggerEvent("police:client:Uncuffed")
        end
    end
end)



function IsTargetDead(playerId)
    local retval = nil
    RLCore.Functions.TriggerCallback('police:server:isPlayerDead', function(result)
        retval = result
    end, playerId)

    while retval == nil do 
        Wait(1) 
    end
    
    return retval
end

function HandCuffAnimation()
    loadAnimDict("mp_arrest_paired")
    Citizen.Wait(100)
    TaskPlayAnim(GetPlayerPed(-1), "mp_arrest_paired", "cop_p2_back_right", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
    Citizen.Wait(3500)
    TaskPlayAnim(GetPlayerPed(-1), "mp_arrest_paired", "exit", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
end

function GetCuffedAnimation(playerId)
    local ped = PlayerPedId()
    local cuffer = GetPlayerPed(GetPlayerFromServerId(playerId))
    local heading = GetEntityHeading(cuffer)
    loadAnimDict("mp_arrest_paired")
    SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(cuffer, 0.0, 0.45, 0.0))
    Citizen.Wait(100)
    SetEntityHeading(ped, heading)
    TaskPlayAnim(ped, "mp_arrest_paired", "crook_p2_back_right", 3.0, 3.0, -1, 32, 0, 0, 0, 0)
    Citizen.Wait(750)
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'handcuff', 0.9)
    Wait(2000)
    if handcuffsProp == nil then
        local bone = GetPedBoneIndex(ped, 18905)
        handcuffsProp = CreateObject(GetHashKey("p_cs_cuffs_02_s"), GetEntityCoords(ped, false), true, false, true) 
        AttachEntityToEntity(handcuffsProp, ped, bone, 0.005, 0.060, 0.03, -180.0, 280.0, 70.0, true, true, false, true, 1, true)
        if not NetworkGetEntityIsNetworked(handcuffsProp) then
            NetworkRegisterEntityAsNetworked(handcuffsProp)
        end
    else
        print("WE CANT CREATE CUFF PROP, AS IT ALREADY EXISTS, DOING SO WILL MAKE IT STICK TO YOU")
    end
end

function UncuffAnimation()
    loadAnimDict("mp_arresting")
    TaskPlayAnim(PlayerPedId(), "mp_arresting", "a_uncuff", 8.0, -8, -1, 49, 0, 0, 0, 0)
    Wait(2000)
    ClearPedTasks(PlayerPedId())
end

function IsHandcuffed()
    return isHandcuffed ~= nil and isHandcuffed or false
end
