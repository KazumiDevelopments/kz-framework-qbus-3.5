RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent('CrashTackle')
AddEventHandler('CrashTackle', function(playerId)
	TriggerClientEvent("playerTackled", playerId)
end)

RegisterServerEvent('undragTarget')
AddEventHandler('undragTarget', function(playerId)
	TriggerClientEvent("undragPlayer", playerId, source)
end)

RegisterServerEvent('dragTarget')
AddEventHandler('dragTarget', function(playerId)
	TriggerClientEvent("dragPlayer", playerId, source)
end)

RegisterServerEvent("rl-carry:beingCarried")
AddEventHandler("rl-carry:beingCarried", function(beingCarried)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	TriggerClientEvent("rl-carry:beingCarried", src, beingCarried)
	Player.Functions.SetMetaData('incarry', beingCarried)
end)