--[[
	Antilag & 2-Step Script
		Created By T.Silence
			Custom audio & launch control
				Edited By SnowQT / Hal Croves
					Interact-Sound used to play custom audio
						Created	by Scott	
]]
RLCore = nil

local ped = GetPlayerPed(-1)
local activated = false
local antilag = false
local twostep  = false 
local launch = false
local AntilagDisplay = false
local LEVOLUME = 0.5
local MysavedGrip = 0.0
local Myhandlingsaved = false
local lastVehicle
local MysavedVehicle


Citizen.CreateThread(function()
    while RLCore == nil do
        Citizen.Wait(10)
        TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
    end

    while RLCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(1)
    end

    currentJob = RLCore.Functions.GetPlayerData().job.name
end)


local handlingData = {
	"handlingName",
	"fMass",
	"fInitialDragCoeff",
	"fPercentSubmerged",
	"vecCentreOfMassOffset",
	"vecInertiaMultiplier",
	"fDriveBiasFront",
	"nInitialDriveGears",
	"fInitialDriveForce",
	"fDriveInertia",
	"fClutchChangeRateScaleUpShift",
	"fClutchChangeRateScaleDownShift",
	"fInitialDriveMaxFlatVel",
	"fBrakeForce",
	"fBrakeBiasFront",
	"fHandBrakeForce",
	"fSteeringLock",
	"fTractionCurveMax",
	"fTractionCurveMin",
	"fTractionCurveLateral",
	"fTractionSpringDeltaMax",
	"fLowSpeedTractionLossMult",
	"fCamberStiffnesss",
	"fTractionBiasFront",
	"fTractionLossMult",
	"fSuspensionForce",
	"fSuspensionCompDamp",
	"fSuspensionReboundDamp",
	"fSuspensionUpperLimit",
	"fSuspensionLowerLimit",
	"fSuspensionRaise",
	"fSuspensionBiasFront",
	"fTractionCurveMax",
	"fAntiRollBarForce",
	"fAntiRollBarBiasFront",
	"fRollCentreHeightFront",
	"fRollCentreHeightRear",
	"fCollisionDamageMult",
	"fWeaponDamageMult",
	"fDeformationDamageMult",
	"fEngineDamageMult",
	"fPetrolTankVolume",
	"fOilVolume",
	"fSeatOffsetDistX",
	"fSeatOffsetDistY",
	"fSeatOffsetDistZ",
	"nMonetaryValue",
	"strModelFlags",
	"strHandlingFlags",
	"strDamageFlags",
	"AIHandling",
	"fThrust",
	"fThrustFallOff",
	"fThrustVectoring",
	"fYawMult",
	"fYawStabilise",
	"fSideSlipMult",
	"fRollMult",
	"fRollStabilise",
	"fPitchMult",
	"fPitchStabilise",
	"fFormLiftMult",
	"fAttackLiftMult",
	"fAttackDiveMult",
	"fGearDownDragV",
	"fGearDownLiftMult",
	"fWindMult",
	"fMoveRes",
	"vecTurnRes",
	"vecSpeedRes",
	"fGearDoorFrontOpen",
	"fGearDoorRearOpen",
	"fGearDoorRearOpen2",
	"fGearDoorRearMOpen",
	"fTurublenceMagnitudeMax",
	"fTurublenceForceMulti",
	"fTurublenceRollTorqueMulti",
	"fTurublencePitchTorqueMulti",
	"fBodyDamageControlEffectMult",
	"fInputSensitivityForDifficulty",
	"fOnGroundYawBoostSpeedPeak",
	"fOnGroundYawBoostSpeedCap",
	"fEngineOffGlideMulti",
	"handlingType",
	"fThrustFallOff",
	"fThrustFallOff",
	"fBackEndPopUpCarImpulseMult",
	"fBackEndPopUpBuildingImpulseMult",
	"fBackEndPopUpMaxDeltaSpeed",
	"fLeanFwdCOMMult",
	"fLeanFwdForceMult",
	"fLeanBakCOMMult",
	"fLeanBakForceMult",
	"fMaxBankAngle",
	"fFullAnimAngle",
	"fDesLeanReturnFrac",
	"fStickLeanMult",
	"fBrakingStabilityMult",
	"fInAirSteerMult",
	"fWheelieBalancePoint",
	"fStoppieBalancePoint",
	"fWheelieSteerMult",
	"fRearBalanceMult",
	"fFrontBalanceMult",
	"fBikeGroundSideFrictionMult",
	"fBikeWheelGroundSideFrictionMult",
	"fBikeOnStandLeanAngle",
	"fBikeOnStandSteerAngle",
	"fJumpForce",
}

