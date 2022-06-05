RLCore = nil
Citizen.CreateThread(function() 
    while RLCore == nil do
        Citizen.Wait(10)
        TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
    end

    while not RLCore.Functions.GetPlayerData() do
        Wait(1)
    end

    while not RLCore.Functions.GetPlayerData().job do
        Wait(1)
    end

    PlayerData = RLCore.Functions.GetPlayerData()

    ShowVehshopBlips(true)
end)

RegisterNetEvent('FinishMoneyCheckForVeh')
RegisterNetEvent('vehshop:spawnVehicle')
local vehshop_blips = {}
local financedPlates = {}
local buyPlate = {}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false
local vehicle_price = 0
local backlock = false
local firstspawn = 0
local commissionbuy = 0

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
local currentCarSpawnLocation = 0
local ownerMenu = false

local vehshopDefault = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Job Vehicles", description = ''},
			}
		},
		["Job Vehicles"] = {
			title = "Job Vehicles",
			name = "Job Vehicles",
			buttons = {
				{name = "Flat Bed", costs = 22000, description = {}, model = "flatbed"},
				{name = "Taxi Cab", costs = 18500, description = {}, model = "taxi"},
				{name = "News Rumpo", costs = 19000, description = {}, model = "rumpo"},
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 150, description = {}, model = "bmx"},
				{name = "Caddy", costs = 5000, description = {}, model = "caddy"},
				{name = "Old Caddy", costs = 3000, description = {}, model = "caddy2"},
				{name = "Cruiser", costs = 240, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 270, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 300, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 2500, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 2600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 2900, description = {}, model = "tribike3"},
			}
		},		
	}
}

