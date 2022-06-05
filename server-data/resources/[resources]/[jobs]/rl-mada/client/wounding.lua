WeaponDamageList = {
	["WEAPON_UNARMED"] = "Fist",
	["WEAPON_ANIMAL"] = "Bite wound from an animal",
	["WEAPON_COUGAR"] = "Bite wouund from a cougar",
	["WEAPON_KNIFE"] = "Knife Wound",
    ["WEAPON_NIGHTSTICK"] = "Wound from a stick or something",
    ["WEAPON_BREAD"] = "Dent in your head from a baguette",
	["WEAPON_HAMMER"] = "Wound from a hammer or something",
	["WEAPON_BAT"] = "Wound from a bat or something",
	["WEAPON_GOLFCLUB"] = "Wound from a golf club or something",
	["WEAPON_CROWBAR"] = "Wound from steel or something",
	["WEAPON_PISTOL"] = "Wound by an firearm",
	["WEAPON_COMBATPISTOL"] = "Wound by an firearm",
	["WEAPON_APPISTOL"] = "Wound by an firearm",
	["WEAPON_PISTOL50"] = "Wound by an firearm",
	["WEAPON_MICROSMG"] = "Wound by an firearm",
	["WEAPON_SMG"] = "Wound by an firearm",
	["WEAPON_SMG_MK2"] = "Wound by an firearm",
	["WEAPON_ASSAULTSMG"] = "Wound by an firearm",
	["WEAPON_ASSAULTRIFLE"] = "Wound by an firearm",
	["WEAPON_ASSAULTRIFLE_MK2"] = "Wound by an firearm",
	["WEAPON_CARBINERIFLE"] = "Wound by an firearm",
	["WEAPON_CARBINERIFLE_MK2"] = "Wound by an firearm",
	["WEAPON_ADVANCEDRIFLE"] = "Wound by an firearm",
	["WEAPON_MG"] = "Wound by an firearm",
	["WEAPON_COMBATMG"] = "Wound by an firearm",
	["WEAPON_PUMPSHOTGUN"] = "Wound by an firearm",
	["WEAPON_SAWNOFFSHOTGUN"] = "Wound by an firearm",
	["WEAPON_ASSAULTSHOTGUN"] = "Wound by an firearm",
	["WEAPON_BULLPUPSHOTGUN"] = "Wound by an firearm",
	["WEAPON_STUNGUN"] = "Taser Print",
	["WEAPON_SNIPERRIFLE"] = "Sniper Bullet Wound",
	["WEAPON_HEAVYSNIPER"] = "Sniper Bullet Wound",
	["WEAPON_REMOTESNIPER"] = "Sniper Bullet Wound",
	["WEAPON_GRENADELAUNCHER"] = "Burns and fragments",
	["WEAPON_GRENADELAUNCHER_SMOKE"] = "Smoke Damage",
	["WEAPON_RPG"] = "Burns and fragments",
	["WEAPON_STINGER"] = "Burns and fragments",
	["WEAPON_MINIGUN"] = "Wounded Body by lots of bullets",
	["WEAPON_GRENADE"] = "Burns and fragments",
	["WEAPON_STICKYBOMB"] = "Burns and fragments",
	["WEAPON_SMOKEGRENADE"] = "Smoke Damage",
	["WEAPON_BZGAS"] = "Gas Damage",
	["WEAPON_MOLOTOV"] = "Several Burns",
	["WEAPON_FIREEXTINGUISHER"] = "Sprayed by Fire extinguisher",
	["WEAPON_PETROLCAN"] = "Petrol Can Damage",
	["WEAPON_FLARE"] = "Flare Damage",
	["WEAPON_BARBED_WIRE"] = "Barbed Wire Damage",
	["WEAPON_DROWNING"] = "Drowned",
	["WEAPON_DROWNING_IN_VEHICLE"] = "Drowned",
	["WEAPON_BLEEDING"] = "Lost lots of blood",
	["WEAPON_ELECTRIC_FENCE"] = "Electric Fence Wounds",
	["WEAPON_EXPLOSION"] = "Lots of burns (van explosieve)",
	["WEAPON_FALL"] = "Broken Bones",
	["WEAPON_EXHAUSTION"] = "Died of Exhaustion",
	["WEAPON_HIT_BY_WATER_CANNON"] = "Water Cannon Prints",
	["WEAPON_RAMMED_BY_CAR"] = "Car Accident",
	["WEAPON_RUN_OVER_BY_CAR"] = "Hit by a vehicle",
	["WEAPON_HELI_CRASH"] = "Helicopter crash",
	["WEAPON_FIRE"] = "Lots of burns",
}

