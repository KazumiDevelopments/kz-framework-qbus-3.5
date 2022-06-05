GaragesConfig = {
    ['settings'] = {
        --['license'] = 'tryhardrpwhitelistMAIN', -- Your license key here
        ['license'] = 'BBMAIN', -- Your license key here
        --[[
            Blips - {color, sprite, display, scale}
        ]]
        ['blip'] = {
            ['garage'] = {69, 357, 6, 0.65},
            ['impound'] = {61, 357, 6, 0.65},
            ['house'] = {50, 357, 6, 0.65},
        },

        ['dev'] = {
            ['enable'] = true,
            ['rank'] = 'god',
        },

        --[[
            Blacklisted Weapons,
            Players will not be able to rob NPC car with these weapons
        ]]
        ['blacklistedWeapons'] = {
            "WEAPON_UNARMED",
            "WEAPON_Knife",
            "WEAPON_Nightstick",
            "WEAPON_HAMMER",
            "WEAPON_Bat",
            "WEAPON_Crowbar",
            "WEAPON_Golfclub",
            "WEAPON_Bottle",
            "WEAPON_Dagger",
            "WEAPON_Hatchet",
            "WEAPON_KnuckleDuster",
            "WEAPON_Machete",
            "WEAPON_Flashlight",
            "WEAPON_SwitchBlade",
            "WEAPON_Poolcue",
            "WEAPON_Wrench",
            "WEAPON_Battleaxe",
            "WEAPON_Grenade",
            "WEAPON_StickyBomb",
            "WEAPON_ProximityMine",
            "WEAPON_BZGas",
            "WEAPON_Molotov",
            "WEAPON_FireExtinguisher",
            "WEAPON_PetrolCan",
            "WEAPON_Flare",
            "WEAPON_Ball",
            "WEAPON_Snowball",
            "WEAPON_SmokeGrenade",
        },

        -- Accept Bank?
        ['bank-payments'] = true,

        -- Fakeplates Stuff
        ['fakeplates'] = {
            ['screwdriver-break-chance'] = 4, -- X / 10
            ['skillbars-max-random'] = 1, -- Max random number of skill bars
            ['taskbarskill-export'] = 'rl-taskbarskill',
        },

        ['interactions'] = {
            ['interact'] = 'Garage',
            ['to_interact'] = '[E] To Open Garage',
        },

        ['housing'] = {
            ['realestate-job'] = 'realestate',
            ['qb-houses:client:addGarage'] = 'rl-houses:client:addGarage',
            ['max-garage-slots'] = 4,
        }
        
    }
}