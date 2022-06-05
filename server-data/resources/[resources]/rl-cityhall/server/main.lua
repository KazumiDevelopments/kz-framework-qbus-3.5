RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local DrivingSchools = {
    "CKF79642",
    "QGM32551",
    "GWR60231",
    "VVG19503",
}

RegisterServerEvent('rl-cityhall:server:weaponlicense:check1')
AddEventHandler('rl-cityhall:server:weaponlicense:check1', function(tog)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local licenses
    if tog then
        licenses = {
            ["driver"] = Player.PlayerData.metadata["licences"]["driver"],
            ["business"] = Player.PlayerData.metadata["licences"]["business"],
            ['weapon1'] = true
        }

        local info = {}
        info.citizenid = Player.PlayerData.citizenid
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.gender = Player.PlayerData.charinfo.gender
        info.nationality = Player.PlayerData.charinfo.nationality

        Player.Functions.SetMetaData('licences', licenses)
        Player.Functions.AddItem('weapon_card', 1, nil, info)
        TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items['weapon_card'], 'add')
    else
        licenses = {
            ["driver"] = Player.PlayerData.metadata["licences"]["driver"],
            ["business"] = Player.PlayerData.metadata["licences"]["business"],
            ['weapon1'] = false
        }
    
        Player.Functions.SetMetaData('licences', licenses)
    end
end)

RegisterServerEvent('rl-cityhall:server:requestId')
AddEventHandler('rl-cityhall:server:requestId', function(identityData)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    
    local info = {}
    if identityData.item == "id_card" then
        info.citizenid = Player.PlayerData.citizenid
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.gender = Player.PlayerData.charinfo.gender
        info.nationality = Player.PlayerData.charinfo.nationality
    elseif identityData.item == "driver_license" then
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "A1-A2-A | AM-B | C1-C-CE"
    elseif identityData.item == 'weapon_card' then
        info.citizenid = Player.PlayerData.citizenid
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.gender = Player.PlayerData.charinfo.gender
        info.nationality = Player.PlayerData.charinfo.nationality
    end
    
    Player.Functions.AddItem(identityData.item, 1, nil, info)
    TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items[identityData.item], 'add')
end)

RegisterServerEvent('rl-cityhall:server:sendDriverTest')
AddEventHandler('rl-cityhall:server:sendDriverTest', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    for k, v in pairs(DrivingSchools) do 
        local SchoolPlayer = RLCore.Functions.GetPlayerByCitizenId(v)
        if SchoolPlayer ~= nil then 
            TriggerClientEvent("rl-cityhall:client:sendDriverEmail", SchoolPlayer.PlayerData.source, Player.PlayerData.charinfo)
        else
            local mailData = {
                sender = "Township",
                subject = "Request driving lessons",
                message = "Beste,<br /><br />We have just received a message that someone wants to get driving lessons/Drivers license. <br /> If you are willing to teach, please contact:<br />Name: <strong>".. Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. "<br />Telephone: <strong>"..Player.PlayerData.charinfo.phone.."</strong><br/><br/>Sincerely,<br />City Hall",
                button = {}
            }
            TriggerEvent("rl-phone:server:sendNewEventMail", v, mailData)
        end
    end
    TriggerClientEvent('RLCore:Notify', src, 'An email has been sent to driving instructors, you will be contacted automatically', "success", 5000)
end)

RegisterServerEvent('rl-cityhall:server:ApplyJob')
AddEventHandler('rl-cityhall:server:ApplyJob', function(job)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local JobInfo = RLCore.Shared.Jobs[job]

    if not Player.Functions.SetJob(job, 0) then
        TriggerClientEvent('RLCore:Notify', src, "Invalid job or job grade")
    else
        TriggerClientEvent('RLCore:Notify', src, 'Applied your new job! ('.. JobInfo.label ..')')
    end
end)

RLCore.Commands.Add("drivinglicense", "Give a driver's license to someone", {{"id", "ID of a person"}}, true, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
    if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "lawyer" or Player.PlayerData.job.name == "judge" or Player.PlayerData.job.name == "judge" and Player.PlayerData.job.onduty) then
        local SearchedPlayer = RLCore.Functions.GetPlayer(tonumber(args[1]))
        if SearchedPlayer ~= nil then
            local driverLicense = SearchedPlayer.PlayerData.metadata["licences"]["driver"]
            if not driverLicense then
                local licenses = {
                    ["driver"] = true,
                    ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"],
                    ['weapon1'] = SearchedPlayer.PlayerData.metadata["licences"]["weapon1"]
                }
                SearchedPlayer.Functions.SetMetaData("licences", licenses)
                TriggerClientEvent('RLCore:Notify', SearchedPlayer.PlayerData.source, "you passed! Pick up your driver's license at the town hall", "success", 5000)
            else
                TriggerClientEvent('RLCore:Notify', source, "Can't issue driver's license..", "error")
            end
        end
    end
end)

RLCore.Commands.Add("weaponlicense", "Give a weapon's license to someone", {{"id", "ID of a person"}}, true, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
    if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "lawyer" or Player.PlayerData.job.name == "judge" and Player.PlayerData.job.onduty) then 
        local SearchedPlayer = RLCore.Functions.GetPlayer(tonumber(args[1]))
        if SearchedPlayer ~= nil then
            local driverLicense = SearchedPlayer.PlayerData.metadata["licences"]["weapon1"]
            if not driverLicense then
                local licenses = {
                    ["driver"] = SearchedPlayer.PlayerData.metadata["licences"]["driver"],
                    ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"],
                    ['weapon1'] = true
                }
                SearchedPlayer.Functions.SetMetaData("licences", licenses)
                TriggerClientEvent('RLCore:Notify', SearchedPlayer.PlayerData.source, "you have been granted a concealed carry license! Pick up your license at the town hall", "success", 5000)
            else
                TriggerClientEvent('RLCore:Notify', source, "Can't issue weapon's license..", "error")
            end
        end
    end
end)

function IsWhitelistedSchool(citizenid)
    local retval = false
    for k, v in pairs(DrivingSchools) do 
        if v == citizenid then
            retval = true
        end
    end
    return retval
end

RegisterServerEvent('rl-cityhall:server:banPlayer')
AddEventHandler('rl-cityhall:server:banPlayer', function()
    local src = source

    TriggerClientEvent('chat:addMessage', -1 , {
        template = '<div class="chat-message server"><b>SYSTEM:</b> {0}</div>',
        args = { GetPlayerName(src).." is banned for sending POST Requests" }
    })

    RLCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', 'Abuse localhost:13172 voor POST requests', 2145913200, '"..GetPlayerName(src).."')")
    DropPlayer(src, "This is not how we work huh;). Check our discord for more information: https://discord.gg/Em7M3uf")
end)