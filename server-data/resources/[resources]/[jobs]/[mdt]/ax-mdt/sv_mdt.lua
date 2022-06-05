RLCore = nil

TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)

RLCore.Commands.Add("mdt", "Police Database", {}, false, function(source, args)
	local usource = source
    local xPlayer = RLCore.Functions.GetPlayer(source)
    if xPlayer and (xPlayer.PlayerData.job.name == 'police' or xPlayer.PlayerData.job.name == 'lawyer' and xPlayer.PlayerData.job.isboss) then
    	exports['ghmattimysql']:execute("SELECT * FROM (SELECT * FROM `mdt_reports` ORDER BY `id` DESC LIMIT 3) sub ORDER BY `id` DESC", {}, function(reports)
    		for r = 1, #reports do
    			reports[r].charges = json.decode(reports[r].charges)
    		end
    		exports['ghmattimysql']:execute("SELECT * FROM (SELECT * FROM `mdt_warrants` ORDER BY `id` DESC LIMIT 3) sub ORDER BY `id` DESC", {}, function(warrants)
    			for w = 1, #warrants do
    				warrants[w].charges = json.decode(warrants[w].charges)
    			end

    			local officer = GetCharacterName(usource)
    			TriggerClientEvent('mdt:toggleVisibilty', usource, reports, warrants, officer)
    		end)
    	end)
    end
end)

RegisterServerEvent("mdt:getOffensesAndOfficer")
AddEventHandler("mdt:getOffensesAndOfficer", function()
	local src = source
	local charges = {}
	exports['ghmattimysql']:execute('SELECT * FROM fine_types', {}, function(fines)
		for j = 1, #fines do
			if fines[j].category == 0 or fines[j].category == 1 or fines[j].category == 2 or fines[j].category == 3 then
				table.insert(charges, fines[j])
			end
		end
		
		local officer = GetCharacterName(usource)

		TriggerClientEvent("mdt:returnOffensesAndOfficer", src, charges, officer)
	end)
end)

RegisterServerEvent("mdt:performOffenderSearch")
AddEventHandler("mdt:performOffenderSearch", function(query)
	local usource = source
	local matches = {}
	local arrary = string.split(query)
	local data = "SELECT * FROM `players` WHERE "
	for k,v in pairs(arrary) do
		if data == "SELECT * FROM `players` WHERE " then
			data = data .. "`charinfo` LIKE '" .. string.lower('%'..v..'%') .. "'"
		else
			data = data .. " OR `charinfo` LIKE '" .. string.lower('%'..v..'%') .. "'"
		end

	end

	data = data .. " OR `citizenid` LIKE '" .. string.lower('%'..query..'%') .. "'"
	data = data .. " OR `metadata` LIKE '%" .. '"fingerprint":"' .. string.lower(query) .. '"' .. "%'"

	exports['ghmattimysql']:execute(data, {}, function(result)

		for index, data in ipairs(result) do
			if data.charinfo then
				local player = json.decode(data.charinfo)
				local metadata = json.decode(data.metadata)
				local core = RLCore.Functions.GetPlayerByCitizenId(data.citizenid)

				if core then
					player = core['PlayerData']['charinfo']
					metadata = core['PlayerData']['metadata']
				end

				player.id = data.id
				player.metadata = metadata
				player.citizenid = data.citizenid
				table.insert(matches, player)
			end
		end

		TriggerClientEvent("mdt:returnOffenderSearchResults", usource, matches)
	end)
end)

