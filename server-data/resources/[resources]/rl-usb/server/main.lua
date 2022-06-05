RLCore = nil

local PlayerHackTimer = {}
local PlayerDrugsTimer = {}
local PlayerConvertTimer = {}

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent("Drugs:startHackTimer")
AddEventHandler("Drugs:startHackTimer",function(source)
    table.insert(PlayerHackTimer,{started = GetPlayerIdentifier(source), time = 3600000}) -- cooldown timer for using USB stick
end)

RegisterServerEvent("Drugs:startDrugsTimer") 
AddEventHandler("Drugs:startDrugsTimer",function(source)
    table.insert(PlayerDrugsTimer,{startedDrugs = GetPlayerIdentifier(source), timeDrugs = 30000}) -- do not touch this
end)

RegisterServerEvent("Drugs:startConvertTimer")
AddEventHandler("Drugs:startConvertTimer",function(source)
    table.insert(PlayerConvertTimer,{startedConvert = GetPlayerIdentifier(source), timeConvert = 5000}) -- do not touch this
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1000)
        for k,v in pairs(PlayerHackTimer) do
            if v.time <= 0 then
                RemoveStarted(v.started)
            else
                v.time = v.time - 1000
            end
        end
        for k,v in pairs(PlayerDrugsTimer) do
            if v.timeDrugs <= 0 then
                RemoveStartedDrugs(v.startedDrugs)
            else
                v.timeDrugs = v.timeDrugs - 1000
            end
        end
        for k,v in pairs(PlayerConvertTimer) do
            if v.timeConvert <= 0 then
                RemoveStartedConvert(v.startedConvert)
            else
                v.timeConvert = v.timeConvert - 1000
            end
        end
    end
end)

-- // ## DRUGS MISSIONS ## // --

RegisterServerEvent("Drugs:reward")
AddEventHandler("Drugs:reward",function(items)
    local xPlayer = RLCore.Functions.GetPlayer(source)
    for k,v in pairs(items) do
        xPlayer.Functions.AddItem(k,math.ceil(v))
    end
end)

RegisterServerEvent("Drugs:syncMissionData")
AddEventHandler("Drugs:syncMissionData",function(data)
    TriggerClientEvent("Drugs:syncMissionData",-1,data)
end)

RLCore.Functions.CreateUseableItem('methburn', function(source, item)
    if not CheckedStarted(GetPlayerIdentifier(source)) then
        local xPlayer = RLCore.Functions.GetPlayer(source)
        xPlayer.Functions.RemoveItem('methburn', 1)
        TriggerEvent("Drugs:startHackTimer",source)
        TriggerEvent('bb-logs:server:createLog', 'usb', 'Meth USB Used', "", source)
        TriggerClientEvent("Drugs:UsableItem",source)
        Citizen.Wait(8000)
        TriggerClientEvent("Drugs:HackingMiniGame",source)
        RLCore.Functions.CreateCallback("Drugs:StartMissionNow",function(source,cb)
            
            TriggerClientEvent("Drugs:startMission",source,"meth")
            cb()
        end)
        
    else
        TriggerClientEvent("RLCore:Notify",source,string.format("You can hack the network again in: %s minutes",GetTimeForMission(GetPlayerIdentifier(source))), 'error')
    end
end)

RLCore.Functions.CreateUseableItem('cokeburn', function(source, item)
    if not CheckedStarted(GetPlayerIdentifier(source)) then
        local xPlayer = RLCore.Functions.GetPlayer(source)
        xPlayer.Functions.RemoveItem('cokeburn', 1)
        TriggerEvent("Drugs:startHackTimer",source)
        TriggerEvent('bb-logs:server:createLog', 'usb', 'Coke USB Used', "", source)
        TriggerClientEvent("Drugs:UsableItem",source)
        Citizen.Wait(8000)
        TriggerClientEvent("Drugs:HackingMiniGame",source)
        
        RLCore.Functions.CreateCallback("Drugs:StartMissionNow",function(source,cb)
            TriggerClientEvent("Drugs:startMission",source,"coke")
            cb()
        end)

    else
        TriggerClientEvent("RLCore:Notify",source,string.format("You can hack the network again in: %s minutes",GetTimeForMission(GetPlayerIdentifier(source))), 'error')
    end
end)

