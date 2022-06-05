------ made by ry#7883 😵 //// love u guys ------

local RLCore = exports['rl-core']:GetCoreObject()

local failed = false 

local shops = {
    [1] = {
        ["basic_kasa"] = vector3(373.49, 328.49, 103.37),
        ["hard_kasa"] = vector3(378.21, 333.79, 103.57),
    },
    [2] = {
        ["basic_kasa"] = vector3(2554.74, 381.45, 108.54),
        ["hard_kasa"] = vector3(2548.88, 384.91, 108.54),
	},
    [3] = {
        ["basic_kasa"] = vector3(-3041.52, 584.43, 7.91),
        ["hard_kasa"] = vector3(-3048.14, 585.44, 7.91),
    },
    [4] = {
        ["basic_kasa"] = vector3(-1486.45, -378.24, 40.16),
        ["hard_kasa"] = vector3(-1478.71, -375.61, 39.16),
    },
    [5] = {
        ["basic_kasa"] = vector3(1393.07, 3606.22, 34.99),
        ["hard_kasa"] = vector3(1394.87, 3614.31, 34.99),
    },
    [6] = {
        ["basic_kasa"] = vector3(-2966.63, 390.88, 14.93),
        ["hard_kasa"] = vector3(-2959.63, 386.69, 14.04),
    },
    [7] = {
        ["basic_kasa"] = vector3(2676.32, 3281.04, 55.24),
        ["hard_kasa"] = vector3(2672.48, 3286.74, 55.24),
    },
    [8] = {
        ["basic_kasa"] = vector3(-46.88, -1757.55, 29.42),
        ["hard_kasa"] = vector3(-43.75, -1748.16, 29.42),
    },
    [9] = {
        ["basic_kasa"] = vector3(1164.38, -322.42, 69.48),
        ["hard_kasa"] = vector3(1159.02, -314.07, 69.48),
    },
    [10] = {
        ["basic_kasa"] = vector3(-706.47, -913.51, 19.58),
        ["hard_kasa"] = vector3(-710.25, -904.18, 19.22),
    },
    [11] = {
        ["basic_kasa"] = vector3(-1820.68, 793.97, 138.09),
        ["hard_kasa"] = vector3(-1829.43, 798.53, 138.09),
    },
    [12] = {
        ["basic_kasa"] = vector3(1698.15, 4923.11, 42.07),
        ["hard_kasa"] = vector3(1708.14, 4920.73, 42.07),
    },
	[13] = {
        ["basic_kasa"] = vector3(1959.4, 3742.23, 32.34),
        ["hard_kasa"] = vector3(1959.04, 3749.27, 32.34),
    },
	[14] = {
        ["basic_kasa"] = vector3(1134.26, -982.52, 46.42),
        ["hard_kasa"] = vector3(1126.8, -979.78, 45.42),
    },
    [15] = {
        ["basic_kasa"] = vector3(24.75, -1344.9, 29.42),
        ["hard_kasa"] = vector3(28.2, -1338.8, 29.42),
    },
	[16] = {
        ["basic_kasa"] = vector3(548.93, 2668.79, 42.04),
        ["hard_kasa"] = vector3(546.55, 2662.4, 42.04),
    },
    [17] = {
        ["basic_kasa"] = vector3(-3244.48, 1000.66, 12.83),
        ["hard_kasa"] = vector3(-3250.4, 1004.37, 12.83),
    },
	[18] = {
        ["basic_kasa"] = vector3(1166.09, 2710.28, 38.02),
        ["hard_kasa"] = vector3(1169.69, 2717.8, 37.16),
    },
	[19] = {
        ["basic_kasa"] = vector3(1729.51, 6417.01, 35.0),
        ["hard_kasa"] = vector3(1734.97, 6421.22, 35.03),
	},
}

local kasa = nil
local kasaNo = nil
local collectmoney = false

