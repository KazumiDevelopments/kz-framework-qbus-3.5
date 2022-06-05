RLCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

isLoggedIn = false
local PlayerJob = {}

Citizen.CreateThread(function()
    while RLCore == nil do
        TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
        Citizen.Wait(200)
    end

    while RLCore.Functions.GetPlayerData() == nil do
        Wait(0)
    end

    while RLCore.Functions.GetPlayerData().job == nil do
        Wait(0)
    end

    isLoggedIn = true
    PlayerJob = RLCore.Functions.GetPlayerData().job

    --if PlayerJob.name == "tow" then

    --end
end)


local isCop = false
local isDoc = false
local isMedic = false
local isTher = false
local asSteamIdKeys = false

function DrawText3DTest(x,y,z, text)

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

isJudge = false
RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)


RegisterNetEvent( 'cell:doors' )
AddEventHandler( 'cell:doors', function(num)
    --TriggerEvent("dooranim")
    TriggerServerEvent("urp-doors:alterlockstate",tonumber(num))
end)


RegisterNetEvent( 'dooranim' )
AddEventHandler( 'dooranim', function()
    
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "anim@heists@keycard@" ) 
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(850)
    ClearPedTasks(PlayerPedId())

end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function cZ(num1,num2,maxLimit)
    local answer = false
    if (num1 - num2) > -1.2 and (num1 - num2) < maxLimit then
        answer = true
    end
    return answer
end


RegisterNetEvent("doors:HasKeys")
AddEventHandler("doors:HasKeys", function(boolRe)
    hasSteamIdKeys = boolRe
end)

local playerped = PlayerPedId()
local plyCoords = GetEntityCoords(playerped)

local closeDoorsStage1 = {}
local closeDoorsStage2 = {}

local distanceCheckStage1 = 140;
local distanceCheckStage2 = 80;

local TargetClosest = 0
local targetDoor = {};
local currentTargetDist = 999999;

local drawdist = 5.0
local distvariable = 20.0

local lastStaged = {}
local updatedCurrentStage = 0

local distantArea = {
    [1] = {1842.1411132813,2614.8305664063,44.628032684326,45},
    [2] = {465.51, -3119.87, 6.08,45},
    [3] = {15.47,-2536.23,6.15,70}, -- driving school
    [4] = {-195.26,-2516.0,6.14,70}, -- driving school
    [5] = {489.5,-1018.37,28.06,45}, -- back PD gate
    [6] = {-770.63,-240.00,37.43,45}, -- Import garage doors
    [7] = {410.98,-1026.32,29.4,15},
}

