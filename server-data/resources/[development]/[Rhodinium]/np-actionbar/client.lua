
local ammoTable = {}
unholsteringactive = false
local prevupdate = 0
local armed = false
local currentInformation = 0
local lastEquippedInfo = nil
local CurrentSqlID = 0
local TIME_REMOVED_FOR_DEG = 1000 * 60 * 5 -- 5 mins
local focusTaken = false
local UNARMED_HASH = `WEAPON_UNARMED`
local isActionBarDisabled = false
local lastEquippedItemToRemove = nil



local throwableWeapons = {}
throwableWeapons["741814745"] = true
throwableWeapons["-1600701090"] = true
throwableWeapons["615608432"] = true
throwableWeapons["1233104067"] = true
throwableWeapons["2874559379"] = true
throwableWeapons["126349499"] = true
throwableWeapons["-73270376"] = true
throwableWeapons["-1169823560"] = true
throwableWeapons["2481070269"] = true
throwableWeapons["-1813897027"] = true
throwableWeapons["600439132"] = true
throwableWeapons["1064738331"] = true
throwableWeapons["-691061592"] = true
throwableWeapons["126349499"] = true
throwableWeapons["-828058162"] = true
throwableWeapons["571920712"] = true
throwableWeapons["-1569615261"] = true
throwableWeapons["-37975472"] = true

RLCore = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

isCop = false
 
RegisterNetEvent('nowCopSpawn')
AddEventHandler('nowCopSpawn', function()
    isCop = true
end)

RegisterNetEvent('nowCopSpawnOff')
AddEventHandler('nowCopSpawnOff', function()
    isCop = false
end)


RegisterNetEvent('np-items:SetAmmo')
AddEventHandler('np-items:SetAmmo', function(sentammoTable)
	if sentammoTable ~= nil then
		ammoTable = sentammoTable
		GiveAmmoNow()
		Wait(300)
	end
end)

function GiveAmmoNow()
	for i,v in pairs(ammoTable) do
		for x,b in pairs(v) do
			SetPedAmmoByType(PlayerPedId(), v.type, v.ammo)
		end
	end
end



local lastWeaponDeg = 0
function attemptToDegWeapon()
	if math.random(100) > 85 then
		local hasTimer = 99999
		hasTimer = (GetGameTimer()-lastWeaponDeg)

		if  hasTimer >= 2000 then
			lastWeaponDeg = GetGameTimer();
			TriggerEvent("inventory:DegenLastUsedItem",1)
		end
	end
end

local reDelayed = false
function actionBarDown()
	if focusTaken or reDelayed then return end
	TriggerEvent("inventory-bar", true)
	--[[
  exports["np-ui"]:sendAppEvent("hud", {
    displayAllForce = true,
    displayAllForceVehicle = GetVehiclePedIsIn(PlayerPedId()) ~= 0,
	displayRadioChannel = true,
  })
  TriggerServerEvent("np-financials:cash:get", GetPlayerServerId(PlayerId()))
  ]]--
end

function actionBarUp()
  if focusTaken then return end
  reDelayed = true
  TriggerEvent("inventory-bar", false)
  --[[
  exports["np-ui"]:sendAppEvent("hud", {
    displayAllForce = false,
    displayAllForceVehicle = false,
  })
  Citizen.SetTimeout(5000, function()
	exports["np-ui"]:sendAppEvent("hud", {
		displayRadioChannel = false,
	})
  end)
  ]]--
  Citizen.SetTimeout(2500, function() reDelayed = false end)
end

function playerWink()
  Citizen.CreateThread(function()
    SetFacialIdleAnimOverride(GetPlayerPed(-1), "pose_aiming_1")
    Citizen.Wait(300)
    SetFacialIdleAnimOverride(GetPlayerPed(-1), "pose_normal_1")
  end)
end