RegisterServerEvent("mdt:getOffenderDetails")
AddEventHandler("mdt:getOffenderDetails", function(offender)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	offender.licenses = {}

	exports['ghmattimysql']:execute('SELECT * FROM `user_mdt` WHERE `char_id` = @id', {
		['@id'] = offender.id
	}, function(result)
		offender.notes = ""
		offender.mugshot_url = ""
		offender.fingerprint = ""
		if result[1] then
			offender.notes = result[1].notes
			offender.mugshot_url = result[1].mugshot_url
			offender.fingerprint = result[1].fingerprint
		end
		exports['ghmattimysql']:execute('SELECT * FROM `user_convictions` WHERE `char_id` = @id', {
			['@id'] = offender.id
		}, function(convictions)
			if convictions[1] then
				offender.convictions = {}
				for i = 1, #convictions do
					local conviction = convictions[i]
					offender.convictions[conviction.offense] = conviction.count
				end
			end

			exports['ghmattimysql']:execute('SELECT * FROM `mdt_warrants` WHERE `char_id` = @id', {
				['@id'] = offender.id
			}, function(warrants)
				if warrants[1] then
					offender.haswarrant = true
				end

				local lic = {
					"driver",
					'business',
					'weapon1',
				}

				local k;

				for i = 1, 3 do
					if Player.PlayerData.metadata.licences[lic[i]] then
						if lic[i] == 'driver' then
							k = 'Driver'
						elseif lic[i] == 'business' then
							k = 'Business'
						elseif lic[i] == 'weapon1' then
							k = 'Concealed Carry'
						end
						table.insert(offender.licenses, k)
					end
				end

				TriggerClientEvent("mdt:returnOffenderDetails", src, offender)
			end)
		end)
	end)
end)

RegisterServerEvent("mdt:getOffenderDetailsById")
AddEventHandler("mdt:getOffenderDetailsById", function(char_id)
	local src = source
	offender.licenses = {}

	exports['ghmattimysql']:execute('SELECT * FROM `players` WHERE `id` = @id', {
		['@id'] = char_id
	}, function(result)
		local offender = json.decode(result[1].charinfo)
		local metadata = json.decode(result[1].metadata)
		offender.id = result[1].id
		offender.citizenid = result[1].citizenid
		offender.fingerprint = metadata.fingerprint
		
		exports['ghmattimysql']:execute('SELECT * FROM `user_mdt` WHERE `char_id` = @id', {
			['@id'] = offender.id
		}, function(result)
			offender.notes = ""
			offender.mugshot_url = ""
			offender.fingerprint = ""
			if result[1] then
				offender.notes = result[1].notes
				offender.mugshot_url = result[1].mugshot_url
				offender.fingerprint = result[1].fingerprint
			end
			exports['ghmattimysql']:execute('SELECT * FROM `user_convictions` WHERE `char_id` = @id', {
				['@id'] = offender.id
			}, function(convictions)
				if convictions[1] then
					offender.convictions = {}
					for i = 1, #convictions do
						local conviction = convictions[i]
						offender.convictions[conviction.offense] = conviction.count
					end
				end

				local Player = RLCore.Functions.GetPlayerByCitizenId(char_id)

				local lic = {
					"driver",
					'business',
					'weapon1',
				}

				local k;

				for i = 1, 3 do
					if Player.PlayerData.metadata.licences[lic[i]] then
						if lic[i] == 'driver' then
							k = 'Driver'
						elseif lic[i] == 'business' then
							k = 'Business'
						elseif lic[i] == 'weapon1' then
							k = 'Concealed Carry'
						end
						table.insert(offender.licenses, k)
					end
				end

				TriggerClientEvent("mdt:returnOffenderDetails", src, offender)
			end)
		end)
	end)
end)

