local copCars = {
    "police2", -- police / sheriff charger
    "police3", -- police SUV
    "policeb", -- police bike
    "sheriff", -- sheriff cvsi
    "sheriff2", -- sheriff SUV
    "hwaycar2", -- trooper cvpi
    "hwaycar", -- trooper suv
    "hwaycar3", -- trooper charger
    "polstang", -- mustang pursuit
    "police", -- K9 Vehicle
    "police4", -- uc cv
    "fbi", -- uc charger
    "fbi2", -- uc cadi
    "pbus", -- prison bus
    "polmav", -- chopper
    "polaventa", --Aventador
    "pol718", -- porsche
    "polf430", -- ferrarri
    "romero", -- lmfao
    "predator"
}

local offroadVehicles = {
    "bifta",
    "blazer",
    "brawler",
    "dubsta3",
    "dune",
    "rebel2",
    "sandking",
    "trophytruck",
    "sanchez",
    "sanchez2",
    "blazer",
    "enduro",
    "pol9",
    "police3", -- police SUV
    "sheriff2", -- sheriff SUV
    "hwaycar", -- trooper suv   
    "fbi2",
    "bf400" 
}

local offroadbikes = {
    "ENDURO",
    "sanchez",
    "sanchez2"
}

local carsEnabled = {}
local airtime = 0
local offroadTimer = 0
local airtimeCoords = GetEntityCoords(PlayerPedId())
local heightPeak = 0
local lasthighPeak = 0
local highestPoint = 0
local zDownForce = 0
local veloc = GetEntityVelocity(GetVehiclePedIsIn(PlayerPedId()), false)
local offroadVehicle = false

local playerPed = nil
local currentVehicle = nil
local driverPed = nil
local harness = false
local harnessDurability = 0.0
local disableControl = false

DecorRegister("vehicleHarnessDur", 1) -- who knows if this works :)
local seatbelt = false

function downgrade(veh,power,offroad)
    local vehModel = GetEntityModel(veh)
    if carsEnabled["" .. veh .. ""] == nil then 
        return 
    end     
    if offroad then 
        power = power + 0.5
        if IsThisModelABike(vehModel) then
            power = power + 0.3
        else
            power = power + 0.3
        end

    end
    power = math.ceil(power * 10)

    local factor = math.random( 3+power ) / 10


    if factor > 0.7 then
        if IsThisModelABike(vehModel) then
            if not offroad then
                factor = 0.7
            end
        else
            if not offroad then
                factor = 0.7
            else
                factor = 0.8
            end
            
        end
    end

    if factor < 0.4 then
        if not offroad then
            factor = 0.25
        else
            factor = 0.4
        end
    end

    if carsEnabled["" .. veh .. ""] == nil then return end
    local carData = carsEnabled["" .. veh .. ""]
    SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel', carData["fInitialDriveMaxFlatVel"] * factor)
    --SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock', carsEnabled["" .. veh .. ""]["fSteeringLock"] * factor)
    SetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionLossMult', carData["fTractionLossMult"] * factor)
    SetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult', carData["fLowSpeedTractionLossMult"] * factor)
    SetVehicleEnginePowerMultiplier(veh,factor)
    SetVehicleEngineTorqueMultiplier(veh,factor)
    TriggerEvent("tuner:setDriver")
end

function ejectionLUL()
    if seatbelt then
        return
    end
    
    local veh = GetVehiclePedIsIn(playerPed,false)
    local coords = GetOffsetFromEntityInWorldCoords(veh, 1.0, 0.0, 1.0)
    SetEntityCoords(playerPed,coords)
    Citizen.Wait(1)
    SetPedToRagdoll(playerPed, 5511, 5511, 0, 0, 0, 0)
    SetEntityVelocity(playerPed, veloc.x*4,veloc.y*4,veloc.z*4)
    local ejectspeed = math.ceil(GetEntitySpeed(playerPed) * 8)
    SetEntityHealth(playerPed, (GetEntityHealth(playerPed) - ejectspeed) )
   -- TriggerEvent("randomBoneDamage")
end

function preventVehicleExit()
    Citizen.CreateThread(function()
        local options = {1000,2000,3000}
        disableControl = true
        local finished = exports["rl-taskbar"]:taskBar(options[math.random(1,3)],"Taking off Harness",true)
        if finished == 100 then
            harness = false
            TriggerEvent("harness", false, harnessDurability)
            TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
        end
        disableControl = false
    end)
end

