RLCore = nil

Citizen.CreateThread(function()
    while RLCore == nil do
        Citizen.Wait(10)
        TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
    end

    while RLCore.Functions.GetPlayerData().job == nil do Wait(10) end
end)

local CurrentCops = 0

RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

local zoneNames = {
    AIRP = "Los Santos International Airport",
    ALAMO = "Alamo Sea",
    ALTA = "Alta",
    ARMYB = "Fort Zancudo",
    BANHAMC = "Banham Canyon Dr",
    BANNING = "Banning",
    BAYTRE = "Baytree Canyon",
    BEACH = "Vespucci Beach",
    BHAMCA = "Banham Canyon",
    BRADP = "Braddock Pass",
    BRADT = "Braddock Tunnel",
    BURTON = "Burton",
    CALAFB = "Calafia Bridge",
    CANNY = "Raton Canyon",
    CCREAK = "Cassidy Creek",
    CHAMH = "Chamberlain Hills",
    CHIL = "Vinewood Hills",
    CHU = "Chumash",
    CMSW = "Chiliad Mountain State Wilderness",
    CYPRE = "Cypress Flats",
    DAVIS = "Davis",
    DELBE = "Del Perro Beach",
    DELPE = "Del Perro",
    DELSOL = "La Puerta",
    DESRT = "Grand Senora Desert",
    DOWNT = "Downtown",
    DTVINE = "Downtown Vinewood",
    EAST_V = "East Vinewood",
    EBURO = "El Burro Heights",
    ELGORL = "El Gordo Lighthouse",
    ELYSIAN = "Elysian Island",
    GALFISH = "Galilee",
    GALLI = "Galileo Park",
    golf = "GWC and Golfing Society",
    GRAPES = "Grapeseed",
    GREATC = "Great Chaparral",
    HARMO = "Harmony",
    HAWICK = "Hawick",
    HORS = "Vinewood Racetrack",
    HUMLAB = "Humane Labs and Research",
    JAIL = "Bolingbroke Penitentiary",
    KOREAT = "Little Seoul",
    LACT = "Land Act Reservoir",
    LAGO = "Lago Zancudo",
    LDAM = "Land Act Dam",
    LEGSQU = "Legion Square",
    LMESA = "La Mesa",
    LOSPUER = "La Puerta",
    MIRR = "Mirror Park",
    MORN = "Morningwood",
    MOVIE = "Richards Majestic",
    MTCHIL = "Mount Chiliad",
    MTGORDO = "Mount Gordo",
    MTJOSE = "Mount Josiah",
    MURRI = "Murrieta Heights",
    NCHU = "North Chumash",
    NOOSE = "N.O.O.S.E",
    OCEANA = "Pacific Ocean",
    PALCOV = "Paleto Cove",
    PALETO = "Paleto Bay",
    PALFOR = "Paleto Forest",
    PALHIGH = "Palomino Highlands",
    PALMPOW = "Palmer-Taylor Power Station",
    PBLUFF = "Pacific Bluffs",
    PBOX = "Pillbox Hill",
    PROCOB = "Procopio Beach",
    RANCHO = "Rancho",
    RGLEN = "Richman Glen",
    RICHM = "Richman",
    ROCKF = "Rockford Hills",
    RTRAK = "Redwood Lights Track",
    SanAnd = "San Andreas",
    SANCHIA = "San Chianski Mountain Range",
    SANDY = "Sandy Shores",
    SKID = "Mission Row",
    SLAB = "Stab City",
    STAD = "Maze Bank Arena",
    STRAW = "Strawberry",
    TATAMO = "Tataviam Mountains",
    TERMINA = "Terminal",
    TEXTI = "Textile City",
    TONGVAH = "Tongva Hills",
    TONGVAV = "Tongva Valley",
    VCANA = "Vespucci Canals",
    VESP = "Vespucci",
    VINE = "Vinewood",
    WINDF = "Ron Alternates Wind Farm",
    WVINE = "West Vinewood",
    ZANCUDO = "Zancudo River",
    ZP_ORT = "Port of South Los Santos",
    ZQ_UAR = "Davis Quartz"
}

function GetTheStreet()
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    local currentStreetHash, intersectStreetHash =
        GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
    currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
    zone = tostring(GetNameOfZone(x, y, z))
    playerStreetsLocation = zoneNames[tostring(zone)]

    if not zone then
        zone = "UNKNOWN"
        zoneNames['UNKNOWN'] = zone
    elseif not zoneNames[tostring(zone)] then
        local undefinedZone = zone .. " " .. x .. " " .. y .. " " .. z
        zoneNames[tostring(zone)] = "Undefined Zone"
    end

    if intersectStreetName ~= nil and intersectStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. " | " ..
                                    intersectStreetName .. " | " ..
                                    zoneNames[tostring(zone)]
    elseif currentStreetName ~= nil and currentStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. " | " ..
                                    zoneNames[tostring(zone)]
    else
        playerStreetsLocation = zoneNames[tostring(zone)]
    end
end

local attempted = 0

