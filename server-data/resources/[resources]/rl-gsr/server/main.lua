RLCore = nil
gsrData = {}

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RLCore.Commands.Add("gsr", "Do GSR Test ", {{name ="id ", help="Player ID"}}, true, function(source, args)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    local number = tonumber(args[1])
    if args[1] ~= nil then 
		if xPlayer.PlayerData.job.name == "police" and Player.PlayerData.job.onduty and type(number) == "number" then
        	CancelEvent()
        	local identifier = GetPlayerIdentifiers(number)[1]
        	if identifier ~= nil then
            	gsrcheck(source, identifier)
        	end
    	else
            TriggerClientEvent("RLCore:Notify", src, "You must be a cop to use the Gun Powder test", "error", 5000)
    	end
	else
        TriggerClientEvent("RLCore:Notify", src, "Correct Usage Is: /gsr (player id)", "error", 5000)
	end
end)

RegisterNetEvent("GSR_Server:PerformTest")
AddEventHandler("GSR_Server:PerformTest", function(targetId)
    local src = source
    local xPlayer = RLCore.Functions.GetPlayer(src)
    if xPlayer.PlayerData.job.name == "police" and xPlayer.PlayerData.job.onduty then
        local identifier = GetPlayerIdentifiers(targetId)[1]
        if identifier ~= nil then
            gsrcheck(source, identifier)
        end
    end
end)

AddEventHandler("RLCore:Client:OnPlayerUnload", function(source)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    if gsrData[identifier] ~= nil then
        gsrData[identifier] = nil
    end
end)

RegisterNetEvent("GSR_Server:Remove")
AddEventHandler("GSR_Server:Remove", function()
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    if gsrData[identifier] ~= nil then
        gsrData[identifier] = nil
    end
end)

RegisterServerEvent("GSR_Server:SetGSR")
AddEventHandler("GSR_Server:SetGSR", function()
    --print("SET MA GSR BITCHHHHHH")
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    gsrData[identifier] = os.time(os.date("!*t")) + Config.gsrTime
    --print("GSR TINGS", json.encode(gsrData[identifier]))
end)



function gsrcheck(source, identifier)
    local src = source
    local identifier = identifier
    local Player = RLCore.Functions.GetPlayer(identifier)
    local nameData = Player.PlayerData.charinfo
	Wait(100)
    local fullName = string.format("%s %s", nameData.firstname, nameData.lastname)
    if gsrData[identifier] ~= nil then
        TriggerClientEvent("RLCore:Notify", src, "Test for "..fullName.." comes back POSITIVE (Has Shot)", "success", 8000)
    else
        TriggerClientEvent("RLCore:Notify", src, "Test for "..fullName.." comes back NEGATIVE (Has Not Shot)", "error", 8000)
    end
end

RLCore.Functions.CreateCallback("GSR_Server:Status", function(source, cb)
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    if gsrData[identifier] ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

function removeGSR()
    for k, v in pairs(gsrData) do
        if v <= os.time(os.date("!*t")) then
            gsrData[k] = nil
        end
    end
end

function gsrTimer()
    removeGSR()
    SetTimeout(Config.gsrAutoRemove, gsrTimer)
end

gsrTimer()