Controlkey = {["generalUse"] = {38,"E"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
  Controlkey["generalUse"] = table["generalUse"]
end)

Citizen.CreateThread(function() -- Calc Player position on a xx basis
    while true do
        playerped = PlayerPedId()
        plyCoords = GetEntityCoords(playerped)
        Wait(500)
    end
end)

Citizen.CreateThread(function()  -- Calc door around player into an array , dist of 100 every 5 seconds
    playerped = PlayerPedId()
    plyCoords = GetEntityCoords(playerped)
    while true do
        for i = 1, #URP.DoorCoords do
            local distance = #(plyCoords - vector3(URP.DoorCoords[i]["x"], URP.DoorCoords[i]["y"], URP.DoorCoords[i]["z"]))
            if distance < distanceCheckStage1 then
                closeDoorsStage1[i] = URP.DoorCoords[i]
            else
                if(closeDoorsStage1[i] ~= nil) then
                    closeDoorsStage1[i] = nil
                end
            end
        end
        Wait(5000)
    end
end)

Citizen.CreateThread(function() -- Calc door around player into an array based on first array , dist of 60 every 3 seconds
    while true do

        if #closeDoorsStage1 > 0 then
            local inZone = false
            local custDist = -1
            for i=1,#distantArea do
                local area = distantArea[i]
                if not inZone and #(plyCoords - vector3(area[1],area[2],area[3])) < area[4] then inZone = true custDist = area[4] end
            end
            if not inZone then
                distvariable = 20.0
                drawdist = 2.0
            else
                if custDist ~= -1 then
                    distvariable = custDist+5.0
                    drawdist = custDist+1.0
                else
                    distvariable = 40.0
                    drawdist = 20.0
                end
            end
        end

        for i, door in pairs(closeDoorsStage1) do
            local distance = #(plyCoords - vector3(door["x"], door["y"], door["z"]))
            
            if distance < distanceCheckStage2 then
                closeDoorsStage2[i] = door
            else
                if(closeDoorsStage2[i] ~= nil) then
                    closeDoorsStage2[i] = nil
                end
            end
        end
        Wait(3000)
        closeDoorsStage2 = {}       
        updatedCurrentStage = 0
        lastStaged = {}
    end
end)


Citizen.CreateThread(function() -- Freeze or unfreeze based on nearest doors calc by second stage check 
    while true do
        local hasEntered = false
        for i, door in pairs(closeDoorsStage2) do
            if updatedCurrentStage == 0 then
                hasEntered = true
                local obj = nil
                if (type(door["doorType"]) == "number") then
                    obj = GetClosestObjectOfType(door["x"], door["y"], door["z"], distvariable, door["doorType"], 0, 0, 0)
                else
                    obj = GetClosestObjectOfType(door["x"], door["y"], door["z"], distvariable, GetHashKey(door["doorType"]), 0, 0, 0)
                end
                lastStaged[i] = obj
            end

            if door["lock"] ~= nil then
                if door["lock"] == 1 then 
                    FreezeEntityPosition(lastStaged[i], true)                         
                else 
                    FreezeEntityPosition(lastStaged[i], false)
                end
            end
        end
        if hasEntered and updatedCurrentStage == 0 then updatedCurrentStage = 1 hasEntered = false  end
        Wait(200)
    end
end)


Citizen.CreateThread(function() -- Find the Single closest door 
    while true do
        local found = false
        for i, door in pairs(closeDoorsStage2) do
            local distance = #(plyCoords - vector3(door["x"], door["y"], door["z"]))
            if distance < currentTargetDist then
                found = true
                TargetClosest = i
                currentTargetDist = distance
                targetDoor = closeDoorsStage2[i]
            end

            
        end

        if not found then closeDoorsStage2 = {} end
        Wait(500)
        currentTargetDist = 999999
        newestTargetID = 0
        TargetClosest = 0
    end
end)


RegisterNetEvent("doors:resetTimer")
AddEventHandler("doors:resetTimer", function()
  closestTimer = 0
end)

local closestTimer = 999999
local newestTargetIDObject = 0
local objFound = nil

local newestTargerIDCoordsDoor = 0
local doorCoordsOffset = {}
local doorCoords = {}
local newestTargetID = 0

Citizen.CreateThread(function()

    while true do
        
        Citizen.Wait(5)

        local curClosestNum = TargetClosest
        local closestString = "None"
        
        


            
        local newaddition = currentTargetDist
        if newaddition < closestTimer then
            closestTimer = math.floor(newaddition)
        end

        if currentTargetDist < distvariable and targetDoor ~= nil then    
            closestTimer = 0

            if newestTargetID == 0 or newestTargetID ~= curClosestNum then
                newestTargetID = curClosestNum
                if (type(targetDoor["doorType"]) == "number") then
                    objFound = GetClosestObjectOfType(targetDoor["x"], targetDoor["y"], targetDoor["z"], distvariable, targetDoor["doorType"], 0, 0, 0)
                else
                    objFound = GetClosestObjectOfType(targetDoor["x"], targetDoor["y"], targetDoor["z"], distvariable, GetHashKey(targetDoor["doorType"]), 0, 0, 0)
                end
            end
    

            objCoords = GetEntityCoords(objFound)

            local limit = 1.0 
            if targetDoor["doorType"] == -550347177 then limit = 3.0 end
            if cZ(objCoords["z"],targetDoor["z"],limit) then
                if newestTargerIDCoordsDoor == 0 or newestTargerIDCoordsDoor ~= curClosestNum then
                    newestTargerIDCoordsDoor = curClosestNum
                    doorCoords = objCoords 
                end 

                if(URP.offSet[targetDoor["doorType"]]) then
                    if (type(targetDoor["doorType"]) == "number") then
                        local pos = URP.offSet[targetDoor["doorType"]]
                        doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, pos[1], pos[2], pos[3])
                    else
                        local pos = URP.offSet[targetDoor["doorType"]]
                        if pos ~= nil and pos[1] then
                            doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, pos[1], pos[2], pos[3])
                        else
                            doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.2, 0.0, 0.1)
                        end
                    end
                else

                    if (type(targetDoor["doorType"]) ~= "number") then
                        doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, -1.2, 0.0, -0.1)
                    else
                        doorCoordsOffset = GetOffsetFromEntityInWorldCoords(objFound, 1.2, 0.0, 0.1) 
                    end
                    
                end              
            end

        end

        if curClosestNum ~= 0 and targetDoor ~= nil then

            if targetDoor["lock"] == 1 then
                if (curClosestNum > 32 and curClosestNum < 61) then
                    closestString = "Locked (" .. curClosestNum .. ")"
                else
                    closestString = "Locked" 
                end
            else 
                if (curClosestNum > 32 and curClosestNum < 61) then
                    closestString = "Unlocked (" .. curClosestNum .. ")"
                else
                    closestString = "Unlocked"
                end
                
            end

            if currentTargetDist < drawdist then

                if isKeyDoor(curClosestNum) then
                    DrawText3DTest(doorCoordsOffset["x"], doorCoordsOffset["y"], doorCoordsOffset["z"], "["..Controlkey["generalUse"][2].."] - " .. closestString .. "" )
                else
                    if targetDoor["x"] == nil or targetDoor == nil or targetDoor["x"] == 0.0 then
                        DrawText3DTest(doorCoordsOffset["x"], doorCoordsOffset["y"], doorCoordsOffset["z"], "["..Controlkey["generalUse"][2].."] - " .. closestString .. "" )
                    else
                        DrawText3DTest(targetDoor["x"], targetDoor["y"], targetDoor["z"], "["..Controlkey["generalUse"][2].."] - " .. closestString .. "" )
                    end
                        
                end
            


                if  IsControlJustReleased(1,  Controlkey["generalUse"][1]) then
                    if OpenCheck(curClosestNum) then

                        local shortcheck = #(vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]) - vector3(doorCoordsOffset["x"], doorCoordsOffset["y"], doorCoordsOffset["z"]))

                        if shortcheck > 2.2 and isKeyDoor(curClosestNum) then
                            -- dont work til close enough
                        else

                            --TriggerEvent("dooranim")

                            if isKeyDoor(curClosestNum) then
                                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'keydoors', 0.4)
                            end
                            
                            if targetDoor["lock"] == 0 then

                                local active = true
                                local swingcount = 0
                                while active do
                                    Citizen.Wait(1)

                                    locked, heading = GetStateOfClosestDoorOfType(GetHashKey(targetDoor["doorType"]), doorCoords["x"], doorCoords["y"], doorCoords["z"]) 
                                    heading = math.ceil(heading * 100) 
                                    DrawText3DTest(doorCoordsOffset["x"], doorCoordsOffset["y"], doorCoordsOffset["z"], "Locking" )
                                    
                                    local dist = #(plyCoords - vector3(targetDoor["x"], targetDoor["y"], targetDoor["z"]))
                                    local dst2 = #(plyCoords - vector3(1830.45, 2607.56, 45.59))

                                    if heading < 1.5 and heading > -1.5 then
                                        swingcount = swingcount + 1
                                    end             
                                    if dist > 150.0 or swingcount > 100 or dst2 < 200.0 then
                                        active = false
                                    end
                                end

                            else

                                local active = true
                                local swingcount = 0
                                while active do
                                    Citizen.Wait(1)
                                    DrawText3DTest(doorCoordsOffset["x"], doorCoordsOffset["y"], doorCoordsOffset["z"], "Unlocking" )
                                    swingcount = swingcount + 1
                                    if swingcount > 100 then
                                        active = false
                                    end
                                end

                            end
                            TriggerServerEvent("urp-doors:alterlockstate",curClosestNum)
                        end
                    end
                end 
            end     
        end
    end
