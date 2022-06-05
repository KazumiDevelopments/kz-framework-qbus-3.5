local RLCore = exports['rl-core']:GetCoreObject()
local CurrentWeather = Config.StartWeather
local baseTime = Config.BaseTime
local timeOffset = Config.TimeOffset
local freezeTime = Config.FreezeTime
local blackout = Config.Blackout
local newWeatherTimer = Config.NewWeatherTimer

--- Is the source a client or the server
--- @param src string | number - source to check
--- @return int - source
local function getSource(src)
    if src == '' then
        return 0 
    end
    return src
end

--- Does source have permissions to run admin commands
--- @param src number - Source to check
--- @return boolean - has permission
local function isAllowedToChange(src)
    if src == 0 or RLCore.Functions.HasPermission(src, "admin") or IsPlayerAceAllowed(src, 'command') then
        return true
    end
    return false
end

--- Sets time offset based on minutes provided
--- @param minute number - Minutes to offset by
local function shiftToMinute(minute)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

--- Sets time offset based on hour provided
--- @param hour number - Hour to offset by
local function shiftToHour(hour)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end

--- Triggers event to switch weather to next stage
local function nextWeatherStage()
    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY"  then
        CurrentWeather = (math.random(1,5) > 2) and "CLEARING" or "OVERCAST" -- 60/40 chance
    elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
        local new = math.random(1,6)
        if new == 1 then CurrentWeather = (CurrentWeather == "CLEARING") and "FOGGY" or "RAIN"
        elseif new == 2 then CurrentWeather = "CLOUDS"
        elseif new == 3 then CurrentWeather = "CLEAR"
        elseif new == 4 then CurrentWeather = "EXTRASUNNY"
        elseif new == 5 then CurrentWeather = "SMOG"
        else CurrentWeather = "FOGGY"
        end
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then CurrentWeather = "CLEARING"
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then CurrentWeather = "CLEAR"
    else CurrentWeather = "CLEAR"
    end
    TriggerEvent("rl-weathersync:server:RequestStateSync")
end

--- Switch to a specified weather type
--- @param weather string - Weather type from Config.AvailableWeatherTypes
--- @return boolean - success
local function setWeather(weather)
    local validWeatherType = false
    for _,weatherType in pairs(Config.AvailableWeatherTypes) do
        if weatherType == string.upper(weather) then
            validWeatherType = true
        end
    end
    if not validWeatherType then return false end
    CurrentWeather = string.upper(weather)
    newWeatherTimer = Config.NewWeatherTimer
    TriggerEvent('rl-weathersync:server:RequestStateSync')
    return true
end

--- Sets sun position based on time to specified
--- @param hour number|string - Hour to set (0-24)
--- @param minute number|string `optional` - Minute to set (0-60)
--- @return boolean - success
local function setTime(hour, minute)
    local argh = tonumber(hour)
    local argm = tonumber(minute) or 0
    if argh == nil or argh > 24 then
        print(Lang:t('time.invalid'))
        return false
    end
    shiftToHour((argh < 24) and argh or 0)
    shiftToMinute((argm < 60) and argm or 0)
    print(Lang:t('time.change', {value = argh, value2 = argm}))
    TriggerEvent('rl-weathersync:server:RequestStateSync')
    return true
end

--- Sets or toggles blackout state and returns the state
--- @param state boolean `optional` - enable blackout?
--- @return boolean - blackout state
local function setBlackout(state)
    if state == nil then state = not blackout end
    if state then blackout = true
    else blackout = false end
    TriggerEvent('rl-weathersync:server:RequestStateSync')
    return blackout
end

--- Sets or toggles time freeze state and returns the state
--- @param state boolean `optional` - Enable time freeze?
--- @return boolean - Time freeze state
local function setTimeFreeze(state)
    if state == nil then state = not freezeTime end
    if state then freezeTime = true
    else freezeTime = false end
    TriggerEvent('rl-weathersync:server:RequestStateSync')
    return freezeTime
end

--- Sets or toggles dynamic weather state and returns the state
--- @param state boolean `optional` - Enable dynamic weather?
--- @return boolean - Dynamic Weather state
local function setDynamicWeather(state)
    if state == nil then state = not Config.DynamicWeather end
    if state then Config.DynamicWeather = true
    else Config.DynamicWeather = false end
    TriggerEvent('rl-weathersync:server:RequestStateSync')
    return Config.DynamicWeather
end

-- EVENTS

RegisterNetEvent('rl-weathersync:server:RequestStateSync', function()
    TriggerClientEvent('rl-weathersync:client:SyncWeather', -1, CurrentWeather, blackout)
    TriggerClientEvent('rl-weathersync:client:SyncTime', -1, baseTime, timeOffset, freezeTime)
end)

