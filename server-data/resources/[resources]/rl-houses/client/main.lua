local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

inside = false
closesthouse = nil
hasKey = false
isOwned = false

isLoggedIn = true
local contractOpen = false

local cam = nil
local viewCam = false
local showClothing = false
local FrontCam = false

stashLocation = nil
outfitLocation = nil
logoutLocation = nil

local OwnedHouseBlips = {}

local CurrentDoorBell = 0
local rangDoorbell = nil

local houseObj = {}
local POIOffsets = nil
local entering = false
local data = nil

local CurrentHouse = nil

RLCore = nil

local inHoldersMenu = false

Citizen.CreateThread(function() 
    while RLCore == nil do
        Citizen.Wait(10)
        TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
    end

    while not RLCore.Functions.GetPlayerData() do
        Wait(1)
    end

    while not RLCore.Functions.GetPlayerData().job do
        Wait(1)
    end

    TriggerServerEvent('rl-houses:server:init')
end)

RegisterNetEvent('rl-houses:client:sellHouse')
AddEventHandler('rl-houses:client:sellHouse', function()
    if closesthouse ~= nil and hasKey then
        TriggerServerEvent('rl-houses:server:viewHouse', closesthouse)
    end
end)

--------------------------------------------------------------
--[[ Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)

        if isLoggedIn then
            if not inside then
                SetClosestHouse()
            end
        end
    end
end) ]]

RegisterNetEvent('rl-houses:client:EnterHouse')
AddEventHandler('rl-houses:client:EnterHouse', function(god)
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)

    if closesthouse ~= nil then
        local dist = GetDistanceBetweenCoords(pos, Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z, true)
        if dist < 1.5 then
            if god then
                enterOwnedHouse(closesthouse)
                return
            end

            if hasKey then
                enterOwnedHouse(closesthouse)
            else
                if not Config.Houses[closesthouse].locked then
                    enterNonOwnedHouse(closesthouse)
                end
            end
        end
    end
end)

RegisterNetEvent('rl-houses:client:RequestRing')
AddEventHandler('rl-houses:client:RequestRing', function()
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)

    if closesthouse ~= nil then
        TriggerServerEvent('rl-houses:server:RingDoor', closesthouse)
    end
end)

Citizen.CreateThread(function()
    Wait(1000)
    
    TriggerServerEvent('rl-houses:client:setHouses')
    isLoggedIn = true
    SetClosestHouse()
    TriggerEvent('rl-houses:client:setupHouseBlips')
    Citizen.Wait(100)
    TriggerEvent('rl-garages:client:setHouseGarage', closesthouse, hasKey)
    TriggerServerEvent("rl-houses:server:setHouses")
end)

function doorText(x, y, z, text)
    SetTextScale(0.325, 0.325)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.011, -0.025+ factor, 0.03, 0, 0, 0, 68)
    ClearDrawOrigin()
end

RegisterNetEvent('RLCore:Client:OnPlayerLoaded')
AddEventHandler('RLCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('rl-houses:client:setHouses')
    isLoggedIn = true
    SetClosestHouse()
    TriggerEvent('rl-houses:client:setupHouseBlips')
    Citizen.Wait(100)
    TriggerEvent('rl-garages:client:setHouseGarage', closesthouse, hasKey)
    TriggerServerEvent("rl-houses:server:setHouses")
end)

RegisterNetEvent('RLCore:Client:OnPlayerUnload')
AddEventHandler('RLCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
    inside = false
    closesthouse = nil
    hasKey = false
    isOwned = false
    for k, v in pairs(OwnedHouseBlips) do
        RemoveBlip(v)
    end
end)

RegisterNetEvent('rl-houses:client:setHouseConfig')
AddEventHandler('rl-houses:client:setHouseConfig', function(houseConfig)
    Config.Houses = houseConfig
end) 

RegisterNetEvent('rl-houses:client:lockHouse')
AddEventHandler('rl-houses:client:lockHouse', function(bool, house)
    Config.Houses[house].locked = bool
end)

RegisterNetEvent('rl-houses:client:createHouses')
AddEventHandler('rl-houses:client:createHouses', function(price, tier)
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local heading = GetEntityHeading(GetPlayerPed(-1))
    local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    local street = GetStreetNameFromHashKey(s1)
    local coords = {
        enter 	= { x = pos.x, y = pos.y, z = pos.z, h = heading},
        cam 	= { x = pos.x, y = pos.y, z = pos.z, h = heading, yaw = -10.00},
    }
    street = street:gsub("%-", " ")
    TriggerServerEvent('rl-houses:server:addNewHouse', street, coords, price, tier)
end)

RegisterNetEvent('rl-houses:client:addGarage')
AddEventHandler('rl-houses:client:addGarage', function()
    if closesthouse ~= nil then 
        local pos = GetEntityCoords(GetPlayerPed(-1))
        local heading = GetEntityHeading(GetPlayerPed(-1))
        local coords = {
            x = pos.x,
            y = pos.y,
            z = pos.z,
            h = heading,
        }
        TriggerServerEvent('bb-garages:server:addHouseGarage', closesthouse, coords, max)
    else
        RLCore.Functions.Notify("No house nearby.", "error")
    end
end)