end)

function OpenCheck(curClosestNum)
    --local gangType = exports["isPed"]:isPed("gang")
    local job = RLCore.Functions.GetPlayerData().job.name
    --local job = ESX.GetPlayerData().job.name

    if (job == "police") and (curClosestNum >= 1 and curClosestNum <= 17) then
        return true
    end

    if (job == "police") and (curClosestNum >= 65 and curClosestNum <= 68) then
        return true
    end

    if (job == "police") and (curClosestNum >= 69 and curClosestNum <= 92) then
        return true
    end

    if (job == "police") and (curClosestNum >= 33 and curClosestNum <= 60) then
        return true
    end

    if (job == "police") and (curClosestNum == 61 or curClosestNum == 62) then
        return true
    end
    
    if (job == "ambulance" or job == "police") and (curClosestNum >= 18 and curClosestNum <= 32) then
        return true
    end 

    if (job == "cardealer" or job == "police") and (curClosestNum == 63 or curClosestNum == 64) then
        return true
    end
    
    --[[ local foundValid = false
    for k,v in pairs(URP.rankCheck) do
        --local rank = exports["isPed"]:GroupRank(k)
        for o,p in pairs(v) do
            if rank >= o and not foundValid then
                if p.between ~= nil then
                    for i=1,#p.between do
                        if curClosestNum >= p.between[i][1] and curClosestNum <= p.between[i][2] then foundValid = true end
                    end
                end

                if p.single ~= nil then
                    for i=1,#p.single do
                        if curClosestNum == p.single[i] then foundValid = true  end
                    end
                end
            end
        end
    end ]]

    if foundValid then
        return true
    end

    return false
end

-- add any doors that arent opened by the player being really close here, for example, gates and shit... could be done on table but /care - prefer function name
function isKeyDoor(num)
    if num == 0 then
        return false
    end
    if URP.DoorCoords[num]["doorType"] == "prop_gate_prison_01" then
        return false
    end
    if URP.DoorCoords[num]["doorType"] == 1286392437 then
        return false
    end
    if URP.DoorCoords[num]["doorType"] == "v_ilev_fin_vaultdoor" then
        return false
    end
    if URP.DoorCoords[num]["doorType"] == "prop_facgate_08" then
        return false
    end
    if URP.DoorCoords[num]["doorType"] == "hei_prop_station_gate" then
        return false
    end
    if URP.DoorCoords[num]["doorType"] == -1603817716 then
        return false
    end
    if URP.DoorCoords[num]["doorType"] == 1501451068 then
        return false
    end
    if URP.DoorCoords[num]["doorType"] == -550347177 then
        return false
    end
    return true
end