local prevPos = nil

local healing = false
RegisterNetEvent("ems:healpassed")
AddEventHandler("ems:healpassed", function()
    HealSlow()
end)

function HealSlow()
    if not healing then
        healing = true
    else
        return
    end
    
    local count = 30
    while count > 0 do
        Citizen.Wait(1000)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1) 
    end
    healing = false
end

function HealMedkit()
    if not healing then
        healing = true
    else
        return
    end
    
    local count = 45
    while count > 0 do
        Citizen.Wait(1000)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1) 
    end
    healing = false
end

function HealFirstAid()
    if not healing then
        healing = true
    else
        return
    end
    
    local count = 40
    while count > 0 do
        Citizen.Wait(1000)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1) 
    end
    healing = false
end

RegisterNetEvent('hospital:client:UseBandage')
AddEventHandler('hospital:client:UseBandage', function()
    RLCore.Functions.Progressbar("use_bandage", "Healing", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "amb@world_human_clipboard@male@idle_a",
		anim = "idle_c",
		flags = 50,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "amb@world_human_clipboard@male@idle_a", "idle_c", 1.0)
        TriggerServerEvent("RLCore:Server:RemoveItem", "bandage", 1)
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["bandage"], "remove")
        --SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 10)
		ClearPedBloodDamage(PlayerPedId())
		HealSlow()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@world_human_clipboard@male@idle_a", "idle_c", 1.0)
        RLCore.Functions.Notify("Canceled", "error")
    end)
end)

RegisterNetEvent('hospital:client:UseFirstAid')
AddEventHandler('hospital:client:UseFirstAid', function()
    RLCore.Functions.Progressbar("use_firstaid", "Healing", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "amb@world_human_clipboard@male@idle_a",
		anim = "idle_c",
		flags = 50,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "amb@world_human_clipboard@male@idle_a", "idle_c", 1.0)
        TriggerServerEvent("RLCore:Server:RemoveItem", "firstaid", 1)
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["firstaid"], "remove")
        --SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 40)
		ClearPedBloodDamage(PlayerPedId())
		HealFirstAid()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@world_human_clipboard@male@idle_a", "idle_c", 1.0)
        RLCore.Functions.Notify("Canceled", "error")
    end)
end)

RegisterNetEvent('hospital:client:UseMedkit')
AddEventHandler('hospital:client:UseMedkit', function()
    RLCore.Functions.Progressbar("use_medkit", "Healing", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "amb@world_human_clipboard@male@idle_a",
		anim = "idle_c",
		flags = 50,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "amb@world_human_clipboard@male@idle_a", "idle_c", 1.0)
        TriggerServerEvent("RLCore:Server:RemoveItem", "medkit", 1)
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["medkit"], "remove")
        --SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 45)
		ClearPedBloodDamage(PlayerPedId())
		HealMedkit()

        SetPlayerSprint(PlayerId(), true)
        ResetPedMovementClipset(PlayerPedId())
        TriggerEvent("dpemotes:WalkCommandStart")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "amb@world_human_clipboard@male@idle_a", "idle_c", 1.0)
        RLCore.Functions.Notify("Canceled", "error")
    end)
end)

RegisterNetEvent('hospital:client:UsePainkillers')
AddEventHandler('hospital:client:UsePainkillers', function()
    RLCore.Functions.Progressbar("use_bandage", "Consuming Painkillers", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        TriggerServerEvent("RLCore:Server:RemoveItem", "painkillers", 1)
        TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["painkillers"], "remove")
    
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        RLCore.Functions.Notify("Canceled", "error")
    end)
end)