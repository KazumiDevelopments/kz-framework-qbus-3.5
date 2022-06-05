local alcoholCount = 0
local onWeed = false

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(10)
        if alcoholCount > 0 then
            Citizen.Wait(1000 * 60 * 15)
            alcoholCount = alcoholCount - 1
        else
            Citizen.Wait(2000)
        end
    end
end)
RegisterNetEvent("consumables:client:UseJoint")
AddEventHandler("consumables:client:UseJoint", function()
    RLCore.Functions.Progressbar("smoke_joint", "Smoking Joint", 1500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("debug", 'Consumables: Joint', 'success')
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["joint"], "remove")
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            TriggerEvent('animations:client:EmoteCommandStart', {"smoke3"})
        else
            TriggerEvent('animations:client:EmoteCommandStart', {"smokeweed"})
        end
        TriggerEvent("evidence:client:SetStatus", "weedsmell", 300)
        TriggerEvent('animations:client:SmokeWeed')
        Citizen.Wait(3000)
        JointEffect()
    end)
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function EquipParachuteAnim()
    loadAnimDict("clothingshirt")        
    TaskPlayAnim(GetPlayerPed(-1), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

local ParachuteEquiped = false

RegisterNetEvent("consumables:client:UseParachute")
AddEventHandler("consumables:client:UseParachute", function()
    EquipParachuteAnim()
    RLCore.Functions.Progressbar("use_parachute", "Using Parachute", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        local ped = GetPlayerPed(-1)
        TriggerEvent("debug", 'Consumables: Parachute', 'success')
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["parachute"], "remove")
        GiveWeaponToPed(ped, GetHashKey("GADGET_PARACHUTE"), 1, false)
        local ParachuteData = {
            outfitData = {
                ["bag"]   = { item = 7, texture = 0},  -- Nek / Das
            }
        }
        TriggerEvent('rl-clothing:client:loadOutfit', ParachuteData)
        ParachuteEquiped = true
        TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    end)
end)

RegisterNetEvent("consumables:client:ResetParachute")
AddEventHandler("consumables:client:ResetParachute", function()
    if ParachuteEquiped then 
        EquipParachuteAnim()
        RLCore.Functions.Progressbar("reset_parachute", "Packing Parachute", 40000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            local ped = GetPlayerPed(-1)
            TriggerEvent("debug", 'Consumables: Reset Parachute', 'success')
            TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["parachute"], "add")
            local ParachuteRemoveData = { 
                outfitData = { 
                    ["bag"] = { item = 0, texture = 0} -- Nek / Das
                }
            }
            TriggerEvent('rl-clothing:client:loadOutfit', ParachuteRemoveData)
            TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            TriggerServerEvent("rl-smallpenis:server:AddParachute")
            ParachuteEquiped = false
        end)
    else
        RLCore.Functions.Notify("You don't have a parachute!", "error")
    end
end)

-- RegisterNetEvent("consumables:client:UseRedSmoke")
-- AddEventHandler("consumables:client:UseRedSmoke", function()
--     if ParachuteEquiped then
--         local ped = GetPlayerPed(-1)
--         SetPlayerParachuteSmokeTrailColor(ped, 255, 0, 0)
--         SetPlayerCanLeaveParachuteSmokeTrail(ped, true)
--         TriggerEvent("inventory:client:Itembox", RLCore.Shared.Items["smoketrailred"], "remove")
--     else
--         RLCore.Functions.Notify("You must have a parachute to activate smoke!", "error")    
--     end
-- end)

RegisterNetEvent("consumables:client:UseArmor")
AddEventHandler("consumables:client:UseArmor", function()
    TriggerServerEvent("RLCore:Server:RemoveItem", "armor", 1)
    TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["armor"], "remove")
    TriggerEvent("debug", 'Consumables: Vest', 'success')
    RLCore.Functions.Progressbar("use_armor", "Armor", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('hospital:server:SetArmor', 75)
        SetPedArmour(GetPlayerPed(-1), 75)
    end)
end)

local currentVest = nil
local currentVestTexture = nil
RegisterNetEvent("consumables:client:UseHeavyArmor")
AddEventHandler("consumables:client:UseHeavyArmor", function()
    local ped = GetPlayerPed(-1)
    local PlayerData = RLCore.Functions.GetPlayerData()
    TriggerServerEvent("RLCore:Server:RemoveItem", "heavyarmor", 1)
    TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["heavyarmor"], "remove")
    TriggerEvent("debug", 'Consumables: Heavy Vest', 'success')

    RLCore.Functions.Progressbar("use_heavyarmor", "Armor", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('hospital:server:SetArmor', 100)
        SetPedArmour(ped, 100)
    end)
end)

RegisterNetEvent("consumables:client:ResetArmor")
AddEventHandler("consumables:client:ResetArmor", function()
    local ped = GetPlayerPed(-1)
    if currentVest ~= nil and currentVestTexture ~= nil then 
        RLCore.Functions.Progressbar("remove_armor", "Removing Armor", 2500, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerEvent("debug", 'Consumables: Reset Vest', 'success')
            SetPedComponentVariation(ped, 9, currentVest, currentVestTexture, 2)
            SetPedArmour(ped, 0)
            TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["heavyarmor"], "add")
            TriggerServerEvent("RLCore:Server:AddItem", "heavyarmor", 1)
        end)
    else
        RLCore.Functions.Notify("You are not wearing a vest.", "error")
    end
