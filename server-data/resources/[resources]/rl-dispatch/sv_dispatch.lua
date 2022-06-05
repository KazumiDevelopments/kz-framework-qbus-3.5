RLCore = nil

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RLCore.Commands.Add("dispatch", "Emergency Dispatch Control.", {{name="type", help="ON/OFF/MUTE"}}, true, function(source, args)
    TriggerClientEvent("dispatch:toggleNotifications", source, args[1])
end)

local DispatchMessages = {
    ['10-50'] = { ['label'] = 'Car crash reported', ['reporter'] = true, ['police'] = true, ['ambulance'] = false, ['priority'] = 3, ['blipSprite'] = 380, ['blipColor'] = 4 }, -- Officer Car Crash
    ['10-10'] = { ['label'] = 'Fight in progress', ['reporter'] = false, ['police'] = false, ['ambulance'] = false, ['blipSprite'] = 311, ['blipColor'] = 4 }, -- Fight
    ['10-11'] = { ['label'] = 'Deadly armed fight in a progress', ['reporter'] = true, ['police'] = true, ['ambulance'] = false, ['blipSprite'] = 313, ['blipColor'] = 4 }, -- Armed Fight
    ['10-31A'] = { ['label'] = 'House Robbery in action', ['reporter'] = true, ['police'] = true, ['ambulance'] = false, ['blipSprite'] = 418, ['blipColor'] = 4 }, -- House Robbery
    ['10-40A'] = { ['label'] = 'Store Robbery in action', ['reporter'] = false, ['police'] = true, ['ambulance'] = false, ['blipSprite'] = 156, ['blipColor'] = 4 }, -- Store Robbery
    ['10-90'] = { ['label'] = 'Robbery of a bank truck in progress', ['reporter'] = true, ['police'] = true, ['ambulance'] = false, ['important'] = true, ['blipSprite'] = 67, ['blipColor'] = 2 }, -- Bank Truck Robbery
    ['10-32B'] = { ['label'] = 'Robbery at the Jewelry Store', ['reporter'] = true, ['police'] = true, ['ambulance'] = false, ['important'] = true, ['blipSprite'] = 439, ['blipColor'] = 3 }, -- Jewelry Robbery
	['10-32A'] = { ['label'] = 'Robbery at the Fleeca Bank', ['reporter'] = true, ['police'] = true, ['ambulance'] = false, ['important'] = true, ['blipSprite'] = 88, ['blipColor'] = 2 }, -- Fleeca Bank Robbery
    ['10-33A'] = { ['label'] = 'Robbery at the Paleto Bank', ['reporter'] = true, ['police'] = true, ['ambulance'] = false, ['important'] = true, ['blipSprite'] = 267, ['blipColor'] = 2 }, -- Paleto Bank Robbery
	['10-35A'] = { ['label'] = 'Robbery at the Pacific Bank', ['reporter'] = true, ['police'] = true, ['ambulance'] = false, ['important'] = true, ['blipSprite'] = 267, ['blipColor'] = 2}, -- Pacific Bank Robbery
	['10-99'] = { ['label'] = 'Prison break attempt in progress', ['reporter'] = true, ['police'] = true, ['ambulance'] = false, ['important'] = true, ['blipSprite'] = 188, ['blipColor'] = 17 }, -- Prison Break
    ['10-30B'] = { ['label'] = 'Power station disturbance in action', ['reporter'] = true, ['police'] = true, ['ambulance'] = false, ['important'] = true, ['blipSprite'] = 354, ['blipColor'] = 5 }, -- Power Station Disturbance
    ['10-31B'] = { ['label'] = 'Robbery at gunpoint', ['reporter'] = false, ['police'] = true, ['ambulance'] = false, ['blipSprite'] = 362, ['blipColor'] = 4 }, -- NPC Robbery
    ['10-29B'] = { ['label'] = 'Drug Trafficking possibly ongoing', ['reporter'] = false, ['police'] = true, ['ambulance'] = false, ['blipSprite'] = 501, ['blipColor'] = 4 }, -- Drug Trafficking
    ['10-55B'] = { ['label'] = 'Illegal driving activity ongoing', ['reporter'] = false, ['police'] = true, ['ambulance'] = false, ['blipSprite'] = 355, ['blipColor'] = 4 }, -- Illegal Diving
    ['10-71A'] = { ['label'] = 'Gun shots reported', ['reporter'] = false, ['police'] = true, ['ambulance'] = false, ['blipSprite'] = 119, ['blipColor'] = 1 }, -- Gun Shots
    ['10-71B'] = { ['label'] = 'Gun shots reported from a vehicle',['reporter'] = false, ['police'] = true, ['ambulance'] = false, ['blipSprite'] = 229, ['blipColor'] = 1 }, -- Gun Shots From Vehicle
    ['10-60'] = { ['label'] = 'Carjacking in progress',['reporter'] = false, ['police'] = true, ['ambulance'] = false, ['blipSprite'] = 225, ['blipColor'] = 4 }, -- Lockpick
    ['10-47'] = { ['label'] = 'Injured person',['reporter'] = true, ['police'] = true, ['ambulance'] = true, ['blipSprite'] = 303, ['blipColor'] = 4 }, -- Death
    ['10-13A'] = { ['label'] = 'Officer down URGENT',['reporter'] = false, ['police'] = true, ['ambulance'] = true, ['important'] = true, ['priority'] = 3, ['sound'] = '10-1314', ['blipSprite'] = 621, ['blipColor'] = 38 }, -- Officer Down
    ['10-13B'] = { ['label'] = 'Officer down NOT URGENT',['reporter'] = false, ['police'] = true, ['ambulance'] = true, ['important'] = false, ['priority'] = 3, ['sound'] = '10-1314', ['blipSprite'] = 621, ['blipColor'] = 38 }, -- Officer Down
    ['10-14A'] = { ['label'] = 'EMS down URGENT',['reporter'] = false, ['police'] = true, ['ambulance'] = true, ['important'] = true, ['priority'] = 3, ['sound'] = '10-1314', ['blipSprite'] = 621, ['blipColor'] = 1 }, -- EMS Down
    ['10-14B'] = { ['label'] = 'EMS down NOT URGENT',['reporter'] = false, ['police'] = true, ['ambulance'] = true, ['important'] = false, ['priority'] = 3, ['sound'] = '10-1314', ['blipSprite'] = 621, ['blipColor'] = 1 }, -- EMS Down
    
    
}

