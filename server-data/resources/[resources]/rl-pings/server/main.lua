RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

-- Code

local Pings = {}

RLCore.Commands.Add("ping", "", {{name = "action", help="id | accept | deny"}}, true, function(source, args)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local task = args[1]
    local PhoneItem = Player.Functions.GetItemByName("phone")

    if PhoneItem ~= nil then
        if task == "accept" then
            if Pings[src] ~= nil then
                TriggerClientEvent("debug", src, 'Pings: Accept Ping', 'success')
                TriggerClientEvent('rl-pings:client:AcceptPing', src, Pings[src], RLCore.Functions.GetPlayer(Pings[src].sender))
                TriggerClientEvent('RLCore:Notify', Pings[src].sender, Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.." accepted your ping!")
                Pings[src] = nil
            else
                TriggerClientEvent('RLCore:Notify', src, "You have no ping open..", "error")
            end
        elseif task == "deny" then
            if Pings[src] ~= nil then
                TriggerClientEvent("debug", src, 'Pings: Deny Ping', 'error')
                TriggerClientEvent('RLCore:Notify', Pings[src].sender, "Your ping has been rejected..", "error")
                TriggerClientEvent('RLCore:Notify', src, "You turned down the ping..", "success")
                Pings[src] = nil
            else
                TriggerClientEvent('RLCore:Notify', src, "You have no ping open..", "error")
            end
        else
            TriggerClientEvent('rl-pings:client:DoPing', src, tonumber(args[1]))
        end
    else
        TriggerClientEvent('RLCore:Notify', src, "You don't have a phone..", "error")
    end
end)

RegisterServerEvent('rl-pings:server:SendPing')
AddEventHandler('rl-pings:server:SendPing', function(id, coords)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local Target = RLCore.Functions.GetPlayer(id)
    local PhoneItem = Player.Functions.GetItemByName("phone")

    if PhoneItem ~= nil then
        if Target ~= nil then
            local OtherItem = Target.Functions.GetItemByName("phone")
            if OtherItem ~= nil then
                TriggerClientEvent('RLCore:Notify', src, "You have sent a ping to "..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname)
                Pings[id] = {
                    coords = coords,
                    sender = src,
                }
                TriggerClientEvent('RLCore:Notify', id, "You have received a ping from "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname..". /ping 'accept | deny'")
            else
                TriggerClientEvent('RLCore:Notify', src, "Could not send ping .. Person may be out of range.", "error")
            end
        else
            TriggerClientEvent('RLCore:Notify', src, "This person is not in the city..", "error")
        end
    else
        TriggerClientEvent('RLCore:Notify', src, "You don't have a phone", "error")
    end
end)

RegisterServerEvent('rl-pings:server:SendLocation')
AddEventHandler('rl-pings:server:SendLocation', function(PingData, SenderData)
    TriggerClientEvent('rl-pings:client:SendLocation', PingData.sender, PingData, SenderData)
end)