--[[RegisterServerEvent("mdt:saveOffenderChanges")
AddEventHandler("mdt:saveOffenderChanges", function(id, notes, mugshot, convictions, convictions_removed, identifier, fingerprint, changes)
	print(json.encode(changes))
	if not changes then
		return
	end

	local id, changes, citizenid = id, changes, citizenid
	exports['ghmattimysql']:execute('UPDATE `user_mdt` SET `notes` = @notes, `mugshot_url` = @mugshot_url, `fingerprint` = @fingerprint  WHERE `char_id` = @id', {
		['@id']  = id
	}, function(result)
		if result[1] then
			exports['ghmattimysql']:execute('UPDATE `user_mdt` SET `notes` = @notes, `mugshot_url` = @mugshot_url, `fingerprint` = @fingerprint  WHERE `char_id` = @id', {
				['@id'] = id,
				['@notes'] = notes,
				['@mugshot_url'] = mugshot,
				['@fingerprint'] = fingerprint
			})
		else
			exports['ghmattimysql']:execute('INSERT INTO `user_mdt` (`char_id`, `notes`, `mugshot_url`, `fingerprint`) VALUES (@id, @notes, @mugshot_url, @fingerprint)', {
				['@id'] = id,
				['@notes'] = notes,
				['@mugshot_url'] = mugshot,
				['@fingerprint'] = fingerprint
			})
		end

		if changes.licenses_removed then
			print('Working!')
			local xPlayer = RLCore.Functions.GetPlayerByCitizenId(citizenid)

			if xPlayer then
				for i = 1, #changes.licenses_removed do
					local license = string.lower(changes.licenses_removed[i])
					local a;
					local b;
					local c;
					print(xPlayer.PlayerData.metadata.licences['weapon1'])
					if license == 'driver' then
						a = false
						b = xPlayer.PlayerData.metadata.licences["business"]
						c = xPlayer.PlayerData.metadata.licences["weapon1"]
					elseif license == 'business' then
						a = xPlayer.PlayerData.metadata.licences["driver"]
						b = false
						c = xPlayer.PlayerData.metadata.licences["weapon1"]
					elseif license == 'concealed carry' then
						a = xPlayer.PlayerData.metadata.licences["driver"]
						b = xPlayer.PlayerData.metadata.licences["business"]
						c = false
					end
					local metadatas = {
						['driver'] = a,
						['business'] = b,
						['weapon1'] = c,
					}
					xPlayer.Functions.SetMetaData('licences', metadatas)
				end
			else
				exports['ghmattimysql']:execute("SELECT * FROM `players` WHERE `citizenid` = '" .. citizenid .. "'", {}, function(result)
					if result[1] then
						local metadata = json.decode(result[1].metadata)
						for i = 1, #changes.licenses_removed do
							local license = string.lower(changes.licenses_removed[i])
							if metadata.licences[license] ~= nil then
								metadata.licences[license] = false
							end
						end
						print(metadata)
						exports['ghmattimysql']:execute("UPDATE `players` SET `metadata` = '" .. json.encode(metadata) .. "'")
					end
				end)
			end
		end

		if changes.convictions then
			for conviction, amount in pairs(changes.convictions) do	
				exports['ghmattimysql']:execute('UPDATE `user_convictions` SET `count` = @count WHERE `char_id` = @id AND `offense` = @offense', {
					['@id'] = id,
					['@count'] = amount,
					['@offense'] = conviction
				})
			end
		end

		if changes.convictions_removed then
			for i = 1, #changes.convictions_removed do
				exports['ghmattimysql']:execute('DELETE FROM `user_convictions` WHERE `char_id` = @id AND `offense` = @offense', {
					['@id'] = id,
					['offense'] = changes.convictions_removed[i]
				})
			end
		end
	end)
end)]]