RegisterNetEvent('vny-shoprobbery:onrobbery')
AddEventHandler('vny-shoprobbery:onrobbery', function()
    local playerPed = PlayerPedId()
    local PlayerCoords = GetEntityCoords(playerPed)
    kasa = nil
    kasaNo = nil
    for i=1, #shops do
    local basitKasaMesafe = #(PlayerCoords - shops[i]["basic_kasa"])
    local hardKasaMesafe = #(PlayerCoords - shops[i]["hard_kasa"])
        if basitKasaMesafe < 1.5 then
            kasa = "basic"
            kasaNo = i
        elseif hardKasaMesafe < 1.5 then
            kasa = "hard"
            kasaNo = i
        end
    end
	RLCore.Functions.TriggerCallback('vny-shoprobbery:serversidecooldown', function(atat)
        print(atat)
		if atat then
            local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey('prop_till_01'))
            if GetEntityHealth(obj) < 800 then
                TriggerEvent('dispatch:storeRobbery', 'Store Robbery In Progress - Please Respond.')
                RLCore.Functions.Progressbar("fuckoff", "Taking Cash", 20000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 16,
                }, {}, {}, function() 
            
                TriggerServerEvent("vny-shoprobbery:givereward", "basic", kasaNo)
                end)
            else
                local math = math.random(1,3)
                if math == 1 then 
                    RLCore.Functions.Notify("Draw is locked, Find a way to open it", "error")
                elseif math == 2 then 
                    RLCore.Functions.Notify("Seems your girly hands can't do the job, Try something harder.", "error")
                elseif math == 3 then
                    RLCore.Functions.Notify("Anti-Tamper latch active, Smash it off!", "error")
                else
                    RLCore.Functions.Notify("Try swinging at it.", "error")
                end
            end
		end
	end, kasaNo, "basic")
end)



RegisterNetEvent('vny-shoprobbery:backrobbery')
AddEventHandler('vny-shoprobbery:backrobbery', function()
    local playerPed = PlayerPedId()
    local PlayerCoords = GetEntityCoords(playerPed)
    kasa = nil
    kasaNo = nil
    for i=1, #shops do
    local basitKasaMesafe = #(PlayerCoords - shops[i]["basic_kasa"])
    local hardKasaMesafe = #(PlayerCoords - shops[i]["hard_kasa"])
        if basitKasaMesafe < 1.5 then
            kasa = "basic"
            kasaNo = i
        elseif hardKasaMesafe < 1.5 then
            kasa = "hard"
            kasaNo = i
        end
    end
    RLCore.Functions.TriggerCallback('vny-shoprobbery:serversidecooldown', function(atat)
		if atat then
            if failed == true then
                RLCore.Functions.Notify("Safe Secure: Security Mode Active", "error")
            else
                exports["memorygame"]:thermiteminigame(9, 6, 2, 5,
                function()
                    TriggerEvent('dispatch:storeRobbery', 'SAFE SECURE: Safe Alarm Triggered')
                    RLCore.Functions.Progressbar("tuner_Transmission", "Opening Safe..", 45000, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = "mini@repair",
                        anim = "fixing_a_player",
                        flags = 16,
                    }, {}, {}, function()

                    RLCore.Functions.Notify("You can collect money now", "error")
                    collectmoney = true
                end)
                end,
                function()
                    TriggerEvent('dispatch:storeRobbery', 'SAFE SECURE: Safe Alarm Triggered')
                    RLCore.Functions.Notify("You couldn't open the safe", "error")
                    failed = true
                end)
            end
		end
	end, kasaNo, "hard")
end)

RegisterNetEvent('shop:reset')
AddEventHandler('shop:reset', function()
    Failed = false
end)

RegisterNetEvent('vny-shoprobbery:collectmoney')
AddEventHandler('vny-shoprobbery:collectmoney', function()
	if collectmoney then 
		TriggerServerEvent("vny-shoprobbery:givereward", "hard", kasaNo)
	else
        RLCore.Functions.Notify("First you have to get past the safe's password", "error")
	end
end)