p_flame_location = {
	
	"exhaust", 
	"exhaust_2", 
	"exhaust_3", 
	"exhaust_4", 
	"exhaust_5", 
	"exhaust_6", 
	"exhaust_7", 
	"exhaust_8", 
	"exhaust_9", 
	"exhaust_10", 
	"exhaust_11", 
	"exhaust_12", 
	"exhaust_13", 
	"exhaust_14", 
	"exhaust_15", 
	"exhaust_16"
}

RegisterNetEvent('InteractSound_CL:PlayWithinDistance')
AddEventHandler('InteractSound_CL:PlayWithinDistance', function(playerNetId, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1))
    local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
    local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
    if(distIs <= maxDistance) then
        SendNUIMessage({
            transactionType     = 'playSound',
            transactionFile     = soundFile,
            transactionVolume   = soundVolume
        })
    end
end)

RegisterNetEvent('InteractSound_CL:PlayOnOne')
AddEventHandler('InteractSound_CL:PlayOnOne', function(soundFile, soundVolume)
    SendNUIMessage({
        transactionType     = 'playSound',
        transactionFile     = soundFile,
        transactionVolume   = soundVolume
    })
end)
	
--notifIcon 
function notifIcon(icon, type, sender, title, text)
    SetNotificationTextEntry("STRING");
    AddTextComponentString(text);
    SetNotificationMessage(icon, icon, true, type, sender, title, text);
    DrawNotification(false, true);
end

RegisterNetEvent("2step:Anti-lag")
AddEventHandler("2step:Anti-lag", function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local vehProps = RLCore.Functions.GetVehicleProperties(vehicle)
	if IsPedInAnyVehicle(PlayerPedId(), false) then 
		if antilag == false then
			antilag = true
			notifIcon("CHAR_MP_DETONATEPHONE", 1, "~p~Ordinateur de bord", false, "~g~Le Module ~b~ALS~g~ est actif")
		else
			antilag = false
			notifIcon("CHAR_MP_DETONATEPHONE", 1, "~p~Ordinateur de bord", false, "~r~Le Module ~b~ALS~r~ est désactivé")
		end
	else
		notifIcon("CHAR_SOCIAL_CLUB", 1, "~b~Wiki", false, "~b~Entre dans ton véhicule avant d'activer ~p~l'Antilag~b!")
	end
end)


RegisterNetEvent("2step:2step")
AddEventHandler("2step:2step", function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local vehProps = RLCore.Functions.GetVehicleProperties(vehicle)
	if IsPedInAnyVehicle(PlayerPedId(), false) then 
		if twostep == false then
			twostep = true
			notifIcon("CHAR_MP_DETONATEPHONE", 1, "~p~Ordinateur de bord", false, "~g~Le Module ~b~2STEP~g~ est actif")
		else
			twostep = false
			notifIcon("CHAR_MP_DETONATEPHONE", 1, "~p~Ordinateur de bord", false, "~r~Le Module ~b~2STEP~r~ est désactivé")
		end
	else
		notifIcon("CHAR_SOCIAL_CLUB", 1, "~b~Wiki", false, "~b~Entre dans ton véhicule avant d'activer ~p~le 2-step~b!")
	end
end)


RegisterNetEvent("2step:launch")
AddEventHandler("2step:launch", function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local vehProps = RLCore.Functions.GetVehicleProperties(vehicle)
	if IsPedInAnyVehicle(PlayerPedId(), false) then 
		if launch == false then
			launch = true
			notifIcon("CHAR_MP_DETONATEPHONE", 1, "~p~Ordinateur de bord", false, "~g~Le Module ~b~Launch control~g~ est actif")
		else
			launch = false
			notifIcon("CHAR_MP_DETONATEPHONE", 1, "~p~Ordinateur de bord", false, "~r~Le Module ~b~Launch control~r~ est désactivé")
		end
	else
		notifIcon("CHAR_SOCIAL_CLUB", 1, "~b~Wiki", false, "~b~Entre dans ton véhicule avant d'activer ~p~le Launch control~b!")
	end
end)



