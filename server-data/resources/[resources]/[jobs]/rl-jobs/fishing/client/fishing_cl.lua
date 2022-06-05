
RLCore = nil
cachedData = {}
isLoggedIn = false

local JobBusy = false

Citizen.CreateThread(function()
	while not RLCore do
		TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

		Citizen.Wait(0)
	end
end)

RegisterNetEvent('RLCore:Client:OnPlayerLoaded')
AddEventHandler('RLCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    GarbageVehicle = nil
    IsWorking = false
end)



function CreateBlips()
	for i, zone in ipairs(Config.FishingZones) do
		local coords = zone.secret and ((zone.coords / 1.5) - 133.37) or zone.coords
		local name = zone.name
		if not zone.secret then
			local x = AddBlipForCoord(coords)
			SetBlipSprite (x, 405)
			SetBlipDisplay(x, 4)
			SetBlipScale  (x, 0.35)
			SetBlipAsShortRange(x, true)
			SetBlipColour(x, 69)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName(name)
			EndTextCommandSetBlipName(x)
		end
	end
end

function DeleteBlips()
	if DoesBlipExist(coords) then
		RemoveBlip(coords)
	end
end

-- function SellFish()


RegisterNetEvent("rl-fishing:tryToFish")
AddEventHandler("rl-fishing:tryToFish", function()
	TryToFish() 
end)

RegisterNetEvent("rl-fishing:calculatedistances")
AddEventHandler("rl-fishing:calculatedistances", pos, function()

end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	HandleStore()
	while true do
		local sleepThread = 500
		local ped = cachedData["ped"]
		if DoesEntityExist(cachedData["storeOwner"]) then
			local pedCoords = GetEntityCoords(ped)
			local dstCheck = #(pedCoords - GetEntityCoords(cachedData["storeOwner"]))
			if dstCheck < 3.0 then
				if JobBusy == true then
					sleepThread = 5
					local displayText = not IsEntityDead(cachedData["storeOwner"]) and "Press ~INPUT_CONTEXT~ to sell your fish to the owner." or "The owner is dead, and therefore can not speak."
					if IsControlJustPressed(0, 38) then
                        RLCore.Functions.Notify("Yo, Thanks for the Fish!.. But did you know the taco shop is in high demands right now?")
						DeleteBlips()
						SellFish()
					end
					ShowHelpNotification(displayText)
				elseif JobBusy == false then
					sleepThread = 5
					local displayText = not IsEntityDead(cachedData["storeOwner"]) and "Press ~INPUT_CONTEXT~ to start working."
					if IsControlJustPressed(0, 38) then
                        RLCore.Functions.Notify("I have given you locations to fish, Enjoy!")
						JobBusy = true
						CreateBlips()
						Citizen.Wait(5000)
					end
					ShowHelpNotification(displayText)
				end
			end
		end
		Citizen.Wait(sleepThread)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)

		local ped = PlayerPedId()

		if cachedData["ped"] ~= ped then
			cachedData["ped"] = ped
		end
	end
end)


TryToFish = function()
    RLCore.Functions.TriggerCallback('rl-fishing:GetItemData', function(count)
        if IsPedSwimming(cachedData["ped"]) then return RLCore.Functions.Notify("You can't be swimming and fishing at the same time.", "error") end 
        if IsPedInAnyVehicle(cachedData["ped"]) then return RLCore.Functions.Notify("You need to exit your vehicle to start fishing.", "error") end 
        if count ~= nil then
            if count == 0 then
                RLCore.Functions.Notify("You need both a fishing rod and bait to fish.", "primary")
            else
                local waterValidated, castLocation = IsInWater()

                if waterValidated then
                    local fishingRod = GenerateFishingRod(cachedData["ped"])

                    CastBait(fishingRod, castLocation)
                else
                    RLCore.Functions.Notify("You need to aim towards the water to fish", "primary")
                end
            end
        end
    end, Config.FishingItems["rod"]["name"], Config.FishingItems["bait"]["name"])
end

