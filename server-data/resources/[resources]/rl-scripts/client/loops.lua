local CrossHair = false

RegisterNetEvent("CrossHair")
AddEventHandler("CrossHair", function()
	CrossHair = not CrossHair
end)

SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))

SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))

function RemoveWeaponDrops()
	local pickupList = {`PICKUP_AMMO_BULLET_MP`,`PICKUP_AMMO_FIREWORK`,`PICKUP_AMMO_FLAREGUN`,`PICKUP_AMMO_GRENADELAUNCHER`,`PICKUP_AMMO_GRENADELAUNCHER_MP`,`PICKUP_AMMO_HOMINGLAUNCHER`,`PICKUP_AMMO_MG`,`PICKUP_AMMO_MINIGUN`,`PICKUP_AMMO_MISSILE_MP`,`PICKUP_AMMO_PISTOL`,`PICKUP_AMMO_RIFLE`,`PICKUP_AMMO_RPG`,`PICKUP_AMMO_SHOTGUN`,`PICKUP_AMMO_SMG`,`PICKUP_AMMO_SNIPER`,`PICKUP_ARMOUR_STANDARD`,`PICKUP_CAMERA`,`PICKUP_CUSTOM_SCRIPT`,`PICKUP_GANG_ATTACK_MONEY`,`PICKUP_HEALTH_SNACK`,`PICKUP_HEALTH_STANDARD`,`PICKUP_MONEY_CASE`,`PICKUP_MONEY_DEP_BAG`,`PICKUP_MONEY_MED_BAG`,`PICKUP_MONEY_PAPER_BAG`,`PICKUP_MONEY_PURSE`,`PICKUP_MONEY_SECURITY_CASE`,`PICKUP_MONEY_VARIABLE`,`PICKUP_MONEY_WALLET`,`PICKUP_PARACHUTE`,`PICKUP_PORTABLE_CRATE_FIXED_INCAR`,`PICKUP_PORTABLE_CRATE_UNFIXED`,`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR`,`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL`,`PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW`,`PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE`,`PICKUP_PORTABLE_PACKAGE`,`PICKUP_SUBMARINE`,`PICKUP_VEHICLE_ARMOUR_STANDARD`,`PICKUP_VEHICLE_CUSTOM_SCRIPT`,`PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW`,`PICKUP_VEHICLE_HEALTH_STANDARD`,`PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW`,`PICKUP_VEHICLE_MONEY_VARIABLE`,`PICKUP_VEHICLE_WEAPON_APPISTOL`,`PICKUP_VEHICLE_WEAPON_ASSAULTSMG`,`PICKUP_VEHICLE_WEAPON_COMBATPISTOL`,`PICKUP_VEHICLE_WEAPON_GRENADE`,`PICKUP_VEHICLE_WEAPON_MICROSMG`,`PICKUP_VEHICLE_WEAPON_MOLOTOV`,`PICKUP_VEHICLE_WEAPON_PISTOL`,`PICKUP_VEHICLE_WEAPON_PISTOL50`,`PICKUP_VEHICLE_WEAPON_SAWNOFF`,`PICKUP_VEHICLE_WEAPON_SMG`,`PICKUP_VEHICLE_WEAPON_SMOKEGRENADE`,`PICKUP_VEHICLE_WEAPON_STICKYBOMB`,`PICKUP_WEAPON_ADVANCEDRIFLE`,`PICKUP_WEAPON_APPISTOL`,`PICKUP_WEAPON_ASSAULTRIFLE`,`PICKUP_WEAPON_ASSAULTSHOTGUN`,`PICKUP_WEAPON_ASSAULTSMG`,`PICKUP_WEAPON_AUTOSHOTGUN`,`PICKUP_WEAPON_BAT`,`PICKUP_WEAPON_BATTLEAXE`,`PICKUP_WEAPON_BOTTLE`,`PICKUP_WEAPON_BULLPUPRIFLE`,`PICKUP_WEAPON_BULLPUPSHOTGUN`,`PICKUP_WEAPON_CARBINERIFLE`,`PICKUP_WEAPON_COMBATMG`,`PICKUP_WEAPON_COMBATPDW`,`PICKUP_WEAPON_COMBATPISTOL`,`PICKUP_WEAPON_COMPACTLAUNCHER`,`PICKUP_WEAPON_COMPACTRIFLE`,`PICKUP_WEAPON_CROWBAR`,`PICKUP_WEAPON_DAGGER`,`PICKUP_WEAPON_DBSHOTGUN`,`PICKUP_WEAPON_FIREWORK`,`PICKUP_WEAPON_FLAREGUN`,`PICKUP_WEAPON_FLASHLIGHT`,`PICKUP_WEAPON_GRENADE`,`PICKUP_WEAPON_GRENADELAUNCHER`,`PICKUP_WEAPON_GUSENBERG`,`PICKUP_WEAPON_GOLFCLUB`,`PICKUP_WEAPON_HAMMER`,`PICKUP_WEAPON_HATCHET`,`PICKUP_WEAPON_HEAVYPISTOL`,`PICKUP_WEAPON_HEAVYSHOTGUN`,`PICKUP_WEAPON_HEAVYSNIPER`,`PICKUP_WEAPON_HOMINGLAUNCHER`,`PICKUP_WEAPON_KNIFE`,`PICKUP_WEAPON_KNUCKLE`,`PICKUP_WEAPON_MACHETE`,`PICKUP_WEAPON_MACHINEPISTOL`,`PICKUP_WEAPON_MARKSMANPISTOL`,`PICKUP_WEAPON_MARKSMANRIFLE`,`PICKUP_WEAPON_MG`,`PICKUP_WEAPON_MICROSMG`,`PICKUP_WEAPON_MINIGUN`,`PICKUP_WEAPON_MINISMG`,`PICKUP_WEAPON_MOLOTOV`,`PICKUP_WEAPON_MUSKET`,`PICKUP_WEAPON_NIGHTSTICK`,`PICKUP_WEAPON_PETROLCAN`,`PICKUP_WEAPON_PIPEBOMB`,`PICKUP_WEAPON_PISTOL`,`PICKUP_WEAPON_PISTOL50`,`PICKUP_WEAPON_POOLCUE`,`PICKUP_WEAPON_PROXMINE`,`PICKUP_WEAPON_PUMPSHOTGUN`,`PICKUP_WEAPON_RAILGUN`,`PICKUP_WEAPON_REVOLVER`,`PICKUP_WEAPON_RPG`,`PICKUP_WEAPON_SAWNOFFSHOTGUN`,`PICKUP_WEAPON_SMG`,`PICKUP_WEAPON_SMOKEGRENADE`,`PICKUP_WEAPON_SNIPERRIFLE`,`PICKUP_WEAPON_SNSPISTOL`,`PICKUP_WEAPON_SPECIALCARBINE`,`PICKUP_WEAPON_STICKYBOMB`,`PICKUP_WEAPON_STUNGUN`,`PICKUP_WEAPON_SWITCHBLADE`,`PICKUP_WEAPON_VINTAGEPISTOL`,`PICKUP_WEAPON_WRENCH`}
	local PlayerPed = GetPlayerPed(-1)
	local pedPos = GetEntityCoords(PlayerPed, false)

	for a = 1, #pickupList do 
		if IsPickupWithinRadius(pickupList[a], pedPos.x, pedPos.y, pedPos.z, 200.0) then
			RemoveAllPickupsOfType(pickupList[a])
		end
	end
