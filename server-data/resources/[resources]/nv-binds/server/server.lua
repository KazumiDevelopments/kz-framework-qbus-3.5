RLCore = nil
Binds = {}
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

CreateThread(function()
    Wait(500)
    local fetch = json.decode(LoadResourceFile(GetCurrentResourceName(), "./database.json"))
    if fetch then
        for k,v in pairs(fetch) do
            print(k)
            Binds[k] = {}
            for bind,_ in pairs(Config.Binds) do
                if v[bind] then
                    Binds[k][bind] = v[bind]
                else
                    Binds[k][bind] = Config.Binds[bind]
                end
            end
        end
    end
end)

RegisterNetEvent("nv-binds:server:openUI")
AddEventHandler("nv-binds:server:openUI", function()
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local steam = xPlayer.PlayerData.steam

    TriggerClientEvent("nv-binds:client:openUI", src, Binds[steam])
end)

RegisterServerEvent("nv-binds:server:edit")
AddEventHandler("nv-binds:server:edit", function(data)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local steam = xPlayer.PlayerData.steam

    for k,v in pairs(Binds[steam]) do
        if v['name'] == data["bind"] then
            Binds[steam][k]['bind'] = data.key
            break
        end
    end

    TriggerClientEvent("nv-binds:client:updateUI", src, Binds[steam])
    SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Binds), -1)
end)

RegisterServerEvent("nv-binds:server:init")
AddEventHandler("nv-binds:server:init", function()
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local steam = xPlayer.PlayerData.steam

    if not Binds[steam] then
        print("[Binds] " .. steam .. ' just created.')
        Binds[steam] = Config.Binds
        SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Binds), -1)
    end

    TriggerClientEvent("nv-binds:client:updateUI", src, Binds[steam])
end)

RLCore.Commands.Add("binds", "Open Binds Menu", {}, false, function(source, args)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local steam = xPlayer.PlayerData.steam

    TriggerClientEvent("nv-binds:client:openUI", src, Binds[steam])
end)