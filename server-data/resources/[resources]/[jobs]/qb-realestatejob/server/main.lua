RLCore.Commands.Add("setestate", "Give Someone The Real Estate Job", {{
    name = "id",
    help = "ID Of The Player"
}}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)

    if IsAuthorized(Player.PlayerData.citizenid) then
        local TargetId = tonumber(args[1])
        if TargetId ~= nil then
            local TargetData = RLCore.Functions.GetPlayer(TargetId)
            if TargetData ~= nil then
                TargetData.Functions.SetJob("realestate")
                TriggerClientEvent('RLCore:Notify', TargetData.PlayerData.source,
                    "You Were Hired As Real Estate Agent!")
                TriggerClientEvent('RLCore:Notify', source, "You have (" .. TargetData.PlayerData.charinfo.firstname ..
                    ") Hired As An Real Estate Agent!")
            end
        else
            TriggerClientEvent('RLCore:Notify', source, "You Must Provide A Player ID!")
        end
    else
        TriggerClientEvent('RLCore:Notify', source, "You Cannot Do This!", "error")
    end
end)

RLCore.Commands.Add("firerealestate", "Fire A Real Estate", {{
    name = "id",
    help = "ID Of The Player"
}}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)

    if IsAuthorized(Player.PlayerData.citizenid) then
        local TargetId = tonumber(args[1])
        if TargetId ~= nil then
            local TargetData = RLCore.Functions.GetPlayer(TargetId)
            if TargetData ~= nil then
                if TargetData.PlayerData.job.name == "realestate" then
                    TargetData.Functions.SetJob("unemployed")
                    TriggerClientEvent('RLCore:Notify', TargetData.PlayerData.source,
                        "You Were Fired As An Real Estate Agent!")
                    TriggerClientEvent('RLCore:Notify', source,
                        "You have (" .. TargetData.PlayerData.charinfo.firstname .. ") Fired As Real Estate Agent!")
                else
                    TriggerClientEvent('RLCore:Notify', source, "Youre Not An Real Estate Agent!", "error")
                end
            end
        else
            TriggerClientEvent('RLCore:Notify', source, "You Must Provide A Player ID!", "error")
        end
    else
        TriggerClientEvent('RLCore:Notify', source, "You Cannot Do This!", "error")
    end
end)