end

AddEventHandler("playerSpawned", function()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, true)
end)

Citizen.CreateThread( function()
	local resetcounter = 0
	local jumpDisabled = false
  	while true do 
    Citizen.Wait(1)
		if jumpDisabled and resetcounter > 0 and IsPedJumping(GetPlayerPed(-1)) then	
			SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 3, 0, 0, 0)
			print("jump")
			resetcounter = 0
		end
		if not jumpDisabled and IsPedJumping(GetPlayerPed(-1)) then
			if math.random(2) == 2 then
				jumpDisabled = true
			end
			resetcounter = 1000
			Citizen.Wait(1200)
		end
		if resetcounter > 0 then
			resetcounter = resetcounter - 1
		else
			if jumpDisabled then
				resetcounter = 0
				jumpDisabled = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		-- Engine
		local ped = GetPlayerPed(-1)

		if DoesEntityExist(ped) and IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) and not IsPauseMenuActive() then
			local veh = GetVehiclePedIsIn(ped, true)
			local engineWasRunning = GetIsVehicleEngineRunning(veh)
			if engineWasRunning then
				SetVehicleEngineOn(veh, true, true, true)
			end

			
			Citizen.Wait(2000)
		end
	end
end)

Citizen.CreateThread(function()
	for i = 1, 32 do
		Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
	end
	
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed(-1)

		local weapon = GetSelectedPedWeapon(ped)
		if weapon ~= GetHashKey("WEAPON_UNARMED") then
			if IsPedArmed(ped, 6) then
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
			end

			--[[ if weapon == GetHashKey("WEAPON_FIREEXTINGUISHER") or  weapon == GetHashKey("WEAPON_PETROLCAN") then
				if IsPedShooting(ped) then
					SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_FIREEXTINGUISHER"))
					SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_PETROLCAN"))
				end
			end ]]
		end
 
		
		if GetPlayerWantedLevel(PlayerId()) ~= 0 then
			ClearPlayerWantedLevel(PlayerId())
		end
		local playerLocalisation = GetEntityCoords(ped)
		ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
		
		-- Hud Stuff
		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(2)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(13)

		if not CrossHair then
			HideHudComponentThisFrame(14)
		end

		HideHudComponentThisFrame(17)
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        HideHudComponentThisFrame(21)
		HideHudComponentThisFrame(22)
		DisplayAmmoThisFrame(true)

		local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if DoesEntityExist(veh) and not IsEntityDead(veh) then
            local model = GetEntityModel(veh)
            -- If it's not a boat, plane or helicopter, and the vehilce is off the ground with ALL wheels, then block steering/leaning left/right/up/down.
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and not IsThisModelABike(model) and IsEntityInAir(veh)  then
                DisableControlAction(0, 59) -- leaning left/right
                DisableControlAction(0, 60) -- leaning up/down
            end
		end
		
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = GetPlayerPed(-1)
		
		if IsPedBeingStunned(ped) then
			SetPedMinGroundTimeForStungun(GetPlayerPed(-1),1000)
		else
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		RemoveWeaponDrops()
		DistantCopCarSirens(false) -- Disables ambient sirens.
	end
end)

