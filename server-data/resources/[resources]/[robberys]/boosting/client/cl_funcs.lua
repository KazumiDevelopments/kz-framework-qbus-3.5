----------------------------------------------------------------------------------------------------------------------------
local CoreName = nil
local ESX = nil

if Config['General']["Core"] == "QBCORE" then
    if Config['CoreSettings']["QBCORE"]["Version"] == "new" then
        CoreName = Config['CoreSettings']["QBCORE"]["Export"]
    else
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(10)
                if CoreName == nil then
                    TriggerEvent(Config['CoreSettings']["QBCORE"]["Trigger"], function(obj) CoreName = obj end)
                    Citizen.Wait(200)
                end
            end
        end)
    end
elseif Config['General']["Core"] == "ESX" then
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent(Config['CoreSettings']["ESX"]["Trigger"], function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end)
end
----------------------------------------------------------------------------------------------------------------------------

BNEBoosting = {}


BNEBoosting['functions'] = {
    GetCurrentBNE = function()
        if Config['General']["Core"] == "QBCORE" then
            CoreName.Functions.TriggerCallback('boosting:getCurrentBNE', function(amount)
                value =  amount.BNE
                background =  amount.background
            end)
            Wait(200)
            return ({bne = value ,back =  background})
        elseif Config['General']["Core"] == "ESX" then
            ESX.TriggerServerCallback('boosting:getCurrentBNE', function(amount)
                value =  amount.BNE
                background =  amount.background
            end)
            Wait(200)
            return ({bne = value ,back =  background})
        elseif Config['General']["Core"] == "NPBASE" then
            local amount = RPC.execute("boosting:getCurrentBNE")
            if amount ~= nil then
                value =  amount.BNE
                background =  amount.background
                Wait(200)
                return ({bne = value ,back =  background})
            end
        end
    end,
    RemoveBNE = function(amount)
        if Config['General']["Core"] == "QBCORE" then
            CoreName.Functions.TriggerCallback('boosting:removeBNE', function(amount) 
                end , amount)
                Wait(200)
            return true
        elseif Config['General']["Core"] == "ESX" then
            ESX.TriggerServerCallback('boosting:removeBNE', function(amount)
                end , amount)
                Wait(200)
            return true
        elseif Config['General']["Core"] == "NPBASE" then
            RPC.execute("boosting:removeBNE",amount)
                Wait(200)
            return true
        end
    end,
    SetBackground = function(backgroundurl)
        TriggerServerEvent("boosting:server:setBacgkround" , backgroundurl)
    end,

    AddBne = function(amount)
        if Config['General']["Core"] == "QBCORE" then
            CoreName.Functions.TriggerCallback('boosting:addBne', function(amount)
                end , amount)
                Wait(200)
            return true
        elseif Config['General']["Core"] == "ESX" then
            ESX.TriggerServerCallback('boosting:addBne', function(amount)
                Wait(200)
                return true
            end , amount)
        elseif Config['General']["Core"] == "NPBASE" then
            RPC.execute("boosting:addBne",amount)
                Wait(200)
            return true
        end
    end,
}