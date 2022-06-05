RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

function isCloseVeh()
    local ped = PlayerPedId()
    coordA = GetEntityCoords(ped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 100.0, 0.0)
    vehicle = getVehicleInDirection(coordA, coordB)
    if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
        return true
    end
    return false
end

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle
    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)    
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        offset = offset - 1
        if vehicle ~= 0 then break end
    end
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end

local isJudge = false
local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local garageClose = false
local bennysClose = false
local gangNum = 0
local cuffStates = {}

local deadcooldown = false

--

rootMenuConfig =  {
    {
        id = "policeDeadA",
        displayName = "10-13A",
        icon = "#police-dead",
        functionName = "dispatch:officerDown",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return (Data.metadata["isdead"] or Data.metadata["inlaststand"]) and (Data.job.name == 'police' and Data.job.onduty)
        end
    },
    { 
        id = "policeDeadA",
        displayName = "Park", 
        icon = "#parking",
        functionName = "rl-garages:client:garageClose",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and IsPedInAnyVehicle(PlayerPedId(), false) and garageClose)
        end
    },
   --[[  {
        id = "bennysClose",
        displayName = "Bennys",
        icon = "#bennys",
        functionName = "event:control:bennys",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and IsPedInAnyVehicle(PlayerPedId(), false) and (Data.job.name == 'mechanic' and Data.job.onduty) or (Data.job.name == 'tuner' and Data.job.onduty) and bennysClose)
        end
    }, ]]
    {
        id = "open-garage",
        displayName = "Vehicle List",
        icon = "#warehouse",
        functionName = "Garages:Open",
        enableMenu = function()
            local pData = RLCore.Functions.GetPlayerData()
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and inGarage and not isCloseVeh() and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
    {
        id = "park-vehicle-garage",
        displayName = "Park",
        icon = "#parking",
        functionName = "Garages:Store",
        enableMenu = function()
            local pData = RLCore.Functions.GetPlayerData()
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and inGarage and isCloseVeh() and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    }, 
    {
        id = "housemenu",
        displayName = "Realestate",
        icon = "#animation-business",
        functionName = "qb-realestate:client:OpenHouseListMenu",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"]) and (Data.job.name == 'realestate' and Data.job.onduty)
        end
    },
    {
        id = "general:depots",
        displayName = "Depot",
        icon = "#warehouse",
        functionName = "Garages:OpenDepot",
        enableMenu = function()
            local pData = RLCore.Functions.GetPlayerData()
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and inDepots and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
    {
        id = "open-garage-housing",
        displayName = "Vehicle List",
        icon = "#warehouse",
        functionName = "Garages:OpenHouseGarage",
        enableMenu = function()
            local pData = RLCore.Functions.GetPlayerData()
            local isAtHouseGarage = false
            RLCore.Functions.TriggerCallback('qb-garages:isAtHouseGar', function(result)
                isAtHouseGarage = result
            end)
            Wait(100)
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and isAtHouseGarage and not isCloseVeh() and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
    {
        id = "park-vehicle-garage-housing",
        displayName = "Park",
        icon = "#parking",
        functionName = "Garages:StoreInHouseGarage",
        enableMenu = function()
            local pData = RLCore.Functions.GetPlayerData()
            local isAtHouseGarage = false
            RLCore.Functions.TriggerCallback('qb-garages:isAtHouseGar', function(result)
                isAtHouseGarage = result
            end)
            Wait(100)
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and isAtHouseGarage and isCloseVeh() and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    }, 

    {
        id = "clothingNear",
        displayName = "Outfits",
        icon = "#house-setoutift",
        functionName = "rl-outfits-ido:client:openOutfits",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            local clothing = exports["rl-clothing"]:IsNearShopMenu()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and clothing <= 5.0)
        end
    },

    {
        id = "emsDeadA",
        displayName = "10-14A",
        icon = "#ems-dead",
        functionName = "dispatch:emsDown",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return (Data.metadata["isdead"] or Data.metadata["inlaststand"]) and (Data.job.name == 'ambulance' and Data.job.onduty)
        end
    },
    {
        id = "policeDeadA",
        displayName = "10-13B",
        icon = "#police-dead",
        functionName = "dispatch:officerDownB",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return (Data.metadata["isdead"] or Data.metadata["inlaststand"]) and (Data.job.name == 'police' and Data.job.onduty)
        end
    },
    {
        id = "emsDeadA",
        displayName = "10-14B",
        icon = "#ems-dead",
        functionName = "dispatch:emsDownB",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return (Data.metadata["isdead"] or Data.metadata["inlaststand"]) and (Data.job.name == 'ambulance' and Data.job.onduty)
        end
    },
    
    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
        subMenus = {"vehicle:giveKeys", "general:Blips", "general:givenum", "general:getintrunk", "general:cornerselling"}
    },

    {
        id = "animations",
        displayName = "Walking Style",
        icon = "#walking",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
        subMenus = { "animations:brave", "animations:hurry", "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien","animations:business2","animations:business3","animations:muscle", }
    },
    {
        id = "expressions",
        displayName = "Expressions",
        icon = "#expressions",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
        subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },

    {
        id = "house",
        displayName = "House Interaction",
        icon = "#house",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
        subMenus = {"house:give","house:remove", "house:doorlock", "house:reset", "house:decorate", "house:setstash", "house:setoutift", "house:setlogout"}
    },

    {
        id = "tow",
        displayName = "Tow Actions",
        icon = "#mechanic",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and (Data.job.name == "tow"))
        end,
        subMenus = {"mechanic:impound","tow:towvehicle", "tow:checkstatus"} --,"tow:checkstatus", "tow:togglenpc"]]--
    },

    {
        id = "cuff",
        displayName = "Cuff Actions",
        icon = "#cuffs",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
        subMenus = { "cuffing:cuff", "cuffing:steal", 'ems:putinvehicle','ems:unseatvehicle', 'police:drag' }--[[, 'kidnap:person', 'kidnap:trunk']]-- 
    },   

    {
        id = "vehicle",
        displayName = "Vehicle",
        icon = "#vehicle-options",
        functionName = "veh:options",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },

    {
        id = "mechanic",
        displayName = "Mechanic Actions",
        icon = "#mechanic",
        enableMenu =function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "mechanic" )
        end,
        subMenus = { "mechanic:impound", "mechanic:flatbed", "tow:checkstatus", "mechanic:repoCheck" }
    },

    {
        id = "cardealer",
        displayName = "Cardealer Actions",
        icon = "#mechanic",
        enableMenu =function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "cardealer")
        end,
        subMenus = { "cardealer:finance", "cardealer:enablebuy", "cardealer:testDrive"}
    },

    {
        id = "judge",
        displayName = "Judge Actions",
        icon = "judge-actions",
        enableMenu =function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "mayor" and Data.job.grade >= 2)
        end,
        subMenus = { 'judge:mdt' }
    },

    {
        id = "taxi",
        displayName = "Taxi Actions",
        icon = "#taxi",
        enableMenu =function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "taxi")
        end,
        subMenus = { "taxi:togglemeter", "taxi:npcmission" }
    },

    {
        id = "police",
        displayName = "Police",
        icon = "#police",
        enableMenu =function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "police" and Data.job.onduty))
        end,
        subMenus = {"police:drag", "police:softcuff", "police:cuff", "ems:putinvehicle","ems:unseatvehicle","police:unmask", "ems:revive", "police:gsrtest", 'police:AddWep', 'police:seizeCash'}
    },

    {
        id = "police-check",
        displayName = "Police Checks",
        icon = "#police-checks",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "police" and Data.job.onduty))
        end,
        subMenus = {"police:checkbank", "police:checklicenses","police:checkfines", "police:search" }
    },

    {
        id = "oxygentank",
        displayName = "Remove Oxygen Tank",
        icon = "#oxygen-mask",
        functionName = "RemoveOxyTank",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and hasOxygenTankOn
        end,

    },

    {
        id = "objects",
        displayName = "Objects",
        icon = "#police-check",
        enableMenu =function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "police" and Data.job.onduty))
        end,
        subMenus = {"objects:barier", "objects:cone", "objects:tent", "objects:spike", "objects:spike2", "objects:light", "objects:remove"}
    },

    {
        id = "mdt",
        displayName = "MDT",
        icon = "#police-mdt",
        functionName = "mdt:Openc", 
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "police" and Data.job.onduty))
        end
    },
    
    {
        id = "objects",
        displayName = "Objects",
        icon = "#objects",
        enableMenu =function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "ambulance" and Data.job.onduty))
        end,
        subMenus = {"ems:bed","ems:wheelchair", "objects:remove", "objects:barier", "objects:cone", "objects:tent"}
    },

    {
        id = "deadblip",
        displayName = "10-11",
        icon = "#police-dead",
        enableMenu =function()
            local Data = RLCore.Functions.GetPlayerData()
            return (isDead and Data.job ~= nil and (Data.job.name == "police" or Data.job.name == "ambulance"))
        end,
        subMenus = { "esx_outlawalert:deadofficerinprogress"}
    },

    {
        id = "vanilla",
        displayName = "Vanilla",
        icon = "#vanilla",
        enableMenu =function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "vanilla")
        end,
        subMenus = { "vanilla:place" }
    },

    {
        id = "news",
        displayName = "News",
        icon = "#news",
        enableMenu =function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and (Data.job.name == "reporter" or Data.job.name == "weaponary"))
        end,
        subMenus = { "news:boom", "news:mic", "news:cam" }
    },

    {
        id = "ems",
        displayName = "EMS",
        icon = "#medic",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "ambulance" and Data.job.onduty))
        end,
        subMenus = { 'police:drag', "ems:revive", 'ems:heal',  'ems:putinvehicle','ems:unseatvehicle'}
    }
}



