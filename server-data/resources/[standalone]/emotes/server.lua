RLCore = nil

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent('emotes:clearkeybinds')
AddEventHandler('emotes:clearkeybinds', function(data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local steam = GetPlayerIdentifiers(src)[1]

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `emotesbinds` WHERE `steam` = '" .. steam .. "'", function(result)
        if result[1] ~= nil then
            RLCore.Functions.ExecuteSql(false, "UPDATE `emotesbinds` SET `data` = '" .. json.encode({}) .. "' WHERE `steam` = '" .. steam .. "'")
        end
    end)
end)

RegisterServerEvent('emotes:setkeybinds')
AddEventHandler('emotes:setkeybinds', function(data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local steam = GetPlayerIdentifiers(src)[1]

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `emotesbinds` WHERE `steam` = '" .. steam .. "'", function(result)
        if result[1] ~= nil then
            RLCore.Functions.ExecuteSql(false, "UPDATE `emotesbinds` SET `data` = '" .. json.encode(data) .. "' WHERE `steam` = '" .. steam .. "'")
        else
            RLCore.Functions.ExecuteSql(true, "INSERT INTO `emotesbinds` (`steam`, `data`) VALUES ('" .. steam .. "', '" .. json.encode(data) .. "')")
        end
    end)
end)

RegisterServerEvent('emotes:getkeybinds')
AddEventHandler('emotes:getkeybinds', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    RLCore.Functions.ExecuteSql(true, "SELECT * FROM `emotesbinds` WHERE `steam` = '" .. GetPlayerIdentifiers(src)[1] .. "'", function(result)
		if (result[1] and result[1].data) then
            TriggerClientEvent("emote:setEmotesFromDB", src, json.decode(result[1].data))
		else
            TriggerClientEvent("emote:setEmotesFromDB", src, {})
		end
	end)
end)

RLCore.Commands.Add("emote", "Playing Animation / Open Emotes Menu", {{name="emote", help="Emote Name"}}, false, function(source, args)
	if args[1] == nil then
		TriggerClientEvent("emotes:OpenMenu", source)
	else
		TriggerClientEvent("doAnim", source, args[1])
	end
end)

RLCore.Commands.Add("emotes", "Show All Animations", {}, false, function(source, args)
    TriggerClientEvent("emotes:emotesOnCommand", source)
end)

RLCore.Commands.Add("e", "Playing Animation", {{name="emote", help="Emote Name"}}, false, function(source, args)
    TriggerClientEvent("doAnim", source, args[1])
end)

RLCore.Commands.Add("walk", "Change Walk Style", {{name="style", help="Walk Style"}}, false, function(source, args)
    TriggerClientEvent("emotes:WalkCommandStart", source, args)
end)

RLCore.Commands.Add("walks", "Show All Walk Styles", {}, false, function(source, args)
    TriggerClientEvent("emotes:WalksOnCommand", source)
end)