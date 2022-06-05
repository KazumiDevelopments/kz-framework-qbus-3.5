local RLCore = nil
local robberyAlert = false
local isLoggedIn = false
local firstAlarm = false
local isInTimeout = false
local usedCameras = {}

Citizen.CreateThread(function()
    while RLCore == nil do
        Citizen.Wait(10)
        TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
    end

    while not RLCore.Functions.GetPlayerData().job do
        Wait(10)
    end

    RLCore.Functions.TriggerCallback('rl-jewellery:gettimeoutstatus', function(rs)
        isInTimeout = rs
    end)
    isLoggedIn = true
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('RLCore:Client:OnPlayerUnload')
AddEventHandler('RLCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

local alarm = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if alarm then
            alarm = false
            Citizen.Wait(600000)
            TriggerServerEvent("jewelalarm:stopalarmSV", -1)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        inRange = false

        for case,_ in pairs(Config.Locations) do
            -- if PlayerData.job.name ~= "police" then
                local dist = GetDistanceBetweenCoords(pos, Config.Locations[case]["coords"]["x"], Config.Locations[case]["coords"]["y"], Config.Locations[case]["coords"]["z"])
                local storeDist = GetDistanceBetweenCoords(pos, Config.JewelleryLocation["coords"]["x"], Config.JewelleryLocation["coords"]["y"], Config.JewelleryLocation["coords"]["z"])
                if dist < 30 then
                    inRange = true

                    if dist < 0.6 then
                        if not Config.Locations[case]["isBusy"] and not Config.Locations[case]["isOpened"] then
                            DrawText3Ds(Config.Locations[case]["coords"]["x"], Config.Locations[case]["coords"]["y"], Config.Locations[case]["coords"]["z"], '[E] Break')
                            if IsControlJustPressed(0, Keys["E"]) then
                                if isInTimeout == false then
                                TriggerServerEvent('rl-jewellery:server:startglobaltimeout')

                                RLCore.Functions.TriggerCallback('rl-jewellery:server:getCops', function(cops)
                                    if cops >= Config.RequiredCops then
                                        if validWeapon() then
                                            smashVitrine(case)
                                            TriggerServerEvent("jewelalarm:startalarmSV", -1)
                                            alarm = true
                                        else
                                            RLCore.Functions.Notify('Your weapon doesn\'t seem strong enough ..', 'error')
                                        end
                                    else
                                        RLCore.Functions.Notify('Not enough police', 'error')
                                    end                
                                end)
                            end
                            end
                        end
                    end

                    --[[ if storeDist < 2 then
                        if not firstAlarm then
                            if validWeapon() then
                                TriggerEvent('dispatch:jewelryRobbery')
                                local cameraID = math.random(31,34)
                                if not usedCameras[cameraID] then
                                    usedCameras[cameraID] = true
                                    TriggerServerEvent("police:camera", cameraID)
                                end
                                firstAlarm = true
                            end
                        end
                    end ]]
                end
            -- end
        end

        if not inRange then
            Citizen.Wait(2000)
        end

        Citizen.Wait(3)
    end
end)

RegisterNetEvent('lkjasdlksa:syncclientnoder')
AddEventHandler('lkjasdlksa:syncclientnoder', function(is)
    isInTimeout = is
end)

function loadParticle()
	if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
    RequestNamedPtfxAsset("scr_jewelheist")
    end
    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
    Citizen.Wait(0)
    end
    SetPtfxAssetNextCall("scr_jewelheist")
end

function loadAnimDict(dict)  
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(3)
    end
end

function validWeapon()
    local ped = GetPlayerPed(-1)
    local pedWeapon = GetSelectedPedWeapon(ped)

    for k, v in pairs(Config.WhitelistedWeapons) do
        if pedWeapon == k then
            return true
        end
    end
    return false
end

local smashing = false

function smashVitrine(k)
    local animDict = "missheist_jewel"
    local animName = "smash_case"
    local ped = GetPlayerPed(-1)
    local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0, 0.6, 0)
    local pedWeapon = GetSelectedPedWeapon(ped)

    if math.random(1, 100) <= 80 and not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", plyCoords)
    elseif math.random(1, 100) <= 5 and IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", plyCoords)
        RLCore.Functions.Notify("You broke the glass.", "error")
    end


    TriggerEvent('dispatch:jewelryRobbery')
    local cameraID = math.random(31,34)
    if not usedCameras[cameraID] then
        usedCameras[cameraID] = true
        TriggerServerEvent("police:camera", cameraID)
    end
    firstAlarm = true


    smashing = true

    RLCore.Functions.Progressbar("smash_vitrine", "Robbing", Config.WhitelistedWeapons[pedWeapon]["timeOut"], false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('rl-jewellery:server:setVitrineState', "isOpened", true, k)
        TriggerServerEvent('rl-jewellery:server:setVitrineState', "isBusy", false, k)
        TriggerServerEvent('rl-jewellery:server:vitrineReward')
        TriggerServerEvent('rl-jewellery:server:setTimeout')
        TriggerEvent('dispatch:jewelryRobbery')
        local cameraID = math.random(31,34)
        if not usedCameras[cameraID] then
            usedCameras[cameraID] = true
            TriggerServerEvent("police:camera", cameraID)
        end
        smashing = false
        TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
    end, function() -- Cancel
        TriggerServerEvent('rl-jewellery:server:setVitrineState', "isBusy", false, k)
        TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
    end)
    TriggerServerEvent('rl-jewellery:server:setVitrineState', "isBusy", true, k)

    Citizen.CreateThread(function()
        while smashing do
            loadAnimDict(animDict)
            TaskPlayAnim(ped, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
            Citizen.Wait(500)
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "breaking_vitrine_glass", 0.25)
            loadParticle()
            StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", plyCoords.x, plyCoords.y, plyCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
            Citizen.Wait(2500)
        end
    end)
    isInTimeout = false
end

RegisterNetEvent('rl-jewellery:client:setVitrineState')
AddEventHandler('rl-jewellery:client:setVitrineState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
end)

RegisterNetEvent('rl-jewellery:client:resetCameras')
AddEventHandler('rl-jewellery:client:resetCameras', function()
    usedCameras = {}
end)

RegisterNetEvent('rl-jewellery:client:setAlertState')
AddEventHandler('rl-jewellery:client:setAlertState', function(bool)
    robberyAlert = bool
end)

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(GetPlayerPed(-1), 3)
    local model = GetEntityModel(GetPlayerPed(-1))
    local retval = true
    if model == GetHashKey("mp_m_freemode_01") then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

Citizen.CreateThread(function()
    Dealer = AddBlipForCoord(Config.JewelleryLocation["coords"]["x"], Config.JewelleryLocation["coords"]["y"], Config.JewelleryLocation["coords"]["z"])

    SetBlipSprite (Dealer, 617)
    SetBlipDisplay(Dealer, 4)
    SetBlipScale  (Dealer, 0.7)
    SetBlipAsShortRange(Dealer, true)
    SetBlipColour(Dealer, 3)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Vangelico")
    EndTextCommandSetBlipName(Dealer)
end)