vehshop = vehshopDefault
local vehshopOwner = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = {
		x = 0.14,
		y = 0.15,
		width = 0.12,
		height = 0.03,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.29,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Motorcycles", description = ""},
				{name = "Cycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Cayo Perico", description = ''},
				{name = "Compacts", description = ''},
				{name = "Coupes", description = ''},
				{name = "Diamond Casino", description = ''},
				{name = "Job Vehicles", description = ''},
				{name = "Lowriders", description = ''},
				{name = "Muscle", description = ''},
				{name = "Off-Road", description = ''},
				{name = "Sedans", description = ''},
				{name = "Sports", description = ''},
				{name = "Sport Classics", description = ''},
				{name = "Suvs", description = ''},
				{name = "Vans", description = ''},
				--{name = "Custom Imports", description = ''},
			}
		},
		["Job Vehicles"] = {
			title = "Job Vehicles",
			name = "Job Vehicles",
			buttons = {
				{name = "Taxi Cab", costs = 18500, description = {}, model = "taxi"},
				{name = "Flat Bed", costs = 22000, description = {}, model = "flatbed"},
				{name = "News Rumpo", costs = 19000, description = {}, model = "rumpo"},
			}
		},
		["Compacts"] = {
			title = "Compacts",
			name = "Compacts",
			buttons = {			
				{name = "Blista", costs = 12000, description = {}, model = "blista"},
				{name = "Brioso R/A", costs = 22000, description = {}, model = "brioso"},
				{name = "Dilettante", costs = 10000, description = {}, model = "Dilettante"},
				{name = "Issi", costs = 14000, description = {}, model = "issi2"},
				{name = "Panto", costs = 8000, description = {}, model = "panto"},
				{name = "Prairie", costs = 9000, description = {}, model = "prairie"},
				{name = "Rhapsody", costs = 16000, description = {}, model = "rhapsody"},
			}
		},
		["Coupes"] = {
			title = "Coupes",
			name = "Coupes",
			buttons = {
				{name = "Cognoscenti Cabrio", costs = 150000, description = {}, model = "cogcabrio"},
				{name = "Cyclone Electric", costs = 150000, description = {}, model = "cyclone"},
				{name = "Exemplar", costs = 80000, description = {}, model = "exemplar"},
				{name = "F620", costs = 90000, description = {}, model = "f620"},
				{name = "Felon", costs = 50000, description = {}, model = "felon"},
				{name = "Felon GT", costs = 70000, description = {}, model = "felon2"},
				{name = "Jackal", costs = 40000, description = {}, model = "jackal"},
				{name = "Oracle", costs = 30000, description = {}, model = "oracle"},
				{name = "Oracle XS", costs = 35000, description = {}, model = "oracle2"},
				{name = "Sentinel", costs = 45000, description = {}, model = "sentinel"},
				{name = "Sentinel XS", costs = 25000, description = {}, model = "sentinel2"},
				{name = "Voltic Electric", costs = 100000, description = {}, model = "voltic"},
				{name = "Windsor", costs = 160000, description = {}, model = "windsor"},
				{name = "Windsor Drop", costs = 165000, description = {}, model = "windsor2"},
				{name = "Zion", costs = 10000, description = {}, model = "zion"},
				{name = "Zion Cabrio", costs = 15000, description = {}, model = "zion2"},
			}
		},
		["Sports"] = {
			title = "Sports",
			name = "Sports",
			buttons = {
				{name = "9F", costs = 120000, description = {}, model = "ninef"},
				{name = "9F Cabrio", costs = 165000, description = {}, model = "ninef2"},
				{name = "Alpha", costs = 15000, description = {}, model = "alpha"},
				{name = "Banshee", costs = 70000, description = {}, model = "banshee"},
				{name = "Banshee 900r", costs = 120000, description = {}, model = "banshee2"},
				{name = "Bestia GTS", costs = 175000, description = {}, model = "bestiagts"},
				{name = "Buffalo", costs = 15000, description = {}, model = "buffalo"},
				{name = "Buffalo S", costs = 20000, description = {}, model = "buffalo2"},
				{name = "Carbonizzare", costs = 165000, description = {}, model = "carbonizzare"},
				{name = "Comet", costs = 60000, description = {}, model = "comet2"},
				{name = "Comet Retro Custom", costs = 75000, description = {}, model = "comet3"},
				{name = "Comet Safari", costs = 47000, description = {}, model = "comet4"},
				{name = "Comet SR", costs = 110000, description = {}, model = "comet5"},
				{name = "Coquette", costs = 80000, description = {}, model = "coquette"},
				{name = "D10", costs =100000, description = {}, model = "coquette4"},
				{name = "Elegy", costs = 90000, description = {}, model = "elegy2"},
				{name = "Elegy Retro Custom", costs = 87000, description = {}, model = "elegy"},
				{name = "Feltzer", costs = 75000, description = {}, model = "feltzer2"},
				{name = "Flash GT", costs = 87000, description = {}, model = "flashgt"},
				{name = "Furore GT", costs = 30000, description = {}, model = "furoregt"},
				{name = "Futo", costs = 8000, description = {}, model = "futo"},
				{name = "Fusilade", costs = 15000, description = {}, model = "fusilade"},
				{name = "GB-200", costs = 58000, description = {}, model = "gb200"},
				{name = "Jester", costs = 95000, description = {}, model = "jester"},
				{name = "Jester Classic", costs = 50000, description = {}, model = "jester3"},
				{name = "Khamelion", costs = 80000, description = {}, model = "khamelion"},
				{name = "Kuruma", costs = 40000, description = {}, model = "kuruma"},
				{name = "Locust", costs = 750000, description = {}, model = "locust"},
				{name = "Lynx", costs = 125000, description = {}, model = "lynx"},
				{name = "Massacro", costs = 165000, description = {}, model = "massacro"},
				{name = "Neon", costs =100000, description = {}, model = "neon"},
				{name = "Omnis", costs = 58000, description = {}, model = "omnis"},
				{name = "Pariah", costs = 79000, description = {}, model = "pariah"},
				{name = "Penumbra", costs = 15000, description = {}, model = "penumbra"},
				{name = "Raiden", costs = 40000, description = {}, model = "raiden"},
				{name = "Rapid GT", costs = 40000, description = {}, model = "rapidgt"},
				{name = "Rapid GT Convertible", costs = 60000, description = {}, model = "rapidgt2"},
				{name = "Raptor 3-Wheeler", costs = 40000, description = {}, model = "raptor"},
				{name = "Schafter V12", costs = 50000, description = {}, model = "schafter3"},
				{name = "Sentinel Classic", costs = 48000, description = {}, model = "sentinel3"},
				{name = "Seven 70", costs =90000, description = {}, model = "seven70"},
				{name = "Specter", costs = 100000, description = {}, model = "specter"},
				{name = "Specter Custom", costs = 150000, description = {}, model = "specter2"},
				{name = "Streiter", costs = 75000, description = {}, model = "streiter"},
				{name = "Sultan", costs = 38000, description = {}, model = "sultan"},
				{name = "Sultan RS", costs = 100000, description = {}, model = "sultanrs"},
				{name = "Surano", costs = 78000, description = {}, model = "surano"},
				{name = "Tropos", costs = 90000, description = {}, model = "tropos"},
				{name = "Verkierer", costs = 74000, description = {}, model = "verlierer2"},
				{name = "Ruston", costs =80000, description = {}, model = "ruston"},
			}
		},
		["Sport Classics"] = {
			title = "Sport Classics",
			name = "Sport Classics",
			buttons = {
				{name = "190z", costs = 115000, description = {}, model = "z190"},
				{name = "Casco", costs = 250000, description = {}, model = "casco"},
				{name = "Cheeta Classic ", costs =230000, description = {}, model = "cheetah2"},
				{name = "Coquette Classic", costs = 60000, description = {}, model = "coquette2"},
				{name = "GT500", costs = 140000, description = {}, model = "gt500"},
				{name = "JB 700", costs = 55000, description = {}, model = "jb700"},
				{name = "Mamba", costs =175000, description = {}, model = "mamba"},
				{name = "Pigalle", costs = 10000, description = {}, model = "pigalle"},
				{name = "Savestra", costs = 125000, description = {}, model = "savestra"},
				{name = "Stinger", costs = 200000, description = {}, model = "stinger"},
				{name = "Stinger GT", costs = 235000, description = {}, model = "stingergt"},
				{name = "Stirling GT", costs = 100000, description = {}, model = "feltzer3"},
				{name = "Rapid GT Classic", costs = 45000, description = {}, model = "rapidgt3"},
				{name = "Retinue", costs = 65000, description = {}, model = "retinue"},
				{name = "Retinue Custom", costs = 80000, description = {}, model = "retinue2"},
				{name = "Viseris", costs = 128000, description = {}, model = "viseris"}, 
				{name = "Roosevelt", costs =200000 , description = {}, model = "btype"},
				{name = "Roosevelt Luxury", costs =280000 , description = {}, model = "btype3"},
				{name = "Turismo Classic", costs =230000 , description = {}, model = "turismo2"},
				{name = "Z-type", costs =175000 , description = {}, model = "ztype"},
			}
		},
		["Custom Imports"] = {
			title = "Custom Imports",
			name = "Custom Imports",
			buttons = {
				 {name = "Audi RS7", costs = 125000, description = {}, model = "rs7"},
				 {name = "Audi R8 V10", costs = 425000, description = {}, model = "r8v10"},
				 {name = "Audi R8 Liberty Walk", costs = 595000, description = {}, model = "ar8lb"},
				 {name = "AMG GTR", costs = 400000, description = {}, model = "gtrc"},
				 {name = "AMG E63", costs = 250000, description = {}, model = "e63amg"},
				 {name = "AMG E63 Liberty Walk", costs = 400000, description = {}, model = "63lb"},
				 {name = "Audi RS6", costs = 350000, description = {}, model = "audirs6tk"},
				 {name = "BMW E36", costs = 225000, description = {}, model = "e36prb"},
				 {name = "BMW E46", costs = 350000, description = {}, model = "e46"},
				 {name = "BMW I8", costs = 325000, description = {}, model = "acs8"},
				 {name = "BMW E60", costs = 325000, description = {}, model = "m5e60"},
				 {name = "BMW M3 E46", costs = 390000, description = {}, model = "m3e46"},
				 {name = "BMW E92 Liberty Walk", costs = 300000, description = {}, model = "e92lb"},
				 {name = "BMW M4", costs = 400000, description = {}, model = "m4"},
				 {name = "Bentley Continental", costs = 290000, description = {}, model = "contss18"},
				 {name = "Bentley Dragon", costs = 325000, description = {}, model = "bdragon"},
				 {name = "Corvette C7", costs = 345000, description = {}, model = "c7"},
				 {name = "Charger 69", costs = 325000, description = {}, model = "69charger"},
				 {name = "Camaro SS", costs = 325000, description = {}, model = "camaro_ss"},
				 {name = "Camaro Exorcist", costs = 325000, description = {}, model = "exor"},
				 {name = "Camaro Z28", costs = 265000, description = {}, model = "z2879"},
				 {name = "Camaro ZL1", costs = 375000, description = {}, model = "czl1"},
				 {name = "Comet 6STR", costs = 200000, description = {}, model = "comet6str"},
				 {name = "Del Sol EG", costs = 50000, description = {}, model = "delsoleg"},
				 {name = "Datsun 510", costs = 330000, description = {}, model = "510"},
				 {name = "Escalade", costs = 350000, description = {}, model = "esv"},
				 {name = "Ellie 6STR", costs = 475000, description = {}, model = "ellie6str"},
				 {name = "Ford Mustang 66", costs = 275000, description = {}, model = "66fastback"},
				 {name = "Ford Mustang 2019", costs = 250000, description = {}, model = "mustang19"},
				 {name = "Ford Mustang WideBody", costs = 325000, description = {}, model = "rmodmustang"},
				 {name = "Ford Focus RS", costs = 300000, description = {}, model = "focusrs"},
				 {name = "Ford F150", costs = 200000, description = {}, model = "f150"},
				 {name = "Ferrari Enzo", costs = 457000, description = {}, model = "mig"},
				 {name = "Ferrari LaFerrari", costs = 485000, description = {}, model = "laferrari17"},
				 {name = "Futo 6STR", costs = 200000, description = {}, model = "futo2"},
				 {name = "Gauntlet 6STR", costs = 225000, description = {}, model = "gauntlet6str"},
				 {name = "Harley", costs = 95500, description = {}, model = "rudiharley"},
				 {name = "Honda NSX", costs = 135000, description = {}, model = "na1"},
				 {name = "Honda S2000", costs = 150000, description = {}, model = "ap2"},
				 {name = "Honda Integra", costs = 150000, description = {}, model = "dc5"},
				 {name = "Honda NSX 2016", costs = 300000, description = {}, model = "filthynsx"},
				 {name = "Honda Civic TypeR", costs = 275000, description = {}, model = "fk8"},
				 {name = "HoldenSV", costs = 125000, description = {}, model = "bluecunt"},
				 {name = "Hemi Cuda", costs = 325000, description = {}, model = "hemicuda"},
				 {name = "Hellion V2", costs = 190000, description = {}, model = "hellion6str"},
				 {name = "Jeep Grand Cheroke", costs = 329000, description = {}, model = "srt8b"},
				 {name = "Kawasaki ZX10", costs = 120000, description = {}, model = "zx10"},
				 {name = "Lamborghini Aventador", costs = 475000, description = {}, model = "lp700r"},
				 {name = "Lamborghini Diablo", costs = 300000, description = {}, model = "500gtrlam"},
				 {name = "Lamborghini Murcielago", costs = 295000, description = {}, model = "lp670"},
				 {name = "Lamborghini Murcielago WideBody", costs = 355000, description = {}, model = "lwlp670"},
				 {name = "Lexus RCF", costs = 325000, description = {}, model = "rcf"},
				 {name = "LadyBird 6STR", costs = 475000, description = {}, model = "ladybird6str"},
				 {name = "Mazda RocketBunny RX7", costs = 175000, description = {}, model = "rx7rb"},
				 {name = "Mazda RX7", costs = 75000, description = {}, model = "fnfrx7"},
				 {name = "Mazda RX7 FC", costs = 195000, description = {}, model = "fc3s"},
				 {name = "Mazda Miata", costs = 150000, description = {}, model = "na6"},
				 {name = "McLaren P1", costs = 800000, description = {}, model = "p1"},
				 {name = "McLaren 650", costs = 625000, description = {}, model = "650slw"},
				 {name = "Maserati Gran Turismo", costs = 395000, description = {}, model = "granlb"},
				 {name = "Mitsubishi Evo6", costs = 325000, description = {}, model = "cp9a"},
				 {name = "Mitsubishi Evo9", costs = 245000, description = {}, model = "evo9"},
				 {name = "Mitsubishi Evo10", costs = 135000, description = {}, model = "evo10"},
				 {name = "Mitsubishi Eclipse", costs = 125000, description = {}, model = "eclipse"},
				 {name = "Mercedes C63 AMG", costs = 290000, description = {}, model = "c63"},
				 {name = "Mercedes G65 AMG", costs = 125000, description = {}, model = "g65amg"},
				 {name = "Mercedes GT63", costs = 390000, description = {}, model = "gt63"},
				 {name = "Mercedes 124", costs = 325000, description = {}, model = "mbw124"},
				 {name = "Nissan LibertyWalk GTR", costs = 700000, description = {}, model = "lwgtr"},
				 {name = "Nissan LibertyWalk GTR 2", costs = 500000, description = {}, model = "lwgtr2"},
				 {name = "Nissan RHD GTR", costs = 328000, description = {}, model = "r35"},
				 {name = "Nissan GTR", costs = 325000, description = {}, model = "gtr"},
				 {name = "Nissan S13", costs = 255000, description = {}, model = "nis13"},
				 {name = "Nissan R34 4 Door", costs = 227000, description = {}, model = "er34"},
				 {name = "Nissan R34", costs = 200000, description = {}, model = "skyline"},
				 {name = "Nissan S15", costs = 350000, description = {}, model = "s15rb"},
				 {name = "Nissan 300zw", costs = 425000, description = {}, model = "300zw"},
				 {name = "Nissan 300zx", costs = 165000, description = {}, model = "z32"},
				 {name = "Nissan 370z", costs = 250000, description = {}, model = "370z"},
				 {name = "Porsche 911", costs = 375000, description = {}, model = "por930"},
				 {name = "Porsche 911 Turbo S", costs = 325000, description = {}, model = "911turbos"},
				 {name = "Porsche 911 Rocket Bunny", costs = 245000, description = {}, model = "911rwb"},
				 {name = "Porsche 911 Rocket Bunny 2", costs = 255000, description = {}, model = "gt2rwb"},
				 {name = "Porsche GT3 RS", costs = 380000, description = {}, model = "gt3rs"},
				 {name = "Porsche Panamera", costs = 400000, description = {}, model = "panamera17turbo"},
				 {name = "Porsche 918 Spyder", costs = 375000, description = {}, model = "918"},
				 {name = "Pagani Zonda R", costs = 497000, description = {}, model = "zondar"},
				 {name = "Ruiner 6STR", costs = 235000, description = {}, model = "ruiner6str"},
				 {name = "Regera", costs = 10000000, description = {}, model = "regera"},
				 {name = "Rolls Royce Wraith", costs = 425000, description = {}, model = "wraith"},
				 {name = "Subaru STI WRX", costs = 125000, description = {}, model = "subwrx"},
				 {name = "Sentinel 6STR", costs = 200000, description = {}, model = "sentinel6str"},
				 {name = "Sentinel 6STR 2", costs = 350000, description = {}, model = "sentinel6str2"},
				 {name = "Schwartzer 6STR ", costs = 225000, description = {}, model = "schwarzer2"},
				 {name = "Stratum 6STR", costs = 210500, description = {}, model = "stratumc"},
				 {name = "Sultan RS MK2", costs = 245000, description = {}, model = "sultanrsv8"},
				 {name = "Tempesta 6STR", costs = 490000, description = {}, model = "tempesta2"},
				 {name = "Toyota Supra", costs = 345000, description = {}, model = "a80"},
				 {name = "Tampa V3", costs = 210000, description = {}, model = "tampa5"},
				 {name = "Volkswagen Golf", costs = 150000, description = {}, model = "golfp"},
				 {name = "Yamaha R1", costs = 125000, description = {}, model = "r1"},
				 {name = "Yosemite 6STR", costs = 195000, description = {}, model = "yosemite6str"},
				 {name = "ZR380", costs = 145000, description = {}, model = "zr3806str"},		 		
			}
		},
		["Diamond Casino"] = {
			title = "Diamond Casino",
			name = "Diamond Casino",
			buttons = {
				{name = "Asbo", costs = 9895, description = {}, model = "asbo"},
				{name = "Blista Kanjo", costs = 22000, description = {}, model = "kanjo"},
				{name = "Caracara", costs = 80000, description = {}, model = "caracara2"},
				{name = "9F Drafter", costs = 100000, description = {}, model = "drafter"},
				{name = "Drift Yosemite", costs =45000, description = {}, model = "yosemite2"},
				{name = "Dynasty", costs = 60000, description = {}, model = "Dynasty"},
				{name = "Everon", costs = 50000 , description = {}, model = "everon"},
				{name = "FF Penumbra", costs = 40000, description = {}, model = "penumbra2"},
				{name = "Gauntlet Classic", costs = 40000, description = {}, model = "gauntlet3"},
				{name = "Gauntlet Hellfire", costs = 75000, description = {}, model = "gauntlet4"},
				{name = "Glendale Lux", costs = 30000 , description = {}, model ="glendale2"},
				{name = "Hellion", costs = 35000, description = {}, model = "hellion"},
				{name = "Imorgon", costs = 70000, description = {}, model = "Imorgon"},
				{name = "Issi Sport", costs = 50000, description = {}, model = "issi7"},
				{name = "Jugular", costs = 50000, description = {}, model = "jugular"},
				{name = "Komoda", costs = 120000, description = {}, model = "komoda"},
				{name = "Nebula", costs = 63000, description = {}, model = "nebula"},
				{name = "Novak", costs = 62000, description = {}, model = "Novak"},
				{name = "Outlaw", costs = 60000, description = {}, model = "outlaw"},
				{name = "Paragon", costs = 75000, description = {}, model = "paragon"},
				{name = "Peyote Gasser", costs = 75000, description = {}, model = "peyote2"},
				{name = "Rebla", costs = 50000, description = {}, model = "rebla"},
				{name = "Sugoi", costs = 40000, description = {}, model = "sugoi"},
				{name = "Sultan Classic", costs = 55000, description = {}, model = "sultan2"},
				{name = "Vagrant", costs = 60000, description = {}, model = "vagrant"},
				{name = "V-STR", costs = 120000, description = {}, model = "vstr"},
				{name = "Youga 4x4", costs = 33000 , description = {}, model = "youga3"},
				{name = "Zion Classic", costs = 35000, description = {}, model = "zion3"},
			}
		},
		["Cayo Perico"] = {
			title = "Cayo Perico",
			name = "Cayo Perico",
			buttons = {
				{name = "Brioso 300", costs = 11000, description = {}, model = "brioso2"},
				{name = "Club", costs = 20000 , description = {}, model = "club"},
				{name = "Itali RSX", costs = 750000, description = {}, model = "italirsx"},
				{name = "Mammoth Squaddie", costs = 36000 , description = {}, model = "squaddie"},
				{name = "Manchez Scout", costs = 10000 , description = {}, model = "manchez2"},
				{name = "SlamTruck", costs = 36000 , description = {}, model = "slamtruck"},
				{name = "Stryder", costs = 25000 , description = {}, model = "stryder"},
				{name = "Veto Classic", costs = 10000 , description = {}, model = "veto"},
				{name = "Veto Modern", costs = 30000 , description = {}, model = "veto2"},
				{name = "Vetir", costs = 20000 , description = {}, model = "vetir"},
				{name = "Verus", costs = 12000 , description = {}, model = "verus"},
				{name = "Weevil", costs = 10000 , description = {}, model = "weevil"},
				{name = "Winky", costs = 16000 , description = {}, model = "winky"},
			}
		},		
		["Muscle"] = {
			title = "Muscle",
			name = "Muscle",
			buttons = {
				{name = "Blade", costs = 22000, description = {}, model = "blade"},
				{name = "Buccaneer", costs = 24000, description = {}, model = "buccaneer"},
				{name = "Chino", costs = 26000, description = {}, model = "chino"},
				{name = "Coquette BlackFin", costs = 115000, description = {}, model = "coquette3"},
				{name = "Deviant", costs = 50000, description = {}, model = "deviant"},
				{name = "Dominator", costs = 40000, description = {}, model = "dominator"},
				{name = "Dominator GTX", costs =65000, description = {}, model = "dominator3"},
				{name = "Dukes", costs = 45000, description = {}, model = "dukes"},
				{name = "Dukes Beater", costs =22000, description = {}, model = "dukes3"},
				{name = "Elliie", costs = 65000, description = {}, model = "ellie"},
				{name = "Faction", costs = 36000, description = {}, model = "faction"},
				{name = "Gang Slam Van", costs = 19500, description = {}, model = "slamvan2"},
				{name = "Gauntlet", costs = 36000, description = {}, model = "gauntlet"},
				{name = "Hermes", costs = 200000, description = {}, model = "hermes"},
				{name = "Picador", costs = 10000, description = {}, model = "picador"},
				{name = "Phoenix", costs = 34000, description = {}, model = "phoenix"},
				{name = "Rat Loader", costs = 19500, description = {}, model = "ratloader2"},
				{name = "Ruiner", costs =20000, description = {}, model = "ruiner"},
				{name = "Sabre Turbo", costs = 24000, description = {}, model = "sabregt"},
				{name = "Slam Van", costs = 19500, description = {}, model = "slamvan"},
				{name = "Tampa", costs = 34000, description = {}, model = "tampa"},
				{name = "Tulip", costs = 55000, description = {}, model = "tulip"},
				{name = "Vamos", costs = 65000, description = {}, model = "vamos"},
				{name = "Virgo", costs = 22000, description = {}, model = "virgo"},
				{name = "Vigero", costs = 23000, description = {}, model = "vigero"},
				{name = "Nightshade", costs =33000, description = {}, model = "nightshade"},
				{name = "Yosemite", costs = 45000, description = {}, model = "yosemite"},
			}
		},
		["Off-Road"] = {
			title = "Off-Road",
			name = "Off-Road",
			buttons = {
				{name = "Bodhi", costs = 5000, description = {}, model = "bodhi2"},	
				{name = "Bifta", costs = 15000, description = {}, model = "bifta"},
				{name = "Blazer", costs = 7000, description = {}, model = "blazer"},
				{name = "Blazer Street", costs = 9000, description = {}, model = "blazer4"},
				{name = "Brawler", costs = 40000, description = {}, model = "brawler"},
				{name = "Desert Raid", costs =55000, description = {}, model = "trophytruck2"},
				{name = "Dubsta 6x6", costs = 95000, description = {}, model = "dubsta3"},
				{name = "Dune Buggy", costs = 10000, description = {}, model = "dune"},
				{name = "Free Crawler", costs = 70000, description = {}, model = "freecrawler"},
				{name = "Guardian", costs = 75000, description = {}, model = "guardian"},
				{name = "Kalahari", costs = 5000, description = {}, model = "kalahari"},
				{name = "Kamacho", costs = 90000, description = {}, model = "kamacho"},
				{name = "Lifted Mesa", costs = 45000, description = {}, model = "mesa3"},
				{name = "Lifted Yosemite", costs =40000 , description = {}, model = "yosemite3"},
				{name = "Riata", costs = 45000, description = {}, model = "riata"},
				{name = "Rebel", costs = 45000, description = {}, model = "rebel2"},
				{name = "Sandking", costs = 70000, description = {}, model = "sandking"},
				{name = "Trophy Truck", costs =35000, description = {}, model = "trophytruck"},
			}
		},
		["Suvs"] = {
			title = "Suvs",
			name = "Suvs",
			buttons = {
				{name = "Baller", costs =55000 , description = {}, model = "baller2"},
				{name = "Baller LE", costs =60000 , description = {}, model = "baller3"},
				{name = "Baller LE LWB", costs =65000 , description = {}, model = "baller4"},
				{name = "Cavalcade", costs = 30000, description = {}, model = "cavalcade2"},
				{name = "Dubsta", costs = 80000, description = {}, model = "dubsta"},
				{name = "Dubsta Luxury", costs = 120000, description = {}, model = "dubsta2"},
				{name = "Granger", costs = 26000, description = {}, model = "granger"},
				{name = "Gresley", costs = 25000, description = {}, model = "gresley"},
				{name = "Huntley S", costs = 145000, description = {}, model = "huntley"},
				{name = "Landstalker", costs = 40000, description = {}, model = "landstalker"},
				{name = "Landstalker XL", costs = 40000, description = {}, model = "landstalker2"},
				{name = "Mesa", costs = 12000, description = {}, model = "mesa"},
				{name = "Patriot", costs = 40000, description = {}, model = "patriot"},
				{name = "Radius", costs = 16000, description = {}, model = "radi"},
				{name = "Rocoto", costs = 24000, description = {}, model = "rocoto"},
				{name = "Seminole", costs = 10500, description = {}, model = "seminole"},
				{name = "Rocoto", costs = 42500, description = {}, model = "rocoto"},
				{name = "Toros", costs = 110000, description = {}, model = "toros"},
				{name = "XLS", costs = 56000, description = {}, model = "xls"},
			}
		},
		["Vans"] = {
			title = "Vans",
			name = "Vans",
			buttons = {
				{name = "Bison", costs = 30000, description = {}, model = "bison"},
				{name = "Bobcat XL", costs = 15000, description = {}, model = "bobcatxl"},
				{name = "Camper", costs = 34500, description = {}, model = "camper"},
				{name = "Clown van", costs = 20000, description = {}, model = "speedo2"},
				{name = "Gang Burrito", costs = 15000, description = {}, model = "gburrito"},
				{name = "Journey", costs = 10000, description = {}, model = "journey"},
				{name = "Minivan", costs = 65000, description = {}, model = "minivan"},
				{name = "Moonbeam", costs = 12500, description = {}, model = "moonbeam"},
				{name = "Paradise", costs = 22000, description = {}, model = "paradise"},
				{name = "Surfer", costs = 9500, description = {}, model = "surfer"},
				{name = "Youga", costs = 14500, description = {}, model = "youga"},
				{name = "Youga Classic", costs = 14500, description = {}, model = "youga2"},
			}
		},
		["Sedans"] = {
			title = "Sedans",
			name = "Sedans",
			buttons = {
				{name = "Asea", costs = 9500, description = {}, model = "asea"},
				{name = "Asterope", costs = 10000, description = {}, model = "asterope"},
				{name = "Cheburek", costs = 32000, description = {}, model = "cheburek"},
				{name = "Cognoscenti", costs = 30000, description = {}, model = "cognoscenti"},
				{name = "Cognoscenti 55", costs = 35000, description = {}, model = "cog55"},
				{name = "Dynasty", costs = 7500, description = {}, model = "Dynasty"},
				{name = "Emperor", costs = 7000, description = {}, model = "emperor2"},
				{name = "Fugitive", costs = 30000, description = {}, model = "fugitive"},
				{name = "Glendale", costs = 7500, description = {}, model = "glendale"},
				{name = "Intruder", costs = 25000, description = {}, model = "intruder"},
				{name = "Premier", costs = 9000, description = {}, model = "premier"},
				{name = "Regina", costs = 32000, description = {}, model = "regina"},
				{name = "Schafter", costs = 45000, description = {}, model = "schafter2"},
				{name = "Stafford", costs = 60000, description = {}, model = "stafford"},
				{name = "Stanier", costs = 10000, description = {}, model = "stanier"},
				{name = "Stratum", costs =90000, description = {}, model = "stratum"},
				{name = "Stretch Limo", costs = 25000, description = {}, model = "stretch"},
				{name = "Super Diamond", costs = 50000, description = {}, model = "superd"},
				{name = "Surge", costs =25000 , description = {}, model = "surge"},
				{name = "Tornado", costs = 9000, description = {}, model = "tornado3"},	
				{name = "Tailgater", costs = 87500, description = {}, model = "tailgater"},
				{name = "Warrener", costs = 85000, description = {}, model = "warrener"},
				{name = "Washington", costs = 18000, description = {}, model = "washington"},

			}
		},
		["Motorcycles"] = {
			title = "Motorcycles",
			name = "Motorcycles",
			buttons = {		
				{name = "Akuma", costs = 20000, description = {}, model = "AKUMA"},
				{name = "Avarus", costs = 26000, description = {}, model = "avarus"},
				{name = "Bagger", costs = 14000, description = {}, model = "bagger"},
				{name = "Bati 801", costs = 32000, description = {}, model = "bati"},
				{name = "BF400", costs = 13000, description = {}, model = "bf400"},
				{name = "Carbon RS", costs = 22000, description = {}, model = "carbonrs"},
				{name = "Chimera", costs = 32000, description = {}, model = "chimera"},
				{name = "Daemon", costs = 16000, description = {}, model = "daemon"},
				{name = "DaemonHigh", costs = 24000, description = {}, model = "daemon2"},
				{name = "Defiler", costs = 26000, description = {}, model = "defiler"},
				{name = "Enduro", costs = 8000, description = {}, model = "enduro"},
				{name = "Esskey", costs = 11000, description = {}, model = "esskey"},
				{name = "Faggio", costs = 3500, description = {}, model = "faggio"},
				{name = "Gargoyle", costs = 30000, description = {}, model = "gargoyle"},
				{name = "Hexer", costs = 45000, description = {}, model = "hexer"},
				{name = "Innovation", costs = 18000, description = {}, model = "innovation"},
				{name = "Manchez", costs = 12000, description = {}, model = "manchez"},
				{name = "Nemesis", costs = 16000, description = {}, model = "nemesis"},
				{name = "Nightblade", costs = 21000 , description = {}, model ="nightblade"},
				{name = "PCJ-600", costs = 11000, description = {}, model = "pcj"},
				{name = "Ruffian", costs = 19000, description = {}, model = "ruffian"}, 
				{name = "Sanchez", costs = 8000, description = {}, model = "sanchez"},
				{name = "Sovereign", costs = 29000, description = {}, model = "sovereign"},
				{name = "Vespa", costs = 4995, description = {}, model = "faggio2"},
				{name = "Vortex", costs = 38000, description = {}, model = "vortex"},
				{name = "Vader", costs = 9800, description = {}, model = "vader"},
				{name = "Wolfsbane", costs = 19000 , description = {}, model = "wolfsbane"},
				{name = "Zombiea", costs = 30000, description = {}, model = "zombiea"},
			}
		},
		["cycles"] = {
			title = "cycles",
			name = "cycles",
			buttons = {
				{name = "BMX", costs = 150, description = {}, model = "bmx"},
				{name = "Caddy", costs = 5000, description = {}, model = "caddy"},
				{name = "Old Caddy", costs = 3000, description = {}, model = "caddy2"},
				{name = "Cruiser", costs = 240, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 270, description = {}, model = "fixter"},
				{name = "Scorcher", costs = 300, description = {}, model = "scorcher"},
				{name = "Pro 1", costs = 2500, description = {}, model = "tribike"},
				{name = "Pro 2", costs = 2600, description = {}, model = "tribike2"},
				{name = "Pro 3", costs = 2900, description = {}, model = "tribike3"},
			}
		},
		["Lowriders"] = {
			title = "Lowriders",
			name = "Lowriders",
			buttons = {
				{name = "Buccaneer Lux", costs = 33000, description = {}, model = "buccaneer2"},
				{name = "Chino Lux", costs = 34000, description = {}, model = "chino2"},
				{name = "Faction Lux", costs = 31000, description = {}, model = "faction2"},
				{name = "Manana Lux", costs = 35000, description = {}, model = "manana2"},
				{name = "Minivan Lux", costs = 26000, description = {}, model = "minivan2"},
				{name = "Moonbeam Lux", costs = 32500, description = {}, model = "moonbeam2"},
				{name = "Primo Lux", costs = 30000, description = {}, model = "primo2"},
				{name = "Sabre Lux", costs = 24000, description = {}, model = "sabregt2"},
				{name = "Slamvan Lux", costs = 32500, description = {}, model = "slamvan3"},
				{name = "Voodoo Lux", costs = 33000, description = {}, model = "voodoo"},
			}
		},

	}
}