--[[ RegisterNetEvent("c_eff_flames")
AddEventHandler("c_eff_flames", function(c_veh, mode)
	for ma,bite in pairs(p_flame_location) do
		local pedVehicle = GetVehiclePedIsIn(PlayerPedId())
		local myExhaustBone = GetEntityBoneIndexByName(pedVehicle, bite)
		local myExhaustBonePos = GetWorldPositionOfEntityBone(pedVehicle, myExhaustBone)
		if mode == "antilag" then
			p_flame_size2 = randomFloat(0.01, 0.05)
		else
			p_flame_size2 = randomFloat(0.01, 0.05)
		end
		if myExhaustBonePos.x ~= 0 then
			local p_flame_particle2 = "veh_backfire"
			local p_flame_particle_asset2 = "core"
			UseParticleFxAssetNextCall(p_flame_particle_asset2)
			createdPart2 = StartNetworkedParticleFxNonLoopedAtCoord(p_flame_particle2, myExhaustBonePos.x, myExhaustBonePos.y, myExhaustBonePos.z, 0.0, GetEntityPitch(pedVehicle), GetEntityHeading(pedVehicle) -90,p_flame_size2,0.0,  0.0,  0.0, 0)
			StopParticleFxLooped(createdPart2, 1)
		end	
	end
end) ]]

RegisterNetEvent("c_eff_flames2")
AddEventHandler("c_eff_flames2", function(c_veh, mode)
	for ma,bite in pairs(p_flame_location) do
		local pedVehicle = GetVehiclePedIsIn(PlayerPedId())
		local myExhaustBone = GetEntityBoneIndexByName(pedVehicle, bite)
		local myExhaustBonePos = GetWorldPositionOfEntityBone(pedVehicle, myExhaustBone)
		if mode == "antilag" then
			p_flame_size2 = randomFloat(1.0, 1.5)
		else
			p_flame_size2 = randomFloat(0.5, 3.0)
		end
		if myExhaustBonePos.x ~= 0 then
			local a_flame_particle2 = "scr_carsteal5_car_muzzle_flash"
			local a_flame_particle_asset2 = "scr_carsteal4" 
			UseParticleFxAssetNextCall(a_flame_particle_asset2)
			createdPart = StartNetworkedParticleFxNonLoopedAtCoord(a_flame_particle2, myExhaustBonePos.x, myExhaustBonePos.y, myExhaustBonePos.z, 0.0, GetEntityPitch(pedVehicle), GetEntityHeading(pedVehicle) -90,p_flame_size2,0.0,  0.0,  0.0, 0)
			StopParticleFxLooped(createdPart, 1)
		end	
	end
end)

p_flame_location = {
	"exhaust",
	"exhaust_2",
	"exhaust_3",
	"exhaust_4"	
}
p_flame_particle = "veh_backfire"
p_flame_particle_asset = "core" 
p_flame_size = 2.4
RegisterNetEvent("c_eff_flames")
AddEventHandler("c_eff_flames", function(c_veh)
	for _,bones in pairs(p_flame_location) do
		UseParticleFxAssetNextCall(p_flame_particle_asset)
		createdPart = StartParticleFxLoopedOnEntityBone(p_flame_particle, NetToVeh(c_veh), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetEntityBoneIndexByName(NetToVeh(c_veh), bones), p_flame_size, 0.0, 0.0, 0.0)
		StopParticleFxLooped(createdPart, 1)
	end
end)

