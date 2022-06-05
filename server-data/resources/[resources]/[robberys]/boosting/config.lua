Config = {}

Config['General'] = {
    ["License"] = "lol", --- your license here
    ["Core"] = "QBCORE", -- This can be ESX , QBCORE , NPBASE
    ["SQLWrapper"] = "ghmattimysql", -- This can be `| oxmysql or ghmattimysql or mysql-async
    ["EmailEvent"] = "qb-phone:server:sendNewMail",
    ["PoliceJobName"] = "police", -- police job name
    ["MinPolice"] = 0,
    ["UseNotificationsInsteadOfEmails"] = true, -- this is most likely for esx users , cuz they use bunsh of difirent phones , leave as false if you use qbus or np bases
    ["PoliceNeedLaptopToseeNotifications"] = false,
	["BNErewardmultiplier"] = math.random(12, 15) / 10,
}




Config['CoreSettings'] = {
    ["ESX"] = {
        ["Trigger"] = "esx:getSharedObject",
        ["ProgressBarScriptName"] = "unwind-taskbar", -- progress bar script name link in esx_readme.md
    },
    ["QBCORE"] = {
        ["Version"] = "old", -- new = using export | old = using events
        --["Export"] = exports['qb-core']:GetCoreObject(), -- uncomment this if using new qbcore version
        ["Trigger"] = "RLCore:GetObject",
        ["HasItem"] = "RLCore:HasItem", -- Imporant [ Your trigger for checking has item, default is CORENAME:HasItem ] 

    }, 
    ["NPBASE"] = {
        ["Name"] = "unwind-fw", -- this will be used in server side to call player module
        ["ProgressBarScriptName"] = "unwind-taskbar", -- progress bar script name link in np_readme.md
        ["HasItem"] = "unwind-inventory", -- Imporant [ Your normal export for checking has item, default is yourservername:inventory ] 
        ["HandlerScriptName"] = "unwind_handler",
    }
}


Config['Utils'] = {
    ["Rewards"] = {
        ["Type"] = "money", -- reward type item or money
        ["RewardItemName"] = "markedbills", -- this will be the reward item name (no need to config if you are using an money as a reward)
        ["RewardMoneyAmount"] = "0", -- this will be the amount the player recieves when he finish the mission (no need to config if you are using an item as a reward)
        ["RewardAccount"] = "cash", -- this can be only ywo values (no need to config if you are using an item as a reward)
    },
    ["Contracts"] = {
        ["TimeBetweenContracts"] = math.random(1800000,2700000), -- Time in (ms) between contract creations
        ["ContractChance"] = 60, -- This is the luck percentage of getting a contract
    },
    ["VIN"] = {
        ["BNEPrice"] = 350, -- Price (BNE) for start a vin scratch
        ["AmountBneAfterDropOff"] = 50, 
        ["VinLocations"] = {x = 472.08, y = -1310.73, z = 29.22}, -- laptop coords
        ["ForceVin"] = true, -- this will force vin contract optiion on any created contract turn to false to use days instead
        ["VinDays"] = 5, -- amount of days between vin contracts , (irl days) 
    },
    ["ClassPrices"] = {
        ['X'] = "55",
        ['A'] = "40",
        ['B'] = "30",
        ['C'] = "20",
        ['D'] = "15",
        ['M'] = "10",
    },
    ["Blips"] = {
        ["BlipUpdateTime"] = 3000, -- Time in (ms) of the police blip update 1000 = 1 second
        ["DisableTrackingOnDCB"] = false, -- This will disable the police tracking on D , C , B vehicle classes (Turn to false to disable this option)
    },
    ["Notifications"] = {
        ["NotEnoughBNE"] = "Not enough BNE", 
        ["NoTrackerOnThisVehicle"] = "Seems like this vehicle doesn't have a tracker on", 
        ["TrackerRemoved"] = "Tracker removed",
        ["TrackerRemovedVINMission"] = "Tracker removed, head to the scratch location", 
        ["TrackerRemoved"] = "Tracker removed", 
        ["FinishComputer"] = "Head to the vehicle and scratch off the vin!",
        ["VehicleAdded"] = "Vehicle added to your garage!",
        ["DropOffMsg"] = "Get out of the car and leave the area , you will get your money soon", 
        ["UiStillLoadingMsg"] = "Please wait 3 senconds the nui is loading", 
        ["SuccessHack"] = "Success" ,
        ["NoMissionDetected"] = "No ongoing mission detected",
    },
    ["Commands"] = {
        ["boosting_test"] = "boostingtest", -- This Command will send you a test contract for testing purposes leave as nil to disable
        ["force_close_nui"] = "boostingclose", -- This Command will close the nui if it glitches leave as nil to disable
        ["get_vehicle_class"] = "boostingclass", -- This Command will print (F8) the vehicle class of the one ur sitting in
    },
    ["Laptop"] = {
        ["LogoUrl"] = "images/winlogo.png", 
        ["DefaultBackground"] = "images/background.png",
        ["CopNotifyLength"] = 5000, -- Time in (ms) of the police Notify length
    },
}





-------------- SERVER FUNCTIONS --------------
AddVehicle = function(data)
    if Config['General']["Core"] == "QBCORE" then
        SQL('INSERT INTO player_vehicles (steam, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)',{data.steam, data.cid, data.vehicle, data.hash, data.vehicleMods, data.vehicleplate, data.vehiclestate})
    elseif Config['General']["Core"] == "ESX" then
        SQL('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?)',{data.steam, data.vehicleplate, data.vehicle})
    elseif Config['General']["Core"] == "NPBASE" then
        local v = {
            ["owner"] = data.steam,
            ["cid"] = data.cid,
            ['name'] = data.vehicle,
            ["model"] = data.vehicle,
            ["vehicle_state"] = "Out",
            ["fuel"] = 100,
            ["engine_damage"] = 1000,
            ["body_damage"] = 1000,
            ["current_garage"] = "T",
            ["license_plate"] = data.vehicleplate
        }
        local k = [[INSERT INTO characters_cars (owner, cid, name, model, vehicle_state, fuel, engine_damage, body_damage, current_garage, license_plate) VALUES(@owner, @cid, @name, @model, @vehicle_state, @fuel, @engine_damage, @body_damage, @current_garage, @license_plate);]]
        SQL(k, v)
    end
end

AddBNE = function(cid, pBne, amount)
    SQL('UPDATE bropixel_boosting SET BNE=@bne WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@bne'] = pBne + amount})
end

RemoveBNE = function(cid, pBne, amount)
    SQL('UPDATE bropixel_boosting SET BNE=@bne WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@bne'] = pBne - amount})
end

-----     VEHCILES TO SPAWN        -------
Config.Vehicles = {

    ---------- S CLASS --------------
    [1] = {vehicle = "t20"},
    [2] = {vehicle = "Zion2"},
    [3] = {vehicle = "Felon"},
    [4] = {vehicle = "Zentorno"},
    -- ---------- A CLASS --------------
    [5] = {vehicle = "Oracle2"},
    [6] = {vehicle = "Windsor2"},
    [7] = {vehicle = "SabreGT2"},
    [8] = {vehicle = "Sentinel2"},
    [9] = {vehicle = "Zion"},
    [10] = {vehicle = "Phoenix"},
    [11] = {vehicle = "Washington"},
    [12] = {vehicle = "Banshee2"},
    [13] = {vehicle = "Infernus2"},
    [14] = {vehicle = "Nero"},
    [15] = {vehicle = "Nero2"},
    [16] = {vehicle = "Brawler"},
    ---------- B CLASS --------------
    [17] = {vehicle = "Prairie"},
    [18] = {vehicle = "Chino"},
    [19] = {vehicle = "Dukes"},
    [20] = {vehicle = "Virgo3"},
    [21] = {vehicle = "Tampa"},
    [22] = {vehicle = "Blade"},
    [23] = {vehicle = "Sultan"},
    [24] = {vehicle = "Primo"},
    [25] = {vehicle = "Primo2"},
    [26] = {vehicle = "Regina"},
    [27] = {vehicle = "ZType"},
    [28] = {vehicle = "Bison3"},
    [29] = {vehicle = "Bison"},
    [30] = {vehicle = "blista"},
    [31] = {vehicle = "blista2"},
    [32] = {vehicle = "Issi2"},
    [33] = {vehicle = "Issi2"},
    [34] = {vehicle = "Buccaneer2"},
    [35] = {vehicle = "Picador"},
    ---------- C CLASS --------------
    [36] = {vehicle = "Emperor2"},
    [37] = {vehicle = "Tornado3"},
    [38] = {vehicle = "BType"},
    [39] = {vehicle = "Sadler"},
    [40] = {vehicle = "Bison2"},
    [41] = {vehicle = "Minivan2"},
    [42] = {vehicle = "RatLoader"},
    [43] = {vehicle = "Virgo2"},
    ---------- D CLASS --------------
    [44] = {vehicle = "Dilettante"},
}


-----     DROP OFF LOCATIONS        -------
Config.BoostingDropOff = {
	[1] =  { ['x'] = 196.87251281738,['y'] = -156.60850524902,['z'] = 56.786975860596},
	[2] =  { ['x'] = -1286.9621582031,['y'] = -274.47973632813,['z'] = 38.724918365479},
	[3] =  { ['x'] = -1330.8432617188,['y'] = -1034.8623046875,['z'] = 7.518029212951},
}

-----     VEHICLE SPAWN LOCATIONS        -------
Config.VehicleCoords = {
    [1] = {x = -1132.395, y = -1070.607, z = 1.64372, h = 120.00},
    [2] = {x = -935.1176, y = -1080.552, z = 1.683342, h = 120.1060},
    [3] = {x = -1074.953,y = -1160.545,z = 1.661577, h = 119.0},
    [4] = {x = -1023.625,y = -890.4014,z = 5.202, h = 216.0399},
    [5] = {x = -1609.647,y = -382.792,z = 42.70383, h = 52.535},
    [6] = {x = -1527.88,y = -309.8757,z = 47.88678, h= 323.43},
    [7] = {x = -1658.969,y = -205.1732,z = 54.8448,h = 71.138},
    [8] = {x = 97.57888,y = -1946.472,z = 20.27978,h = 215.933},
    [9] = {x = -61.59007,y = -1844.621,z = 26.1685,h = 138.9848},
    [10] = {x = 28.51439,y = -1734.881,z = 28.5415,h = 231.968},
    [11] = {x = 437.5428,y = -1925.465,z = 24.004,h = 28.82286},
    [12] = {x = 406.5316,y = -1920.471,z = 24.51589,h = 224.6432},
    [13] = {x = 438.4482,y = -1838.672,z = 27.47369,h = 42.8129   },
    [14] = {x = 187.353,y = -1542.984,z = 28.72487,h = 39.00627},
    [15] = {x = 1153.467,y = -330.2682,z = 68.60548,h = 7.20},
    [16] = {x = 1144.622,y = -465.7694,z = 66.20689,h = 76.612770},
    [17] = {x = 1295.844,y = -567.6,z = 70.77858,h = 166.552},
    [18] = {x = 1319.566,y = -575.9492,z = 72.58221,h = 155.9249},
    [19] = {x = 1379.466,y = -596.0999,z = 73.89736,h = 230.594},
    [20] = {x = 1256.648,y = -624.0594,z = 68.93141,h = 117.415},
    [21] = {x = 1368.127,y = -748.2613,z = 66.62316,h = 231.535},
    [22] = {x = 981.7167,y = -709.7389,z = 57.18427,h = 128.729},
    [23] = {x = 958.206,y = -662.7545,z = 57.57119,h = 116.9299},
    [24] = {x = -2012.404,y = 484.0458,z = 106.5597,h = 78.13},
    [25] = {x = -2001.294,y = 454.7647,z = 102.0194,h = 108.1178},
    [26] = {x = -1994.725,y = 377.4933,z = 94.04324,h = 89.64067},
    [27] = {x = -1967.549,y = 262.1507,z = 86.23506,h = 109.1846},
    [28] = {x = -989.6796,y = 418.4977,z = 74.731,h = 20.262},
    [29] = {x = -979.6517,y = 518.119,z = 81.03075,h = 328.386},
    [30] = {x = -1040.915,y = 496.5622,z = 82.52803,h = 54.439},
    [31] = {x = -1094.621,y = 439.2605,z = 74.84596,h = 84.936},
    [32] = {x = -1236.895,y = 487.9722,z = 92.82943,h = 330.6634},
    [33] = {x = -1209.098,y = 557.9588,z = 99.04235,h = 3.2526},
    [34] = {x = -1155.296,y = 565.4297,z = 101.3919,h = 7.4106},
    [35] = {x = -1105.378,y = 551.5797,z = 102.1759,h = 211.7110},
    [36] = {x = 1708.02,y = 3775.486,z = 34.08183,h = 35.04580},
    [37] = {x = 2113.365,y = 4770.113,z = 40.72895,h = 297.5323},
    [38] = {x = 2865.448,y = 1512.715,z = 24.12726,h = 252.3262},
    [39] = {x = 1413.973,y = 1119.024,z = 114.3981,h = 305.99868},
    [40] = {x = -78.39651,y = 497.4749,z = 143.9646,h = 160.2948},
    [41] = {x = -248.9841,y = 492.9105,z = 125.0711,h = 208.5761},
    [42] = {x = 14.09792,y = 548.8402,z = 175.7571,h = 241.4019775},
    [43] = {x = 51.48445,y = 562.2509,z = 179.8492,h = 203.159},
    [44] = {x = -319.3912,y = 478.9731,z = 111.7186,h = 298.7645},
    [45] = {x = -202.0035,y = 410.2064,z = 110.0086,h = 195.6136},
    [46] = {x = -187.1009, y = 379.9514, z = 108.0138, h = 176.9462},
    [47] = {x = 213.5159, y = 389.3123, z = 106.4154, h = 348.890255},
    [48] = {x = 323.7256, y = 343.3308, z = 104.761, h = 345.49426},
    [49] = {x = 701.1197, y = 254.4424, z = 92.85217, h = 240.62884},
    [50] = {x = 656.4758, y = 184.8482, z = 94.53828, h = 248.9376},
    [51] = {x = 615.5524, y = 161.4801, z = 96.91451, h = 69.2577},
    [52] = {x = 899.2693, y = -41.99047, z = 78.32366, h = 28.13086},
    [53] = {x = 873.3314, y = 9.008331, z = 78.32432, h = 329.343},
    [54] = {x = 941.2477, y = -248.0161, z = 68.15629, h = 328.122},
    [55] = {x = 842.7501, y = -191.9954, z = 72.1975, h = 329.2124},
    [56] = {x = 534.3583, y = -26.7027, z = 70.18916, h = 30.70978},
    [57] = {x = 302.5077, y = -176.5727, z = 56.95071, h = 249.3339},
    [58] = {x = 85.26346, y = -214.7179, z = 54.05132, h = 160.2142},
    [59] = {x = 78.38569, y = -198.4182, z = 55.79539, h = 70.1377},
    [60] = {x = -30.09893, y = -89.37914, z = 56.8136, h = 340.32879},
}



-----     YOU CAN MESS AROUND WITH THESE NAMES CUZ WHY NOT  -------

Config.CitizenNames =  {
    [1] = {name = "Geoffrey Willis"},
    [2] = {name = "Judy Gordon"},
    [3] = {name = "Nathan Ross"},
    [4] = {name = "Mona Collins"},
    [5] = {name = "Arnold Pittman"},
    [6] = {name = "Brittany Wallace"},
    [7] = {name = "Natalie Taylor"},
    [8] = {name = "Garry Stewart"},
    [9] = {name = "Terrell Todd"},
    [10] = {name = "Vincent Price"},
    [11] = {name = "Todd Hardy"},
    [12] = {name = "Elvira Gross"},
    [13] = {name = "Rudy Newman"},
    [14] = {name = "Rickey Nash"},
    [15] = {name = "Shawn Harris"},
    [16] = {name = "Archie Delgado"},
    [17] = {name = "Josephine Hall"},
    [18] = {name = "Gregory Elliott"},
    [19] = {name = "Marjorie Carlson"},
    [20] = {name = "Lois Phillips"},
    [21] = {name = "Darla Lowe"},
    [22] = {name = "Guadalupe Blake"},
    [23] = {name = "Jack Curry"},
    [24] = {name = "Clifford Sanchez"},
    [25] = {name = "Neil Howard"},
    [26] = {name = "Betsy Mitchell"},
    [27] = {name = "Regina Moss"},
    [28] = {name = "Maxine Davis"},
    [29] = {name = "Elisa Estrada"},
    [30] = {name = "Geneva Newton"},
    [31] = {name = "Trevor Shelton"},
    [32] = {name = "Candice Murphy"},
    [33] = {name = "Roman Austin"},
    [34] = {name = "Juanita Rhodes"},
    [35] = {name = "Laurie Thompson"},
    [36] = {name = "Horace Goodwin"},
    [37] = {name = "Julio Kennedy"},
    [38] = {name = "Rosalie Norton"},
    [39] = {name = "Eleanor Gilbert"},
    [40] = {name = "Kristine Frank"},
    [41] = {name = "Lynn Olson"},
    [42] = {name = "Ruben Huff"},
    [43] = {name = "Janice Page"},
    [44] = {name = "Drew Parks"},
    [45] = {name = "Maggie Garner"},
    [46] = {name = "Kenneth Mcdaniel"},
    [47] = {name = "Sara Herrera"},
    [48] = {name = "Allen Morton"},
    [49] = {name = "Howard Klein"},
    [50] = {name = "Jared Little"},
    [51] = {name = "Jesse Fleming"},
    [52] = {name = "Andre Patrick"},
    [53] = {name = "Pam Mccormick"},
    [54] = {name = "Abel Glover"},
    [55] = {name = "Casey Brewer"},
    [56] = {name = "Kimberly Foster"},
    [57] = {name = "Gary Ruiz"},
    [58] = {name = "Theresa Drake"},
    [59] = {name = "Lorraine Frazier"},
    [60] = {name = "Melvin Mendez"},
    [61] = {name = "Courtney Burns"},
    [62] = {name = "Ora Pope"},
    [63] = {name = "Cecil Moreno"},
    [64] = {name = "Kenny Richardson"},
    [65] = {name = "Salvatore Larson"},
    [66] = {name = "Ethel Martinez"},
    [67] = {name = "Ross Sims"},
    [68] = {name = "Peter Hubbard"},
    [69] = {name = "Noel Evans"},
    [70] = {name = "Joseph Hunter"},
    [71] = {name = "Russell Keller"},
    [72] = {name = "Phil Simon"},
    [73] = {name = "Bertha Cruz"},
    [74] = {name = "Rufus Carroll"},
    [75] = {name = "Jeremiah Russell"},
    [76] = {name = "Kim Roy"},
    [77] = {name = "Sally Obrien"},
    [78] = {name = "Joshua Hunt"},
    [79] = {name = "Kurt Singleton"},
    [80] = {name = "Marlon Carter"},
    [81] = {name = "Jane Collier"},
    [82] = {name = "Marshall Johnston"},
    [83] = {name = "Stacey Morris"},
    [84] = {name = "Ivan Lindsey"},
    [85] = {name = "Alberta Oliver"},
    [86] = {name = "Earnest Paul"},
    [87] = {name = "Henrietta Doyle"},
    [88] = {name = "Bryant Green"},
    [89] = {name = "Viola Wagner"},
    [90] = {name = "Roosevelt Jacobs"},
    [91] = {name = "Rolando Clayton"},
    [92] = {name = "Bernice Graham"},
    [92] = {name = "Carl Knight"},
    [94] = {name = "Justin Carr"},
    [95] = {name = "Toni Briggs"},
    [96] = {name = "Amos Williamson"},
    [97] = {name = "Lamar Leonard"},
    [98] = {name = "Wm Allison"},
    [99] = {name = "Johnnie Quinn"},
    [100] = {name = "Jenna Anderson"},
}




--------------BLIPS----------------- DON4T TOUCH ANY OF THESE UNLESS YOU KNOW WHAT YOU ARE DOING
local Circle


function CreateBlip(v)
    Circle = Citizen.InvokeNative(0x46818D79B1F7499A,v.x + math.random(0.0,150.0), v.y + math.random(0.0,80.0), v.z + math.random(0.0,5.0) , 300.0) -- you can use a higher number for a bigger zone
    SetBlipHighDetail(Circle, true)
    SetBlipColour(Circle, 18)
    SetBlipAlpha (Circle, 128)
end
  
function DeleteCircle()
    if DoesBlipExist(Circle) then
        RemoveBlip(Circle)
    end
end
  

function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end


function CreateDropPoint()
    DeleteBlip()
    rnd = math.random(1,#Config.BoostingDropOff)
    if OnTheDropoffWay then
    blip = AddBlipForCoord(Config.BoostingDropOff[rnd]["x"],Config.BoostingDropOff[rnd]["y"],Config.BoostingDropOff[rnd]["z"])
    end
    SetBlipSprite(blip, 514)
    SetBlipScale(blip, 0.7)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Drop Off")
    EndTextCommandSetBlipName(blip)
    DropblipCreated = true
end

function DeleteCopBlip()
	if DoesBlipExist(copblip) then
		RemoveBlip(copblip)
	end
end

function CreateCopBlip(cx,cy,cz)
    DeleteCopBlip()
    copblip = AddBlipForCoord(cx,cy,cz)
    SetBlipSprite(copblip , 161)
    SetBlipScale(copblipy , 2.0)
    SetBlipColour(copblip, 8)
    PulseBlip(copblip)
end


function CreateScratchPoint()
    DeleteBlip()
    if vinstarted then
        blip = AddBlipForCoord(Config.ScratchLocation[1]["x"],Config.ScratchLocation[1]["y"],Config.ScratchLocation[1]["z"])
    end
    SetBlipSprite(blip, 514)
    SetBlipScale(blip, 0.7)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Vin Scratch")
    EndTextCommandSetBlipName(blip)
    DropblipCreated = true
end


function DrawText3D2(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
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
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end


ShowNotification = function(msg, type)
    exports['mythic_notify']:SendAlert(type, msg)
	--exports['co_notify']:SendNotify('boosting', type, msg)
end


function LoadDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
end