local passiveModeEnabled = false
function passiveMode()
  if passiveModeEnabled then
    passiveModeEnabled = false
    TriggerEvent("DoLongHudText", "Passive mode off")
    return
  end
  TriggerEvent("DoLongHudText", "Passive mode on")
  passiveModeEnabled = true
  Citizen.CreateThread(function()
    while passiveModeEnabled do
      DisablePlayerFiring(PlayerPedId(), true)
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      Citizen.Wait(0)
    end
  end)
end

Citizen.CreateThread(function()
	exports["np-keybinds"]:registerKeyMapping("", "Player", "Action Bar", "+actionBar", "-actionBar", "TAB")
	RegisterCommand('+actionBar', actionBarDown, false)
	RegisterCommand('-actionBar', actionBarUp, false)

	exports["np-keybinds"]:registerKeyMapping("", "Player", "Wink", "+playerWink", "-playerWink")
	RegisterCommand('+playerWink', playerWink, false)
	RegisterCommand('-playerWink', function() end, false)

	exports["np-keybinds"]:registerKeyMapping("", "Player", "Passive Mode", "+passiveMode", "-passiveMode")
	RegisterCommand('+passiveMode', passiveMode, false)
	RegisterCommand('-passiveMode', function() end, false)
end)

local excludedWeapons = {
	[UNARMED_HASH] = true,
	[`WEAPON_FIREEXTINGUISHER`] = true,
	[`WEAPON_FLARE`] = true,
	[`WEAPON_PetrolCan`] = true,
	[`WEAPON_STUNGUN`] = true,
	[-2009644972] = true, -- paintball gun bruv
	[1064738331] = true, -- bricked
	[-828058162] = true, -- shoed
	[571920712] = true, -- money
	[-691061592] = true, -- book
	[1834241177] = true, -- EMP Gun
	[1233104067] = true, -- Flare
	[600439132] = true, -- Lime
	[126349499] = true, -- Snowball
}

local lastShot = 0
local lastDamageTrigger = 0
local shotRecentlyLoopActive = false

local function shotRecently()
	if shotRecentlyLoopActive then return end
	shotRecentlyLoopActive = true
	Citizen.CreateThread(function()
		while shotRecentlyLoopActive do
			Citizen.Wait(60000)
			if (lastShot + 1200000) < GetGameTimer() then
				shotRecentlyLoopActive = false
			end
		end
	end)
end

AddEventHandler('np-actionbar:hotreload', function()
	TriggerServerEvent("np-weapons:getAmmo")
end)

