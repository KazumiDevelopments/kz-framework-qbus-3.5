local openingDoor = false

RegisterNetEvent("RLCore:Client:OnPlayerLoaded")
AddEventHandler("RLCore:Client:OnPlayerLoaded", function()
    RLCore.Functions.TriggerCallback('rl-pawnshop:melting:server:GetConfig', function(IsMelting, MeltTime, CanTake)
        Config.IsMelting = IsMelting
        Config.MeltTime = MeltTime
        Config.CanTake = CanTake
        isLoggedIn = true

        if Config.IsMelting then
            Citizen.CreateThread(function()
                while Config.IsMelting do
                    if isLoggedIn then
                        Config.MeltTime = Config.MeltTime - 1
                        if Config.MeltTime <= 0 then
                            Config.CanTake = true
                            Config.IsMelting = false
                        end
                    else
                        break
                    end
                    Citizen.Wait(1000)
                end
            end)
        end
    end)
end)

RegisterNetEvent("RLCore:Client:OnPlayerUnload")
AddEventHandler("RLCore:Client:OnPlayerUnload", function()
    Config.IsMelting = false
    Config.MeltTime = 300
    Config.CanTake = false
    isLoggedIn = false
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local inRange = false
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.MeltLocation.x, Config.MeltLocation.y, Config.MeltLocation.z, true) < 3.0 then
			inRange = true
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.MeltLocation.x, Config.MeltLocation.y, Config.MeltLocation.z, true) < 1.5 then
                if not Config.IsMelting then
                    if Config.CanTake then
                        DrawText3D(Config.MeltLocation.x, Config.MeltLocation.y, Config.MeltLocation.z, "[E] Grab gold bars")
                        if IsControlJustReleased(0, Keys["E"]) then
                            TriggerServerEvent("rl-pawnshop:server:getGoldBars")
                        end
                    else
                        DrawText3D(Config.MeltLocation.x, Config.MeltLocation.y, Config.MeltLocation.z, "[E] Melt gold items")
                        if IsControlJustReleased(0, Keys["E"]) then 
                            local waitTime = math.random(10000, 15000)
                            ScrapAnim(1000)
                            RLCore.Functions.Progressbar("drop_golden_stuff", "Grabbing items", 1000, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function() -- Done
                                if not Config.IsMelting then
                                    StopAnimTask(GetPlayerPed(-1), "mp_car_bomb", "car_bomb_mechanic", 1.0)
                                    TriggerServerEvent("rl-pawnshop:server:meltItems")
                                end
                            end)
                        end
                    end
                elseif Config.IsMelting and Config.MeltTime > 0 then
                    DrawText3D(Config.MeltLocation.x, Config.MeltLocation.y, Config.MeltLocation.z, "Melting:" .. Config.MeltTime..'s')
                end
			end
		end
		if not inRange then
			Citizen.Wait(2500)
		end
	end
end)
local sellItemsSet = false

function ScrapAnim(time)
    local time = time / 1000
    loadAnimDict("mp_car_bomb")
    TaskPlayAnim(GetPlayerPed(-1), "mp_car_bomb", "car_bomb_mechanic" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    Citizen.CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(2000)
            time = time - 2
            if time <= 0 then
                openingDoor = false
                StopAnimTask(GetPlayerPed(-1), "mp_car_bomb", "car_bomb_mechanic", 1.0)
            end
        end
    end)
end

function HasPlayerGold()
	local retval = false
	RLCore.Functions.TriggerCallback('rl-pawnshop:server:hasGold', function(result)
		retval = result
	end)
    Citizen.Wait(500)
	return retval
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

RegisterNetEvent('rl-pawnshop:client:startMelting')
AddEventHandler('rl-pawnshop:client:startMelting', function()
    if not Config.IsMelting then
        Config.IsMelting = true
        Config.MeltTime = 300
        Citizen.CreateThread(function()
            while Config.IsMelting do
                if isLoggedIn then
                    Config.MeltTime = Config.MeltTime - 1
                    if Config.MeltTime <= 0 then
                        Config.CanTake = true
                        Config.IsMelting = false
                    end
                else
                    break
                end
                Citizen.Wait(1000)
            end
        end)
    end
end)

RegisterNetEvent('rl-pawnshop:client:SetTakeState')
AddEventHandler('rl-pawnshop:client:SetTakeState', function(state)
    Config.CanTake = state
    Config.IsMelting = state
    if not state then
        Config.MeltTime = 300
    end

    RLCore.Functions.TriggerCallback('rl-pawnshop:melting:server:GetConfig', function(IsMelting, MeltTime, CanTake)
        Config.IsMelting = IsMelting
        Config.MeltTime = MeltTime
        Config.CanTake = CanTake
        isLoggedIn = true

        if Config.IsMelting then
            Citizen.CreateThread(function()
                while Config.IsMelting do
                    if isLoggedIn then
                        Config.MeltTime = Config.MeltTime - 1
                        if Config.MeltTime <= 0 then
                            Config.CanTake = true
                            Config.IsMelting = false
                        end
                    else
                        break
                    end
                    Citizen.Wait(1000)
                end
            end)
        end
    end)
end)