RLCore.Functions.CreateUseableItem('weedburn', function(source, item)
    if not CheckedStarted(GetPlayerIdentifier(source)) then
        local xPlayer = RLCore.Functions.GetPlayer(source)
        xPlayer.Functions.RemoveItem('weedburn', 1)
        TriggerEvent("Drugs:startHackTimer",source)
        TriggerEvent('bb-logs:server:createLog', 'usb', 'Weed USB Used', "", source)
        TriggerClientEvent("Drugs:UsableItem",source)
        Citizen.Wait(8000)
        TriggerClientEvent("Drugs:HackingMiniGame",source)
        
        RLCore.Functions.CreateCallback("Drugs:StartMissionNow",function(source,cb)
            TriggerClientEvent("Drugs:startMission",source,"weed")
            cb()
        end)
    
    else
        TriggerClientEvent("RLCore:Notify",source,string.format("You can hack the network again in: %s minutes",GetTimeForMission(GetPlayerIdentifier(source))), 'error')
    end
end)

RLCore.Functions.CreateUseableItem('goldenburn', function(source, item)
    if not CheckedStarted(GetPlayerIdentifier(source)) then
        local xPlayer = RLCore.Functions.GetPlayer(source)
        xPlayer.Functions.RemoveItem('goldenburn', 1)
        TriggerEvent("Drugs:startHackTimer", source)
        local selected = string.gsub(Config.Items.items[math.random(1, 3)].name, "burn", "")
        TriggerEvent('bb-logs:server:createLog', 'usb', 'Golden USB Used', "**[Random Type]** " .. selected, source)
        TriggerClientEvent("Drugs:UsableItem", source)
        Citizen.Wait(8000)
        TriggerClientEvent("Drugs:HackingMiniGame",source)
        
        RLCore.Functions.CreateCallback("Drugs:StartMissionNow",function(source,cb)
            TriggerClientEvent("Drugs:startMission",source, selected)
            cb()
        end)
    
    else
        TriggerClientEvent("RLCore:Notify",source,string.format("You can hack the network again in: %s minutes",GetTimeForMission(GetPlayerIdentifier(source))), 'error')
    end
end)

-- // ## DRUGS CONVERSION ## // --