Citizen.CreateThread( function()
	local lastWeapon
	while true do
		Citizen.Wait(0)

		local ped = PlayerPedId()

		local selectedWeapon = GetSelectedPedWeapon(ped)

		if UNARMED_HASH ~= selectedWeapon then
			lastWeapon = selectedWeapon
		end

		if selectedWeapon == 741814745 then
			TriggerEvent('Evidence:StateSet', 29, 3600)
		end

		if IsPedShooting(ped) then
			local hash = GetSelectedPedWeapon(ped)
			local ammoType = Citizen.InvokeNative(0x7FEAD38B326B9F74, ped, hash)
			newammo = GetPedAmmoByType(ped, ammoType)
			if newammo < 5 then
				updateAmmo()
			end

			attemptToDegWeapon()
			local weapon = "".. hash ..""
      if weapon == "-37975472" then
        TriggerEvent("np-weapons:threwSmokeGrenade")
        if lastEquippedItemToRemove then
          if exports["np-inventory"]:hasEnoughOfItem(lastEquippedItemToRemove,1,false) then
            TriggerEvent("inventory:removeItem", lastEquippedItemToRemove, 1)
            Citizen.Wait(3000)
          end
        end
        lastEquippedItemToRemove = nil
      end
			if throwableWeapons[weapon] and exports["np-inventory"]:hasEnoughOfItem(weapon,1,false) then
				TriggerEvent("inventory:removeItem", weapon, 1)
				Citizen.Wait(3000)
			end
			if not excludedWeapons[hash] then
				nextLastShot = GetGameTimer()
				if nextLastShot - lastShot > 30000 then
					TriggerEvent("client:newStress", true, 50, true)
				end
				lastShot = nextLastShot
				shotRecently()
			else
				nextLastShot = GetGameTimer()
				if ((nextLastShot - lastShot) > 30000) and hash == -2009644972 then
					-- paintball reduce stress YAY :)
					TriggerEvent("client:newStress", false, 1000)
				end
				lastShot = nextLastShot
			end

			if hash == `WEAPON_FIREEXTINGUISHER` then
				local pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 3.0, 0.0)
				if GetNumberOfFiresInRange(pos,4.0) > 1 then
					local rnd = math.random(100)
					if rnd > 40 then TriggerServerEvent('fire:serverStopFire',pos.x,pos.y,pos.z,4.0) end
				end
			end

			if selectedWeapon ~= lastWeapon and (lastWeapon == 741814745 or lastWeapon == -1600701090 or lastWeapon == 600439132 or lastWeapon == 126349499 or lastWeapon == -828058162 or lastWeapon == 1064738331 or lastWeapon == -691061592 or lastWeapon == 1233104067) then
				TriggerEvent("inventory:removeItem", lastWeapon, 1)
			end

			if selectedWeapon ~= lastWeapon and (lastWeapon == 571920712) then
				TriggerEvent("inventory:removeItemByMetaKV", lastWeapon, 1, "id", lastEquippedInfo.id)
			end
		end

		if unholsteringactive then
			DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
		end


		prevupdate = prevupdate - 1

		if (IsControlJustReleased(0,157) or IsDisabledControlJustReleased(0,157)) and not focusTaken and not isActionBarDisabled then
			TriggerEvent("inventory-bind",1)
		end

		if (IsControlJustReleased(0,158) or IsDisabledControlJustReleased(0,158)) and not focusTaken and not isActionBarDisabled then
			TriggerEvent("inventory-bind",2)
		end

		if (IsControlJustReleased(0,160) or IsDisabledControlJustReleased(0,160)) and not focusTaken and not isActionBarDisabled then
			TriggerEvent("inventory-bind",3)
		end

		if (IsControlJustReleased(0,164) or IsDisabledControlJustReleased(0,164)) and not focusTaken and not isActionBarDisabled then
			TriggerEvent("inventory-bind",4)
		end

		if UNARMED_HASH ~= selectedWeapon and 741814745 ~= selectedWeapon and 100416529 ~= selectedWeapon then
			DisplayAmmoThisFrame(true)
		end

		if IsPedPlantingBomb(ped) then
			if exports["np-inventory"]:hasEnoughOfItem("741814745",1,false) then

				TriggerEvent("inventory:removeItem", 741814745, 1)
				Citizen.Wait(3000)
			end
		end

	end
end)

AddEventHandler("np-voice:focus:set", function(pState)
  focusTaken = pState
end)

RegisterNetEvent("police:hasShotRecently")
AddEventHandler("police:hasShotRecently", function(copId)
	TriggerServerEvent("police:hasShotRecently", shotRecentlyLoopActive, copId)
end)

local cannotPullWeaponInAnimation = false


