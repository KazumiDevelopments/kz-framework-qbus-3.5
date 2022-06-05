local ST = ST or {}
ST.Scoreboard = {}
ST._Scoreboard = {}

ST.Scoreboard.Menu = {}

ST._Scoreboard.Players = {}
ST._Scoreboard.Recent = {}
ST._Scoreboard.SelectedPlayer = nil
ST._Scoreboard.MenuOpen = false
ST._Scoreboard.Menus = {}

local function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function ST.Scoreboard.AddPlayer(self, data)
    ST._Scoreboard.Players[data.src] = data
end

function ST.Scoreboard.RemovePlayer(self, data)
    ST._Scoreboard.Players[data.src] = nil
    ST._Scoreboard.Recent[data.src] = data
end

function ST.Scoreboard.RemoveRecent(self, src)
    ST._Scoreboard.Recent[src] = nil
end

function ST.Scoreboard.AddAllPlayers(self, data, recentData)
    ST._Scoreboard.Players[data.src] = data
    ST._Scoreboard.Recent[recentData.src] = recentData
end

function ST.Scoreboard.GetPlayerCount(self)
    local count = 0

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then count = count + 1 end
    end

    return count
end

local sv_maxClients = 128

Citizen.CreateThread(function()
    local function DrawMain()
        if WarMenu.Button("Server:", tostring(#GetActivePlayers()) .. '/' .. tostring(sv_maxClients), {r = 56, g = 56, b = 56, a = 150}) then end
        
        for k,v in spairs(ST._Scoreboard.Players, function(t, a, b) return t[a].src < t[b].src end) do
            local playerId = GetPlayerFromServerId(v.src)

            if NetworkIsPlayerActive(playerId) or GetPlayerPed(playerId) == GetPlayerPed(-1) then
                if WarMenu.MenuButton("f[" .. v.src .. "] " .. v.steamid .. " ", "options") then ST._Scoreboard.SelectedPlayer = v end
            else
                if WarMenu.MenuButton("[" .. v.src .. "] - instanced?", "options", {r = 255, g = 0, b = 0, a = 255}) then ST._Scoreboard.SelectedPlayer = v end
            end
        end

        

        if WarMenu.MenuButton("Recent Disconnects", "recent", {r = 0, g = 0, b = 0, a = 150}) then
        end
    end

    local function DrawRecent()
        for k,v in spairs(ST._Scoreboard.Recent, function(t, a, b) return t[a].src < t[b].src end) do
            if WarMenu.MenuButton("[" .. v.src .. "] " .. v.name, "options") then ST._Scoreboard.SelectedPlayer = v end
        end
    end

    local function DrawOptions()
        if group ~= "user" then
            if WarMenu.Button("Name:", ST._Scoreboard.SelectedPlayer.name) then end
        end
        if WarMenu.Button("Steam ID:", ST._Scoreboard.SelectedPlayer.steamid) then end
        if WarMenu.Button("Community ID:", ST._Scoreboard.SelectedPlayer.comid) then end
        if WarMenu.Button("Server ID:", ST._Scoreboard.SelectedPlayer.src) then end
    end

    ST._Scoreboard.Menus = {
        ["scoreboard"] = DrawMain,
        ["recent"] = DrawRecent,
        ["options"] = DrawOptions
    }

    local function Init()
        WarMenu.CreateMenu("scoreboard", "Player List")
        WarMenu.SetSubTitle("scoreboard", "Players")

        WarMenu.SetMenuWidth("scoreboard", 0.5)
        WarMenu.SetMenuX("scoreboard", 0.71)
        WarMenu.SetMenuY("scoreboard", 0.25)
        WarMenu.SetMenuMaxOptionCountOnScreen("scoreboard", 30)
        WarMenu.SetTitleColor("scoreboard", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("scoreboard", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("scoreboard", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("scoreboard", 255, 255, 255, 255)

        WarMenu.CreateSubMenu("recent", "scoreboard", "Recent D/C's")
        WarMenu.SetMenuWidth("recent", 0.5)
        WarMenu.SetTitleColor("recent", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("recent", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("recent", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("recent", 255, 255, 255, 255)

        WarMenu.CreateSubMenu("options", "scoreboard", "User Info")
        WarMenu.SetMenuWidth("options", 0.5)
        WarMenu.SetTitleColor("options", 135, 206, 250, 255)
        WarMenu.SetTitleBackgroundColor("options", 0 , 0, 0, 150)
        WarMenu.SetMenuBackgroundColor("options", 0, 0, 0, 100)
        WarMenu.SetMenuSubTextColor("options", 255, 255, 255, 255)
    end

    Init()
    timed = 0
    while true do
        for k,v in pairs(ST._Scoreboard.Menus) do
            if WarMenu.IsMenuOpened(k) then
                v()
                WarMenu.Display()
            else
                if timed > 0 then
                    timed = timed - 1
                end
            end
        end

        Citizen.Wait(1)
    end
end)

function ST.Scoreboard.Menu.Open(self)
    ST._Scoreboard.SelectedPlayer = nil
    WarMenu.OpenMenu("scoreboard")
    shouldDraw = true
end

function ST.Scoreboard.Menu.Close(self)
    for k,v in pairs(ST._Scoreboard.Menus) do
        WarMenu.CloseMenu(K)        shouldDraw =false    end
end

Citizen.CreateThread(function()
    local function IsAnyMenuOpen()
        for k,v in pairs(ST._Scoreboard.Menus) do
            if WarMenu.IsMenuOpened(k) then return true end
        end

        return false
    end

    while true do
        Citizen.Wait(0)
        if IsControlPressed(0, 10) then
            if not IsAnyMenuOpen() then
                ST.Scoreboard.Menu:Open()
            end
        else
            if IsAnyMenuOpen() and IsInputDisabled(0) then ST.Scoreboard.Menu:Close() end
            Citizen.Wait(100)
        end
    end
end)

RegisterNetEvent("scoreboard:RemovePlayer")
AddEventHandler("scoreboard:RemovePlayer", function(data)
    ST.Scoreboard:RemovePlayer(data)
end)

RegisterNetEvent("scoreboard:AddPlayer")
AddEventHandler("scoreboard:AddPlayer", function(data)
    ST.Scoreboard:AddPlayer(data)
end)

RegisterNetEvent("scoreboard:RemoveRecent")
AddEventHandler("scoreboard:RemoveRecent", function(src)
    ST.Scoreboard:RemoveRecent(src)
end)

RegisterNetEvent("scoreboard:AddAllPlayers")
AddEventHandler("scoreboard:AddAllPlayers", function(data, recentData)
    ST.Scoreboard:AddAllPlayers(data, recentData)
end)

-----------------------------
-- Player IDs Above Head
-----------------------------

--Draw Things
Citizen.CreateThread(function()
    local animationState = false
    while true do
        Citizen.Wait(0)

        if shouldDraw or forceDraw then
            local nearbyPlayers = GetNeareastPlayers()
            for k, v in pairs(nearbyPlayers) do
                local ped = v.ped
                if DoesEntityExist(ped) and IsEntityVisible(ped) then
                    local x, y, z = table.unpack(GetEntityCoords(v.ped))
                    Draw3DText(x, y, z + 1.1, v.playerId)
                end
            end
        end
    end
end)

function Draw3DText(x, y, z, text)
    -- Check if coords are visible and get 2D screen coords
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        -- Calculate text scale to use
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = 1.8 * (1 / dist) * (1 / GetGameplayCamFov()) * 100

        -- Draw text on screen
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function GetNeareastPlayers()
	local playerPed = PlayerPedId()
	local playerlist = GetActivePlayers()
   --local players, _ = hc.Game.GetPlayersInArea(GetEntityCoords(playerPed), Config.DrawDistance)

    local players_clean = {}
    local found_players = false

    for i = 1, #playerlist, 1 do
        found_players = true
        table.insert(players_clean, { playerName = GetPlayerName(playerlist[i]), playerId = GetPlayerServerId(playerlist[i]), ped = GetPlayerPed(playerlist[i]) })
    end
    return players_clean
end