newSubMenus = {

    ['cardealer:finance'] = {
        title = "Enable Finance",
        icon = "#police-gsr-test",
        functionName = "rl-radial:finance"
    },

    ['cardealer:enablebuy'] = {
        title = "Enable Purchase",
        icon = "#police-gsr-test",
        functionName = "rl-radial:enablebuy" 
    },

    ['cardealer:testDrive'] = {
        title = "Start Testdrive",
        icon = "#police-gsr-test",
        functionName = "rl-radial:testdrive" 
    },

    ['judge:mdt'] = {
        title = "MDT",
        icon = "#police-mdt",
        functionName = "rl-menu:police:mdt"
    },

    ['general:flipveh'] = {
        title = "Flip Vehicle",
        icon = "#general-flip-vehicle",
        functionName = "vehicle:flipit"
    },

    ['general:bills'] = {
        title = "Bills",
        icon = "#police-bills",
        functionName = "rl-menu:general:bills"
    },

    ['general:hotdog'] = {
        title = "Toggle Sale",
        icon = "#hotdog",
        functionName = "rl-hotdogjob:client:ToggleSell"
    },

    ['general:givenum'] = {
        title = "Provide Contact Details",
        icon = "#givenum",
        functionName = "phone:client:GiveContactDetails"
    },

    ['general:Blips'] = {
        title = "Toggle Garages",
        icon = "#warehouse",
        functionName = "garages:Blips"
    },

    ['general:getintrunk'] = { 
        title = "Enter Trunk",
        icon = "#getintrunk",
        functionName = "rl-trunk:client:GetIn"
    },
	
    ['general:cornerselling'] = {
        title = "Corner Selling",
        icon = "#cornerselling",
        functionName = "rl-drugs:client:cornerselling"
    },

    ['general:train'] = {
        title = "Request Train",
        icon = "#general-ask-for-train",
        functionName = "AskForTrainConfirmed"
    },

    ['deadblip:sendBlip'] = {
        title = "10-11 Distress Call",
        icon = "#police-dead",
        functionName = "rl-menu:senddeadblip" 
    },
    --------------------------------------
    
    ['objects:barier'] = {
        title = "Barier",
        icon = "#barier",
        functionName = "police:client:spawnBarier"
    },

    ['objects:cone'] = {
        title = "Cone",
        icon = "#cone",
        functionName = "police:client:spawnCone"
    },

    ['objects:tent'] = {
        title = "Tent",
        icon = "#tent",
        functionName = "police:client:spawnTent"
    },

    ['objects:spike'] = {
        title = "Spike",
        icon = "#spike",
        functionName = "police:client:SpawnSpikeStrip"
    },

    ['objects:spike2'] = {
        title = "Spike Remove",
        icon = "#spike",
        functionName = "police:client:RemoveSpikeStrip"
    },

    ['objects:light'] = {
        title = "Light",
        icon = "#cone",
        functionName = "police:client:spawnLight"
    },

    ['objects:remove'] = {
        title = "Remove",
        icon = "#removeobject",
        functionName = "police:client:deleteObject"
    },

    ['ems:bed'] = {
        title = "Bed",
        icon = "#bed",
        functionName = "rl-mada:client:bed"
    },

    ['ems:wheelchair'] = {
        title = "Wheelchair",
        icon = "#wheelchair",
        functionName = "rl-mada:client:wheelchair"
    },
    --------------------------------------

    ['house:give'] = {
        title = "Give House Key",
        icon = "#house-givekey",
        functionName = "qb-houses:client:giveHouseKey" 
    },

    ['house:remove'] = {
        title = "Remove House Key",
        icon = "#house-removekey",
        functionName = "qb-houses:client:removeHouseKey"
    },

    ['house:doorlock'] = {
        title = "Toggle Door lock",
        icon = "#house-doorlock",
        functionName = "qb-houses:client:toggleDoorlock"
    },

    ['house:reset'] = {
        title = "Reset Home lock",
        icon = "#house-resetlock",
        functionName = "qb-houses:client:ResetHouse"
    },

    ['house:decorate'] = {
        title = "Decorate house",
        icon = "#house-decorate",
        functionName = "qb-houses:client:decorate",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
    },

    ['house:setstash'] = {
        title = "Set Stash",
        icon = "#house-setstash",
        functionName = "qb-houses:client:setStash",
    },

    ['house:setoutift'] = {
        title = "Outfit Set",
        icon = "#house-setoutift",
        functionName = "qb-houses:client:setOutfit",
    },

    ['house:setlogout'] = {
        title = "Logout",
        icon = "#house-logout",
        functionName = "qb-houses:client:setLogout",
    },

    --------------------------------------

    ['animations:joy'] = {
        title = "Joy",
        icon = "#animation-joy",
        functionName = "AnimSet:Joy"
    },
    ['animations:sexy'] = {
        title = "Sexy",
        icon = "#animation-sexy",
        functionName = "AnimSet:Sexy"
    },
    ['animations:moon'] = {
        title = "Moon",
        icon = "#animation-moon",
        functionName = "AnimSet:Moon"
    },
    ['animations:tired'] = {
        title = "Tired",
        icon = "#animation-tired",
        functionName = "AnimSet:Tired"
    },
    ['animations:arrogant'] = {
        title = "Arrogant",
        icon = "#animation-arrogant",
        functionName = "AnimSet:Arrogant"
    },
    
    ['animations:casual'] = {
        title = "Casual",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual"
    },
    ['animations:casual2'] = {
        title = "Casual 2",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual2"
    },
    ['animations:casual3'] = {
        title = "Casual 3",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual3"
    },
    ['animations:casual4'] = {
        title = "Casual 4",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual4"
    },
    ['animations:casual5'] = {
        title = "Casual 5",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual5"
    },
    ['animations:casual6'] = {
        title = "Casual 6",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual6"
    },
    ['animations:confident'] = {
        title = "Confident",
        icon = "#animation-confident",
        functionName = "AnimSet:Confident"
    },
    
    ['animations:business2'] = {
        title = "Business 2",
        icon = "#animation-business",
        functionName = "AnimSet:Business2"
    },
    ['animations:business3'] = {
        title = "Business 3",
        icon = "#animation-business",
        functionName = "AnimSet:Business3"
    },
    
    ['animations:femme'] = {
        title = "Femme",
        icon = "#animation-female",
        functionName = "AnimSet:Femme"
    },
    ['animations:flee'] = {
        title = "Flee",
        icon = "#animation-flee",
        functionName = "AnimSet:Flee"
    },
    ['animations:gangster'] = {
        title = "Gangster",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster"
    },
    ['animations:gangster2'] = {
        title = "Gangster 2",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster2"
    },
    ['animations:gangster3'] = {
        title = "Gangster 3",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster3"
    },
    ['animations:gangster4'] = {
        title = "Gangster 4",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster4"
    },
    ['animations:gangster5'] = {
        title = "Gangster 5",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster5"
    },
    
    ['animations:heels'] = {
        title = "Heels",
        icon = "#animation-female",
        functionName = "AnimSet:Heels"
    },
    ['animations:heels2'] = {
        title = "Heels 2",
        icon = "#animation-female",
        functionName = "AnimSet:Heels2"
    },
    
    ['animations:hipster'] = {
        title = "Hipster",
        icon = "#animation-hipster",
        functionName = "AnimSet:Hipster"
    },
    ['animations:hiking'] = {
        title = "Hiking",
        icon = "#animation-hiking",
        functionName = "AnimSet:Hiking"
    },
    
    ['animations:jog'] = {
        title = "Jog",
        icon = "#animation-jog",
        functionName = "AnimSet:Jog"
    },
    
    ['animations:muscle'] = {
        title = "Muscle",
        icon = "#animation-tough",
        functionName = "AnimSet:Muscle"
    },
    
    ['animations:quick'] = {
        title = "Quick",
        icon = "#animation-quick",
        functionName = "AnimSet:Quick"
    },
    ['animations:wide'] = {
        title = "Wide",
        icon = "#animation-wide",
        functionName = "AnimSet:Wide"
    },
    ['animations:scared'] = {
        title = "Scared",
        icon = "#animation-scared",
        functionName = "AnimSet:Scared"
    },
    ['animations:guard'] = {
        title = "Guard",
        icon = "#animation-guard",
        functionName = "AnimSet:Guard"
    },
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },
    ['animations:hurry'] = {
        title = "Hurry",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },
    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },
    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },
    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },
    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },
    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },
    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },
    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },
    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },
    ['animations:nonchalant'] =
    {
        title = "Nonchalant",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },
    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },
    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },
    ['animations:shady'] = {
        title = "Shady",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },
    ['animations:maneater'] = {
        title = "Man Eater",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },
    ['animations:chichi'] = {
        title = "ChiChi",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },
    ['animations:default'] = {
        title = "Default",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },

    --------------------------------------

    ['cuffing:steal'] = {
        title = "Rob Person",
        icon = "#cuffs-steal",
        functionName = "police:client:RobPlayer",
    },
	
    ['kidnap:person'] = {
        title = "Kidnap Person",
        icon = "#cuffs-steal",
        functionName = "police:client:KidnapPlayer",
    },
	
	
    ['kidnap:trunk'] = {
        title = "Kidnap into Trunk",
        icon = "#cuffs-steal",
        functionName = "rl-trunk:client:KidnapTrunk",
    },

    ['cuffing:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        enableMenu = function()
            local Data = RLCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name ~= "ambulance" and Data.job.name ~= "police" and not IsPedInAnyVehicle(ped, true))
        end,
        functionName = "police:client:CuffPlayerSoft",
    },

    ['vanilla:place'] = {
        title = "Place Stripper",
        icon = "#stripper",
        functionName = "strippers:place",
    },
    
    --------------------------------------
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },

    ['animations:hurry'] = {
        title = "Hurry",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },

    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },

    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },

    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },

    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },

    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },

    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },

    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },

    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },

    ['animations:nonchalant'] = {
        title = "Calm",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },

    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },

    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },

    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },

    ['animations:shady'] = {
        title = "Shady",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },

    ['animations:maneater'] = {
        title = "Maneater",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },

    ['animations:chichi'] = {
        title = "Chichi",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },

    ['animations:default'] = {
        title = "Default",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },

    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },

    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },

    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },

    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },

    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },

    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },

    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },

    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },

    ["expressions:mouthbreather"] = {
        title="Mouthbreather",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },

    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },

    ["expressions:oneeye"]  = {
        title="Oneeye",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },

    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },

    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },

    ["expressions:smug"]  = {
        title="Smug",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },

    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },

    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },

    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },

    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },

    ["expressions:weird2"]  = {
        title="Weird 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
     },    
    --------------------------------------
    ['vehicle:giveKeys'] = {
        title = "Give Key",
        icon = "#vehicle-givekeys",
        functionName = "vehiclekeys:client:GiveKeys"
    },
    --------------------------------------
    ['police:unmask'] = {
        title = "Remove Mask Hat",
        icon = "#unmask",
        functionName = "police:unmask"
    },

    ['police:checkbank'] = {
        title = "Check Bank",
        icon = "#police-check-bank",
        functionName = "police:client:checkBank"
    },

    ['police:checklicenses'] = {
        title = "Check Licenses",
        icon = "#police-check-licenses",
        functionName = "police:client:checkLicenses"
    },

    ['police:checkfines'] = {
        title = "Check Fines",
        icon = "#police-check-fines",
        functionName = "police:client:checkFines"
    },

    ['police:search'] = {
        title = "Search Player",
        icon = "#police-search",
        functionName = "police:client:SearchPlayer"
    },

    ['police:drag'] = {
        title = "Escort",
        icon = "#general-escort",
        functionName = "police:client:EscortPlayer",
    },
    
    ['police:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:client:Hardcuff"
    },
 
    ['police:softcuff'] = {
        title = "Soft Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:client:Softcuff"
    },

    ["police:gsrtest"] = {
        title = "GSR Test",
        icon = "#police-gsr-test",
        functionName = "GSR_Client:PerformTest"
    },

    ['police:AddWep'] = {
        title = 'Weapon Licence',
        icon = "#police-gsr-test",
        functionName = 'police:client:AddWep'
    },

    ['police:seizeCash'] = {
        title = 'Seize Cash',
        icon = "#police-cashrem",
        functionName = 'police:client:SeizeCash'
    },
	
	--------------------------------------
    ['ems:revive'] = {
        title = "Revive",
        icon = "#ems-revive",
        functionName = "hospital:client:RevivePlayer",
    },

    ['ems:heal'] = {
        title = "Heal",
        icon = "#ems-heal",
        functionName = "hospital:client:TreatWounds",
    },

    ['ems:undrag'] = {
        title = "Drag",
        icon = "#general-escort",
        functionName = "police:client:EscortPlayer"
    },

    ['ems:putinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:client:PutPlayerInVehicle"
    },

    ['ems:unseatvehicle'] = {
        title = "Unseat Nearest",
        icon = "#general-unseat-nearest",
        functionName = "police:client:SetPlayerOutVehicle"
    },
    --------------------------------------
	['news:boom'] = {
        title = "Boom Microphone",
        icon = "#news-boom",
        functionName = "Mic:ToggleBMic"
    },

    ['news:cam'] = {
        title = "Camera",
        icon = "#news-cam",
        functionName = "Cam:ToggleCam"
    },

    ['news:mic'] = {
        title = "Microphone",
        icon = "#news-mic",
        functionName = "Mic:ToggleMic"
    },
    --------------------------------------
    ["taxi:togglemeter"] = {
        title = "Show/Hide Meter",
        icon = "#taxi-togglemeter",
        functionName = "rl-taxi:client:toggleMeter",
    },

    ["taxi:npcmission"] = {
        title = "Start/Stop Meter",
        icon = "#taxi-power",
        functionName = "rl-taxi:client:enableMeter",
    },
    --------------------------------------
    ["tow:togglenpc"] = {
        title = "Toggle NPC",
        icon = "#tow-npcmission",
        functionName = "jobs:client:ToggleNpc",
    },
    
    ["tow:towvehicle"] = {
        title = "Hoist Vehicle",
        icon = "#mechanic-flatbed",
        functionName = "rl-tow:client:TowVehicle",
    },

    ["tow:checkstatus"] = {
        title = "Check Status",
        icon = "#tow-status",
        functionName = "vehiclemod:client:getVehicleStatus",
    },

    --------------------------------------
    ["mechanic:impound"] = {
        title = "Impound",
        icon = "#police-jail",
        functionName = "rl-tow:client:ImpoundVehicle"
    },

    ["mechanic:flatbed"] = {
        title = "Tow",
        icon = "#mechanic-flatbed",
        functionName = "rl-tow:client:TowVehicle"
    },

    ["mechanic:repoCheck"] = {
        title = "Check For Repo",
        icon = "#police-jail",
        functionName = "mechanic:client:repoCheck"
    }

}


RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)

RegisterNetEvent("menu:garageClose")
AddEventHandler("menu:garageClose", function()
    garageClose = true
end)
 
RegisterNetEvent("menu:garageCloseF")
AddEventHandler("menu:garageCloseF", function()
    garageClose = false
end)

RegisterNetEvent("menu:bennysClose")
AddEventHandler("menu:bennysClose", function()
    bennysClose = true
end)
 
RegisterNetEvent("menu:bennysCloseF")
AddEventHandler("menu:bennysCloseF", function()
    bennysClose = false
end)


RegisterNetEvent("mdt:Openc")
AddEventHandler("mdt:Openc", function()
    Citizen.Wait(750)
    TriggerServerEvent("mdt:Open")
end)



function GetPlayers()
    local players = {}

    for i = 0, 128 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end

TrunkClasses = {
    [0]  = { allowed = true, x = 0.0, y = -1.5, z = 0.0 }, --Coupes  
    [1]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sedans  
    [2]  = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --SUVs  
    [3]  = { allowed = true, x = 0.0, y = -1.5, z = 0.0 }, --Coupes  
    [4]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Muscle  
    [5]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sports Classics  
    [6]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sports  
    [7]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Super  
    [8]  = { allowed = false, x = 0.0, y = -1.0, z = 0.25 }, --Motorcycles  
    [9]  = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Off-road  
    [10] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Industrial  
    [11] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Utility  
    [12] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Vans  
    [13] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Cycles  
    [14] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Boats  
    [15] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Helicopters  
    [16] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Planes  
    [17] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Service  
    [18] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Emergency  
    [19] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Military  
    [20] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Commercial  
    [21] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Trains  
}

