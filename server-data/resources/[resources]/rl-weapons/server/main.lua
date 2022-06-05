RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local WeaponAmmo = {}

RLCore.Functions.CreateCallback("weapons:server:GetConfig", function(source, cb)
    cb(Config.WeaponRepairPoints)
end)

RegisterServerEvent("weapons:server:AddWeaponAmmo")
AddEventHandler('weapons:server:AddWeaponAmmo', function(CurrentWeaponData, amount)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local amount = tonumber(amount)

    if CurrentWeaponData ~= nil then
        if Player.PlayerData.items[CurrentWeaponData.slot] ~= nil then
            Player.PlayerData.items[CurrentWeaponData.slot].info.ammo = amount
        end
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterServerEvent("weapons:server:UpdateWeaponAmmo")
AddEventHandler('weapons:server:UpdateWeaponAmmo', function(CurrentWeaponData, amount)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local amount = tonumber(amount)
    if CurrentWeaponData ~= nil then
        if Player.PlayerData.items[CurrentWeaponData.slot] ~= nil then
            Player.PlayerData.items[CurrentWeaponData.slot].info.ammo = amount
        end
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RLCore.Functions.CreateCallback("weapon:server:GetWeaponAmmo", function(source, cb, WeaponData)
    local Player = RLCore.Functions.GetPlayer(source)
    local retval = 0
    if WeaponData ~= nil then
        if Player ~= nil then
            local ItemData = Player.Functions.GetItemBySlot(WeaponData.slot)
            if ItemData ~= nil then
                retval = ItemData.info.ammo ~= nil and ItemData.info.ammo or 0
            end
        end
    end
    cb(retval)
end)

RLCore.Functions.CreateUseableItem("pistol_ammo", function(source, item)
    TriggerClientEvent("weapon:client:AddAmmo", source, "AMMO_PISTOL", 30, item)
end)

RLCore.Functions.CreateUseableItem("rifle_ammo", function(source, item)
    TriggerClientEvent("weapon:client:AddAmmo", source, "AMMO_RIFLE", 30, item)
end)

RLCore.Functions.CreateUseableItem("smg_ammo", function(source, item)
    TriggerClientEvent("weapon:client:AddAmmo", source, "AMMO_SMG", 30, item)
end)

RLCore.Functions.CreateUseableItem("shotgun_ammo", function(source, item)
    TriggerClientEvent("weapon:client:AddAmmo", source, "AMMO_SHOTGUN", 30, item)
end)

RLCore.Functions.CreateUseableItem("mg_ammo", function(source, item)
    TriggerClientEvent("weapon:client:AddAmmo", source, "AMMO_MG", 30, item)
end)

function IsWeaponBlocked(WeaponName)
    local retval = false
    for _, name in pairs(Config.DurabilityBlockedWeapons) do
        if name == WeaponName then
            retval = true
            break
        end 
    end
    return retval
end

RegisterServerEvent('weapons:server:UpdateWeaponQuality')
AddEventHandler('weapons:server:UpdateWeaponQuality', function(data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local WeaponData = RLCore.Shared.Weapons[GetHashKey(data.name)]
     local WeaponSlot = Player.PlayerData.items[data.slot]
    local DecreaseAmount = Config.DurabilityMultiplier[data.name]
    
    if not IsWeaponBlocked(WeaponData.name) then
        if WeaponSlot.info.quality ~= nil then
            if WeaponSlot.info.quality - DecreaseAmount > 0 then
                WeaponSlot.info.quality = WeaponSlot.info.quality - DecreaseAmount
            else
                WeaponSlot.info.quality = 0
                TriggerClientEvent('inventory:client:UseWeapon', src, data)
                 TriggerClientEvent('RLCore:Notify', src, "Your weapon is broken, you must fix this weapon before you can use it again.", "error")
            end
        else
            WeaponSlot.info.quality = 100
            if WeaponSlot.info.quality - DecreaseAmount > 0 then
                WeaponSlot.info.quality = WeaponSlot.info.quality - DecreaseAmount
            else
                WeaponSlot.info.quality = 0
                TriggerClientEvent('inventory:client:UseWeapon', src, data)
                TriggerClientEvent('RLCore:Notify', src, "Your weapon is broken, you must fix this weapon before you can use it again.", "error")
            end
        end
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterServerEvent('weapons:server:UpdateWeaponQuality')
AddEventHandler('weapons:server:UpdateWeaponQuality', function(data, RepeatAmount)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local WeaponData = RLCore.Shared.Weapons[GetHashKey(data.name)]
    local WeaponSlot = Player.PlayerData.items[data.slot]
    local DecreaseAmount = Config.DurabilityMultiplier[data.name]

    if WeaponSlot ~= nil then
        if not IsWeaponBlocked(WeaponData.name) then
            if WeaponSlot.info.quality ~= nil then
                for i = 1, RepeatAmount, 1 do
                    if WeaponSlot.info.quality - DecreaseAmount > 0 then
                        WeaponSlot.info.quality = WeaponSlot.info.quality - DecreaseAmount
                    else
                        WeaponSlot.info.quality = 0
                        TriggerClientEvent('inventory:client:UseWeapon', src, data)
                        --TriggerClientEvent('RLCore:Notify', src, "Your weapon is broken, you must repair it before you can use it again.", "error")
                        break
                    end
                end
            else
                WeaponSlot.info.quality = 100
                for i = 1, RepeatAmount, 1 do
                    if WeaponSlot.info.quality - DecreaseAmount > 0 then
                        WeaponSlot.info.quality = WeaponSlot.info.quality - DecreaseAmount
                    else
                        WeaponSlot.info.quality = 0
                        TriggerClientEvent('inventory:client:UseWeapon', src, data)
                        --TriggerClientEvent('RLCore:Notify', src, "Your weapon is broken, you must repair it before you can use it again.", "error")
                        break
                    end
                end
            end
        end
    end

    Player.Functions.SetInventory(Player.PlayerData.items)
end)

RegisterServerEvent("weapons:server:SetWeaponQuality")
AddEventHandler("weapons:server:SetWeaponQuality", function(data, hp)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local WeaponData = RLCore.Shared.Weapons[GetHashKey(data.name)]
    local WeaponSlot = Player.PlayerData.items[data.slot]
    local DecreaseAmount = Config.DurabilityMultiplier[data.name]
    WeaponSlot.info.quality = hp
    Player.Functions.SetInventory(Player.PlayerData.items)
end)

RLCore.Functions.CreateCallback("weapons:server:RepairWeapon", function(source, cb, RepairPoint, data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local minute = 60 * 1000
    local Timeout = math.random(3 * minute, 6 * minute)
    local WeaponData = RLCore.Shared.Weapons[GetHashKey(data.name)]
    local WeaponClass = (RLCore.Shared.SplitStr(WeaponData.ammotype, "_")[2]):lower()

    if Player.PlayerData.items[data.slot] ~= nil then
        if Player.PlayerData.items[data.slot].info.quality ~= nil then
            if Player.PlayerData.items[data.slot].info.quality ~= 100 then
                if Player.Functions.RemoveMoney('cash', Config.WeaponRepairCotsts[WeaponClass]) then
                    Config.WeaponRepairPoints[RepairPoint].IsRepairing = true
                    Config.WeaponRepairPoints[RepairPoint].RepairingData = {
                        CitizenId = Player.PlayerData.citizenid,
                        WeaponData = Player.PlayerData.items[data.slot],
                        Ready = false,
                    }
                    Player.Functions.RemoveItem(data.name, 1, data.slot)
                    TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items[data.name], "remove")
                    TriggerClientEvent("inventory:client:CheckWeapon", src, data.name)
                    TriggerClientEvent('weapons:client:SyncRepairShops', -1, Config.WeaponRepairPoints[RepairPoint], RepairPoint)

                    SetTimeout(Timeout, function()
                        Config.WeaponRepairPoints[RepairPoint].IsRepairing = false
                        Config.WeaponRepairPoints[RepairPoint].RepairingData.Ready = true
                        TriggerClientEvent('weapons:client:SyncRepairShops', -1, Config.WeaponRepairPoints[RepairPoint], RepairPoint)
                        TriggerEvent('rl-phone:server:sendNewMailToOffline', Player.PlayerData.citizenid, {
                            sender = "Tyrone",
                            subject = "Repair",
                            message = "Yes "..WeaponData.label.." is repaired! You can pick it up at the fixed location.<br><br> Peace out madafaka"
                        })
                        SetTimeout(7 * 60000, function()
                            if Config.WeaponRepairPoints[RepairPoint].RepairingData.Ready then
                                Config.WeaponRepairPoints[RepairPoint].IsRepairing = false
                                Config.WeaponRepairPoints[RepairPoint].RepairingData = {}
                                TriggerClientEvent('weapons:client:SyncRepairShops', -1, Config.WeaponRepairPoints[RepairPoint], RepairPoint)
                            end
                        end)
                    end)
                    cb(true)
                else
                    cb(false)
                end
            else
                TriggerClientEvent("RLCore:Notify", src, "This weapon is not damaged..", "error")
                cb(false)
            end
        else
            TriggerClientEvent("RLCore:Notify", src, "This weapon is not damaged..", "error")
            cb(false)
        end
    else
        TriggerClientEvent('RLCore:Notify', src, "You had no weapon in your hand..", "error")
        TriggerClientEvent('weapons:client:SetCurrentWeapon', src, {}, false)
        cb(false)
    end
end)

RegisterServerEvent("weapons:server:TakeBackWeapon")
AddEventHandler("weapons:server:TakeBackWeapon", function(k, data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local itemdata = Config.WeaponRepairPoints[k].RepairingData.WeaponData

    itemdata.info.quality = 80
    Player.Functions.AddItem(itemdata.name, 1, false, itemdata.info)
    TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items[itemdata.name], "add")
    Config.WeaponRepairPoints[k].IsRepairing = false
    Config.WeaponRepairPoints[k].RepairingData = {}
    TriggerClientEvent('weapons:client:SyncRepairShops', -1, Config.WeaponRepairPoints[k], k)
end)

RLCore.Functions.CreateUseableItem("pistol_suppressor", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "suppressor")
end)

RLCore.Functions.CreateUseableItem("smg_suppressor", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "suppressor")
end)

RLCore.Functions.CreateUseableItem("rifle_suppressor", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "suppressor")
end)

RLCore.Functions.CreateUseableItem("pistol_extendedclip", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "extendedclip")
end)

