local DoorLocked = false --SET BACK TO FALSE IF WE WANT TO LEWL
local Objects, POIOffsets = {}, {}
local drugStorePed = nil

CreateThread(function()
    Wait(500)
    TriggerServerEvent('rl-oxyruns:server:doorState')

    while true do
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)
        local letSleep = true

        local distance = {}
        local whitelisted = true --(RLCore and RLCore.Functions.GetPlayerData().job and RLCore.Functions.GetPlayerData().job.name == 'drugdealer')
        local isboss = (RLCore and RLCore.Functions.GetPlayerData().job and RLCore.Functions.GetPlayerData().job.isboss)

        for k,v in pairs(Config.Locations) do
            distance[k] = Vdist2(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
            if (distance[k] < 20) then
                letSleep = false
            end
        end

        if (distance['enter'] < 5) then
            if (whitelisted) then
                DrawText3Ds(Config.Locations['enter'].x, Config.Locations['enter'].y, Config.Locations['enter'].z, "Press [E] to enter")
                --DrawText3Ds(Config.Locations['enter'].x, Config.Locations['enter'].y, Config.Locations['enter'].z, "[E] - Enter | [H] - " .. (DoorLocked and "Unlock" or "Lock"))
                --if (IsControlJustPressed(0, 74)) then 
                --    openDoorAnim()
                --    TriggerServerEvent('rl-oxyruns:server:doorState', not DoorLocked)
                --end
            elseif not DoorLocked then
                DrawText3Ds(Config.Locations['enter'].x, Config.Locations['enter'].y, Config.Locations['enter'].z, "Press [E] to enter")
            end

            if IsControlJustPressed(0, 38) and (whitelisted or not DoorLocked) then
                openDoorAnim()
                Wait(500)
                Objects, POIOffsets = exports['rl-interior']:CreateGunshopShell({ x = plyCoords.x, y = plyCoords.y, z = plyCoords.z-50.0, h = GetEntityHeading(plyPed) })
                CreateDrugStorePed()
            end
        elseif (distance['exit'] < 5) then
            if (whitelisted) then
                DrawText3Ds(Config.Locations['exit'].x, Config.Locations['exit'].y, Config.Locations['exit'].z, --[[ DoorLocked and "Locked" or ]] "Press [E] to leave")
                --DrawText3Ds(Config.Locations['exit'].x, Config.Locations['exit'].y, Config.Locations['exit'].z, "[E] - Leave | [H] - " .. (DoorLocked and "Unlock" or "Lock"))
                --if (IsControlJustPressed(0, 74)) then 
                --    openDoorAnim()
                --    TriggerServerEvent('rl-oxyruns:server:doorState', not DoorLocked)
                --end
            else
                DrawText3Ds(Config.Locations['exit'].x, Config.Locations['exit'].y, Config.Locations['exit'].z, --[[ DoorLocked and "Locked" or ]] "Press [E] to leave")
            end

            if IsControlJustPressed(0, 38) and (whitelisted --[[ or not DoorLocked ]]) then
                openDoorAnim()
                Wait(500)
                DoScreenFadeOut(500)
                while not IsScreenFadedOut() do
                    Wait(10)
                end
                CleanUpArea(function()
                    SetEntityCoords(PlayerPedId(), Config.Locations['enter'].x, Config.Locations['enter'].y, Config.Locations['enter'].z)
                    Wait(1000)
                    DoScreenFadeIn(500)
                end)
            end
        elseif (whitelisted) then
            if (distance['stash'] < 5) then
                DrawText3Ds(Config.Locations['stash'].x, Config.Locations['stash'].y, Config.Locations['stash'].z, "[E] - Stash")
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "oxyruns", {
                        maxweight = 4000000,
                        slots = 500,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", "oxyruns")
                end
            elseif (distance['shop'] < 5) then
                DrawText3Ds(Config.Locations['shop'].x, Config.Locations['shop'].y, Config.Locations['shop'].z, "[E] - Shop")
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent("inventory:server:OpenInventory", "shop", "oxyruns", Config.Shop)
                end
            elseif (distance['boss'] < 5 and isboss) then
                DrawText3Ds(Config.Locations['boss'].x, Config.Locations['boss'].y, Config.Locations['boss'].z, "[E] - Boss Menu")
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent("bb-bossmenu:server:openMenu")
                end
            end
        end

        if (letSleep) then
            Wait(1000)
        else
            Wait(1)
        end
    end
end)

RegisterNetEvent('rl-oxyruns:client:doorState')
AddEventHandler('rl-oxyruns:client:doorState', function(bool)
    DoorLocked = bool
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function CleanUpArea(cb)
    local playerped = PlayerPedId()
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = #(plycoords - pos)
        if distance < 10.0 and ObjectFound ~= playerped then
        	if IsEntityAPed(ObjectFound) then
        		if IsPedAPlayer(ObjectFound) then
        		else
        			DeleteObject(ObjectFound)
        		end
        	else
        		if not IsEntityAVehicle(ObjectFound) and not IsEntityAttached(ObjectFound) then
	        		DeleteObject(ObjectFound)
	        	end
        	end            
        end
        success, ObjectFound = FindNextObject(handle)
    until not success

    SetEntityAsNoLongerNeeded(drugStorePed)
    DeleteEntity(drugStorePed)

    EndFindObject(handle)
    DeleteCreatedPed()

    if cb then
        cb()
    end
end

function CreateDrugStorePed()

	if DoesEntityExist(drugStorePed) then
		return
    end
    
	local hashKey = `g_m_m_chigoon_02`
	local pedType = GetPedType(hashKey)
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end
	drugStorePed = CreatePed(pedType, hashKey, Config.Locations['ped']["x"],Config.Locations['ped']["y"],Config.Locations['ped']["z"]-0.9, Config.Locations['ped']["h"], false, 1)
    ClearPedTasks(drugStorePed)
    ClearPedSecondaryTask(drugStorePed)
    TaskSetBlockingOfNonTemporaryEvents(drugStorePed, true)
    SetPedFleeAttributes(drugStorePed, 0, 0)
    SetPedCombatAttributes(drugStorePed, 17, 1)

    SetPedSeeingRange(drugStorePed, 0.0)
    SetPedHearingRange(drugStorePed, 0.0)
    SetPedAlertness(drugStorePed, 0)
    SetPedKeepTask(drugStorePed, true)
    FreezeEntityPosition(drugStorePed, true)
end

function DeleteCreatedPed()
	if DoesEntityExist(deliveryPed) then 
		SetPedKeepTask(deliveryPed, false)
		TaskSetBlockingOfNonTemporaryEvents(deliveryPed, false)
		ClearPedTasks(deliveryPed)
		TaskWanderStandard(deliveryPed, 10.0, 10)
		SetPedAsNoLongerNeeded(deliveryPed)

		Citizen.Wait(100)
		DeletePed(deliveryPed)
	end
end

RegisterNetEvent("rl-oxyruns:client:AcceptBribe")
AddEventHandler("rl-oxyruns:client:AcceptBribe", function()
    openDoorAnim()
    PlayAmbientSpeech1(drugStorePed, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
    openDoorAnim(drugStorePed)
end)

RegisterNetEvent("rl-oxyruns:client:nope")
AddEventHandler("rl-oxyruns:client:nope", function()
    RLCore.Functions.Notify('We aint needing no help right now - come back later.', "error")
	PlayAmbientSpeech1(drugStorePed, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
end)

function openDoorAnim(ped)
    local ped = ped ~= nil and ped or PlayerPedId()
    loadAnimDict("anim@heists@keycard@") 
    TaskPlayAnim( ped, "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
	SetTimeout(400, function()
		ClearPedTasks(ped)
	end)
end

local blip = nil
function RefreshBlip()
    if blip and DoesBlipExist(blip) then
        RemoveBlip(blip)
    end

    if (RLCore and RLCore.Functions.GetPlayerData().job and RLCore.Functions.GetPlayerData().job.name == 'drugdealer') then
        blip = AddBlipForCoord(Config.Locations['enter'].x, Config.Locations['enter'].y, Config.Locations['enter'].z)

		SetBlipSprite (blip, 351)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		--SetBlipColour (blip, 3)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Business')
		EndTextCommandSetBlipName(blip)
    end
end