local isFishing = false
CastBait = function(rodHandle, castLocation)
    if isFishing then return end
    isFishing = true

    local startedCasting = GetGameTimer()

    if not HasFishingBait() then
        RLCore.Functions.Notify('You don\'t have any bait!', 'error')

        isFishing = false
        return DeleteEntity(rodHandle)
    end

    while not IsControlJustPressed(0, 47) do
        Citizen.Wait(5)

        ShowHelpNotification("Cast your line by pressing ~INPUT_DETONATE~")

        if GetGameTimer() - startedCasting > 5000 then
            RLCore.Functions.Notify("You need to cast the bait.", "primary")

            isFishing = false
            return DeleteEntity(rodHandle)
        end
    end

    PlayAnimation(cachedData["ped"], "mini@tennis", "forehand_ts_md_far", {
        ["flag"] = 48
    })

    while IsEntityPlayingAnim(cachedData["ped"], "mini@tennis", "forehand_ts_md_far", 3) do
        Citizen.Wait(0)
    end

    PlayAnimation(cachedData["ped"], "amb@world_human_stand_fishing@idle_a", "idle_c", {
        ["flag"] = 11
    })

    local startedBaiting = GetGameTimer()
    local randomBait = math.random(10000, 30000)

    --DrawBusySpinner("Waiting for a fish that is biting..")
    RLCore.Functions.Notify("Waiting for a fish to bite...", "success", "10000")
    TriggerServerEvent('RLCore:Server:RemoveItem', "fishingbait", 1)
	TriggerEvent("inventory:client:ItemBox", RLCore.Shared.Items["fishingbait"], "remove")

    local interupted = false

    Citizen.Wait(1000)

    while GetGameTimer() - startedBaiting < randomBait do
        Citizen.Wait(5)

        if not IsEntityPlayingAnim(cachedData["ped"], "amb@world_human_stand_fishing@idle_a", "idle_c", 3) then
            interupted = true

            break
        end
    end

    RemoveLoadingPrompt()

    if interupted then
        ClearPedTasks(cachedData["ped"])

        isFishing = false
        CastBait(rodHandle, castLocation)
        return DeleteEntity(rodHandle)
    end
    
    local caughtFish = TryToCatchFish()

    ClearPedTasks(cachedData["ped"])

    if caughtFish then
        TriggerServerEvent("rl-fishing:receiveFish", castLocation, function(received) end)
        TriggerServerEvent('hud:server:RelieveStress', 1)
    else
        RLCore.Functions.Notify("The fish got loose.", "error")
    end
    
    isFishing = false
    CastBait(rodHandle, castLocation)
    return DeleteEntity(rodHandle)
end

TryToCatchFish = function()
    local minigameSprites = {
        ["powerDict"] = "custom",
        ["powerName"] = "bar",
    
        ["tennisDict"] = "tennis",
        ["tennisName"] = "swingmetergrad"
    }

    while not HasStreamedTextureDictLoaded(minigameSprites["powerDict"]) and not HasStreamedTextureDictLoaded(minigameSprites["tennisDict"]) do
        RequestStreamedTextureDict(minigameSprites["powerDict"], false)
        RequestStreamedTextureDict(minigameSprites["tennisDict"], false)

        Citizen.Wait(5)
    end

    local swingOffset = 0.09
    local swingReversed = false

    local DrawObject = function(x, y, width, height, red, green, blue)
        DrawRect(x + (width / 2.0), y + (height / 2.0), width, height, red, green, blue, 150)
    end

    while true do
        Citizen.Wait(5)

        ShowHelpNotification("Press ~INPUT_CONTEXT~ in the green area.")

        DrawSprite(minigameSprites["powerDict"], minigameSprites["powerName"], 0.5, 0.4, 0.01, 0.2, 0.0, 255, 0, 0, 255)

        DrawObject(0.49453227, 0.3, 0.010449, 0.03, 0, 255, 0)

        DrawSprite(minigameSprites["tennisDict"], minigameSprites["tennisName"], 0.5, 0.4 + swingOffset, 0.018, 0.002, 0.0, 0, 0, 0, 255)

        if swingReversed then
            swingOffset = swingOffset - 0.005
        else
            swingOffset = swingOffset + 0.005
        end

        if swingOffset > 0.09 then
            swingReversed = true
        elseif swingOffset < -0.09 then
            swingReversed = false
        end

        if IsControlJustPressed(0, 38) then
            swingOffset = 0 - swingOffset

            extraPower = (swingOffset + 0.09) * 250 + 1.0

            print(extraPower)
            if extraPower >= 30 then
                return true
            else
                return false
            end
        end
    end

    SetStreamedTextureDictAsNoLongerNeeded(minigameSprites["powerDict"])
    SetStreamedTextureDictAsNoLongerNeeded(minigameSprites["tennisDict"])
