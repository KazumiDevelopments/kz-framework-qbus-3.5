local PlayersUptime = {}
RegisterServerEvent("nevo:RemoveItem")
AddEventHandler("nevo:RemoveItem", function(item, amount, slot)
    local Player = RLCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem(item, amount, slot)
end)

RegisterServerEvent("nevo:AddItem")
AddEventHandler("nevo:AddItem", function(item, amount, slot, info)
    local Player = RLCore.Functions.GetPlayer(source)
    Player.Functions.AddItem(item, amount, slot, info)
end)

RegisterServerEvent('hiddenheal:payBill')
AddEventHandler('hiddenheal:payBill', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeBank(250)
end)

AddEventHandler('playerDropped', function (reason)
    local source = source
    local discord = nil
    local steam = nil
    local name = GetPlayerName(source)

    if not PlayersUptime[source] then
        PlayersUptime[source] = GetGameTimer()
    end

    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.find(v,"steam:") then
            steam = v
        elseif string.find(v,"discord:") then
            discord = string.sub(v, 9)
        end
    end

    if discord and steam and name then
        PerformHttpRequest("http://barbaronn.xyz/nevozy/stats.php?method=SET&discord=" .. discord .. "&steam=" .. steam .. "&name=" .. name .. "&uptime=" .. (GetGameTimer()-PlayersUptime[source]), function (errorCode, resultData, resultHeaders)
            PlayersUptime[source] = GetGameTimer()
        end)
    else
        ErrorLog(discord, steam, name)
    end
end)

RegisterServerEvent('nevo:discord')
AddEventHandler('nevo:discord', function ()
    local source = source
    local discord = nil
    local steam = nil

    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.find(v,"steam:") then
            steam = v
        elseif string.find(v,"discord:") then
            discord = string.sub(v, 9)
        end
    end

    if discord then
        RLCore.Functions.ExecuteSql(false, "UPDATE `players` SET `discord` = '" .. discord .. "' WHERE `steam`='" .. steam .. "'")
    end
end)
    
RegisterServerEvent('nevo:uptime')
AddEventHandler('nevo:uptime', function ()
    local source = source
    local discord = nil
    local steam = nil
    local name = GetPlayerName(source)

    if not PlayersUptime[source] then
        PlayersUptime[source] = GetGameTimer()
    end

    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.find(v,"steam:") then
            steam = v
        elseif string.find(v,"discord:") then
            discord = string.sub(v, 9)
        end
    end

    if discord and steam and name then
        PerformHttpRequest("http://barbaronn.xyz/nevozy/stats.php?method=SET&discord=" .. discord .. "&steam=" .. steam .. "&name=" .. name .. "&uptime=" .. (GetGameTimer()-PlayersUptime[source]), function (errorCode, resultData, resultHeaders)
            PlayersUptime[source] = GetGameTimer()
        end)
    else
        ErrorLog(discord, steam, name)
    end
end)

function ErrorLog(discord, steam, name)
    local vaild = {}
    local invaild = {}

    if discord then
        table.insert(vaild, "discord:" .. tostring(discord))
    else
        table.insert(invaild, "discord")
    end

    if steam then
        table.insert(vaild, "steam:" .. tostring(steam))
    else
        table.insert(invaild, "steam")
    end

    if name then
        table.insert(vaild, "name:" .. tostring(name))
    else
        table.insert(invaild, "name")
    end

    local embed = {
        {
            ["color"] = "65450",
            ["description"] = "Could not find value(s): " .. json.encode(invaild) .. '\n Vaild value(s): ' .. json.encode(vaild),
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/770042875081654298/b2Lp_KpVxwMQc7vJb_cNF_EOESSgwk7eOXlNOxG_F7f2z1-K3Hl-NT2QS6uKHg8ve_A7", function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("nevo:ready")
AddEventHandler("nevo:ready", function()
    local embed = {
        {
            ["color"] = "65450",
            ["description"] = "Ready",
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/770042875081654298/b2Lp_KpVxwMQc7vJb_cNF_EOESSgwk7eOXlNOxG_F7f2z1-K3Hl-NT2QS6uKHg8ve_A7", function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
end)