RegisterNetEvent('rl-houses:client:toggleDoorlock')
AddEventHandler('rl-houses:client:toggleDoorlock', function()
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    
    if(GetDistanceBetweenCoords(pos, Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z, true) < 1.5)then
        if hasKey then
            if Config.Houses[closesthouse].locked then
                TriggerServerEvent('rl-houses:server:lockHouse', false, closesthouse)
                RLCore.Functions.Notify("House is unlocked!", "success", 2500)
            else
                TriggerServerEvent('rl-houses:server:lockHouse', true, closesthouse)
                RLCore.Functions.Notify("House is locked!", "error", 2500)
            end
        else
            RLCore.Functions.Notify("You don't have the keys to this house.", "error", 3500)
        end
    else
        RLCore.Functions.Notify("There is no door to be seen?", "error", 3500)
    end
end)

DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end



Citizen.CreateThread(function()
    while true do

        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        local inRange = false
 
        if closesthouse ~= nil then
            if(GetDistanceBetweenCoords(pos, Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z, false) < 30)then
                inRange = true
                if hasKey then
                    -- ENTER HOUSE
                    if not inside then
                        if closesthouse ~= nil then
                            if(GetDistanceBetweenCoords(pos, Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z, true) < 1.5)then
                                if Config.Houses[closesthouse].locked then
                                    DrawText3Ds(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z, '~b~E~w~ - Enter')
                                elseif not Config.Houses[closesthouse].locked then
                                    DrawText3Ds(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z, '~b~E~w~ - Enter')
                                end
                                if IsControlJustPressed(0, Keys["E"]) then
                                    enterOwnedHouse(closesthouse)
									TriggerEvent("inhouse",true)
                                end
                            end
                        end
                    end

                    if CurrentDoorBell ~= 0 then
                        if(GetDistanceBetweenCoords(pos, Config.Houses[closesthouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[closesthouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[closesthouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z, true) < 1.5)then
                            DrawText3Ds(Config.Houses[closesthouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[closesthouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[closesthouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z + 0.35, '~g~G~w~ - Open the door')
                            if IsControlJustPressed(0, Keys["G"]) then
                                TriggerServerEvent("rl-houses:server:OpenDoor", CurrentDoorBell, closesthouse)
                                CurrentDoorBell = 0
                            end
                        end
                    end
                    -- EXIT HOUSE
				    if inside then
                        if not entering then
                            if POIOffsets ~= nil then
                                if POIOffsets.exit ~= nil then
                                    if(GetDistanceBetweenCoords(pos, Config.Houses[closesthouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[closesthouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[closesthouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z, true) < 1.5)then
                                        DrawText3Ds(Config.Houses[closesthouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[closesthouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[closesthouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z, '~g~E~w~ - To leave the house')
                                        DrawText3Ds(Config.Houses[closesthouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[closesthouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[closesthouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z - 0.1, '~g~H~w~ - Watch camera')
                                        if IsControlJustPressed(0, Keys["E"]) then
                                        leaveOwnedHouse(closesthouse)
									    TriggerEvent("inhouse",false)
                                        end
                                        if IsControlJustPressed(0, Keys["H"]) then
                                            FrontDoorCam(Config.Houses[closesthouse].coords.enter)
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if not isOwned then
                        if closesthouse ~= nil then 
                            if(GetDistanceBetweenCoords(pos, Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z, true) < 1.5)then
                                if not viewCam and Config.Houses[closesthouse].locked then
                                    DrawText3Ds(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z, '[~g~E~w~] See house')
                                    if IsControlJustPressed(0, Keys["E"]) then
                                        TriggerServerEvent('rl-houses:server:viewHouse', closesthouse)
                                    end
                                elseif not viewCam and not Config.Houses[closesthouse].locked then
                                    DrawText3Ds(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z + 1.2, '[~g~E~w~] Enter')
                                    if IsControlJustPressed(0, Keys["E"])  then
                                        enterNonOwnedHouse(closesthouse)
                                    end
                                end
                            end
                        end
                    elseif isOwned then
                        if closesthouse ~= nil then
                            if not inOwned then
                                if(GetDistanceBetweenCoords(pos, Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z, true) < 1.5)then
                                    if not Config.Houses[closesthouse].locked then
                                        DrawText3Ds(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z + 1.2, '[~g~E~w~] Enter')
                                        if IsControlJustPressed(0, Keys["E"])  then
                                            enterNonOwnedHouse(closesthouse)
                                        end
                                    else
                                        DrawText3Ds(Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z + 1.2, 'The door is ~r~closed / ~g~G~w~ - Call at the doorbell')
                                        if IsControlJustPressed(0, Keys["G"]) then
                                            TriggerServerEvent('rl-houses:server:RingDoor', closesthouse)
                                        end
                                    end
                                end
                            elseif inOwned then
                                if(GetDistanceBetweenCoords(pos, Config.Houses[closesthouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[closesthouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[closesthouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z, true) < 1.5)then
                                    DrawText3Ds(Config.Houses[closesthouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[closesthouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[closesthouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z, '~g~E~w~ - Leave')
                                    if IsControlJustPressed(0, Keys["E"]) then
                                        leaveNonOwnedHouse(closesthouse)
                                    end
                                end
                            end
                        end
                    end
                    if inside and not isOwned then
                        if not entering then
                            if(GetDistanceBetweenCoords(pos, Config.Houses[closesthouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[closesthouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[closesthouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z, true) < 1.5)then
                                DrawText3Ds(Config.Houses[closesthouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[closesthouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[closesthouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z, '~g~E~w~ - Leave')
                                if IsControlJustPressed(0, Keys["E"]) then
                                    leaveNonOwnedHouse(closesthouse)
                                end
                            end
                        end
                    end
                end
                
                local StashObject = nil
                -- STASH
                if inside then
                    if closesthouse ~= nil then
                        if stashLocation ~= nil then
                            if(GetDistanceBetweenCoords(pos, stashLocation.x, stashLocation.y, stashLocation.z, true) < 1.5)then
                                DrawText3Ds(stashLocation.x, stashLocation.y, stashLocation.z, '~g~E~w~ - Drawer')
                                if IsControlJustPressed(0, Keys["E"]) then
									local other = {}
                                    other.maxweight = 1000000
                                    other.slots = 50
                                    if Config.Houses[CurrentHouse].tier == 1 then
                                        other.maxweight = 1500000
                                        other.slots = 60
                                    end
                                    if Config.Houses[CurrentHouse].tier == 2 then
                                        other.maxweight = 2000000
                                        other.slots = 70
                                    end
                                    if Config.Houses[CurrentHouse].tier == 3 then
                                        other.maxweight = 2500000
                                        other.slots = 80
                                    end
                                    if Config.Houses[CurrentHouse].tier == 4 then
                                        other.maxweight = 3000000
                                        other.slots = 90
                                    end				
                                    TriggerServerEvent("inventory:server:OpenInventory", "stash", CurrentHouse, other)
                                    TriggerEvent("inventory:client:SetCurrentStash", CurrentHouse)
                                end
                            elseif(GetDistanceBetweenCoords(pos, stashLocation.x, stashLocation.y, stashLocation.z, true) < 3)then
                                DrawText3Ds(stashLocation.x, stashLocation.y, stashLocation.z, 'Drawer')
                            end
                        end
                    end
                end
				
				local Stash2Object = nil
                -- STASH
                if inside then
                    if closesthouse ~= nil then
                        if stash2Location ~= nil then
                            if(GetDistanceBetweenCoords(pos, stash2Location.x, stash2Location.y, stash2Location.z, true) < 1.5)then
                                DrawText3Ds(stash2Location.x, stash2Location.y, stash2Location.z, '~g~E~w~ - Drawer 2')
                                if IsControlJustPressed(0, Keys["E"]) then
									TriggerServerEvent("inventory:server:OpenInventory", "stash", CurrentHouse, other)
                                end
                            elseif(GetDistanceBetweenCoords(pos, stash2Location.x, stash2Location.y, stash2Location.z, true) < 3)then
                               DrawText3Ds(stash2Location.x, stash2Location.y, stash2Location.z, '~g~E~w~ - Drawer 2')
                            end
                        end
                    end
                end

                if inside then
                    if closesthouse ~= nil then
                        if outfitLocation ~= nil then
                            if(GetDistanceBetweenCoords(pos, outfitLocation.x, outfitLocation.y, outfitLocation.z, true) < 1.5)then
                                DrawText3Ds(outfitLocation.x, outfitLocation.y, outfitLocation.z, '/outfits')
                                showClothing = true
                            else
                                showClothing = false
                            end
                        end
                    end
                end

                if inside then
                    if closesthouse ~= nil then
                        if logoutLocation ~= nil then
                            if(GetDistanceBetweenCoords(pos, logoutLocation.x, logoutLocation.y, logoutLocation.z, true) < 1.5)then
                                DrawText3Ds(logoutLocation.x, logoutLocation.y, logoutLocation.z, '~g~E~w~ - Switch Character')
                                if IsControlJustPressed(0, Keys["E"]) then
                                    DoScreenFadeOut(250)
                                    while not IsScreenFadedOut() do
                                        Citizen.Wait(10)
                                    end
                                    showClothing = false
                                    exports['rl-interior']:DespawnInterior(houseObj, function()
                                        TriggerEvent('rl-weathersync:client:EnableSync')
                                        SetEntityCoords(GetPlayerPed(-1), Config.Houses[CurrentHouse].coords.enter.x, Config.Houses[CurrentHouse].coords.enter.y, Config.Houses[CurrentHouse].coords.enter.z + 0.5)
                                        SetEntityHeading(GetPlayerPed(-1), Config.Houses[CurrentHouse].coords.enter.h)
                                        inOwned = false
                                        inside = false
                                        TriggerServerEvent('rl-houses:server:LogoutLocation')
                                    end)
                                end
                            elseif(GetDistanceBetweenCoords(pos, logoutLocation.x, logoutLocation.y, logoutLocation.z, true) < 3)then
                                DrawText3Ds(logoutLocation.x, logoutLocation.y, logoutLocation.z, 'Switch Character')
                            end
                        end
                    end
                end
            end
        end
        if not inRange then
            Citizen.Wait(1500)
        end
    
        Citizen.Wait(3)
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if inHoldersMenu then
            Menu.renderGUI()
        end
    end
end)

function openHouseAnim()
    loadAnimDict("anim@heists@keycard@") 
    TaskPlayAnim( GetPlayerPed(-1), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(400)
    ClearPedTasks(GetPlayerPed(-1))
end

RegisterNetEvent('rl-houses:client:RingDoor')
AddEventHandler('rl-houses:client:RingDoor', function(player, house)
    if closesthouse == house and inside then
        CurrentDoorBell = player
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "doorbell", 0.1)
        RLCore.Functions.Notify("Someone is ringing the doorbell!")
    end
end)

function GetClosestPlayer()
    local closestPlayers = RLCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(GetPlayerPed(-1))

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end

	return closestPlayer, closestDistance
end

RegisterNetEvent('rl-houses:client:giveHouseKey')
AddEventHandler('rl-houses:client:giveHouseKey', function(data)
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 and closesthouse ~= nil then
        local playerId = GetPlayerServerId(player)
        local housedist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z)
        
        if housedist < 10 then
            TriggerServerEvent('rl-houses:server:giveHouseKey', playerId, closesthouse)
        else
            RLCore.Functions.Notify("You are not close enough to the house..", "error")
        end
    elseif closesthouse == nil then
        RLCore.Functions.Notify("There is no house nearby!", "error")
    else
        RLCore.Functions.Notify("No one around!", "error")
    end
end)

RegisterNetEvent('rl-houses:client:removeHouseKey')
AddEventHandler('rl-houses:client:removeHouseKey', function(data)
    if closesthouse ~= nil then 
        local housedist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z)
        if housedist < 5 then
            RLCore.Functions.TriggerCallback('rl-houses:server:getHouseOwner', function(result)
                if RLCore.Functions.GetPlayerData().citizenid == result then
                    inHoldersMenu = true
                    HouseKeysMenu()
                    Menu.hidden = not Menu.hidden
                else
                    RLCore.Functions.Notify("You are not a home owner..", "error")
                end
            end, closesthouse)
        else
            RLCore.Functions.Notify("You are not close enough to the house..", "error")
        end
    else
        RLCore.Functions.Notify("You are not close enough to the house..", "error")
    end
end)

RegisterNetEvent('rl-houses:client:refreshHouse')
AddEventHandler('rl-houses:client:refreshHouse', function(data)
    Citizen.Wait(100)
    SetClosestHouse()
    --TriggerEvent('rl-garages:client:setHouseGarage', closesthouse, hasKey)
end)

RegisterNetEvent('rl-houses:client:SpawnInApartment')
AddEventHandler('rl-houses:client:SpawnInApartment', function(house)
    local pos = GetEntityCoords(GetPlayerPed(-1))
    if rangDoorbell ~= nil then
        if(GetDistanceBetweenCoords(pos, Config.Houses[house].coords.enter.x, Config.Houses[house].coords.enter.y, Config.Houses[house].coords.enter.z, true) > 5)then
            return
        end
    end
    closesthouse = house
    enterNonOwnedHouse(house)
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end 

function HouseKeysMenu()
    ped = GetPlayerPed(-1);
    MenuTitle = "Keys"
    ClearMenu()
    RLCore.Functions.TriggerCallback('rl-houses:server:getHouseKeyHolders', function(holders)
        ped = GetPlayerPed(-1);
        MenuTitle = "Key holders:"
        ClearMenu()
        if holders == nil or next(holders) == nil then
            RLCore.Functions.Notify("No key holders found.", "error", 3500)
            closeMenuFull()
        else
            for k, v in pairs(holders) do
                Menu.addButton(holders[k].firstname .. " " .. holders[k].lastname, "optionMenu", holders[k]) 
            end
        end
        Menu.addButton("Close Menu", "closeMenuFull", nil) 
    end, closesthouse)
end

function changeOutfit()
	Wait(200)
    loadAnimDict("clothingshirt")    	
	TaskPlayAnim(GetPlayerPed(-1), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
	Wait(3100)
	TaskPlayAnim(GetPlayerPed(-1), "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

function optionMenu(citizenData)
    ped = GetPlayerPed(-1);
    MenuTitle = "What now?"
    ClearMenu()
    Menu.addButton("Remove Key", "removeHouseKey", citizenData) 
    Menu.addButton("Return", "HouseKeysMenu",nil)
end

function removeHouseKey(citizenData)
    TriggerServerEvent('rl-houses:server:removeHouseKey', closesthouse, citizenData)
    closeMenuFull()
end

function removeOutfit(oData)
    TriggerServerEvent('clothes:removeOutfit', oData.outfitname)
    RLCore.Functions.Notify(oData.outfitname.." is removed", "success", 2500)
    closeMenuFull()
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    inHoldersMenu = false
    ClearMenu()
end

function ClearMenu()
	--Menu = {}
	Menu.GUI = {}
	Menu.buttonCount = 0
	Menu.selection = 0
end

function openContract(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "toggle",
        status = bool,
    })
    contractOpen = bool
end

function enterOwnedHouse(house)
    CurrentHouse = house
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    openHouseAnim()
    inside = true
    Citizen.Wait(250)
    local coords = { x = Config.Houses[house].coords.enter.x, y = Config.Houses[house].coords.enter.y, z= Config.Houses[house].coords.enter.z - Config.MinZOffset}
    LoadDecorations(house)

    if Config.Houses[house].tier == 1 then
        data = exports['rl-interior']:CreateCaravanShell(coords)
        --data = exports['rl-interior']:CreateTier1House(coords)
	elseif Config.Houses[house].tier == 2 then
        data = exports['rl-interior']:CreateApartmentShell(coords)
        --data = exports['rl-interior']:CreateMichaelShell(coords)
	elseif Config.Houses[house].tier == 3 then
        data = exports['rl-interior']:CreateFranklinAuntShell(coords)
        --data = exports['rl-interior']:CreateTrevorsShell(coords)
	elseif Config.Houses[house].tier == 4 then
        data = exports['rl-interior']:CreateTrevorsShell(coords)
        --data = exports['rl-interior']:CreateFranklinShell(coords)
	elseif Config.Houses[house].tier == 5 then
        data = exports['rl-interior']:CreateTier1House(coords)
        --data = exports['rl-interior']:CreateFranklinAuntShell(coords)
	elseif Config.Houses[house].tier == 6 then
        data = exports['rl-interior']:CreateMichaelShell(coords)
        --data = exports['rl-interior']:CreateApartmentShell(coords)
	elseif Config.Houses[house].tier == 7 then
        data = exports['rl-interior']:CreateFranklinShell(coords)
        --data = exports['rl-interior']:CreateCaravanShell(coords)
    end


    Citizen.Wait(100)
    houseObj = data[1]
    POIOffsets = data[2]
    print(POIOffsets)
    print(data[2])
    print(POIOffsets.exit.x)
    entering = true
    TriggerServerEvent('rl-houses:server:SetInsideMeta', house, true)
    Citizen.Wait(500)
    SetRainFxIntensity(0.0)
    TriggerEvent('rl-weathersync:client:DisableSync')
    TriggerEvent('rl-weed:client:getHousePlants', house)
    Citizen.Wait(100)
    SetWeatherTypePersist('EXTRASUNNY')
    SetWeatherTypeNow('EXTRASUNNY')
    SetWeatherTypeNowPersist('EXTRASUNNY')
    NetworkOverrideClockTime(12, 0, 0)
    entering = false
    showClothing = true
    setHouseLocations()
end

RegisterNetEvent('rl-houses:client:enterOwnedHouse')
AddEventHandler('rl-houses:client:enterOwnedHouse', function(house)
    RLCore.Functions.GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] == 0 then
			enterOwnedHouse(house)
		end
	end)
end)

RegisterNUICallback('HasEnoughMoney', function(data, cb)
    RLCore.Functions.TriggerCallback('rl-houses:server:HasEnoughMoney', function(hasEnough)
        
    end, data.objectData)
end)

RegisterNetEvent('rl-houses:client:LastLocationHouse')
AddEventHandler('rl-houses:client:LastLocationHouse', function(houseId)
    RLCore.Functions.GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] == 0 then
			enterOwnedHouse(houseId)
		end
	end)
end)

function leaveOwnedHouse(house)
    if not FrontCam then
        inside = false
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
        openHouseAnim()
        Citizen.Wait(250)
        DoScreenFadeOut(250)
        Citizen.Wait(500)
        exports['rl-interior']:DespawnInterior(houseObj, function()
            UnloadDecorations()
            TriggerEvent('rl-weathersync:client:EnableSync')
            Citizen.Wait(250)
            DoScreenFadeIn(250)
            SetEntityCoords(GetPlayerPed(-1), Config.Houses[CurrentHouse].coords.enter.x, Config.Houses[CurrentHouse].coords.enter.y, Config.Houses[CurrentHouse].coords.enter.z + 0.2)
            SetEntityHeading(GetPlayerPed(-1), Config.Houses[CurrentHouse].coords.enter.h)
            TriggerEvent('rl-weed:client:leaveHouse')
            TriggerServerEvent('rl-houses:server:SetInsideMeta', house, false)
            CurrentHouse = nil
            showClothing = false
        end)
    end
end

function enterNonOwnedHouse(house)
    CurrentHouse = house
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    openHouseAnim()
    inside = true
    Citizen.Wait(250)
    local coords = { x = Config.Houses[closesthouse].coords.enter.x, y = Config.Houses[closesthouse].coords.enter.y, z= Config.Houses[closesthouse].coords.enter.z - Config.MinZOffset}
    LoadDecorations(house)

    if Config.Houses[house].tier == 1 then
        data = exports['rl-interior']:CreateCaravanShell(coords)
        --data = exports['rl-interior']:CreateTier1House(coords)
	elseif Config.Houses[house].tier == 2 then
        data = exports['rl-interior']:CreateApartmentShell(coords)
        --data = exports['rl-interior']:CreateMichaelShell(coords)
	elseif Config.Houses[house].tier == 3 then
        data = exports['rl-interior']:CreateFranklinAuntShell(coords)
        --data = exports['rl-interior']:CreateTrevorsShell(coords)
	elseif Config.Houses[house].tier == 4 then
        data = exports['rl-interior']:CreateTrevorsShell(coords)
        --data = exports['rl-interior']:CreateFranklinShell(coords)
	elseif Config.Houses[house].tier == 5 then
        data = exports['rl-interior']:CreateTier1House(coords)
        --data = exports['rl-interior']:CreateFranklinAuntShell(coords)
	elseif Config.Houses[house].tier == 6 then
        data = exports['rl-interior']:CreateMichaelShell(coords)
        --data = exports['rl-interior']:CreateApartmentShell(coords)
	elseif Config.Houses[house].tier == 7 then
        data = exports['rl-interior']:CreateFranklinShell(coords)
        --data = exports['rl-interior']:CreateCaravanShell(coords)
    end

    houseObj = data[1]
    POIOffsets = data[2]
    entering = true
    Citizen.Wait(500)
    SetRainFxIntensity(0.0)
    TriggerServerEvent('rl-houses:server:SetInsideMeta', house, true)
    TriggerEvent('rl-weathersync:client:DisableSync')
    TriggerEvent('rl-weed:client:getHousePlants', house)
    Citizen.Wait(100)
    SetWeatherTypePersist('EXTRASUNNY')
    SetWeatherTypeNow('EXTRASUNNY')
    SetWeatherTypeNowPersist('EXTRASUNNY')
    NetworkOverrideClockTime(12, 0, 0)
    entering = false
    inOwned = true
    showClothing = false
    setHouseLocations()
end

function leaveNonOwnedHouse(house)
    if not FrontCam then
        inside = false
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
        openHouseAnim()
        Citizen.Wait(250)
        DoScreenFadeOut(250)
        Citizen.Wait(500)
        exports['rl-interior']:DespawnInterior(houseObj, function()
            UnloadDecorations()
            TriggerEvent('rl-weathersync:client:EnableSync')
            Citizen.Wait(250)
            DoScreenFadeIn(250)
            SetEntityCoords(GetPlayerPed(-1), Config.Houses[CurrentHouse].coords.enter.x, Config.Houses[CurrentHouse].coords.enter.y, Config.Houses[CurrentHouse].coords.enter.z + 0.2)
            SetEntityHeading(GetPlayerPed(-1), Config.Houses[CurrentHouse].coords.enter.h)
            inOwned = false
            TriggerEvent('rl-weed:client:leaveHouse')
            TriggerServerEvent('rl-houses:server:SetInsideMeta', house, false)
            CurrentHouse = nil
            showClothing = false
        end)
    end
end

RegisterNetEvent('rl-houses:client:setupHouseBlips')
AddEventHandler('rl-houses:client:setupHouseBlips', function()
    Citizen.CreateThread(function()
        Citizen.Wait(2000)
        if isLoggedIn then
            RLCore.Functions.TriggerCallback('rl-houses:server:getOwnedHouses', function(ownedHouses)
                if ownedHouses ~= nil then
                    for k, v in pairs(ownedHouses) do
                        local house = Config.Houses[ownedHouses[k]]
                        HouseBlip = AddBlipForCoord(house.coords.enter.x, house.coords.enter.y, house.coords.enter.z)

                        SetBlipSprite (HouseBlip, 40)
                        SetBlipDisplay(HouseBlip, 4)
                        SetBlipScale  (HouseBlip, 0.65)
                        SetBlipAsShortRange(HouseBlip, true)
                        SetBlipColour(HouseBlip, 3)

                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentSubstringPlayerName(house.adress)
                        EndTextCommandSetBlipName(HouseBlip)

                        table.insert(OwnedHouseBlips, HouseBlip)
                    end
                end
            end)
        end
    end)
end)

local toggleblips, toggleblipsdata = false, {}
RegisterNetEvent('ToggleHouseBlips')
AddEventHandler('ToggleHouseBlips', function()
    if toggleblips then
        toggleblips = false
        for k, v in pairs(toggleblipsdata) do
            RemoveBlip(v)
        end
        toggleblipsdata = {}
    else
        toggleblips = true
        CreateThread(function()
            for k, house in pairs(Config.Houses) do
                local HouseBlips = AddBlipForCoord(house.coords.enter.x, house.coords.enter.y, house.coords.enter.z)

                SetBlipSprite (HouseBlips, 40)
                SetBlipDisplay(HouseBlips, 4)
                SetBlipScale  (HouseBlips, 0.65)
                SetBlipAsShortRange(HouseBlips, true)
                SetBlipColour(HouseBlips, 3)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName(house.adress)
                EndTextCommandSetBlipName(HouseBlips)

                table.insert(toggleblipsdata, HouseBlips)
            end
        end)
    end
end)

RegisterNetEvent('rl-houses:client:SetClosestHouse')
AddEventHandler('rl-houses:client:SetClosestHouse', function()
    SetClosestHouse()
end)

function setViewCam(coords, h, yaw)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z, yaw, 0.00, h, 80.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
    viewCam = true
end

function FrontDoorCam(coords)
    DoScreenFadeOut(150)
    Citizen.Wait(500)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z + 0.5, 0.0, 0.00, coords.h - 180, 80.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
    FrontCam = true
    FreezeEntityPosition(GetPlayerPed(-1), true)
    Citizen.Wait(500)
    DoScreenFadeIn(150)
    SendNUIMessage({
        type = "frontcam",
        toggle = true,
        label = Config.Houses[closesthouse].adress
    })
    Citizen.CreateThread(function()
        while FrontCam do

            local instructions = CreateInstuctionScaleform("instructional_buttons")
            DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
            SetTimecycleModifier("scanline_cam_cheap")
            SetTimecycleModifierStrength(1.0)

            if IsControlJustPressed(1, Keys["BACKSPACE"]) then
                DoScreenFadeOut(150)
                SendNUIMessage({
                    type = "frontcam",
                    toggle = false,
                })
                Citizen.Wait(500)
                RenderScriptCams(false, true, 500, true, true)
                FreezeEntityPosition(GetPlayerPed(-1), false)
                SetCamActive(cam, false)
                DestroyCam(cam, true)
                ClearTimecycleModifier("scanline_cam_cheap")
                cam = nil
                FrontCam = false
                Citizen.Wait(500)
                DoScreenFadeIn(150)
            end

            local getCameraRot = GetCamRot(cam, 2)

            -- ROTATE UP
            if IsControlPressed(0, Keys["W"]) then
                if getCameraRot.x <= 0.0 then
                    SetCamRot(cam, getCameraRot.x + 0.7, 0.0, getCameraRot.z, 2)
                end
            end

            -- ROTATE DOWN
            if IsControlPressed(0, Keys["S"]) then
                if getCameraRot.x >= -50.0 then
                    SetCamRot(cam, getCameraRot.x - 0.7, 0.0, getCameraRot.z, 2)
                end
            end

            -- ROTATE LEFT
            if IsControlPressed(0, Keys["A"]) then
                SetCamRot(cam, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
            end

            -- ROTATE RIGHT
            if IsControlPressed(0, Keys["D"]) then
                SetCamRot(cam, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
            end

            Citizen.Wait(1)
        end
    end)
end

function CreateInstuctionScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    InstructionButton(GetControlInstructionalButton(1, 194, true))
    InstructionButtonMessage("Close Camera")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

function InstructionButton(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function InstructionButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function disableViewCam()
    if viewCam then
        RenderScriptCams(false, true, 500, true, true)
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        viewCam = false
    end
end

RegisterNUICallback('buy', function()
    openContract(false)
    disableViewCam()
    TriggerServerEvent('rl-houses:server:buyHouse', closesthouse)
end)

RegisterNUICallback('exit', function()
    openContract(false)
    disableViewCam()
end)

RegisterNetEvent('rl-houses:client:viewHouse')
AddEventHandler('rl-houses:client:viewHouse', function(houseprice, brokerfee, bankfee, taxes, firstname, lastname)
    setViewCam(Config.Houses[closesthouse].coords.cam, Config.Houses[closesthouse].coords.cam.h, Config.Houses[closesthouse].coords.yaw)
    Citizen.Wait(500)
    openContract(true)
    SendNUIMessage({
        type = "setupContract",
        firstname = firstname,
        lastname = lastname,
        street = Config.Houses[closesthouse].adress,
        houseprice = houseprice,
        brokerfee = brokerfee,
        bankfee = bankfee,
        taxes = taxes,
        totalprice = (houseprice + brokerfee + bankfee + taxes)
    })
end) 

function SetClosestHouse()
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    local current = nil
    local dist = nil
    if not inside then
        for id, house in pairs(Config.Houses) do
            if current ~= nil then
                if(GetDistanceBetweenCoords(pos, Config.Houses[id].coords.enter.x, Config.Houses[id].coords.enter.y, Config.Houses[id].coords.enter.z, true) < dist)then
                    current = id
                    dist = GetDistanceBetweenCoords(pos, Config.Houses[id].coords.enter.x, Config.Houses[id].coords.enter.y, Config.Houses[id].coords.enter.z, true)
                end
            else
                dist = GetDistanceBetweenCoords(pos, Config.Houses[id].coords.enter.x, Config.Houses[id].coords.enter.y, Config.Houses[id].coords.enter.z, true)
                current = id
            end
        end
        closesthouse = current
    
        if closesthouse ~= nil then 
            RLCore.Functions.TriggerCallback('rl-houses:server:hasKey', function(result)
                hasKey = result
            end, closesthouse)
        
            RLCore.Functions.TriggerCallback('rl-houses:server:isOwned', function(result)
                isOwned = result
            end, closesthouse)
        end
    end
    TriggerEvent('rl-garages:client:setHouseGarage', closesthouse, hasKey)
end

function setHouseLocations()
    if closesthouse ~= nil then
        RLCore.Functions.TriggerCallback('rl-houses:server:getHouseLocations', function(result)
            if result ~= nil then
                if result.stash ~= nil then
                    stashLocation = json.decode(result.stash)
                end

                if result.outfit ~= nil then
                    outfitLocation = json.decode(result.outfit)
                end

                if result.logout ~= nil then
                    logoutLocation = json.decode(result.logout)
                end
            end
        end, closesthouse)
    end
end

RegisterNetEvent('rl-houses:client:setLocation')
AddEventHandler('rl-houses:client:setLocation', function(data)
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    local coords = {x = pos.x, y = pos.y, z = pos.z}

    if inside then
        if hasKey then
            if data == 'setstash' then
                TriggerServerEvent('rl-houses:server:setLocation', coords, closesthouse, 1)
            elseif data == 'setoutift' then
                TriggerServerEvent('rl-houses:server:setLocation', coords, closesthouse, 2)
            elseif data == 'setlogout' then
                TriggerServerEvent('rl-houses:server:setLocation', coords, closesthouse, 3)
            end
        else
            RLCore.Functions.Notify('You do not own the house..', 'error')
        end
    else    
        RLCore.Functions.Notify('You are not in a house..', 'error')
    end
end)

RegisterNetEvent('rl-houses:client:refreshLocations')
AddEventHandler('rl-houses:client:refreshLocations', function(house, location, type)
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)

    if closesthouse == house then
        if inside then
            if type == 1 then
                stashLocation = json.decode(location)
            elseif type == 2 then
                outfitLocation = json.decode(location)
            elseif type == 3 then
                logoutLocation = json.decode(location)
            end
        end
    end
end)

local RamsDone = 0

function DoRamAnimation(bool)
    local ped = GetPlayerPed(-1)
    local dict = "missheistfbi3b_ig7"
    local anim = "lift_fibagent_loop"

    if bool then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(1)
        end
        TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 1, -1, false, false, false)
    else
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(1)
        end
        TaskPlayAnim(ped, dict, "exit", 8.0, 8.0, -1, 1, -1, false, false, false)
    end
end

RegisterNetEvent('rl-houses:client:HomeInvasion')
AddEventHandler('rl-houses:client:HomeInvasion', function()
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    local Skillbar = exports['rl-skillbar']:GetSkillbarObject()

    if closesthouse ~= nil then
                local dist = GetDistanceBetweenCoords(pos, Config.Houses[closesthouse].coords.enter.x, Config.Houses[closesthouse].coords.enter.y, Config.Houses[closesthouse].coords.enter.z, true)
                if Config.Houses[closesthouse].IsRaming == nil then
                    Config.Houses[closesthouse].IsRaming = false
                end
        
                if dist < 1 then
                    if Config.Houses[closesthouse].locked then
                        if not Config.Houses[closesthouse].IsRaming then
                            DoRamAnimation(true)
                            Skillbar.Start({
                                duration = math.random(5000, 10000),
                                pos = math.random(10, 30),
                                width = math.random(10, 20),
                            }, function()
                                if RamsDone + 1 >= Config.RamsNeeded then
                                    TriggerServerEvent('rl-houses:server:lockHouse', false, closesthouse)
                                    RLCore.Functions.Notify('It worked, the door is now out.', 'success')
                                    TriggerServerEvent('rl-houses:server:SetHouseRammed', true, closesthouse)
                                    DoRamAnimation(false)
                                else
                                    DoRamAnimation(true)
                                    Skillbar.Repeat({
                                        duration = math.random(500, 1000),
                                        pos = math.random(10, 30),
                                        width = math.random(5, 12),
                                    })
                                    RamsDone = RamsDone + 1
                                end
                            end, function()
                                RamsDone = 0
                                TriggerServerEvent('rl-houses:server:SetRamState', false, closesthouse)
                                RLCore.Functions.Notify('It failed .. Please try again.', 'error')
                                DoRamAnimation(false)
                            end)
                            TriggerServerEvent('rl-houses:server:SetRamState', true, closesthouse)
                        else
                            RLCore.Functions.Notify('Someone is already working on the door..', 'error')
                        end
                    else
                        RLCore.Functions.Notify('This house is already open ..', 'error')
                    end
                else
                    RLCore.Functions.Notify('You\'re not near a house.', 'error')
                end
            else
                RLCore.Functions.Notify('There is no force management present.', 'error')
            end
        end)

RegisterNetEvent('rl-houses:client:SetRamState')
AddEventHandler('rl-houses:client:SetRamState', function(bool, house)
    Config.Houses[house].IsRaming = bool
end)

RegisterNetEvent('rl-houses:client:SetHouseRammed')
AddEventHandler('rl-houses:client:SetHouseRammed', function(bool, house)
    Config.Houses[house].IsRammed = bool
end)

RegisterNetEvent('rl-houses:client:ResetHouse')
AddEventHandler('rl-houses:client:ResetHouse', function()
    local ped = GetPlayerPed(-1)

    if closesthouse ~= nil then
        if Config.Houses[closesthouse].IsRammed == nil then
            Config.Houses[closesthouse].IsRammed = false
            TriggerServerEvent('rl-houses:server:SetHouseRammed', false, closesthouse)
            TriggerServerEvent('rl-houses:server:SetRamState', false, closesthouse)
        end
        if Config.Houses[closesthouse].IsRammed then
            openHouseAnim()
            TriggerServerEvent('rl-houses:server:SetHouseRammed', false, closesthouse)
            TriggerServerEvent('rl-houses:server:SetRamState', false, closesthouse)
            TriggerServerEvent('rl-houses:server:lockHouse', true, closesthouse)
            RamsDone = 0
            RLCore.Functions.Notify('You locked up the house again..', 'success')
        else
            RLCore.Functions.Notify('This door has not been broken open..', 'error')
        end
    end
end)


imClosesToRoom2 = function()
    local ply = PlayerPedId()
    if showClothing then
      return true
    else
      return false
    end
end