RegisterNetEvent('equipWeaponID')
AddEventHandler('equipWeaponID', function(hash,newInformation,sqlID,itemToRemove)
	--GiveAmmoNow()
	if not exports["np-propattach"]:canPullWeaponHoldingEntity() then return end
	
	if cannotPullWeaponInAnimation  then return end

  -- if tonumber(hash) == 1593441988 then
  --   hash = 453432689
  -- end

	cannotPullWeaponInAnimation = true
	CurrentSqlID = sqlID
	currentInformation = json.decode(newInformation)

	


	if (currentInformation.cartridge == nil) then
		currentInformation = "Scratched off data"
	else
		currentInformation = currentInformation.cartridge
	end
	TriggerEvent("evidence:bulletInformation", currentInformation)

	local dead = RLCore.Functions.GetPlayerData().metadata["isdead"]
	if dead then
		return
	end

  lastEquippedItemToRemove = itemToRemove

	if UNARMED_HASH == GetSelectedPedWeapon(PlayerPedId()) then
		armed = false
	end

	SetPlayerCanDoDriveBy(PlayerId(),false)
	
	if armed then
		armed = false
		TriggerEvent("hud-display-item",tonumber(hash), "Holster")
		holster1h()		
	else
		armed = true
		TriggerEvent("hud-display-item",tonumber(hash), "Equip")
		unholster1h(tonumber(hash),true, json.decode(newInformation))
	end	

	if hash == "-72657034" then
		RemoveAllPedWeaponsP(PlayerPedId(),hash)
	end

	SetPedAmmo(PlayerPedId(),  `WEAPON_FIREEXTINGUISHER`, 10000)
	SetPedAmmo(PlayerPedId(),  `WEAPON_STICKYBOMB`, 1)
	SetPedAmmo(PlayerPedId(),  1233104067, 1)
	SetPedAmmo(PlayerPedId(),  -37975472, 1)
	
	SetPlayerCanDoDriveBy(PlayerId(),true)
	SetWeaponsNoAutoswap(true)
	
	TriggerEvent("np-weapons:client:weaponEquiped", hash, newInformation, sqlID, itemToRemove, armed)
	TriggerServerEvent("np-weapons:weaponEquiped", hash, newInformation, sqlID, itemToRemove, armed)

end)

RegisterNetEvent('brokenWeapon')
AddEventHandler('brokenWeapon', function()

	local dead = RLCore.Functions.GetPlayerData().metadata["isdead"]
	if dead then
		return
	end


	holster1h()
	armed = false

	SetPedAmmo(PlayerPedId(),  `WEAPON_FIREEXTINGUISHER`, 10000)

end)


function ammoTypeCheck(atype)
	if type(atype) == "number" then
		if ammoTable["" .. atype .. ""] == nil then
			ammoTable["" .. atype .. ""] = {}
			ammoTable["" .. atype .. ""]["ammo"] = 0
			ammoTable["" .. atype .. ""]["type"] = atype
		end
	end
end



RegisterNetEvent('actionbar:ammo')
AddEventHandler('actionbar:ammo', function(hash,amount,addition)

	local ped = PlayerPedId()
	local ammoType = hash
	ammoTypeCheck(ammoType)

	if ammoTable == nil then
		TriggerServerEvent("np-weapons:getAmmo")
		
	end

	if ammoTable["" .. ammoType .. ""] == nil then
		TriggerServerEvent("np-weapons:getAmmo")
	end


	if hash == Citizen.InvokeNative(0x7FEAD38B326B9F74, ped, GetSelectedPedWeapon(ped)) then
		curAmmo = GetPedAmmoByType(ped, hash)
	else
		curAmmo = ammoTable["" .. ammoType .. ""]["ammo"]

		if curAmmo == nil then
			ammoTable["" .. ammoType .. ""]["ammo"] = 0
		end
	end

	if addition then
	    newammo = tonumber(curAmmo) + tonumber(amount)
	else
		newammo = tonumber(curAmmo) - tonumber(amount)
	end

	if (curAmmo == newammo) then
		newammo = newammo + 30
	end

	if addition and newammo < amount then newammo = amount end


	if newammo > 150 and ammoType ~= -899475295 then
   		newammo = 150
    elseif newammo < 0 then
    	newammo = 0
    end

    ammoTable["" .. ammoType .. ""]["ammo"] = newammo

    SetPedAmmoByType(PlayerPedId(), ammoType, newammo)

    prevupdate = 0
	updateAmmoTable(newammo,ammoType)
end)


function updateAmmoTable(newammo,ammoType)
	local ped = PlayerPedId()
	local hash = GetSelectedPedWeapon(ped)
	if hash == UNARMED_HASH then
		updateAmmo(true)
		return
	end
	TriggerServerEvent("np-weapons:updateAmmo",newammo,ammoType,ammoTable)
