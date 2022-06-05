Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

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

-- Code

local CurrentPings = {}

RegisterNetEvent('rl-pings:client:DoPing')
AddEventHandler('rl-pings:client:DoPing', function(id)
    local player = GetPlayerFromServerId(id)
    local ped = GetPlayerPed(player)
    local pos = GetEntityCoords(ped)
    local coords = {
        x = pos.x,
        y = pos.y,
        z = pos.z,
    }
    if not exports['rl-police']:IsHandcuffed() then
        TriggerServerEvent('rl-pings:server:SendPing', id, coords)
        TriggerEvent("debug", 'Pings: Send Ping', 'success')
    else
        RLCore.Functions.Notify('You cannot currently send pings.', 'error')
        TriggerEvent("debug", 'Pings: Handcuffed', 'error')
    end
end)

RegisterNetEvent('rl-pings:client:AcceptPing')
AddEventHandler('rl-pings:client:AcceptPing', function(PingData, SenderData)
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)

    if not exports['rl-police']:IsHandcuffed() then
        TriggerServerEvent('rl-pings:server:SendLocation', PingData, SenderData)
        TriggerEvent("debug", 'Pings: Send Location', 'success')
    else
        RLCore.Functions.Notify('You cannot currently accept the ping.', 'error')
        TriggerEvent("debug", 'Pings: Handcuffed', 'error')
    end
end)

RegisterNetEvent('rl-pings:client:SendLocation')
AddEventHandler('rl-pings:client:SendLocation', function(PingData, SenderData)
    RLCore.Functions.Notify('The location is indicated on your map with a blip.', 'success')

    CurrentPings[PingData.sender] = AddBlipForCoord(PingData.coords.x, PingData.coords.y, PingData.coords.z)
    SetBlipSprite(CurrentPings[PingData.sender], 280)
    SetBlipDisplay(CurrentPings[PingData.sender], 4)
    SetBlipScale(CurrentPings[PingData.sender], 1.1)
    SetBlipAsShortRange(CurrentPings[PingData.sender], false)
    SetBlipColour(CurrentPings[PingData.sender], 0)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Friend")
    EndTextCommandSetBlipName(CurrentPings[PingData.sender])

    SetTimeout(5 * (60 * 1000), function()
        RLCore.Functions.Notify('Ping '..PingData.sender..' has expired..', 'error')
        RemoveBlip(CurrentPings[PingData.sender])
        CurrentPings[PingData.sender] = nil
    end)
end)