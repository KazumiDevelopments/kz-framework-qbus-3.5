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
	SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
    RLCore.Functions.Progressbar("smoke_joint", "Smoking Joint", 2000, false, true, {
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
            TriggerEvent('animations:client:EmoteCommandStart', {"weed"})
        end
        TriggerEvent("evidence:client:SetStatus", "weedsmell", 300)
		TriggerEvent("stress:timed",2000,"WORLD_HUMAN_SMOKING_POT")
    end)
end)

RegisterNetEvent("client:cigar")
AddEventHandler("client:cigar", function()
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
		Citizen.Wait(2000)
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["cigar"], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"cigar"})
end)

RegisterNetEvent("client:cigarette")
AddEventHandler("client:cigarette", function()
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
		Citizen.Wait(2000)
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["ciggy"], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"smoke"})
end)


RegisterNetEvent("stress:timed")
AddEventHandler("stress:timed",function(alteredValue,scenario)
	local removedStress = 0
	Wait(1000)

	RLCore.Functions.Notify("Stress is being relieved")
	while true do
		removedStress = removedStress + 100
		if removedStress >= alteredValue then
			break
		end
        local armor = GetPedArmour(PlayerPedId())
        SetPedArmour(PlayerPedId(),armor+3)
		if scenario ~= "None" then
			if not IsPedUsingScenario(PlayerPedId(),scenario) then
				TriggerEvent("animation:cancel")
				break
			end
		end
		Citizen.Wait(1000)
	end
	TriggerServerEvent("server:alterStress",false,removedStress)
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
        RLCore.Functions.Notify("You are not wearing a vest..", "error")
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

function HealOxy()
    if not healing then
        healing = true
    else
        return
    end
    
    local count = 9
    while count > 0 do
        Citizen.Wait(1000)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 6) 
    end
    healing = false
end

RegisterNetEvent('consumables:client:oxy')
AddEventHandler('consumables:client:oxy', function()
    RLCore.Functions.Progressbar("use_oxy", "Healing", 2000, false, true, {
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
        ClearPedBloodDamage(PlayerPedId())
		HealOxy()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "mp_suicide", "pill", 1.0)
        RLCore.Functions.Notify("Canceled", "error")
    end)
end)

RegisterNetEvent('consumables:client:ifak')
AddEventHandler('consumables:client:ifak', function()
    RLCore.Functions.Progressbar("use_ifak", "Applying IFAK", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "amb@world_human_clipboard@male@idle_a",
		anim = "idle_c",
		flags = 50,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "amb@world_human_clipboard@male@idle_a", "idle_c", 1.0)
        TriggerServerEvent("RLCore:Server:RemoveItem", "ifak", 1)
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["ifak"], "remove")
        ClearPedBloodDamage(PlayerPedId())
		HealOxy()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "amb@world_human_clipboard@male@idle_a", "idle_c", 1.0)
        RLCore.Functions.Notify("Canceled", "error")
    end)
end)

