RLCore = nil

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

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

RLCore.Functions.CreateUseableItem("ciggy", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("client:cigarette", source)
end)

RLCore.Functions.CreateUseableItem("cigar", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("client:cigar", source)
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

RLCore.Functions.CreateUseableItem("ifak", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:ifak", source)
end)

RLCore.Functions.CreateUseableItem("crack_baggy", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:Crackbaggy", source)
end)

RLCore.Functions.CreateUseableItem("methbag", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:methbag", source)
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

RLCore.Commands.Add("divingsuit", "Take off your diving suit", {}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("oxygenmaskclient:UseGear", source, false)
end)

RLCore.Functions.CreateUseableItem("diving_gear", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent('police:woxy', source)
    --TriggerClientEvent("oxygenmaskclient:UseGear", source, true)
end)

RegisterServerEvent('oxygengear:RemoveGear')
AddEventHandler('oxygengear:RemoveGear', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem("diving_gear", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["diving_gear"], "remove")
end)

RegisterServerEvent('oxygengear:GiveBackGear')
AddEventHandler('oxygengear:GiveBackGear', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    
    Player.Functions.AddItem("diving_gear", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["diving_gear"], "add")
end)


-- prop oitems

RLCore.Functions.CreateUseableItem("boombox", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent('attach:boombox', source)
end)
RLCore.Functions.CreateUseableItem("box", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent('attach:box', source)
end)
RLCore.Functions.CreateUseableItem("dufflebag", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent('attach:blackDuffelBag', source)
end)
RLCore.Functions.CreateUseableItem("medicalbag", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent('attach:medicalBag', source)
end)
RLCore.Functions.CreateUseableItem("securitycase", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent('attach:securityCase', source)
end)
RLCore.Functions.CreateUseableItem("toolbox", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent('attach:toolbox', source)
end)

--Bandanas
RLCore.Functions.CreateUseableItem('bloodsbandana', function(source)
	local Player = RLCore.Functions.GetPlayer(source)
	TriggerClientEvent('qb_bandana:bloodsbandana', source)
end)

RLCore.Functions.CreateUseableItem('greenbandana', function(source)
	local Player = RLCore.Functions.GetPlayer(source)
	TriggerClientEvent('qb_bandana:greenbandana', source)
end)

RLCore.Functions.CreateUseableItem('ballasbandana', function(source)
	local Player = RLCore.Functions.GetPlayer(source)
	TriggerClientEvent('qb_bandana:ballasbandana', source)
end)

RLCore.Functions.CreateUseableItem('vagosbandana', function(source)
	local Player = RLCore.Functions.GetPlayer(source)
	TriggerClientEvent('qb_bandana:vagosbandana', source)
end)

RLCore.Functions.CreateUseableItem('cripsbandana', function(source)
	local Player = RLCore.Functions.GetPlayer(source)
	TriggerClientEvent('qb_bandana:cripsbandana', source)
end)

RLCore.Functions.CreateUseableItem('whitebandana', function(source)
	local Player = RLCore.Functions.GetPlayer(source)
	TriggerClientEvent('qb_bandana:whitebandana', source)
end)

RLCore.Functions.CreateUseableItem('blackbandana', function(source)
	local Player = RLCore.Functions.GetPlayer(source)
	TriggerClientEvent('qb_bandana:blackbandana', source)
end)

RLCore.Functions.CreateUseableItem('orangebandana', function(source)
	local Player = RLCore.Functions.GetPlayer(source)
	TriggerClientEvent('qb_bandana:orangebandana', source)
end)

RLCore.Functions.CreateUseableItem('watch', function(source)
    TriggerClientEvent("carHud:compass", source)
end)