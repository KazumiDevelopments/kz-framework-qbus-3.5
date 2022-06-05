RLCore = nil

local isLoggedIn = true
local CurrentWeaponData = {}
local PlayerData = {}
local CanShoot = true

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

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

Citizen.CreateThread(function() 
    while true do
        if isLoggedIn then
            TriggerServerEvent("weapons:server:SaveWeaponAmmo")
            TriggerEvent("debug", 'Weapons: Ammo Saved', 'success')
        end
        Citizen.Wait(60000)
    end
end)

Citizen.CreateThread(function()
    Wait(1000)
    if RLCore.Functions.GetPlayerData() ~= nil then
        TriggerServerEvent("weapons:server:LoadWeaponAmmo")
        isLoggedIn = true
        PlayerData = RLCore.Functions.GetPlayerData()

        RLCore.Functions.TriggerCallback("weapons:server:GetConfig", function(RepairPoints)
            for k, data in pairs(RepairPoints) do
                Config.WeaponRepairPoints[k].IsRepairing = data.IsRepairing
                Config.WeaponRepairPoints[k].RepairingData = data.RepairingData
            end

            TriggerEvent("debug", 'Weapons: Config Received', 'success')
        end)
    end
end)

local MultiplierAmount = 0

Citizen.CreateThread(function()
    while true do
        if isLoggedIn then
            if CurrentWeaponData ~= nil and next(CurrentWeaponData) ~= nil then
                if IsPedShooting(GetPlayerPed(-1)) or IsControlJustPressed(0, 24) then
                    if CanShoot then
                        local weapon = GetSelectedPedWeapon(GetPlayerPed(-1))
                        local ammo = GetAmmoInPedWeapon(GetPlayerPed(-1), weapon)
                        if RLCore.Shared.Weapons[weapon]["name"] == "weapon_snowball" then
                            TriggerServerEvent('RLCore:Server:RemoveItem', "snowball", 1)
                        else
                            if ammo > 0 then
                                MultiplierAmount = MultiplierAmount + 1
                            end
                        end
                    elseif tonumber(GetSelectedPedWeapon(GetPlayerPed(-1))) ~= -1569615261 then
                        TriggerEvent('inventory:client:CheckWeapon')
                        RLCore.Functions.Notify("This weapon is broken and cannot be used..", "error")
                        MultiplierAmount = 0
                        TriggerEvent("debug", 'Weapons: Broken Weapon', 'error')
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        local player = PlayerId()
        local weapon = GetSelectedPedWeapon(ped)
        local ammo = GetAmmoInPedWeapon(ped, weapon)

        if ammo == 1 then
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            if IsPedInAnyVehicle(ped, true) then
                SetPlayerCanDoDriveBy(player, false)
            end
        else
            EnableControlAction(0, 24, true) -- Attack
			EnableControlAction(0, 257, true) -- Attack 2
            if IsPedInAnyVehicle(ped, true) then
                SetPlayerCanDoDriveBy(player, true)
            end
        end

        if IsPedShooting(ped) then
            if ammo - 1 < 1 then
                SetAmmoInClip(GetPlayerPed(-1), GetHashKey(RLCore.Shared.Weapons[weapon]["name"]), 1)
            end
        end

        if not CanShoot then
            if tonumber(weapon) ~= -1569615261 then
                DisablePlayerFiring(PlayerId(), true)
            end
        end
        
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if IsPedShooting(PlayerPedId()) then
            local weapon = GetSelectedPedWeapon(GetPlayerPed(-1))
            local ammo = GetAmmoInPedWeapon(GetPlayerPed(-1), weapon)
            if ammo > 0 then
                TriggerServerEvent("weapons:server:UpdateWeaponAmmo", CurrentWeaponData, tonumber(ammo))
            else
                TriggerEvent('inventory:client:CheckWeapon')
                TriggerServerEvent("weapons:server:UpdateWeaponAmmo", CurrentWeaponData, 0)
            end

            if MultiplierAmount > 0 then
                TriggerServerEvent("weapons:server:UpdateWeaponQuality", CurrentWeaponData, MultiplierAmount)
                MultiplierAmount = 0
            end
        end
        Citizen.Wait(1)
    end
end)