local fakecar = {model = '', car = nil}
local vehshop_locations = {
	{
		entering = {-33.737,-1102.322,26.422},
		inside = {-61.166320800781,-1107.8854980469,26.43579864502,76.141090393066},
		outside = {-61.166320800781,-1107.8854980469,26.43579864502,76.141090393066},
	}
}

local carspawns = {
	[1] =  { ['x'] = -38.25,['y'] = -1104.18,['z'] = 26.43,['h'] = 14.46, ['info'] = ' Car Spot 1' },
	[2] =  { ['x'] = -36.36,['y'] = -1097.3,['z'] = 26.43,['h'] = 109.4, ['info'] = ' Car Spot 2' },
	[3] =  { ['x'] = -43.11,['y'] = -1095.02,['z'] = 26.43,['h'] = 67.77, ['info'] = ' Car Spot 3' },
	[4] =  { ['x'] = -50.45,['y'] = -1092.66,['z'] = 26.43,['h'] = 116.33, ['info'] = ' Car Spot 4' },
	[5] =  { ['x'] = -56.24,['y'] = -1094.33,['z'] = 26.43,['h'] = 157.08, ['info'] = ' Car Spot 5' },
	[6] =  { ['x'] = -49.73,['y'] = -1098.63,['z'] = 26.43,['h'] = 240.99, ['info'] = ' Car Spot 6' },
	[7] =  { ['x'] = -45.58,['y'] = -1101.4,['z'] = 26.43,['h'] = 287.3, ['info'] = ' Car Spot 7' },
}