end)

RegisterNetEvent("consumables:client:DrinkAlcohol")
AddEventHandler("consumables:client:DrinkAlcohol", function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', {"drink"})
    RLCore.Functions.Progressbar("snort_coke", "Drinking", math.random(3000, 6000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("debug", 'Consumables: Alcohol', 'success')
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items[itemName], "remove")
        TriggerServerEvent("RLCore:Server:RemoveItem", itemName, 1)
        TriggerServerEvent("RLCore:Server:SetMetaData", "thirst", RLCore.Functions.GetPlayerData().metadata["thirst"] + Consumeables[itemName])
        alcoholCount = alcoholCount + 1
        if alcoholCount > 1 and alcoholCount < 4 then
            TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
        elseif alcoholCount >= 4 then
            TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
        end
        
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        RLCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('consumables:client:oxy')
AddEventHandler('consumables:client:oxy', function()
    RLCore.Functions.Progressbar("use_oxy", "Oxy", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        TriggerEvent("debug", 'Consumables: Oxy', 'success')
        StopAnimTask(GetPlayerPed(-1), "mp_suicide", "pill", 1.0)
        TriggerServerEvent("RLCore:Server:RemoveItem", "oxy", 1)
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["oxy"], "remove")
        OxyEffect()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "mp_suicide", "pill", 1.0)
        RLCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent("consumables:client:Cokebaggy")
AddEventHandler("consumables:client:Cokebaggy", function()
    RLCore.Functions.Progressbar("snort_coke", "Coke Gaming", math.random(5000, 6000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@nightclub@peds@",
        anim = "missfbi3_party_snort_coke_b_male3",
        flags = 50,
    }, {}, {}, function() -- Done
        TriggerEvent("debug", 'Consumables: Coke Baggy', 'success')
        StopAnimTask(GetPlayerPed(-1), "anim@amb@nightclub@peds@", "missfbi3_party_snort_coke_b_male3", 1.0)
        TriggerServerEvent("RLCore:Server:RemoveItem", "cokebaggy", 1)
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["cokebaggy"], "remove")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 200)
        CokeBaggyEffect()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "anim@amb@nightclub@peds@", "missfbi3_party_snort_coke_b_male3", 1.0)
        RLCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent("consumables:client:Crackbaggy")
AddEventHandler("consumables:client:Crackbaggy", function()
    RLCore.Functions.Progressbar("snort_coke", "Smoking Crack", math.random(5000, 6000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        TriggerEvent("debug", 'Consumables: Crack Baggy', 'success')
        StopAnimTask(GetPlayerPed(-1), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerServerEvent("RLCore:Server:RemoveItem", "crack_baggy", 1)
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["crack_baggy"], "remove")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
        CrackBaggyEffect()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        RLCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('consumables:client:EcstasyBaggy')
AddEventHandler('consumables:client:EcstasyBaggy', function()
    RLCore.Functions.Progressbar("use_ecstasy", "XTC Madness", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        TriggerEvent("debug", 'Consumables: Ecstasy Baggy', 'success')
        StopAnimTask(GetPlayerPed(-1), "mp_suicide", "pill", 1.0)
        TriggerServerEvent("RLCore:Server:RemoveItem", "xtcbaggy", 1)
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["xtcbaggy"], "remove")
        EcstasyEffect()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "mp_suicide", "pill", 1.0)
        RLCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent("consumables:client:Eat")
AddEventHandler("consumables:client:Eat", function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', {"eat"})
    RLCore.Functions.Progressbar("eat_something", "Eating", 2500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("debug", 'Consumables: ' .. RLCore.Shared.Items[itemName].label, 'success')
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("RLCore:Server:SetMetaData", "hunger", RLCore.Functions.GetPlayerData().metadata["hunger"] + Consumeables[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
    end)
end)

RegisterNetEvent("consumables:client:Drink")
AddEventHandler("consumables:client:Drink", function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', {"drink"})
    RLCore.Functions.Progressbar("drink_something", "Drinking", 2500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("debug", 'Consumables: ' .. RLCore.Shared.Items[itemName].label, 'success')
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("RLCore:Server:SetMetaData", "thirst", RLCore.Functions.GetPlayerData().metadata["thirst"] + Consumeables[itemName])
    end)
end)

function EcstasyEffect()
    local startStamina = 30
    SetFlash(0, 0, 500, 7000, 500)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end

    startStamina = 0
end

function OxyEffect()
	local ped = GetPlayerPed(-1)
	local playerPed = PlayerId()
	local maxHealth = GetEntityMaxHealth(PlayerPedId())
	local health = GetEntityHealth(PlayerPedId())
	local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 6))
	SetEntityHealth(PlayerPedId(), newHealth)
end

function JointEffect()
	local ped = GetPlayerPed(-1)
    AddArmourToPed(ped, 3)
    Citizen.Wait(3000)
    AddArmourToPed(ped, 3)
end

function CrackBaggyEffect()
    local startStamina = 8
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.4)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        if math.random(1, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 51 then
            AlienEffect()
        end
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function CokeBaggyEffect()
    local startStamina = 20
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        if math.random(1, 100) < 20 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 300) < 10 then
            AlienEffect()
            Citizen.Wait(math.random(3000, 6000))
        end
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Citizen.Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Citizen.Wait(math.random(5000, 8000))    
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end