function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  AddTextEntry('FE_THDR_GTAO', 'ConnectRP')
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		for i = 1, 12 do
			EnableDispatchService(i, false)
		end
		SetAudioFlag('DisableFlightMusic', true)
		SetPlayerWantedLevel(PlayerId(), 0, false)
		SetPlayerWantedLevelNow(PlayerId(), false)
		SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
		SetCreateRandomCops(false)
        SetCreateRandomCopsNotOnScenarios(false)
		SetCreateRandomCopsOnScenarios(false)
		SetVehicleModelIsSuppressed(GetHashKey("sentinel"), true)
	end
end) 

--OutOfBreathe

--[[ local isSprinting = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100) -- check every 100 ticks, performance matters
		local letSleep = true
		local stamina = GetPlayerSprintStaminaRemaining(PlayerId())
		if isSprinting then
			letSleep = false
			if stamina == 100 then
			RequestAnimDict("re@construction")
			while not HasAnimDictLoaded("re@construction") do
			Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "re@construction", "out_of_breath", 8.0, 8.0, -1, 32, 0, false, false, false)
			end
		end
		if letSleep then
		Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
	local lPed = GetPlayerPed(-1)
	isSprinting = IsPedSprinting(lPed)
        Citizen.Wait(500)
    end
end) ]]

--[[ Citizen.CreateThread(function() -- While shooting
    while true do
        local ped = PlayerPedId()
        local status = IsPedShooting(ped)
        local silenced = IsPedCurrentWeaponSilenced(ped)

        if status and not silenced then
            TriggerServerEvent('hud:server:GainStress', math.random(2, 6))
            Citizen.Wait(2000)
        else
            Citizen.Wait(5)
        end
    end
end) ]]

Citizen.CreateThread(function() -- Aiming with a melee, hitting with a melee or getting hit by a melee
    while true do
        local ped = PlayerPedId()
        local status = IsPedInMeleeCombat(ped)

        if status then
            TriggerServerEvent('hud:server:GainStress', math.random(2, 6))
            Citizen.Wait(5000)
        else
            Citizen.Wait(5)
        end
    end
end)