local carTable = {
	[1] = { ["model"] = "gauntlet", ["baseprice"] = 36000, ["commission"] = 15 }, 
	[2] = { ["model"] = "dubsta3", ["baseprice"] = 95000, ["commission"] = 15 },
	[3] = { ["model"] = "landstalker", ["baseprice"] = 40000, ["commission"] = 15 },
	[4] = { ["model"] = "bobcatxl", ["baseprice"] = 15000, ["commission"] = 15 },
	[5] = { ["model"] = "surfer", ["baseprice"] = 9500, ["commission"] = 15 },
	[6] = { ["model"] = "glendale", ["baseprice"] = 7500, ["commission"] = 15 },
	[7] = { ["model"] = "washington", ["baseprice"] = 18000, ["commission"] = 15 },
}

function updateCarTable(model,price,name)
	carTable[currentCarSpawnLocation]["model"] = model
	carTable[currentCarSpawnLocation]["baseprice"] = price
	carTable[currentCarSpawnLocation]["name"] = name
	TriggerServerEvent("carshop:table",carTable)
end

local myspawnedvehs = {}

RegisterNetEvent("car:testdrive")
AddEventHandler("car:testdrive", function()

	local pData = RLCore.Functions.GetPlayerData()
	if pData.job.name ~= 'cardealer' or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		RLCore.Functions.Notify("Could not locate vehicle!",'error')
		return
	end

	local model = GetEntityModel(veh)
	local veh = GetClosestVehicle(-51.51, -1077.96, 26.92, 3.000, 0, 70)

	if not DoesEntityExist(veh) then

		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model,-51.51, -1077.96, 26.92,80.0,true,false)
		local vehplate = "CAR"..math.random(10000,99999)
		SetVehicleNumberPlateText(veh, vehplate)
		local plate = GetVehicleNumberPlateText(veh, vehplate)
		Citizen.Wait(100)
		TriggerServerEvent('garage:addKeys', vehplate)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)

		TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())), GetVehiclePedIsIn(PlayerPedId()))
		Citizen.Wait(350)
		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())), GetVehiclePedIsIn(PlayerPedId()))
		Citizen.Wait(350)
		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())), GetVehiclePedIsIn(PlayerPedId()))
		myspawnedvehs[veh] = true
	else
		RLCore.Functions.Notify("A car is on the spawn point.",'error')
	end
