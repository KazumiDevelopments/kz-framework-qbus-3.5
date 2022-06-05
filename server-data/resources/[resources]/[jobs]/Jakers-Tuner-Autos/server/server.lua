local RLCore = exports['rl-core']:GetCoreObject()  

--shop
RegisterNetEvent('rl-shops:client:UpdateShop', function(shop, itemData, amount)
    TriggerServerEvent('rl-shops:server:UpdateShopItems', shop, itemData, amount)
end)

RegisterNetEvent('rl-shops:client:SetShopItems', function(shop, shopProducts)
    Config.Locations[shop]["products"] = shopProducts
end)

RegisterNetEvent('rl-shops:client:RestockShopItems', function(shop, amount)
    if Config.Locations[shop]["products"] ~= nil then
        for k, v in pairs(Config.Locations[shop]["products"]) do
            Config.Locations[shop]["products"][k].amount = Config.Locations[shop]["products"][k].amount + amount
        end
    end
end) 

--billing
RegisterServerEvent("tuner-autosjob:client:MechanicShopPay:player")
AddEventHandler("tuner-autosjob:client:MechanicShopPay:player", function(playerId, amount)
        local biller = RLCore.Functions.GetPlayer(source)
        local billed = RLCore.Functions.GetPlayer(tonumber(playerId))
        local amount = tonumber(amount)
        if biller.PlayerData.job.name == 'tuner' then
            if billed ~= nil then
                if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                    if amount and amount > 0 then
                        exports.oxmysql:insert('INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (@citizenid, @amount, @society, @sender, @sendercitizenid)', {
                            ['@citizenid'] = billed.PlayerData.citizenid,
                            ['@amount'] = amount,
                            ['@society'] = biller.PlayerData.job.name,
                            ['@sender'] = biller.PlayerData.charinfo.firstname,
                            ['@sendercitizenid'] = biller.PlayerData.citizenid
                        })
                        TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                        TriggerClientEvent('RLCore:Notify', source, 'Invoice Successfully Sent', 'success')
                        TriggerClientEvent('RLCore:Notify', billed.PlayerData.source, 'New Invoice Received')
                    else
                        TriggerClientEvent('RLCore:Notify', source, 'Must Be A Valid Amount Above 0', 'error')
                    end
                else
                    TriggerClientEvent('RLCore:Notify', source, 'You Cannot Bill Yourself', 'error')
                end
            else
                TriggerClientEvent('RLCore:Notify', source, 'Player Not Online', 'error')
            end
        else
            TriggerClientEvent('RLCore:Notify', source, 'No Access', 'error')
        end
end)

--Items
--[[RLCore.Functions.CreateUseableItem("repairkit", function(source, item)
  local Player = RLCore.Functions.GetPlayer(src)
  TriggerClientEvent("tuner-autos:RepairKit", source, item.name)
end)]]

RLCore.Functions.CreateUseableItem("lockpick", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:LockPick", source, item.name)
  end)

