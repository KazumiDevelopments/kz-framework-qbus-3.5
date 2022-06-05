local sv_maxClients = 128
local sv_players = 0
local q = 0

RegisterNetEvent('rl-core:client:updatePlayers')
AddEventHandler('rl-core:client:updatePlayers', function(playerSSs)
    sv_players = #playerSSs

    TriggerEvent("debug", 'RLCore: Update Players Count #' .. sv_players, 'normal')
end)

Citizen.CreateThread(function()
    while true do
		SetDiscordAppId(747671382690627624)
		SetDiscordRichPresenceAsset('logo')
        SetDiscordRichPresenceAssetText('ConnectRP')
        if q > 0 then
            SetRichPresence(#GetActivePlayers() .. '/' .. sv_maxClients .. ' players | ' .. q .. ' Q.')
        else
            SetRichPresence(#GetActivePlayers() .. '/' .. sv_maxClients .. ' Players.')
        end
        Citizen.Wait(35000)
	end
end)
