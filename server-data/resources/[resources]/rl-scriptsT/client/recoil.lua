local recoils = {
	-- pistols
	[416676503] = 0.30,

	--smg
	[-957766203] = 0.01,

	-- rifles
	[970310034] = 0.14,
}

local myRecoilFactor = 0.0

RegisterNetEvent("recoil:updateposition")
AddEventHandler("recoil:updateposition", function(sendFactor)
    myRecoilFactor = sendFactor / 5 + 0.0
end)

Citizen.CreateThread( function()

	while true do 

		 if IsPedArmed(PlayerPedId(), 6) then
		 	Citizen.Wait(1)
		 else
		 	Citizen.Wait(1500)
		 end  

	    if IsPedShooting(PlayerPedId()) then
	    	local ply = PlayerPedId()
	    	local GamePlayCam = GetFollowPedCamViewMode()
	    	local Vehicled = IsPedInAnyVehicle(ply, false)
	    	local MovementSpeed = math.ceil(GetEntitySpeed(ply))

	    	if MovementSpeed > 69 then
	    		MovementSpeed = 69
	    	end

	        local _,wep = GetCurrentPedWeapon(ply)

	        local group = GetWeapontypeGroup(wep)

	        local p = GetGameplayCamRelativePitch()

	        local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))

	        local recoil = math.random(130,140+(math.ceil(MovementSpeed*1.5)))/100
	        local rifle = false

          	if group == 970310034 or group == 1159398588 then
          		rifle = true
          	end

          	if cameraDistance < 5.3 then
          		cameraDistance = 1.5
          	else
          		if cameraDistance < 8.0 then
          			cameraDistance = 4.0
          		else
          			cameraDistance = 7.0
          		end
          	end

	        if Vehicled then
	        	recoil = recoil + (recoil * cameraDistance)
	        else
	        	recoil = recoil * 0.3
	        end

	        if GamePlayCam == 4 then

	        	recoil = recoil * 0.7
		        if rifle then
		        	recoil = recoil * 0.1
		        end
	        end

	        if rifle then
	        	recoil = recoil * 0.1
	        end

	        local rightleft = math.random(4)
	        local h = GetGameplayCamRelativeHeading()
	        local hf = math.random(10,40+MovementSpeed)/100

	        if Vehicled then
	        	hf = hf * 2.0
	        end

	        if rightleft == 1 then
	        	SetGameplayCamRelativeHeading(h+hf)
	        elseif rightleft == 2 then
	        	SetGameplayCamRelativeHeading(h-hf)
	        end 
        
	        local set = p+recoil
	       	SetGameplayCamRelativePitch(set,0.8)    	       	
	    end
	end
end)