function carCrash()
    --[[ local wheels = {0,1,4,5}
    for i=1, math.random(4) do
        local wheel = math.random(#wheels)
        SetVehicleTyreBurst(currentVehicle, wheels[wheel], true, 1000)
        table.remove(wheels, wheel)
    end ]]
    SetVehicleEngineHealth(currentVehicle, 0)
    SetVehicleEngineOn(currentVehicle, false, true, true)
    lastCurrentVehicleSpeed = 0.0
    lastCurrentVehicleBodyHealth = 0.0
end

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle
    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)  
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        offset = offset - 1
        if vehicle ~= 0 then break end
    end
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end

RegisterNetEvent("veh:seatbelt")
AddEventHandler("veh:seatbelt", function(bool)
    seatbelt = bool 
end)

function toggleSeatbelt()
   --[[ if seatbelt == false then
        TriggerEvent("seatbelt",true)
        TriggerEvent("InteractSound_CL:PlayOnOne","seatbelt",0.1)
        TriggerEvent("notification",'Seat Belt Enabled',4)
    else
        TriggerEvent("seatbelt",false)
        TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
        TriggerEvent("notification",'Seat Belt Disabled',4)
    end
    seatbelt = not seatbelt--]]
end

Citizen.CreateThread(function()
    local firstDrop = GetEntityVelocity(PlayerPedId())
    local lastentSpeed = 0
    while true do
        Citizen.Wait(1)

        if (IsPedInAnyVehicle(PlayerPedId(), false)) then

            local veh = GetVehiclePedIsIn(PlayerPedId(),false)
            if not invehicle and not IsThisModelABike(GetEntityModel(veh)) then
                invehicle = true
                TriggerEvent("InteractSound_CL:PlayOnOne","beltalarm",0.35)
            end
            
            local bicycle = IsThisModelABicycle( GetEntityModel(veh) )

            if carsEnabled["" .. veh .. ""] == nil and not bicycle then


                if IsThisModelABike(GetEntityModel(veh)) then


                SetVehicleHasBeenOwnedByPlayer(veh,true)
                carsEnabled["" .. veh .. ""] = { 
                    ["fInitialDriveMaxFlatVel"] = fInitialDriveMaxFlatVel, 
                    ["fSteeringLock"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock'), 
                    ["fTractionLossMult"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionLossMult'), 
                    ["fLowSpeedTractionLossMult"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult') 
                }
                local plt = GetVehicleNumberPlateText(veh)
            else
                Wait(1000)
            end


            if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then

                local coords = GetEntityCoords(PlayerPedId())
                local roadtest2 = IsPointOnRoad(coords.x, coords.y, coords.z, veh)
              --  roadtest, endResult, outHeading = GetClosestVehicleNode(coords.x, coords.y, coords.z,  1, 0, -1)
             --   endDistance = #(vector3(endResult.x, endResult.y, endResult.z) - GetEntityCoords(PlayerPedId()))   
                local myspeed = GetEntitySpeed(veh) * 3.6
                local xRot = GetEntityUprightValue(veh)
                if not roadtest2 then
                    if (xRot < 0.90) then
                        offroadTimer = offroadTimer + (1 - xRot)
                    elseif xRot > 0.90 then
                        if offroadTimer < 1 then
                            offroadTimer = 0
                        else
                            offroadTimer = offroadTimer - xRot
                            --resetdowngrade(veh)
                        end                         
                    end
                elseif offroadTimer > 0 or offroadTimer == 0 then
                    offroadTimer = 0
                    offroadVehicle = false 
                    --resetdowngrade(veh)
                end

                if offroadTimer > 5 and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then  
           
                    for i = 1, #offroadVehicles do
                        if IsVehicleModel( GetVehiclePedIsUsing(PlayerPedId()), GetHashKey(offroadVehicles[i]) ) then
                            offroadVehicle = true

                        end
                    end

                end

                if IsEntityInAir(veh) then
                    firstDrop = GetEntityVelocity(veh)
                    lastentSpeed = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())))
                    if airtime == 1 then
                        heightPeak = 0
                        lasthighPeak = 0                        
                        airtimeCoords = GetEntityCoords(veh)
                        lasthighPeak = airtimeCoords.z
                    else
                        local AirCurCoords = GetEntityCoords(veh)
                        heightPeak = AirCurCoords.z
                        if tonumber(heightPeak) > tonumber(lasthighPeak) and airtime ~= 0 then
                            lasthighPeak = heightPeak
                            highestPoint = heightPeak - airtimeCoords.z
                        end
                    end
                    airtime = airtime + 1
                elseif airtime > 0 then
                    
                    if airtime > 110 then
                        Citizen.Wait(333)
                        local landingCoords = GetEntityCoords(veh)  
                        local landingfactor = landingCoords.z - airtimeCoords.z     
                        local momentum = GetEntityVelocity(veh)
                        highestPoint = highestPoint - landingfactor

                        highestPoint = highestPoint * 0.55

                        airtime = math.ceil(airtime * highestPoint)

                        local xdf = 0
                        local ydf = 0
                        if momentum.x < 0 then
                            xdf = momentum.x
                            xdf = math.ceil(xdf - (xdf * 2))
                        else
                            xdf = momentum.x
                        end

                        if momentum.y < 0 then
                            ydf = momentum.y
                            ydf = math.ceil(ydf - (ydf * 2))
                        else
                            ydf = momentum.y
                        end



                        zdf = momentum.z 
                        lastzvel = firstDrop.z
                        print("IMPACT Z" .. zdf)
                        print("LAST DROP Z" .. lastzvel)


                        zdf = zdf - lastzvel
                        local dirtBike = false
                        for i = 1, #offroadbikes do
                            if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()), GetHashKey(offroadbikes[i], _r)) then
                                dirtBike = true
                            end
                        end
                        if dirtBike then
                            airtime = airtime - 200
                        end

                        if IsThisModelABicycle(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) then
                            print(airtime .. " what " .. zdf)
                            local ohshit = math.ceil((zdf * 200))
                            local entSpeed = math.ceil( GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 1.35 )
                            print("speed - " .. entSpeed)


                        elseif airtime > 950 and IsThisModelABike(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) then
                            print(airtime .. " what " .. zdf)
                            local ohshit = math.ceil((zdf * 200))
                            local entSpeed = math.ceil( GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 1.15 )
                            print("speed - " .. entSpeed)

                            
                                 
                        end
                    end
                    airtimeCoords = GetEntityCoords(PlayerPedId())
                    heightPeak = 0
                    airtime = 0
                    lasthighPeak = 0
                    zDownForce = 0
                end

                --GetVehicleClass(vehicle)
                local ped = PlayerPedId()
                local roll = GetEntityRoll(veh)

                if IsEntityInAir(veh) and not IsThisModelABike(GetEntityModel(veh)) then
                    DisableControlAction(0, 59)
                    DisableControlAction(0, 60)
                end
                if ((roll > 75.0 or roll < -75.0) or not IsVehicleEngineOn(veh)) and not IsThisModelABike(GetEntityModel(veh)) then         
                    DisableControlAction(2,59,true)
                    DisableControlAction(2,60,true)
                end
            else
                Wait(1000)
            end
        else
            if invehicle or seatbelt then
                if seatbelt then
                    TriggerEvent("InteractSound_CL:PlayOnOne","seatbeltoff",0.7)
                end
                invehicle = false
                seatbelt = false
                TriggerEvent("seatbelt",false)
            end
            Citizen.Wait(1500)
        end
    end
    end
