Config = {}

Config.Jobs = {
    ["electrician"] = "Electrician",
}

Config.Locations = {
    jobs = {
        ["electrician"] = {
            [1] = {
                coords = {x = 1761.46, y = 2540.41, z = 45.56, h = 272.249},
            },
            [2] = {
                coords = {x = 1718.54, y = 2527.802, z = 45.56, h = 272.249},
            },
            [3] = {
                coords = {x = 1700.199, y = 2474.811, z = 45.56, h = 272.249},
            },
            [4] = {
                coords = {x = 1664.827, y = 2501.58, z = 45.56, h = 272.249},
            },
            [5] = {
                coords = {x = 1621.622, y = 2509.302, z = 45.56, h = 272.249},
            },
            [6] = {
                coords = {x = 1627.936, y = 2538.393, z = 45.56, h = 272.249},
            },
            [7] = {
                coords = {x = 1625.1, y = 2575.988, z = 45.56, h = 272.249},
            },
        },
    },
    ["freedom"] = {
        coords = {x = 1788.01, y = 2595.48, z = 45.71, h = 1.0, r = 1.0}, 
    },
    ["outside"] = {
        coords = {x = 1838.93, y = 2587.18, z = 45.89, h = 181.56, r = 1.0}, 
    },
    ["yard"] = {
        coords = {x = 1765.67, y = 2565.91, z = 45.56, h = 1.5, r = 1.0}, 
    },
    ["middle"] = {
        coords = {x = 1712.70, y = 2562.95, z = 45.56, h = 190.23},
    },
    ["shop"] = {
        coords = {x = 1775.83, y = 2587.85, z = 45.71, h = 0.9, r = 1.0},
    },
    spawns = {
        [1] = {
            animation = "bumsleep",
            coords = {x = 1766.30, y = 2584.38, z = 46.24, h = 5.63},
        },
        [2] = {
            animation = "pee",
            coords = {x = 1764.29, y = 2581.01, z = 45.72, h = 93.08},
        },
        [3] = {
            animation = "lean",
            coords = {x = 1763.43, y = 2573.70, z = 45.73, h = 265.64},
        },
        [4] = {
            animation = "sitchair4",
            coords = {x = 1715.19, y = 2553.58, z = 45.56, h = 179.84},
        },
    }
}

Config.CanteenItems = {
    [1] = {
        name = "jailfood",
        price = 10,
        amount = 200,
        info = {},
        type = "item",
        slot = 1,
    },
}