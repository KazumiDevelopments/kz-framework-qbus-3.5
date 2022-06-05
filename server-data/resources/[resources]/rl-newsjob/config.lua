Config = Config or {}

Config.Locations = {
	['stash'] = { ['x'] = -587.8378, ['y'] = -936.3125, ['z'] = 23.877563 },
      ['shop'] = { ['x'] = -591.6034, ['y'] = -933.0354, ['z'] = 23.877563 },
      ['vehicles'] = { ['x'] = -552.24, ['y'] = -925.61, ['z'] = 23.86 },
      ['boss'] = { ['x'] = -580.5962, ['y'] = -936.2144, ['z'] = 23.877573 },
      ["helipad"] = { ['x'] = -582.6713, ['y'] = -930.4347, ['z'] = 36.7, ['a'] = 92.664566 }
}

Config.Shop = {
    label = "News Items",
    slots = 1,
    items = {
		[1] = {
            name = "empy_contract",
            price = 30,
            amount = 25,
            type = "item",
            slot = 1,
		},
		[2] = {
            name = "radioscanner",
            price = 250,
            amount = 25,
            type = "item",
            slot = 2,
        },
	}
}

Config.Vehicles = {
      ["wnews1"] = "Small Reporter Van",
      ["wnews2"] = "Large Reporter Van"
}