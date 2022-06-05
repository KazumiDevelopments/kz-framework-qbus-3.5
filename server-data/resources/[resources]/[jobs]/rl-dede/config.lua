Config = {}

Config.Keys = {
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

Config.Products = {
    ['slushys'] = {
        [1] = {
            name = "orangeslushy",
            price = 29,
            amount = 15,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "blueslushy",
            price = 29,
            amount = 15,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "greenslushy",
            price = 29,
            amount = 15,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "yellowslushy",
            price = 29,
            amount = 15,
            info = {},
            type = "item",
            slot = 4,
        },
    },
    
    ['donuts'] = {
        [1] = {
            name = "donut",
            price = 4,
            amount = 200,
            info = {},
            type = "item",
            slot = 1,
        },
    },

    ['drinks'] = {
        [1] = {
            name = "water_bottle",
            price = 5,
            amount = 200,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "cocacola",
            price = 6,
            amount = 200,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "beer",
            price = 10,
            amount = 200,
            info = {},
            type = "item",
            slot = 3,
        },
    },
    
    ['sandwichs'] = {
        [1] = {
            name = "sandwich",
            price = 5,
            amount = 200,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "toast",
            price = 5,
            amount = 125,
            info = {},
            type = "200",
            slot = 2,
        },
    },
    
    ['coffees'] = {
        [1] = {
            name = "whiskey",
            price = 25,
            amount = 200,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "vodka",
            price = 25,
            amount = 200,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "coffee",
            price = 5,
            amount = 200,
            info = {},
            type = "item",
            slot = 3,
        },
    },
    
    ["misc"] = {
        [1] = {
            name = "twerks_candy",
            price = 5,
            amount = 200,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "snikkel_candy",
            price = 5,
            amount = 200,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "bandage",
            price = 15,
            amount = 250,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "lighter",
            price = 100,
            amount = 200,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "walkstick",
            price = 100,
            amount = 200,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "rolling_paper",
            price = 1,
            amount = 5000,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "binoculars",
            price = 30,
            amount = 15,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "twinkie",
            price = 5,
            amount = 15,
            info = {},
            type = "item",
            slot = 8,
        },
    },
}

Config.Locations = {
    ['shops'] = {
        ["slushys"] = {
            ['label'] = 'Our Slushys',
            ["coords"] = {
                [1] = vector3(26.847242, -1342.241, 29.508716),
            },
            ["products"] = Config.Products["slushys"],
        },
        ["donuts"] = {
            ['label'] = 'Our Donuts',
            ["coords"] = {
                [1] = vector3(31.027654, -1346.975, 29.523303),
            },
            ["products"] = Config.Products["donuts"],
        },
        ["drinks"] = {
            ['label'] = 'Our Drinks',
            ["coords"] = {
                [1] = vector3(34.331619, -1346.493, 29.748779),
            },
            ["products"] = Config.Products["drinks"],
        },
        ["sandwichs"] = {
            ['label'] = 'Our Sandwichs & Others',
            ["coords"] = {
                [1] = vector3(32.394802, -1342.964, 29.497022),
            },
            ["products"] = Config.Products["sandwichs"],
        },
        ["coffees"] = {
            ['label'] = 'Our Hard Drinks & Coffees',
            ["coords"] = {
                [1] = vector3(24.271385, -1343.473, 29.497022),
            },
            ["products"] = Config.Products["coffees"],
        },
    
        ["misc"] = {
            ['label'] = 'Our Candys & Miscs',
            ["coords"] = {
                [1] = vector3(25.746746, -1346.637, 29.497024),
            },
            ["products"] = Config.Products["misc"],
        },
    },

    ['job'] = {
        ['boss'] = vector3(30.330526, -1339.365, 29.497043),
        ['stash'] = vector3(24.746761, -1339.033, 29.497043),
        ['vendings'] = vector3(26.242641, -1315.003, 29.622074),
    }
}