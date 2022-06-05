-- SCREEN POSITION PARAMETERS
local screenPosX = 0.165                    -- X coordinate (top left corner of HUD)
local screenPosY = 0.882                    -- Y coordinate (top left corner of HUD)

-- GENERAL PARAMETERS
local enableController = true               -- Enable controller inputs

-- SPEEDOMETER PARAMETERS
local speedLimit = 100.0                    -- Speed limit for changing speed color
local speedColorText = {255, 255, 255}      -- Color used to display speed label text
local speedColorUnder = {255, 255, 255}     -- Color used to display speed when under speedLimit
local speedColorOver = {255, 96, 96}        -- Color used to display speed when over speedLimit

-- FUEL PARAMETERS
local fuelShowPercentage = false             -- Show fuel as a percentage (disabled shows fuel in liters)
local fuelWarnLimit = 25.0                  -- Fuel limit for triggering warning color
local fuelColorText = {255, 255, 255}       -- Color used to display fuel text
local fuelColorOver = {255, 255, 255}       -- Color used to display fuel when good
local fuelColorUnder = {255, 96, 96}        -- Color used to display fuel warning

-- ENGINE PARAMETERS
local EngineDrawColour = {255,255,255}
local engineHealthColourGood = {255, 255, 255}      -- Colour for "Good" Engine Health
local engineHealthColourMedium = {255, 165, 000}    -- Colour for "Medium" Engine Health
local engineHealthColourBad = {255, 96, 96}       -- Colour for "Bad" Engine Health
local engineHealthAmountGood = 75.0                 -- Value Theshold for "Good" Engine
local engineHealthAmountMedium = 50.0               -- Value Theshold for "Medium" Engine
local engineHealthAmountBad = 25.0                  -- Value Theshold for "Bad" Engine
local ShowEngineNumbers = true                     -- Set True to Show Engine Data