RLCore.Functions.CreateUseableItem("turbo", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:Turbo", source, item.name)
  end)
  RLCore.Functions.CreateUseableItem("translv1", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:TRANSLV1", source, item.name)
  end)
  RLCore.Functions.CreateUseableItem("translv2", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:TRANSLV2", source, item.name)
  end)
  RLCore.Functions.CreateUseableItem("translv3", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:TRANSLV3", source, item.name)
  end)

  RLCore.Functions.CreateUseableItem("englv1", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:ENGLV1", source, item.name)
  end)
  RLCore.Functions.CreateUseableItem("englv2", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:ENGLV2", source, item.name)
  end)
  RLCore.Functions.CreateUseableItem("englv3", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:ENGLV3", source, item.name)
  end)
  RLCore.Functions.CreateUseableItem("englv4", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:ENGLV4", source, item.name)
  end)


  RLCore.Functions.CreateUseableItem("suslv1", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:SUSLV1", source, item.name)
  end)
  RLCore.Functions.CreateUseableItem("suslv2", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:SUSLV2", source, item.name)
  end)
  RLCore.Functions.CreateUseableItem("suslv3", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:SUSLV3", source, item.name)
  end)

  RLCore.Functions.CreateUseableItem("suslv4", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:SUSLV4", source, item.name)
  end)
  
  RLCore.Functions.CreateUseableItem("brakeslv1", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:BRAKESLV1", source, item.name)
  end)
  RLCore.Functions.CreateUseableItem("brakeslv2", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:BRAKESLV2", source, item.name)
  end)
  RLCore.Functions.CreateUseableItem("brakeslv3", function(source, item)
    local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent("tuner-autos:BRAKESLV3", source, item.name)
  end)

 
  RegisterNetEvent('tuner-autos:RemoveTurbo')
  AddEventHandler('tuner-autos:RemoveTurbo', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('turbo', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['turbo'], "remove")
  end)

  RegisterNetEvent('tuner-autos:RemoveTranslv1')
  AddEventHandler('tuner-autos:RemoveTranslv1', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('translv1', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['translv1'], "remove")
  end)

  RegisterNetEvent('tuner-autos:RemoveTranslv2')
  AddEventHandler('tuner-autos:RemoveTranslv2', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('Translv2', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['translv2'], "remove")
  end)

  RegisterNetEvent('tuner-autos:RemoveTranslv3')
  AddEventHandler('tuner-autos:RemoveTranslv3', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('translv3', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['translv3'], "remove")
  end)

  RegisterNetEvent('tuner-autos:RemoveEnglv1')
  AddEventHandler('tuner-autos:RemoveEnglv1', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('englv1', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['englv1'], "remove")
  end)

  RegisterNetEvent('tuner-autos:RemoveEnglv2')
  AddEventHandler('tuner-autos:RemoveEnglv2', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('englv2', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['englv2'], "remove")
  end)

  RegisterNetEvent('tuner-autos:RemoveEnglv3')
  AddEventHandler('tuner-autos:RemoveEnglv3', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('englv3', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['englv3'], "remove")
  end)

  RegisterNetEvent('tuner-autos:RemoveEnglv4')
  AddEventHandler('tuner-autos:RemoveEnglv4', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('englv4', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['englv4'], "remove")
  end)

  RegisterNetEvent('tuner-autos:RemoveBrakeslv1')
  AddEventHandler('tuner-autos:RemoveBrakeslv1', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('brakeslv1', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['brakeslv1'], "remove")
  end)

  RegisterNetEvent('tuner-autos:RemoveBrakeslv2')
  AddEventHandler('tuner-autos:RemoveBrakeslv2', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('brakeslv2', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['brakeslv2'], "remove")
  end)

  RegisterNetEvent('tuner-autos:RemoveBrakeslv3')
  AddEventHandler('tuner-autos:RemoveBrakeslv3', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('brakeslv3', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['brakeslv3'], "remove")
  end)


  RegisterNetEvent('tuner-autos:RemoveSuslv1')
  AddEventHandler('tuner-autos:RemoveSuslv1', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('suslv1', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['suslv1'], "remove")
  end)

  RegisterNetEvent('tuner-autos:RemoveSuslv2')
  AddEventHandler('tuner-autos:RemoveSuslv2', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('suslv2', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['suslv2'], "remove")
  end)

  RegisterNetEvent('tuner-autos:RemoveSuslv3')
  AddEventHandler('tuner-autos:RemoveSuslv3', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('suslv3', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['suslv3'], "remove")
  end)

  RegisterNetEvent('tuner-autos:RemoveSuslv4')
  AddEventHandler('tuner-autos:RemoveSuslv4', function()
    local src = source 
    local Player = RLCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem('suslv4', 1)
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['suslv4'], "remove")
  end)