end)

RegisterNetEvent("finance")
AddEventHandler("finance", function()
	if #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		RLCore.Functions.Notify("Could not locate vehicle",'error')
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)
	TriggerServerEvent("finance:enable",vehplate)
end)

RegisterNetEvent("buyEnable")
AddEventHandler("buyEnable", function()
	local pData = RLCore.Functions.GetPlayerData()
	if #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 and pData.job.name == 'cardealer' then
		return
	end

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		RLCore.Functions.Notify("Could not locate vehicle",'error')
		return
	end
	local vehplate = GetVehicleNumberPlateText(veh)
	TriggerServerEvent("buy:enable",vehplate)
end)

RegisterNetEvent("finance:enableOnClient")
AddEventHandler("finance:enableOnClient", function(addplate)
	financedPlates[addplate] = true
	Citizen.Wait(60000)
	financedPlates[addplate] = nil
end)

RegisterNetEvent("buy:enableOnClient")
AddEventHandler("buy:enableOnClient", function(addplate)
	buyPlate[addplate] = true
	Citizen.Wait(60000)
	buyPlate[addplate] = nil
end)

RegisterNetEvent("commission")
AddEventHandler("commission", function(newAmount)
	local pData = RLCore.Functions.GetPlayerData()
	if pData.job.name ~= 'cardealer' or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
	end

	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			carTable[i]["commission"] = tonumber(newAmount)
			TriggerServerEvent("carshop:table",carTable)

		end
	end
end)

