RegisterNetEvent('bb-911:client:createBlip')
AddEventHandler('bb-911:client:createBlip', function(type, coords, name, message, id, source)
    plyData = RLCore.Functions.GetPlayerData()
    PlayerJob = plyData.job

	if ((PlayerJob.name == "police" or PlayerJob.name == "ambulance") and PlayerJob.onduty) or (source == GetPlayerServerId(PlayerId())) then
		local blip = AddBlipForCoord(coords)
		SetBlipSprite(blip, 280)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, typ == "police" and 1 or 3)
		SetBlipAsShortRange(blip, false)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(type == "police" and "Police Call" or "Ambulance Call")
		EndTextCommandSetBlipName(blip)

		if type == "police" then
            TriggerEvent('chat:addMessage', {template = '<div class="chat-message" style="background-color: rgba(163, 62, 48, 0.85);"><b>Police 911 #' .. id .. ' | ' .. name .. '</b> ' .. message .. '</div>'})
		elseif type == "ems" then
			TriggerEvent('chat:addMessage', {template = '<div class="chat-message" style="background-color: rgba(163, 62, 48, 0.85);"><b>Paramedic 311 #' .. id .. ' | ' .. name .. '</b> ' .. message .. '</div>'})
		end

		TriggerEvent("InteractSound_CL:PlayOnOne", "demo", 0.4) 

		Citizen.Wait(60000) 
		RemoveBlip(blip)
	end
end)

RegisterNetEvent('bb-911:client:reply')
AddEventHandler('bb-911:client:reply', function(type, id, message,officer, source)
	if ((PlayerJob.name == "police" or PlayerJob.name == "ambulance") and PlayerJob.onduty) or (source == GetPlayerServerId(PlayerId())) then
		TriggerEvent('chat:addMessage', {template = '<div class="chat-message server"><b>Emergency Call ' .. (type == 'police' and '911' or '311') .. 'r #' .. id .. ' | ' .. officer .. '</b> ' .. message .. '</div>'})
		TriggerEvent("InteractSound_CL:PlayOnOne", "demo", 0.4)
	end
end)

RegisterNetEvent('bb-911:client:justcalled')
AddEventHandler('bb-911:client:justcalled', function()
	if RLCore.Functions.GetPlayerData().metadata["isdead"] or IsEntityPlayingAnim(PlayerPedId(), "cellphone@", "cellphone_call_listen_base", 3) or IsPedRagdoll(PlayerPedId()) then
		return
	end

    RequestAnimDict("cellphone@")
    while ( not HasAnimDictLoaded( "cellphone@" ) ) do
        Wait(10)
    end

    TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_call_listen_base", 2.0, 1.0, -1, 49, 0, 0, 0, 0)
    attachPropPhone()

    Wait(5000)

    ClearPedTasks(PlayerPedId())
    removeAttachedPropPhone()
end)

function removeAttachedPropPhone()
	if DoesEntityExist(attachedPropPhone) then
		DeleteEntity(attachedPropPhone)
		attachedPropPhone = 0
	end
end

function attachPropPhone()
    removeAttachedPropPhone()
	attachModelPhone = GetHashKey('prop_player_phone_01')
	SetCurrentPedWeapon(PlayerPedId(), 0xA2719263)
    local bone = GetPedBoneIndex(PlayerPedId(), 57005)
    
    
	RequestModel(attachModelPhone)
	while not HasModelLoaded(attachModelPhone) do
		Citizen.Wait(100)
    end
    
	attachedPropPhone = CreateObject(attachModelPhone, 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(attachedPropPhone, PlayerPedId(), bone, 0.14, 0.01, -0.02, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
end

RegisterCommand('lfmso', function()
	local nearbyVehicles = RLCore.Functions.GetVehicles()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k, v in pairs(nearbyVehicles) do
		if #(GetEntityCoords(v) - coords) <= 50.0 then
		end
	end
end)