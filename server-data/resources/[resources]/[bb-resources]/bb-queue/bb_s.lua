local globalCounter, latestColor, ColorsTimeout = 0, true, false
local playersInfo, connectingInfo, savedInfo = {}, {}, {}
StopResource('hardcap')

Citizen.CreateThread(function()
	while true do
		PerformHttpRequest(Config.ApiLink .. '?key=' .. Config.ApiKey .. '&type=SET&queue=' .. #playersInfo, function(statusCode, response, headers) end)
		Wait(25000)
	end
end)

RegisterServerEvent("bb-queue:playerConnecting")
AddEventHandler("bb-queue:playerConnecting", function(source, reject, d)
    local _source = source
    local currentSteamID, currentDiscordID
    d.defer()
    Wait(50)
    d.update('Handshaking with RealisticLife Queue.')
    Wait(75)
    d.update('Handshaking with RealisticLife Queue..')
    Wait(75)
    d.update('Handshaking with RealisticLife Queue...')
    Wait(50)

    for k, v in ipairs(GetPlayerIdentifiers(_source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            currentDiscordID = v
        elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
            currentSteamID = v
        end
    end

    if not currentDiscordID then
        reject(Config.NoDiscord)
        CancelEvent()
        return
    end

    if not currentSteamID then
        reject(Config.NoSteam)
        CancelEvent()
        return
    end

    if not ProccessQueue(currentSteamID, currentDiscordID, d, _source) then
        CancelEvent()
    end
end)

function tprint (t, s)
    for k, v in pairs(t) do
        local kfmt = '["' .. tostring(k) ..'"]'
        if type(k) ~= 'string' then
            kfmt = '[' .. k .. ']'
        end
        local vfmt = '"'.. tostring(v) ..'"'
        if type(v) == 'table' then
            tprint(v, (s or '')..kfmt)
        else
            if type(v) ~= 'string' then
                vfmt = tostring(v)
            end
            print(type(t)..(s or '')..kfmt..' = '..vfmt)
        end
    end
end 

function ProccessQueue(steamID, discordID, d, _source)
    local data = {name = nil, queuepts = 0}
	PerformHttpRequest("https://discordapp.com/api/guilds/" .. Config.DiscordServerID .. "/members/"..string.sub(discordID, 9), function(err, text, headers) 
		if text ~= nil then
			local member = json.decode(text)
        	local memberRoleNames, memberRoleNamesCounter = '', 0
        	for a, b in ipairs(member.roles) do
        	    for _, roleData in pairs(Config.Roles) do
        	        if b == roleData.roleID then
        	            data.queuepts = data.queuepts + roleData.points
        	            if memberRoleNamesCounter == 0 then
        	            	memberRoleNames = roleData.name
        	            	memberRoleNamesCounter = memberRoleNamesCounter + 1
        	            else
        	            	memberRoleNames = memberRoleNames .. ' & ' .. roleData.name
        	            end
        	        end
        	    end
        	end

			local localname, localdec = "", ""
			local phphash = ""
			for k, v in pairs(member.user) do
        	    if k == "username" then
					localname = v
				elseif k == "avatar" then
					phphash = v
        	    elseif k == "discriminator" then
        	        localdec = tostring(v)
        	    end
        	end
        	data.name = localname .. "#" .. tostring(localdec)
        	if memberRoleNames == "" then
				memberRoleNames = "Member"
			end

			local discordPfp = "https://cdn.discordapp.com/avatars/" .. string.sub(discordID, 9) .. "/" .. phphash .. ".png"
        	AddPlayer(steamID, discordID, data.name, discordPfp, data.queuepts, memberRoleNames, _source, d, {s = 0, m = 0, h = 0})

        	local stop = false
        	repeat
        		for k, v in pairs(connectingInfo) do
        			if v.steamID == steamID then
        				stop = true
        			end
        		end


				for k, v in ipairs(playersInfo) do
					if v.steamID == steamID and (GetPlayerPing(v.source) == 0) then
						dropPlayerFromQueue(steamID, discordID)
						d.done(Config.Error)
						return false
					end
				end

        	    local currentMessage = GetMessage(steamID)
        	    d.presentCard(currentMessage, function(data, rawData) end)
        	    Wait(0)
        	until stop
        	d.done()
			return true
		else
			d.done(Config.NotWhitelisted)
			return false
		end
    end, "GET", "", {["Content-type"] = "application/json", ["Authorization"] = "Bot " .. Config.DiscordBotToken})
end

AddEventHandler("playerDropped", function(reason)
    local _source = source
    dropPlayerFromQueue(GetPlayerIdentifier(_source, 1), GetPlayerIdentifier(_source, 3))
end)

RegisterServerEvent('RLCore:PlayerJoined')
AddEventHandler('RLCore:PlayerJoined', function()
	local _source = source
	for k, v in pairs(connectingInfo) do
		if v.steamID == GetPlayerIdentifier(_source) then
			table.remove(connectingInfo, k)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
		for k, v in pairs(playersInfo) do
			v.Timer.s = v.Timer.s + 1
			if v.Timer.s == 60 then
				v.Timer.s = 0
				v.Timer.m = v.Timer.m + 1
				if v.Timer.m == 60 then
					v.Timer.m = 0
					v.Timer.h = v.Timer.h + 1
				end
			end
		end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000)
        CheckConnecting()

        if #playersInfo > 0 and #connectingInfo + #GetPlayers() < Config.maxServerSlots then
            ConnectFirst()
        end
    end
end)

function dropPlayerFromQueue(steamID, discordID, count)
	if count then
		local queueCount = #playersInfo
    	for currentPlayer = count, queueCount do
    		playersInfo[currentPlayer] = playersInfo[currentPlayer + 1]
    	end
	else
		for k, v in pairs(playersInfo) do
			if v.steamID == steamID or v.discordID == discordID then
				local queueCount = #playersInfo
    			local saveCred = nil
    			for currentPlayer = k + 1, queueCount do
    				playersInfo[currentPlayer - 1] = playersInfo[currentPlayer]
    			end
    			playersInfo[queueCount] = nil
    			return
			end
		end
	end
end

function AddPlayer(steamID, discordID, discordName, discordPfp, queuePts, roleNames, source, d, timer)
    local _source = source

    if #playersInfo == 0 then
    	playersInfo[1] = {
    		steamID = steamID,
    		steamName = GetPlayerName(_source),
    		discordID = discordID,
			discordName = discordName, 
			discordPfp = discordPfp,
    		points = queuePts,
    		roleNames = roleNames,
			source = _source,
			Timer = timer
    	}
    else
    	for k, v in pairs(playersInfo) do
    		if v.points < queuePts then
    			local queueCount = #playersInfo
    			local saveCred = nil
    			for currentPlayer = k, queueCount + 1 do
    				if currentPlayer == k then
    					saveCred = playersInfo[currentPlayer + 1]
    					playersInfo[currentPlayer + 1] = playersInfo[currentPlayer]
    				else
    					local currentSaveCred = playersInfo[currentPlayer + 1]
    					playersInfo[currentPlayer + 1] = saveCred
    					saveCred = currentSaveCred
    				end
    			end

    			playersInfo[k] = {
    				steamID = steamID,
    				steamName = GetPlayerName(_source),
    				discordID = discordID,
					discordName = discordName,
					discordPfp = discordPfp,
    				points = queuePts,
    				roleNames = roleNames,
    				source = _source,
					Timer = timer
    			}
    			return
    		end
    	end

    	playersInfo[#playersInfo + 1] = {
    		steamID = steamID,
    		steamName = GetPlayerName(_source),
    		discordID = discordID,
			discordName = discordName,
			discordPfp = discordPfp,
    		points = queuePts,
    		roleNames = roleNames,
    		source = _source,
			Timer = timer
    	}
    end
end

function CheckConnecting()
    for k, v in pairs(playersInfo) do
        if GetPlayerPing(v.source) == 500 then
           	dropPlayerFromQueue(nil, nil, k)
        end
    end

    for k, v in pairs(connectingInfo) do
        if GetPlayerPing(v.source) == -1 then
            if v.errorsNum > 1 then
				table.remove(connectingInfo, k)
            end
            v.errorsNum = v.errorsNum + 1
        end
    end
end

function ConnectFirst()
    if #playersInfo == 0 then 
    	return 
    end
    
    table.insert(connectingInfo, {steamID = playersInfo[1].steamID, source = playersInfo[1].source, errorsNum = 0})
    dropPlayerFromQueue(nil, nil, 1)
end

function GetMessage(currentSteamid)
    local msg = ""
	--local cardd = jsonCard
	local cardd = originalCard
	
	local counter = 1
	local placeCounter = 0
	local newjson = ""
	
	if not ColorsTimeout then
		CreateThread(function()
			ColorsTimeout = true
			latestColor = not latestColor
			Wait(2500)
			ColorsTimeout = false
		end)
	end
	local color = latestColor
	
	for k, v in pairs(playersInfo) do
		local thisjson = ""

		local thisTimer = ""
		if counter < 10 then
			if v.Timer.h ~= 0 then
				thisTimer = thisTimer .. tostring(v.Timer.h) .. 'H:'
			end
			if v.Timer.m ~= 0 then
				thisTimer = thisTimer .. tostring(v.Timer.m) .. 'M:'
			end
			thisTimer = thisTimer .. tostring(v.Timer.s) .. 'S'

			if v.steamID == currentSteamid then
				placeCounter = k
				thisjson = lineFormat(v.discordPfp, '['..tostring(k)..'] ' .. v.steamName .. ' (' .. v.discordName .. ') | ' .. v.roleNames .. ' [' .. thisTimer .. ']', true)
			else
				thisjson = lineFormat(v.discordPfp, '['..tostring(k)..'] ' .. v.steamName .. ' (' .. v.discordName .. ') | ' .. v.roleNames .. ' [' .. thisTimer .. ']', false)
			end
		elseif counter == 10 then
			thisjson = lineFormat("", 'And ' .. (#playersInfo - counter) + 1 .. ' more players.', false)
		end
		newjson = newjson .. thisjson
		counter = counter + 1
    end
	local starting = createStarting(color)
	local ending = createEnding("Your Place: " .. placeCounter ..  " | Queue Length: " .. tostring(#playersInfo))--.. " | Player Count: " .. #GetPlayers() .. "/" .. Config.maxServerSlots, color)

	local newCard = json.decode(starting .. newjson .. ending)
    return newCard
end

function lineFormat(playerpicture, text, isthis)
	local strr = ""

	if isthis then
		strr = tostring([[{"type": "ColumnSet",
			"spacing": "Small",
			"columns": [
				{
					"type": "Column",
					"width": "20px",
					"minHeight": "12px",
					"backgroundImage": {
						"verticalAlignment": "Center",
						"horizontalAlignment": "Center"
					},
					"items": [
						{
							"type": "Image",
							"style": "Person",
							"height": "20px",
							"url": "]] .. playerpicture .. [[",
							"width": "20px"
						}
					]
				},
				{
					"type": "Column",
					"width": "auto",
					"minHeight": "24px",
					"items": [
						{
							"type": "TextBlock",
							"text": "]] .. text .. [[",
							"color": "Attention",
							"fontType": "Default",
							"weight": "Bolder"
						}
					]
				}
			]
		},]])
	else
		strr = tostring([[{"type": "ColumnSet",
			"spacing": "Small",
			"columns": [
				{
					"type": "Column",
					"width": "14px",
					"minHeight": "14px",
					"backgroundImage": {
						"verticalAlignment": "Center",
						"horizontalAlignment": "Center"
					},
					"items": [
						{
							"type": "Image",
							"style": "Person",
							"height": "18px",
							"url": "]] .. playerpicture .. [[",
							"width": "18px"
						}
					]
				},
				{
					"type": "Column",
					"width": "auto",
					"minHeight": "24px",
					"items": [
						{
							"type": "TextBlock",
							"text": "]] .. text .. [[",
							"color": "Light",
							"fontType": "Default",
							"weight": "Lighter"
						}
					]
				}
			]
		},]])
	end
	return strr
end

function createEnding(text, clr)
	local colorr = "Light"
	if clr then
		colorr = "Attention"
	end

	local strr = tostring([[
		{
			"type": "TextBlock",
			"text": "]] .. text .. [[",
			"color": "]] .. colorr .. [[",
			"spacing": "Small",
			"horizontalAlignment": "Center",
			"weight": "Bolder"
		},
		{
			"type": "TextBlock",
			"text": "Reserve your queue place now! realisticlife.co.il",
			"horizontalAlignment": "Center",
			"weight": "Bolder",
			"color": "]] .. colorr .. [[",
			"size": "Small",
			"spacing": "Small"
		}
	]
	}
	]])
	return strr
end

function createStarting(clr)
	local colorr = "Attention"
	if clr then
		colorr = "Light"
	end
	
	local strr = tostring([[
		{
			"type": "AdaptiveCard",
			"$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
			"version": "1.2",
			"body": [
				{
					"type": "Image",
					"url": "https://cdn.discordapp.com/attachments/655220339776684046/779633567486574602/aa55e1c925c37-1.png",
					"horizontalAlignment": "Center",
					"width": "70px",
					"spacing": "Small"
				},
	]])
	return strr
end
