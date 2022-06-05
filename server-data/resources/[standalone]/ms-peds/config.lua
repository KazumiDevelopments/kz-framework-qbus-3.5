Config = {}

Config.Invincible = false -- Is the ped going to be invincible?
Config.Frozen = false -- Is the ped frozen in place?
Config.Stoic = false -- Will the ped react to events around them?
Config.FadeIn = true -- Will the ped fade in and out based on the distance. (Looks a lot better.)
Config.DistanceSpawn = 20.0 -- Distance before spawning/despawning the ped. (GTA Units.)

Config.MinusOne = true -- Leave this enabled if your coordinates grabber does not -1 from the player coords.

Config.GenderNumbers = { -- No reason to touch these.
	['male'] = 4,
	['female'] = 5
}

Config.PedList = {
	-- Barber Shops
	{
		model = `s_f_m_fembarber`, -- Model name as a hash.
		coords = vector4(-34.42, -151.15, 57.09, 180.0), -- Hawick Ave (X, Y, Z, Heading)
		gender = 'female' -- The gender of the ped, used for the CreatePed native.
	},

	{
		model = `s_f_m_fembarber`,
		coords = vector4(-279.89, 6227.61, 31.71, 50.0), -- Paleto Bay
		gender = 'female'
	},

	{
		model = `s_f_m_fembarber`,
		coords = vector4(1933.71, 3730.42, 32.85, 210.0), -- Sandy Shores
		gender = 'female'
	},

	{
		model = `s_f_m_fembarber`,
		coords = vector4(-817.19, -183.30, 37.57, 130.0), -- Mad Wayne Thunder Drive
		gender = 'female'
	},

	{
		model = `s_f_m_fembarber`,
		coords = vector4(-1283.62, -1119.24, 7.00, 110.0), -- Magellan Ave
		gender = 'female'
	},

	{
		model = `s_f_m_fembarber`,
		coords = vector4(137.61, -1709.78, 29.30, 320.0), -- Carson Ave
		gender = 'female'
	},

	-- Clothing Stores
	{
		model = `s_f_y_shop_low`,
		coords = vector4(1.20, 6508.53, 31.88, 330.0), -- Paleto Bay
		gender = 'female'
	},

	{
		model = `s_f_y_shop_low`,
		coords = vector4(1695.00, 4817.49, 42.06, 360.0), -- Grapeseed
		gender = 'female'
	},

	{
		model = `s_f_y_shop_mid`,
		coords = vector4(126.91, -224.29, 54.56, 90.0), -- Hawick Ave
		gender = 'female'
	},

	{
		model = `s_f_m_shop_high`,
		coords = vector4(-709.06, -151.46, 37.42, 120.0), -- Portola Drive
		gender = 'female'
	},

	{
		model = `s_f_m_shop_high`,
		coords = vector4(-1448.41, -237.54, 49.81, 60.0), -- Cougar Ave
		gender = 'female'
	},

	{
		model = `s_f_m_shop_high`,
		coords = vector4(-165.24, -303.62, 39.73, 260.0), -- Las Lagunas Blvd
		gender = 'female'
	},

	{
		model = `s_f_y_shop_mid`,
		coords = vector4(-1194.10, -767.09, 17.32, 220.0), -- North Rockford Drive
		gender = 'female'
	},

	{
		model = `s_f_y_shop_low`,
		coords = vector4(425.88, -811.50, 29.49, 20.0), -- Sinner Street
		gender = 'female'
	},

	{
		model = `s_f_y_shop_low`,
		coords = vector4(-818.20, -1070.43, 11.33, 120.0), -- South Rockford Drive
		gender = 'female'
	},

	{
		model = `s_f_y_shop_low`,
		coords = vector4(75.20, -1387.62, 29.38, 210.0), -- Innocence Blvd
		gender = 'female'
	},

	{
		model = `s_f_y_shop_mid`,
		coords = vector4(613.04, 2762.49, 42.09, 280.0), -- Grapeseed
		gender = 'female'
	},

	{
		model = `s_f_y_shop_low`,
		coords = vector4(1201.97, 2710.80, 38.22, 100.0), -- Harmony
		gender = 'female'
	},

	{
		model = `s_f_y_shop_low`,
		coords = vector4(-1097.96, 2714.62, 19.11, 140.0), -- Route 68
		gender = 'female'
	},

	{
		model = `s_f_y_shop_low`,
		coords = vector4(-3169.38, 1043.18, 20.86, 50.0), -- Great Ocean Highway
		gender = 'female'
	},
	-- BANK PED'S
	{
		model = `ig_bankman`,
		coords = vector4(241.44, 227.19, 106.29, 170.43),
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle'
	},
	{
		model = `ig_bankman`,
		coords = vector4(313.84, -280.58, 54.16, 338.31), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle'
	},
	{
		model = `ig_bankman`, 
		coords = vector4(149.46, -1042.09, 29.37, 335.43), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle'
	},
	{
		model = `ig_bankman`, 
		coords = vector4(-351.23, -51.28, 49.04, 341.73), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle'
	},
	{
		model = `ig_bankman`, 
		coords = vector4(-1211.9, -331.9, 37.78, 20.07), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle'
	},
	{
		model = `ig_bankman`, 
		coords = vector4(-2961.14, 483.09, 15.7, 83.84), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle'
	},
	{
		model = `ig_bankman`, 
		coords = vector4(1174.8, 2708.2, 38.09, 178.52), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle'
	},
	{
		model = `ig_bankman`, 
		coords = vector4(-112.22, 6471.01, 31.63, 134.18), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions',
		animName = 'cop_b_idle'
	},
	--PD 
	{
		model = `ig_trafficwarden`, 
		coords = vector4(413.0473, -1024.108, 29.503236, 94.807708), 
		gender = 'male', 
		animDict = 'anim@heists@prison_heiststation@cop_reactions', 
		animName = 'cop_b_idle'
	},
	--ToolPeds
	{
		model = `cs_floyd`, 
		coords = vector4(45.141063, -1748.34, 29.555221, 45.292907), 
		gender = 'male', 
	},
	-- Store Clerks
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(1727.8383, 6415.2998, 35.0372, 237.7803), -- 24/7 Senora Freeway Utool
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'		
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(2677.8523, 3279.2815, 55.2411, 327.3371), -- 24/7 Senora Paleto
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'		
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(1698.0909, 4922.7100, 42.0636, 318.4146), -- LTD. Gas - Grapeseed
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'		
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(1959.8857, 3739.9534, 32.3438, 298.0646), -- Sandy Shores 24/7
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'		
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(2557.2183, 380.6950, 108.6230, 1.9620), -- 24/7 Gas Palimino Fwy
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'		
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(1166.0024, 2710.8669, 38.1577, 171.9204), -- Harmony Robs Liquor
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'		
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(549.2151, 2671.2429, 42.1565, 85.3526), -- 24/7 Harmony
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'		
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(-3242.3149, 999.8690, 12.8307, 354.1691), -- 24/7 Barbareono Rd. 
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'		
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(-3038.9753, 584.5553, 7.9089, 13.4241), -- 24/7 Inseno Rd. 
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'		
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(-2966.4250, 390.8515, 15.0433, 84.9697), -- Robs Liquor GOH
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'		
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(-1221.9572, -908.3364, 12.3263, 32.2396), -- Robs Liquor San Andreas Ave
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'		
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(-706.0817, -915.4422, 19.2156, 91.6470), -- LTD. Little Seoul
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'		
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(-46.7397, -1757.8669, 29.4210, 43.2014), -- LTD. Grove
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'		
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(372.5850, 326.4227, 103.5664, 247.0649), -- 24/7 Clinton Ave. 
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'		
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(1164.6998, -322.6867, 69.2051, 98.0899), -- LTD Gas. Mirror Park
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'	
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(1134.2421, -982.4398, 46.4158, 272.1794), -- Robs Liquor El Rancho	
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'	
	},
	{
		model = `mp_m_shopkeep_01`, 
		coords = vector4(24.5012, -1347.3879, 29.4970, 271.8180), -- 24/7 Innocence
		gender = 'male',
		animDict = 'anim@amb@nightclub@lazlow@ig1_vip@',
		animName = 'clubvip_base_laz'	
	},
	{ -- Ammunations
		model = `s_m_y_ammucity_01`, 
		coords = vector4(23.8852, -1105.9779, 29.7970, 154.4946), -- San Andreas Ave
		gender = 'male',
		animDict = 'anim@heists@heist_corona@single_team',
		animName = 'single_team_loop_boss'	
	},
	{ 
		model = `s_m_y_ammucity_01`, 
		coords = vector4(808.8728, -2159.0381, 29.6190, 1.6373), -- Popular St
		gender = 'male',
		animDict = 'anim@heists@heist_corona@single_team',
		animName = 'single_team_loop_boss'	
	},		
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(-660.9344, -933.5817, 21.8292, 165.5856), -- Little Seoul
		gender = 'male',
		animDict = 'anim@heists@heist_corona@single_team',
		animName = 'single_team_loop_boss'	
	},		
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(-1304.4987, -395.9834, 36.6958, 76.6630), -- Marathon Ave / Boulevard Del Pero
		gender = 'male',
		animDict = 'anim@heists@heist_corona@single_team',
		animName = 'single_team_loop_boss'	
	},		
	{ 
		model = `s_m_y_ammucity_01`, 
		coords = vector4(-3173.0732, 1089.5426, 20.8387, 250.1212), -- GOH
		gender = 'male',
		animDict = 'anim@heists@heist_corona@single_team',
		animName = 'single_team_loop_boss'	
	},		
	{ 
		model = `s_m_y_ammucity_01`, 
		coords = vector4(-1117.9327, 2700.6331, 18.5541, 228.5580), --R68
		gender = 'male',
		animDict = 'anim@heists@heist_corona@single_team',
		animName = 'single_team_loop_boss'	
	},		
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(-330.6958, 6085.9702, 31.4548, 224.5260), -- Paleto
		gender = 'male',
		animDict = 'anim@heists@heist_corona@single_team',
		animName = 'single_team_loop_boss'	
	},		
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(1693.1450, 3762.0181, 34.7053, 217.5376), -- Sandy Shores
		gender = 'male',
		animDict = 'anim@heists@heist_corona@single_team',
		animName = 'single_team_loop_boss'	
	},		
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(2566.6487, 292.6444, 108.7349, 2.8016), -- Palimino Fwy
		gender = 'male',
		animDict = 'anim@heists@heist_corona@single_team',
		animName = 'single_team_loop_boss'	
	},		
			

}


