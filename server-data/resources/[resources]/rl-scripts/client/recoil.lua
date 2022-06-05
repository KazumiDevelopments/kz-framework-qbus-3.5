local recoils = {
	-- pistols
	[416676503] = 0.30,

	--smg
	[-957766203] = 0.11,
}

local myRecoilFactor = 0.0
local s = false

RegisterNetEvent("recoil:updateposition")
AddEventHandler("recoil:updateposition", function(sendFactor)
    myRecoilFactor = sendFactor / 5 + 0.0
end)

RegisterNetEvent("recoil:updateRecoil")
AddEventHandler("recoil:updateRecoil", function(f)
    s = f
end)

Citizen.CreateThread( function()
	while true do 
		if IsPedArmed(PlayerPedId(), 6) then
			Citizen.Wait(1)
		else
			Citizen.Wait(1500)
		end  
		
		if s == false then
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

	    	    if Vehicled then
	    	    	recoil = recoil + (recoil)
	    	    end

	    	    local rightleft = math.random(4)
	    	    local h = GetGameplayCamRelativeHeading()
	    	    local hf = math.random(10,40+MovementSpeed)/100

	    	    if Vehicled then
	    	    	hf = hf * 2.0
	    	    end
			
	    	    local set = p+recoil
	    	   	SetGameplayCamRelativePitch(set,0.8)    	       	
			end
		end
	end
end)