RegisterNetEvent('weapon:client:AddAmmo')
AddEventHandler('weapon:client:AddAmmo', function(type, amount, itemData)
    local ped = GetPlayerPed(-1)
    local weapon = GetSelectedPedWeapon(GetPlayerPed(-1))
    if CurrentWeaponData ~= nil then
        if RLCore.Shared.Weapons[weapon]["name"] ~= "weapon_unarmed" and RLCore.Shared.Weapons[weapon]["ammotype"] == type:upper() then
            local total = (GetAmmoInPedWeapon(GetPlayerPed(-1), weapon))
            local f, max = GetMaxAmmo(ped, weapon)
            local clipmax = tonumber(GetMaxAmmoInClip(ped, weapon, 1))
            local newtotal = total + clipmax
            if newtotal < max then
                RLCore.Functions.Progressbar("taking_bullets", "Reloading", 5000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    if RLCore.Shared.Weapons[weapon] ~= nil then
                        TaskReloadWeapon(ped)
                        SetPedAmmo(ped, weapon, newtotal)
                        TriggerServerEvent("weapons:server:AddWeaponAmmo", CurrentWeaponData, newtotal)
                        TriggerServerEvent('RLCore:Server:RemoveItem', itemData.name, 1, itemData.slot)
                        TriggerEvent('inventory:client:ItemBox', RLCore.Shared.Items[itemData.name], "remove")
                        TriggerEvent('RLCore:Notify', clipmax .." bullets loaded!", "success")
                        TriggerEvent("debug", 'Weapons: Bullets Loaded', 'success')
                    end
                end, function()
                    RLCore.Functions.Notify("Canceled..", "error")
                    TriggerEvent("debug", 'Weapons: Canceled', 'error')
                end)
            else
                RLCore.Functions.Notify("The ammo for this weapon is full..", "error")
            end
        else    
            RLCore.Functions.Notify("You don't have a weapon..", "error")
        end
    else
        RLCore.Functions.Notify("You don't have a weapon..", "error")
    end
end)

Citizen.CreateThread(function()
	while RLCore == nil do
		TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
		Citizen.Wait(200)
	end

	while RLCore.Functions.GetPlayerData() == nil do
		Wait(0)
	end

	while RLCore.Functions.GetPlayerData().job == nil do
		Wait(0)
	end

    TriggerServerEvent("weapons:server:LoadWeaponAmmo")
    isLoggedIn = true
    PlayerData = RLCore.Functions.GetPlayerData()

    RLCore.Functions.TriggerCallback("weapons:server:GetConfig", function(RepairPoints)
        for k, data in pairs(RepairPoints) do
            Config.WeaponRepairPoints[k].IsRepairing = data.IsRepairing
            Config.WeaponRepairPoints[k].RepairingData = data.RepairingData
        end

        TriggerEvent("debug", 'Weapons: Config Received', 'success')
    end)
end)

RegisterNetEvent('weapons:client:SetCurrentWeapon')
AddEventHandler('weapons:client:SetCurrentWeapon', function(data, bool)
    if data ~= false then
        CurrentWeaponData = data
    else
        CurrentWeaponData = {}
    end
    CanShoot = bool

    TriggerEvent("debug", 'Weapons: Current Weapon Updated', 'success')
end)

RegisterNetEvent('RLCore:Client:OnPlayerUnload')
AddEventHandler('RLCore:Client:OnPlayerUnload', function()
    isLoggedIn = false

    for k, v in pairs(Config.WeaponRepairPoints) do
        Config.WeaponRepairPoints[k].IsRepairing = false
        Config.WeaponRepairPoints[k].RepairingData = {}
    end
end)

RegisterNetEvent('weapons:client:SetWeaponQuality')
AddEventHandler('weapons:client:SetWeaponQuality', function(amount)
    if CurrentWeaponData ~= nil and next(CurrentWeaponData) ~= nil then
        TriggerServerEvent("weapons:server:SetWeaponQuality", CurrentWeaponData, amount)
    end

    TriggerEvent("debug", 'Weapons: Update Weapon Quality', 'success')
end)

