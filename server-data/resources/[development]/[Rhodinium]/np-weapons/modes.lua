local FireRateTypes = {
	{ label = "Single Fire", name = "SINGLE_FIRE", delay = 30 },
	{ label = "Burst Fire", name = "BURST_FIRE", delay = 300 },
	{ label = "Full Auto", name = "FULL_AUTO_FIRE", delay = 1 }
}

local AllowedModes = {
	-- MPX (PD Issued)
	["171789620"] = {
		["SINGLE_FIRE"] = true,
		["BURST_FIRE"] = true,
		["FULL_AUTO_FIRE"] = true
	},

	-- PD M4
	["1192676223"] = {
		["SINGLE_FIRE"] = true,
		["BURST_FIRE"] = true,
		["FULL_AUTO_FIRE"] = true
	},

	["-1719357158"] = {
		["SINGLE_FIRE"] = true,
		["BURST_FIRE"] = false,
		["FULL_AUTO_FIRE"] = false
	},

	-- AK47
	["-1074790547"] = {
		["SINGLE_FIRE"] = false,
		["BURST_FIRE"] = false,
		["FULL_AUTO_FIRE"] = true
	},

	-- M70
	["497969164"] = {
		["SINGLE_FIRE"] = false,
		["BURST_FIRE"] = false,
		["FULL_AUTO_FIRE"] = true
	},

	-- Groza
	["-1357824103"] = {
		["SINGLE_FIRE"] = true,
		["BURST_FIRE"] = false,
		["FULL_AUTO_FIRE"] = true
	},

	["-1768145561"] = {
		["SINGLE_FIRE"] = true,
		["BURST_FIRE"] = true,
		["FULL_AUTO_FIRE"] = true
	}
}

local ForceWeaponMode = {
	["-1719357158"] = 1 -- PD M14
}

local running = false
local PREVIOUS_WEAPON_MODES = {}
local SELECTED_FIRE_RATE = 3

Citizen.CreateThread(function()

	-- Register Keybinds
	exports["np-keybinds"]:registerKeyMapping("", "Weapons", "Switch Weapon Mode", "+switchWeaponMode", "-switchWeaponMode")
  RegisterCommand("+switchWeaponMode", SwitchWeaponMode, false)
  RegisterCommand("-switchWeaponMode", function() end, false)
end)

local function runWeaponLoop()
  running = true
  Citizen.CreateThread(function()
      while running do
					if IsDisabledControlPressed(0, 24) then
						Wait(FireRateTypes[SELECTED_FIRE_RATE].delay)
						if FireRateTypes[SELECTED_FIRE_RATE].name ~= "FULL_AUTO_FIRE" then
							while IsDisabledControlPressed(0, 24) do
								DisablePlayerFiring(PlayerPedId(), true)
								Wait(0)
							end
						end
					end
					Wait(0)
      end
  end)
end

function SwitchWeaponMode()
	local pWeaponHash = tostring(GetSelectedPedWeapon(PlayerPedId()))

	if AllowedModes[pWeaponHash] == nil then
		SELECTED_FIRE_RATE = 3
		TriggerEvent("DoLongHudText", "You have no modes to cycle through", 2)
		return
	end

	-- Does this weapon only allow a single mode and forced?
	if ForceWeaponMode[pWeaponHash] ~= nil then
		if SELECTED_FIRE_RATE == ForceWeaponMode[pWeaponHash] then
			TriggerEvent("DoLongHudText", "You can't change mode from: " .. FireRateTypes[SELECTED_FIRE_RATE].label , 2)
		else
			SELECTED_FIRE_RATE = ForceWeaponMode[pWeaponHash]
			TriggerEvent("np-weapons:client:setWeaponFireRate", 33.3 * SELECTED_FIRE_RATE)
		end
		return
	end

	local newSelected = FindWeaponModeAfterIndex(SELECTED_FIRE_RATE, pWeaponHash)

	SELECTED_FIRE_RATE = newSelected
	PREVIOUS_WEAPON_MODES[pWeaponHash] = SELECTED_FIRE_RATE
	local selectedRate = FireRateTypes[SELECTED_FIRE_RATE]

	TriggerEvent("DoLongHudText", "Changed fire mode: " .. selectedRate.label , 1)
	TriggerEvent("np-weapons:client:setWeaponFireRate", 33.3 * SELECTED_FIRE_RATE)
end

function FindWeaponModeAfterIndex(pIndex, pWeaponHash)
	pIndex = pIndex + 1

	-- We are at the end of weapon modes list so reset it
	if (pIndex > #FireRateTypes) then
		pIndex = 1	
	end

	if (AllowedModes[pWeaponHash] ~= nil and AllowedModes[pWeaponHash][FireRateTypes[pIndex].name] ~= nil and not AllowedModes[pWeaponHash][FireRateTypes[pIndex].name]) then
		return FindWeaponModeAfterIndex(pIndex, pWeaponHash)
	end

	return pIndex;
end

RegisterNetEvent("np-weapons:client:weaponEquiped")
AddEventHandler("np-weapons:client:weaponEquiped", function(pWeaponHash, newInformation, sqlID, itemToRemove, pArmed)
	if ForceWeaponMode[pWeaponHash] ~= nil then
		SELECTED_FIRE_RATE = ForceWeaponMode[pWeaponHash]
		TriggerEvent("np-weapons:client:setWeaponFireRate", 33.3 * SELECTED_FIRE_RATE)
	end

	if PREVIOUS_WEAPON_MODES[pWeaponHash] ~= nil then
		SELECTED_FIRE_RATE = PREVIOUS_WEAPON_MODES[pWeaponHash]
	else

		-- Does this weapon have an auto mode? if so set that default
		if AllowedModes[pWeaponHash] ~= nil and AllowedModes[pWeaponHash]["FULL_AUTO_FIRE"] then
			SELECTED_FIRE_RATE = 3
		else
			-- Will set to the first available mode if we didn't previously have a selected mode
			SELECTED_FIRE_RATE = FindWeaponModeAfterIndex(0, pWeaponHash)
		end
	end

	-- If we dont have modes we can cycle always make full auto by default
	if AllowedModes[pWeaponHash] == nil then
		SELECTED_FIRE_RATE = 3
	end

	running = pArmed
	if pArmed then
		runWeaponLoop()
	end
	
	TriggerEvent("np-weapons:client:showWeaponFireRate", pArmed)
	TriggerEvent("np-weapons:client:setWeaponFireRate", 33.3 * SELECTED_FIRE_RATE)
end)
