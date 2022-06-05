### QB-RealEstate Job for QBCore! - Made by Aljo

# Office for job was change alittle bit, converted from https://www.gta5-mods.com/maps/jonhsons-realty-office.
# This job have own wardrobe, duty blip, vehicle spawner and boss menu.

# There are some things that need to be added to qb-houses, qb-clothing, qb-radialmenu and changed in qb-bossmenu

# qb-houses server/main.lua under Events

```lua

RegisterNetEvent('qb-houses:server:updateTier', function()
    local HouseGarages = {}
        local result = exports.oxmysql:executeSync('SELECT * FROM houselocations', {})
        if result[1] then
            for k, v in pairs(result) do
                local owned = false
                if tonumber(v.owned) == 1 then
                    owned = true
                end
                local garage = json.decode(v.garage) or {}
                Config.Houses[v.name] = {
                    coords = json.decode(v.coords),
                    owned = v.owned,
                    price = newprice,
                    locked = true,
                    adress = v.label,
                    tier = v.tier,
                    garage = garage,
                    decorations = {}
                }
                HouseGarages[v.name] = {
                    label = v.label,
                    takeVehicle = garage
                }
            end
        end
        TriggerClientEvent("qb-garages:client:houseGarageConfig", -1, HouseGarages)
        TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Config.Houses)
end)

RegisterNetEvent('qb-houses:server:updatePrice', function(price)
    local newprice = price
    local HouseGarages = {}
    local result = exports.oxmysql:executeSync('SELECT * FROM houselocations', {})
    if result[1] then
        for k, v in pairs(result) do
            local owned = false
            if tonumber(v.owned) == 1 then
                owned = true
            end
            local garage = json.decode(v.garage) or {}
            Config.Houses[v.name] = {
                coords = json.decode(v.coords),
                owned = v.owned,
                price = newprice,
                locked = true,
                adress = v.label,
                tier = v.tier,
                garage = garage,
                decorations = {}
            }
            HouseGarages[v.name] = {
                label = v.label,
                takeVehicle = garage
            }
        end
    end
    TriggerClientEvent("qb-garages:client:houseGarageConfig", -1, HouseGarages)
    TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Config.Houses)    
end)

```

# qb-clothing config.lua line 50

```lua
    
    [7] = {requiredJob = "realestate", coords = vector3(-447.29, 168.25, 78.82), cameraLocation = vector4(-447.32, 166.44, 78.82,  300.44)},

```
# And line 710

```lua

    ["realestate"] = {
        ["male"] = {
            [1] = {
                outfitLabel = "Work clothes",
                outfitData = {
                    ["pants"]       = { item = 28, texture = 0},  -- Pants
                    ["arms"]        = { item = 1, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 31, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 294, texture = 0},  -- Jacket
                    ["shoes"]       = { item = 10, texture = 0},  -- Shoes
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = 12, texture = -1},  -- Hat
                    ["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                },
            },
        },
        ["female"] = {
            [1] = {
                outfitLabel = "Work clothes",
                outfitData = {
                    ["pants"]       = { item = 133, texture = 0},  -- Pants
                    ["arms"]        = { item = 31, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 35, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 34, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 48, texture = 0},  -- Jacket
                    ["shoes"]       = { item = 52, texture = 0},  -- Shoes
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = 0, texture = 0},  -- Hat
                    ["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                },
            },
        }
    },

```

# qb-radialmenu config.lua line 572

```lua

    ["realestate"] = {
        {
            id = 'housemenu',
            title = 'List of houses',
            icon = 'laptop-house',
            type = 'client',
            event = 'qb-realestate:client:OpenHouseListMenu',
            shouldClose = true
        }
    },

```

# qb-bossmenu config.lua

```lua

    ['realestate'] = vector3(-450.79, 168.38, 78.82),
    
```