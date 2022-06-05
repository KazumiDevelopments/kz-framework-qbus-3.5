--[[
	Antilag & 2-Step Script
		Created By T.Silence
			Custom audio & launch control
				Edited By SnowQT / Hal Croves
					Interact-Sound used to play custom audio
						Created	by Scott	
]]


ESX             = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("eff_flames")
AddEventHandler("eff_flames", function(entity)
	local source = source
	TriggerClientEvent("c_eff_flames", source, entity, "antilag")
	TriggerClientEvent("c_eff_flames2", source, entity, "PENIS")

end)

RegisterServerEvent("eff_flames2")
AddEventHandler("eff_flames2", function(entity)
	local source = source
	TriggerClientEvent("c_eff_flames", source, entity, "antilag")
	TriggerClientEvent("c_eff_flames2", source, entity, "PENIS")

end)

RegisterCommand("antilag", function(source, args, rawCommand)
	TriggerClientEvent("2step:Anti-lag", source, 0)
end)

RegisterCommand("2step", function(source, args, rawCommand)
	TriggerClientEvent("2step:2step", source, 0)
end)

RegisterCommand("launch", function(source, args, rawCommand)
	TriggerClientEvent("2step:launch", source, 0)
end)


RegisterServerEvent('InteractSound_SV:PlayWithinDistance')
AddEventHandler('InteractSound_SV:PlayWithinDistance', function(maxDistance, soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, source, maxDistance, soundFile, soundVolume)
end)

RegisterServerEvent('InteractSound_SV:PlayOnSource')
AddEventHandler('InteractSound_SV:PlayOnSource', function(soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:PlayOnOne', source, soundFile, soundVolume)
end)