RegisterServerEvent("mdt:saveOffenderChanges")
AddEventHandler("mdt:saveOffenderChanges", function(id, changes, citizenid)
	if not changes then
		return
	end

	local id, changes, citizenid = id, changes, citizenid
	exports['ghmattimysql']:execute('SELECT * FROM `user_mdt` WHERE `char_id` = @id', {
		['@id']  = id
	}, function(result)
		if result[1] then
			exports['ghmattimysql']:execute('UPDATE `user_mdt` SET `notes` = @notes, `mugshot_url` = @mugshot_url WHERE `char_id` = @id', {
				['@id'] = id,
				['@notes'] = changes.notes,
				['@mugshot_url'] = changes.mugshot_url
			})
		else
			exports['ghmattimysql']:execute('INSERT INTO `user_mdt` (`char_id`, `notes`, `mugshot_url`) VALUES (@id, @notes, @mugshot_url)', {
				['@id'] = id,
				['@notes'] = changes.notes,
				['@mugshot_url'] = changes.mugshot_url
			})
		end

		if changes.licenses_removed then
			local xPlayer = RLCore.Functions.GetPlayerByCitizenId(citizenid)

			if xPlayer then
				for i = 1, #changes.licenses_removed do
					local license = string.lower(changes.licenses_removed[i])
					local a;
					local b;
					local c;
					print(xPlayer.PlayerData.metadata.licences['weapon1'])
					if license == 'driver' then
						a = false
						b = xPlayer.PlayerData.metadata.licences["business"]
						c = xPlayer.PlayerData.metadata.licences["weapon1"]
					elseif license == 'business' then
						a = xPlayer.PlayerData.metadata.licences["driver"]
						b = false
						c = xPlayer.PlayerData.metadata.licences["weapon1"]
					elseif license == 'concealed carry' then
						a = xPlayer.PlayerData.metadata.licences["driver"]
						b = xPlayer.PlayerData.metadata.licences["business"]
						c = false
					end
					local metadatas = {
						['driver'] = a,
						['business'] = b,
						['weapon1'] = c,
					}
					xPlayer.Functions.SetMetaData('licences', metadatas)
				end
			else
				exports['ghmattimysql']:execute("SELECT * FROM `players` WHERE `citizenid` = '" .. citizenid .. "'", {}, function(result)
					if result[1] then
						local metadata = json.decode(result[1].metadata)
						for i = 1, #changes.licenses_removed do
							local license = string.lower(changes.licenses_removed[i])
							if metadata.licences[license] ~= nil then
								metadata.licences[license] = false
							end
						end
						print(metadata)
						exports['ghmattimysql']:execute("UPDATE `players` SET `metadata` = '" .. json.encode(metadata) .. "'")
					end
				end)
			end
		end

		if changes.convictions then
			for conviction, amount in pairs(changes.convictions) do	
				exports['ghmattimysql']:execute('UPDATE `user_convictions` SET `count` = @count WHERE `char_id` = @id AND `offense` = @offense', {
					['@id'] = id,
					['@count'] = amount,
					['@offense'] = conviction
				})
			end
		end

		if changes.convictions_removed then
			for i = 1, #changes.convictions_removed do
				exports['ghmattimysql']:execute('DELETE FROM `user_convictions` WHERE `char_id` = @id AND `offense` = @offense', {
					['@id'] = id,
					['offense'] = changes.convictions_removed[i]
				})
			end
		end
	end)
end)

RegisterServerEvent("mdt:saveReportChanges")
AddEventHandler("mdt:saveReportChanges", function(data)
	exports['ghmattimysql']:execute('UPDATE `mdt_reports` SET `title` = @title, `incident` = @incident WHERE `id` = @id', {
		['@id'] = data.id,
		['@title'] = data.title,
		['@incident'] = data.incident
	})
end)

RegisterServerEvent("mdt:deleteReport")
AddEventHandler("mdt:deleteReport", function(id)
	exports['ghmattimysql']:execute('DELETE FROM `mdt_reports` WHERE `id` = @id', {
		['@id']  = id
	})
end)

RegisterServerEvent("mdt:submitNewReport")
AddEventHandler("mdt:submitNewReport", function(data)
	local usource = source
	local author = GetCharacterName(source)
	if tonumber(data.sentence) and tonumber(data.sentence) > 0 then
		data.sentence = tonumber(data.sentence)
	else 
		data.sentence = nil 
	end
	charges = json.encode(data.charges)
	data.date = os.date('%m-%d-%Y %H:%M:%S', os.time())
	exports['ghmattimysql']:execute('INSERT INTO `mdt_reports` (`char_id`, `title`, `incident`, `charges`, `author`, `name`, `date`, `jailtime`) VALUES (@id, @title, @incident, @charges, @author, @name, @date, @sentence)', {
		['@id']  = data.char_id,
		['@title'] = data.title,
		['@incident'] = data.incident,
		['@charges'] = charges,
		['@author'] = author,
		['@name'] = data.name,
		['@date'] = data.date,
		['@sentence'] = data.sentence
	}, function(id)
		exports['ghmattimysql']:execute("SELECT * FROM `mdt_reports` WHERE `char_id` = '" .. data.char_id .. "' AND `date` = '" .. data.date .. "' AND `title` = '" .. data.title .. "'", {}, function(result)
			if result[1] then
				TriggerEvent("mdt:getReportDetailsById", result[1].id, usource)
			end
		end)
	end)

	for offense, count in pairs(data.charges) do
		exports['ghmattimysql']:execute('SELECT * FROM `user_convictions` WHERE `offense` = @offense AND `char_id` = @id', {
			['@offense'] = offense,
			['@id'] = data.char_id
		}, function(result)
			if result[1] then
				exports['ghmattimysql']:execute('UPDATE `user_convictions` SET `count` = @count WHERE `offense` = @offense AND `char_id` = @id', {
					['@id']  = data.char_id,
					['@offense'] = offense,
					['@count'] = count + 1
				})
			else
				exports['ghmattimysql']:execute('INSERT INTO `user_convictions` (`char_id`, `offense`, `count`) VALUES (@id, @offense, @count)', {
					['@id']  = data.char_id,
					['@offense'] = offense,
					['@count'] = count
				})
			end
		end)
	end
end)

