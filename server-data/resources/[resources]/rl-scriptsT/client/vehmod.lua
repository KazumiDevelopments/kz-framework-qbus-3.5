local copCars = {
    "police2", -- police / sheriff charger
    "police3", -- police SUV
    "policeb", -- police bike
    "sheriff", -- sheriff cvsi
    "sheriff2", -- sheriff SUV
    "hwaycar2", -- trooper cvpi
    "hwaycar", -- trooper suv
    "hwaycar3", -- trooper charger
    "2015polstang", -- mustang pursuit
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
local veloc = GetEntityVelocity(veh)
local offroadVehicle = false
local NosVehicles = {}
local seatbelt = false

RegisterNetEvent("veh:seatbelt")
AddEventHandler("veh:seatbelt", function(toggle)
    seatbelt = toggle
end)

function ejectionLUL()
    local veh = GetVehiclePedIsIn(PlayerPedId(),false)
    local coords = GetOffsetFromEntityInWorldCoords(veh, 1.0, 0.0, 1.0)
    SetEntityCoords(PlayerPedId(),coords)
    Citizen.Wait(1)
    SetPedToRagdoll(PlayerPedId(), 5511, 5511, 0, 0, 0, 0)
    SetEntityVelocity(PlayerPedId(), veloc.x*4,veloc.y*4,veloc.z*4)
    local ejectspeed = math.ceil(GetEntitySpeed(PlayerPedId()) * 8)
    SetEntityHealth( PlayerPedId(), (GetEntityHealth(PlayerPedId()) - ejectspeed) )
end

RegisterNetEvent("carhud:ejection:client")
AddEventHandler("carhud:ejection:client",function(plate)
    local curplate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
    if curplate == plate and not seatbelt then
        if math.random(10) > 7 then
            ejectionLUL()
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    local firstDrop = GetEntityVelocity(PlayerPedId())
    local lastentSpeed = 0
    local newvehicleBodyHealth = 0
    local newvehicleEngineHealth = 0
    local currentvehicleEngineHealth = 0
    local currentvehicleBodyHealth = 0
    local frameBodyChange = 0
    local frameEngineChange = 0
    local lastFrameVehiclespeed = 0
    local lastFrameVehiclespeed2 = 0
    local thisFrameVehicleSpeed = 0
    local tick = 0
    local damagedone = false
    while true do
        Citizen.Wait(5)
        local playerPed = PlayerPedId()
        local currentVehicle = GetVehiclePedIsIn(playerPed, false)
        local driverPed = GetPedInVehicleSeat(currentVehicle, -1)
        if currentVehicle ~= nil and currentVehicle ~= false and currentVehicle ~= 0 then
            SetPedHelmet(playerPed, false)
            lastVehicle = GetVehiclePedIsIn(playerPed, false)
            if driverPed == PlayerPedId() then
                if (GetVehicleHandbrake(currentVehicle) or (GetVehicleSteeringAngle(currentVehicle)) > 25.0 or (GetVehicleSteeringAngle(currentVehicle)) < -25.0) then
                    if handbrake == 0 then
                        handbrake = 100
                        TriggerEvent("resethandbrake")
                    else
                        handbrake = 100
                    end
                end
                if NosVehicles[currentVehicle] == nil then
                    NosVehicles[currentVehicle] = 0
                end
                thisFrameVehicleSpeed = GetEntitySpeed(currentVehicle) * 3.6
                if (IsControlJustReleased(1,21) or NosVehicles[currentVehicle] < 10) and nitroTimer then
                    endNos()
                end
                if IsControlPressed(1,21) and not disablenos and handbrake < 5 and thisFrameVehicleSpeed > 45.0 and not IsThisModelAHeli(GetEntityModel(currentVehicle)) and not IsThisModelABoat(GetEntityModel(currentVehicle)) and not IsThisModelABike(GetEntityModel(currentVehicle)) and NosVehicles[currentVehicle] ~= nil then
                    if NosVehicles[currentVehicle] > 1 then
                        TriggerEvent("NosBro",currentVehicle)
                        NosVehicles[currentVehicle] = NosVehicles[currentVehicle] - 1
                    end
                end
                currentvehicleBodyHealth = GetVehicleBodyHealth(currentVehicle)
                if currentvehicleBodyHealth == 1000 and frameBodyChange ~= 0 then
                    frameBodyChange = 0
                end
                if frameBodyChange ~= 0 then
                    if lastFrameVehiclespeed > 110 and thisFrameVehicleSpeed < (lastFrameVehiclespeed * 0.75) and not damagedone then
                        if frameBodyChange > 18.0 then
                            if not IsThisModelABike(currentVehicle) then
                                TriggerServerEvent("carhud:ejection:server",GetVehicleNumberPlateText(currentVehicle))
                            end
                            if not seatbelt and not IsThisModelABike(currentVehicle) then
                                if math.random(math.ceil(lastFrameVehiclespeed)) > 110 then
                                    ejectionLUL()
                                end
                            elseif seatbelt and not IsThisModelABike(currentVehicle) then
                                if lastFrameVehiclespeed > 150 then
                                    if math.random(math.ceil(lastFrameVehiclespeed)) > 99 then
                                        ejectionLUL()
                                    end
                                end
                            end
                        else
                            if not IsThisModelABike(currentVehicle) then
                                TriggerServerEvent("carhud:ejection:server",GetVehicleNumberPlateText(currentVehicle))
                            end

                            if not seatbelt and not IsThisModelABike(currentVehicle) then
                                if math.random(math.ceil(lastFrameVehiclespeed)) > 60 then
                                    ejectionLUL()
                                end
                            elseif seatbelt and not IsThisModelABike(currentVehicle) then
                                if lastFrameVehiclespeed > 120 then
                                    if math.random(math.ceil(lastFrameVehiclespeed)) > 99 then
                                        ejectionLUL()
                                    end
                                end
                            end
                        end
                        damagedone = true
                        local wheels = {0,1,4,5}
                        for i=1, math.random(4) do
                            local wheel = math.random(#wheels)
                            table.remove(wheels, wheel)
                        end
                        SetVehicleEngineOn(currentVehicle, true, true, true)
                        Citizen.Wait(1000)
                        TriggerEvent("civilian:alertPolice",50.0,"carcrash",0)
                    end
                    if currentvehicleBodyHealth < 350.0 and not damagedone then
                        damagedone = true
                        local wheels = {0,1,4,5}
                        for i=1, math.random(4) do
                            local wheel = math.random(#wheels)
                            table.remove(wheels, wheel)
                        end
                        SetVehicleEngineOn(currentVehicle, true, true, true)
                        Citizen.Wait(1000)
                    end
                end
                if lastFrameVehiclespeed < 110 then
                    Wait(100)
                    tick = 0
                end
                frameBodyChange = newvehicleBodyHealth - currentvehicleBodyHealth
                if tick > 0 then
                    tick = tick - 1
                    if tick == 1 then
                        lastFrameVehiclespeed = GetEntitySpeed(currentVehicle) * 3.6
                    end
                else
                    lastFrameVehiclespeed2 = lastFrameVehiclespeed
                    if damagedone then
                        damagedone = false
                        frameBodyChange = 0
                        lastFrameVehiclespeed = GetEntitySpeed(currentVehicle) * 3.6
                    end

                    if thisFrameVehicleSpeed > lastFrameVehiclespeed2 then
                        lastFrameVehiclespeed = GetEntitySpeed(currentVehicle) * 3.6
                    end

                    if thisFrameVehicleSpeed < lastFrameVehiclespeed2 then
                        tick = 25
                    end
                end
                vels = GetEntityVelocity(currentVehicle)
                if tick < 0 then
                    tick = 0
                end
                newvehicleBodyHealth = GetVehicleBodyHealth(currentVehicle)
            else
                vels = GetEntityVelocity(currentVehicle)
                Wait(1000)
            end
            veloc = GetEntityVelocity(currentVehicle)
        else
            if lastVehicle ~= nil then
                SetPedHelmet(playerPed, true)
                Citizen.Wait(200)
                newvehicleBodyHealth = GetVehicleBodyHealth(lastVehicle)
                if not damagedone and newvehicleBodyHealth < currentvehicleBodyHealth then
                    damagedone = true                   
                    SetVehicleEngineOn(lastVehicle, true, true, true)
                    Citizen.Wait(1000)
                end
                lastVehicle = nil
            end
            lastFrameVehiclespeed = 0
            lastFrameVehiclespeed2 = 0
            newvehicleBodyHealth = 0
            currentvehicleBodyHealth = 0
            frameBodyChange = 0
            Citizen.Wait(2000)
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		DisablePlayerVehicleRewards(PlayerId())	
	end
end)