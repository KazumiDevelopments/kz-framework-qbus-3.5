Config = {}

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

Config.RandomStr = function(length)
	if length > 0 then
		return Config.RandomStr(length-1) .. StringCharset[math.random(1, #StringCharset)]
	else
		return ''
	end
end

Config.RandomInt = function(length)
	if length > 0 then
		return Config.RandomInt(length-1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

Config.BinObjects = {
    "prop_bin_05a",
}

Config.VendingDrinksItem = {
    [1] = {
        name = "cocacola",
        price = 4,
        amount = 15,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "spirte",
        price = 4,
        amount = 15,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "water_bottle",
        price = 6,
        amount = 15,
        info = {},
        type = "item",
        slot = 3,
    },
}

Config.VendingFoodItems = {
    [1] = {
        name = "twerks_candy",
        price = 4,
        amount = 15,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "snikkel_candy",
        price = 4,
        amount = 15,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "twinkie",
        price = 5,
        amount = 15,
        info = {},
        type = "item",
        slot = 3,
    },
}

Config.VendingObjects = {
    {"prop_vend_soda_01", Config.VendingDrinksItem, 'Dede\'s Drinks'},
    {"prop_vend_soda_02", Config.VendingDrinksItem, 'Dede\'s Drinks'},
    {"prop_vend_water_01", Config.VendingDrinksItem, 'Dede\'s Drinks'},
    {1114264700, Config.VendingDrinksItem, 'Dede\'s Drinks'},
    {-654402915, Config.VendingFoodItems, 'Dede\'s Snacks'}
}

Config.CraftingItems = {
    [1] = {
        name = "screwdriverset",
        amount = 50,
        info = {},
        costs = {
            ["metalscrap"] = 50,
            ["plastic"] = 40,
        },
        type = "item",
        slot = 1,
        threshold = 0,
        points = 0,
    },
    [2] = {
        name = "advancedscrewdriver",
        amount = 50,
        info = {},
        costs = {
            ["metalscrap"] = 90,
            ["plastic"] = 70,
        },
        type = "item",
        slot = 2,
        threshold = 0,
        points = 0,
    },
    [3] = {
        name = "electronickit",
        amount = 50,
        info = {},
        costs = {
            ["metalscrap"] = 140,
            ["plastic"] = 140,
            ["aluminum"] = 140,
        },
        type = "item",
        slot = 3,
        threshold = 0,
        points = 0,
    },
    [4] = {
        name = "radioscanner",
        amount = 50,
        info = {},
        costs = {
            ["electronickit"] = 1,
            ["plastic"] = 50,
            ["steel"] = 50,
        },
        type = "item",
        slot = 4,
        threshold = 0,
        points = 0,
    },
    [5] = {
        name = "gatecrack",
        amount = 50,
        info = {},
        costs = {
            ["metalscrap"] = 75,
            ["plastic"] = 100,
            ["aluminum"] = 120,
            ["iron"] = 50,
            ["electronickit"] = 2,
        },
        type = "item",
        slot = 5,
        threshold = 0,
        points = 0,
    },
    [6] = {
        name = "handcuffs",
        amount = 50,
        info = {},
        costs = {
            ["steel"] = 50,
            ["aluminum"] = 30,
        },
        type = "item",
        slot = 6,
        threshold = 0,
        points = 0,
    },
    [7] = {
        name = "drill",
        amount = 50,
        info = {},
        costs = {
            ["iron"] = 200,
            ["steel"] = 200,
            ["screwdriverset"] = 2,
            ["advancedlockpick"] = 2,
        },
        type = "item",
        slot = 7,
        threshold = 0,
        points = 0,
    },
    [8] = {
        name = "advancedlockpick",
        amount = 50,
        info = {},
        costs = {
            ["iron"] = 50,
            ["steel"] = 10,
            ["lockpick"] = 1,
            ["glass"] = 150,
        },
        type = "item",
        slot = 8,
        threshold = 0,
        points = 0,
    },
    [9] = {
        name = "trojan_usb",
        amount = 50,
        info = {},
        costs = {
            ["glass"] = 50,
            ["steel"] = 125,
            ["copper"] = 125,
        },
        type = "item",
        slot = 9,
        threshold = 0,
        points = 0,
    },
    [10] = {
        name = "thermite",
        amount = 50,
        info = {},
        costs = {
            ["glass"] = 35,
            ["steel"] = 65,
            ["copper"] = 95,
        },
        type = "item",
        slot = 10,
        threshold = 0,
        points = 0,
    },
    [11] = {
        name = "lockpick",
        amount = 50,
        info = {},
        costs = {
            ["aluminum"] = 25,
            ["metalscrap"] = 25,
			["steel"] = 15,
        },
        type = "item",
        slot = 11,
        threshold = 0,
        points = 0,
    },
}

Config.AttachmentCrafting = {
    ["location"] = {x = 88.91, y = 3743.88, z = 40.77, h = 66.5, r = 1.0}, 
    ["items"] = {
        [1] = {
            name = "pistol_extendedclip",
            amount = 10,
            info = {},
            costs = {
                ["metalscrap"] = 30,
                ["steel"] = 30,
                ["rubber"] = 30,
            },
            type = "item",
            slot = 1,
            threshold = 0,
            points = 0,
        },
        [2] = {
            name = "pistol_suppressor",
            amount = 10,
            info = {},
            costs = {
                ["metalscrap"] = 30,
                ["steel"] = 30,
                ["rubber"] = 30,
            },
            type = "item",
            slot = 2,
            threshold = 0,
            points = 0,
        },
        [3] = {
            name = "rifle_extendedclip",
            amount = 10,
            info = {},
            costs = {
                ["metalscrap"] = 50,
                ["steel"] = 50,
                ["rubber"] = 50,
                ["smg_extendedclip"] = 1,
            },
            type = "item",
            slot = 7,
            threshold = 0,
            points = 0,
        },
        [4] = {
            name = "rifle_drummag",
            amount = 10,
            info = {},
            costs = {
                ["metalscrap"] = 50,
                ["steel"] = 50,
                ["rubber"] = 50,
                ["smg_extendedclip"] = 1,
            },
            type = "item",
            slot = 8,
            threshold = 0,
            points = 0,
        },
        [5] = {
            name = "smg_flashlight",
            amount = 10,
            info = {},
            costs = {
                ["metalscrap"] = 40,
                ["steel"] = 40,
                ["rubber"] = 40,
            },
            type = "item",
            slot = 3,
            threshold = 0,
            points = 0,
        },
        [6] = {
            name = "smg_extendedclip",
            amount = 10,
            info = {},
            costs = {
                ["metalscrap"] = 40,
                ["steel"] = 40,
                ["rubber"] = 40,
            },
            type = "item",
            slot = 4,
            threshold = 0,
            points = 0,
        },
        [7] = {
            name = "smg_suppressor",
            amount = 10,
            info = {},
            costs = {
                ["metalscrap"] = 40,
                ["steel"] = 40,
                ["rubber"] = 40,
            },
            type = "item",
            slot = 5,
            threshold = 0,
            points = 0,
        },
        [8] = {
            name = "smg_scope",
            amount = 10,
            info = {},
            costs = {
                ["metalscrap"] = 40,
                ["steel"] = 40,
                ["rubber"] = 40,
            },
            type = "item",
            slot = 6,
            threshold = 0,
            points = 0,
        },
    }
}

Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

MaxInventorySlots = 40

BackEngineVehicles = {
    'ninef',
    'adder',
    'vagner',
    't20',
    'infernus',
    'zentorno',
    'reaper',
    'comet2',
    'comet3',
    'jester',
    'jester2',
    'cheetah',
    'cheetah2',
    'prototipo',
    'turismor',
    'pfister811',
    'ardent',
    'nero',
    'nero2',
    'tempesta',
    'vacca',
    'bullet',
    'osiris',
    'entityxf',
    'turismo2',
    'fmj',
    're7b',
    'tyrus',
    'italigtb',
    'penetrator',
    'monroe',
    'ninef2',
    'stingergt',
    'surfer',
    'surfer2',
    'comet3',
}

Config.MaximumAmmoValues = {
    ["pistol"] = 250,
    ["smg"] = 250,
    ["shotgun"] = 200,
    ["rifle"] = 250,
}