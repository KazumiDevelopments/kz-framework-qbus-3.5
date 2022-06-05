RegisterCommand("giveitem", function(source, args, rawCommand)
    TriggerClientEvent('player:receiveItem', source, args[1], args[2])
end, false)
