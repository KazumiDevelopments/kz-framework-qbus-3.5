WELCOME THANK YOU FOR PURCHSING MY SCRIPT

Discord - https://discord.gg/GX63bSG4Xb  

Third-eye targeting for entire job + Crafting + Shop !

Here we have a indepth Player Owned Mechanic Job for your server
You can craft all engine parts ie turbo, engine1,2,3,4, transmissin1,2,3, brakes1,2,3, suspension1,2,3,4, lockpicks & repairkits
You manually install parts to vehicles
Inspect vehicles health and upgrades 
Job locked store to allow for buying cheap racing / mechanic items.


Third-eye targeting for entire job
Target Crafting Bench to make parts
Target Till systems to make payments / sales
Target Boss Menu laptop
Target Duty Laptop
Target Outfits
Target stash / storage\
Target Vehicles to inspect,clean,fix

GABZ TUNER SHOP NOT INCLUDED!

EASY INSTALL DRAG AND DROP!

QB-Target, QB-Menu, QB-Input already exported in bt.lua.

### INSTALL ###

1) Customise `config.lua` to your liking.
2) Drag and drop `Jakers-Tuner-Autos` into your server resources you should already have Listed Dependices
3) Add item / job information provided into `qb-core/shared.lua`
4) Add images provided into `inventory/html/images`
5) Restart your server

### SHARED.LUA ### 

*** Add job to shared lua

['tuner'] = {
        label = 'Tuner Autos',
        defaultDuty = false,
        grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 500
            },
            ['1'] = {
                name = 'Mechanic',
                payment = 750
            },
            ['2'] = {
                name = 'Manager',
                isboss = true,
                payment = 1000
            
            },
            ['3'] = {
                name = 'Co-Owner',
                isboss = true,
                payment = 1250
            },
            ['4'] = {
                name = 'Owner',
                isboss = true,
                payment = 1500
            },


***Add items to shared lua
["turbo"] 	 		         = {["name"] = "turbo", 				["label"] = "Turbocharger", 			["weight"] = 10000, 		["type"] = "item", 		["image"] = "TURBO.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},
    ["translv1"] 	 		 = {["name"] = "translv1", 				["label"] = "Transmission Level 1", 	        ["weight"] = 20000, 		["type"] = "item", 		["image"] = "TRANSLV1.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},
    ["translv2"] 	 		 = {["name"] = "translv2", 				["label"] = "Transmission Level 2", 	        ["weight"] = 20000, 		["type"] = "item", 		["image"] = "TRANSLV2.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},
    ["translv3"] 	 		 = {["name"] = "translv3", 				["label"] = "Transmission Level 3", 	        ["weight"] = 20000, 		["type"] = "item", 		["image"] = "TRANSLV3.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},
    ["englv1"] 	 		         = {["name"] = "englv1", 				["label"] = "Engine Level 1", 			["weight"] = 30000, 		["type"] = "item", 		["image"] = "ENGLV1.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},
    ["englv2"] 	 		         = {["name"] = "englv2", 				["label"] = "Engine Level 2", 			["weight"] = 30000, 		["type"] = "item", 		["image"] = "ENGLV2.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},
    ["englv3"] 	 		         = {["name"] = "englv3", 				["label"] = "Engine Level 3", 			["weight"] = 30000, 		["type"] = "item", 		["image"] = "ENGLV3.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},
    ["englv4"] 	 		         = {["name"] = "englv4", 				["label"] = "Engine Level 4", 			["weight"] = 30000, 		["type"] = "item", 		["image"] = "ENGLV4.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},
    ["brakeslv1"] 	 		 = {["name"] = "brakeslv1", 			        ["label"] = "Brakes Level 1", 			["weight"] = 2000, 		    ["type"] = "item", 		["image"] = "BRAKESLV1.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},
    ["brakeslv2"] 	 		 = {["name"] = "brakeslv2", 			        ["label"] = "Brakes Level 2", 			["weight"] = 2000, 		    ["type"] = "item", 		["image"] = "BRAKESLV2.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},
    ["brakeslv3"] 	 		 = {["name"] = "brakeslv3", 			        ["label"] = "Brakes Level 3", 			["weight"] = 2000, 		    ["type"] = "item", 		["image"] = "BRAKESLV3.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},
    ["suslv1"] 	 	                 = {["name"] = "suslv1", 			        ["label"] = "Suspension Level 1", 		["weight"] = 2000, 		    ["type"] = "item", 		["image"] = "SUSLV1.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},
    ["suslv2"] 	 	                 = {["name"] = "suslv2", 			        ["label"] = "Suspension Level 2", 		["weight"] = 2000, 		    ["type"] = "item", 		["image"] = "SUSLV2.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},
    ["suslv3"] 	        	         = {["name"] = "suslv3", 			        ["label"] = "Suspension Level 3", 		["weight"] = 2000, 		    ["type"] = "item", 		["image"] = "SUSLV3.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},
    ["suslv4"] 	 	                 = {["name"] = "suslv4", 			        ["label"] = "Suspension Level 4", 		["weight"] = 2000, 		    ["type"] = "item", 		["image"] = "SUSLV4.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = ""},


***Add to qb-bossmenu
['tuner'] = vector3(125.53, -3007.18, 7.04)

***Add to qb-bossmenu /accounts.json
tuner":1000,


Dependencies

MLO - https://fivem.gabzv.com/package/4724521

ProgressBar - https://github.com/qbcore-framework/progressbar

qb-lock - https://github.com/M-Middy/qb-lock (minigame)

qb-input - https://github.com/qbcore-framework/qb-input

qb-target - https://github.com/BerkieBb/qb-target  (third eye)

qb-menu - https://github.com/qbcore-framework/qb-menu