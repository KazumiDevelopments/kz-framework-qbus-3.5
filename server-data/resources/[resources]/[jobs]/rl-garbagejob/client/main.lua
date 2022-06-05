RLCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent('RLCore:GetObject', function(obj) 
                RLCore = obj 
            end)
            Citizen.Wait(200)
        end
    end
end)

isLoggedIn = false
PlayerJob = {}

local GarbageVehicle = nil
local hasVuilniswagen = false
local hasZak = false
local GarbageLocation = 0
local DeliveryBlip = nil
local IsWorking = false
local AmountOfBags = 0
local GarbageObject = nil
local EndBlip = nil
local GarbageBlip = nil
local Earnings = 0
local CanTakeBag = true

local currentRuns, currentLocations = 0, {}

RegisterNetEvent('RLCore:Client:OnPlayerLoaded')
AddEventHandler('RLCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = RLCore.Functions.GetPlayerData().job
    GarbageVehicle = nil
    hasVuilniswagen = false
    hasZak = false
    GarbageLocation = 0
    DeliveryBlip = nil
    IsWorking = false
    AmountOfBags = 0
    GarbageObject = nil
    EndBlip = nil

    --if PlayerJob.name == "garbage" then
    GarbageBlip = AddBlipForCoord(Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z)
    SetBlipSprite(GarbageBlip, 318)
    SetBlipDisplay(GarbageBlip, 4)
    SetBlipScale(GarbageBlip, 0.6)
    SetBlipAsShortRange(GarbageBlip, true)
    SetBlipColour(GarbageBlip, 39)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations["main"].label)
    EndTextCommandSetBlipName(GarbageBlip)
    --end
end)