end

RegisterNetEvent('armory:ammo')
AddEventHandler('armory:ammo', function()
	TriggerEvent("actionbar:ammo",1950175060,150,true)
	TriggerEvent("actionbar:ammo",218444191,150,true)
	TriggerEvent("actionbar:ammo",-1878508229,150,true)
	TriggerEvent("actionbar:ammo",1820140472,150,true)
	TriggerEvent("actionbar:ammo",965225813,150,true)
end)

RegisterNetEvent('actionbar:setEmptyHanded')
AddEventHandler('actionbar:setEmptyHanded', function(ignoreUpdateAmmo)
	prevupdate = 0
  if not ignoreUpdateAmmo then
	  updateAmmo(true)
  end
	Wait(500)
	SetCurrentPedWeapon(PlayerPedId(), UNARMED_HASH, true)
end)


local lastUsedAmmo = GetSelectedPedWeapon(PlayerPedId())
function updateAmmo(isForced)

	if prevupdate > 0 then
		return
	end

	prevupdate = 5
	local ped = PlayerPedId()
	local hash = GetSelectedPedWeapon(ped)
	if hash == UNARMED_HASH then
		hash = lastUsedAmmoHash
	end
	lastUsedAmmoHash = hash
	local newammo = 0
	local ammoType = Citizen.InvokeNative(0x7FEAD38B326B9F74, ped, hash)

	if type(ammoType) == 'number' then 

		ammoTypeCheck(ammoType)

		newammo = GetPedAmmoByType(ped, ammoType)
		
		if newammo == nil then
			return
		end

		if isForced and newammo == 0 then 
			return
		end

		if newammo > 150 and ammoType ~= -899475295 then
			newammo = 150
		end

		ammoTable["" .. ammoType .. ""]["ammo"] = newammo


		TriggerServerEvent("np-weapons:updateAmmo",newammo,ammoType,ammoTable)

	end

	return newammo
end


function getAmmo(hash)
	if hash == nil then return end

	if (throwableWeapons[""..hash..""]) then
    	return 2
    end

	local ped = PlayerPedId()
	local ammoType = Citizen.InvokeNative(0x7FEAD38B326B9F74, ped, hash)

	local newammo = 0

	if type(ammoType) == "number" then
		ammoTypeCheck(ammoType)
		newammo = ammoTable["" .. ammoType .. ""]["ammo"]
	end

	if newammo > 150 and ammoType ~= -899475295 then
		newammo = 150
	end

	return newammo
end

RegisterNetEvent('np-item:CheckClientAmmo')
AddEventHandler('np-item:CheckClientAmmo', function(weapons)
	local ped = PlayerPedId()
	local ammoType = Citizen.InvokeNative(0x7FEAD38B326B9F74, ped, weapons)
	local newammo = 0

	ammoTypeCheck(ammoType)

	if type(ammoType) == "number" then
		ammoTypeCheck(ammoType)
		newammo = ammoTable["" .. ammoType .. ""]["ammo"]
	end


end)