RegisterServerEvent("mdt:sentencePlayer")
AddEventHandler("mdt:sentencePlayer", function(jailtime, charges, char_id, fine, players)
	local usource = source
	local jailmsg = ""
	for offense, amount in pairs(charges) do
		jailmsg = jailmsg .. " "..offense.." x"..amount.." |"
	end
	for _, src in pairs(players) do
		if src ~= 0 and GetPlayerName(src) then
			exports['ghmattimysql']:execute('SELECT * FROM `players` WHERE `steam` = @steam', {
				['@steam'] = GetPlayerIdentifiers(src)[1]
			}, function(result)
				if result[1].id == char_id then
					if jailtime and jailtime > 0 then
						jailtime = math.ceil(jailtime)
						TriggerEvent("esx-qalle-jail:jailPlayer", src, jailtime, jailmsg)
					end
					if fine > 0 then
						TriggerClientEvent("mdt:billPlayer", usource, src, 'society_police', 'Fine: '..jailmsg, fine)
					end
					return
				end
			end)
		end
	end
end)

RegisterServerEvent('mdt:server:BillPlayer')
AddEventHandler('mdt:server:BillPlayer', function(playerId, price)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
	local OtherPlayer = RLCore.Functions.GetPlayer(playerId)
	print (Player.PlayerData.job.name)
    if Player.PlayerData.job.name == "police" then
        if OtherPlayer ~= nil then
            OtherPlayer.Functions.RemoveMoney("bank", price, "paid-bills")
            TriggerClientEvent('RLCore:Notify', OtherPlayer.PlayerData.source, "You received a fine of $"..price)
        end
    end
end)

RegisterServerEvent("mdt:server:getPlayer")
AddEventHandler("mdt:server:getPlayer", function(playerid)

	local _source = source
	local _citizenID = nil
	
	if playerid ~= nil then 
		_citizenID = RLCore.Functions.GetPlayer(playerid)
	end

	TriggerClientEvent('mdt:client:getCitizenID', source, _citizenID)
end)

RegisterServerEvent("mdt:sentencePlayer")
AddEventHandler("mdt:sentencePlayer", function( jailtime, charges, char_id, fine, players)
	
	local src = source
	local offender = char_id

	if offender ~= nil then
		TriggerClientEvent("mdt:client:JailPlayer", src, jailtime, offender, fine)
	end

	-- debugging purposes below 
	for _, src in pairs(players) do
		if src ~= 0 and GetPlayerName(src) then
			exports['ghmattimysql']:execute('SELECT * FROM `players` WHERE `citizenid` = @identifier', {
				['@identifier'] = char_id
			}, function(result)
	
				if result[1].id == char_id then
					if jailtime and jailtime > 0 then
						jailtime = math.ceil(jailtime)
						
						-- TriggerEvent("esx-qalle-jail:jailPlayer", src, jailtime, jailmsg)
					end
					if fine > 0 then
						-- TriggerClientEvent("mdt:billPlayer", usource, src, 'society_police', 'Fine: '..jailmsg, fine)
					end
					return
				end

				TriggerClientEvent("mdt:client:JailCommand", src, 'NHB84639', 5)
			end)
		end
	end

end)

RegisterServerEvent("mdt:performReportSearch")
AddEventHandler("mdt:performReportSearch", function(query)
	local usource = source
	local matches = {}
	exports['ghmattimysql']:execute("SELECT * FROM `mdt_reports` WHERE `id` LIKE @query OR LOWER(`title`) LIKE @query OR LOWER(`name`) LIKE @query OR LOWER(`author`) LIKE @query or LOWER(`charges`) LIKE @query", {
		['@query'] = string.lower('%'..query..'%') -- % wildcard, needed to search for all alike results
	}, function(result)

		for index, data in ipairs(result) do
			data.charges = json.decode(data.charges)
			table.insert(matches, data)
		end

		TriggerClientEvent("mdt:returnReportSearchResults", usource, matches)
	end)
end)