RegisterNetEvent('rl-weathersync:server:RequestCommands', function()
    local src = source
    if isAllowedToChange(src) then
        TriggerClientEvent('rl-weathersync:client:RequestCommands', src, true)
    end
end)

RegisterNetEvent('rl-weathersync:server:setWeather', function(weather)
    local src = getSource(source)
    if isAllowedToChange(src) then
        local success = setWeather(weather)
        if src > 0 then
            if (success) then TriggerClientEvent('RLCore:Notify', src, Lang:t('weather.updated'))
            else TriggerClientEvent('RLCore:Notify', src, Lang:t('weather.invalid'))
            end
        end
    end
end)

RegisterNetEvent('rl-weathersync:server:setTime', function(hour, minute)
    local src = getSource(source)
    if isAllowedToChange(src) then
        local success = setTime(hour, minute)
        if src > 0 then
            if (success) then TriggerClientEvent('RLCore:Notify', src, Lang:t('time.change', {value = hour, value2 = minute or "00"}))
            else TriggerClientEvent('RLCore:Notify', src, Lang:t('time.invalid'))
            end
        end
    end
end)

RegisterNetEvent('rl-weathersync:server:toggleBlackout', function(state)
    local src = getSource(source)
    if isAllowedToChange(src) then
        local newstate = setBlackout(state)
        if src > 0 then
            if (newstate) then TriggerClientEvent('RLCore:Notify', src, Lang:t('blackout.enabled'))
            else TriggerClientEvent('RLCore:Notify', src, Lang:t('blackout.disabled'))
            end
        end
    end
end)

RegisterNetEvent('rl-weathersync:server:toggleFreezeTime', function(state)
    local src = getSource(source)
    if isAllowedToChange(src) then
        local newstate = setTimeFreeze(state)
        if src > 0 then
            if (newstate) then TriggerClientEvent('RLCore:Notify', src, Lang:t('time.now_frozen'))
            else TriggerClientEvent('RLCore:Notify', src, Lang:t('time.now_unfrozen'))
            end
        end
    end
end)

RegisterNetEvent('rl-weathersync:server:toggleDynamicWeather', function(state)
    local src = getSource(source)
    if isAllowedToChange(src) then
        local newstate = setDynamicWeather(state)
        if src > 0 then
            if (newstate) then TriggerClientEvent('RLCore:Notify', src, Lang:t('weather.now_unfrozen'))
            else TriggerClientEvent('RLCore:Notify', src, Lang:t('weather.now_frozen'))
            end
        end
    end
end)

-- COMMANDS

RegisterCommand('freezetime', function(source, args, rawCommand)
    if isAllowedToChange(source) then
        local newstate = setTimeFreeze()
        if source > 0 then
            if (newstate) then return TriggerClientEvent('RLCore:Notify', source, Lang:t('time.frozenc')) end
            return TriggerClientEvent('RLCore:Notify', source, Lang:t('time.unfrozenc'))
        end
        if (newstate) then return print(Lang:t('time.now_frozen')) end
        return print(Lang:t('time.now_unfrozen'))
    end
    TriggerClientEvent('RLCore:Notify', source, Lang:t('error.not_allowed'), 'error')
end)

RegisterCommand('freezeweather', function(source, args, rawCommand)
    if isAllowedToChange(source) then
        local newstate = setDynamicWeather()
        if source > 0 then
            if (newstate) then return TriggerClientEvent('RLCore:Notify', source, Lang:t('dynamic_weather.enabled')) end
            return TriggerClientEvent('RLCore:Notify', source, Lang:t('dynamic_weather.disabled'))
        end
        if (newstate) then return print(Lang:t('weather.now_unfrozen')) end
        return print(Lang:t('weather.now_frozen'))
    end
    TriggerClientEvent('RLCore:Notify', source, Lang:t('error.not_allowed'), 'error')
end)

RegisterCommand('weather', function(source, args, rawCommand)
    if isAllowedToChange(source) then
        if args[1] == nil then
            if source > 0 then return TriggerClientEvent('RLCore:Notify', source, Lang:t('weather.invalid_syntaxc'), 'error') end
            return print(Lang:t('weather.invalid_syntax'))
        end
        local success = setWeather(args[1])
        if source > 0 then
            if (success) then return TriggerClientEvent('RLCore:Notify', source, Lang:t('weather.willchangeto', {value = string.lower(args[1])})) end
            return TriggerClientEvent('RLCore:Notify', source, Lang:t('weather.invalidc'), 'error')
        end
        if (success) then return print(Lang:t('weather.updated')) end
        return print(Lang:t('weather.invalid'))
    else
        TriggerClientEvent('RLCore:Notify', source, Lang:t('error.not_access'), 'error')
    end
end)