Citizen.CreateThread(function()
    while true do

    	local chance = math.random(1,100)
        local ped = PlayerPedId()
        local pedVehicle = GetVehiclePedIsIn(ped) 
        --debug shit 
        --DrawHudText("danger ⚠", {255, 0, 0,255},0.93,0.90,0.4,0.4,9)  
        --DrawHudText("2Step", {255, 0, 0,255},0.94,0.883,0.5,0.5,6)
		--DrawHudText("READY TO LAUNCH ", {math.random(0,255), math.random(0,255), math.random(0,255),255},0.93,0.81,0.7,0.7,6)
        --DrawHudText("ALS", {31, 190, 214,255},0.884,0.84,0.5,0.5,6)

        --DrawHudText("1", {255, 0, 0,255},0.875,0.843,0.3,0.3,3)
		--DrawHudText("2", {255, 0, 0,255},0.899,0.843,0.3,0.3,3)
		
        
		
			if IsControlPressed(1, 21) then
				if twostep then
					if isPedDrivingAVehicle() then
						local pedPos = GetEntityCoords(ped)
						local vehiclePos = GetEntityCoords(pedVehicle)
						local RPM = GetVehicleCurrentRpm(pedVehicle)

						if GetPedInVehicleSeat(pedVehicle, -1) == ped then
							local vehicleModel = GetEntityModel(pedVehicle)
							local BackFireDelay = (math.random(50, 150))

							if RPM > 0.9 and GetEntitySpeed(pedVehicle) < 2.0 then

								local closestPlayer, distance = RLCore.Functions.GetClosestPlayer() 
						        if distance >= 0.0 and distance < 8.0 then 
						        	LEVOLUME = 0.5
						        elseif distance >= 8.0 and distance < 16.0 then
						        	LEVOLUME = 0.4
						        elseif distance >= 16.0 and distance < 24.0 then
						        	LEVOLUME = 0.3
						        elseif distance >= 24.0 and distance < 30.0 then
						        	LEVOLUME = 0.1
						        end
								DrawHudText("danger ⚠", {255, 0, 0,255},0.93,0.90,0.4,0.4,9)
								TriggerServerEvent("eff_flames2", VehToNet(pedVehicle))
								if distance >= 0.1 and distance < 25 then 
									--TriggerServerEvent("InteractSound_SV:PlayWithinDistance",25.0, tostring(1), LEVOLUME)
									AddExplosion(vehiclePos.x, vehiclePos.y, vehiclePos.z, 61, 0.0, true, true, 0.0, true)
								else
									--TriggerServerEvent("InteractSound_SV:PlayWithinDistance",25.0, tostring(1), randomFloat(0.1,0.2))
									AddExplosion(vehiclePos.x, vehiclePos.y, vehiclePos.z, 61, 0.0, true, true, 0.0, true)
								end	
								SetVehicleTurboPressure(pedVehicle, 25)
								activated = true
							  	Wait(BackFireDelay) 
							else 
								activated = false
							end
						else
							activated = false	
						end
					else
						activated = false
					end
				end	
			else
				activated = false
				if not IsControlPressed(1, 71) and not IsControlPressed(1, 72) then
					if antilag then
						if isPedDrivingAVehicle() then
							local pedPos = GetEntityCoords(ped)
							local vehiclePos = GetEntityCoords(pedVehicle)
							local RPM = GetVehicleCurrentRpm(pedVehicle)
							local AntiLagDelay = (math.random(100, 1000))
							if GetPedInVehicleSeat(pedVehicle, -1) == ped then
								if RPM > 0.75 then
									local closestPlayer, distance = RLCore.Functions.GetClosestPlayer()  
									local vehicleModel = GetEntityModel(pedVehicle)
									DrawHudText("1", {255, 0, 0,255},0.875,0.843,0.3,0.3,3)
									DrawHudText("2", {255, 0, 0,255},0.899,0.843,0.3,0.3,3)
									TriggerServerEvent("eff_flames", VehToNet(pedVehicle))

									if distance >= 0.1 and distance < 25 then 
										--TriggerServerEvent("InteractSound_SV:PlayWithinDistance",25.0, tostring(1), LEVOLUME)
										AddExplosion(vehiclePos.x, vehiclePos.y, vehiclePos.z, 61, 0.0, true, true, 0.0, true)
									else
										--TriggerServerEvent("InteractSound_SV:PlayWithinDistance",25.0, tostring(1), randomFloat(0.1,0.2))
										AddExplosion(vehiclePos.x, vehiclePos.y, vehiclePos.z, 61, 0.0, true, true, 0.0, true)
									end	
									
									SetVehicleTurboPressure(pedVehicle, 25)
									AntilagDisplay = true
								  	Wait(AntiLagDelay)
								else
									AntilagDisplay = false
								end
							end
						else
							AntilagDisplay = false
							antilag = false
							twostep = false
							launch 	= false
						end
					end
				else 
					AntilagDisplay = false
				end
			end

			if IsControlJustReleased(1, 21) and twostep then
				if isPedDrivingAVehicle() then
					SetVehicleTurboPressure(pedVehicle, 25)
				end
			end
	  	Wait(0)
	end
end)