RegisterNetEvent("RLCore:Client:OnJobUpdate")
AddEventHandler("RLCore:Client:OnJobUpdate", function(JobInfo)
	PlayerJob = JobInfo
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DrawText3D2(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x,coords.y,coords.z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function LoadModel(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(10)
    end
end

function LoadAnimation(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
end

function BringBackCar()
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1))
    DeleteVehicle(veh)
    if EndBlip ~= nil then
        RemoveBlip(EndBlip)
    end
    if DeliveryBlip ~= nil then
        RemoveBlip(DeliveryBlip)
    end
    if Earnings > 0 then
        PayCheckLoop(GarbageLocation)
    end
    GarbageVehicle = nil
    hasVuilniswagen = false
    hasZak = false
    GarbageLocation = 0
    DeliveryBlip = nil
    IsWorking = false
    AmountOfBags = 0
    GarbageObject = nil
    EndBlip = nil
end

function PayCheckLoop(location)
    Citizen.CreateThread(function()
        while Earnings > 0 do
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local coords = Config.Locations["paycheck"].coords
            local distance = GetDistanceBetweenCoords(pos, coords.x, coords.y, coords.z, true)

            if distance < 20 then
                DrawMarker(2, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 233, 55, 22, 222, false, false, false, true, false, false, false)
                if distance < 1.5 then
                    DrawText3D(coords.x, coords.y, coords.z, "[E] - Payslip")
                    if IsControlJustPressed(0, Keys["E"]) then
                        TriggerServerEvent('rl-garbagejob:server:Pay', Earnings, location)
                        Earnings = 0
                    end
                elseif distance < 5 then
                    DrawText3D(coords.x, coords.y, coords.z, "Payslip")
                end
            end

            Citizen.Wait(1)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local spawnplek = Config.Locations["vehicle"].label
        local InVehicle = IsPedInAnyVehicle(GetPlayerPed(-1), false)
        local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, true)
        
        if isLoggedIn then
            --if PlayerJob.name == "garbage" then
                if distance < 10.0 then
                    DrawMarker(2, Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 233, 55, 22, 222, false, false, false, true, false, false, false)
                    if distance < 1.5 then
                        if InVehicle then
                            DrawText3D(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, "[E] - Store garbage truck")
                            if IsControlJustReleased(0, Keys["E"]) then
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
                                DrawText3D(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, "[E] - Garbage truck")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    RLCore.Functions.TriggerCallback('rl-garbagejob:server:HasMoney', function(HasMoney)
                                        if HasMoney then
                                            local coords = Config.Locations["vehicle"].coords
                                            RLCore.Functions.SpawnVehicle("trash2", function(veh)
                                                GarbageVehicle = veh
                                                SetVehicleNumberPlateText(veh, "GARB"..tostring(math.random(1000, 9999)))
                                                SetEntityHeading(veh, coords.h)
                                                exports['lj-fuel']:SetFuel(veh, 100)
                                                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                                                SetEntityAsMissionEntity(veh, true, true)
                                                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
                                                SetVehicleEngineOn(veh, true, true)
                                                hasVuilniswagen = true
                                                GarbageLocation = 1
                                                IsWorking = true
                                                SetGarbageRoute()
                                                RLCore.Functions.Notify("You have paid $1000!")
                                                RLCore.Functions.Notify("You have started working, location is indicated on your GPS!")
                                            end, coords, true)
                                        else
                                            RLCore.Functions.Notify("You do not have enough money for the deposit .. Deposit costs are $ 1000, -")
                                        end
                                    end)
                                end
                            else
                                DrawText3D(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, "Return The Old Truck To Get A New One")
                            end
                        end
                    end
                end
            --end
        end

        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do

        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local inRange = false

        if isLoggedIn then
            --if PlayerJob.name == "garbage" then
                if IsWorking then
                    if GarbageLocation ~= 0 then
                        if DeliveryBlip ~= nil then
                            local DeliveryData = Config.Locations["vuilnisbakken"][GarbageLocation]
                            local Distance = GetDistanceBetweenCoords(pos, DeliveryData.coords.x, DeliveryData.coords.y, DeliveryData.coords.z, true)

                            if Distance < 20 or hasZak then
                                LoadAnimation('missfbi4prepp1')
                                DrawMarker(2, DeliveryData.coords.x, DeliveryData.coords.y, DeliveryData.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 55, 22, 255, false, false, false, false, false, false, false)
                                if not hasZak then
                                    if CanTakeBag then
                                        if Distance < 1.5 then
                                            DrawText3D2(DeliveryData.coords, "[E] - Grab a garbage bag")
                                            if IsControlJustPressed(0, 51) then
                                                if AmountOfBags == 0 then
                                                    AmountOfBags = math.random(2, 4)
                                                end 
                                                hasZak = true
                                                TakeAnim()
                                            end
                                        elseif Distance < 10 then
                                            DrawText3D2(DeliveryData.coords, "Stand here to grab garbage bag.")
                                        end
                                    end
                                else
                                    if DoesEntityExist(GarbageVehicle) then
                                        if Distance < 10 then
                                            DrawText3D2(DeliveryData.coords, "Put the bag in your truck ..")
                                        end

                                        local Coords = GetOffsetFromEntityInWorldCoords(GarbageVehicle, 0.0, -4.5, 0.0)
                                        local TruckDist = GetDistanceBetweenCoords(pos, Coords.x, Coords.y, Coords.z, true)

                                        if TruckDist < 2 then
                                            DrawText3D(Coords.x, Coords.y, Coords.z, "[E] - Throw away the trash bag")
                                            if IsControlJustPressed(0, 51) then
                                                hasZak = false
                                                local AmountOfLocations = #Config.Locations["vuilnisbakken"]
                                                if (AmountOfBags - 1) == 0 then
                                                    Earnings = Earnings + math.random(125, 195)

                                                    local foundNextLocation, randomLocation = true, -1
                                                    while foundNextLocation do
                                                        foundNextLocation = false
                                                        randomLocation = math.random(1, AmountOfLocations)
                                                        for _, v in pairs(currentLocations) do
                                                            if v == randomLocation then
                                                                foundNextLocation = true
                                                            end
                                                        end
                                                        Wait(0)
                                                    end
                                                    
                                                    table.insert(currentLocations, randomLocation)
                                                    currentRuns, GarbageLocation = currentRuns + 1, randomLocation

                                                    if currentRuns <= 2 then
                                                        SetGarbageRoute()
                                                        RLCore.Functions.Notify("All garbage bags are done, move on to the next location!")
                                                    else
                                                        RLCore.Functions.Notify("You are done working! Go back to the dump.")
                                                        --TriggerEvent('bb-scripts:client:locationChange', 'a') 
                                                        IsWorking = false
                                                        RemoveBlip(DeliveryBlip)
                                                        SetRouteBack()

                                                        currentRuns, currentLocations = 0, {}
                                                    end
                                                    AmountOfBags = 0
                                                    hasZak = false
                                                else
                                                    -- Hier heb je nog niet alle zakken afgeleverd
                                                    AmountOfBags = AmountOfBags - 1
                                                    if AmountOfBags > 1 then
                                                        RLCore.Functions.Notify("There are still "..AmountOfBags.." bags left!")
                                                    else
                                                        RLCore.Functions.Notify("There is still "..AmountOfBags.." bag over!")
                                                    end
                                                    hasZak = false
                                                end
                                                DeliverAnim()
                                            end
                                        elseif TruckDist < 10 then
                                            DrawText3D(Coords.x, Coords.y, Coords.z, "Stand here ..")
                                        end
                                    else
                                        DrawText3D2(DeliveryData.coords, "You don't have a truck ..")
                                    end
                                end
                            end
                        end
                    end
                end
            --end
        end

        if not IsWorking then
            Citizen.Wait(1000)
        end

        Citizen.Wait(1)
    end
end)

function SetGarbageRoute()
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    local CurrentLocation = Config.Locations["vuilnisbakken"][GarbageLocation]

    if DeliveryBlip ~= nil then
        RemoveBlip(DeliveryBlip)
    end

    DeliveryBlip = AddBlipForCoord(CurrentLocation.coords.x, CurrentLocation.coords.y, CurrentLocation.coords.z)
    SetBlipSprite(DeliveryBlip, 1)
    SetBlipDisplay(DeliveryBlip, 2)
    SetBlipScale(DeliveryBlip, 1.0)
    SetBlipAsShortRange(DeliveryBlip, false)
    SetBlipColour(DeliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations["vuilnisbakken"][GarbageLocation].name)
    EndTextCommandSetBlipName(DeliveryBlip)
    SetBlipRoute(DeliveryBlip, true)
end

function SetRouteBack()
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    local inleverpunt = Config.Locations["vehicle"]

    EndBlip = AddBlipForCoord(inleverpunt.coords.x, inleverpunt.coords.y, inleverpunt.coords.z)
    SetBlipSprite(EndBlip, 1)
    SetBlipDisplay(EndBlip, 2)
    SetBlipScale(EndBlip, 1.0)
    SetBlipAsShortRange(EndBlip, false)
    SetBlipColour(EndBlip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations["vehicle"].name)
    EndTextCommandSetBlipName(EndBlip)
    SetBlipRoute(EndBlip, true)
end

function TakeAnim()
    local ped = GetPlayerPed(-1)

    LoadAnimation('missfbi4prepp1')
    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
    GarbageObject = CreateObject(GetHashKey("prop_cs_rub_binbag_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(GarbageObject, ped, GetPedBoneIndex(ped, 57005), 0.12, 0.0, -0.05, 220.0, 120.0, 0.0, true, true, false, true, 1, true)

    AnimCheck()
end

function AnimCheck()
    Citizen.CreateThread(function()
        while true do
            local ped = GetPlayerPed(-1)

            if hasZak then
                if not IsEntityPlayingAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 3) then
                    ClearPedTasks(GetPlayerPed(-1))
                    LoadAnimation('missfbi4prepp1')
                    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
                end
            else
                break
            end

            Citizen.Wait(200)
        end
    end)
end

function DeliverAnim()
    local ped = GetPlayerPed(-1)

    LoadAnimation('missfbi4prepp1')
    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_throw_garbage_man', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, GetEntityHeading(GarbageVehicle))
    CanTakeBag = false

    SetTimeout(1250, function()
        DetachEntity(GarbageObject, 1, false)
        DeleteObject(GarbageObject)
        TaskPlayAnim(ped, 'missfbi4prepp1', 'exit', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
        FreezeEntityPosition(ped, false)
        GarbageObject = nil
        CanTakeBag = true
    end)
end

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource then
        if GarbageObject ~= nil then
            DeleteEntity(GarbageObject)
            GarbageObject = nil
        end
    end
end)