end



IsInWater = function()
    local startedCheck = GetGameTimer()

    local ped = cachedData["ped"]
    local pedPos = GetEntityCoords(ped)

    local forwardVector = GetEntityForwardVector(ped)
    local forwardPos = vector3(pedPos["x"] + forwardVector["x"] * 10, pedPos["y"] + forwardVector["y"] * 10, pedPos["z"])

    local fishHash = `a_c_fish`

    WaitForModel(fishHash)

    local waterHeight = GetWaterHeight(forwardPos["x"], forwardPos["y"], forwardPos["z"])

    local fishHandle = CreatePed(1, fishHash, forwardPos, 0.0, false)
    
    SetEntityAlpha(fishHandle, 0, true) -- makes the fish invisible.

    -- DrawBusySpinner("Checking fishing location....")
    RLCore.Functions.Notify("Checking fishing location...", "success", "3000")

    while GetGameTimer() - startedCheck < 3000 do
        Citizen.Wait(0)
    end

    RemoveLoadingPrompt()

    local fishInWater = IsEntityInWater(fishHandle)

    DeleteEntity(fishHandle)

    SetModelAsNoLongerNeeded(fishHash)

    return fishInWater, fishInWater and vector3(forwardPos["x"], forwardPos["y"], waterHeight) or false
end

