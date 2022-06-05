local headerShown = false

local function openMenu(data)
    if not data then return end
    SetNuiFocus(true, true)
    headerShown = false
    SendNUIMessage({
        action = 'OPEN_MENU',
        data = data
    })
end

local function closeMenu()
    headerShown = false
    SetNuiFocus(false)
    SendNUIMessage({
        action = 'CLOSE_MENU'
    })
end

local function showHeader(data)
    headerShown = true
    SendNUIMessage({
        action = 'SHOW_HEADER',
        data = data
    })
end

RegisterNetEvent('context-menu:client:openMenu', function(data)
    openMenu(data)
end)

RegisterNetEvent('context-menu:client:closeMenu', function()
    closeMenu()
end)

RegisterNUICallback('clickedButton', function(data)
    if headerShown then headerShown = false end
    PlaySoundFrontend(-1, 'Highlight_Cancel','DLC_HEIST_PLANNING_BOARD_SOUNDS', 1)
    SetNuiFocus(false)
    if data.isServer then
        TriggerServerEvent(data.event, data.args)
    else
        TriggerEvent(data.event, data.args)
    end
end)

RegisterNUICallback('closeMenu', function()
    headerShown = false
    SetNuiFocus(false)
end)

RegisterCommand('+playerfocus', function()
    if headerShown then
        SetNuiFocus(true, true)
    end
end)

RegisterKeyMapping('+playerFocus', 'Give Menu Focus', 'keyboard', 'LMENU')

exports('openMenu', openMenu)
exports('closeMenu', closeMenu)
exports('showHeader', showHeader)
exports('clearHistory', clearHistory)