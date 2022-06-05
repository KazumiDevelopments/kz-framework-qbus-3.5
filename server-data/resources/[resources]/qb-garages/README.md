# qb-garages v2.1 used with QBCore Framework
Nopixel 3.0 inspired garage system for qbcore
idle resmon at 0.00ms - 0.01 ms
(ghmattimysql / old qb-core version)

# Dependencies
* qb-core
* PolyZone
* polyzonehelper
* qb-houses
* radialmenu
* context-menu

## Installation
### Manual
- Download the script and all the dependencies you need and put them in `resource` folder.
- Run the *garages.sql* which is with the script.
- Put the codes below in `@radialmenu/config.lua` (default qb-radialmenu doesn't supports. get a radialmenu which supports polyzones or buy it! / If you use my radialmenu skip this part)
- Add the following code to your server.cfg/resouces.cfg
- Run the server (Make sure you have all the dependencies installed before run)
```
ensure PolyZone
ensure polyzonehelper
ensure context-menu
ensure radialmenu
ensure qb-garages
ensure qb-houses
```

## qb-radialmenu
* default one does not support!
* find this in *qb-radialmenu/config.lua*
* Put this anywhere inside {} in rootMenuConfig = {}
```lua
{
        id = "open-garage",
        displayName = "Vehicle List",
        icon = "#warehouse",
        functionName = "Garages:Open",
        enableMenu = function()
            local pData = QBCore.Functions.GetPlayerData()
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and inGarage and not isCloseVeh() and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
    {
        id = "park-vehicle-garage",
        displayName = "Park",
        icon = "#parking",
        functionName = "Garages:Store",
        enableMenu = function()
            local pData = QBCore.Functions.GetPlayerData()
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and inGarage and isCloseVeh() and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
    {
        id = "general:depots",
        displayName = "Depot",
        icon = "#warehouse",
        functionName = "Garages:OpenDepot",
        enableMenu = function()
            local pData = QBCore.Functions.GetPlayerData()
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and inDepots and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
    {
        id = "open-garage-housing",
        displayName = "Vehicle List",
        icon = "#warehouse",
        functionName = "Garages:OpenHouseGarage",
        enableMenu = function()
            local pData = QBCore.Functions.GetPlayerData()
            local isAtHouseGarage = false
            QBCore.Functions.TriggerCallback('qb-garages:isAtHouseGar', function(result)
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
            local pData = QBCore.Functions.GetPlayerData()
            local isAtHouseGarage = false
            QBCore.Functions.TriggerCallback('qb-garages:isAtHouseGar', function(result)
                isAtHouseGarage = result
            end)
            Wait(100)
            return (not pData.metadata["isdead"] and not pData.metadata["inlaststand"] and isAtHouseGarage and isCloseVeh() and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },    
```

* Put this at bottom
```lua
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
```

## NOTE
* Make sure to add all the vehicles you store within garages into 'Shared.lua'

## Optional
* If you want toggle on/off garage blips on map by using radialmenu you can use this *garages:Blips* Event for that

### 1.0
* Initial release

### 1.1
* resmon optimization
* minor bug fixes

### 1.2
* added Shared job garages
* added support for old qbcore
* added support for ghmattimysql

### 2.0
* shared MRPD Pillbox job garages
* added vehicle preview on vehicle selection
* added helicopter garage
* vehicle parking log

### 2.1
* not saving vehicle modifications of shared vehicles patched
* depot charges didn't reduced fixed
* added ability to save vehicle modifications when you store cars if you use too old core

## HORIZONSCRIPTS ## HORIZONSCRIPTS ## HORIZONSCRIPTS ## HORIZONSCRIPTS ##
IF YOU NEED ANY SUPPORT CONTACT US VIA DISCORD https://discord.gg/EJhKuMH6Bv
## HORIZONSCRIPTS ## HORIZONSCRIPTS ## HORIZONSCRIPTS ## HORIZONSCRIPTS ##