--[[ Citizen.CreateThread(function() -- Staying still or walking
    while true do
        local ped = PlayerPedId()
        local status = IsPedStill(ped)
        local status_w = IsPedArmed(ped, 4)
        local status2 = IsPedWalking(ped)
		local status_v = IsPedInAnyVehicle(ped, false)

        if status and not status_w and not status_v and not GetPedStealthMovement(ped) then -- durmak // still
            Citizen.Wait(15000)
            TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
            Citizen.Wait(15000)
        elseif status2 and not status_w and not GetPedStealthMovement(ped) then -- walking
            Citizen.Wait(15000)
            TriggerServerEvent('hud:server:RelieveStress', math.random(2, 6))
            Citizen.Wait(15000)
        else
            Citizen.Wait(5)
        end
    end
end) ]]

Citizen.CreateThread(function() -- Skydiving with parachute
    while true do
        local ped = PlayerPedId()
        local status = GetPedParachuteState(ped)

        if status == 0 then -- paraşütle dalış // freefall with chute (not falling without it)
            TriggerServerEvent('hud:server:GainStress', math.random(2, 6))
            Citizen.Wait(5000)
        elseif status == 1 or status == 2 then -- paraşüt açık // opened chute
            TriggerServerEvent('hud:server:GainStress', math.random(2, 4))
            Citizen.Wait(5000)
        else
            Citizen.Wait(5000) -- refresh rate is low on this one since it's not so common to skydive in RP servers
        end
    end
end)

Citizen.CreateThread(function() -- Stealth mode
    while true do
        local ped = PlayerPedId()
        local status = GetPedStealthMovement(ped)

        if status then
            TriggerServerEvent('hud:server:GainStress', math.random(1, 4))
            Citizen.Wait(8000)
        else
            Citizen.Wait(5) -- refresh rate
        end
    end
end)

Citizen.CreateThread(function() -- You can use this as a template if you want to make an animation stressful or stress reliever
    while true do
        local ped = PlayerPedId()
        local status = IsEntityPlayingAnim(ped, "timetable@tracy@sleep@", "idle_c", 3)

        if status then
            Citizen.Wait(20000)
            TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
        else
            Citizen.Wait(5) -- refresh rate
        end
    end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(2500)
        ClearAreaOfPeds(969.40423, -124.5897, 74.031448, 50.0, 1)
    end
end)


local shot = false
local check = false
local check2 = false
local count = 0

Citizen.CreateThread(function()
	while true do
		SetBlackout(false)
		Citizen.Wait( 1 )
		if IsPlayerFreeAiming(PlayerId()) then
		    if GetFollowPedCamViewMode() == 4 and check == false then
			    check = false
			else
			    SetFollowVehicleCamViewMode(4)
			    check = true
			end
		else
		    if check == true then
		        SetFollowVehicleCamViewMode(0)
				check = false
			end
		end
	end
end )

Citizen.CreateThread(function()
	SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0)
end)

local INPUT_AIM = 0
local INPUT_AIM = 0
local UseFPS = false
local justpressed = 0

local disable = 0
Citizen.CreateThread( function()

  while true do    
    
    Citizen.Wait(0)


        if IsControlPressed(0, INPUT_AIM) then
          justpressed = justpressed + 1
        end

        if IsControlJustReleased(0, INPUT_AIM) then

        	if justpressed < 15 then
        		UseFPS = true
        	end
        	justpressed = 0
        end

        if GetFollowPedCamViewMode() == 1 or GetFollowVehicleCamViewMode() == 1 then
        	Citizen.Wait(1)
        	SetFollowPedCamViewMode(0)
        	SetFollowVehicleCamViewMode(0)
        end


        if UseFPS then
        	if GetFollowPedCamViewMode() == 0 or GetFollowVehicleCamViewMode() == 0 then
        		Citizen.Wait(0)
        		
        		SetFollowPedCamViewMode(4)
        		SetFollowVehicleCamViewMode(4)
        	else
        		Citizen.Wait(0)
        		
        		SetFollowPedCamViewMode(0)
        		SetFollowVehicleCamViewMode(0)
        	end
    		UseFPS = false
        end


        if IsPedArmed(ped,1) or not IsPedArmed(ped,7) then
            if IsControlJustPressed(0,24) or IsControlJustPressed(0,141) or IsControlJustPressed(0,142) or IsControlJustPressed(0,140)  then
               disable = 50
            end
        end

        if disable > 0 then
            disable = disable - 1
            DisableControlAction(0,24)
            DisableControlAction(0,140)
            DisableControlAction(0,141)
            DisableControlAction(0,142)
        end
  end

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedArmed(PlayerPedId(), 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
    end
end)