-- SEATBELT PARAMETERS
local seatbeltInput = 29                   -- Toggle seatbelt on/off with K or DPAD down (controller)
local seatbeltPlaySound = true              -- Play seatbelt sound
local seatbeltDisableExit = true            -- Disable vehicle exit when seatbelt is enabled
local seatbeltEjectSpeed = 45.0             -- Speed threshold to eject player (MPH)
local seatbeltEjectAccel = 100.0            -- Acceleration threshold to eject player (G's)
local seatbeltColorOn = {160, 255, 160}     -- Color used when seatbelt is on
local seatbeltColorOff = {255, 96, 96}      -- Color used when seatbelt is off

-- CRUISE CONTROL PARAMETERS
local cruiseInput = 48                     -- Toggle cruise on/off with CAPSLOCK or A button (controller)
local cruiseColorOn = {160, 255, 160}       -- Color used when cruise control is on
local cruiseColorOff = {255, 255, 255}      -- Color used when cruise control is off

-- LOCATION AND TIME PARAMETERS
local locationAlwaysOn = false              -- Always display location and time
local locationColorText = {255, 255, 255}   -- Color used to display location and time

local commandnotOveride = true

-- Lookup tables for direction and zone
local directions = { [0] = '', [1] = '', [2] = '', [3] = '', [4] = '', [5] = '', [6] = '', [7] = '', [8] = '' } 
local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

-- Globals
local pedInVeh = false
local timeText = ""
local locationText = ""
local currentFuel = 0.0
local mph = true

local poptires = false

local nitro = 0
local watchon = false
local stopWatchDisplay = false
-- START

RegisterNetEvent('rl-hud:nitro')
AddEventHandler('rl-hud:nitro', function(percent)
  nitro = percent
end)

-- Main thread
Citizen.CreateThread(function()
    -- Initialize local variable
    local currSpeed = 0.0
    local cruiseSpeed = 999.0
    local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}
    local cruiseIsOn = false
    local seatbeltIsOn = false
    local waitDelay = 500

    while true do
        -- Loop forever and update HUD every frame
        -- Get player PED, position and vehicle and save to locals
        local player = GetPlayerPed(-1)
        local position = GetEntityCoords(player)
        local vehicle = GetVehiclePedIsIn(player, false)
        local engineHealth = (GetVehicleEngineHealth(vehicle) / 10)

        Citizen.Wait(waitDelay)     

        -- Set vehicle states
        if IsPedInAnyVehicle(player, false) then
            pedInVeh = true
        else
            -- Reset states when not in car
            pedInVeh = false
            cruiseIsOn = false
            engineHealth = 0
            seatbeltIsOn = false
        end
        
        -- Display Location and time when in any vehicle or on foot (if enabled)
        if pedInVeh or locationAlwaysOn then
            waitDelay = 5
            -- Get time and display
            drawTxt(timeText, 4, locationColorText, 0.4, screenPosX, screenPosY + 0.033)
            
            -- Display heading, street name and zone when possible
            drawTxt(locationText, 4, locationColorText, 0.5, screenPosX + 0.0325, screenPosY + 0.090)
        
            -- Display remainder of HUD when engine is on and vehicle is not a bicycle
            local vehicleClass = GetVehicleClass(vehicle)
            if pedInVeh and GetIsVehicleEngineRunning(vehicle) then
                if vehicleClass ~= 13 then
                    DisplayRadar(true)
                    -- Save previous speed and get current speed
                    local prevSpeed = currSpeed
                    currSpeed = GetEntitySpeed(vehicle)

                    -- Set PED flags
                    SetPedConfigFlag(PlayerPedId(), 32, true)

                    -- Check if seatbelt button pressed, toggle state and handle seatbelt logic
                    if IsControlJustReleased(0, seatbeltInput) and (enableController or GetLastInputMethod(0)) and vehicleClass ~= 8 then
                        -- Toggle seatbelt status and play sound when enabled
                        seatbeltIsOn = not seatbeltIsOn
                        if seatbeltIsOn then
                            TriggerEvent('InteractSound_CL:PlayOnOne','carbuckle',0.2)
                            TriggerEvent("veh:seatbelt", true)
                        else
                            TriggerEvent('InteractSound_CL:PlayOnOne','carunbuckle',0.2)
                            TriggerEvent("veh:seatbelt", false)
                        
                        end
                    end
                    --[[ if not seatbeltIsOn then
                        -- Eject PED when moving forward, vehicle was going over 45 MPH and acceleration over 100 G's
                        local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                        local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
                        if (vehIsMovingFwd and (prevSpeed > (seatbeltEjectSpeed/2.237)) and (vehAcc > (seatbeltEjectAccel*9.81))) then
                            ejectionLUL()
                        else
                            -- Update previous velocity for ejecting player
                        prevVelocity = GetEntityVelocity(vehicle)
                        end
                    elseif seatbeltDisableExit then
                        -- Disable vehicle exit when seatbelt is on
                        DisableControlAction(0, 75)
                    end ]]

                    if poptires then
                        local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                        local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
                        if (vehIsMovingFwd and (prevSpeed > (seatbeltEjectSpeed/2.237)) and (vehAcc > (seatbeltEjectAccel*9.81))) then
                            PopTires()
                        end
                    end

                    -- When player in driver seat, handle cruise control
                    if (GetPedInVehicleSeat(vehicle, -1) == player) then
                        if IsControlJustReleased(0, cruiseInput) and (enableController or GetLastInputMethod(0)) then
                            cruiseIsOn = not cruiseIsOn
                            cruiseSpeed = currSpeed
                            PlaySoundFrontend(-1, "Faster_Click", "RESPAWN_ONLINE_SOUNDSET", 1)
                        end
                        local maxSpeed = cruiseIsOn and cruiseSpeed or GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
                        SetEntityMaxSpeed(vehicle, maxSpeed)
                            if IsControlJustPressed(1, 27) then
                                if cruiseIsOn then
                                    cruiseSpeed = cruiseSpeed + 2.10
                                    SetEntityMaxSpeed(vehicle, maxSpeed)
                                end
                            elseif IsControlJustPressed(1, 173) then
                                if cruiseIsOn then
                                    cruiseSpeed = cruiseSpeed - 2.10
                                    SetEntityMaxSpeed(vehicle, maxSpeed)
                                end
                            end
                    else
                        -- Reset cruise control
                        cruiseIsOn = false
                    end

                    -- Check what units should be used for speed
                    if not mph then
                        -- Get vehicle speed in KPH and draw speedometer
                        local speed = currSpeed*3.6
                        local speedColor = (speed >= speedLimit) and speedColorOver or speedColorUnder
                        drawTxt(("%.3d"):format(math.ceil(speed)), 2, speedColor, 0.8, screenPosX + 0.000, screenPosY + 0.063)
                        drawTxt("KPH", 2, speedColorText, 0.4, screenPosX + 0.011, screenPosY + 0.063)
                    else
                        -- Get vehicle speed in MPH and draw speedometer
                        local speed = currSpeed*2.23694
                        local speedColor = (speed >= speedLimit) and speedColorOver or speedColorUnder
                        drawTxt(("%.3d"):format(math.ceil(speed)), 2, speedColor, 0.8, screenPosX + 0.000, screenPosY + 0.063)
                        drawTxt("MPH", 2, speedColorText, 0.4, screenPosX + 0.011, screenPosY + 0.063)
                    end
                    
                    -- Draw fuel gauge
                    local fuelColor = (currentFuel >= fuelWarnLimit) and fuelColorOver or fuelColorUnder
                    drawTxt(("%.3d"):format(math.ceil(currentFuel)), 2, fuelColor, 0.8, screenPosX + 0.030, screenPosY + 0.063)
                    drawTxt("FUEL", 2, fuelColorText, 0.4, screenPosX + 0.041, screenPosY + 0.063)

                    -- Draw cruise control status
                    local cruiseColor = cruiseIsOn and cruiseColorOn or cruiseColorOff
                    drawTxt("CRUISE", 2, cruiseColor, 0.4, screenPosX + 0.030, screenPosY + 0.033)

                    --local nitroColorText = {255, 255, 255}       -- Color used to display fuel text
                    --local nitroColor = {255, 255, 255} 

                    --local nitroColor = nitro 
                    if nitro > 0 then
                        drawTxt(("%.3d"):format(math.ceil(nitro)), 2, cruiseColor, 0.8, screenPosX + 0.0700, screenPosY + 0.033)
                        drawTxt("NOS", 2, {240,230,140}, 0.4, screenPosX + 0.058, screenPosY + 0.033)
                    end


                        -- Color used to display fuel when good

                    -- Logic for engine health colour
                    if engineHealth <= engineHealthAmountBad then
                        EngineDrawColour = engineHealthColourBad -- RED
                    elseif engineHealth > engineHealthAmountBad and engineHealth <= engineHealthAmountMedium then
                        EngineDrawColour = engineHealthColourMedium
                    elseif engineHealth >= engineHealthAmountGood then
                        EngineDrawColour = engineHealthColourGood
                    end
                    
                    -- Draw Engine Health
                    --if ShowEngineNumbers then
                    --local bodyh = (GetVehicleBodyHealth(vehicle) / 10)
                    --    drawTxt(("%.3d"):format(math.ceil(engineHealth)), 2, EngineDrawColour, 0.4, screenPosX + 0.061, screenPosY + 0.048)
                    --    drawTxt(("%.3d"):format(math.ceil(bodyh)), 2, EngineDrawColour, 0.4, screenPosX + 0.076, screenPosY + 0.048)
                        
                    
                    --end
                   -- drawTxt("ENGINE", 2, EngineDrawColour, 0.4, screenPosX + 0.061, screenPosY + 0.048)
                    if vehicleClass ~= 8 then
                        local seatbeltColor = seatbeltIsOn and seatbeltColorOn or seatbeltColorOff
                        drawTxt("SEATBELT", 2, seatbeltColor, 0.4, screenPosX + 0.061, screenPosY + 0.063)
                    end
                end
            end
        else
            DisplayRadar(false)
            waitDelay = 500
        end
    end
end)