function unholster1h(weaponHash, a, info)

	unholsteringactive = true

  lastEquippedInfo = info

	local dict = "reaction@intimidation@1h"
	local anim = "intro"
	local myJob = RLCore.Functions.GetPlayerData().job.name
	local ped = PlayerPedId()

	if myJob == "police" or myJob == "doc" then

		if weaponHash == -1953168119 then
			TriggerEvent("fx:staffused",true)
			GiveWeaponToPed(ped, weaponHash, getAmmo(weaponHash), 1, 1)
			cannotPullWeaponInAnimation = false
			ClearPedTasks(ped)
			Citizen.Wait(1200)
			unholsteringactive = false
			return
		end

		copunholster(weaponHash)

		if weaponHash == 218362403 then
			SetPedWeaponTintIndex(ped, weaponHash, 6)
		end
		  
	    if weaponHash == 3219281620 then
			  GiveWeaponComponentToPed(PlayerPedId(), 3219281620, `COMPONENT_AT_PI_FLSH_02` )
	    end

	    if weaponHash == 736523883 then
        GiveWeaponComponentToPed( ped, 736523883, `COMPONENT_AT_AR_FLSH` )
        GiveWeaponComponentToPed( ped, 736523883, `COMPONENT_AT_SCOPE_MACRO_02` )	
	    end

	    if weaponHash == -2084633992 then
        GiveWeaponComponentToPed( ped, -2084633992, `COMPONENT_AT_AR_FLSH` )
        GiveWeaponComponentToPed( ped, -2084633992, `COMPONENT_AT_AR_AFGRIP` )
        GiveWeaponComponentToPed( ped, -2084633992, `COMPONENT_AT_SCOPE_MEDIUM` )
		end
		
	    -- if weaponHash == 1432025498 then
        -- GiveWeaponComponentToPed( ped, 1432025498, `COMPONENT_AT_SCOPE_MACRO_MK2` )
        -- GiveWeaponComponentToPed( ped, 1432025498, `COMPONENT_AT_AR_FLSH` )
	    -- end

	    if weaponHash == 2024373456 then
        GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_AR_FLSH` )
        GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_SIGHTS_SMG` )	
        GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_MUZZLE_01` )
        GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_SB_BARREL_02` )	
	    end

	    if weaponHash == -86904375 then
	    	GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_AT_AR_FLSH` )
	    	GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_AT_SIGHTS` )
	    end

	    if weaponHash == -1075685676 then
	    	GiveWeaponComponentToPed( ped, -1075685676, `COMPONENT_AT_PI_FLSH_02` )
	    end

		if weaponHash == 1649403952 and info and info.componentVariant then
			local variants = {
			  ["1"] = 0xF605986F,
			}
			if variants[info.componentVariant] then
			  GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
			end
		  end

		  if weaponHash == -1024456158 and info and info.componentVariant then
			local variants = {
			  ["1"] = 0xDF427E88,
			  ["2"] = 0x84276AFF,
			  ["3"] = 0x1122A82,
			  ["4"] = 0x12788BB7,
			  ["5"] = 0x475ECA83,
			  ["6"] = 0x2B65CEAD,
			  ["7"] = 0xFE52F3D7,
			}
			if variants[info.componentVariant] then
			  GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
			end
		  end

		  AttachmentCheck(weaponHash)
		
	    Citizen.Wait(450)
      unholsteringactive = false
      cannotPullWeaponInAnimation = false
		return
	end	

	RemoveAllPedWeaponsP(ped,weaponHash)

	if weaponHash == -1953168119 then
		TriggerEvent("fx:staffused",true)
		GiveWeaponToPed(ped, weaponHash, getAmmo(weaponHash), 1, 1)
		cannotPullWeaponInAnimation = false
		ClearPedTasks(ped)
		if info and info.componentVariant then
			local variants = {
			  ["1"] = 0xF5C8A04A,
			  ["2"] = 0xEC7D8DB4,
			  ["3"] = 0x1C7C6DB1,
			  ["4"] = 0xB18CAEA,
			  ["5"] = 0xB0DF1678,
			  ["6"] = 0xDF8AF3CF,
			  ["7"] = 0xC80344C0,
			  ["8"] = 0x791226CB,
			  ["9"] = 0x78ADA746,
			  ["10"] = 0xC52AC043,
			}
			if variants[info.componentVariant] then
			  GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
			end
		end
		Citizen.Wait(1200)
		unholsteringactive = false
		return
	end


	if weaponHash ~= -538741184 and weaponHash ~= 615608432 then
		  local animLength = GetAnimDuration(dict, anim) * 1000
	    loadAnimDict(dict) 
	    TaskPlayAnim(ped, dict, anim, 1.0, 1.0, -1, 50, 0, 0, 0, 0)
	    Citizen.Wait(900)
	    GiveWeaponToPed(ped, weaponHash, getAmmo(weaponHash), 0, 1)
	    SetCurrentPedWeapon(ped, weaponHash, 1)
	else
      GiveWeaponToPed(ped, weaponHash, getAmmo(weaponHash), 1, 0)
      SetCurrentPedWeapon(ped, weaponHash, 0)
	end

  if weaponHash == 218362403 then
      SetPedWeaponTintIndex(ped, weaponHash, 6)
  end
  
  if info and info.weaponTint then
    SetPedWeaponTintIndex(ped, weaponHash, info.weaponTint)
  end

  if weaponHash == 1692590063 and info and info.componentVariant then
    local variants = {
      ["1"] = 0x6218EEB8,
      ["2"] = 0xA4BF7400,
      ["3"] = 0x3F2DA8E2, -- cursed katana, never use this one
      ["4"] = 0x849233A6,
      ["5"] = 0x83648BFB, -- Talon sword, don't use this
    }
    if variants[info.componentVariant] then
      GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
    end
  end

  if weaponHash == 1649403952 and info and info.componentVariant then
    local variants = {
      ["1"] = 0xF605986F,
    }
    if variants[info.componentVariant] then
      GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
    end
  end

  if weaponHash == -1024456158 and info and info.componentVariant then
    local variants = {
      ["1"] = 0xDF427E88,
      ["2"] = 0x84276AFF,
      ["3"] = 0x1122A82,
      ["4"] = 0x12788BB7,
      ["5"] = 0x475ECA83,
      ["6"] = 0x2B65CEAD,
      ["7"] = 0xFE52F3D7,
    }
    if variants[info.componentVariant] then
      GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
    end
  end

  if weaponHash == 3638508604 and info and info.componentVariant then
    local variants = {
      ["1"] = 0xF3462F33,
      ["2"] = 0xC613F685,
      ["3"] = 0xEED9FD63,
      ["4"] = 0x50910C31,
      ["5"] = 0x9761D9DC,
      ["6"] = 0x7DECFE30,
      ["7"] = 0x3F4E8AA6,
	  ["8"] = 0x8B808BB,
	  ["9"] = 0xE28BABEF,
	  ["10"] = 0x7AF3F785,
    }
    if variants[info.componentVariant] then
      GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
    end
  end
   
  if weaponHash == 1317494643 and info and info.componentVariant then
    local variants = {
      ["1"] = 0x904467BA,
    }
    if variants[info.componentVariant] then
      GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
    end
  end

  AttachmentCheck(weaponHash)
  Citizen.Wait(500)
  cannotPullWeaponInAnimation = false
  ClearPedTasks(ped)
  Citizen.Wait(1200)
  
  unholsteringactive = false