RLCore.Functions.CreateUseableItem("smg_extendedclip", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "extendedclip")
end)

RLCore.Functions.CreateUseableItem("smg_flashlight", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "flashlight")
end)

RLCore.Functions.CreateUseableItem("smg_scope", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "scope")
end)

RLCore.Functions.CreateUseableItem("smg_scope", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "scope")
end)

RLCore.Functions.CreateUseableItem("rifle_extendedclip", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "extendedclip")
end)

RLCore.Functions.CreateUseableItem("rifle_drummag", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("weapons:client:EquipAttachment", source, item, "drummag")
end)

function HasAttachment(component, attachments)
    local retval = false
    local key = nil
    for k, v in pairs(attachments) do
        if v.component == component then
            key = k
            retval = true
        end
    end
    return retval, key
end

function GetAttachmentItem(weapon, component)
    local retval = nil
    for k, v in pairs(Config.WeaponAttachments[weapon]) do
        if v.component == component then
            retval = v.item
        end
    end
    return retval
end

RegisterServerEvent("weapons:server:EquipAttachment")
AddEventHandler("weapons:server:EquipAttachment", function(ItemData, CurrentWeaponData, AttachmentData)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local Inventory = Player.PlayerData.items
    local GiveBackItem = nil
    if Inventory[CurrentWeaponData.slot] ~= nil then
        if Inventory[CurrentWeaponData.slot].info.attachments ~= nil and next(Inventory[CurrentWeaponData.slot].info.attachments) ~= nil then
            local HasAttach, key = HasAttachment(AttachmentData.component, Inventory[CurrentWeaponData.slot].info.attachments)
            if not HasAttach then
                if CurrentWeaponData.name == "weapon_compactrifle" then
                    local component = "COMPONENT_COMPACTRIFLE_CLIP_03"
                    if AttachmentData.component == "COMPONENT_COMPACTRIFLE_CLIP_03" then
                        component = "COMPONENT_COMPACTRIFLE_CLIP_02"
                    end
                    for k, v in pairs(Inventory[CurrentWeaponData.slot].info.attachments) do
                        if v.component == component then
                            local has, key = HasAttachment(component, Inventory[CurrentWeaponData.slot].info.attachments)
                            local item = GetAttachmentItem(CurrentWeaponData.name:upper(), component)
                            GiveBackItem = tostring(item):lower()
                            table.remove(Inventory[CurrentWeaponData.slot].info.attachments, key)
                            TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items[item], "add")
                        end
                    end
                end
                table.insert(Inventory[CurrentWeaponData.slot].info.attachments, {
                    component = AttachmentData.component,
                    label = AttachmentData.label,
                })
                TriggerClientEvent("addAttachment", src, AttachmentData.component)
                Player.Functions.SetInventory(Player.PlayerData.items)
                Player.Functions.RemoveItem(ItemData.name, 1)
                SetTimeout(1000, function()
                    TriggerClientEvent('inventory:client:ItemBox', src, ItemData, "remove")
                end)
            else
                TriggerClientEvent("RLCore:Notify", src, "You already have one "..AttachmentData.label:lower().."sit on your weapon.", "error", 3500)
            end
        else
            Inventory[CurrentWeaponData.slot].info.attachments = {}
            table.insert(Inventory[CurrentWeaponData.slot].info.attachments, {
                component = AttachmentData.component,
                label = AttachmentData.label,
            })
            TriggerClientEvent("addAttachment", src, AttachmentData.component)
            print('added '.. AttachmentData.component )
            Player.Functions.SetInventory(Player.PlayerData.items)
            Player.Functions.RemoveItem(ItemData.name, 1)
            SetTimeout(1000, function()
                TriggerClientEvent('inventory:client:ItemBox', src, ItemData, "remove")
            end)
        end
    end

    if GiveBackItem ~= nil then
        Player.Functions.AddItem(GiveBackItem, 1, false)
        GiveBackItem = nil
    end
end)

RLCore.Functions.CreateCallback('weapons:server:RemoveAttachment', function(source, cb, AttachmentData, ItemData)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local Inventory = Player.PlayerData.items
    local AttachmentComponent = Config.WeaponAttachments[ItemData.name:upper()][AttachmentData.attachment]

    if Inventory[ItemData.slot] ~= nil then
        if Inventory[ItemData.slot].info.attachments ~= nil and next(Inventory[ItemData.slot].info.attachments) ~= nil then
            local HasAttach, key = HasAttachment(AttachmentComponent.component, Inventory[ItemData.slot].info.attachments)
            if HasAttach then
                table.remove(Inventory[ItemData.slot].info.attachments, key)
                Player.Functions.SetInventory(Player.PlayerData.items)
                Player.Functions.AddItem(AttachmentComponent.item, 1)
                TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items[AttachmentComponent.item], "add")
                TriggerClientEvent("RLCore:Notify", src, "You have the "..AttachmentComponent.label.." removed from your weapon!", "error")
                cb(Inventory[ItemData.slot].info.attachments)
            else
                cb(false)
            end
        else
            cb(false)
        end
    else
        cb(false)
    end
end)