RegisterNetEvent("truckrobbery:gruppeCard")
AddEventHandler("truckrobbery:gruppeCard", function()
    local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0,
                                                    100.0, 0.0)
    local targetVehicle = getVehicleInDirection(coordA, coordB)
    if targetVehicle ~= 0 and GetHashKey("stockade") ==
        GetEntityModel(targetVehicle) then
        local entityCreatePoint = GetOffsetFromEntityInWorldCoords(
                                      targetVehicle, 0.0, -4.0, 0.0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local aDist = GetDistanceBetweenCoords(coords["x"], coords["y"],
                                               coords["z"],
                                               entityCreatePoint["x"],
                                               entityCreatePoint["y"],
                                               entityCreatePoint["z"])
        if aDist < 2.0 then
            local randomcode = math.random(1000, 9999)
            local street = GetTheStreet()
            if CurrentCops >= 3 then 
                TriggerEvent("truckrobbery:AttemptHeist", targetVehicle)
            else 
                RLCore.Functions.Notify('The police are being lazy, Try again later.')
            end
        else
            RLCore.Functions.Notify('You need to do this from behind the vehicle.')
        end
    end
end)

RegisterNetEvent('truckrobbery:AttemptHeist')
AddEventHandler('truckrobbery:AttemptHeist', function(veh)
    attempted = veh
    SetEntityAsMissionEntity(attempted, true, true)
    local plate = GetVehicleNumberPlateText(veh)
    local pedCo = GetEntityCoords(PlayerPedId())
    RLCore.Functions.TriggerCallback('tp:gruppe:checkPlate', function(canRob)
        if canRob then
            TriggerEvent('dispatch:truckRobbery')
            RLCore.Functions.Progressbar("unlockdoor_action", "Unlocking Vehicle",
            60000, false, true, {
                disableMovement = true,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true
            }, {
                animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flags = 49
            }, {}, {}, function(status)
                if not status then
                    TriggerEvent("truckrobbery:AllowHeist", veh)
                    TriggerServerEvent("truckrobbery:removeItem", "security_card_03", 1)
                    TriggerServerEvent("truckrobbery:PlateLog", plate)
                    TriggerServerEvent('tp:gruppe:addPlate', plate) 
                end
            end)
        else 
            RLCore.Functions.Notify('This truck is empty and the security system has been triggered.')
            TriggerEvent('dispatch:truckRobbery')
        end
    end, plate)
end)

RegisterNetEvent('truckrobbery:AllowHeist')
AddEventHandler('truckrobbery:AllowHeist', function(veh)
    TriggerEvent("truckrobbery:AddPeds", attempted)
    SetVehicleDoorOpen(attempted, 2, 0, 0)
    SetVehicleDoorOpen(attempted, 3, 0, 0)
    TriggerEvent("truckrobbery:PickupCash")
end)

RegisterNetEvent('truckrobbery:AddPeds')
AddEventHandler('truckrobbery:AddPeds', function(veh)
    local cType = 'ig_casey'

    local pedmodel = GetHashKey(cType)
    RequestModel(pedmodel)
    while not HasModelLoaded(pedmodel) do
        RequestModel(pedmodel)
        Citizen.Wait(100)
    end

    ped2 = CreatePedInsideVehicle(veh, 4, pedmodel, 0, 1, 0.0)
    ped3 = CreatePedInsideVehicle(veh, 4, pedmodel, 1, 1, 0.0)
    ped4 = CreatePedInsideVehicle(veh, 4, pedmodel, 2, 1, 0.0)

    GiveWeaponToPed(ped2, GetHashKey('WEAPON_SPECIALCARBINE'), 420, 0, 1)
    GiveWeaponToPed(ped3, GetHashKey('WEAPON_SPECIALCARBINE'), 420, 0, 1)
    GiveWeaponToPed(ped4, GetHashKey('WEAPON_SPECIALCARBINE'), 420, 0, 1)

    SetPedMaxHealth(ped2, 850)
    SetPedMaxHealth(ped3, 850)
    SetPedMaxHealth(ped4, 850)

    SetPedDropsWeaponsWhenDead(ped2, false)
    SetPedRelationshipGroupDefaultHash(ped2, GetHashKey('COP'))
    SetPedRelationshipGroupHash(ped2, GetHashKey('COP'))
    SetPedAsCop(ped2, true)
    SetCanAttackFriendly(ped2, false, true)

    SetPedDropsWeaponsWhenDead(ped3, false)
    SetPedRelationshipGroupDefaultHash(ped3, GetHashKey('COP'))
    SetPedRelationshipGroupHash(ped3, GetHashKey('COP'))
    SetPedAsCop(ped3, true)
    SetCanAttackFriendly(ped3, false, true)

    SetPedDropsWeaponsWhenDead(ped4, false)
    SetPedRelationshipGroupDefaultHash(ped4, GetHashKey('COP'))
    SetPedRelationshipGroupHash(ped4, GetHashKey('COP'))
    SetPedAsCop(ped4, true)
    SetCanAttackFriendly(ped4, false, true)

    TaskCombatPed(ped2, GetPlayerPed(-1), 0, 16)
    TaskCombatPed(ped3, GetPlayerPed(-1), 0, 16)
    TaskCombatPed(ped4, GetPlayerPed(-1), 0, 16)
end)