Citizen.CreateThread(function()
    for k, v in pairs(Garages) do 
        exports["polyzonehelper"]:AddBoxZone("garages", vector3(Garages[k].polyzone.x, Garages[k].polyzone.y, Garages[k].polyzone.z), Garages[k].polyzone1, Garages[k].polyzone2, {
            name="garages",
            heading=Garages[k].heading,
            minZ = Garages[k].minZ,
            maxZ = Garages[k].maxZ,
            debugPoly=false
        }) 
    end
    for k, v in pairs(GangGarages) do
        exports["polyzonehelper"]:AddBoxZone("ganggarages", vector3(GangGarages[k].polyzone.x, GangGarages[k].polyzone.y, GangGarages[k].polyzone.z), GangGarages[k].polyzone1, GangGarages[k].polyzone2, {
            name="ganggarages",
            heading=GangGarages[k].heading,
            minZ = GangGarages[k].minZ,
            maxZ = GangGarages[k].maxZ,
            debugPoly=false
        }) 
    end
    for k, v in pairs(JobGarages) do
        exports["polyzonehelper"]:AddBoxZone("jobgarages", vector3(JobGarages[k].polyzone.x, JobGarages[k].polyzone.y, JobGarages[k].polyzone.z), JobGarages[k].polyzone1, JobGarages[k].polyzone2, {
            name="jobgarages",
            heading=JobGarages[k].heading,
            minZ = JobGarages[k].minZ,
            maxZ = JobGarages[k].maxZ,
            debugPoly=false
        }) 
    end
    for k, v in pairs(Depots) do
        exports["polyzonehelper"]:AddBoxZone("depots", vector3(Depots[k].polyzone.x, Depots[k].polyzone.y, Depots[k].polyzone.z), Depots[k].polyzone1, Depots[k].polyzone2, {
            name="depots",
            heading=Depots[k].heading,
            minZ = Depots[k].minZ,
            maxZ = Depots[k].maxZ,
            debugPoly=false
        }) 
    end
end)

RegisterNetEvent('polyzonehelper:enter')
AddEventHandler('polyzonehelper:enter', function(name)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if name == "garages" then
        inGarage = true
    elseif name == "ganggarages" then
        inGarage = true
    elseif name == "jobgarages" then
        inGarage = true
    elseif name == "depots" then
        inDepots = true
    end
end)

RegisterNetEvent('polyzonehelper:exit')
AddEventHandler('polyzonehelper:exit', function(name)
    if name == "garages" then
        inGarage = false
    elseif name == "ganggarages" then
        inGarage = false
    elseif name == "jobgarages" then
        inGarage = false
    elseif name == "depots" then
        inDepots = false
    end
end)