RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local Races = {}
RegisterServerEvent('rl-streetraces:NewRace')
AddEventHandler('rl-streetraces:NewRace', function(RaceTable)
    local src = source
    local RaceId = math.random(1000, 9999)
    local xPlayer = RLCore.Functions.GetPlayer(src)
    if xPlayer.Functions.RemoveMoney('cash', RaceTable.amount, "streetrace-created") then
        Races[RaceId] = RaceTable
        Races[RaceId].creator = GetPlayerIdentifiers(src)[1]
        table.insert(Races[RaceId].joined, GetPlayerIdentifiers(src)[1])
        TriggerClientEvent('rl-streetraces:SetRace', -1, Races)
        TriggerClientEvent('rl-streetraces:SetRaceId', src, RaceId)
        TriggerClientEvent('RLCore:Notify', src, "You participate in the race $"..Races[RaceId].amount..",-", 'success')
    end
end)

RegisterServerEvent('rl-streetraces:RaceWon')
AddEventHandler('rl-streetraces:RaceWon', function(RaceId)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    xPlayer.Functions.AddMoney('cash', Races[RaceId].pot, "race-won")
    TriggerClientEvent('RLCore:Notify', src, "You have won the race and $"..Races[RaceId].pot..",- received", 'success')
    TriggerClientEvent('rl-streetraces:SetRace', -1, Races)
    TriggerClientEvent('rl-streetraces:RaceDone', -1, RaceId, GetPlayerName(src))
end)

RegisterServerEvent('rl-streetraces:JoinRace')
AddEventHandler('rl-streetraces:JoinRace', function(RaceId)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local zPlayer = RLCore.Functions.GetPlayer(Races[RaceId].creator)
    if zPlayer ~= nil then
        if xPlayer.PlayerData.money.cash >= Races[RaceId].amount then
            Races[RaceId].pot = Races[RaceId].pot + Races[RaceId].amount
            table.insert(Races[RaceId].joined, GetPlayerIdentifiers(src)[1])
            if xPlayer.Functions.RemoveMoney('cash', Races[RaceId].amount, "streetrace-joined") then
                TriggerClientEvent('rl-streetraces:SetRace', -1, Races)
                TriggerClientEvent('rl-streetraces:SetRaceId', src, RaceId)
                TriggerClientEvent('RLCore:Notify', zPlayer.PlayerData.source, GetPlayerName(src).." joined to the race!", 'primary')
            end
        else
            TriggerClientEvent('RLCore:Notify', src, "You don't have enough cash in your pocket!", 'error')
        end
    else
        TriggerClientEvent('RLCore:Notify', src, "The one who made the race is offline!", 'error')
        Races[RaceId] = {}
    end
end)

RLCore.Commands.Add("race", "Start a street race.", {{name="bedrag", help="The stake amount for the race."}}, true, function(source, args)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local amount = tonumber(args[1])
    if GetJoinedRace(GetPlayerIdentifiers(src)[1]) == 0 then
        if xPlayer.PlayerData.money.cash >= amount then
            TriggerClientEvent('rl-streetraces:CreateRace', src, amount)
        else
            TriggerClientEvent('RLCore:Notify', src, "You don't have enough cash in your pocket!", 'error')
        end
    else
        TriggerClientEvent('RLCore:Notify', src, "You are already in a race!", 'error')
    end
end)

RLCore.Commands.Add("stoprace", "Stop a race as a creator.", {}, false, function(source, args)
    local src = source
    CancelRace(src)
end)

RLCore.Commands.Add("quitrace", "Get out of a race. (You will NOT get your money back!)", {}, false, function(source, args)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local RaceId = GetJoinedRace(GetPlayerIdentifiers(src)[1])
    local zPlayer = RLCore.Functions.GetPlayer(Races[RaceId].creator)
    if RaceId ~= 0 then
        if GetCreatedRace(GetPlayerIdentifiers(src)[1]) ~= RaceId then
            RemoveFromRace(GetPlayerIdentifiers(src)[1])
            TriggerClientEvent('RLCore:Notify', src, "You have stepped out of the race! And you lost your money", 'error')
        else
            TriggerClientEvent('RLCore:Notify', src, "/stop race to stop the race!", 'error')
        end
    else
        TriggerClientEvent('RLCore:Notify', src, "You are not in a race..", 'error')
    end
end)

RLCore.Commands.Add("startrace", "Race beginnen", {}, false, function(source, args)
    local src = source
    local RaceId = GetCreatedRace(GetPlayerIdentifiers(src)[1])
    
    if RaceId ~= 0 then
        Races[RaceId].started = true
        TriggerClientEvent('rl-streetraces:SetRace', -1, Races)
        TriggerClientEvent("rl-streetraces:StartRace", -1, RaceId)
    else
        TriggerClientEvent('RLCore:Notify', src, "You have not started a race!", 'error')
    end
end)

function CancelRace(source)
    local xPlayer = RLCore.Functions.GetPlayer(source)
    local RaceId = GetCreatedRace(GetPlayerIdentifiers(source)[1])

    if RaceId ~= 0 then
        for key, race in pairs(Races) do
            if Races[key] ~= nil and Races[key].creator == xPlayer.PlayerData.steam then
                if not Races[key].started then
                    for _, iden in pairs(Races[key].joined) do
                        local xdPlayer = RLCore.Functions.GetPlayer(iden)
                        xdPlayer.Functions.AddMoney('cash', Races[key].amount, "race-cancelled")
                        TriggerClientEvent('RLCore:Notify', xdPlayer.PlayerData.source, "Race has stopped, you have $"..Races[key].amount..",- received back!", 'error')
                        TriggerClientEvent('rl-streetraces:StopRace', xdPlayer.PlayerData.source)
                        RemoveFromRace(iden)
                    end
                else
                    TriggerClientEvent('RLCore:Notify', xPlayer.PlayerData.source, "The race has already started..", 'error')
                end
                TriggerClientEvent('RLCore:Notify', source, "Race stopped!", 'error')
                Races[key] = nil
            end
        end
        TriggerClientEvent('rl-streetraces:SetRace', -1, Races)
    else
        TriggerClientEvent('RLCore:Notify', source, "You have not started a race!", 'error')
    end
end

function RemoveFromRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and not Races[key].started then
            for i, iden in pairs(Races[key].joined) do
                if iden == identifier then
                    table.remove(Races[key].joined, i)
                end
            end
        end
    end
end

function GetJoinedRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and not Races[key].started then
            for _, iden in pairs(Races[key].joined) do
                if iden == identifier then
                    return key
                end
            end
        end
    end
    return 0
end

function GetCreatedRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and Races[key].creator == identifier and not Races[key].started then
            return key
        end
    end
    return 0
end
