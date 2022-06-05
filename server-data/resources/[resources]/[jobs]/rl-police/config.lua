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

Config.Objects = {
    ["cone"] = {model = `prop_roadcone02a`, freeze = false},
    ["barier"] = {model = `prop_barrier_work06a`, freeze = true},
    ["schotten"] = {model = `prop_snow_sign_road_06g`, freeze = true},
    ["tent"] = {model = `prop_gazebo_03`, freeze = true}, 
    ["light"] = {model = `prop_worklight_03b`, freeze = true},
    ["chair"] = {model = `prop_chair_08`, freeze = true},
    ["chairs"] = {model = `prop_chair_pile_01`, freeze = true},
    ["table"] = {model = `prop_table_03`, freeze = true},
    ["monitor"] = {model = `des_tvsmash_root`, freeze = true},
}

Config.Locations = {
   ["duty"] = {
       [1] = { ['x'] = 441.29382, ['y'] = -981.8419, ['z'] = 30.689504, ['h'] = 269.36389 },
       [2] = {x = 1849.98, y = 3686.11, z = 34.26, h = 119.80},
       [3] = {x = -449.811, y = 6012.909, z = 31.815, h = 90.654},
   },  
   ["vest"] = {
       [1] = { ['x'] = 487.28985, ['y'] = -995.6288, ['z'] = 30.689647, ['h'] = 312.05645 },
   }, 
   ["vehicle"] = {
       --[1] = { ['x'] = 447.15734, ['y'] = -1018.094, ['z'] = 28.58464, ['h'] = 117.68385 },
       [1] = {x = 471.13, y = -1024.05, z = 28.17, h = 274.5},
       [2] = {x = 1853.30, y = 3674.85, z = 33.72, h = 215.21},
       [3] = {x = -455.39, y = 6002.02, z = 31.34, h = 87.93},
       [4] = { ['x'] = 1753.7666, ['y'] = 2600.7036, ['z'] = 45.564975, ['h'] = 357.73715 },
       [5] = { ['x'] = 458.7723, ['y'] = -992.2885, ['z'] = 25.699819, ['h'] = 359.97521 },
       [6] = { ['x'] = 450.68603, ['y'] = -975.8229, ['z'] = 25.69981, ['h'] = 89.077331 },
       [7] = { ['x'] = 436.2752, ['y'] = -975.8202, ['z'] = 25.699792, ['h'] = 94.253761 },
       --[8] = { ['x'] = 437.36444, ['y'] = -991.4945, ['z'] = 25.825035, ['h'] = 93.966674 },
       [8] = { ['x'] = 444.99926, ['y'] = -991.558, ['z'] = 25.699813, ['h'] = 265.90441 },
       [9] = { ['x'] = 317.77432, ['y'] = -573.7828, ['z'] = 28.796842, ['h'] = 252.14067 },
       [10] = { ['x'] = 318.88052, ['y'] = -569.4916, ['z'] = 28.796842, ['h'] = 248.68237 },
       [11] = { ['x'] = 320.51202, ['y'] = -565.1149, ['z'] = 28.796842, ['h'] = 247.20288 },
       [12] = { ['x'] = 315.9385, ['y'] = -578.1325, ['z'] = 28.796842, ['h'] = 245.12908 },

   },
   ["stash"] = {
       [1] = { ['x'] = 475.83053, ['y'] = -987.4559, ['z'] = 34.217075, ['h'] = 266.51992 },
       [6] = { ['x'] = 463.37826, ['y'] = -995.8663, ['z'] = 30.689512, ['h'] = 2.0808196 },
       [2] = {x = 1853.02, y = 3689.85, z = 34.26, h = 292.75},
       [3] = {x = 1765.33, y = 2589.48, z = 49.71, h = 176.13},
       [4] = {x = 1834.93, y = 2573.00, z = 45.89, h = 179.96},
       [5] = {x = -434.63, y = 6001.63, z = 31.71, h = 316.5, r = 1.0},
   },     
   ["impound"] = {}, 
   ["helicopter"] = {
       [1] = {x = 449.168, y = -981.325, z = 43.691, h = 87.234},
       [2] = {x = 1893.71, y = 3697.82, z = 32.88, h = 213.31},
       [3] = {x = -475.43, y = 5988.353, z = 31.716, h = 31.34},
       [4] = {x = 352.17401, y = -588.3106, z = 74.161773, h = 68.790626},
   }, 
   ["boat"] = {
       [1] = {x = -789.27, y = -1486.10, z = 0.26, h = 105.81},
	   [2] = {x = -1613.35, y = -1168.50, z = 0.33, h = 126.32},
	   [3] = {x = 1583.26, y = 3861.79, z = 30.19, h = 68.31},
	   [4] = {x = -723.85, y = 6115.57, z = 0.12, h = 24.24},
   }, 
   ["armory"] = {
       [1] = {['x'] = 482.50073, ['y'] = -995.827, ['z'] = 30.689647, ['h'] = 359.50912 },
       [2] = {x = 1841.97, y = 3691.42, z = 34.26, h = 119.59},
       [3] = {x = -436.82, y = 5996.98, z = 31.716, h = 90.654},
   }, 
   ["jail"] = {
       [1] = {x = 1763.79, y = 2591.75, z = 49.71, h = 90.55},
   },   
   ["trash"] = {
    [1] = {x = 448.20758, y = -996.9163, z = 30.689508, h = 88.125755},
   },     
   ["property"] = {
       [1] = { ['x'] = 462.2124, ['y'] = -999.674, ['z'] = 30.689514, ['h'] = 185.73783 },
   },     
   ["fingerprint"] = {
       [1] = { ['x'] = 473.10122, ['y'] = -1013.379, ['z'] = 26.273303, ['h'] = 301.55725 },
       [2] = {x = 1848.60, y = 3680.75, z = 30.25, h = 115.46},
       [3] = {x = -442.38, y = 6011.9, z = 27.98, h = 311.5},
   },
   ["evidence"] = {
       [1] = { ['x'] = 472.90631, ['y'] = -996.5554, ['z'] = 26.273279, ['h'] = 181.26879 },
       [2] = {x = -439.09, y = 6003.12, z = 31.84, h = 90.654},
   },    
   ["evidence2"] = {
       [1] =  { ['x'] = 474.8402, ['y'] = -996.3182, ['z'] = 26.273275, ['h'] = 179.52352 },
       [2] = {x = -439.54, y = 6011.42, z = 27.98, h = 44.5, r = 1.0},
   },   
   ["evidence3"] = {
       [1] = {x = 472.82369, y = -993.3993, z = 26.273279, h = 349.44125},
       [2] = {x = -439.43, y = 6009.45, z = 27.98, h = 134.5, r = 1.0},
   }, 
   ["csi"] = {
    [1] = { ['x'] = 480.92214, ['y'] = -990.832, ['z'] = 30.689649, ['h'] = 87.517753 },
    [2] = { ['x'] = 487.4776, ['y'] = -987.764, ['z'] = 30.68964, ['h'] = 273.38232 },
},       
   ["stations"] = {
       [1] = {label = "Police Station 1", coords = {x = 428.23, y = -984.28, z = 29.76, h = 3.5}},
       [2] = {label = "Police Station 2", coords = {x = -451.55, y = 6014.25, z = 31.716, h = 223.81}},
       [3] = {label = "Police Station 3", coords = {x = 1856.36, y = 3681.32, z = 34.26, h = 212.73}},
       [4] = {label = "Prison", coords = {x = 1845.903, y = 2585.873, z = 45.672, h = 272.249}},
   },
   ["boss"] = {
        [1] = { ['x'] = 462.18551, ['y'] = -984.781, ['z'] = 30.689685, ['h'] = 1.941749 },
        [2] = { ['x'] = -447.433, ['y'] = 6014.2958, ['z'] = 36.507068, ['h'] = 227.97558 },
        [3] = { ['x'] = 1861.67, ['y'] = 3689.42, ['z'] = 34.26, ['h'] = 353.00 },
    },
}

