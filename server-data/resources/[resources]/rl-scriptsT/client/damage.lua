
CreateThread(function()
	SetWeaponDamageModifier(`WEAPON_UNARMED`, 0.2) -- Melee
	SetWeaponDamageModifier(`WEAPON_BOTTLE`, 0.3) -- Melee
	SetWeaponDamageModifier(`WEAPON_FLASHLIGHT`, 0.3) -- Melee
	SetWeaponDamageModifier(`WEAPON_NIGHTSTICK`, 0.0) -- Melee
	SetWeaponDamageModifier(`WEAPON_HAMMER`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_CROWBAR`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_POOLCUE`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_GOLFCLUB`, 0.5) -- Melee
	SetWeaponDamageModifier(`WEAPON_BAT`, 0.5) -- Melee
	SetWeaponDamageModifier(`WEAPON_KNIFE`, 0.6) -- Melee
	SetWeaponDamageModifier(`WEAPON_HATCHET`, 0.0) -- Melee
	SetWeaponDamageModifier(`WEAPON_DAGGER`, 0.6) -- Melee
	SetWeaponDamageModifier(`WEAPON_SWITCHBLADE`, 0.6) -- Melee
	SetWeaponDamageModifier(`WEAPON_KNUCKLE`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_MACHETE`, 0.7) -- Melee
   	SetWeaponDamageModifier(`WEAPON_STUNGUN`, 0.0) -- Pistol / Melee
	SetWeaponDamageModifier(`WEAPON_SMOKEGRENADE`, 0.1) -- Utility
	SetWeaponDamageModifier(`WEAPON_HIT_BY_WATER_CANNON`, 0.0) -- Fire Truck Cannon

	while true do
		Wait(0)
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		SetPedSuffersCriticalHits(PlayerPedId(), false)
	end
end)