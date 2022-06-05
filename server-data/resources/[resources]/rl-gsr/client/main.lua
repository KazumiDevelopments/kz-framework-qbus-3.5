RLCore = nil
local hasShot = false
local ignoreShooting = false

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
            if RLCore ~= nil then
                return
            end
        end
    end
end)

Citizen.CreateThread(function()
    local waitDelay = 500
    while true do
        Wait(waitDelay)
        
        local ped = PlayerPedId()
        if IsPedArmed(ped, 4) then -- Check they aren"t unarmed or using a melee weapon
            waitDelay = 5 -- Set the tick time to 5ms so shot detection is accurate
            if IsPedShooting(ped) then -- Check if they have shot
                -- print("IS SHOOTING")
                if IsPedArmed(ped, 4) then -- Double check they aren"t unarmed or using a melee weapon
                    local wearingGloves = WearingGloves(ped)
                    -- print("GOT A WEAPON WITH BULLET TINGSSSS", tostring(wearingGloves))
                    if not wearingGloves then
                        TriggerServerEvent("GSR_Server:SetGSR")
                        hasShot = true
                        Wait(Config.GSRUpdate)
                    end
                end
            end
        else
            waitDelay = 500
        end
    end
end)

RegisterNetEvent("GSR_Client:PerformTest")
AddEventHandler("GSR_Client:PerformTest", function()
    local player, distance = RLCore.Functions.GetClosestPlayer()
    if player ~= -1 then
        if distance < 2.5 then
            local playerId = GetPlayerServerId(player)
            TriggerServerEvent("GSR_Server:PerformTest", playerId)
        else
            RLCore.Functions.Notify("You aren't close enough to this person!", "error")
        end
    else
        RLCore.Functions.Notify("No one found!", "error")
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(2000)
        if Config.waterClean and hasShot then
            ped = PlayerPedId()
            if IsEntityInWater(ped) then
                RLCore.Functions.Notify("You begin cleaning off the Gun Powder... stay in the water")
                Wait(100)
                RLCore.Functions.Progressbar("lundgsr", "Washing Off Gun Powder", Config.waterCleanTime, false, false, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = false,
                }, {}, {}, {}, function() -- Done
            		if IsEntityInWater(ped) then
                    	hasShot = false
                    	TriggerServerEvent("GSR_Server:Remove")
                        RLCore.Functions.Notify("You washed off all the Gun Powder in the water","success")
                    else
                        RLCore.Functions.Notify("You left the water too early and did not wash off the Gun Powder.", "error")
                    end
                end)
				Citizen.Wait(Config.waterCleanTime)
            end
        end
    end
end)

function WearingGloves(ped)
	for k, v in pairs(Config.Gloves) do
		if GetPedDrawableVariation(ped, 3) == v then
			return true
		end
	end
	return false
end

function status()
    if hasShot then
        RLCore.Functions.TriggerCallback("GSR_Server:Status", function(cb)
            if not cb then
                hasShot = false
            end
        end)
    end
end

function updateStatus()
    status()
    SetTimeout(Config.gsrUpdateStatus, updateStatus)
end

updateStatus()