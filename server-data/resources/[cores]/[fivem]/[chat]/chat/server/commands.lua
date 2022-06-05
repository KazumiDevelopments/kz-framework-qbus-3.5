RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end

RLCore.Commands.Add('clear', 'Clear chat.', {}, false, function(source, args)
    TriggerClientEvent('chat:client:ClearChat', source)
end)

RLCore.Commands.Add('clearall', 'Clear chat for everyone.', {}, false, function(source, args)
	TriggerClientEvent('chat:client:ClearChat', -1)
end, "admin")


RegisterServerEvent('bb-chat:sendOocGlobally')
AddEventHandler('bb-chat:sendOocGlobally', function(playername, msg)
	local xPlayer = RLCore.Functions.GetPlayer(source)
	local name = xPlayer.PlayerData.charinfo.firstname
	--local alt = xPlayer.PlayerData.charinfo.lastname

	TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message" style="background-color: rgba(51, 112, 165, 0.75);"><b>OOC - '..xPlayer.PlayerData.charinfo.firstname ..' '.. xPlayer.PlayerData.charinfo.lastname ..' | {0}</b> </div>',
        args = { msg}
    })
end)

RLCore.Commands.Add('police', 'Police message.', {}, false, function(source, args)
	-- If From Console
	if source == 0 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(52, 67, 235, 0.75);">{0} <b>Police</b> <img src=' .. Config.Images.Police .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img></div>',
        	args = { args }
    	})
		
		TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, "CONSOLE", "```[Police] " .. args .. "```" )
		return
	end

	-- Emojis Stuff
	args = table.concat(args, ' ')
	args = args:gsub("%:heart:", "❤️")
    args = args:gsub("%:smile:", "🙂")
    args = args:gsub("%:thinking:", "🤔")
    args = args:gsub("%:check:", "✅")
    args = args:gsub("%:hot:", "🥵")
    args = args:gsub("%:sad:", "😦")

    -- Permmisions Stuff
	local xPlayer = RLCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job ~= nil and xPlayer.PlayerData.job.name == 'police' then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(52, 67, 235, 0.75);"><b>Police</b> {0}<img src=' .. Config.Images.Police .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img></div>',
        	args = { args }
    	})
	else
		TriggerClientEvent('chat:addMessage', source, {
        	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN</b> You are not a police officer</div>',
        	args = {}
    	})
	end
	
	-- Logs Stuff
	TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, GetPlayerName(source) .. " | " .. GetPlayerIdentifiers(source)[1], "```[Police] " .. args .. "```" )
end)

RLCore.Commands.Add('ems', 'EMS Message.', {}, false, function(source, args)
	-- If From Console
	if source == 0 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(163, 62, 48, 0.75);">{0} <b>EMS</b> <img src=' .. Config.Images.Ems .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img></div>',
        	args = { args }
    	})
		
		TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, "CONSOLE", "```[Police] " .. args .. "```" )
		return
	end

	-- Emojis Stuff
	args = table.concat(args, ' ')
	args = args:gsub("%:heart:", "❤️")
    args = args:gsub("%:smile:", "🙂")
    args = args:gsub("%:thinking:", "🤔")
    args = args:gsub("%:check:", "✅")
    args = args:gsub("%:hot:", "🥵")
    args = args:gsub("%:sad:", "😦")

    -- Permmisions Stuff
	local xPlayer = RLCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job ~= nil and xPlayer.PlayerData.job.name == 'ambulance' then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(255, 0, 21, 0.75);"><b>EMS</b> {0}<img src=' .. Config.Images.Ems .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img></div>',
        	args = { args }
    	})
	else
		TriggerClientEvent('chat:addMessage', source, {
        	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN</b> You are not an EMS employer</div>',
        	args = {}
    	})
	end
	
	-- Logs Stuff
	TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, GetPlayerName(source) .. " | " .. GetPlayerIdentifiers(source)[1], "```[Police] " .. args .. "```" )
end)