Config.Helicopter = "polas350"
Config.Boat = "predator"

Config.SecurityCameras = {
    hideradar = false,
    cameras = {
        [1] = {label = "Pacific Bank CAM#1", x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false, isOnline = true},
        [2] = {label = "Pacific Bank CAM#2", x = 232.86, y = 221.46, z = 107.83, r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = false, isOnline = true},
        [3] = {label = "Pacific Bank CAM#3", x = 252.27, y = 225.52, z = 103.99, r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = false, isOnline = true},
        [4] = {label = "Limited Ltd Grove St. CAM#1", x = -53.1433, y = -1746.714, z = 31.546, r = {x = -35.0, y = 0.0, z = -168.9182}, canRotate = false, isOnline = true},
        [5] = {label = "Rob's Liqour Prosperity St. CAM#1", x = -1482.9, y = -380.463, z = 42.363, r = {x = -35.0, y = 0.0, z = 79.53281}, canRotate = false, isOnline = true},
        [6] = {label = "Rob's Liqour San Andreas Ave. CAM#1", x = -1224.874, y = -911.094, z = 14.401, r = {x = -35.0, y = 0.0, z = -6.778894}, canRotate = false, isOnline = true},
        [7] = {label = "Limited Ltd Ginger St. CAM#1", x = -718.153, y = -909.211, z = 21.49, r = {x = -35.0, y = 0.0, z = -137.1431}, canRotate = false, isOnline = true},
        [8] = {label = "24/7 Supermarket Innocence Blvd. CAM#1", x = 23.885, y = -1342.441, z = 31.672, r = {x = -35.0, y = 0.0, z = -142.9191}, canRotate = false, isOnline = true},
        [9] = {label = "Rob's Liqour El Rancho Blvd. CAM#1", x = 1133.024, y = -978.712, z = 48.515, r = {x = -35.0, y = 0.0, z = -137.302}, canRotate = false, isOnline = true},
        [10] = {label = "Limited Ltd West Mirror Drive CAM#1", x = 1151.93, y = -320.389, z = 71.33, r = {x = -35.0, y = 0.0, z = -119.4468}, canRotate = false, isOnline = true},
        [11] = {label = "24/7 Supermarket Clinton Ave CAM#1", x = 383.402, y = 328.915, z = 105.541, r = {x = -35.0, y = 0.0, z = 118.585}, canRotate = false, isOnline = true},
        [12] = {label = "Limited Ltd Banham Canyon Dr CAM#1", x = -1832.057, y = 789.389, z = 140.436, r = {x = -35.0, y = 0.0, z = -91.481}, canRotate = false, isOnline = true},
        [13] = {label = "Rob's Liqour Great Ocean Hwy CAM#1", x = -2966.15, y = 387.067, z = 17.393, r = {x = -35.0, y = 0.0, z = 32.92229}, canRotate = false, isOnline = true},
        [14] = {label = "24/7 Supermarket Ineseno Road CAM#1", x = -3046.749, y = 592.491, z = 9.808, r = {x = -35.0, y = 0.0, z = -116.673}, canRotate = false, isOnline = true},
        [15] = {label = "24/7 Supermarket Barbareno Rd. CAM#1", x = -3246.489, y = 1010.408, z = 14.705, r = {x = -35.0, y = 0.0, z = -135.2151}, canRotate = false, isOnline = true},
        [16] = {label = "24/7 Supermarket Route 68 CAM#1", x = 539.773, y = 2664.904, z = 44.056, r = {x = -35.0, y = 0.0, z = -42.947}, canRotate = false, isOnline = true},
        [17] = {label = "Rob's Liqour Route 68 CAM#1", x = 1169.855, y = 2711.493, z = 40.432, r = {x = -35.0, y = 0.0, z = 127.17}, canRotate = false, isOnline = true},
        [18] = {label = "24/7 Supermarket Senora Fwy CAM#1", x = 2673.579, y = 3281.265, z = 57.541, r = {x = -35.0, y = 0.0, z = -80.242}, canRotate = false, isOnline = true},
        [19] = {label = "24/7 Supermarket Alhambra Dr. CAM#1", x = 1966.24, y = 3749.545, z = 34.143, r = {x = -35.0, y = 0.0, z = 163.065}, canRotate = false, isOnline = true},
        [20] = {label = "24/7 Supermarket Senora Fwy CAM#2", x = 1729.522, y = 6419.87, z = 37.262, r = {x = -35.0, y = 0.0, z = -160.089}, canRotate = false, isOnline = true},
        [21] = {label = "Fleeca Bank Hawick Ave CAM#1", x = 309.341, y = -281.439, z = 55.88, r = {x = -35.0, y = 0.0, z = -146.1595}, canRotate = false, isOnline = true},
        [22] = {label = "Fleeca Bank Legion Square CAM#1", x = 144.871, y = -1043.044, z = 31.017, r = {x = -35.0, y = 0.0, z = -143.9796}, canRotate = false, isOnline = true},
        [23] = {label = "Fleeca Bank Hawick Ave CAM#2", x = -355.7643, y = -52.506, z = 50.746, r = {x = -35.0, y = 0.0, z = -143.8711}, canRotate = false, isOnline = true},
        [24] = {label = "Fleeca Bank Del Perro Blvd CAM#1", x = -1214.226, y = -335.86, z = 39.515, r = {x = -35.0, y = 0.0, z = -97.862}, canRotate = false, isOnline = true},
        [25] = {label = "Fleeca Bank Great Ocean Hwy CAM#1", x = -2958.885, y = 478.983, z = 17.406, r = {x = -35.0, y = 0.0, z = -34.69595}, canRotate = false, isOnline = true},
        [26] = {label = "Paleto Bank CAM#1", x = -102.939, y = 6467.668, z = 33.424, r = {x = -35.0, y = 0.0, z = 24.66}, canRotate = false, isOnline = true},
        [27] = {label = "Del Vecchio Liquor Paleto Bay", x = -163.75, y = 6323.45, z = 33.424, r = {x = -35.0, y = 0.0, z = 260.00}, canRotate = false, isOnline = true},
        [28] = {label = "Don's Country Store Paleto Bay CAM#1", x = 166.42, y = 6634.4, z = 33.69, r = {x = -35.0, y = 0.0, z = 32.00}, canRotate = false, isOnline = true},
        [29] = {label = "Don's Country Store Paleto Bay CAM#2", x = 163.74, y = 6644.34, z = 33.69, r = {x = -35.0, y = 0.0, z = 168.00}, canRotate = false, isOnline = true},
        [30] = {label = "Don's Country Store Paleto Bay CAM#3", x = 169.54, y = 6640.89, z = 33.69, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = false, isOnline = true},
        [31] = {label = "Vangelico CAM#1", x = -627.54, y = -239.74, z = 40.33, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
        [32] = {label = "Vangelico CAM#2", x = -627.51, y = -229.51, z = 40.24, r = {x = -35.0, y = 0.0, z = -95.78}, canRotate = true, isOnline = true},
        [33] = {label = "Vangelico CAM#3", x = -620.3, y = -224.31, z = 40.23, r = {x = -35.0, y = 0.0, z = 165.78}, canRotate = true, isOnline = true},
        [34] = {label = "Vangelico CAM#4", x = -622.57, y = -236.3, z = 40.31, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
    },
}


Config.Vehicles = {
    --["POLVIC"] = "LSPD Vic",
    ["POLVIC2"] = "2011 Crown Vic",
    ["code3cap"] = "Chevrolet Caprice",
    ["POLTAURUS"] = "2016 Taurus",
    ["tahoe"] = "2020 Tahoe",
    --["pol8"] = "Motorbike",
    ["POLRAPTOR"] = "2020 Raptor",
    ["expleo"] = "2016 Explorer",
    ["18chgrleo"] = "2018 Charger",
    ["POLCHAR"] = "2014 Charger",
    ["sspres"] = "SWAT Suburban",
    ["onebeast"] = "SWAT Limo",
    ["sahpinsurgent"] = "SWAT Insurgent",
    ["pbus2"] = "Prison Bus",
    ["policet"] = "Armored Van",
    ["polschafter3"] = "UC Schafter",
    ["2015POLSTANG"] = "Mustang",
    ["fbi"] = "FBI Buffalo",
    ["fbi2"] = "TFBI Granger",
    ["ucwashington"] = "UC Washington",
    ["ucbanshee"] = "UC Banshee",
    ["ucrancher"] = "UC Rancher",
    ["ucprimo"] = "UC Primo",
    ["uccoquette"] = "UC Coquette",
    ["ucbuffalo"] = "UC Buffalo",
    ["ucballer"] = "UC Baller",
    ["uccomet"] = "UC Comet",  
}

Config.AmmoLabels = {
    ["AMMO_PISTOL"] = "9x19mm Pistol Ammo",
    ["AMMO_SMG"] = "9x19mm SMG Ammo",
    ["AMMO_RIFLE"] = "7.62x39mm Rifle Ammo",
    ["AMMO_MG"] = "7.92x57mm MG Ammo",
    ["AMMO_SHOTGUN"] = "12 Shotgun shells",
    ["AMMO_SNIPER"] = "Sniper bullet",
}

Config.Radars = {
	{x = -623.44421386719, y = -823.08361816406, z = 25.25704574585, h = 145.0 },
	{x = -652.44421386719, y = -854.08361816406, z = 24.55704574585, h = 325.0 },
	{x = 1623.0114746094, y = 1068.9924316406, z = 80.903594970703, h = 84.0 },
	{x = -2604.8994140625, y = 2996.3391113281, z = 27.528566360474, h = 175.0 },
	{x = 2136.65234375, y = -591.81469726563, z = 94.272926330566, h = 318.0 },
	{x = 2117.5764160156, y = -558.51013183594, z = 95.683128356934, h = 158.0 },
	{x = 406.89505004883, y = -969.06286621094, z = 29.436267852783, h = 33.0 },
	{x = 657.315, y = -218.819, z = 44.06, h = 320.0 },
	{x = 2118.287, y = 6040.027, z = 50.928, h = 172.0 },
	{x = -106.304, y = -1127.5530, z = 30.778, h = 230.0 },
	{x = -823.3688, y = -1146.980, z = 8.0, h = 300.0 },
}

Config.CarItems = {
    [1] = {
        name = "weapon_fireextinguisher",
        amount = 1,
        info = {},
        type = "weapon",
        slot = 1,
    },
}

Config.Items = {
    label = "Police Weapon Safe",
    slots = 1,
    items = {
        [1] = {
            name = "weapon_pistol_mk2",
            price = 75,
            amount = 1,
            info = {
                serie = "",                
                attachments = {
                    {component = "COMPONENT_PISTOL_MK2_CLIP_02", label = "Extended"},
                    {component = "COMPONENT_AT_PI_COMP", label = "Compensator"},
                    {component = "COMPONENT_AT_PI_FLSH_02", label = "Flashlight"},
                    {component = "COMPONENT_AT_PI_RAIL", label = "Scope"},
                }
            },
            type = "weapon",
            slot = 1,
        },
        [2] = {
            name = "weapon_combatpdw",
            price = 300,
            amount = 1,
            info = {
                serie = "",                
                attachments = {
                    {component = "COMPONENT_COMBATPDW_CLIP_02", label = "Extended"},
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    {component = "COMPONENT_AT_AR_AFGRIP", label = "Grip"},
                    {component = "COMPONENT_AT_SCOPE_SMALL", label = "Scope"},
                }
            },
            type = "weapon",
            slot = 2,
        },
        [3] = {
            name = "weapon_smg",
            price = 200,
            amount = 1,
            info = {
                serie = "",                
                attachments = {
                    {component = "COMPONENT_SMG_CLIP_02", label = "Extended"},
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    {component = "COMPONENT_AT_SCOPE_MACRO_02", label = "Scope"},
                }
            },
            type = "weapon",
            slot = 3,
        },
        [4] = {
            name = "weapon_smg_mk2",
            price = 250,
            amount = 1,
            info = {
                serie = "",                
                attachments = {
                    {component = "COMPONENT_SMG_MK2_CLIP_02", label = "Extended"},
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    {component = "COMPONENT_AT_SIGHTS_SMG", label = "Scope"},
                }
            },
            type = "weapon",
            slot = 4,
        },
        [5] = {
            name = "weapon_carbinerifle",
            price = 300,
            amount = 1,
            info = {
                serie = "",                
                attachments = {
                    {component = "COMPONENT_CARBINERIFLE_CLIP_02", label = "Extended"},
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    {component = "COMPONENT_AT_AR_AFGRIP", label = "Grip"},
                    {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "Scope"},
                }
            },
            type = "weapon",
            slot = 5,
        }, 
        [6] = {
            name = "weapon_carbinerifle_mk2",
            price = 600,
            amount = 1,
            info = {
                serie = "",                
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    {component = "COMPONENT_AT_AR_AFGRIP_02", label = "Grip"},
                    {component = "COMPONENT_AT_SIGHTS", label = "Scope"},
					{component = "COMPONENT_CARBINERIFLE_MK2_CLIP_TRACER", label = "Tracer Rounds"},
					{component = "COMPONENT_AT_MUZZLE_07", label = "Split-End Muzzle Brake"},
					{component = "COMPONENT_AT_CR_BARREL_02", label = "Heavy Barrel"},
                }
            },
            type = "weapon",
            slot = 6,
        }, 
        [7] = {
            name = "weapon_doubleaction",
            price = 150,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 7,
        },
        [8] = {
            name = "weapon_stungun",
            price = 25,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 8,
        },
        [9] = {
            name = "weapon_nightstick",
            price = 10,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 9,
        },
        [10] = {
            name = "weapon_flashlight",
            price = 20,
            amount = 2,
            info = {},
            type = "weapon",
            slot = 10,
        },
        [11] = {
            name = "weapon_fireextinguisher",
            price = 50,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 11,
        },
        [12] = {
            name = "handcuffs",
            price = 10,
            amount = 5,
            info = {},
            type = "item",
            slot = 12,
        },
        [13] = {
            name = "binoculars",
            price = 20,
            amount = 5,
            info = {},
            type = "item",
            slot = 13,
        },
        [14] = {
            name = "diving_gear",
            price = 1000,
            amount = 2,
            info = {},
            type = "item",
            slot = 14,
        }, 
        [15] = {
            name = "parachute",
            price = 250,
            amount = 2,
            info = {},
            type = "item",
            slot = 15,
        }, 
        [16] = {
            name = "heavyarmor",
            price = 100,
            amount = 10,
            info = {},
            type = "item",
            slot = 16,
        },
        [17] = {
            name = "radio",
            price = 150,
            amount = 10,
            info = {},
            type = "item",
            slot = 17,
        },
        [18] = {
            name = "empty_evidence_bag",
            price = 2,
            amount = 50,
            info = {},
            type = "item",
            slot = 18,
        },
        [19] = {
            name = "police_stormram",
            price = 100,
            amount = 10,
            info = {},
            type = "item",
            slot = 19,
        },
        [20] = {
            name = "pistol_ammo",
            price = 10,
            amount = 15,
            info = {},
            type = "item",
           slot = 20,
        },    
        [21] = {
            name = "smg_ammo",
            price = 15,
            amount = 15,
            info = {},
            type = "item",
           	slot = 21,
        },
        [22] = {
            name = "rifle_ammo",
            price = 15,
            amount = 15,
            info = {},
            type = "item",
            slot = 22,
        },
        [23] = {
            name = "signalradar",
            price = 5,
            amount = 10,
            info = {},
            type = "item",
            slot = 23,
        },
        [24] = {
            name = "ifak",
            price = 50,
            amount = 25,
            info = {},
            type = "item",
            slot = 24,
        },
        [25] = {
            name = "repairkit",
            price = 150, 
            amount = 5,
            info = {},
            type = "item",
            slot = 25,
        },
    }
}

Config.JailItems = {
    label = "Jail Weapon Safe",
    slots = 1,
    items = {
        [1] = {
            name = "weapon_stungun",
            price = 25,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 1,
        },
        [2] = {
            name = "weapon_nightstick",
            price = 10,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 2,
        },
        [3] = {
            name = "weapon_flashlight",
            price = 20,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 3,
        },
        [4] = {
            name = "handcuffs",
            price = 10,
            amount = 5,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "binoculars",
            price = 20,
            amount = 5,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "heavyarmor",
            price = 100,
            amount = 10,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "radio",
            price = 150,
            amount = 10,
            info = {},
            type = "item",
            slot = 7,
		},
        [8] = {
            name = "ifak",
            price = 50,
            amount = 25,
            info = {},
            type = "item",
            slot = 8,
        }
    }
}