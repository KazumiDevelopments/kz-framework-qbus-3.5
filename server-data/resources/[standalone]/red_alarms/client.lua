RegisterNetEvent("prisonalarm:startalarmCL")
AddEventHandler('prisonalarm:startalarmCL', function()
while not PrepareAlarm("PRISON_ALARMS") do
		Citizen.Wait(0)
	end
	StartAlarm("PRISON_ALARMS", 1)
end)

RegisterNetEvent("prisonalarm:stopalarmCL")
AddEventHandler('prisonalarm:stopalarmCL', function()
StopAlarm("PRISON_ALARMS", -1)
end)

RegisterNetEvent("fortzalarm:startalarmCL")
AddEventHandler('fortzalarm:startalarmCL', function()
while not PrepareAlarm("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS") do
		Citizen.Wait(0)
	end
	StartAlarm("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS", 1)
end)

RegisterNetEvent("fortzalarm:stopalarmCL")
AddEventHandler('fortzalarm:stopalarmCL', function()
StopAlarm("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS", -1)
end)

RegisterNetEvent("pbalarm:startalarmCL")
AddEventHandler('pbalarm:startalarmCL', function()
while not PrepareAlarm("PALETO_BAY_SCORE_ALARM") do
		Citizen.Wait(0)
	end
	StartAlarm("PALETO_BAY_SCORE_ALARM", 1)
end)

RegisterNetEvent("pbalarm:stopalarmCL")
AddEventHandler('pbalarm:stopalarmCL', function()
StopAlarm("PALETO_BAY_SCORE_ALARM", -1)
end)

RegisterNetEvent("hlalarm:startalarmCL")
AddEventHandler('hlalarm:startalarmCL', function()
while not PrepareAlarm("FIB_05_BIOTECH_LAB_ALARMS") do
		Citizen.Wait(0)
	end
	StartAlarm("FIB_05_BIOTECH_LAB_ALARMS", 1)
end)

RegisterNetEvent("hlalarm:stopalarmCL")
AddEventHandler('hlalarm:stopalarmCL', function()
StopAlarm("FIB_05_BIOTECH_LAB_ALARMS", -1)
end)

RegisterNetEvent("udalarm:startalarmCL")
AddEventHandler('udalarm:startalarmCL', function()
while not PrepareAlarm("BIG_SCORE_HEIST_VAULT_ALARMS") do
		Citizen.Wait(0)
	end
	StartAlarm("BIG_SCORE_HEIST_VAULT_ALARMS", 1)
end)

RegisterNetEvent("udalarm:stopalarmCL")
AddEventHandler('udalarm:stopalarmCL', function()
StopAlarm("BIG_SCORE_HEIST_VAULT_ALARMS", -1)
end)

RegisterNetEvent("chfalarm:startalarmCL")
AddEventHandler('chfalarm:startalarmCL', function()
while not PrepareAlarm("PALETO_BAY_SCORE_CHICKEN_FACTORY_ALARM") do
		Citizen.Wait(0)
	end
	StartAlarm("PALETO_BAY_SCORE_CHICKEN_FACTORY_ALARM", 1)
end)

RegisterNetEvent("chfalarm:stopalarmCL")
AddEventHandler('chfalarm:stopalarmCL', function()
StopAlarm("PALETO_BAY_SCORE_CHICKEN_FACTORY_ALARM", -1)
end)

RegisterNetEvent("fbialarm:startalarmCL")
AddEventHandler('fbialarm:startalarmCL', function()
while not PrepareAlarm("AGENCY_HEIST_FIB_TOWER_ALARMS") do
		Citizen.Wait(0)
	end
	StartAlarm("AGENCY_HEIST_FIB_TOWER_ALARMS", 1)
	StartAlarm("AGENCY_HEIST_FIB_TOWER_ALARMS_UPPER", 1)
	StartAlarm("AGENCY_HEIST_FIB_TOWER_ALARMS_UPPER_B", 1)
	StartAlarm("FBI_01_MORGUE_ALARMS", 1)
end)

RegisterNetEvent("fbialarm:stopalarmCL")
AddEventHandler('fbialarm:stopalarmCL', function()
StopAlarm("AGENCY_HEIST_FIB_TOWER_ALARMS", -1)
StopAlarm("AGENCY_HEIST_FIB_TOWER_ALARMS_UPPER", -1)
StopAlarm("AGENCY_HEIST_FIB_TOWER_ALARMS_UPPER_B", -1)
StopAlarm("FBI_01_MORGUE_ALARMS", -1)
end)

RegisterNetEvent("jewelalarm:startalarmCL")
AddEventHandler('jewelalarm:startalarmCL', function()
while not PrepareAlarm("JEWEL_STORE_HEIST_ALARMS") do
		Citizen.Wait(0)
	end
	StartAlarm("JEWEL_STORE_HEIST_ALARMS", 1)
end)

RegisterNetEvent("jewelalarm:stopalarmCL")
AddEventHandler('jewelalarm:stopalarmCL', function()
StopAlarm("JEWEL_STORE_HEIST_ALARMS", -1)
end)
