RLCore = nil
Outfits = {}
TriggerEvent(Config.TriggerPrefix .. ':GetObject', function(obj) RLCore = obj end)

CreateThread(function()
    Wait(500)
    local fetch = json.decode(LoadResourceFile(GetCurrentResourceName(), "./database.json"))
    if fetch then
        Outfits = fetch
    end
end)

RegisterServerEvent("nv-outfits:server:create")
AddEventHandler("nv-outfits:server:create", function(slot, name, data)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local citizenid = xPlayer.PlayerData.citizenid
    local slot = tonumber(slot)
    local char = xPlayer.PlayerData.citizenid

    if not slot then
        return
    end

    if not Outfits[citizenid] then
        print("[Outfits] " .. citizenid .. ' just created.')
        Outfits[citizenid] = {}
    end

    exports.ghmattimysql:execute("SELECT * FROM playersTattoos WHERE citizenid = '" .. char .. "'", {}, function(result)
        if(#result > 0) then
            data['tats'] = json.decode(result[1].tattoos)
            exports.ghmattimysql:execute("UPDATE playersTattoos SET tattoos = '{}' WHERE citizenid = '" .. char .. "'")
        else
            data['tats'] = {}
			exports.ghmattimysql:execute("INSERT INTO playersTattoos (citizenid, tattoos) VALUES ('" .. char .. "', '{}')")
        end
    end)

    while not data['tats'] do
        Wait(1)
    end

    if not Outfits[citizenid][slot] then
        Outfits[citizenid][slot] = { name = name, outfit = data }
        TriggerClientEvent("nv-outfits:client:updateUI", src, Outfits[citizenid])
    end

    SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Outfits), -1)
end)

RegisterServerEvent("nv-outfits:server:delete")
AddEventHandler("nv-outfits:server:delete", function(slot)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local citizenid = xPlayer.PlayerData.citizenid
    local slot = tonumber(slot)

    if not slot then
        return
    end
    
    if not Outfits[citizenid] then
        print("[Outfits] " .. citizenid .. ' just created.')
        Outfits[citizenid] = {}
    end

    if Outfits[citizenid][slot] then
        Outfits[citizenid][slot] = nil
    end

    TriggerClientEvent("nv-outfits:client:updateUI", src, Outfits[citizenid])
    SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Outfits), -1)
end)

RegisterServerEvent("nv-outfits:server:use")
AddEventHandler("nv-outfits:server:use", function(slot)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local citizenid = xPlayer.PlayerData.citizenid
    local slot = tonumber(slot)

    if not slot then
        return
    end
    
    if not Outfits[citizenid] then
        print("[Outfits] " .. citizenid .. ' just created.')
        Outfits[citizenid] = {}
        TriggerClientEvent("nv-outfits:client:updateUI", src, Outfits[citizenid])
    end

    if Outfits[citizenid][slot] then
        local outfit = Outfits[citizenid][slot]['outfit']
        TriggerClientEvent("nv-outfits:client:SetClothing", src, outfit)
    end

    SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Outfits), -1)
end)

RLCore.Commands.Add("outfits", "Outfits Menu", {}, false, function(source, args)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local citizenid = xPlayer.PlayerData.citizenid

    if not Outfits[citizenid] then
        print("[Outfits] " .. citizenid .. ' just created.')
        Outfits[citizenid] = {}
        SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Outfits), -1)
    end

    TriggerClientEvent("nv-outfits:client:tryUI", src, Outfits[citizenid])
end)

RegisterNetEvent("nv-outfits:server:openUI")
AddEventHandler("nv-outfits:server:openUI", function(s)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local citizenid = xPlayer.PlayerData.citizenid

    if not Outfits[citizenid] then
        print("[Outfits] " .. citizenid .. ' just created.')
        Outfits[citizenid] = {}
        SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Outfits), -1)
    end

    TriggerClientEvent("nv-outfits:client:tryUI", src, Outfits[citizenid], s)
end)