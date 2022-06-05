-- Author - FuryX#6060
local chance = 0
local skillGap = 20
local factor = 1.0
local taskInProcess = false
local calm = true

function openGui(sentLength,taskID,namesent,chancesent,skillGapSent)
    guiEnabled = true
    SetNuiFocus(guiEnabled,false)
    SendNUIMessage({runProgress = true, Length = sentLength, Task = taskID, name = namesent, chance = chancesent, skillGap = skillGapSent})
end
function updateGui(sentLength,taskID,namesent,chancesent,skillGapSent)
    SendNUIMessage({runUpdate = true, Length = sentLength, Task = taskID, name = namesent, chance = chancesent, skillGap = skillGapSent})
end
local activeTasks = 0
function closeGuiFail()
    guiEnabled = false
    SetNuiFocus(guiEnabled,false)
    SendNUIMessage({closeFail = true})
end
function closeGui()
    guiEnabled = false
    SetNuiFocus(guiEnabled,false)
    SendNUIMessage({closeProgress = true})
end

function closeNormalGui()
    guiEnabled = false
    SetNuiFocus(guiEnabled, false)
end
  
RegisterNUICallback('taskCancel', function(data, cb)
  closeGui()
  activeTasks = 2
  FactorFunction(false)
end)

RegisterNUICallback('taskEnd', function(data, cb)
    closeNormalGui()
    activeTasks = 3
    factor = 1.0
end)


function FactorFunction(pos)
    if not pos then
        factor = factor - 0.1
        if factor < 0.1 then
            factor = 0.1
        end
        if factor == 0.5 and calm then
            calm = false 
            QBCore.Functions.Notify("You are getting frustrated", "error", 3500)

        end
        TriggerEvent("factor:restore")        
    else
        if factor > 1.0 or factor == 0.9 then
            if not calm then
                QBCore.Functions.Notify("You are calm again", "primary", 3500)

                calm = true
            end            
            factor = 1.0
            return
        end
        factor = factor + 0.1
    end    
end

RegisterNetEvent('factor:restore')
AddEventHandler('factor:restore', function()
    Wait(15000)
    FactorFunction(true)
end)


function taskBar(difficulty,skillGapSent)
    Wait(100)
    skillGap = skillGapSent
    if skillGap < 5 then
        skillGap = 5
    end
    local name = "E"
    local playerPed = PlayerPedId()
    if taskInProcess then
        return 100
    end
    FactorFunction(false)
    chance = math.random(15,90)

    local length = math.ceil(difficulty * factor)

    taskInProcess = true
    local taskIdentifier = "taskid" .. math.random(1000000)
    openGui(length,taskIdentifier,name,chance,skillGap)
    activeTasks = 1

    while activeTasks == 1 do
        Citizen.Wait(1)
    end

    if activeTasks == 2 then
        closeGui()
        taskInProcess = false 
        return 0
    else
        closeGui()
        taskInProcess = false
        return 100
    end 
end

RegisterCommand("test", function()
    exports["np-skillbar"]:taskBar(1200,7)
end)
