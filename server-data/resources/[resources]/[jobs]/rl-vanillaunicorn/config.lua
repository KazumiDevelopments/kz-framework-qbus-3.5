Config = Config or {}

Config.Locations = {
	['shop'] = { ['x'] = 129.76, ['y'] = -1281.82, ['z'] = 29.26, ['h'] = 295.61 },
	['vip'] = { ['x'] = 92.97, ['y'] = -1291.31, ['z'] = 29.26, ['h'] = 26.38 },
	['stripper'] = { ['x'] = 108.55, ['y'] = -1305.98, ['z'] = 28.76, ['h'] = 212.00  },
	['boss'] = { ['x'] = 95.15, ['y'] = -1293.38, ['z'] = 29.26, ['h'] = 290.99  },
}

Config.Strippers = {
    ['locations'] ={
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(118.77422, -1302.212, 28.269432, 31.382211),
            ['stand'] = vector4(118.42105, -1301.561, 28.269502, 208.21502),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(116.74626, -1303.393, 28.273693, 32.705486),
            ['stand'] = vector4(116.29303, -1302.636, 28.269521, 207.09544),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(114.60829, -1304.639, 28.269498, 25.138725),
            ['stand'] = vector4(114.19611, -1303.985, 28.269498, 207.37702),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(112.82508, -1305.668, 28.2695, 30.056648),
            ['stand'] = vector4(112.34696, -1305.062, 28.269504, 202.59379),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(112.82508, -1305.668, 28.2695, 30.056648),
            ['stand'] = vector4(112.34696, -1305.062, 28.269504, 202.59379),
        },
    },
    ['peds'] = {
       'csb_stripper_01', -- White Stripper
	   's_f_y_stripperlite', -- Black Stripper
       'mp_f_stripperlite', -- Black Stripper
    }
}

Config.Items = {
    label = "Vanilla Unicorn",
    slots = 1,
    items = {
        [1] = {
            name = "glassbeer",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 1,
		},
        [2] = {
            name = "bloodymary",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "dusche",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "tequilashot",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "pinacolada",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 5,
		},
        [6] = {
            name = "beer",
            price = 4,
            amount = 1251,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "whiskey",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "vodka",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 8,
		},
        [9] = {
            name = "tequila",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 9,
		},
        [10] = {
            name = "fries",
            price = 7,
            amount = 125,
            info = {},
            type = "item",
            slot = 10,
        }
    }
}

Config.BossItems = {
    label = "Vanilla Unicorn VIP",
    slots = 1,
    items = {
        [1] = {
            name = "champagne",
            price = 1500,
            amount = 125,
            info = {},
            type = "item",
            slot = 1,	
		},
        [2] = {
            name = "whitewine",
            price = 1000,
            amount = 125,
            info = {},
            type = "item",
            slot = 2,	
		},
        [3] = {
            name = "glasschampagne",
            price = 0,
            amount = 125,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "glasswhiskey",
            price = 0,
            amount = 125,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "glasswine",
            price = 0,
            amount = 125,
            info = {},
            type = "item",
            slot = 5,
        }
    }
}