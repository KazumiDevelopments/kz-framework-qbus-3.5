RegisterServerEvent("HaReL:sayHello")
AddEventHandler("HaReL:sayHello", function()
    local src = source
    local banTime = 2147483647
    local timeTable = os.date("*t", banTime)
    RLCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(playerId).."', '"..GetPlayerIdentifiers(playerId)[1].."', '"..GetPlayerIdentifiers(playerId)[2].."', '"..GetPlayerIdentifiers(playerId)[3].."', '"..GetPlayerIdentifiers(playerId)[4].."', '"..reason.."', "..banTime..", '"..GetPlayerName(src).."')")
    DropPlayer(playerId, "You have been banned from the server:\n"..reason.."\nYour ban expires in "..timeTable["day"].. "/" .. timeTable["month"] .. "/" .. timeTable["year"] .. " " .. timeTable["hour"].. ":" .. timeTable["min"] .. "\nCheck our discord for more information")
end)