local crouched = false
local proned = false
crouchKey = 36
proneKey = 20

Citizen.CreateThread( function()
	while true do 
		Citizen.Wait( 1 )
		local ped = PlayerPedId()
		if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
			ProneMovement()
			--DisableControlAction( 0, proneKey, true ) 
			DisableControlAction( 0, crouchKey, true ) 
			if ( not IsPauseMenuActive() ) then 
				if ( IsDisabledControlJustPressed( 0, crouchKey ) and not proned ) then 
					RequestAnimSet( "move_ped_crouched" )
					while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
						Citizen.Wait( 100 )
					end 		
					if ( crouched and not proned ) then 
						ResetPedMovementClipset( ped )
						ResetPedStrafeClipset(ped)
                        crouched = false 
                        TriggerEvent("dpemotes:WalkCommandStart")
					elseif ( not crouched and not proned ) then
						SetPedMovementClipset( ped, "move_ped_crouched", 0.65 )
						SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
						crouched = true 
					end 
					--[[
				elseif ( IsDisabledControlJustPressed(0, proneKey) and not crouched and not IsPedInAnyVehicle(ped, true) and not IsPedFalling(ped) and not IsPedDiving(ped) and not IsPedInCover(ped, false) and not IsPedInParachuteFreeFall(ped) and (GetPedParachuteState(ped) == 0 or GetPedParachuteState(ped) == -1) ) then
					if proned then
						ClearPedTasksImmediately(ped)
						proned = false
					elseif not proned then
						RequestAnimSet( "move_crawl" )
						while ( not HasAnimSetLoaded( "move_crawl" ) ) do 
							Citizen.Wait( 100 )
						end 
						ClearPedTasksImmediately(ped)
						proned = true
						if IsPedSprinting(ped) or IsPedRunning(ped) or GetEntitySpeed(ped) > 5 then
							TaskPlayAnim(ped, "move_jump", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
							Citizen.Wait(1000)
						end
						SetProned()
					end]]
				end
			end
		else
			proned = false
			crouched = false
		end
	end
end)

function SetProned()
	ped = PlayerPedId()
	ClearPedTasksImmediately(ped)
	TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_fwd", GetEntityCoords(ped), 0.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 46, 1.0, 0, 0)
end

function ProneMovement()
	if proned then
		ped = PlayerPedId()
		if IsControlPressed(0, 32) or IsControlPressed(0, 33) then
			DisablePlayerFiring(ped, true)
		 elseif IsControlJustReleased(0, 32) or IsControlJustReleased(0, 33) then
		 	DisablePlayerFiring(ped, false)
		 end
		if IsControlJustPressed(0, 32) and not movefwd then
			movefwd = true
		    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_fwd", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 47, 1.0, 0, 0)
		elseif IsControlJustReleased(0, 32) and movefwd then
		    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_fwd", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 46, 1.0, 0, 0)
			movefwd = false
		end		
		if IsControlJustPressed(0, 33) and not movebwd then
			movebwd = true
		    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_bwd", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 47, 1.0, 0, 0)
		elseif IsControlJustReleased(0, 33) and movebwd then 
		    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_bwd", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 46, 1.0, 0, 0)
		    movebwd = false
		end
		if IsControlPressed(0, 34) then
			SetEntityHeading(ped, GetEntityHeading(ped)+2.0 )
		elseif IsControlPressed(0, 35) then
			SetEntityHeading(ped, GetEntityHeading(ped)-2.0 )
		end
	end
end

--[[Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}
local stage = 0
local movingForward = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
            if IsControlJustReleased(0, Keys["LEFTCTRL"]) then
                stage = stage + 1
                if stage == 2 then
                    -- Crouch stuff
                    ClearPedTasks(GetPlayerPed(-1))
                    RequestAnimSet("move_ped_crouched")
                    while not HasAnimSetLoaded("move_ped_crouched") do
                        Citizen.Wait(0)
                    end

                    SetPedMovementClipset(GetPlayerPed(-1), "move_ped_crouched",1.0)    
                    SetPedWeaponMovementClipset(GetPlayerPed(-1), "move_ped_crouched",1.0)
                    SetPedStrafeClipset(GetPlayerPed(-1), "move_ped_crouched_strafing",1.0)
                elseif stage == 3 then
                    ClearPedTasks(GetPlayerPed(-1))
                    RequestAnimSet("move_crawl")
                    while not HasAnimSetLoaded("move_crawl") do
                        Citizen.Wait(0)
                    end
                elseif stage > 3 then
                    stage = 0
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    ResetAnimSet()
                    SetPedStealthMovement(GetPlayerPed(-1),0,0)
                end
            end

            if stage == 2 then
                if GetEntitySpeed(GetPlayerPed(-1)) > 1.0 then
                    SetPedWeaponMovementClipset(GetPlayerPed(-1), "move_ped_crouched",1.0)
                    SetPedStrafeClipset(GetPlayerPed(-1), "move_ped_crouched_strafing",1.0)
                elseif GetEntitySpeed(GetPlayerPed(-1)) < 1.0 and (GetFollowPedCamViewMode() == 4 or GetFollowVehicleCamViewMode() == 4) then
                    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
                    ResetPedStrafeClipset(GetPlayerPed(-1))
                end
            elseif stage == 3 then
                DisableControlAction( 0, 21, true ) -- sprint
                DisableControlAction(1, 140, true)
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)

                if (IsControlPressed(0, Keys["W"]) and not movingForward) then
                    movingForward = true
                    SetPedMoveAnimsBlendOut(GetPlayerPed(-1))
                    local pronepos = GetEntityCoords(GetPlayerPed(-1))
                    TaskPlayAnimAdvanced(GetPlayerPed(-1), "move_crawl", "onfront_fwd", pronepos.x, pronepos.y, pronepos.z+0.1, 0.0, 0.0, GetEntityHeading(GetPlayerPed(-1)), 100.0, 0.4, 1.0, 7, 2.0, 1, 1) 
                    Citizen.Wait(500)
                elseif (not IsControlPressed(0, Keys["W"]) and movingForward) then
                    local pronepos = GetEntityCoords(GetPlayerPed(-1))
                    TaskPlayAnimAdvanced(GetPlayerPed(-1), "move_crawl", "onfront_fwd", pronepos.x, pronepos.y, pronepos.z+0.1, 0.0, 0.0, GetEntityHeading(GetPlayerPed(-1)), 100.0, 0.4, 1.0, 6, 2.0, 1, 1)
                    Citizen.Wait(500)
                    movingForward = false
                end

                if IsControlPressed(0, Keys["A"]) then
                    SetEntityHeading(GetPlayerPed(-1),GetEntityHeading(GetPlayerPed(-1)) + 1)
                end     

                if IsControlPressed(0, Keys["D"]) then
                    SetEntityHeading(GetPlayerPed(-1),GetEntityHeading(GetPlayerPed(-1)) - 1)
                end 
            end
        else
            stage = 0
            Citizen.Wait(1000)
        end
    end
end)

local walkSet = "default"
RegisterNetEvent("crouchprone:client:SetWalkSet")
AddEventHandler("crouchprone:client:SetWalkSet", function(clipset)
    walkSet = clipset
end)


function ResetAnimSet()
    if walkSet == "default" then
        ResetPedMovementClipset(GetPlayerPed(-1))
        ResetPedWeaponMovementClipset(GetPlayerPed(-1))
        ResetPedStrafeClipset(GetPlayerPed(-1))
    else
        ResetPedMovementClipset(GetPlayerPed(-1))
        ResetPedWeaponMovementClipset(GetPlayerPed(-1))
        ResetPedStrafeClipset(GetPlayerPed(-1))
        Citizen.Wait(100)
        RequestWalking(walkSet)
        SetPedMovementClipset(PlayerPedId(), walkSet, 1)
        RemoveAnimSet(walkSet)
    end
end

function RequestWalking(set)
    RequestAnimSet(set)
    while not HasAnimSetLoaded(set) do
        Citizen.Wait(1)
    end 
end]]--