--
--Craftevents
RegisterServerEvent("tuner:EnginesCraft1")
AddEventHandler("tuner:EnginesCraft1", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")
    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 25 and metalscrap.amount >= 25 and plastic.amount >= 25 and aluminum.amount >= 25 then
            Player.Functions.RemoveItem("metalscrap", 25)
            Player.Functions.RemoveItem("steel", 25)
            Player.Functions.RemoveItem("plastic", 25)
            Player.Functions.RemoveItem("aluminum", 25)
            Player.Functions.AddItem("englv1", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["englv1"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)

RegisterServerEvent("tuner:EnginesCraft2")
AddEventHandler("tuner:EnginesCraft2", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")
    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 50 and metalscrap.amount >= 50 and plastic.amount >= 50 and aluminum.amount >= 50 then
            Player.Functions.RemoveItem("metalscrap", 50)
            Player.Functions.RemoveItem("steel", 50)
            Player.Functions.RemoveItem("plastic", 50)
            Player.Functions.RemoveItem("aluminum", 50)
            Player.Functions.AddItem("englv2", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["englv2"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)

RegisterServerEvent("tuner:EnginesCraft3")
AddEventHandler("tuner:EnginesCraft3", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")
    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 100 and metalscrap.amount >= 100 and plastic.amount >= 100 and aluminum.amount >= 100 then
            Player.Functions.RemoveItem("metalscrap", 100)
            Player.Functions.RemoveItem("steel", 100)
            Player.Functions.RemoveItem("plastic", 100)
            Player.Functions.RemoveItem("aluminum", 100)

            Player.Functions.AddItem("englv3", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["englv3"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)

RegisterServerEvent("tuner:EnginesCraft4")
AddEventHandler("tuner:EnginesCraft4", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")

    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 150 and metalscrap.amount >= 150 and plastic.amount >= 150 and aluminum.amount >= 150 then
            Player.Functions.RemoveItem("metalscrap", 150)
            Player.Functions.RemoveItem("steel", 150)
            Player.Functions.RemoveItem("plastic", 150)
            Player.Functions.RemoveItem("aluminum", 150)

            Player.Functions.AddItem("englv4", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["englv4"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)


RegisterServerEvent("tuner:TransmissionCraft1")
AddEventHandler("tuner:TransmissionCraft1", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")
    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 25 and metalscrap.amount >= 25 and plastic.amount >= 25 and aluminum.amount >= 25 then
            Player.Functions.RemoveItem("metalscrap", 25)
            Player.Functions.RemoveItem("steel", 25)
            Player.Functions.RemoveItem("plastic", 25)
            Player.Functions.RemoveItem("aluminum", 25)
            Player.Functions.AddItem("translv1", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["translv1"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)

RegisterServerEvent("tuner:TransmissionCraft2")
AddEventHandler("tuner:TransmissionCraft2", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")
    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 50 and metalscrap.amount >= 50 and plastic.amount >= 50 and aluminum.amount >= 50 then
            Player.Functions.RemoveItem("metalscrap", 50)
            Player.Functions.RemoveItem("steel", 50)
            Player.Functions.RemoveItem("plastic", 50)
            Player.Functions.RemoveItem("aluminum", 50)

            Player.Functions.AddItem("translv2", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["translv2"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)

RegisterServerEvent("tuner:TransmissionCraft3")
AddEventHandler("tuner:TransmissionCraft3", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")
    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 100 and metalscrap.amount >= 100 and plastic.amount >= 100 and aluminum.amount >= 100 then
            Player.Functions.RemoveItem("metalscrap", 100)
            Player.Functions.RemoveItem("steel", 100)
            Player.Functions.RemoveItem("plastic", 100)
            Player.Functions.RemoveItem("aluminum", 100)
            Player.Functions.AddItem("translv3", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["translv3"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)


RegisterServerEvent("tuner:BrakesCraft1")
AddEventHandler("tuner:BrakesCraft1", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")
    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 25 and metalscrap.amount >= 25 and plastic.amount >= 25 and plastic.amount >= 25 then
            Player.Functions.RemoveItem("metalscrap", 25)
            Player.Functions.RemoveItem("steel", 25)
            Player.Functions.RemoveItem("plastic", 25)
            Player.Functions.RemoveItem("aluminum", 25)

            Player.Functions.AddItem("brakeslv1", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["brakeslv1"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)

RegisterServerEvent("tuner:BrakesCraft2")
AddEventHandler("tuner:BrakesCraft2", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")
    
    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 50 and metalscrap.amount >= 50 and plastic.amount >= 50 and aluminum.amount >= 50 then
            Player.Functions.RemoveItem("metalscrap", 50)
            Player.Functions.RemoveItem("steel", 50)
            Player.Functions.RemoveItem("plastic", 50)
            Player.Functions.RemoveItem("aluminum", 50)

            Player.Functions.AddItem("brakeslv2", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["brakeslv2"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)


RegisterServerEvent("tuner:BrakesCraft3")
AddEventHandler("tuner:BrakesCraft3", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")

    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 100 and metalscrap.amount >= 100 and plastic.amount >= 100 and aluminum.amount >= 100 then
            Player.Functions.RemoveItem("metalscrap", 100)
            Player.Functions.RemoveItem("steel", 100)
            Player.Functions.RemoveItem("plastic", 100)
            Player.Functions.RemoveItem("aluminum", 100)

            Player.Functions.AddItem("brakeslv3", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["brakeslv3"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)



RegisterServerEvent("tuner:SuspensionCraft1")
AddEventHandler("tuner:SuspensionCraft1", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")

    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 25 and metalscrap.amount >= 25 and plastic.amount >= 25 and aluminum.amount >= 25 then
            Player.Functions.RemoveItem("metalscrap", 25)
            Player.Functions.RemoveItem("steel", 25)
            Player.Functions.RemoveItem("plastic", 25)
            Player.Functions.RemoveItem("aluminum", 25)

            Player.Functions.AddItem("suslv1", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["suslv1"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)


RegisterServerEvent("tuner:SuspensionCraft2")
AddEventHandler("tuner:SuspensionCraft2", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")

    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 50 and metalscrap.amount >= 50 and plastic.amount >= 50 and aluminum.amount >= 50 then
            Player.Functions.RemoveItem("metalscrap", 50)
            Player.Functions.RemoveItem("steel", 50)
            Player.Functions.RemoveItem("plastic", 50)
            Player.Functions.RemoveItem("aluminum", 50)
            Player.Functions.AddItem("suslv2", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["suslv2"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)

RegisterServerEvent("tuner:SuspensionCraft3")
AddEventHandler("tuner:SuspensionCraft3", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")

    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 100 and metalscrap.amount >= 100 and plastic.amount >= 100 and aluminum.amount >= 100 then
            Player.Functions.RemoveItem("metalscrap", 100)
            Player.Functions.RemoveItem("steel", 100)
            Player.Functions.RemoveItem("plastic", 100)
            Player.Functions.RemoveItem("aluminum", 100)
            Player.Functions.AddItem("suslv3", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["suslv3"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)

RegisterServerEvent("tuner:SuspensionCraft4")
AddEventHandler("tuner:SuspensionCraft4", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")

    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 100 and metalscrap.amount >= 100 and plastic.amount >= 100 and aluminum.amount >= 100 then
            Player.Functions.RemoveItem("metalscrap", 100)
            Player.Functions.RemoveItem("steel", 100)
            Player.Functions.RemoveItem("plastic", 100)
            Player.Functions.RemoveItem("aluminum", 100)
            Player.Functions.AddItem("suslv4", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["suslv4"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)

RegisterServerEvent("tuner:TurboCraft")
AddEventHandler("tuner:TurboCraft", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")

    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 150 and metalscrap.amount >= 150 and plastic.amount >= 150 and aluminum.amount >= 150 then
            Player.Functions.RemoveItem("metalscrap", 150)
            Player.Functions.RemoveItem("steel", 150)
            Player.Functions.RemoveItem("plastic", 150)
            Player.Functions.RemoveItem("aluminum", 150)
            Player.Functions.AddItem("turbo", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["turbo"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)

--Crafteventmisc
RegisterServerEvent("tuner-jobcrafting:server:makerepairkit")
AddEventHandler("tuner-jobcrafting:server:makerepairkit", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")
    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 10 and metalscrap.amount >= 10 and plastic.amount >= 10 and aluminum.amount >= 10 then
            Player.Functions.RemoveItem("metalscrap", 10)
            Player.Functions.RemoveItem("steel", 10)
            Player.Functions.RemoveItem("plastic", 10)
            Player.Functions.RemoveItem("aluminium", 10)
            Player.Functions.AddItem("advancedrepairkit", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items[" advancedrepairkit"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)

RegisterServerEvent("tuner-jobcrafting:server:makelockpick")
AddEventHandler("tuner-jobcrafting:server:makelockpick", function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local metalscrap = Player.Functions.GetItemByName("metalscrap")
    local steel = Player.Functions.GetItemByName("steel")
    local plastic = Player.Functions.GetItemByName("plastic")
    local aluminum = Player.Functions.GetItemByName("aluminum")
    if metalscrap ~= nil and steel ~= nil and plastic ~= nil and aluminum ~= nil then

        if steel.amount >= 5 and metalscrap.amount >= 5 and plastic.amount >= 1 then
            Player.Functions.RemoveItem("metalscrap", 5)
            Player.Functions.RemoveItem("steel", 5)
            Player.Functions.RemoveItem("plastic", 5)
            Player.Functions.AddItem("advancedlockpick", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, RLCore.Shared.Items["advancedlockpick"], "add")
            TriggerClientEvent('RLCore:Notify', src, 'Item Crafted.')
        else
            TriggerClientEvent('RLCore:Notify', src, 'You do not have the correct items.', 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify", src, "You're Missing something", "error")
    end
end)


RLCore.Functions.CreateCallback('tuner-autos:IsMechanicAvailable', function(source, cb)
	local amount = 0
	for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "tuner" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    cb(amount)
end)