-- Secondary thread to update strings
Citizen.CreateThread(function()
    while true do
        -- Update when player is in a vehicle or on foot (if enabled)
        if pedInVeh or locationAlwaysOn then
            -- Get player, position and vehicle
            local player = GetPlayerPed(-1)
            local position = GetEntityCoords(player)

            -- Update time text string
            local hour = GetClockHours()
            local minute = GetClockMinutes()
            timeText = ("%.2d"):format((hour == 0) and 12 or hour) .. ":" .. ("%.2d"):format( minute) .. ((hour < 12) and " AM" or " PM")

            -- Get heading and zone from lookup tables and street name from hash
            local heading = directions[math.floor((GetEntityHeading(player) + 22.5) / 45.0)]
            local zoneNameFull = zones[GetNameOfZone(position.x, position.y, position.z)]
            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))
            
            -- Update location text string
            locationText = heading
            locationText = (streetName == "" or streetName == nil) and (locationText) or (locationText .. " | " .. streetName)
            locationText = (zoneNameFull == "" or zoneNameFull == nil) and (locationText) or (locationText .. " | " .. zoneNameFull)

            -- Update fuel when in a vehicle
            if pedInVeh then
                local vehicle = GetVehiclePedIsIn(player, false)
                if fuelShowPercentage then
                    -- Display remaining fuel as a percentage
                    currentFuel = 100 * GetVehicleFuelLevel(vehicle) / GetVehicleHandlingFloat(vehicle,"CHandlingData","fPetrolTankVolume")
                else
                    -- Display remainign fuel in liters
                    currentFuel = GetVehicleFuelLevel(vehicle)
                end
            end

            -- Update every second
            Citizen.Wait(1000)
        else
            -- Wait until next frame
            Citizen.Wait(0)
        end
    end
