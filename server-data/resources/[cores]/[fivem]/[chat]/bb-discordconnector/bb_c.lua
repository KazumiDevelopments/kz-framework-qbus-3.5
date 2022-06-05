DiscordName = ""

RegisterNetEvent("bb-discordconnector:SavePlayer")
AddEventHandler("bb-discordconnector:SavePlayer", function(discname)
    DiscordName = discname
end)

CreateThread(function()
    TriggerServerEvent("bb-discordconnector:checkPlayer")
end)

RegisterCommand('refreshname', function()
    TriggerServerEvent("bb-discordconnector:checkPlayer")
end)

RegisterCommand('ooc', function(source, args, rawCommand)
	local msg = rawCommand:sub(4)
	TriggerServerEvent('bb-chat:sendOocGlobally', DiscordName, msg)
end, false)

RegisterCommand('ac', function(source, args, rawCommand)
	local msg = rawCommand:sub(4)
	TriggerServerEvent('bbcha:adminchatpermmision', DiscordName, msg)
end, false)