end)

RegisterNetEvent("carhud:ejection:client")
AddEventHandler("carhud:ejection:client",function(value)
    veloc = value
    ejectionLUL()
end)

-- CurrentVehicle and DriverPed Updater --
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        playerPed = PlayerPedId()
        local tempVehicle = GetVehiclePedIsIn(playerPed, false)
        local tempDriver = GetPedInVehicleSeat(tempVehicle, -1)

        if tempVehicle ~= currentVehicle then
            harness = false
            seatbelt = false
            currentVehicle = tempVehicle
            if currentVehicle == nil or currentVehicle == 0 or currentVehicle == false then
                TriggerEvent("DensityModifierEnable", true)
            else
                driverPed = GetPedInVehicleSeat(currentVehicle, -1)
                if driverPed == playerPed then
                    TriggerEvent("DensityModifierEnable", true)
                    TriggerEvent("tuner:setDriver")
                else
                    TriggerEvent("DensityModifierEnable", false)
                end
                
            end
        elseif (tempDriver ~= driverPed and tempDriver ~= 0) or (tempDriver == 0 and driverPed == playerPed) then
            driverPed = tempDriver
            if driverPed == playerPed then
                -- Switched seat to driver
                if seatbelt then
                    toggleSeatbelt()
                end
                TriggerEvent("DensityModifierEnable", true)
                TriggerEvent("tuner:setDriver")
            else
                if harness then
                elseif seatbelt then
                    toggleSeatbelt()
                end

                TriggerEvent("DensityModifierEnable", false)
            end

            TriggerEvent("seatbelt",false)
        end
    end
end)