GenerateFishingRod = function(ped)
    local pedPos = GetEntityCoords(ped)
    
    local fishingRodHash = `prop_fishing_rod_01`

    WaitForModel(fishingRodHash)

    local rodHandle = CreateObject(fishingRodHash, pedPos, true)

    AttachEntityToEntity(rodHandle, ped, GetPedBoneIndex(ped, 18905), 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(fishingRodHash)

    return rodHandle
end

HandleStore = function()
    local storeData = Config.FishingRestaurant

    WaitForModel(storeData["ped"]["model"])

    local pedHandle = CreatePed(5, storeData["ped"]["model"], storeData["ped"]["position"], storeData["ped"]["heading"], false)

    SetEntityInvincible(pedHandle, true)
    SetEntityAsMissionEntity(pedHandle, true, true)
    SetBlockingOfNonTemporaryEvents(pedHandle, true)

    cachedData["storeOwner"] = pedHandle

    SetModelAsNoLongerNeeded(storeData["ped"]["model"])

    local storeBlip = AddBlipForCoord(storeData["ped"]["position"])
	
    SetBlipSprite(storeBlip, storeData["blip"]["sprite"])
    SetBlipScale(storeBlip, 0.65)
    SetBlipColour(storeBlip, storeData["blip"]["color"])
    SetBlipAsShortRange(storeBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(storeData["name"])
    EndTextCommandSetBlipName(storeBlip)
end


SellFish = function()
    RLCore.Functions.TriggerCallback('rl-fishing:GetItemData', function(count)
        TaskTurnPedToFaceEntity(cachedData["storeOwner"], cachedData["ped"], 1000)
        TaskTurnPedToFaceEntity(cachedData["ped"], cachedData["storeOwner"], 1000)

        TriggerServerEvent("rl-fishing:sellFish", function(sold, fishesSold) end)
    end)
end



PlayAnimation = function(ped, dict, anim, settings)
	if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else 
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0

                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end

                if settings["flag"] then
                    flag = settings["flag"]
                end

                if settings["playbackRate"] then
                    playbackRate = settings["playbackRate"]
                end

                TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end
      
            RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

FadeOut = function(duration)
    DoScreenFadeOut(duration)
    
    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end
end

FadeIn = function(duration)
    DoScreenFadeIn(500)

    while not IsScreenFadedIn() do
        Citizen.Wait(0)
    end
end

WaitForModel = function(model)
    if not IsModelValid(model) then
        return
    end

	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end
end

DrawBusySpinner = function(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end

ShowHelpNotification = function(msg, thisFrame, beep, duration)
	AddTextEntry('qbHelpNotification', msg)

	if thisFrame then
		DisplayHelpTextThisFrame('qbHelpNotification', false)
	else
		if beep == nil then beep = true end
		BeginTextCommandDisplayHelp('qbHelpNotification')
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

function HasFishingBait()
    local rtval = false
    RLCore.Functions.TriggerCallback('RLCore:HasItem', function(amount)
        if amount then
            rtval = true
        end
    end, "fishingbait")
    Wait(1000)
    return rtval
end


---Vehicle spawn

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local spawnplek = "Fishing Boat Storage"
        local InVehicle = IsPedInAnyVehicle(ped, false)
        local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, -1802.503, -1228.861, 1.6110491, true)
        
        --if isLoggedIn then
            if distance < 10.0 then
                DrawMarker(2, -1802.619, -1228.801, 1.6108186, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 233, 55, 22, 222, false, false, false, true, false, false, false)
                if distance < 15.0 then
                    if InVehicle then
                        DrawText3D(-1800.22,-1231.369, 1.7745625, "[E] Store Rental Boat")
                        DrawMarker(2, -1800.22,-1231.369, 1.7745625, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 233, 55, 22, 222, false, false, false, true, false, false, false)
                        if IsControlJustReleased(0, 38) then
                            RLCore.Functions.TriggerCallback('rl-garbagejob:server:CheckBail', function(DidBail)
                                if DidBail then
                                    BringBackCar()
                                    RLCore.Functions.Notify("You have received a $1000 deposit back!") 
                                else
                                    RLCore.Functions.Notify("You have not paid a deposit on this vehicle ..")
                                end
                            end)
                        end
                    else
                        if not IsWorking then
                            DrawText3D(-1802.503, -1228.861, 1.6110491, "[E] Rental Boat")
                            if IsControlJustReleased(0, 38) then
                                RLCore.Functions.TriggerCallback('rl-garbagejob:server:HasMoney', function(HasMoney)
                                    if HasMoney then
                                        
                                        local coords = {x = -1798.792, y = -1231.33, z = 1.6819111, h = 327.64468}
                                        RLCore.Functions.SpawnVehicle("dinghy", function(veh) 
                                            GarbageVehicle = veh
                                            SetVehicleNumberPlateText(veh, "FISH"..tostring(math.random(1000, 9999)))
                                            SetEntityHeading(veh, coords.h)
                                            exports['lj-fuel']:SetFuel(veh, 100)
                                            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                                            SetEntityAsMissionEntity(veh, true, true)
                                            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
                                            SetVehicleEngineOn(veh, true, true)
                                            RLCore.Functions.Notify("You have paid $1000!")
                                            Citizen.Wait(5000)
                                            RLCore.Functions.Notify("You can lower your anchor by pressing [E] make sure you first turn off your engine!")
                                        end, coords, true)
                                    else
                                        RLCore.Functions.Notify("You do not have enough money for the deposit .. Deposit costs are $ 1000")
                                    end
                                end)
                            end
                        else
                            DrawText3D(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, "Return Boat")
                        end
                    end
                end
            end
        --end

        Citizen.Wait(1)
    end
end)

function BringBackCar()
    local veh = GetVehiclePedIsIn(PlayerPedId())
    DeleteVehicle(veh)
    GarbageVehicle = nil
end

--Anchor
--[[ local anchored = false
local boat = nil
Citizen.CreateThread(function()
	while true do

		Wait(0)
		local ped = PlayerPedId()
		if IsPedInAnyBoat(ped) then
		    boat = GetVehiclePedIsIn(ped, true)
		end
		if IsControlJustPressed(0, 38) and not IsPedInAnyVehicle(ped) and boat ~= nil then
			if not anchored then
				SetBoatAnchor(boat, true)
				TaskStartScenarioInPlace(ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				Citizen.Wait(10000)
				RLCore.Functions.Notify("You have lowered the anchor")
                --sound
				ClearPedTasks(ped)
                anchored = true
            elseif anchored then
				TaskStartScenarioInPlace(ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				Citizen.Wait(10000)
				SetBoatAnchor(boat, false)
				RLCore.Functions.Notify("Anchor retreived")
                --sound 
				ClearPedTasks(ped)
                anchored = false
			end
		end
		if IsVehicleEngineOn(boat) then
			anchored = false
		end
	end
end) ]]