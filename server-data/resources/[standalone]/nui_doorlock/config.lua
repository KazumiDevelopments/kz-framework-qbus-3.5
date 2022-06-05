Config = {}

Config.ShowUnlockedText = true

Config.LockedColor = 'rgb(219 58 58)'
Config.UnlockedColor = 'rgb(33, 149, 246)' -- Old Color if you want it 'rgb(19, 28, 74)'

Config.AdminAccess = {
	enabled = false,
	permission = 'admin' -- Needs to be admin or god
}
Config.CommandPermission = 'god' -- Needs to be admin or god, if you want no permission on it you'd have to remove some code

Config.Debug = false -- Prints the closest door data
 
Config.DoorList = {

}

-- PD Main Doors created by Doofy Gilmore
Config.DoorList['PD Main Doors'] = {
    audioRemote = false,
    locked = false,
    doors = {
        {objHash = -1547307588, objHeading = 269.98272705078, objCoords = vec3(434.744446, -980.755554, 30.815304)},
        {objHash = -1547307588, objHeading = 90.017288208008, objCoords = vec3(434.744446, -983.078125, 30.815304)}
    },
    slides = false,
    maxDistance = 2.5,
    authorizedJobs = { ['police']=0 },
    lockpick = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- entryright_mrpd created by DAD?
Config.DoorList['entryleft_mrpd'] = {
    objHash = -96679321,
    objCoords = vec3(440.520081, -986.233459, 30.823193),
    audioRemote = false,
    garage = false,
    objHeading = 180.00001525879,
    locked = true,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    slides = false,
    fixText = false,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- sideentrance_mrpd created by DAD?
Config.DoorList['sideentrance_mrpd'] = {
    locked = true,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0 },
    maxDistance = 2.5,
    doors = {
        {objHash = -1547307588, objHeading = 0.0, objCoords = vec3(440.739197, -998.746216, 30.815304)},
        {objHash = -1547307588, objHeading = 180.00001525879, objCoords = vec3(443.061768, -998.746216, 30.815304)}
    },
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- entryright_mrpd created by DAD?
Config.DoorList['entryright_mrpd'] = {
    objHash = -1406685646,
    objCoords = vec3(440.520081, -977.601074, 30.823193),
    audioRemote = false,
    garage = false,
    objHeading = 0.0,
    locked = true,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    slides = false,
    fixText = false,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- sideentry_mrpd created by DAD?
Config.DoorList['sideentry_mrpd'] = {
    locked = true,
    lockpick = false,
    audioRemote = false,
    authorizedJobs = { ['police']=0 },
    maxDistance = 2.5,
    doors = {
        {objHash = -1547307588, objHeading = 180.00001525879, objCoords = vec3(458.208740, -972.254272, 30.815308)},
        {objHash = -1547307588, objHeading = 0.0, objCoords = vec3(455.886169, -972.254272, 30.815308)}
    },
    slides = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- armoryfront_mrpd created by DAD?
Config.DoorList['armoryfront_mrpd'] = {
    objHash = -692649124,
    objCoords = vec3(479.750732, -999.629028, 30.789167),
    audioRemote = false,
    garage = false,
    objHeading = 89.999977111816,
    locked = true,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    slides = false,
    fixText = false,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- armoryrear_mrpd created by DAD?
Config.DoorList['armoryrear_mrpd'] = {
    objHash = -692649124,
    objCoords = vec3(487.437836, -1000.189270, 30.786972),
    audioRemote = false,
    garage = false,
    objHeading = 181.28001403809,
    locked = true,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    slides = false,
    fixText = false,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- parkingentrydoor_mrpd created by DAD?
Config.DoorList['parkingentrydoor_mrpd'] = {
    objHash = 1830360419,
    objCoords = vec3(464.156555, -997.509277, 26.370705),
    audioRemote = false,
    garage = false,
    objHeading = 89.870010375977,
    locked = true,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    slides = false,
    fixText = false,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- parkingentrydoor2_mrpd created by DAD?
Config.DoorList['parkingentrydoor2_mrpd'] = {
    objHash = 1830360419,
    objCoords = vec3(464.159058, -974.665588, 26.370705),
    audioRemote = false,
    garage = false,
    objHeading = 269.79000854492,
    locked = true,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    slides = false,
    fixText = false,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- evidence_mrpd created by DAD?
Config.DoorList['evidence_mrpd'] = {
    objHash = -692649124,
    objCoords = vec3(475.832336, -990.483948, 26.405483),
    audioRemote = false,
    garage = false,
    objHeading = 134.97177124023,
    locked = true,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    slides = false,
    fixText = false,
    maxDistance = 2.0,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- sallyport_mrpd created by DAD?
Config.DoorList['sallyport_mrpd'] = {
    lockpick = false,
    slides = false,
    maxDistance = 2.5,
    doors = {
        {objHash = -692649124, objHeading = 0.0, objCoords = vec3(467.368622, -1014.406006, 26.483816)},
        {objHash = -692649124, objHeading = 180.00001525879, objCoords = vec3(469.774261, -1014.406006, 26.483816)}
    },
    locked = true,
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Holdingcellsentry_mrpd created by DAD?
Config.DoorList['Holdingcellsentry_mrpd'] = {
    lockpick = false,
    slides = false,
    maxDistance = 2.5,
    doors = {
        {objHash = 149284793, objHeading = 270.19003295898, objCoords = vec3(471.367859, -1007.793396, 26.405483)},
        {objHash = 149284793, objHeading = 89.999977111816, objCoords = vec3(471.375824, -1010.197876, 26.405483)}
    },
    locked = true,
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- mugshot_mrpd created by DAD?
Config.DoorList['mugshot_mrpd'] = {
    objCoords = vec3(475.953857, -1010.819336, 26.406385),
    slides = false,
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    lockpick = false,
    locked = true,
    objHeading = 180.00001525879,
    fixText = false,
    maxDistance = 2.0,
    garage = false,
    objHash = -1406685646,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- holdingcellsentry_mrpd created by DAD?
Config.DoorList['holdingcellsentry_mrpd'] = {
    objCoords = vec3(476.615692, -1008.875427, 26.480055),
    slides = false,
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    lockpick = false,
    locked = true,
    objHeading = 270.13998413086,
    fixText = false,
    maxDistance = 2.0,
    garage = false,
    objHash = -53345114,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Cell1_mrpd created by DAD?
Config.DoorList['Cell1_mrpd'] = {
    objCoords = vec3(477.912598, -1012.188660, 26.480055),
    slides = false,
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    lockpick = false,
    locked = true,
    objHeading = 0.0,
    fixText = false,
    maxDistance = 2.0,
    garage = false,
    objHash = -53345114,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Cell2_mrpd created by DAD?
Config.DoorList['Cell2_mrpd'] = {
    objCoords = vec3(480.912811, -1012.188660, 26.480055),
    slides = false,
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    lockpick = false,
    locked = true,
    objHeading = 0.0,
    fixText = false,
    maxDistance = 2.0,
    garage = false,
    objHash = -53345114,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Cell3_mrpd created by DAD?
Config.DoorList['Cell3_mrpd'] = {
    objCoords = vec3(483.912720, -1012.188660, 26.480055),
    slides = false,
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    lockpick = false,
    locked = true,
    objHeading = 0.0,
    fixText = false,
    maxDistance = 2.0,
    garage = false,
    objHash = -53345114,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Cell4_mrpd created by DAD?
Config.DoorList['Cell4_mrpd'] = {
    objCoords = vec3(486.913116, -1012.188660, 26.480055),
    slides = false,
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    lockpick = false,
    locked = true,
    objHeading = 0.0,
    fixText = false,
    maxDistance = 2.0,
    garage = false,
    objHash = -53345114,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Cell5_mrpd created by DAD?
Config.DoorList['Cell5_mrpd'] = {
    objCoords = vec3(484.176422, -1007.734375, 26.480055),
    slides = false,
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    lockpick = false,
    locked = true,
    objHeading = 180.00001525879,
    fixText = false,
    maxDistance = 2.0,
    garage = false,
    objHash = -53345114,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- holdingcellsexit_mrpd created by DAD?
Config.DoorList['holdingcellsexit_mrpd'] = {
    objCoords = vec3(481.008362, -1004.117981, 26.480055),
    slides = false,
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    lockpick = false,
    locked = true,
    objHeading = 180.00001525879,
    fixText = false,
    maxDistance = 2.0,
    garage = false,
    objHash = -53345114,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- intergation1_mrpd created by DAD?
Config.DoorList['intergation1_mrpd'] = {
    audioRemote = false,
    objHeading = 270.00003051758,
    fixText = false,
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    objHash = -1406685646,
    slides = false,
    lockpick = false,
    locked = true,
    objCoords = vec3(482.670135, -987.579163, 26.405483),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- intergation2_mrpd created by DAD?
Config.DoorList['intergation2_mrpd'] = {
    audioRemote = false,
    objHeading = 270.00003051758,
    fixText = false,
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    objHash = -1406685646,
    slides = false,
    lockpick = false,
    locked = true,
    objCoords = vec3(482.670258, -995.728516, 26.405483),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- observation2_mrpd created by DAD?
Config.DoorList['observation2_mrpd'] = {
    audioRemote = false,
    objHeading = 270.00003051758,
    fixText = false,
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    objHash = -1406685646,
    slides = false,
    lockpick = false,
    locked = true,
    objCoords = vec3(482.669922, -992.299133, 26.405483),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- observation1_mrpd created by DAD?
Config.DoorList['observation1_mrpd'] = {
    audioRemote = false,
    objHeading = 270.00003051758,
    fixText = false,
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    objHash = -1406685646,
    slides = false,
    lockpick = false,
    locked = true,
    objCoords = vec3(482.669434, -983.986816, 26.405483),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- roof_mrpd created by DAD?
Config.DoorList['roof_mrpd'] = {
    audioRemote = false,
    objHeading = 89.999977111816,
    fixText = false,
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    objHash = -692649124,
    slides = false,
    lockpick = false,
    locked = true,
    objCoords = vec3(464.308563, -984.528442, 43.771240),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- interside_mrpd created by DAD?
Config.DoorList['interside_mrpd'] = {
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    slides = false,
    lockpick = false,
    doors = {
        {objHash = 149284793, objHeading = 0.0, objCoords = vec3(479.663757, -997.909973, 26.406504)},
        {objHash = 149284793, objHeading = 180.00001525879, objCoords = vec3(482.068573, -997.909973, 26.406504)}
    },
    maxDistance = 2.5,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- interside2_mrpd created by DAD?
Config.DoorList['interside2_mrpd'] = {
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    slides = false,
    lockpick = false,
    doors = {
        {objHash = 149284793, objHeading = 89.999977111816, objCoords = vec3(479.062408, -987.437561, 26.405483)},
        {objHash = 149284793, objHeading = 270.00003051758, objCoords = vec3(479.062408, -985.032349, 26.405483)}
    },
    maxDistance = 2.5,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- interside3_mrpd created by DAD?
Config.DoorList['interside3_mrpd'] = {
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    slides = false,
    lockpick = false,
    doors = {
        {objHash = -1406685646, objHeading = 270.00003051758, objCoords = vec3(471.375305, -985.031921, 26.405483)},
        {objHash = -96679321, objHeading = 270.00003051758, objCoords = vec3(471.375305, -987.437378, 26.405483)}
    },
    maxDistance = 2.5,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- cellhallway_mrpd created by DAD?
Config.DoorList['cellhallway_mrpd'] = {
    authorizedJobs = { ['police']=0 },
    audioRemote = false,
    slides = false,
    lockpick = false,
    doors = {
        {objHash = -288803980, objHeading = 180.00001525879, objCoords = vec3(469.927368, -1000.543701, 26.405483)},
        {objHash = -288803980, objHeading = 0.0, objCoords = vec3(467.522217, -1000.543701, 26.405483)}
    },
    maxDistance = 2.5,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- parkinggarge1_mrpd created by DAD?
Config.DoorList['parkinggarge1_mrpd'] = {
    audioRemote = false,
    objHeading = 0.0,
    fixText = false,
    maxDistance = 6.0,
    authorizedJobs = { ['police']=0 },
    objHash = 2130672747,
    slides = true,
    lockpick = false,
    locked = true,
    objCoords = vec3(452.300507, -1000.771667, 26.696609),
    garage = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- parkinggarge2_mrpd created by DAD?
Config.DoorList['parkinggarge2_mrpd'] = {
    audioRemote = false,
    objHeading = 0.0,
    fixText = false,
    maxDistance = 6.0,
    authorizedJobs = { ['police']=0 },
    objHash = 2130672747,
    slides = true,
    lockpick = false,
    locked = true,
    objCoords = vec3(431.411926, -1000.771667, 26.696609),
    garage = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- capoffice_mrpd created by DAD?
Config.DoorList['capoffice_mrpd'] = {
    audioRemote = false,
    objHeading = 270.00003051758,
    fixText = false,
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    objHash = -96679321,
    slides = false,
    lockpick = false,
    locked = true,
    objCoords = vec3(458.654327, -990.649780, 30.823193),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- sallyportgate_mrpd created by DAD?
Config.DoorList['sallyportgate_mrpd'] = {
    audioRemote = false,
    objHeading = 90.0,
    fixText = false,
    maxDistance = 6.0,
    authorizedJobs = { ['police']=0 },
    objHash = -1603817716,
    slides = true,
    lockpick = false,
    locked = true,
    objCoords = vec3(488.894806, -1017.211975, 27.149349),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Staffroom_pillbox created by DAD?
Config.DoorList['Staffroom_pillbox'] = {
    audioRemote = false,
    objHeading = 160.00003051758,
    fixText = false,
    maxDistance = 2.0,
    authorizedJobs = { ['ambulance']=0 },
    objHash = 854291622,
    slides = false,
    lockpick = false,
    locked = true,
    objCoords = vec3(309.133728, -597.751465, 43.433910),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- counter_pillbox created by DAD?
Config.DoorList['counter_pillbox'] = {
    audioRemote = false,
    objHeading = 249.98275756836,
    fixText = false,
    maxDistance = 2.0,
    authorizedJobs = { ['ambulance']=0 },
    objHash = 854291622,
    slides = false,
    lockpick = false,
    locked = true,
    objCoords = vec3(313.480072, -595.458313, 43.433910),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- WardB_pillbox created by DAD?
Config.DoorList['WardB_pillbox'] = {
    authorizedJobs = { ['ambulance']=0 },
    audioRemote = false,
    slides = false,
    lockpick = false,
    doors = {
        {objHash = -434783486, objHeading = 340.00003051758, objCoords = vec3(324.236023, -589.226196, 43.433910)},
        {objHash = -1700911976, objHeading = 340.00003051758, objCoords = vec3(326.654999, -590.106628, 43.433910)}
    },
    maxDistance = 2.5,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- surgery_pillbox created by DAD?
Config.DoorList['surgery_pillbox'] = {
    authorizedJobs = { ['ambulance']=0 },
    audioRemote = false,
    slides = false,
    lockpick = false,
    doors = {
        {objHash = -434783486, objHeading = 340.00003051758, objCoords = vec3(312.005127, -571.341187, 43.433910)},
        {objHash = -1700911976, objHeading = 340.00003051758, objCoords = vec3(314.424103, -572.221558, 43.433910)}
    },
    maxDistance = 2.5,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- surgery2_pillbox created by DAD?
Config.DoorList['surgery2_pillbox'] = {
    authorizedJobs = { ['ambulance']=0 },
    audioRemote = false,
    slides = false,
    lockpick = false,
    doors = {
        {objHash = -434783486, objHeading = 340.00003051758, objCoords = vec3(317.842560, -573.465881, 43.433910)},
        {objHash = -1700911976, objHeading = 340.00003051758, objCoords = vec3(320.261536, -574.346313, 43.433910)}
    },
    maxDistance = 2.5,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- surgery3_pillbox created by DAD?
Config.DoorList['surgery3_pillbox'] = {
    authorizedJobs = { ['ambulance']=0 },
    audioRemote = false,
    slides = false,
    lockpick = false,
    doors = {
        {objHash = -434783486, objHeading = 340.00003051758, objCoords = vec3(323.237549, -575.429443, 43.433910)},
        {objHash = -1700911976, objHeading = 340.00003051758, objCoords = vec3(325.656525, -576.309937, 43.433910)}
    },
    maxDistance = 2.5,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- WardB2_pillbox created by DAD?
Config.DoorList['WardB2_pillbox'] = {
    authorizedJobs = { ['ambulance']=0 },
    audioRemote = false,
    slides = false,
    lockpick = false,
    doors = {
        {objHash = -434783486, objHeading = 249.98275756836, objCoords = vec3(326.549896, -578.040649, 43.433910)},
        {objHash = -1700911976, objHeading = 249.98275756836, objCoords = vec3(325.669464, -580.459595, 43.433910)}
    },
    maxDistance = 2.5,
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- admin_pillbox created by DAD?
Config.DoorList['admin_pillbox'] = {
    audioRemote = false,
    objHeading = 340.00003051758,
    fixText = false,
    maxDistance = 2.0,
    authorizedJobs = { ['ambulance']=0 },
    objHash = 854291622,
    slides = false,
    lockpick = false,
    locked = true,
    objCoords = vec3(339.004974, -586.703369, 43.433910),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Wardc_pillbox created by DAD?
Config.DoorList['Wardc_pillbox'] = {
    audioRemote = false,
    objHeading = 249.98275756836,
    fixText = false,
    maxDistance = 2.0,
    authorizedJobs = { ['ambulance']=0 },
    objHash = -1700911976,
    slides = false,
    lockpick = false,
    locked = true,
    objCoords = vec3(348.433319, -588.744995, 43.433910),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- garagedoor1_pillbox created by DAD?
Config.DoorList['garagedoor1_pillbox'] = {
    audioRemote = false,
    objHeading = 160.00607299805,
    fixText = false,
    maxDistance = 6.0,
    authorizedJobs = { ['ambulance']=0, ['police']=0 },
    objHash = -820650556,
    slides = true,
    lockpick = false,
    locked = true,
    objCoords = vec3(337.277679, -564.432007, 29.775291),
    garage = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- garagedoor2_pillbox created by DAD?
Config.DoorList['garagedoor2_pillbox'] = {
    audioRemote = false,
    objHeading = 160.00605773926,
    fixText = false,
    maxDistance = 6.0,
    authorizedJobs = { ['ambulance']=0, ['police']=0 },
    objHash = -820650556,
    slides = true,
    lockpick = false,
    locked = true,
    objCoords = vec3(330.134918, -561.833130, 29.775291),
    garage = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- garage2_mechainc created by DAD?
Config.DoorList['garage2_mechainc'] = {
    audioRemote = false,
    objHeading = 31.999959945679,
    fixText = false,
    maxDistance = 6.0,
    authorizedJobs = { ['mechanic']=0 },
    objHash = 1715394473,
    slides = true,
    lockpick = false,
    locked = false,
    objCoords = vec3(-1427.326050, -444.151581, 34.903519),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- garage1_mechainc created by DAD?
Config.DoorList['garage1_mechainc'] = {
    audioRemote = false,
    objHeading = 31.999959945679,
    fixText = false,
    maxDistance = 6.0,
    authorizedJobs = { ['mechanic']=0 },
    objHash = 1715394473,
    slides = true,
    lockpick = false,
    locked = false,
    objCoords = vec3(-1421.117554, -440.272064, 34.903519),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- garage3_mechainc created by DAD?
Config.DoorList['garage3_mechainc'] = {
    audioRemote = false,
    objHeading = 31.999959945679,
    fixText = false,
    maxDistance = 6.0,
    authorizedJobs = { ['mechanic']=0 },
    objHash = 1715394473,
    slides = true,
    lockpick = false,
    locked = false,
    objCoords = vec3(-1414.868896, -436.367523, 34.903519),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- staff_mechainc created by DAD?
Config.DoorList['staff_mechainc'] = {
    audioRemote = false,
    objHeading = 302.0,
    fixText = false,
    maxDistance = 2.0,
    authorizedJobs = { ['mechanic']=0 },
    objHash = 1289778077,
    slides = false,
    lockpick = false,
    locked = true,
    objCoords = vec3(-1427.525146, -455.680450, 36.059563),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- entry_mechainc created by DAD?
Config.DoorList['entry_mechainc'] = {
    audioRemote = false,
    objHeading = 31.999956130981,
    fixText = false,
    maxDistance = 2.0,
    authorizedJobs = { ['mechanic']=0 },
    objHash = -634936098,
    slides = false,
    lockpick = false,
    locked = false,
    objCoords = vec3(-1434.155029, -448.586090, 36.059235),
    garage = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}



-- Garage1_tuner created by DAD?
Config.DoorList['Garage1_tuner'] = {
    maxDistance = 6.0,
    authorizedJobs = { ['tuner']=0 },
    garage = true,
    locked = false,
    objHeading = 89.999961853027,
    fixText = false,
    audioRemote = false,
    slides = true,
    lockpick = false,
    objHash = -456733639,
    objCoords = vec3(154.809525, -3023.889160, 8.503336),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Garage2_tuner created by DAD?
Config.DoorList['Garage2_tuner'] = {
    maxDistance = 6.0,
    authorizedJobs = { ['tuner']=0 },
    garage = true,
    locked = false,
    objHeading = 89.999961853027,
    fixText = false,
    audioRemote = false,
    slides = true,
    lockpick = false,
    objHash = -456733639,
    objCoords = vec3(154.809525, -3034.051270, 8.503336),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- entry_tuner created by DAD?
Config.DoorList['entry_tuner'] = {
    maxDistance = 2.0,
    authorizedJobs = { ['tuner']=0 },
    garage = false,
    locked = false,
    objHeading = 270.00003051758,
    fixText = false,
    audioRemote = false,
    slides = false,
    lockpick = false,
    objHash = -2023754432,
    objCoords = vec3(154.934464, -3017.322998, 7.190679),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- staff2_prison created by DAD?
Config.DoorList['staff2_prison'] = {
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    garage = false,
    locked = true,
    objHeading = 0.0,
    fixText = false,
    audioRemote = false,
    slides = false,
    lockpick = false,
    objHash = 2024969025,
    objCoords = vec3(1837.633789, 2576.991699, 46.038597),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- staff1_prison created by DAD?
Config.DoorList['staff1_prison'] = {
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    garage = false,
    locked = true,
    objHeading = 0.0,
    fixText = false,
    audioRemote = false,
    slides = false,
    lockpick = false,
    objHash = 2024969025,
    objCoords = vec3(1844.403809, 2576.997070, 46.035603),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lobbydoor_prison created by DAD?
Config.DoorList['lobbydoor_prison'] = {
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    garage = false,
    locked = true,
    objHeading = 0.0,
    fixText = false,
    audioRemote = false,
    slides = false,
    lockpick = false,
    objHash = -684929024,
    objCoords = vec3(1837.741943, 2592.161865, 46.039574),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- lobbyd1_prison created by DAD?
Config.DoorList['lobbyd1_prison'] = {
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    garage = false,
    locked = true,
    objHeading = 89.999961853027,
    fixText = false,
    audioRemote = false,
    slides = false,
    lockpick = false,
    objHash = -684929024,
    objCoords = vec3(1831.339966, 2594.992188, 46.037910),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- outside1_prison created by DAD?
Config.DoorList['outside1_prison'] = {
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    garage = false,
    locked = true,
    objHeading = 270.00003051758,
    fixText = false,
    audioRemote = false,
    slides = false,
    lockpick = false,
    objHash = 705715602,
    objCoords = vec3(1819.072876, 2594.873291, 46.090363),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate2_prison created by DAD?
Config.DoorList['gate2_prison'] = {
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    garage = false,
    locked = true,
    objHeading = 179.99987792969,
    fixText = false,
    audioRemote = false,
    slides = false,
    lockpick = false,
    objHash = -1156020871,
    objCoords = vec3(1798.089966, 2591.687012, 46.417839),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate3_prison created by DAD?
Config.DoorList['gate3_prison'] = {
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    garage = false,
    locked = true,
    objHeading = 179.99987792969,
    fixText = false,
    audioRemote = false,
    slides = false,
    lockpick = false,
    objHash = -1156020871,
    objCoords = vec3(1797.760986, 2596.564941, 46.387310),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- cafe1_prison created by DAD?
Config.DoorList['cafe1_prison'] = {
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    garage = false,
    locked = true,
    objHeading = 89.999977111816,
    fixText = false,
    audioRemote = false,
    slides = false,
    lockpick = false,
    objHash = 705715602,
    objCoords = vec3(1791.595703, 2551.462158, 45.753204),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- cafe2_prison created by DAD?
Config.DoorList['cafe2_prison'] = {
    maxDistance = 2.0,
    authorizedJobs = { ['police']=0 },
    garage = false,
    locked = false,
    objHeading = 270.00003051758,
    fixText = false,
    audioRemote = false,
    slides = false,
    lockpick = false,
    objHash = 705715602,
    objCoords = vec3(1776.195679, 2552.563232, 45.747406),
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- ICU_prison created by DAD?
Config.DoorList['ICU_prison'] = {
    maxDistance = 2.5,
    authorizedJobs = { ['police']=0, ['ambulance']=0 },
    slides = false,
    audioRemote = false,
    lockpick = false,
    doors = {
        {objHash = -1624297821, objHeading = 180.00006103516, objCoords = vec3(1764.026245, 2589.564209, 45.753090)},
        {objHash = -1624297821, objHeading = 3.8476657209685e-05, objCoords = vec3(1766.325195, 2589.564209, 45.753090)}
    },
    locked = false,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- surgery_prison created by DAD?
Config.DoorList['surgery_prison'] = {
    maxDistance = 2.5,
    authorizedJobs = { ['police']=0, ['ambulance']=0 },
    slides = false,
    audioRemote = false,
    lockpick = false,
    doors = {
        {objHash = -1624297821, objHeading = 270.0, objCoords = vec3(1767.320923, 2582.307861, 45.753448)},
        {objHash = -1624297821, objHeading = 90.000007629395, objCoords = vec3(1767.320923, 2584.607178, 45.753448)}
    },
    locked = true,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- infermstaff_prison created by DAD?
Config.DoorList['infermstaff_prison'] = {
    maxDistance = 2.0,
    objHash = 2074175368,
    objCoords = vec3(1772.813477, 2570.296387, 45.744675),
    slides = false,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 4.8494574002689e-05,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate4_prison created by DAD?
Config.DoorList['gate4_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1774.645020, 2534.517090, 44.694859),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 59.86828994751,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate5_prison created by DAD?
Config.DoorList['gate5_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1798.570557, 2530.107910, 44.694878),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 184.86828613281,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate6_prison created by DAD?
Config.DoorList['gate6_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1813.749023, 2488.906982, 44.463680),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 251.97775268555,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate7_prison created by DAD?
Config.DoorList['gate7_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1808.991943, 2474.544922, 44.480770),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 70.905715942383,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate8_prison created by DAD?
Config.DoorList['gate8_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1762.541992, 2426.507080, 44.437870),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 206.12844848633,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate9_prison created by DAD?
Config.DoorList['gate9_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1749.141968, 2419.812012, 44.425171),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 26.757732391357,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate10_prison created by DAD?
Config.DoorList['gate10_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1667.668945, 2407.647949, 44.428791),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 173.00039672852,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate11_prison created by DAD?
Config.DoorList['gate11_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1652.984009, 2409.571045, 44.443081),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 353.00021362305,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate12_prison created by DAD?
Config.DoorList['gate12_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1558.221191, 2469.349121, 44.395287),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 118.04624938965,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate13_prison created by DAD?
Config.DoorList['gate13_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1550.930420, 2482.743408, 44.395287),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 298.04623413086,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate14_prison created by DAD?
Config.DoorList['gate14_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1546.983398, 2576.129639, 44.390327),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 87.0146484375,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate15_prison created by DAD?
Config.DoorList['gate15_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1547.706177, 2591.282227, 44.509468),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 267.01473999023,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate16_prison created by DAD?
Config.DoorList['gate16_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1575.719482, 2667.151855, 44.509468),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 54.548603057861,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate17_prison created by DAD?
Config.DoorList['gate17_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1584.652954, 2679.749023, 44.509472),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 233.70986938477,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate18_prison created by DAD?
Config.DoorList['gate18_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1648.411011, 2741.667969, 44.446690),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 27.17546081543,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate19_prison created by DAD?
Config.DoorList['gate19_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1662.010986, 2748.702881, 44.446690),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 207.17547607422,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate20_prison created by DAD?
Config.DoorList['gate20_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1762.196045, 2752.489014, 44.446690),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 339.62002563477,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate21_prison created by DAD?
Config.DoorList['gate21_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1776.701050, 2747.147949, 44.446690),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 160.00001525879,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate22_prison created by DAD?
Config.DoorList['gate22_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1830.134033, 2703.499023, 44.446701),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 289.16897583008,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate23_prison created by DAD?
Config.DoorList['gate23_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1835.285034, 2689.104004, 44.446701),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 110.00004577637,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate24_prison created by DAD?
Config.DoorList['gate24_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1799.608032, 2616.975098, 44.603249),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 179.99998474121,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate25_prison created by DAD?
Config.DoorList['gate25_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1818.542969, 2604.812012, 44.611000),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 89.999969482422,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate26_prison created by DAD?
Config.DoorList['gate26_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1844.998047, 2604.812012, 44.639778),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 89.999969482422,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate27_prison created by DAD?
Config.DoorList['gate27_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1663.384033, 2602.679932, 44.569740),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 89.868255615234,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate28_prison created by DAD?
Config.DoorList['gate28_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1653.932983, 2629.573975, 44.557159),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 137.86825561523,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- gate29_prison created by DAD?
Config.DoorList['gate29_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1625.689941, 2584.999023, 44.585781),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 179.86825561523,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Cellblock7_prison created by DAD?
Config.DoorList['Cellblock7_prison'] = {
    maxDistance = 2.0,
    objHash = 705715602,
    objCoords = vec3(1754.937134, 2501.868408, 46.041050),
    slides = false,
    garage = false,
    locked = false,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 209.93482971191,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- Cellblock6_prison created by DAD?
Config.DoorList['Cellblock6_prison'] = {
    maxDistance = 2.0,
    objHash = 705715602,
    objCoords = vec3(1693.423096, 2469.049561, 46.053631),
    slides = false,
    garage = false,
    locked = false,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 179.93481445312,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- GATEIDK_prison created by DAD?
Config.DoorList['GATEIDK_prison'] = {
    maxDistance = 6.0,
    objHash = 741314661,
    objCoords = vec3(1626.267944, 2531.435059, 44.560940),
    slides = true,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 179.86825561523,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- cellblock4_prison created by DAD?
Config.DoorList['cellblock4_prison'] = {
    maxDistance = 2.0,
    objHash = 705715602,
    objCoords = vec3(1597.704346, 2553.188721, 46.057663),
    slides = false,
    garage = false,
    locked = false,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 89.999961853027,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- GATEFUCK_prison created by DAD?
Config.DoorList['GATEFUCK_prison'] = {
    maxDistance = 2.0,
    objHash = -1156020871,
    objCoords = vec3(1626.454956, 2563.104980, 46.324810),
    slides = false,
    garage = false,
    locked = false,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 269.86828613281,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- LEGALVIST_prison created by DAD?
Config.DoorList['LEGALVIST_prison'] = {
    maxDistance = 2.0,
    objHash = -684929024,
    objCoords = vec3(1838.616943, 2593.705078, 46.036358),
    slides = false,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 270.00003051758,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- GARAGE1_prison created by DAD?
Config.DoorList['GARAGE1_prison'] = {
    maxDistance = 6.0,
    objHash = -982531572,
    objCoords = vec3(1839.011963, 2549.645020, 47.267849),
    slides = true,
    garage = true,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 90.029319763184,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- GARAGE2_prison created by DAD?
Config.DoorList['GARAGE2_prison'] = {
    maxDistance = 6.0,
    objHash = -982531572,
    objCoords = vec3(1839.011963, 2542.096924, 47.267849),
    slides = true,
    garage = true,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 90.029319763184,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- GARAGE3_prison created by DAD?
Config.DoorList['GARAGE3_prison'] = {
    maxDistance = 6.0,
    objHash = -982531572,
    objCoords = vec3(1839.011963, 2534.539062, 47.267849),
    slides = true,
    garage = true,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 90.029319763184,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}

-- GARAGEENTRY_prison created by DAD?
Config.DoorList['GARAGEENTRY_prison'] = {
    maxDistance = 2.0,
    objHash = 705715602,
    objCoords = vec3(1839.407959, 2529.919922, 46.118401),
    slides = false,
    garage = false,
    locked = true,
    audioRemote = false,
    fixText = false,
    lockpick = false,
    authorizedJobs = { ['police']=0 },
    objHeading = 269.38461303711,
    --oldMethod = true,
    --audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
    --audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
    --autoLock = 1000,
    --doorRate = 1.0,
    --showNUI = true
}