-- Collision Thread --
--[[ Citizen.CreateThread(function()
    Citizen.Wait(1000)
    local lastCurrentVehicleBodyHealth = 0
    local lastCurrentVehicleSpeed = 0

    local function eject(percent, speed, trigger)
        if math.random(math.ceil(speed)) > percent then
            ejectionLUL()
            if trigger then
                TriggerEvent("dispatch:carCrash")
            end
        end
    end

    while true do
        Citizen.Wait(1)
        if currentVehicle ~= nil and currentVehicle ~= false and currentVehicle ~= 0 then
            SetPedHelmet(playerPed, false)
            if driverPed == playerPed then
                local currentEngineHealth = GetVehicleEngineHealth(currentVehicle)
                if currentEngineHealth < 0.0 then
                    -- Dont blow up
                    SetVehicleEngineHealth(currentVehicle,0.0)
                end

                local collision = HasEntityCollidedWithAnything(currentVehicle)
                if collision == false then
                    lastCurrentVehicleSpeed = GetEntitySpeed(currentVehicle)
                    lastCurrentVehicleBodyHealth = GetVehicleBodyHealth(currentVehicle)
                    veloc = GetEntityVelocity(currentVehicle)
                    if currentEngineHealth > 10.0 and (currentEngineHealth < 175.0 or lastCurrentVehicleBodyHealth < 50.0) then
                        carCrash()
                        Citizen.Wait(1000)
                    end             
                else
                    Citizen.Wait(100)
                    local currentVehicleBodyHealth = GetVehicleBodyHealth(currentVehicle)
                    local currentVehicleSpeed = GetEntitySpeed(currentVehicle)
                    if currentEngineHealth > 0.0 and lastCurrentVehicleBodyHealth - currentVehicleBodyHealth > 15 then
                        if lastCurrentVehicleSpeed > 30.5 and currentVehicleSpeed < (lastCurrentVehicleSpeed * 0.75) then
                            if not IsThisModelABike(GetEntityModel(currentVehicle)) then
                                --carCrash()
                                print("2") 
                                sendServerEventForPassengers("carhud:ejection:server", veloc)
                                if harness and harnessDurability > 0.0 then
                                    harnessDurability = harnessDurability - 0.1
                                    if DecorExistOn(currentVehicle, "vehicleHarnessDur") then
                                        DecorSetFloat(currentVehicle, "vehicleHarnessDur", harnessDurability)
                                    end
                                    if harnessDurability <= 0.0 then
                                        harnessDurability = 0.0
                                        TriggerEvent("event:control:vehicleMod")
                                    end
                                elseif not seatbelt then
                                    eject(30.5, lastCurrentVehicleSpeed, true)
                                elseif seatbelt and lastCurrentVehicleSpeed > 41.6 then
                                    eject(33.0, lastCurrentVehicleSpeed, false)
                                end
                                -- Buffer after crash
                                Citizen.Wait(1000)
                                lastCurrentVehicleSpeed = 0.0
                                lastCurrentVehicleBodyHealth = currentVehicleBodyHealth
                            else
                                -- IsBike
                                carCrash()
                                Citizen.Wait(1000)
                                lastCurrentVehicleSpeed = 0.0
                                lastCurrentVehicleBodyHealth = currentVehicleBodyHealth
                            end
                        end
                    else
                        if currentEngineHealth > 10.0 and (currentEngineHealth < 195.0 or currentVehicleBodyHealth < 50.0) then
                            carCrash()
                            print("3")
                            Citizen.Wait(1000)
                        end                        
                        lastCurrentVehicleSpeed = currentVehicleSpeed
                        lastCurrentVehicleBodyHealth = currentVehicleBodyHealth
                    end
                end
            else
                -- Not driver
                Citizen.Wait(1000)
            end
        else
            -- Not in veh
            currentVehicleSpeed = 0
            lastCurrentVehicleSpeed = 0
            lastCurrentVehicleBodyHealth = 0
            Citizen.Wait(4000)
        end
    end
end) ]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        DisablePlayerVehicleRewards(PlayerId()) 
    end
end)

function sendServerEventForPassengers(event, value)
    local player = PlayerPedId()
    for i=-1, GetVehicleMaxNumberOfPassengers(currentVehicle)-1 do
        local ped = GetPedInVehicleSeat(currentVehicle, i)
        if ped ~= player then
            for j,v in pairs(GetActivePlayers()) do
                if GetPlayerPed(v) == ped then
                    TriggerServerEvent(event, GetPlayerServerId(v), value)
                end
            end
        end
    end
end