end

function AttachmentCheck(weaponhash)

	if exports["np-inventory"]:hasEnoughOfItem("weapon_silencer_assault", 1, false, true) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_AR_SUPP` )
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_AR_SUPP_02` )
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, 0x3164BAB )
	end

	if exports["np-inventory"]:hasEnoughOfItem("weapon_silencer_pistol", 1, false, true) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_PI_SUPP_02` )
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_PI_SUPP` )	
	end

	if exports["np-inventory"]:hasEnoughOfItem("weapon_oil_silencer", 1, false, true) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, 1532150734 )
	end

	if exports["np-inventory"]:hasEnoughOfItem("weapon_scope", 1, false, true) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_SCOPE_MEDIUM` )	
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_SCOPE_MACRO` )	
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_SCOPE_SMALL` )	
	end

	if exports["np-inventory"]:hasEnoughOfItem("weapon_uzi_extended", 1, false, true) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, 0xE40F1CD2 )	
	end
	if exports["np-inventory"]:hasEnoughOfItem("weapon_uzi_foldstock", 1, false, true) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, 0x8FBBD54C )		
	end
	if exports["np-inventory"]:hasEnoughOfItem("weapon_uzi_woodstock", 1, false, true) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, 0x722C6CA6 )		
	end

end


function copunholster(weaponHash)
  local dic = "reaction@intimidation@cop@unarmed"
  local anim = "intro"
  local ammoCount = 0
   loadAnimDict( dic ) 

	local ped = PlayerPedId()
	RemoveAllPedWeaponsP(ped,weaponHash)

	TaskPlayAnim(ped, dic, anim, 10.0, 2.3, -1, 49, 1, 0, 0, 0 )

	Citizen.Wait(600)

    GiveWeaponToPed(ped, weaponHash, getAmmo(weaponHash), 0, 1)
	
	SetCurrentPedWeapon(ped, weaponHash, 1)
	ClearPedTasks(ped)

end

function RemoveAllPedWeaponsP(ped,weaponHash)
	local chute = false
	if HasPedGotWeapon(ped,`gadget_parachute`,false) then
		chute = true
	end
	RemoveAllPedWeapons(ped)
	if chute or weaponHash == '-72657034' then
		GiveWeaponToPed(ped, -72657034, 1, 0, 1)
		SetPlayerHasReserveParachute(PlayerId())
	end
end

function copholster()

  local dic = "reaction@intimidation@cop@unarmed"
  local anim = "intro"
  local ammoCount = 0
   loadAnimDict( dic ) 

	local ped = PlayerPedId()
	prevupdate = 0
	updateAmmo()

	TaskPlayAnim(ped, dic, anim, 10.0, 2.3, -1, 49, 1, 0, 0, 0 )

	Citizen.Wait(600)
	SetCurrentPedWeapon(ped, UNARMED_HASH, 1)
	RemoveAllPedWeaponsP(ped,0)
	ClearPedTasks(ped)
end
function holster1h()
	
	print(weaponHash)
	unholsteringactive = true
	local dict = "reaction@intimidation@1h"
	local anim = "outro"
	local myJob = RLCore.Functions.GetPlayerData().job.name
	local ped = PlayerPedId()
	local num, weaponHash = GetCurrentPedWeapon(ped)
	
	if myJob == "police" or myJob == "doc" then

		if weaponHash == -1953168119 then
			TriggerEvent("fx:staffused",true)
			GiveWeaponToPed(ped, weaponHash, getAmmo(weaponHash), 1, 1)
			cannotPullWeaponInAnimation = false
			ClearPedTasks(ped)
			Citizen.Wait(1200)
			unholsteringactive = false
			return
		end

		copholster()
		Citizen.Wait(600)
		unholsteringactive = false
		cannotPullWeaponInAnimation = false
		return
	end

	if weaponHash == -1953168119 then
		TriggerEvent("fx:staffused",false)
		SetCurrentPedWeapon(ped, UNARMED_HASH, 1)
		RemoveAllPedWeaponsP(ped,0)
		ClearPedTasks(ped)
		unholsteringactive = false
		cannotPullWeaponInAnimation = false
		return
	end

	prevupdate = 0
	updateAmmo()
	local animLength = GetAnimDuration(dict, anim) * 1000
    loadAnimDict(dict) 
    TaskPlayAnim(ped, dict, anim, 1.0, 1.0, -1, 50, 0, 0, 0, 0)   
    Citizen.Wait(animLength - 2200)
    
    SetCurrentPedWeapon(ped, UNARMED_HASH, 1)
    Citizen.Wait(300)
    RemoveAllPedWeaponsP(ped,0)
    ClearPedTasks(ped)
    Citizen.Wait(800)
	unholsteringactive = false
	cannotPullWeaponInAnimation = false
end


exports('disableActionBar', function(pState)
  isActionBarDisabled = pState
end)

RegisterNetEvent("np-weapons:hitPlayerWithCash", function(pTarget)
  TriggerServerEvent("np-weapons:processGiveCashAmount", pTarget, lastEquippedInfo.amount, lastEquippedInfo.id)
end)