end)


function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, true)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- Helper function to draw text to screen
function drawTxt(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, 0.35)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    --SetTextDropShadow(0, 0, 0, 0,255)
    --SetTextDropShadow()
    --SetTextEdge(2, 0, 0, 0, 50)
    --SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end
--[[
function ejectionLUL()
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
    local coords = GetOffsetFromEntityInWorldCoords(veh, 1.0, 2.0, 1.0)
    local coords1 = GetOffsetFromEntityInWorldCoords(veh, 1.0, 3.0, 1.0)
    local coords2 = GetOffsetFromEntityInWorldCoords(veh, 1.0, 4.0, 1.0)
    local coords3 = GetOffsetFromEntityInWorldCoords(veh, 1.0, 5.0, 1.0)
    local coords4 = GetOffsetFromEntityInWorldCoords(veh, 1.0, 6.0, 1.0)
    local coords5 = GetOffsetFromEntityInWorldCoords(veh, 1.0, 7.0, 1.0)
    local coords6 = GetOffsetFromEntityInWorldCoords(veh, 1.0, 8.0, 1.0)
    local coords7 = GetOffsetFromEntityInWorldCoords(veh, 1.0, 9.0, 1.0)
    local veloc = GetEntityVelocity(veh)
    local playerPed = PlayerPedId()

  
    SetEntityCoords(GetPlayerPed(-1),coords)
    Citizen.Wait(0)
    SetPedToRagdollWithFall(GetPlayerPed(-1), 5511, 5511, 0, 0, 0, 0)
    SetEntityCoords(GetPlayerPed(-1),coords1)
    Citizen.Wait(0)
    SetEntityCoords(GetPlayerPed(-1),coords2)
    Citizen.Wait(0)
    SetEntityCoords(GetPlayerPed(-1),coords3)
    Citizen.Wait(0)
    SetEntityCoords(GetPlayerPed(-1),coords4)
    Citizen.Wait(0)
    SetEntityCoords(GetPlayerPed(-1),coords5)
    Citizen.Wait(0)
    SetEntityCoords(GetPlayerPed(-1),coords6)
    Citizen.Wait(0)
    SetEntityCoords(GetPlayerPed(-1),coords7)
    Citizen.Wait(0)
    

    --RespawnPed(playerPed, coords, 0.0)

    SetEntityVelocity(GetPlayerPed(-1), veloc.x*4,veloc.y*4,veloc.z*4)

    local ejectspeed = math.ceil(GetEntitySpeed(GetPlayerPed(-1)) * 8)

    SetEntityHealth( GetPlayerPed(-1), (GetEntityHealth(GetPlayerPed(-1)) - ejectspeed) )




end
--]]

function ejectionLUL()
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
    local coords = GetOffsetFromEntityInWorldCoords(veh, 1.0, 0.0, 1.0)
    local veloc = GetEntityVelocity(veh)

    SetEntityCoords(GetPlayerPed(-1),coords)
    Citizen.Wait(1)

    --RE ENABLE ONCE WE FIND A SOLUTION

    --Maybe make it so if they crash hard enough they get a notification (YOU SMASHED YOUR HEAD OFF THE STEERING WHEEL - only if they have no belt 
    -- and freeze there controls for a few seconds and make the screen fade black etc, If they have there belt on there fine)

    SetPedToRagdoll(GetPlayerPed(-1), 5511, 5511, 0, 0, 0, 0)

    SetEntityVelocity(GetPlayerPed(-1), veloc.x*4,veloc.y*4,veloc.z*4)

    --local ejectspeed = math.ceil(GetEntitySpeed(GetPlayerPed(-1)) * 8)

    --SetEntityHealth( GetPlayerPed(-1), (GetEntityHealth(GetPlayerPed(-1)) - ejectspeed) )

    SmashVehicleWindow(veh, 6)