RegisterServerEvent("dispatch:svNotify")
AddEventHandler("dispatch:svNotify", function(data, msg)
    data.source = -1
    data.recipientList = {}

    if DispatchMessages[data.dispatchCode] then

        local message = DispatchMessages[data.dispatchCode]

        if not msg and message['label'] then
            data.dispatchMessage = message['label']
        elseif msg then
            data.dispatchMessage = msg
        else
            data.dispatchMessage = 'None'
        end

        if message['priority'] then
            data.priority = message['priority']
        else
            data.priority = 1
        end

        if message['sound'] then
            data.playSound = true
            data.soundName = message['sound']
        else
            data.playSound = false
        end

        if message['important'] then
            data.isImportant = message['important']
        else
            data.isImportant = false
        end

        if message['callSign'] then
            data.callSign = message['callSign']
        end

        if message['blipColor'] then
            data.blipColor = message['blipColor']
        end

        if message['blipSprite'] then
            data.blipSprite = message['blipSprite']
        end

        if message['police'] ~= nil then
            data.recipientList['police'] = message['police']
        else
            data.recipientList['police'] = true
        end

        if message['ambulance'] ~= nil then
            data.recipientList['ambulance'] = message['ambulance']
        else
            data.recipientList['ambulance'] = true
        end

        if message['reporter'] ~= nil then
            data.recipientList['reporter'] = message['reporter']
        else
            data.recipientList['reporter'] = false
        end

        if message['source'] ~= nil then
            data['source'] = message['source']
        end
    end

    TriggerClientEvent("dispatch:clNotify", data['source'], data)
end)

RegisterServerEvent('police:camera')
AddEventHandler('police:camera', function(id)
    TriggerClientEvent('police:camera', -1, id)
end)