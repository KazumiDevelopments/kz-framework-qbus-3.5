--Main Thread
Citizen.CreateThread(function()
	sleep = 1000
	while true do
		ped = PlayerPedId() 
		pedc = GetEntityCoords(ped, true)

		for k,v in pairs(Config.MetalDetectors) do 
			if #(pedc - v) < 4.0 then
				sleep = 10
				if #(pedc - v) < 1.0 then
					TriggerServerEvent('rl-metaldetector:checkForWeapons', v)
					Wait(500)
				end
			else 
				sleep = 1000
			end 
		end

		Citizen.Wait(sleep)
	end
end)

RegisterNetEvent('rl-metaldetector:playSound')
AddEventHandler('rl-metaldetector:playSound', function(coords)
	ped = PlayerPedId() 
	pedc = GetEntityCoords(ped, true)
	if #(pedc - coords) <= 5.0 then
		PlaySoundFromCoord(-1, "CHECKPOINT_MISSED", coords.x,coords.y,coords.z, 'HUD_MINI_GAME_SOUNDSET', 0,5,1)
	end
end)