Citizen.CreateThread(function ()
	while true do 
		Wait(0)
		if twostep then
			DrawHudText("2Step", {31, 190, 214,255},0.94,0.883,0.5,0.5,6)
		end
		if antilag then
			DrawHudText("ALS", {31, 190, 214,255},0.884,0.84,0.5,0.5,6)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if launch then
			if activated and isPedDrivingAVehicle() then
				lastVehicle = GetVehiclePedIsIn(PlayerPedId(),false)

				if lastVehicle ~= nil and MysavedVehicle ~= nil then
					if  lastVehicle ~= MysavedVehicle then
						Myhandlingsaved = false
						MysavedVehicle = lastVehicle
					end
				end

				if not Myhandlingsaved then 
					MysavedGrip = GetVehicleHandlingData(lastVehicle,'fTractionCurveMin')
					MysavedVehicle = lastVehicle
					Myhandlingsaved = true
				end
				
				if lastVehicle ~= nil then
					--Wait(200)
					SetVehicleHandlingData(lastVehicle,'fTractionCurveMin', tonumber(7.1))
				end
			else
				Citizen.Wait(2000)
				if lastVehicle ~= nil then
					SetVehicleHandlingData(lastVehicle,'fTractionCurveMin', MysavedGrip)
				end
			end

			

			if activated then 
				DrawHudText("READY TO LAUNCH ", {math.random(0,255), math.random(0,255), math.random(0,255),255},0.93,0.81,0.7,0.7,6)
			end
		end
	end
end)

function DrawHudText(text,colour,coordsx,coordsy,scalex,scaley, font)
    SetTextFont(font)
    SetTextProportional(7)
    SetTextScale(scalex, scaley)
    local colourr,colourg,colourb,coloura = table.unpack(colour)
    SetTextColour(colourr,colourg,colourb, coloura)
    SetTextDropshadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(coordsx,coordsy)
end

function Notif( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

function randomFloat(lower, greater)
    return lower + math.random()  * (greater - lower);
end

function exitmarkerCarArea()
	SendNUIMessage({
	    transactionType     = 'updateVolume',
	    transactionVolume   = 0.0
	})
end

function isPedDrivingAVehicle()
    local ped = PlayerPedId()
    vehicle = GetVehiclePedIsIn(ped, false)
    if IsPedInAnyVehicle(ped, false) then
        -- Check if ped is in driver seat
        if GetPedInVehicleSeat(vehicle, -1) == ped then
            local class = GetVehicleClass(vehicle)
            -- We don't want planes, helicopters, bicycles and trains
            if class ~= 15 and class ~= 16 and class ~=21 and class ~=13 and class ~=8 then
                return true
            end
        end
    end
    return false
end

function print_r(arr, indentLevel)
	local str = ""
	local indentStr = "#"
	if(indentLevel == nil) then
	    print(print_r(arr, 0))
	    return
	end
	for i = 0, indentLevel do
	    indentStr = indentStr.."\t"
	end
	for index,value in pairs(arr) do
	    if type(value) == "table" then
	        str = str..indentStr..index..": \n"..print_r(value, (indentLevel + 1))
	    else 
	        str = str..indentStr..index..": "..value.."\n"
	    end
	end
	return str
end

function SetVehicleHandlingData(Vehicle,Data,Value)
	if DoesEntityExist(Vehicle) and Data and Value then
		for theKey,property in pairs(handlingData) do 
			if property == Data then
				local intfind = string.find(property, "n")
				local floatfind = string.find(property, "f")
				local strfind = string.find(property, "str")
				local vecfind = string.find(property, "vec")
				
				
				if intfind ~= nil and intfind == 1 then
					SetVehicleHandlingInt(Vehicle, "CHandlingData", Data, tonumber(Value))
				elseif floatfind ~= nil and floatfind == 1 then
					local Value = tonumber(Value)+.0
					SetVehicleHandlingFloat(Vehicle, "CHandlingData", Data, tonumber(Value))
				elseif strfind ~= nil and strfind == 1 then
					SetVehicleHandlingField(Vehicle, "CHandlingData", Data, Value)
				elseif vecfind ~= nil and vecfind == 1 then
					SetVehicleHandlingVector(Vehicle, "CHandlingData", Data, Value)
				else
					SetVehicleHandlingField(Vehicle, "CHandlingData", Data, Value)
				end
			end
		end 
	end
end


function GetVehicleHandlingData(Vehicle,Data)
	if DoesEntityExist(Vehicle) then
		for theKey,property in pairs(handlingData) do 
			if property == Data then
				local intfind = string.find(property, "n")
				local floatfind = string.find(property, "f")
				local strfind = string.find(property, "str")
				local vecfind = string.find(property, "vec")
				
				if intfind ~= nil and intfind == 1 then
					return GetVehicleHandlingInt(Vehicle, "CHandlingData", Data)
				elseif floatfind ~= nil and floatfind == 1 then
					return GetVehicleHandlingFloat(Vehicle, "CHandlingData", Data)
				elseif vecfind ~= nil and vecfind == 1 then
					return GetVehicleHandlingVector(Vehicle, "CHandlingData", Data)
				else
					return false
				end
			end
		end
	end
end