-- COKE BRICK >> COKE (10G)
RLCore.Functions.CreateUseableItem('cokebrick', function(source, item)
        
    local xPlayer = RLCore.Functions.GetPlayer(source)
    local brick = GetItem(source, "cokebrick").count >= 1
    local scale = GetItem(source, "hqscale").count >= 1
    local bags = GetItem(source, "empty_weed_bag").count >= 10
    
    if not bags or not brick then
        if not bags then
            TriggerClientEvent("RLCore:Notify",source,"You do not have enough bags", 'error')
        else
            TriggerClientEvent("RLCore:Notify",source,"You do not have enough Cocaine Bricks", 'error')
        end
        return
    end
    
    local maxCokeOutput = 10
        
    if not scale then
        maxCokeOutput = 6
    end

    if GetItem(source, "coke10g").count <= 40 or (not scale and GetItem(source, "coke10g").count <= 44) then
        if not CheckedStartedConvert(GetPlayerIdentifier(source)) then
            TriggerEvent("Drugs:startConvertTimer",source)
                    
            xPlayer.Functions.RemoveItem("cokebrick",1)
            xPlayer.Functions.RemoveItem("empty_weed_bag",10)
        
            TriggerClientEvent("BrickToCoke10g",source)
            Citizen.Wait(15000)
        
            xPlayer.Functions.AddItem("coke10g",maxCokeOutput)
        else
            TriggerClientEvent("RLCore:Notify",source,string.format("You are already engaged in a process!",GetTimeForConvert(GetPlayerIdentifier(source))), 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify",source,"You do not have enough empty space for more Cocaine (10G)", 'error')
    end
end)

-- METH BRICK >> METH (10G)
RLCore.Functions.CreateUseableItem('methbrick', function(source, item)
        
    local xPlayer = RLCore.Functions.GetPlayer(source)
    local brick = GetItem(source, "methbrick").count >= 1
    local scale = GetItem(source, "hqscale").count >= 1
    local bags = GetItem(source, "empty_weed_bag").count >= 10
    
    if not bags or not brick then
        if not bags then
            TriggerClientEvent("RLCore:Notify",source,"You do not have enough bags", 'error')
        else
            TriggerClientEvent("RLCore:Notify",source,"You do not have enough Meth Bricks", 'error')
        end
        return
    end
    
    local maxMethOutput = 10
        
    if not scale then
        maxMethOutput = 6
    end
    
    if GetItem(source, "meth10g").count <= 40 or (not scale and GetItem(source, "meth10g").count <= 44) then
        if not CheckedStartedConvert(GetPlayerIdentifier(source)) then
            TriggerEvent("Drugs:startConvertTimer",source)
        
            xPlayer.Functions.RemoveItem("methbrick",1)
            xPlayer.Functions.RemoveItem("empty_weed_bag",10)
        
            TriggerClientEvent("BrickToMeth10g",source)
            Citizen.Wait(15000)
        
            xPlayer.Functions.AddItem("meth10g",maxMethOutput)
        else
            TriggerClientEvent("RLCore:Notify",source,string.format("You are already engaged in a process!",GetTimeForConvert(GetPlayerIdentifier(source))))
        end
    else
        TriggerClientEvent("RLCore:Notify",source,"You do not have enough empty space for more Meth (10G)", 'error')
    end
end)

-- COKE (10G) >> COKE (1G)
RLCore.Functions.CreateUseableItem('coke10g', function(source, item)
        
    local xPlayer = RLCore.Functions.GetPlayer(source)
    local coke = GetItem(source, "coke10g").count >= 1
    local scale = GetItem(source, "hqscale").count >= 1
    local bags = GetItem(source, "empty_weed_bag").count >= 10
    
    if not bags or not coke then
        if not bags then
            TriggerClientEvent("RLCore:Notify",source,"You do not have enough bags", 'error')
        else
            TriggerClientEvent("RLCore:Notify",source,"You do not have enough Cocaine (10G)", 'error')
        end
        return
    end
    
    local maxCoke1gOutput = 10
        
    if not scale then
        maxCoke1gOutput = 6
    end
    
    if GetItem(source, "cokebaggy").count <= 40 or (not scale and GetItem(source, "cokebaggy").count <= 44) then
        if not CheckedStartedConvert(GetPlayerIdentifier(source)) then
            TriggerEvent("Drugs:startConvertTimer",source)
        
            xPlayer.Functions.RemoveItem("coke10g",1)
            xPlayer.Functions.RemoveItem("empty_weed_bag",10)
        
            TriggerClientEvent("Coke10gToCoke1g",source)
        
            xPlayer.Functions.AddItem("cokebaggy",maxCoke1gOutput)
        else
            TriggerClientEvent("RLCore:Notify",source,string.format("You are already engaged in a process!",GetTimeForConvert(GetPlayerIdentifier(source))), 'error')
        end
    else
        TriggerClientEvent("RLCore:Notify",source,"You do not have enough empty space for more Cocaine (1G)", 'error')
    end
end)

-- METH (10G) >> METH (1G)
RLCore.Functions.CreateUseableItem('meth10g', function(source, item)
        
    local xPlayer = RLCore.Functions.GetPlayer(source)
    local meth = GetItem(source, "meth10g").count >= 1
    local scale = GetItem(source, "hqscale").count >= 1
    local bags = GetItem(source, "empty_weed_bag").count >= 10
    
    if not bags or not meth then
        if not bags then
            TriggerClientEvent("RLCore:Notify",source,"You do not have enough bags", 'error')
        else
            TriggerClientEvent("RLCore:Notify",source,"You do not have enough Meth (10G)", 'error')
        end
        return
    end
    
    local maxMeth1gOutput = 10
        
    if not scale then
        maxMeth1gOutput = 6
    end
    
    if GetItem(source, "crack_baggy").count <= 40 or (not scale and GetItem(source, "crack_baggy").count <= 44) then
        if not CheckedStartedConvert(GetPlayerIdentifier(source)) then
            TriggerEvent("Drugs:startConvertTimer",source)
        
            xPlayer.Functions.RemoveItem("meth10g",1)
            xPlayer.Functions.RemoveItem("empty_weed_bag",10)
        
            TriggerClientEvent("Meth10gToMeth1g",source)
        
            xPlayer.Functions.AddItem("crack_baggy",maxMeth1gOutput)
        else
            TriggerClientEvent("RLCore:Notify",source,string.format("You are already engaged in a process!",GetTimeForConvert(GetPlayerIdentifier(source))))
        end
    else
        TriggerClientEvent("RLCore:Notify",source,"You do not have enough empty space for more Meth (1G)", 'error')
    end
end)

-- WEED (4G) >> JOINT (2G)
RLCore.Functions.CreateUseableItem('weed4g', function(source, item)
        
    local xPlayer = RLCore.Functions.GetPlayer(source)
    local weed = GetItem(source, "weed4g").count >= 1
    local paper = GetItem(source, "rolling_paper").count >= 2
    
    if not paper or not weed then
        if not paper then
            TriggerClientEvent("RLCore:Notify",source,"You do not have enough rolling paper", 'error')
        else
            TriggerClientEvent("RLCore:Notify",source,"You do not have enough Weed (4G)", 'error')
        end
        return
    end
    
    if GetItem(source, "joint").count <= 48 then
        if not CheckedStartedConvert(GetPlayerIdentifier(source)) then
            TriggerEvent("Drugs:startConvertTimer",source)
        
            xPlayer.Functions.RemoveItem("weed4g",1)
            xPlayer.Functions.RemoveItem("rolling_paper",2)
        
            TriggerClientEvent("Weed4gToJoint2g",source)
        
            xPlayer.Functions.AddItem("joint",2)
        else
            TriggerClientEvent("RLCore:Notify",source,string.format("You are already engaged in a process!",GetTimeForConvert(GetPlayerIdentifier(source))))
        end
    else
        TriggerClientEvent("RLCore:Notify",source,"You do not have enough empty space for more Joint (2G)", 'error')
    end
end)

-- // ## TIMERS ## // --

-- DO NOT TOUCH!!
function RemoveStarted(source)
    for k,v in pairs(PlayerHackTimer) do
        if v.started == source then
            table.remove(PlayerHackTimer,k)
        end
    end
end
-- DO NOT TOUCH!!
function GetTimeForMission(source)
    for k,v in pairs(PlayerHackTimer) do
        if v.started == source then
            return math.ceil(v.time/60000)
        end
    end
end
-- DO NOT TOUCH!!
function CheckedStarted(source)
    for k,v in pairs(PlayerHackTimer) do
        if v.started == source then
            return true
        end
    end
    return false
end

-- USABLE DRUGS EFFECTS TIMER
-- DO NOT TOUCH!!
-- // ## TIMERS ## // --

-- DO NOT TOUCH!!
function RemoveStarted(source)
    for k,v in pairs(PlayerHackTimer) do
        if v.started == source then
            table.remove(PlayerHackTimer,k)
        end
    end
end
-- DO NOT TOUCH!!
function GetTimeForMission(source)
    for k,v in pairs(PlayerHackTimer) do
        if v.started == source then
            return math.ceil(v.time/60000)
        end
    end
end
-- DO NOT TOUCH!!
function CheckedStarted(source)
    for k,v in pairs(PlayerHackTimer) do
        if v.started == source then
            return true
        end
    end
    return false
end

-- USABLE DRUGS EFFECTS TIMER
-- DO NOT TOUCH!!
function RemoveStartedDrugs(source)
    for k,v in pairs(PlayerDrugsTimer) do
        if v.startedDrugs == source then
            table.remove(PlayerDrugsTimer,k)
        end
    end
end
-- DO NOT TOUCH!!
function GetTimeForDrugs(source)
    for k,v in pairs(PlayerDrugsTimer) do
        if v.startedDrugs == source then
            return math.ceil(v.timeDrugs/1000)
        end
    end
end
-- DO NOT TOUCH!!
function CheckedStartedDrugs(source)
    for k,v in pairs(PlayerDrugsTimer) do
        if v.startedDrugs == source then
            return true
        end
    end
    return false
end
-- DO NOT TOUCH!!
function RemoveStartedConvert(source)
    for k,v in pairs(PlayerConvertTimer) do
        if v.startedConvert == source then
            table.remove(PlayerConvertTimer,k)
        end
    end
end
-- DO NOT TOUCH!!
function GetTimeForConvert(source)
    for k,v in pairs(PlayerConvertTimer) do
        if v.startedConvert == source then
            return math.ceil(v.timeConvert/10)
        end
    end
end
-- DO NOT TOUCH!!
function CheckedStartedConvert(source)
    for k,v in pairs(PlayerConvertTimer) do
        if v.startedConvert == source then
            return true
        end
    end
    return false
end

function GetItem(source, item)
    local xPlayer = RLCore.Functions.GetPlayer(source)
    local count = 0

    for k,v in pairs(xPlayer['PlayerData']['items']) do
        if v.name == item then
            count = count + v.amount
        end
    end
    
    return { name = item, count = count }
end