RegisterServerEvent("mdt:performVehicleSearch")
AddEventHandler("mdt:performVehicleSearch", function(query)
	local usource = source
	local matches = {}
	exports['ghmattimysql']:execute("SELECT * FROM `bbvehicles` WHERE `plate` LIKE @query", {
		['@query'] = string.lower('%'..query..'%') -- % wildcard, needed to search for all alike results
	}, function(result)

		for index, data in ipairs(result) do
			local mods = result[1].mods ~= nil and json.decode(result[1].mods) or {}

			data.model = data.vehicle
			data.owner = data.citizenid
			if mods.color1 then
				data.color = colors[tostring(mods.color1)]
				if colors[tostring(mods.color2)] then
					data.color = colors[tostring(mods.color2)] .. " on " .. colors[tostring(mods.color1)]
				end
			end
			table.insert(matches, data)
		end

		TriggerClientEvent("mdt:returnVehicleSearchResults", usource, matches)
	end)
end)



RegisterServerEvent("mdt:performVehicleSearchInFront")
AddEventHandler("mdt:performVehicleSearchInFront", function(query)
	local usource = source
	local xPlayer = RLCore.Functions.GetPlayer(usource)
    if xPlayer.PlayerData.job.name == 'police' then
		exports['ghmattimysql']:execute("SELECT * FROM `bbvehicles` WHERE `plate` = @query", {
			['@query'] = query
		}, function(result)
			exports['ghmattimysql']:execute("SELECT * FROM (SELECT * FROM `mdt_reports` ORDER BY `id` DESC LIMIT 3) sub ORDER BY `id` DESC", {}, function(reports)
                for r = 1, #reports do
                    reports[r].charges = json.decode(reports[r].charges)
                end
                exports['ghmattimysql']:execute("SELECT * FROM (SELECT * FROM `mdt_warrants` ORDER BY `id` DESC LIMIT 3) sub ORDER BY `id` DESC", {}, function(warrants)
                    for w = 1, #warrants do
                        warrants[w].charges = json.decode(warrants[w].charges)
                    end
    
    
                    local officer = GetCharacterName(usource)
                    TriggerClientEvent('mdt:toggleVisibilty', usource, reports, warrants, officer)
                end)
            end)
			TriggerClientEvent("mdt:returnVehicleSearchInFront", usource, result, query)
		end)
	end
end)

RegisterServerEvent("mdt:getVehicle")
AddEventHandler("mdt:getVehicle", function(vehicle)
	local usource = source
	exports['ghmattimysql']:execute("SELECT * FROM `players` WHERE `citizenid` = @citizenid", {
		['@citizenid'] = vehicle.owner
	}, function(result)
		if result[1] then
			local charinfo = json.decode(result[1].charinfo)

			vehicle.owner = charinfo.firstname .. ' ' .. charinfo.lastname .. ' - ' .. result[1].citizenid
			vehicle.owner_id = result[1].id
		else
			vehicle.owner = 'Unknown'
			vehicle.owner_id = 0
		end

		TriggerClientEvent("mdt:returnVehicleDetails", usource, vehicle)
	end)
end)

RegisterServerEvent("mdt:getWarrants")
AddEventHandler("mdt:getWarrants", function()
	local usource = source
	exports['ghmattimysql']:execute("SELECT * FROM `mdt_warrants`", {}, function(warrants)
		for i = 1, #warrants do
			warrants[i].expire_time = ""
			warrants[i].charges = json.decode(warrants[i].charges)
		end
		TriggerClientEvent("mdt:returnWarrants", usource, warrants)
	end)
end)

