RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RLCore.Commands.Add('me', 'Me message.', {}, false, function(source, args)
	if source == 0 or source == "Console" then return end

	args = table.concat(args, ' ')
	TriggerClientEvent('u7x!A%D*', -1, source, args, "me")
	TriggerEvent('bb-logs:server:createLog', GetCurrentResourceName(), GetCurrentResourceName(), '**ME** ' .. args, source)
end)

RLCore.Commands.Add('do', 'Do message.', {}, false, function(source, args)
	if source == 0 then return end

	args = table.concat(args, ' ')
	TriggerClientEvent('u7x!A%D*', -1, source, args, "do")
	TriggerEvent('bb-logs:server:createLog', GetCurrentResourceName(), GetCurrentResourceName(), '**DO** ' .. args, source)
end)