RegisterNetEvent("veh_shop:returnTable")
AddEventHandler("veh_shop:returnTable", function(newTable)
	carTable = newTable
	DespawnSaleVehicles()
	SpawnSaleVehicles()
end)

local hasspawned = false
local spawnedvehicles = {}
local vehicles_spawned = false

function BuyMenu()
	for i = 1, #carspawns do

		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
				ClearPedTasksImmediately(PlayerPedId())
			end
			DisableControlAction(0,23)
			if IsControlJustReleased(0,47) and buyPlate[addplate] ~= nil then
				RLCore.Functions.Notify("Attempting purchase",'inform')
				AttemptBuy(i,false)
			end

			if IsControlJustReleased(0,23) or IsDisabledControlJustReleased(0,23) then
				if financedPlates[addplate] ~= nil then
					RLCore.Functions.Notify("Attempting purchase",'inform')
					AttemptBuy(i,true)
				end
			end
		end
	end
end

function AttemptBuy(tableid,financed)

	local veh = GetClosestVehicle(carspawns[tableid]["x"],carspawns[tableid]["y"],carspawns[tableid]["z"], 3.000, 0, 70)
	if not DoesEntityExist(veh) then
		RLCore.Functions.Notify("Could not locate vehicle",'error')
		return
	end

	if financed then
--		print("financed")
	end

	local model = carTable[tableid]["model"]
	local commission = carTable[tableid]["commission"]
	local baseprice = carTable[tableid]["baseprice"]
	local name = carTable[tableid]["name"]
	local price = baseprice + (baseprice * commission/ 100)

	currentlocation = vehshop_blips[1]
	TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
	TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())), GetVehiclePedIsIn(PlayerPedId()))
	TriggerServerEvent('CheckMoneyForVeh',name, model, price, financed)
	commissionbuy = (baseprice * commission / 200)
end

function OwnerMenu()
	if not vehshop.opened then
		currentCarSpawnLocation = 0
		ownerMenu = false
	end
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			ownerMenu = true
			currentCarSpawnLocation = i
			if IsControlJustReleased(0,38) then
				RLCore.Functions.Notify("We Opened",'inform')
				if vehshop.opened then
					CloseCreator()
				else
					OpenCreator()
				end
			end
		end
	end
end

function DrawPrices()
	for i = 1, #carspawns do
		if #(vector3(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.5 then
			local commission = carTable[i]["commission"]
			local baseprice = carTable[i]["baseprice"]
			local price = baseprice + (baseprice * commission/100)
			local pData = RLCore.Functions.GetPlayerData() 
			local veh = GetClosestVehicle(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], 3.000, 0, 70)
			local addplate = GetVehicleNumberPlateText(veh)
			if pData.job.name == 'cardealer' then
				if financedPlates[addplate] ~= nil and buyPlate[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy | [F] to Finance ")
				elseif financedPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], "$" .. math.ceil(price/4) .. " upfront, $" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [F] to Finance ")
				elseif buyPlate[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change | [G] to buy. ")
				else
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " | Com: %" ..commission.. " | [E] to change")
				end
			else
				if financedPlates[addplate] ~= nil and buyPlate[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " [G] to buy | $" .. math.ceil(price/4) .. " upfront, $" .. math.ceil(price) .. " over 10 weeks, [F] to finance. ")
				elseif financedPlates[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"], "$" .. math.ceil(price/4) .. " upfront, $" .. math.ceil(price) .. " over 10 weeks, [F] to finance. ")
				elseif buyPlate[addplate] ~= nil then
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"$" .. math.ceil(price) .. " [G] to buy. ")
				else
					DrawText3D(carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"],"Buy Price: $" .. math.ceil(price) .. " ")
				end
			end
		end
	end
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function SpawnSaleVehicles()
	if not hasspawned then
		TriggerServerEvent("carshop:requesttable")
--		print("requesting table")
		Citizen.Wait(1500)
	end
	DespawnSaleVehicles()
	hasspawned = true
	for i = 1, #carTable do
		local model = GetHashKey(carTable[i]["model"])
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		local veh = CreateVehicle(model,carspawns[i]["x"],carspawns[i]["y"],carspawns[i]["z"]-1,carspawns[i]["h"],false,false)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)
		SetEntityInvincible(veh,true)

		FreezeEntityPosition(veh,true)
		spawnedvehicles[#spawnedvehicles+1] = veh
		SetVehicleNumberPlateText(veh, "PDM ".. i)
	end
	vehicles_spawned = true
end

function DespawnSaleVehicles()
	for i = 1, #spawnedvehicles do
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(spawnedvehicles[i]))
	end
	vehicles_spawned = false
