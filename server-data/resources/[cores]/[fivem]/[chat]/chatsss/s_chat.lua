RegisterServerEvent("chat:event")
RegisterServerEvent("__cfx_internal:commandFallback")
AddEventHandler("__cfx_internal:commandFallback", function(command)
	local source = tonumber(source)
	if source then
		local name = GetPlayerName(source)
		TriggerEvent('chatMessage', source, name, '/' .. command)
		if not WasEventCanceled() then
			TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
		end
		CancelEvent()
	end
end)

AddEventHandler("chat:event", function(thefunc, args)
	local source = tonumber(source)
	if source then
		if thefunc == "sendchat" then
			if args.author and args.message then
				TriggerEvent("chatMessage", source, args.author, args.message)
				if not WasEventCanceled() then
					TriggerClientEvent("chatMessage", -1, author, {255, 255, 255}, args.message)
				end
			end
		end
		if thefunc == "info" then
			Wait(250)
			local suggests = {}
			for a, b in ipairs(GetRegisteredCommands()) do
				if IsPlayerAceAllowed(source, "command."..b.name) then
					suggests[#suggests+1] = {name = "/"..b.name, help = ""}
				end
			end
			TriggerClientEvent("chat:addSuggestions", source, suggests)
		end
	end
end)