end


function PopTires()
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1),false)

    SetVehicleTyreBurst(veh, 0, false, 0.001)
    SetVehicleTyreBurst(veh, 45, false, 0.001)
    SetVehicleTyreBurst(veh, 1, false, 0.001)
    SetVehicleTyreBurst(veh, 47, false, 0.001)
end


RegisterCommand('mph', function(source, args, rawCommand) 
	mph = true
end, false)

RegisterCommand('kmh', function(source, args, rawCommand) 
	mph = false
end, false)



--[[ RegisterCommand('emotes', function(source, args, raw)
    EmotesOnCommand() -- If anyone has a better solution for this please let me know, copied a the pairsByKeys func from stackoverflow and it wokrs a little bit better
  end) ]]




--------------------- COMPASS

local compassP = false

RegisterNetEvent('carHud:compass')
AddEventHandler('carHud:compass', function(table)
    if compassP == false then
        compassP = true
    else
        compassP = false
    end
end)

local compass = { cardinal={}, intercardinal={}}

-- Configuration. Please be careful when editing. It does not check for errors.
compass.show = true
compass.position = {x = 0.182, y = 0.982, centered = true}
compass.width = 0.03
compass.fov = 80
compass.followGameplayCam = false

compass.ticksBetweenCardinals = 9.0
compass.tickColour = {r = 255, g = 255, b = 255, a = 255}
compass.tickSize = {w = 0.001, h = 0.003}

compass.cardinal.textSize = 0.20
compass.cardinal.textOffset = 0.002
compass.cardinal.textColour = {r = 255, g = 255, b = 255, a = 255}

compass.cardinal.tickShow = true
compass.cardinal.tickSize = {w = 0.001, h = 0.012}
compass.cardinal.tickColour = {r = 255, g = 255, b = 255, a = 255}

compass.intercardinal.show = true
compass.intercardinal.textShow = true
compass.intercardinal.textSize = 0.15
compass.intercardinal.textOffset = 0.002
compass.intercardinal.textColour = {r = 255, g = 255, b = 255, a = 255}

compass.intercardinal.tickShow = true
compass.intercardinal.tickSize = {w = 0.001, h = 0.006}
compass.intercardinal.tickColour = {r = 255, g = 255, b = 255, a = 255}
-- End of configuration


Citizen.CreateThread( function()
	if compass.position.centered then
		compass.position.x = compass.position.x - compass.width / 2
	end
	
	while compass.show do
		Wait(5)
		if IsPedInAnyVehicle(PlayerPedId()) or compassP then
		
			local pxDegree = compass.width / compass.fov
			local playerHeadingDegrees = 0
			
			if compass.followGameplayCam then
				-- Converts [-180, 180] to [0, 360] where E = 90 and W = 270
				local camRot = Citizen.InvokeNative( 0x837765A25378F0BB, 0, Citizen.ResultAsVector() )
				playerHeadingDegrees = 360.0 - ((camRot.z + 360.0) % 360.0)
			else
				-- Converts E = 270 to E = 90
				playerHeadingDegrees = 360.0 - GetEntityHeading(PlayerPedId())
			end
			
			local tickDegree = playerHeadingDegrees - compass.fov / 2
			local tickDegreeRemainder = compass.ticksBetweenCardinals - (tickDegree % compass.ticksBetweenCardinals)
			local tickPosition = compass.position.x + tickDegreeRemainder * pxDegree
			
			tickDegree = tickDegree + tickDegreeRemainder
			
			while tickPosition < compass.position.x + compass.width do
				if (tickDegree % 90.0) == 0 then
					-- Draw cardinal
					if compass.cardinal.tickShow then
						DrawRect( tickPosition, compass.position.y, compass.cardinal.tickSize.w, compass.cardinal.tickSize.h, compass.cardinal.tickColour.r, compass.cardinal.tickColour.g, compass.cardinal.tickColour.b, compass.cardinal.tickColour.a )
					end
					
					drawText( degreesToIntercardinalDirection( tickDegree ), tickPosition, compass.position.y + compass.cardinal.textOffset, {
						size = compass.cardinal.textSize,
						colour = compass.cardinal.textColour,
						outline = true,
						centered = true
					})
				elseif (tickDegree % 45.0) == 0 and compass.intercardinal.show then
					-- Draw intercardinal
					if compass.intercardinal.tickShow then
						DrawRect( tickPosition, compass.position.y, compass.intercardinal.tickSize.w, compass.intercardinal.tickSize.h, compass.intercardinal.tickColour.r, compass.intercardinal.tickColour.g, compass.intercardinal.tickColour.b, compass.intercardinal.tickColour.a )
					end
					
					if compass.intercardinal.textShow then
						drawText( degreesToIntercardinalDirection( tickDegree ), tickPosition, compass.position.y + compass.intercardinal.textOffset, {
							size = compass.intercardinal.textSize,
							colour = compass.intercardinal.textColour,
							outline = true,
							centered = true
						})
					end
				else
					-- Draw tick
					DrawRect( tickPosition, compass.position.y, compass.tickSize.w, compass.tickSize.h, compass.tickColour.r, compass.tickColour.g, compass.tickColour.b, compass.tickColour.a )
				end
				
				-- Advance to the next tick
				tickDegree = tickDegree + compass.ticksBetweenCardinals
				tickPosition = tickPosition + pxDegree * compass.ticksBetweenCardinals
			end
		end
	end
end)