RegisterServerEvent("mdt:submitNewWarrant")
AddEventHandler("mdt:submitNewWarrant", function(data)
	local usource = source
	data.charges = json.encode(data.charges)
	data.author = GetCharacterName(source)
	data.date = os.date('%m-%d-%Y %H:%M:%S', os.time())
	exports['ghmattimysql']:execute('INSERT INTO `mdt_warrants` (`name`, `char_id`, `report_id`, `report_title`, `charges`, `date`, `expire`, `notes`, `author`) VALUES (@name, @char_id, @report_id, @report_title, @charges, @date, @expire, @notes, @author)', {
		['@name']  = data.name,
		['@char_id'] = data.char_id,
		['@report_id'] = data.report_id,
		['@report_title'] = data.report_title,
		['@charges'] = data.charges,
		['@date'] = data.date,
		['@expire'] = data.expire,
		['@notes'] = data.notes,
		['@author'] = data.author
	}, function()
		TriggerClientEvent("mdt:completedWarrantAction", usource)
	end)
end)

RegisterServerEvent("mdt:deleteWarrant")
AddEventHandler("mdt:deleteWarrant", function(id)
	local usource = source
	exports['ghmattimysql']:execute('DELETE FROM `mdt_warrants` WHERE `id` = @id', {
		['@id']  = id
	}, function()
		TriggerClientEvent("mdt:completedWarrantAction", usource)
	end)
end)

RegisterServerEvent("mdt:getReportDetailsById")
AddEventHandler("mdt:getReportDetailsById", function(query, _source)
	if _source then source = _source end
	local usource = source
	exports['ghmattimysql']:execute("SELECT * FROM `mdt_reports` WHERE `id` = @query", {
		['@query'] = query
	}, function(result)
		if result and result[1] then
			result[1].charges = json.decode(result[1].charges)
			TriggerClientEvent("mdt:returnReportDetails", usource, result[1])
		end
	end)
end)

RegisterServerEvent("mdt:performForensicsSearch")
AddEventHandler("mdt:performForensicsSearch", function(query)
	local src = source
	local matches = {}
	exports['ghmattimysql']:execute("SELECT players.cid, players.citizenid, players.charinfo, user_mdt.fingerprint, user_mdt.notes FROM players INNER JOIN user_mdt ON players.citizenid = user_mdt.char_id", {
		['@query'] = string.lower('%'..query..'%') -- % wildcard, needed to search for all alike results
	}, function(result)

		for index, data in ipairs(result) do
			local charinfo = json.decode(tostring(data.charinfo))
			local shouldputintable = false
			local query2 = string.lower(query)
			local first = string.lower(charinfo.firstname)
			local last = string.lower(charinfo.lastname)
			local fingerprint = string.lower(data.fingerprint)
			local name = nil
			if first ~= '' and last ~= '' then
				name = first .. ' ' .. last
			end
			data.firstname = charinfo.firstname
			data.lastname = charinfo.lastname
			data.id = data.citizenid
			data.char_id = data.citizenid
			data.fingerprint = data.fingerprint
			if name ~= nil then
				if string.find(query2, name) then
					table.insert(matches, data)
				elseif string.find(query2, first) then
					table.insert(matches, data)
				elseif string.find(query2, last) then
					table.insert(matches, data)
				elseif string.find(query2, fingerprint) then
					table.insert(matches, data)
				end
			end
		end
		TriggerClientEvent("mdt:returnOffenderSearchResults", src, matches)
	end)
end)

function GetCharacterName(source)
	local Player = RLCore.Functions.GetPlayer(source)

	if Player then
		return Player['PlayerData']['charinfo']['firstname'] .. ' ' .. Player['PlayerData']['charinfo']['lastname']
	end

	return ""
end

function tprint (tbl, indent)
  if not indent then indent = 0 end
  local toprint = string.rep(" ", indent) .. "{\r\n"
  indent = indent + 2 
  for k, v in pairs(tbl) do
    toprint = toprint .. string.rep(" ", indent)
    if (type(k) == "number") then
      toprint = toprint .. "[" .. k .. "] = "
    elseif (type(k) == "string") then
      toprint = toprint  .. k ..  "= "   
    end
    if (type(v) == "number") then
      toprint = toprint .. v .. ",\r\n"
    elseif (type(v) == "string") then
      toprint = toprint .. "\"" .. v .. "\",\r\n"
    elseif (type(v) == "table") then
      toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
    else
      toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
    end
  end
  toprint = toprint .. string.rep(" ", indent-2) .. "}"
  return toprint
end

string.split = function(inputstr, sep)
	if sep == nil then
			sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return t
end