RegisterCommand('blackout', function(source, args, rawCommand)
    local src = source
    if isAllowedToChange(src) then
        local newstate = setBlackout()
        if src > 0 then
            if (newstate) then return TriggerClientEvent('RLCore:Notify', src, Lang:t('blackout.enabledc')) end
            return TriggerClientEvent('RLCore:Notify', src, Lang:t('blackout.disabledc'))
        end
        if (newstate) then return print(Lang:t('blackout.enabled')) end
        return print(Lang:t('blackout.disabled'))
    end
    TriggerClientEvent('RLCore:Notify', src, Lang:t('error.not_allowed'), 'error')
end)

RegisterCommand('morning', function(source, args, rawCommand)
    if isAllowedToChange(source) then
        setTime(9, 0)
        if source > 0 then return TriggerClientEvent('RLCore:Notify', source, Lang:t('time.morning')) end
    else
        TriggerClientEvent('RLCore:Notify', source, Lang:t('error.not_allowed'), 'error')
    end
end)

RegisterCommand('noon', function(source, args, rawCommand)
    if isAllowedToChange(source) then
        setTime(12, 0)
        if source > 0 then return TriggerClientEvent('RLCore:Notify', source, Lang:t('time.noon')) end
    else
        TriggerClientEvent('RLCore:Notify', source, Lang:t('error.not_allowed'), 'error')
    end
end)

RegisterCommand('evening', function(source, args, rawCommand)
    if isAllowedToChange(source) then
        setTime(18, 0)
        if source > 0 then return TriggerClientEvent('RLCore:Notify', source, Lang:t('time.evening')) end
    else
        TriggerClientEvent('RLCore:Notify', source, Lang:t('error.not_allowed'), 'error')
    end
end)

RegisterCommand('night', function(source, args, rawCommand)
    if isAllowedToChange(source) then
        setTime(23, 0)
        if source > 0 then return TriggerClientEvent('RLCore:Notify', source, Lang:t('time.night')) end
    else
        TriggerClientEvent('RLCore:Notify', source, Lang:t('error.not_allowed'), 'error')
    end
end)

RegisterCommand('time', function(source, args, rawCommand)
    if isAllowedToChange(source) then
        if args[1] == nil then
            if source > 0 then return TriggerClientEvent('RLCore:Notify', source, Lang:t('time.invalidc'), 'error') end
            return print(Lang:t('time.invalid'))
        end
        local success = setTime(args[1], args[2])
        if source > 0 then
            if (success) then return TriggerClientEvent('RLCore:Notify', source, Lang:t('time.changec', {value = args[1]..':'..(args[2] or "00")})) end
            return TriggerClientEvent('RLCore:Notify', source, Lang:t('time.invalidc'), 'error')
        end
        if (success) then return print(Lang:t('time.change', {value = args[1], value2 = args[2] or "00"})) end
        return print(Lang:t('time.invalid'))
    else
        TriggerClientEvent('RLCore:Notify', source, Lang:t('time.access'), 'error')
    end
end)

-- THREAD LOOPS

CreateThread(function()
    local previous = 0
    while true do
        Wait(0)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360         --Set the server time depending of OS time
        if (newBaseTime % 60) ~= previous then                      --Check if a new minute is passed
            previous = newBaseTime % 60                             --Only update time with plain minutes, seconds are handled in the client
            if freezeTime then
                timeOffset = timeOffset + baseTime - newBaseTime
            end
            baseTime = newBaseTime
        end
    end
end)

CreateThread(function()
    while true do
        Wait(2000)                                          --Change to send every minute in game sync
        TriggerClientEvent('rl-weathersync:client:SyncTime', -1, baseTime, timeOffset, freezeTime)
    end
end)

CreateThread(function()
    while true do
        Wait(300000)
        TriggerClientEvent('rl-weathersync:client:SyncWeather', -1, CurrentWeather, blackout)
    end
end)

CreateThread(function()
    while true do
        newWeatherTimer = newWeatherTimer - 1
        Wait((1000 * 60) * Config.NewWeatherTimer)
        if newWeatherTimer == 0 then
            if Config.DynamicWeather then
                nextWeatherStage()
            end
            newWeatherTimer = Config.NewWeatherTimer
        end
    end
end)

-- EXPORTS

exports('nextWeatherStage', nextWeatherStage)
exports('setWeather', setWeather)
exports('setTime', setTime)
exports('setBlackout', setBlackout)
exports('setTimeFreeze', setTimeFreeze)
exports('setDynamicWeather', setDynamicWeather)
exports('getBlackoutState', function() return blackout end)
exports('getTimeFreezeState', function() return freezeTime end)
exports('getWeatherState', function() return CurrentWeather end)
exports('getDynamicWeather', function() return Config.DynamicWeather end)