RLCore.Commands.Add('court', 'Court House message.', {}, false, function(source, args)
	-- If From Console
	if source == 0 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(153, 71, 0, 0.75);">{0} <b>Court House</b> <img src=' .. Config.Images.Court .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img></div>',
        	args = { args }
    	})
		
		TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, "CONSOLE", "```[Police] " .. args .. "```" )
		return
	end

	-- Emojis Stuff
	args = table.concat(args, ' ')
	args = args:gsub("%:heart:", "❤️")
    args = args:gsub("%:smile:", "🙂")
    args = args:gsub("%:thinking:", "🤔")
    args = args:gsub("%:check:", "✅")
    args = args:gsub("%:hot:", "🥵")
    args = args:gsub("%:sad:", "😦")

    -- Permmisions Stuff
	local xPlayer = RLCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.job ~= nil and xPlayer.PlayerData.job.name == 'judge' or xPlayer.PlayerData.job.name == 'lawyer' then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(153, 71, 0, 0.75);"><b>Court House</b> {0}<img src=' .. Config.Images.Court .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img></div>',
        	args = { args }
    	})
	else
		TriggerClientEvent('chat:addMessage', source, {
        	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN</b> You are not an court employer</div>',
        	args = {}
    	})
	end
	
	-- Logs Stuff
	TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, GetPlayerName(source) .. " | " .. GetPlayerIdentifiers(source)[1], "```[Police] " .. args .. "```" )
end)

RegisterCommand('id', function(source, args, rawCommand)
	if source == 0 then
		return
	end
	local src = source
	TriggerClientEvent('bb_chat:id', -1, src, GetPlayerName(src))
end, false)

RegisterCommand('stats', function(source, args, rawCommand)
	if source == 0 then
		return
	end

	local _source = source
	local xPlayerGroup = RLCore.Functions.GetPermission(_source)

	TriggerClientEvent('chat:addMessage', _source, {
    	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN STATS</b> Group: {0}</div>',
    	args = {xPlayerGroup}
    })
end, false)

RegisterServerEvent('bbcha:adminchatpermmision')
AddEventHandler('bbcha:adminchatpermmision', function(name, msg)
	local _source = source
	local xPlayerGroup = RLCore.Functions.GetPermission(_source)
	if xPlayerGroup ~= nil and xPlayerGroup ~= "user" then
		sendToAllPlayers(name, msg)
	else
		TriggerClientEvent('chat:addMessage', _source, {
        	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN</b> You are not a staff member</div>',
        	args = {}
    	})
	end
end)

RegisterServerEvent('bbcha:adminchatsystem')
AddEventHandler('bbcha:adminchatsystem', function(name, msg)
	local _source = source
	sendToAllPlayers(name, GetPlayerName(_source) .. msg)
end)

function sendToAllPlayers(name, msg)
	local xPlayers = RLCore.Functions.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local xPlayer = RLCore.Functions.GetPlayer(xPlayers[i])
		local xPlayerGroup = RLCore.Functions.GetPermission(xPlayers[i])
		if xPlayerGroup ~= nil and xPlayerGroup ~= "user" then
			TriggerClientEvent('chat:addMessage', xPlayer.PlayerData.source, {
    			template = '<div class="chat-message" style="background-color: rgba(255, 0, 21, 0.75);"><b>STAFF CHAT | {0}</b> {1}</div>',
    			args = {name, msg}
    		})
    	end
    end
end

RegisterCommand('staff', function(source, args, rawCommand)
	-- If From Console
	if source == 0 then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(255, 0, 0, 0.75);"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img><b>ADMIN:</b> {0}</div>',
        	args = { args }
    	})
		return
	end

	-- Emojis Stuff
	args = table.concat(args, ' ')
	args = args:gsub("%:heart:", "❤️")
    args = args:gsub("%:smile:", "🙂")
    args = args:gsub("%:thinking:", "🤔")
    args = args:gsub("%:check:", "✅")
    args = args:gsub("%:hot:", "🥵")
    args = args:gsub("%:sad:", "😦")

    -- Permmisions Stuff
	local xPlayerGroup = RLCore.Functions.GetPermission(source)
	if xPlayerGroup ~= nil and xPlayerGroup ~= "user" then
		TriggerClientEvent('chat:addMessage', -1, {
        	template = '<div class="chat-message" style="background-color: rgba(163, 62, 48, 0.75);"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 3px;height:20px ;"></img><b>ADMIN:</b> {0}</div>',
        	args = { args }
    	})
	else
		TriggerClientEvent('chat:addMessage', source, {
        	template = '<div class="chat-message" style="background-color: rgba(66, 66, 66, 0.75); color: white;"><img src=' .. Config.Images.System .. ' style="width:22px; padding-right: 5px; position:relative ; top: 5px;height:20px ;"></img><b>ADMIN</b> You are not a staff member</div>',
        	args = {}
    	})
	end
	
	-- Logs Stuff
	TriggerEvent('barbaronn:SendWebhookDiscordMsg', Config.Logs, GetPlayerName(source) .. " | " .. GetPlayerIdentifiers(source)[1], "```[Police] " .. args .. "```" )
end, false)