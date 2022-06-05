RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent("updateJailTime")
AddEventHandler("updateJailTime", function(minutes)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    xPlayer.Functions.SetMetaData("injail", minutes)
    xPlayer.Functions.UpdatePlayerData()
end)

RegisterServerEvent("jail:saveItems")
AddEventHandler("jail:saveItems", function()
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    
    xPlayer.Functions.SetMetaData("jailitems", xPlayer.PlayerData.items)
    xPlayer.Functions.ClearInventory()
    xPlayer.Functions.UpdatePlayerData()
end)

RegisterServerEvent("jail:drop")
AddEventHandler("jail:drop", function()
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    
    xPlayer.Functions.AddMoney("cash", math.random(10,30))
    TriggerClientEvent('RLCore:Notify', src, "Drop Off Completed.", "success")
end)

RegisterServerEvent("jail:reclaimPossessions")
AddEventHandler("jail:reclaimPossessions", function()
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)

    if #xPlayer.PlayerData.metadata["jailitems"] < 0 then
        xPlayer.Functions.SetInventory(xPlayer.PlayerData.metadata["jailitems"])
        xPlayer.Functions.SetMetaData("jailitems", {})
        xPlayer.Functions.UpdatePlayerData()
    end
end)

RLCore.Commands.Add('unjail', 'Unjail player (Police Only)', {{name = 'ID', help = 'Player ID'}}, true, function(source, args)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    if xPlayer.PlayerData.job.name == 'police' then
        if tonumber(args[1]) and RLCore.Functions.GetPlayer(tonumber(args[1])) then
            TriggerClientEvent("endJailTime", tonumber(args[1]))
        else
            TriggerClientEvent("notification", src, 'There is no player with this ID.', 2)
        end
    end
end)

RLCore.Commands.Add('jail', 'Jail player (Police Only)', {{name = 'ID', help = 'Player ID'}, {name = 'Time', help = 'Time'}, {name = 'Reason', help = 'reason'}}, true, function(source, args)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    if xPlayer.PlayerData.job.name == 'police' then
        if tonumber(args[1]) and RLCore.Functions.GetPlayer(tonumber(args[1])) then
            if tonumber(args[2]) then
                TriggerClientEvent("beginJail", args[1], args[2])
            else
                TriggerClientEvent("notification", src, 'Invaild jail time. wtf?', 2)
            end
        else
            TriggerClientEvent("notification", src, 'There is no player with this ID.', 2)
        end
    end
end)


RLCore.Commands.Add('jail', 'Unjail player (Police Only)', {{name = 'ID', help = 'Player ID'}}, true, function(source, args)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    if xPlayer.PlayerData.job.name == 'police' then
        if tonumber(args[1]) and RLCore.Functions.GetPlayer(tonumber(args[1])) then
            if tonumber(args[2]) then
                TriggerClientEvent("beginJail", args[1], args[2])
            else
                TriggerClientEvent("notification", src, 'Invaild jail time. wtf?', 2)
            end
        else
            TriggerClientEvent("notification", src, 'There are no player with this ID.', 2)
        end
    end
end)