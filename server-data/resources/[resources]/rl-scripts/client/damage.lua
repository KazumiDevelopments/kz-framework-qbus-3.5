CreateThread(function()
	SetWeaponDamageModifier(`WEAPON_UNARMED`, 0.2) -- Melee
	SetWeaponDamageModifier(`WEAPON_BOTTLE`, 0.45) -- Melee
	SetWeaponDamageModifier(`WEAPON_FLASHLIGHT`, 0.45) -- Melee
	SetWeaponDamageModifier(`WEAPON_KNUCKLE`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_NIGHTSTICK`, 0.6) -- Melee
	SetWeaponDamageModifier(`WEAPON_HAMMER`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_CROWBAR`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_POOLCUE`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_GOLFCLUB`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_BAT`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_KNIFE`, 0.6) -- Melee
	SetWeaponDamageModifier(`WEAPON_DAGGER`, 0.6) -- Melee
	SetWeaponDamageModifier(`WEAPON_SWITCHBLADE`, 0.6) -- Melee
	SetWeaponDamageModifier(`WEAPON_REVOLVER`, 1.0) -- Pistol / Melee
	SetWeaponDamageModifier(`WEAPON_REVOLVER_MK2`, 1.0) -- Pistol / Melee
	SetWeaponDamageModifier(`WEAPON_MACHETE`, 0.7) -- Melee
	SetWeaponDamageModifier(`WEAPON_HATCHET`, 0.7) -- 
	SetWeaponDamageModifier(`WEAPON_MICROSMG`, 1.19)
	SetWeaponDamageModifier(`WEAPON_MACHINEPISTOL`, 1.15)
	SetWeaponDamageModifier(`WEAPON_MINISMG`, 1.16)
	SetWeaponDamageModifier(`WEAPON_ASSAULTSMG`, 1.13)
	SetWeaponDamageModifier(`WEAPON_SMG`, 1.10)
	SetWeaponDamageModifier(`WEAPON_SMG_MK2`, 1.13)
	SetWeaponDamageModifier(`WEAPON_COMBATPDW`, 1.02)
	SetWeaponDamageModifier(`WEAPON_GUSENBERG`, 1.05)
	SetWeaponDamageModifier(`WEAPON_VINTAGEPISTOL`, 1.10)
	SetWeaponDamageModifier(`WEAPON_APPISTOL`, 1.17)
	SetWeaponDamageModifier(`WEAPON_HEAVYPISTOL`, 1.19)
	SetWeaponDamageModifier(`WEAPON_COMBATPISTOL`, 1.12)
	SetWeaponDamageModifier(`WEAPON_VINTAGEPISTOL`, 1.10)
	SetWeaponDamageModifier(`WEAPON_PISTOL`, 1.09)
	SetWeaponDamageModifier(`WEAPON_SNSPISTOL`, 1.0)
	SetWeaponDamageModifier(`WEAPON_PISTOL_MK2`, 1.18)
   	SetWeaponDamageModifier(`WEAPON_STUNGUN`, 0.0) -- Pistol / Melee
	SetWeaponDamageModifier(`WEAPON_SMOKEGRENADE`, 0.1) -- Utility
	SetWeaponDamageModifier(`WEAPON_SNOWBALL`, 0.0) -- Utility
	SetWeaponDamageModifier(`WEAPON_HIT_BY_WATER_CANNON`, 0.0) -- Fire Truck Cannon

	while true do
		Wait(0)
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		SetPedSuffersCriticalHits(PlayerPedId(), false)
	end
end)

--[[ local weapons = {
    ['WEAPON_UNARMED'] = 0.3, 
    ['WEAPON_ADVANCEDRIFLE'] = 0.45,
    ['WEAPON_APPISTOL'] = 0.4,
    ['WEAPON_ASSAULTRIFLE'] = 0.65,
    ['WEAPON_ASSAULTSHOTGUN'] = 0.65,
    ['WEAPON_BAT'] = 0.45,
    ['WEAPON_BOTTLE'] = 0.45,
    ['WEAPON_BULLPUPRIFLE'] = 0.65,
    ['WEAPON_BULLPUPSHOTGUN'] = 0.65,
    ['WEAPON_CARBINERIFLE'] = 0.65,
    ['WEAPON_CARBINERIFLE_MK2'] = 0.65,
    ['WEAPON_COMBATMG'] = 0.65,
    ['WEAPON_COMBATPDW'] = 0.65, 
    ['WEAPON_COMBATPISTOL'] = 0.75,
    ['WEAPON_COMPACTLAUNCHER'] = 0.65,
    ['WEAPON_COMPACTRIFLE'] = 0.65,
    ['WEAPON_CROWBAR'] = 0.45,
    ['WEAPON_DAGGER'] = 0.45,
    ['WEAPON_DBSHOTGUN'] = 0.65,
    ['WEAPON_DIGISCANNER'] = 0.65,
    ['WEAPON_DOUBLEACTION'] = 0.65,
    ['WEAPON_FIREWORK'] = 0.65,
    ['WEAPON_FLASHLIGHT'] = 0.45,
    ['WEAPON_GOLFCLUB'] = 0.45,
    ['WEAPON_GRENADELAUNCHER'] = 0.65,
    ['WEAPON_GUSENBURG'] = 0.65,
    ['WEAPON_HAMMER'] = 0.45,
    ['WEAPON_HATCHET'] = 0.45,
    ['WEAPON_HEAVYPISTOL'] = 0.7,
    ['WEAPON_HEAVYSHOTGUN'] = 0.65,
    ['WEAPON_HEAVYSNIPER'] = 0.65,
    ['WEAPON_HOMINGLAUNCHER'] = 0.65,
    ['WEAPON_KNIFE'] = 0.65,
    ['WEAPON_KNUCKLE'] = 0.5,
    ['WEAPON_MACHETE'] = 0.65,
    ['WEAPON_MACHINEPISTOL'] = 0.65,
    ['WEAPON_MARKSMANPISTOL'] = 0.65,
    ['WEAPON_MARKSMANRIFLE'] = 0.65,
    ['WEAPON_MG'] = 0.65,
    ['WEAPON_MICROSMG'] = 0.65,
    ['WEAPON_MINISMG'] = 0.65,
    ['WEAPON_NIGHTSTICK'] = 0.65,
    ['WEAPON_PETROLCAN'] = 0.65,
    ['WEAPON_PISTOL'] = 0.65,
    ['WEAPON_PISTOL_MK2'] = 0.8,
    ['WEAPON_PISTOL50'] = 0.65,
    ['WEAPON_POOLCUE'] = 0.65,
    ['WEAPON_PUMPSHOTGUN'] = 0.65,
    ['WEAPON_REVOLVER'] = 0.5,
    ['WEAPON_RPG'] = 0.65,
    ['WEAPON_SAWNOFFSHOTGUN'] = 0.65,
    ['WEAPON_SMG'] = 0.45,
    ['WEAPON_SMG_MK2'] = 0.45,
    ['WEAPON_ASSAULTSMG'] = 0.70,
    ['WEAPON_SNIPERRIFLE'] = 0.65,
    ['WEAPON_SPECIALCARBINE'] = 0.65,
    ['WEAPON_SWITCHBLADE'] = 0.65,
    ['WEAPON_VINTAGEPISTOL'] = 0.65,
    ['WEAPON_WRENCH'] = 0.65,
    ['WEAPON_SNSPISTOL'] = 0.55,

}

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(weapons) do
            N_0x4757f00bc6323cfe(GetHashKey(k), v)
            SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		    SetPedSuffersCriticalHits(PlayerPedId(), false)
        Wait(0)
        end
    end
end) ]]