Citizen.CreateThread(function()
    while true do
        if isLoggedIn then
            local inRange = false
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)

            for k, data in pairs(Config.WeaponRepairPoints) do
                local distance = GetDistanceBetweenCoords(pos, data.coords.x, data.coords.y, data.coords.z, true)

                if distance < 10 then
                    inRange = true

                    if distance < 1 then
                        if data.IsRepairing then
                            if data.RepairingData.CitizenId ~= PlayerData.citizenid then
                                DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'The repair shop is currently ~r~NOT~w~ available..')
                            else
                                if not data.RepairingData.Ready then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'Your weapon is being repaired')
                                else
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, '[E] Take back the weapon')
                                end
                            end
                        else
                            if CurrentWeaponData ~= nil and next(CurrentWeaponData) ~= nil then
                                if not data.RepairingData.Ready then
                                    local WeaponData = RLCore.Shared.Weapons[GetHashKey(CurrentWeaponData.name)]
                                    local WeaponClass = (RLCore.Shared.SplitStr(WeaponData.ammotype, "_")[2]):lower()
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, '[E] Repair weapon, ~g~$'..Config.WeaponRepairCotsts[WeaponClass]..'~w~')
                                    if IsControlJustPressed(0, Keys["E"]) then
                                        RLCore.Functions.TriggerCallback('weapons:server:RepairWeapon', function(HasMoney)
                                            if HasMoney then
                                                CurrentWeaponData = {}
                                            end
                                        end, k, CurrentWeaponData)
                                    end
                                else
                                    if data.RepairingData.CitizenId ~= PlayerData.citizenid then
                                        DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'The repair shop is currently ~r~NOT~w~ available..')
                                    else
                                        DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, '[E] Take back the weapon')
                                        if IsControlJustPressed(0, Keys["E"]) then
                                            TriggerServerEvent('weapons:server:TakeBackWeapon', k, data)
                                        end
                                    end
                                end
                            else
                                if data.RepairingData.CitizenId == nil then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, 'You have no weapon in your hand..')
                                elseif data.RepairingData.CitizenId == PlayerData.citizenid then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, '[E] Take back the weapon')
                                    if IsControlJustPressed(0, Keys["E"]) then
                                        TriggerServerEvent('weapons:server:TakeBackWeapon', k, data)
                                    end
                                end
                            end
                        end
                    end
                end
            end

            if not inRange then
                Citizen.Wait(1000)
            end
        end
        Citizen.Wait(3)
    end
end)

RegisterNetEvent("weapons:client:SyncRepairShops")
AddEventHandler("weapons:client:SyncRepairShops", function(NewData, key)
    Config.WeaponRepairPoints[key].IsRepairing = NewData.IsRepairing
    Config.WeaponRepairPoints[key].RepairingData = NewData.RepairingData
end)

RegisterNetEvent('rl-weapons:client:SetWeaponAmmoManual')
AddEventHandler('rl-weapons:client:SetWeaponAmmoManual', function(weapon, ammo)
    local ped = GetPlayerPed(-1)
    if weapon ~= "current" then
        local weapon = weapon:upper()
        SetPedAmmo(ped, GetHashKey(weapon), ammo)
        RLCore.Functions.Notify('+'..ammo..' Ammo for the '..RLCore.Shared.Weapons[GetHashKey(weapon)]["label"], 'success')
    else
        local weapon = GetSelectedPedWeapon(ped)
        if weapon ~= nil then
            SetPedAmmo(ped, weapon, ammo)
            TriggerServerEvent("weapons:server:AddWeaponAmmo", CurrentWeaponData, ammo)
            RLCore.Functions.Notify('+'..ammo..' Ammo for the '..RLCore.Shared.Weapons[weapon]["label"], 'success')
        else
            RLCore.Functions.Notify('You dont have a weapon..', 'error')
        end
    end
end)

RegisterNetEvent("weapons:client:EquipAttachment")
AddEventHandler("weapons:client:EquipAttachment", function(ItemData, attachment)
    local ped = GetPlayerPed(-1)
    local weapon = GetSelectedPedWeapon(ped)
    local WeaponData = RLCore.Shared.Weapons[weapon]

    if weapon ~= GetHashKey("WEAPON_UNARMED") then
        WeaponData.name = WeaponData.name:upper()
        if Config.WeaponAttachments[WeaponData.name] ~= nil then
            if Config.WeaponAttachments[WeaponData.name][attachment] ~= nil then
                TriggerServerEvent("weapons:server:EquipAttachment", ItemData, CurrentWeaponData, Config.WeaponAttachments[WeaponData.name][attachment])
                TriggerEvent("debug", 'Weapons: Attachment Equipped', 'success')
            else
                RLCore.Functions.Notify("This weapon does not support this attachment..", "error")
            end
        end
    else
        RLCore.Functions.Notify("You have no weapon in your hand..", "error")
    end
end)

function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end


RegisterNetEvent("addAttachment")
AddEventHandler("addAttachment", function(component)
    local ped = GetPlayerPed(-1)
    local weapon = GetSelectedPedWeapon(ped)
    local WeaponData = RLCore.Shared.Weapons[weapon]
    GiveWeaponComponentToPed(ped, GetHashKey(WeaponData.name), GetHashKey(component))
end)