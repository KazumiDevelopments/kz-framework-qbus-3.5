RLCore.Functions.CreateUseableItem("joint", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:UseJoint", source)
    end
end)

RLCore.Functions.CreateUseableItem("armor", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:UseArmor", source)
end)

RLCore.Functions.CreateUseableItem("heavyarmor", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:UseHeavyArmor", source)
end)

-- RLCore.Functions.CreateUseableItem("smoketrailred", function(source, item)
--     local Player = RLCore.Functions.GetPlayer(source)
-- 	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
--         TriggerClientEvent("consumables:client:UseRedSmoke", source)
--     end
-- end)

RLCore.Functions.CreateUseableItem("parachute", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:UseParachute", source)
    end
end)

RLCore.Commands.Add("parachuteoff", "Take off your parachute", {}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
        TriggerClientEvent("consumables:client:ResetParachute", source)
end)

RegisterServerEvent("rl-smallpenis:server:AddParachute")
AddEventHandler("rl-smallpenis:server:AddParachute", function()
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)

    Ply.Functions.AddItem("parachute", 1)
end)

RLCore.Functions.CreateUseableItem("binoculars", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("binoculars:Toggle", source)
end)

RLCore.Functions.CreateUseableItem("cokebaggy", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:Cokebaggy", source)
end)

RLCore.Functions.CreateUseableItem("oxy", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:oxy", source)
end)

RLCore.Functions.CreateUseableItem("crack_baggy", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:Crackbaggy", source)
end)

RLCore.Functions.CreateUseableItem("xtcbaggy", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:EcstasyBaggy", source)
end)

RLCore.Functions.CreateUseableItem("firework1", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("fireworks:client:UseFirework", source, item.name, "proj_indep_firework")
end)

RLCore.Functions.CreateUseableItem("firework2", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("fireworks:client:UseFirework", source, item.name, "proj_indep_firework_v2")
end)

RLCore.Functions.CreateUseableItem("firework3", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("fireworks:client:UseFirework", source, item.name, "proj_xmas_firework")
end)

RLCore.Functions.CreateUseableItem("firework4", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("fireworks:client:UseFirework", source, item.name, "scr_indep_fireworks")
end)

RLCore.Commands.Add("vestoff", "Take your vest off. (Police Only)", {}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("consumables:client:ResetArmor", source)
    else
        TriggerClientEvent('chat:addMessage', source , {
            template = '<div class="chat-message server"><b>SYSTEM:</b> {0}</div>',
            args = { "This command is for emergency services!!" }
        })
    end
end)