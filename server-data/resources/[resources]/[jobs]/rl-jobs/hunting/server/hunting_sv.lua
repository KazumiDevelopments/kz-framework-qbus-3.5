RLCore = nil

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent("hunting:sell:")
AddEventHandler("hunting:sell", function(x,y,z)
    local xPlayer = RLCore.Functions.GetPlayer(source)
	local Item = xPlayer.Functions.GetItemByName('milkbotle')

    if Item.amount > 0 then
        --for i = 1, Item.amount do
        local reward = 50
        for i = 1, Item.amount do
            reward = reward + math.random(50, 150)
        end
        xPlayer.Functions.RemoveItem('meat', 1)----change this
        TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['meat'], "remove")
        xPlayer.Functions.AddMoney("cash", reward, "sold-pawn-items")
        TriggerClientEvent('RLCore:Notify', source, "You have sold 1 piece of meat for: $"..reward) 
        --end
    end
    --TriggerEvent("qb-log:server:CreateLog", "coke", "Coke", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | *"..src.. "* ) processed a coke brick and was given 10 coke bags" )
  end)

RegisterServerEvent("hunting:reward")
AddEventHandler("hunting:reward", function(x,y,z) 
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('meat', math.random(1,4))
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['meat'], "add")
    Player.Functions.AddItem('leather', math.random(2,4))
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['meat'], "add")
    --TriggerEvent("qb-log:server:CreateLog", "coke", "Coke", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | *"..src.. "* ) processed a coke brick and was given 10 coke bags" )
end)

RegisterServerEvent("hunting:GiveWeapon")
AddEventHandler("hunting:GiveWeapon", function(x,y,z)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('weapon_heavysniper', math.random(1,1))
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['weapon_heavysniper'], "add")
    --TriggerEvent("qb-log:server:CreateLog", "coke", "Coke", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | *"..src.. "* ) processed a coke brick and was given 10 coke bags" )
end)

RegisterServerEvent("hunting:RemoveWeapon")
AddEventHandler("hunting:RemoveWeapon", function(x,y,z)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem('weapon_heavysniper', math.random(1,1))
    TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items['weapon_heavysniper'], "remove")
    --TriggerEvent("qb-log:server:CreateLog", "coke", "Coke", "orange", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | *"..src.. "* ) processed a coke brick and was given 10 coke bags" )
end)