RegisterNetEvent("consumables:client:Cokebaggy")
AddEventHandler("consumables:client:Cokebaggy", function()
    RLCore.Functions.Progressbar("snort_coke", "Coke Gaming", 5000, false, true, {
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
    RLCore.Functions.Progressbar("snort_coke", "Smoking Crack", 5000, false, true, {
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

RegisterNetEvent("consumables:client:methbag")
AddEventHandler("consumables:client:methbag", function()
    local finished = exports["rl-taskbarskill"]:taskBar(2500,10)
    if (finished == 100) then  
    RLCore.Functions.Progressbar("snort_meth", "💩 Smoking Ass Meth 💩", 1500, false, true, {
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
        TriggerServerEvent("RLCore:Server:RemoveItem", "methbag", 1)
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["methbag"], "remove")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
		TriggerEvent("evidence:client:SetStatus", "agitated", 300)
        MethBagEffect()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        RLCore.Functions.Notify("Canceled..", "error")
		end)
	end
end)

RegisterNetEvent('consumables:client:EcstasyBaggy')
AddEventHandler('consumables:client:EcstasyBaggy', function()
    RLCore.Functions.Progressbar("use_ecstasy", "XTC Madness", 2000, false, true, {
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
    --[[ TriggerEvent('animations:client:EmoteCommandStart', {"eat"})
    RLCore.Functions.Progressbar("eat_something", "Eating", 2500, false, true, {
        disableMovement = false,
        disableCarMovement = false, 
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("debug", 'Consumables: ' .. RLCore.Shared.Items[itemName].label, 'success')
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"}) ]]
        TriggerServerEvent("RLCore:Server:SetMetaData", "hunger", RLCore.Functions.GetPlayerData().metadata["hunger"] + Consumeables[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
    end)
end)

RegisterNetEvent("consumables:client:Drink")
AddEventHandler("consumables:client:Drink", function(itemName)
   --[[  TriggerEvent('animations:client:EmoteCommandStart', {"drink"})
    RLCore.Functions.Progressbar("drink_something", "Drinking", 2500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("debug", 'Consumables: ' .. RLCore.Shared.Items[itemName].label, 'success')
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"}) ]]
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
    exports["acidtrip"]:DoAcid(120000)
end

function Drugs1()
	StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
	StopScreenEffect("DrugsMichaelAliensFightIn")
	StopScreenEffect("DrugsMichaelAliensFight")
	StopScreenEffect("DrugsMichaelAliensFightOut")

end

function Drugs2()
	StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end

function RevertToStressMultiplier()

	local factor = (stresslevel / 2) / 10000
	local factor = 1.0 - factor


	if factor > 0.1 then

		SetSwimMultiplierForPlayer(PlayerId(), factor)
		SetRunSprintMultiplierForPlayer(PlayerId(), factor)
	else
		SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
	end

end

function CrackBaggyEffect()
    dstamina = 0
    stresslevel = 0

    Citizen.Wait(1000)
    RLCore.Functions.Notify('You sniffed the full bag! Get ready for a trip...', 'error')
    local death = math.random(1,99)
      if death <= 7 then
        RLCore.Functions.Notify('You should call a doctor, You dont feel so good.....', 'error')
        Citizen.Wait(10000)
        RLCore.Functions.Notify('You felt your heart skip a beat....', 'error')
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, 'heartrate', 1.0)
        Citizen.Wait(8000)
        SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
        DoScreenFadeOut(500)
        Citizen.Wait(500)
        DoScreenFadeIn(500)
        Citizen.Wait(8000)
        RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
        ResetPedMovementClipset(GetPlayerPed(-1))
        SetPedMovementClipset(GetPlayerPed(-1),"MOVE_M@DRUNK@VERYDRUNK", 0.8)
        SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
        StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
        Citizen.Wait(8000)
        SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
        DoScreenFadeOut(500)
        Citizen.Wait(500)
        DoScreenFadeIn(500)
        Citizen.Wait(8000) 
        SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
        Citizen.Wait(8000)
        SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
        DoScreenFadeOut(500)
        Citizen.Wait(500)
        DoScreenFadeIn(500)
        RLCore.Functions.Notify('YOU NEED MEDICAL ATTENTION', 'error')
        Citizen.Wait(6000)
        SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
        Citizen.Wait(15000)
        RLCore.Functions.Notify('CARDIAC ARREST....', 'error')
        SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
        Citizen.Wait(500)
        SetEntityHealth(GetPlayerPed(-1), 0)
        ResetPedMovementClipset(GetPlayerPed(-1))
        StopScreenEffect("DrugsTrevorClownsFight")
      else


      if math.random(100) > 50 then
          Drugs1()
      else
          Drugs2()
      end

      SetPedArmour( GetPlayerPed(-1), 100 )

      if stresslevel > 500 then
          SetRunSprintMultiplierForPlayer(PlayerId(), 1.08)
          dstamina = 200
      else
          SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
          dstamina = 200
      end

      while dstamina > 0 do

          Citizen.Wait(1000)
          RestorePlayerStamina(PlayerId(), 1.0)
          dstamina = dstamina - 1

          if IsPedRagdoll(GetPlayerPed(-1)) then
              SetPedToRagdoll(GetPlayerPed(-1), math.random(5), math.random(5), 3, 0, 0, 0)
          end

          if math.random(500) < 3 then
              if math.random(100) > 50 then
                  Drugs1()
              else
                  Drugs2()
              end
              Citizen.Wait(math.random(30000))
          end

          if math.random(100) > 75 and IsPedRunning(GetPlayerPed(-1)) then
              SetPedToRagdoll(GetPlayerPed(-1), math.random(1000), math.random(1000), 3, 0, 0, 0)
          end

      end

      dstamina = 0

      if IsPedRunning(GetPlayerPed(-1)) then
          SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
      end

      SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
      RevertToStressMultiplier()
    end
end

function MethBagEffect()
    local startStamina = 8
    TrevorEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(5, 100) < 51 then
            TrevorEffect()
        end
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    --exports["acidtrip"]:DoAcid(120000)
end

function CokeBaggyEffect()
    local startStamina = 8
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.4)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(5, 100) < 51 then
            AlienEffect()
        end
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Citizen.Wait(3000)
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Citizen.Wait(3000) 
	StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
	StopScreenEffect("DrugsMichaelAliensFightIn")
	StopScreenEffect("DrugsMichaelAliensFight")
	StopScreenEffect("DrugsMichaelAliensFightOut")
end

function TrevorEffect()
    StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
    Citizen.Wait(3000)
    StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
    Citizen.Wait(3000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end

local currentGear = {
    mask = 0,
    tank = 0,
    enabled = false
}

function DeleteGear()
	if currentGear.mask ~= 0 then
        DetachEntity(currentGear.mask, 0, 1)
        DeleteEntity(currentGear.mask)
		currentGear.mask = 0
    end
    
	if currentGear.tank ~= 0 then
        DetachEntity(currentGear.tank, 0, 1)
        DeleteEntity(currentGear.tank)
		currentGear.tank = 0
	end
end

--[[ RegisterNetEvent('oxygenmaskclient:UseGear')
AddEventHandler('oxygenmaskclient:UseGear', function(bool)
    if bool then
        GearAnim() 
        RLCore.Functions.Progressbar("equip_gear", "Oxygen Tank", 30000, false, true, {}, {}, {}, {}, function() -- Done
            DeleteGear()
            local maskModel = GetHashKey("p_d_scuba_mask_s")
            local tankModel = GetHashKey("p_s_scuba_tank_s")
    
            RequestModel(tankModel)
            while not HasModelLoaded(tankModel) do
                Citizen.Wait(1)
            end
            TankObject = CreateObject(tankModel, 1.0, 1.0, 1.0, 1, 1, 0)
            local bone1 = GetPedBoneIndex(GetPlayerPed(-1), 24818)
            AttachEntityToEntity(TankObject, GetPlayerPed(-1), bone1, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
            currentGear.tank = TankObject
    
            RequestModel(maskModel)
            while not HasModelLoaded(maskModel) do
                Citizen.Wait(1)
            end
            
            MaskObject = CreateObject(maskModel, 1.0, 1.0, 1.0, 1, 1, 0)
            local bone2 = GetPedBoneIndex(GetPlayerPed(-1), 12844)
            AttachEntityToEntity(MaskObject, GetPlayerPed(-1), bone2, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
            currentGear.mask = MaskObject
    
            SetEnableScuba(GetPlayerPed(-1), true)
            SetPedMaxTimeUnderwater(GetPlayerPed(-1), 2000.00)
            currentGear.enabled = true
            TriggerServerEvent('oxygengear:RemoveGear')
            ClearPedTasks(GetPlayerPed(-1))
			RLCore.Functions.Notify('/divingsuit to take off your diving suit!', 'error')
        end)
    else
        if currentGear.enabled then
            GearAnim()
            RLCore.Functions.Progressbar("remove_gear", "Oxygen Tank", 10000, false, true, {}, {}, {}, {}, function() -- Done
                DeleteGear()

                SetEnableScuba(GetPlayerPed(-1), false)
                SetPedMaxTimeUnderwater(GetPlayerPed(-1), 1.00)
                currentGear.enabled = false
                TriggerServerEvent('oxygengear:GiveBackGear')
                ClearPedTasks(GetPlayerPed(-1))
            end)
        else
            RLCore.Functions.Notify('You are not wearing an oxygen tank.', 'error')
        end
    end
end) ]]

function GearAnim()
    loadAnimDict("clothingshirt")    	
	TaskPlayAnim(GetPlayerPed(-1), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

--Bandanas
bandana = false

RegisterNetEvent('qb_bandana:bloodsbandana')
AddEventHandler('qb_bandana:bloodsbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 3, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

RegisterNetEvent('qb_bandana:greenbandana')
AddEventHandler('qb_bandana:greenbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 0, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

RegisterNetEvent('qb_bandana:ballasbandana')
AddEventHandler('qb_bandana:ballasbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 4, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

RegisterNetEvent('qb_bandana:vagosbandana')
AddEventHandler('qb_bandana:vagosbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 7, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

RegisterNetEvent('qb_bandana:cripsbandana')
AddEventHandler('qb_bandana:cripsbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 2, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

RegisterNetEvent('qb_bandana:whitebandana')
AddEventHandler('qb_bandana:whitebandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 1, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

RegisterNetEvent('qb_bandana:blackbandana')
AddEventHandler('qb_bandana:blackbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 3, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

RegisterNetEvent('qb_bandana:orangebandana')
AddEventHandler('qb_bandana:orangebandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
	if not bandana then
	RequestAnimDict(dict)
	TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	bandana = true
	SetPedPropIndex(GetPlayerPed(-1), 0, 14, 6, 2)
	elseif bandana then
	bandana = false
	RequestAnimDict(dict)
	TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	Wait (600)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
	end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end