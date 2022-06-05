local RLCore = exports['rl-core']:GetCoreObject()

local basicBeklemeCd = 7200 
local hardBeklemeCd = 7200 

local shops = {
    [1] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [2] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [3] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [4] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [5] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [6] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [7] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [8] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [9] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [10] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [11] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [12] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
	[13] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
	[14] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
    [15] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
	[16] = {
		["son_basic_cd"] = 0, 
        ["son_advanced_cd"] = 0,
    },
    [17] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
	[18] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    }, 
	[19] = {
		["son_basic_cd"] = 0,
        ["son_advanced_cd"] = 0,
    },
}

RLCore.Functions.CreateCallback('vny-shoprobbery:serversidecooldown', function(source, cb, marketNo, tip)
    local src = source
    if marketNo ~= nil then
        if tip == "basic" and (os.time() - shops[marketNo]["son_basic_cd"]) > basicBeklemeCd then
            cb(true)
        elseif tip == "hard" and (os.time() - shops[marketNo]["son_advanced_cd"]) > hardBeklemeCd then
            cb(true)
        else
            TriggerClientEvent('RLCore:Notify', src, ('This place has already been robbed!'), 'error', 5000) 
            cb(false)
        end   
    else
        -- Drop the ban code here to catch cheaters :D 
        TriggerClientEvent('RLCore:Notify', src, ('Safe Secure: Anti-Tamper device is active.'), 'error', 5000)
    end
end)

RegisterServerEvent("vny-shoprobbery:givereward")
AddEventHandler("vny-shoprobbery:givereward", function(tip, kasaNo)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    if tip == "basic" and (os.time() - shops[kasaNo]["son_basic_cd"]) > basicBeklemeCd then
        local random = math.random(350, 830)
        xPlayer.Functions.AddMoney('cash', random, "bla")
        TriggerClientEvent('RLCore:Notify', src, ('You Found $' .. random .. ''), 'success', 5000)
        shops[kasaNo]["son_basic_cd"] = os.time()
    elseif tip == "hard" and (os.time() - shops[kasaNo]["son_advanced_cd"]) > hardBeklemeCd then
        local random1 = math.random(1450, 1900)
        xPlayer.Functions.AddMoney('cash', random1, "bla")
        TriggerClientEvent('RLCore:Notify', src, ('You Found $' .. random1 .. ''), 'success', 5000)
        shops[kasaNo]["son_advanced_cd"] = os.time()
    else
        TriggerClientEvent('RLCore:Notify', src, ('You didnt find anything!'), 'success', 5000)
    end
end)