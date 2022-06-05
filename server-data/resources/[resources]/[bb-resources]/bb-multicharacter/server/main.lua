RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RLCore.Functions.CreateCallback("bb-multicharacter:server:GetUserCharacters", function(source, cb)
    local src = source

    RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `players` WHERE `steam` = \'' .. GetPlayerIdentifier(src) ..'\'', function(result)
        if result ~= nil then
            cb(result)
        else
            cb(false)
        end
    end)
end)

RLCore.Functions.CreateCallback("bb-multicharacter:server:GetServerLogs", function(source, cb)
    exports['ghmattimysql']:execute('SELECT * FROM server_logs', function(result)
        cb(result)
    end)
end)

RLCore.Functions.CreateCallback("test:yeet", function(source, cb)
    local steamId = GetPlayerIdentifiers(source)[1]
    local plyChars = {}
    
    exports['ghmattimysql']:execute('SELECT * FROM players WHERE steam = @steam', {['@steam'] = steamId}, function(result)
        for i = 1, (#result), 1 do
            result[i].charinfo = json.decode(result[i].charinfo)
            result[i].money = json.decode(result[i].money)
            result[i].job = json.decode(result[i].job)

            table.insert(plyChars, result[i])
        end
        cb(plyChars)
    end)
end)

RLCore.Functions.CreateCallback("bb-multicharacter:server:getSkin", function(source, cb, cid, inf)
    local src = source
    local info = inf
    local char = {}

    exports.ghmattimysql:execute("SELECT * FROM `character_current` WHERE citizenid = '" .. cid .. "'", {}, function(character_current)
        char.model = '1885233650'
        char.drawables = json.decode('{"1":["masks",0],"2":["hair",0],"3":["torsos",0],"4":["legs",0],"5":["bags",0],"6":["shoes",1],"7":["neck",0],"8":["undershirts",0],"9":["vest",0],"10":["decals",0],"11":["jackets",0],"0":["face",0]}')
        char.props = json.decode('{"1":["glasses",-1],"2":["earrings",-1],"3":["mouth",-1],"4":["lhand",-1],"5":["rhand",-1],"6":["watches",-1],"7":["braclets",-1],"0":["hats",-1]}')
        char.drawtextures = json.decode('[["face",0],["masks",0],["hair",0],["torsos",0],["legs",0],["bags",0],["shoes",2],["neck",0],["undershirts",1],["vest",0],["decals",0],["jackets",11]]')
        char.proptextures = json.decode('[["hats",-1],["glasses",-1],["earrings",-1],["mouth",-1],["lhand",-1],["rhand",-1],["watches",-1],["braclets",-1]]')

        if character_current[1] and character_current[1].model then
            char.model = character_current[1].model
            char.drawables = json.decode(character_current[1].drawables)
            char.props = json.decode(character_current[1].props)
            char.drawtextures = json.decode(character_current[1].drawtextures)
            char.proptextures = json.decode(character_current[1].proptextures)
        end

        exports.ghmattimysql:execute("SELECT * FROM `character_face` WHERE citizenid = '" .. cid .. "'", {}, function(character_face)
            if character_face[1] and character_face[1].headBlend then
                char.headBlend = json.decode(character_face[1].headBlend)
                char.hairColor = json.decode(character_face[1].hairColor)
                char.headStructure = json.decode(character_face[1].headStructure)
                char.headOverlay = json.decode(character_face[1].headOverlay)
            end

            cb(char, info)
        end)
    end)
end)

RegisterServerEvent('bb-multicharacter:server:disconnect')
AddEventHandler('bb-multicharacter:server:disconnect', function()
    local src = source
    DropPlayer(src, "You have disconnected from ConnectRP")
end)


RegisterServerEvent('bb-multicharacter:server:loadUserData')
AddEventHandler('bb-multicharacter:server:loadUserData', function(cData)
    local src = source
    if RLCore.Player.Login(src, cData.dat[1]) then
        print('^2[bb-multicharacter]^7 '..GetPlayerName(src)..' (Citizen ID: '..cData.dat[1]..') has succesfully loaded!')
        RLCore.Commands.Refresh(src)
        loadHouseData()

        TriggerEvent('bb-logs:server:createLog', 'connects', 'Player Loaded', "Loaded citizenID " .. cData.dat[1] .. ".", src)
        TriggerClientEvent('apartments:client:setupSpawnUI', src, cData)
	end
end)

AddEventHandler('playerDropped', function (reason)
    TriggerEvent('bb-logs:server:createLog', 'connects', 'Player Disconnected', reason, source)
    if reason == 'Game crashed: gta-core-five.dll!CrashCommand (0x0)' then
        TriggerEvent('bb-logs:server:createLog', 'crash', '_crash executed', reason, source)
    end
end)

RegisterServerEvent('bb-multicharacter:server:createCharacter')
AddEventHandler('bb-multicharacter:server:createCharacter', function(data, cid)
    local src = source
    local newData = {}
    newData.charinfo = data
    newData.cid = cid
    if RLCore.Player.Login(src, false, newData) then
        print('^2[bb-multicharacter]^7 '..GetPlayerName(src)..' has succesfully loaded!')
        RLCore.Commands.Refresh(src)
        loadHouseData()

        TriggerClientEvent("bb-multicharacter:client:closeNUI", src)
        TriggerClientEvent('apartments:client:setupSpawnUI', src, newData)
        GiveStarterItems(src)
	end
end)

RegisterServerEvent('bb-multicharacter:server:deleteCharacter')
AddEventHandler('bb-multicharacter:server:deleteCharacter', function(citizenid)
    local src = source
    RLCore.Player.DeleteCharacter(src, citizenid)
end)

function GiveStarterItems(source)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    for k, v in pairs(RLCore.Shared.StarterItems) do
        local info = {}
        if v.item == "id_card" then
            info.citizenid = Player.PlayerData.citizenid
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.gender = Player.PlayerData.charinfo.gender
            info.nationality = Player.PlayerData.charinfo.nationality
        elseif v.item == "driver_license" then
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.type = "A1-A2-A | AM-B | C1-C-CE"
        end
        Player.Functions.AddItem(v.item, 1, false, info)
    end
end

function loadHouseData()
    local HouseGarages = {}
    local Houses = {}
	RLCore.Functions.ExecuteSql(false, "SELECT * FROM `houselocations`", function(result)
		if result[1] ~= nil then
			for k, v in pairs(result) do
				local owned = false
				if tonumber(v.owned) == 1 then
					owned = true
				end
				local garage = v.garage ~= nil and json.decode(v.garage) or {}
				Houses[v.name] = {
					coords = json.decode(v.coords),
					owned = v.owned,
					price = v.price,
					locked = true,
					adress = v.label, 
					tier = v.tier,
					garage = garage,
					decorations = {},
				}
				HouseGarages[v.name] = {
					label = v.label,
					takeVehicle = garage,
				}
			end
		end
		TriggerClientEvent("bb-garages:client:houseGarageConfig", -1, HouseGarages)
		TriggerClientEvent("bb-houses:client:setHouseConfig", -1, Houses)
	end)
end

RLCore.Commands.Add("char", "Logout by admin", {}, false, function(source, args)
    RLCore.Player.Logout(source)
    TriggerClientEvent('bb-multicharacter:client:chooseChar', source)
end, "god")

RLCore.Commands.Add("closeNUI", "Close NUI", {}, false, function(source, args)
    TriggerClientEvent('bb-multicharacter:client:closeNUI', source)
end)