local pickup = false
RegisterNetEvent('truckrobbery:PickupCash')
AddEventHandler('truckrobbery:PickupCash', function()
    pickup = true
    TriggerEvent("truckrobbery:PickupCashLoop")
    Wait(180000)
    pickup = false
end)

RegisterNetEvent('truckrobbery:PickupCashLoop')
AddEventHandler('truckrobbery:PickupCashLoop', function()
    local markerlocation = GetOffsetFromEntityInWorldCoords(attempted, 0.0, -3.7, 0.1)
    SetVehicleHandbrake(attempted, true)
    while pickup do
        Citizen.Wait(1)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local aDist = GetDistanceBetweenCoords(coords["x"], coords["y"], coords["z"], markerlocation["x"], markerlocation["y"], markerlocation["z"])
        if aDist < 10.0 then

            if aDist < 2.0 and pickup then
                if IsDisabledControlJustReleased(0, 38) then
                    pickUpCash()
                    pickup = false
                end
                DrawText3Ds(markerlocation["x"], markerlocation["y"], markerlocation["z"], "[E] - Grab Items")
            else
                DrawText3Ds(markerlocation["x"], markerlocation["y"], markerlocation["z"], "Grab Items")
            end
        end
    end
end)

function DrawText3Ds(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

function Progressbar(duration, label)
	local retval = nil
	RLCore.Functions.Progressbar("drugs", label, duration, false, false, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = false,
	}, {}, {}, {}, function()
		retval = true
	end, function()
		retval = false
	end)

	while retval == nil do
		Wait(1)
	end

	return retval
end

local gotem = false

local pickingup = false

function pickUpCash()
    if not pickingup then
        local coords = GetEntityCoords(GetPlayerPed(-1))
        pickingup = true
        RequestAnimDict("mini@repair")

        while not HasAnimDictLoaded("mini@repair") do Citizen.Wait(0) end

        while pickingup do
            Citizen.Wait(1)
            local coords2 = GetEntityCoords(GetPlayerPed(-1))
            local aDist = GetDistanceBetweenCoords(coords["x"], coords["y"], coords["z"], coords2["x"],  coords2["y"], coords2["z"])
            if aDist > 1.0 or not pickup then pickingup = false end
            if IsEntityPlayingAnim(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 3) then
            else
                TaskPlayAnim(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 8.0, -8, -1, 49, 0, 0, 0, 0)
                FreezeEntityPosition(GetPlayerPed(-1), true)
            end
            Progressbar(60000,"Collecting Items")

            local fuckazazel = math.random(1,10)
            local chance = math.random(1, 100)
            if chance >= 65 then
                TriggerServerEvent('truckrobbery:addItem', "security_card_01", 1)
                if fuckazazel <= 4 then 
                    TriggerServerEvent('truckrobbery:addItem', "weedburn", 1)
                elseif fuckazazel <= 3 then 
                    TriggerServerEvent('truckrobbery:addItem', "cokeburn", 1)
                elseif fuckazazel <= 2 then
                    TriggerServerEvent('truckrobbery:addItem', "methburn", 1)
                end
            end

            for i = 1, #Config.Items, 1 do
                Wait(1000)
                TriggerServerEvent('truckrobbery:addItem', Config.Items[i].name, Config.Items[i].count)
            end
            TriggerServerEvent('truckrobbery:addMoney', Config.Money)
            pickingup = false
            FreezeEntityPosition(GetPlayerPed(-1), false)
        end
        ClearPedTasks(GetPlayerPed(-1))
    end
end

function FindEndPointCar(x, y)
    local randomPool = 50.0
    while true do

        if (randomPool > 2900) then return end
        local vehSpawnResult = {}
        vehSpawnResult["x"] = 0.0
        vehSpawnResult["y"] = 0.0
        vehSpawnResult["z"] = 30.0
        vehSpawnResult["x"] = x +
                                  math.random(randomPool - (randomPool * 2),
                                              randomPool) + 1.0
        vehSpawnResult["y"] = y +
                                  math.random(randomPool - (randomPool * 2),
                                              randomPool) + 1.0
        roadtest, vehSpawnResult, outHeading =
            GetClosestVehicleNode(vehSpawnResult["x"], vehSpawnResult["y"],
                                  vehSpawnResult["z"], 0, 55.0, 55.0)

        Citizen.Wait(1000)
        if vehSpawnResult["z"] ~= 0.0 then
            local caisseo = GetClosestVehicle(vehSpawnResult["x"],
                                              vehSpawnResult["y"],
                                              vehSpawnResult["z"], 20.000, 0, 70)
            if not DoesEntityExist(caisseo) then

                return vehSpawnResult["x"], vehSpawnResult["y"],
                       vehSpawnResult["z"], outHeading
            end

        end
        randomPool = randomPool + 50.0
    end
end

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z,
                                        coordTo.x, coordTo.y,
                                        coordTo.z + offset, 10, PlayerPedId(), 0)
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)

        offset = offset - 1

        if vehicle ~= 0 then break end
    end

    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))

    if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end