---- COMPASS ESSENTIAL

-- DrawText method wrapper, draws text to the screen.
-- @param1	string	The text to draw
-- @param2	float	Screen x-axis coordinate
-- @param3	float	Screen y-axis coordinate
-- @param4	table	Optional. Styles to apply to the text
-- @return
function drawText( str, x, y, style )
	if style == nil then
		style = {}
	end
	
	SetTextFont( (style.font ~= nil) and style.font or 0 )
	SetTextScale( 0.0, (style.size ~= nil) and style.size or 1.0 )
	SetTextProportional( 1 )
	
	if style.colour ~= nil then
		SetTextColour( style.colour.r ~= nil and style.colour.r or 255, style.colour.g ~= nil and style.colour.g or 255, style.colour.b ~= nil and style.colour.b or 255, style.colour.a ~= nil and style.colour.a or 255 )
	else
		SetTextColour( 255, 255, 255, 255 )
	end
	
	
	
	if style.centered ~= nil and style.centered == true then
		SetTextCentre( true )
	end
	
	
	
	SetTextEntry( "STRING" )
	AddTextComponentString( str )
	
	DrawText( x, y )
end

-- Converts degrees to (inter)cardinal directions.
-- @param1	float	Degrees. Expects EAST to be 90� and WEST to be 270�.
-- 					In GTA, WEST is usually 90�, EAST is usually 270�. To convert, subtract that value from 360.
--
-- @return			The converted (inter)cardinal direction.
function degreesToIntercardinalDirection( dgr )
	dgr = dgr % 360.0
	
	if (dgr >= 0.0 and dgr < 22.5) or dgr >= 337.5 then
		return "N "
	elseif dgr >= 22.5 and dgr < 67.5 then
		return "NE"
	elseif dgr >= 67.5 and dgr < 112.5 then
		return "E"
	elseif dgr >= 112.5 and dgr < 157.5 then
		return "SE"
	elseif dgr >= 157.5 and dgr < 202.5 then
		return "S"
	elseif dgr >= 202.5 and dgr < 247.5 then
		return "SW"
	elseif dgr >= 247.5 and dgr < 292.5 then
		return "W"
	elseif dgr >= 292.5 and dgr < 337.5 then
		return "NW"
	end
end

local button = 311

Citizen.CreateThread(function()
    while true do

        Citizen.Wait(0)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

        if (IsControlJustReleased(0, button) or IsDisabledControlJustReleased(0, button)) and vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) and IsInputDisabled(2) then
            toggleEngine()
        end
    end
end)

function toggleEngine()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local engine = GetVehicleEngineHealth(vehicle)

    if vehicle ~= nil and vehicle ~= 0 then

        if (GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(-1)) then

            if IsVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false)) then
                SetVehicleEngineOn(vehicle, false, false, true)
                RLCore.Functions.Notify("Engine Halted")
            else
                if engine >= 250.0 then
                    SetVehicleEngineOn(vehicle, true, false, true)
                    RLCore.Functions.Notify("Engine Started")
                else
                    RLCore.Functions.Notify("Your engine seems to have died, Call a mechanic!")
                end
            end
        end
    end
end