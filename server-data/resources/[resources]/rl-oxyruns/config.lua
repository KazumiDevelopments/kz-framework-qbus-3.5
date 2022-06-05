Config = {}

Config.StartOxyPayment = 2500 -- Cash you pay to start the delivery kekw
Config.RunAmount = math.random(4,7) -- How many dropoffs you can do per payment, stops at max math.random
Config.OxyChance = 70 -- Percentage chance of getting oxy on the run. Multiplied by 100. 10% = 100, 20% = 200, 50% = 500, etc. Default 55%.
Config.BigRewarditemChance = 1 -- Percentage of getting rare item on oxy run. Multiplied by 100. 0.1% = 1, 1% = 10, 20% = 200, 50% = 500, etc. Default 0.1%.

Config.Locations = {
	-- Everyone
	['enter'] = { ['x'] = -638.66, ['y'] = -1249.59, ['z'] = 11.81 },
	['exit'] = { ['x'] = -639.68, ['y'] = -1255.01, ['z'] = -32.14 },
	['ped'] = { ['x'] = -635.80, ['y'] = -1247.88, ['z'] = -32.14, ['h'] = 134.37 },

	-- Whitelist
	['stash'] = { ['x'] = 468.16662, ['y'] = -1510.469, ['z'] = -9.422742, ['h'] = 169.84828 },
	['shop'] = { ['x'] = 463.76699, ['y'] = -1507.401, ['z'] = -9.42274, ['h'] = 189.64636 },
	['boss'] = { ['x'] = -637.01, ['y'] = -1244.83, ['z'] = -32.14, ['h'] = 176.88 },
}

Config.Shop = {
    label = "Oxyruns Items",
    slots = 1,
    items = {
		[1] = {
            name = "empy_contract",
            price = 0,
            amount = 1,
            type = "item",
            slot = 1,
        },
	}
}