end

Controlkey = {["generalUse"] = {38,"E"},["generalUseSecondary"] = {191,"Enter"}}
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
	Controlkey["generalUse"] = table["generalUse"]
	Controlkey["generalUseSecondary"] = table["generalUseSecondary"]
end)

--[[Functions]]--

function LocalPed()
	return PlayerPedId()
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function IsPlayerInRangeOfVehshop()
	return inrangeofvehshop
end

function ShowVehshopBlips(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,326)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Vehicle Shop')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, 3)
			vehshop_blips[#vehshop_blips+1]= {blip = blip, pos = loc}
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(1)
				local inrange = false

				if #(vector3(-45.98,-1082.97, 26.27) - GetEntityCoords(LocalPed())) < 5.0 then
					local veh = GetVehiclePedIsUsing(LocalPed())
					if myspawnedvehs[veh] ~= nil then
						DrawText3D(-45.98,-1082.97, 26.27,"["..Controlkey["generalUse"][2].."] return vehicle")
						if IsControlJustReleased(0,Controlkey["generalUse"][1]) then
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
						end
					end
				end

				for i,b in ipairs(vehshop_blips) do
					if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 100 then
						currentlocation = b
						if not vehicles_spawned then
--							print("Spawning Display Vehicles?")
							SpawnSaleVehicles()
						end
						if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 25 then
							DrawPrices()
						end

						local pData = RLCore.Functions.GetPlayerData()
						if pData.job.name == 'cardealer' then
							OwnerMenu()
						end
						BuyMenu()
					else
						if vehicles_spawned then
--							print("Despawning Display ?")
							DespawnSaleVehicles()
						end
						Citizen.Wait(1000)
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		for i,b in ipairs(vehshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		vehshop_blips = {}
	end
end

function f(n)
	return n + 0.0001
end

function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function OpenCreator()
	boughtcar = false
	if ownerMenu then
		vehshop = vehshopOwner
	else
		vehshop = vehshopDefault
	end

	local ped = LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])

	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end

function CloseCreator(name, veh, price, financed)
	Citizen.CreateThread(function()
		local ped = LocalPed()
		local pPrice = price
		if not boughtcar then
			local pos = currentlocation.pos.entering
			SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
		else
			local name = name
			local vehicle = veh
			local price = price
			local veh = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(veh)
			local colors = table.pack(GetVehicleColours(veh))
			local extra_colors = table.pack(GetVehicleExtraColours(veh))

			local mods = {}
			for i = 0,24 do
				mods[i] = GetVehicleMod(veh,i)
			end
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
			local pos = currentlocation.pos.outside

			FreezeEntityPosition(ped,false)
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(0)
			end
			personalvehicle = CreateVehicle(model,pos[1],pos[2],pos[3],pos[4],true,false)
			SetModelAsNoLongerNeeded(model)

			if name == "rumpo" then
				SetVehicleLivery(personalvehicle,0)
			end

			if name == "taxi" then
				SetVehicleExtra(personalvehicle, 8, 0)
				SetVehicleExtra(personalvehicle, 9, 0)
				SetVehicleExtra(personalvehicle, 5, 1)
			end

			for i,mod in pairs(mods) do
				SetVehicleModKit(personalvehicle,0)
				SetVehicleMod(personalvehicle,i,mod)
			end

			SetVehicleOnGroundProperly(personalvehicle)
			--SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
			local id = NetworkGetNetworkIdFromEntity(personalvehicle)



			RLCore.Functions.TriggerCallback("tp-generateplate",function(newPlate)
				SetVehicleNumberPlateText(personalvehicle, newPlate)
				SetNetworkIdCanMigrate(id, true)
				SetVehicleColours(personalvehicle,colors[1],colors[2])
				SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
				TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
				TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())), GetVehiclePedIsIn(PlayerPedId()))
				SetEntityVisible(ped,true)
				local vehProps = RLCore.Functions.GetVehicleProperties(personalvehicle)
				TriggerServerEvent('BuyForVeh', vehProps, name, vehicle, pPrice, financed)
				TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())), GetVehiclePedIsIn(PlayerPedId()))
				DespawnSaleVehicles()
				SpawnSaleVehicles()

				Wait(250)
				TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())), GetVehiclePedIsIn(PlayerPedId()))
			end)
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end


RegisterNetEvent("carshop:failedpurchase")
AddEventHandler("carshop:failedpurchase", function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	TaskLeaveVehicle(PlayerPedId(),veh,0)
end)


function drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,255,55,55,220)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,250)
	DrawText(0.255, 0.254)
end

function drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.2, 0.2)
	--SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(250,250,250, 255)
	end

	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 + 0.025, y - menu.height/3 + 0.0002)

	if selected then
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255,255,255,255)
	else
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255,55,55,220)
	end
end

function drawMenuTitle(txt,x,y)
	local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)

	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,250)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function ButtonSelected(button)
	local ped = PlayerPedId()
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Vehicles" then
			OpenMenu('vehicles')
		elseif btn == "Motorcycles" then
			OpenMenu('Motorcycles')
		elseif btn == "Cycles" then
			OpenMenu('cycles')
		end
	elseif this == "vehicles" then
		if btn == "Sports" then
			OpenMenu('Sports')
		elseif btn == "Sedans" then
			OpenMenu('Sedans')
		elseif btn == "Job Vehicles" then
			OpenMenu('Job Vehicles')
		elseif btn == "Compacts" then
			OpenMenu('Compacts')
		elseif btn == "Coupes" then
			OpenMenu('Coupes')
		elseif btn == "Sport Classics" then
			OpenMenu("Sport Classics")
		elseif btn == "Custom Imports" then
			OpenMenu('Custom Imports')
		elseif btn == "Lowriders" then
			OpenMenu('Lowriders')			
		elseif btn == "Diamond Casino" then
			OpenMenu('Diamond Casino')
		elseif btn == "Cayo Perico" then
			OpenMenu('Cayo Perico')	
		elseif btn == "Muscle" then
			OpenMenu('Muscle')
		elseif btn == "Off-Road" then
			OpenMenu('Off-Road')
		elseif btn == "Suvs" then
			OpenMenu('Suvs')
		elseif btn == "Vans" then
			OpenMenu('Vans')
		end
	elseif this == "Job Vehicles" or this == "Compacts" or this == "Coupes" or this == "Sedans" or this == "Sports" or this == "Sport Classics" or this == "Lowriders" or this == "Diamond Casino" or this == "Cayo Perico" or this == "Custom Imports" or this == "Muscle" or this == "Off-Road" or this == "Suvs" or this == "Vans" or this == "industrial" or this == "cycles" or this == "Motorcycles" then
		if ownerMenu then
			updateCarTable(button.model,button.costs,button.name)
		else
			TriggerServerEvent('CheckMoneyForVeh',button.name, button.model, button.costs)
		end
	end
end

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "vehicles" then
		vehshop.lastmenu = "main"
	elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end

function Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		CloseCreator()
	elseif vehshop.currentmenu == "Job Vehicles" or vehshop.currentmenu == "Compacts" or vehshop.currentmenu == "Coupes" or vehshop.currentmenu == "Sedans" or vehshop.currentmenu == "Sports" or vehshop.currentmenu == "Sport Classics" or vehshop.currentmenu == "Lowriders" or vehshop.currentmenu == "Diamond Casino" or vehshop.currentmenu == "Cayo Perico" or vehshop.currentmenu == "Custom Imports" or vehshop.currentmenu == "Muscle" or vehshop.currentmenu == "Off-Road" or vehshop.currentmenu == "Suvs" or vehshop.currentmenu == "Vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "Motorcycles" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ( IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1]) ) and IsPlayerInRangeOfVehshop() then
			if vehshop.opened then
				CloseCreator()
			else
				OpenCreator()
			end
		end
		if vehshop.opened then

			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			local pData = RLCore.Functions.GetPlayerData() 
			for i,button in pairs(menu.buttons) do
				--local br = button.rank ~= nil and button.rank or 0
				if pData.job.name == 'cardealer' and i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vehshop.menu.x,y,selected)

					if button.costs ~= nil then
						drawMenuRight("$"..button.costs,vehshop.menu.x,y,selected)
					end

					y = y + 0.04
					if vehshop.currentmenu == "Job Vehicles" or vehshop.currentmenu == "Compacts" or vehshop.currentmenu == "Coupes" or vehshop.currentmenu == "Sedans" or vehshop.currentmenu == "Sports" or vehshop.currentmenu == "Sport Classics" or vehshop.currentmenu == "Lowriders" or vehshop.currentmenu == "Diamond Casino" or vehshop.currentmenu == "Cayo Perico" or vehshop.currentmenu == "Custom Imports" or vehshop.currentmenu == "Muscle" or vehshop.currentmenu == "Off-Road" or vehshop.currentmenu == "Suvs" or vehshop.currentmenu == "Vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "Motorcycles" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end
								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)


								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								SetModelAsNoLongerNeeded(hash)
								local timer = 9000
								while not DoesEntityExist(veh) and timer > 0 do
									timer = timer - 1
									Citizen.Wait(1)
								end
								TriggerEvent("vehsearch:disable",veh)

								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())), GetVehiclePedIsIn(PlayerPedId()))
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, car = veh}
								local topspeed = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 2)
								local handling = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock') * 2)
								local braking = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 100)
								local accel = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 100) 
								if button.model == "rumpo" then
									SetVehicleLivery(veh,2)
								end

								-- not sure why it doesnt refresh itself, but blocks need to be set to their maximum 20 40 60 80 100 before a new number is pushed.
								--for i = 1, 5 do
								-- 	scaleform = resetscaleform(topspeed,handling,braking,accel,"mp_car_stats_01",i)
							    --    x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
							    --    Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x-1,y+1.8,z+7.0, 0.0, 180.0, 90.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0)
								--end

								--scaleform = Initialize("mp_car_stats_01",fakecar.car,fakecar.model)
							end
						end
					end
					if selected and ( IsControlJustPressed(1,Controlkey["generalUse"][1]) or IsControlJustPressed(1, Controlkey["generalUseSecondary"][1])  ) then
						ButtonSelected(button)
					end
				end
			end

			if DoesEntityExist(fakecar.car) then
				if vehshop.currentmenu == "cycles" or vehshop.currentmenu == "Motorcycles" then
					daz = 6.0
					if fakecar.model == "Chimera" then
						daz = 8.0
					end
					if fakecar.model == "bmx" then
						daz = 8.0
					end
					 x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, daz))
		        	Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 7.0, 7.0, 7.0, 0)
				else
		       		x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, 10.0))
		       		Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 10.0, 10.0, 10.0, 0)		
				end
				TaskWarpPedIntoVehicle(LocalPed(),fakecar.car,-1)
				TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())), GetVehiclePedIsIn(PlayerPedId()))
		    end

		end
		if vehshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end

	end
end)

AddEventHandler('FinishMoneyCheckForVeh', function(name, vehicle, price,financed)
	local name = name
	local vehicle = vehicle
	local price = price
	boughtcar = true
	CloseCreator(name, vehicle, price,financed)
	print("Im done here")
end)

ShowVehshopBlips(true)
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		--326 car blip 227 225
		ShowVehshopBlips(true)
		firstspawn = 1
	end
end)

AddEventHandler('vehshop:spawnVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = PlayerPedId()
	if playerPed and playerPed ~= -1 then
		RequestModel(car)
		while not HasModelLoaded(car) do
			Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)
		veh = CreateVehicle(car, playerCoords, 0.0, true, false)
		SetModelAsNoLongerNeeded(car)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())), GetVehiclePedIsIn(PlayerPedId()))
		SetEntityInvincible(veh, true)
	end
end)

local firstspawn = 0

AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		RemoveIpl('v_carshowroom')
		RemoveIpl('shutter_open')
		RemoveIpl('shutter_closed')
		RemoveIpl('shr_int')
		RemoveIpl('csr_inMission')
		RequestIpl('v_carshowroom')
		RequestIpl('shr_int')
		RequestIpl('shutter_closed')
		firstspawn = 1
	end
end)

RegisterNetEvent("rl-radial:finance")
AddEventHandler("rl-radial:finance", function()
	local pData = RLCore.Functions.GetPlayerData()
	local job = pData.job.name
	if job == 'cardealer' then
		TriggerEvent('finance')
	elseif job == 'tuner' then
		TriggerEvent('finance_tuner')
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)

RegisterNetEvent("rl-radial:enablebuy")
AddEventHandler("rl-radial:enablebuy", function()
	local pData = RLCore.Functions.GetPlayerData()
	local job = pData.job.name
	if job == 'cardealer' then
		TriggerEvent('buyEnable')
	elseif job == 'tuner' then
		TriggerEvent('tuner:enable_buy')
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)

RegisterNetEvent("rl-radial:testdrive")
AddEventHandler("rl-radial:testdrive", function()
	local pData = RLCore.Functions.GetPlayerData()
	local job = pData.job.name
	if job == 'cardealer' then
		TriggerEvent('car:testdrive')
	elseif job == 'tuner' then
		TriggerEvent('car:testdrive_tuner')
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)


--[[ RegisterCommand('finance', function(source, args, raw)
	local pData = RLCore.Functions.GetPlayerData()
	local job = pData.job.name
	if job == 'cardealer' then
		TriggerEvent('finance')
	elseif job == 'tuner' then
		TriggerEvent('finance_tuner')
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end) ]]

RegisterCommand('commission', function(source, args, raw)
	local pData = RLCore.Functions.GetPlayerData()
	local job = pData.job.name
	if job == 'cardealer' then
		local amount = args[1]
		if amount ~= nil then
			TriggerEvent('commission', amount)
		else
			TriggerEvent('DoLongHudText', 'Invalid amount "/commision [amount]', 1)
		end
	elseif job == 'tuner' then
		local amount = args[1]
		if amount ~= nil then
			TriggerEvent('commission_tuner', amount)
		else
			TriggerEvent('DoLongHudText', 'Invalid amount "/commision [amount]', 1)
		end
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end)

--[[ RegisterCommand('testdrive', function(source, args, raw)
	local pData = RLCore.Functions.GetPlayerData()
	local job = pData.job.name
	if job == 'cardealer' then
		TriggerEvent('car:testdrive')
	elseif job == 'tuner' then
		TriggerEvent('car:testdrive_tuner')
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end) ]]

--[[ RegisterCommand('enableBuy', function(source, args, raw)
	local pData = RLCore.Functions.GetPlayerData()
	local job = pData.job.name
	if job == 'cardealer' then
		TriggerEvent('buyEnable')
	elseif job == 'tuner' then
		TriggerEvent('tuner:enable_buy')
	else
		TriggerEvent('DoLongHudText', 'You dont have permissions for this!', 2)
	end
end) ]]

