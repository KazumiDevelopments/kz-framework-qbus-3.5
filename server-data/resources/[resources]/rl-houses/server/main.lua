RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

Citizen.CreateThread(function()
	RLCore.Functions.ExecuteSql(false, "SELECT * FROM `houselocations`", function(result)
		if result[1] ~= nil then
			for k, v in pairs(result) do
				local owned = false
				if tonumber(v.owned) == 1 then
					owned = true
				end
				local garage = v.garage ~= nil and json.decode(v.garage) or {}
				Config.Houses[v.name] = {
					coords = json.decode(v.coords),
					owned = v.owned,
					price = v.price,
					locked = true,
					adress = v.label, 
					tier = v.tier,
					garage = garage,
					decorations = {},
				}
				Config.HouseGarages[v.name] = {
					label = v.label,
					takeVehicle = garage,
				}
			end
		end
		TriggerClientEvent("rl-garages:client:houseGarageConfig", -1, Config.HouseGarages)
		TriggerClientEvent("rl-houses:client:setHouseConfig", -1, Config.Houses)
	end)
end)

local houseowneridentifier = {}
local houseownercid = {}
local housekeyholders = {}

RegisterServerEvent('rl-houses:server:setHouses')
AddEventHandler('rl-houses:server:setHouses', function()
	local src = source
	TriggerClientEvent("rl-houses:client:setHouseConfig", src, Config.Houses)
	TriggerClientEvent("rl-garages:client:houseGarageConfig", -1, Config.HouseGarages)
end)

RegisterServerEvent('rl-houses:server:addNewHouse')
AddEventHandler('rl-houses:server:addNewHouse', function(street, coords, price, tier)
	local src = source
	local street = street:gsub("%'", "")
	local price = tonumber(price)
	local tier = tonumber(tier)
	local houseCount = GetHouseStreetCount(street)
	local name = street:lower() .. tostring(houseCount)
	local label = street .. " " .. tostring(houseCount)
	
	RLCore.Functions.ExecuteSql(false, "INSERT INTO `houselocations` (`name`, `label`, `coords`, `owned`, `price`, `tier`) VALUES ('"..name.."', '"..label.."', '"..json.encode(coords).."', 0,"..price..", "..tier..")")
	Config.Houses[name] = {
		coords = coords,
		owned = false,
		price = price,
		locked = true,
		adress = label, 
		tier = tier,
		garage = {},
		decorations = {},
	}
	TriggerClientEvent("rl-houses:client:setHouseConfig", -1, Config.Houses)
	TriggerClientEvent('RLCore:Notify', src, "You have added a house: "..label)
end)

RegisterServerEvent('rl-houses:server:addGarage')
AddEventHandler('rl-houses:server:addGarage', function(house, coords)
	local src = source
	RLCore.Functions.ExecuteSql(false, "UPDATE `houselocations` SET `garage` = '"..json.encode(coords).."' WHERE `name` = '"..house.."'")
	Config.HouseGarages[house] = {
		label = Config.Houses[house].adress,
		takeVehicle = coords,
	}
	TriggerClientEvent("rl-garages:client:addHouseGarage", -1, house, Config.HouseGarages[house])
	TriggerClientEvent('RLCore:Notify', src, "You have added a garage to: "..Config.HouseGarages[house].label)
end)

RegisterServerEvent('rl-houses:server:viewHouse')
AddEventHandler('rl-houses:server:viewHouse', function(house)
	local pData 		= RLCore.Functions.GetPlayer(source)
	local houseprice   	= Config.Houses[house].price 
	local brokerfee 	= (houseprice / 100 * 5)
	local bankfee 		= (houseprice / 100 * 10)  
	local taxes 		= (houseprice / 100 * 6)

	TriggerClientEvent('rl-houses:client:viewHouse', source, houseprice, brokerfee, bankfee, taxes, pData.PlayerData.charinfo.firstname, pData.PlayerData.charinfo.lastname)
end)

RegisterServerEvent('rl-houses:server:buyHouse')
AddEventHandler('rl-houses:server:buyHouse', function(house)
	local src     	= source
	local pData 	= RLCore.Functions.GetPlayer(src)
	local price   	= Config.Houses[house].price
	local HousePrice = math.ceil(price * 1.21)
	local bankBalance = pData.PlayerData.money["bank"]

	if (bankBalance >= HousePrice) then
		houseowneridentifier[house] = pData.PlayerData.steam
		houseownercid[house] = pData.PlayerData.citizenid
		housekeyholders[house] = {}
		housekeyholders[house][1] = pData.PlayerData.citizenid

		RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_houses` (`house`, `identifier`, `citizenid`, `keyholders`) VALUES ('"..house.."', '"..pData.PlayerData.steam.."', '"..pData.PlayerData.citizenid.."', '"..json.encode(housekeyholders[house]).."')")

		RLCore.Functions.ExecuteSql(true, "UPDATE `houselocations` SET `owned` = 1 WHERE `name` = '"..house.."'")
		TriggerClientEvent('rl-houses:client:SetClosestHouse', src)
		pData.Functions.RemoveMoney('bank', HousePrice, "bought-house") -- 21% Extra house costs
		print(HousePrice)
        TriggerEvent("bb-bossmenu:server:addAccountMoney", "realestate", (HousePrice / 100) * math.random(18, 25))
        TriggerEvent('bb-garages:server:buyHouseGarage', house, pData.PlayerData.citizenid, src)
	else
		TriggerClientEvent('RLCore:Notify', source, "You do not have enough money..", "error")
	end
end)

RegisterServerEvent('rl-houses:server:lockHouse')
AddEventHandler('rl-houses:server:lockHouse', function(bool, house)
	TriggerClientEvent('rl-houses:client:lockHouse', -1, bool, house)
end)

RegisterServerEvent('rl-houses:server:SetRamState')
AddEventHandler('rl-houses:server:SetRamState', function(bool, house)
	Config.Houses[house].IsRaming = bool
	TriggerClientEvent('rl-houses:server:SetRamState', -1, bool, house)
end)

--------------------------------------------------------------

--------------------------------------------------------------

RLCore.Functions.CreateCallback('rl-houses:server:hasKey', function(source, cb, house)
	local Player = RLCore.Functions.GetPlayer(source)
	local retval = false
	if Player ~= nil then 
		local identifier = Player.PlayerData.steam
		local CharId = Player.PlayerData.citizenid
		if hasKey(identifier, CharId, house) then
			retval = true
		else
			retval = false
		end
	end
	if Player.PlayerData.job.name == "realestate" then
		cb(true)
		return
	end 

	--[[ if RLCore.Functions.HasPermission(src, 'god') then 
		cb(true)
		return
	end ]]
	
	cb(retval)
end)

RLCore.Functions.CreateCallback('rl-houses:server:isOwned', function(source, cb, house)
	if houseowneridentifier[house] ~= nil and houseownercid[house] ~= nil then
		cb(true)
	else
		if RLCore.Functions.HasPermission(source, 'god') then
			cb(true)
			return
		end
		cb(false)
	end
end)

RLCore.Functions.CreateCallback('rl-houses:server:getHouseOwner', function(source, cb, house)
	cb(houseownercid[house])
end)

RLCore.Functions.CreateCallback('rl-houses:server:getHouseKeyHolders', function(source, cb, house)
	local retval = {}
	local Player = RLCore.Functions.GetPlayer(source)
	if housekeyholders[house] ~= nil then 
		for i = 1, #housekeyholders[house], 1 do
			if Player.PlayerData.citizenid ~= housekeyholders[house][i] then
				RLCore.Functions.ExecuteSql(false, "SELECT `charinfo` FROM `players` WHERE `citizenid` = '"..housekeyholders[house][i].."'", function(result)
					if result[1] ~= nil then 
						local charinfo = json.decode(result[1].charinfo)
						table.insert(retval, {
							firstname = charinfo.firstname,
							lastname = charinfo.lastname,
							citizenid = housekeyholders[house][i],
						})
					end
					cb(retval)
				end)
			end
		end
	else
		cb(nil)
	end
end)

function hasKey(identifier, cid, house)
	if houseowneridentifier[house] ~= nil and houseownercid[house] ~= nil then
		if houseowneridentifier[house] == identifier and houseownercid[house] == cid then
			return true
		else
			if housekeyholders[house] ~= nil then 
				for i = 1, #housekeyholders[house], 1 do
					if housekeyholders[house][i] == cid then
						return true
					end
				end
			end
		end
	end
	return false
end

function getOfflinePlayerData(citizenid)
	exports['ghmattimysql']:execute("SELECT `charinfo` FROM `players` WHERE `citizenid` = '"..citizenid.."'", function(result)
		Citizen.Wait(100)
		if result[1] ~= nil then 
			local charinfo = json.decode(result[1].charinfo)
			return charinfo
		else
			return nil
		end
	end)
end

RegisterServerEvent('rl-houses:server:giveKey')
AddEventHandler('rl-houses:server:giveKey', function(house, target)
	local pData = RLCore.Functions.GetPlayer(target)

	table.insert(housekeyholders[house], pData.PlayerData.citizenid)
    RLCore.Functions.ExecuteSql(false, "UPDATE `player_houses` SET `keyholders` = '"..json.encode(housekeyholders[house]).."' WHERE `house` = '"..house.."'")
    TriggerEvent('bb-garages:server:updateHouseAccess', housekeyholders[house], house)
end)

RegisterServerEvent('rl-houses:server:removeHouseKey')
AddEventHandler('rl-houses:server:removeHouseKey', function(house, citizenData)
	local src = source
	local newHolders = {}
	if housekeyholders[house] ~= nil then 
		for k, v in pairs(housekeyholders[house]) do
			if housekeyholders[house][k] ~= citizenData.citizenid then
				table.insert(newHolders, housekeyholders[house][k])
			end
		end
	end
	housekeyholders[house] = newHolders
	TriggerClientEvent('RLCore:Notify', src, citizenData.firstname .. " " .. citizenData.lastname .. "'s keys removed.", 'error', 3500)
    RLCore.Functions.ExecuteSql(false, "UPDATE `player_houses` SET `keyholders` = '"..json.encode(housekeyholders[house]).."' WHERE `house` = '"..house.."'")
    TriggerEvent('bb-garages:server:updateHouseAccess', housekeyholders[house], house)
end)

RLCore.Functions.CreateCallback('rl-phone:server:TransferCid', function(source, cb, NewCid, house)
	RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` = '"..NewCid.."'", function(result)
		if result[1] ~= nil then
			local HouseName = house.name
			housekeyholders[HouseName] = {}
			housekeyholders[HouseName][1] = NewCid
			houseownercid[HouseName] = NewCid
			houseowneridentifier[HouseName] = result[1].steam

			RLCore.Functions.ExecuteSql(false, "UPDATE `player_houses` SET citizenid='"..NewCid.."', keyholders='"..json.encode(housekeyholders[HouseName]).."', identifier='"..result[1].steam.."' WHERE `house` = '"..HouseName.."'")
			cb(true)
		else
			cb(false)
		end
	end)
end)

function typeof(var)
    local _type = type(var);
    if(_type ~= "table" and _type ~= "userdata") then
        return _type;
    end
    local _meta = getmetatable(var);
    if(_meta ~= nil and _meta._NAME ~= nil) then
        return _meta._NAME;
    else
        return _type;
    end
end

local housesLoaded = false

Citizen.CreateThread(function()
	while true do
		if not housesLoaded then
			exports['ghmattimysql']:execute('SELECT * FROM player_houses', function(houses)
				if houses ~= nil then
					for _,house in pairs(houses) do
						houseowneridentifier[house.house] = house.identifier
						houseownercid[house.house] = house.citizenid
						housekeyholders[house.house] = json.decode(house.keyholders)
					end
				end
			end)
			housesLoaded = true
		end
		Citizen.Wait(7)
	end
end)

RegisterServerEvent('rl-houses:server:OpenDoor')
AddEventHandler('rl-houses:server:OpenDoor', function(target, house)
    local src = source
    local OtherPlayer = RLCore.Functions.GetPlayer(target)
    if OtherPlayer ~= nil then
        TriggerClientEvent('rl-houses:client:SpawnInApartment', OtherPlayer.PlayerData.source, house)
    end
end)

RegisterServerEvent('rl-houses:server:RingDoor')
AddEventHandler('rl-houses:server:RingDoor', function(house)
    local src = source
    TriggerClientEvent('rl-houses:client:RingDoor', -1, src, house)
end)

RegisterServerEvent('rl-houses:server:savedecorations')
AddEventHandler('rl-houses:server:savedecorations', function(house, decorations)
	local src = source
	RLCore.Functions.ExecuteSql(false, "UPDATE `player_houses` SET `decorations` = '"..json.encode(decorations).."' WHERE `house` = '"..house.."'")
	TriggerClientEvent("rl-houses:server:sethousedecorations", -1, house, decorations)
end)

RLCore.Functions.CreateCallback('rl-houses:server:getHouseDecorations', function(source, cb, house)
	local retval = nil
	RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_houses` WHERE `house` = '"..house.."'", function(result)
		if result[1] ~= nil then
			if result[1].decorations ~= nil then
				retval = json.decode(result[1].decorations)
			end
		end
		cb(retval)
	end)
end)

RLCore.Functions.CreateCallback('rl-houses:server:getHouseLocations', function(source, cb, house)
	local retval = nil
	RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_houses` WHERE `house` = '"..house.."'", function(result)
		if result[1] ~= nil then
			retval = result[1]
		end
		cb(retval)
	end)
end)

RLCore.Functions.CreateCallback('rl-houses:server:getHouseKeys', function(source, cb)
	local src = source
	local pData = RLCore.Functions.GetPlayer(src)
	local cid = pData.PlayerData.citizenid
end)

function mysplit (inputstr, sep)
	if sep == nil then
			sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return t
end

RLCore.Functions.CreateCallback('rl-houses:server:getOwnedHouses', function(source, cb)
	local src = source
	local pData = RLCore.Functions.GetPlayer(src)

	if pData then
		exports['ghmattimysql']:execute('SELECT * FROM player_houses WHERE identifier = @identifier AND citizenid = @citizenid', {['@identifier'] = pData.PlayerData.steam, ['@citizenid'] = pData.PlayerData.citizenid}, function(houses)
			local ownedHouses = {}

			for i=1, #houses, 1 do
				table.insert(ownedHouses, houses[i].house)
			end

			if houses ~= nil then
				cb(ownedHouses)
			else
				cb(nil)
			end
		end)
	end
end)

RLCore.Functions.CreateCallback('rl-houses:server:getSavedOutfits', function(source, cb)
	local src = source
	local pData = RLCore.Functions.GetPlayer(src)

	if pData then
		exports['ghmattimysql']:execute('SELECT * FROM player_outfits WHERE citizenid = @citizenid', {['@citizenid'] = pData.PlayerData.citizenid}, function(result)
			if result[1] ~= nil then
				cb(result)
			else
				cb(nil)
			end
		end)
	end
end)

RLCore.Commands.Add("decorate", "Decorate your cottage :)", {}, false, function(source, args)
	TriggerClientEvent("rl-houses:client:decorate", source)
end)

function GetHouseStreetCount(street)
	local count = 1
	RLCore.Functions.ExecuteSql(true, "SELECT * FROM `houselocations` WHERE `name` LIKE '%"..street.."%'", function(result)
		if result[1] ~= nil then 
			for i = 1, #result, 1 do
				count = count + 1
			end
		end
		return count
	end)
	return count
end

RegisterServerEvent('rl-houses:server:LogoutLocation')
AddEventHandler('rl-houses:server:LogoutLocation', function()
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	local MyItems = Player.PlayerData.items
	RLCore.Functions.ExecuteSql(true, "UPDATE `players` SET `inventory` = '"..RLCore.EscapeSqli(json.encode(MyItems)).."' WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'")
	RLCore.Player.Logout(src)
	TriggerClientEvent("rl-hud-player:client:SpawnedIn", src, false)
    TriggerClientEvent('bb-multicharacter:client:chooseChar', src)
end)

RegisterServerEvent('rl-houses:server:giveHouseKey')
AddEventHandler('rl-houses:server:giveHouseKey', function(target, house)
	local src = source
	local tPlayer = RLCore.Functions.GetPlayer(target)
	
	if tPlayer ~= nil then
		if housekeyholders[house] ~= nil then
			for _, cid in pairs(housekeyholders[house]) do
				if cid == tPlayer.PlayerData.citizenid then
					TriggerClientEvent('RLCore:Notify', src, 'This person already has the keys to this house!', 'error', 3500)
					return
				end
			end		
			table.insert(housekeyholders[house], tPlayer.PlayerData.citizenid)
			RLCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `keyholders` = '"..json.encode(housekeyholders[house]).."' WHERE `house` = '"..house.."'")
			TriggerClientEvent('rl-houses:client:refreshHouse', tPlayer.PlayerData.source)
			TriggerClientEvent('RLCore:Notify', tPlayer.PlayerData.source, 'You have the keys '..Config.Houses[house].adress..' receive!', 'success', 2500)
		else
			local sourceTarget = RLCore.Functions.GetPlayer(src)
			housekeyholders[house] = {
				[1] = sourceTarget.PlayerData.citizenid
			}
			table.insert(housekeyholders[house], tPlayer.PlayerData.citizenid)
			RLCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `keyholders` = '"..json.encode(housekeyholders[house]).."' WHERE `house` = '"..house.."'")
			TriggerClientEvent('rl-houses:client:refreshHouse', tPlayer.PlayerData.source)
			TriggerClientEvent('RLCore:Notify', tPlayer.PlayerData.source, 'The keys to '..Config.Houses[house].adress..' receive!', 'success', 2500)
		end
	else
		TriggerClientEvent('RLCore:Notify', src, 'Something went wrong. Please try again!', 'error', 2500)
	end
end)

RegisterServerEvent('test:test')
AddEventHandler('test:test', function(msg)
	print(msg)
end)

RegisterServerEvent('rl-houses:server:setLocation')
AddEventHandler('rl-houses:server:setLocation', function(coords, house, type)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)

	if type == 1 then
		RLCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `stash` = '"..json.encode(coords).."' WHERE `house` = '"..house.."'")
	elseif type == 2 then
		RLCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `outfit` = '"..json.encode(coords).."' WHERE `house` = '"..house.."'")
	elseif type == 3 then
		RLCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `logout` = '"..json.encode(coords).."' WHERE `house` = '"..house.."'")
	end

	TriggerClientEvent('rl-houses:client:refreshLocations', -1, house, json.encode(coords), type)
end)

RLCore.Commands.Add("createhouse", "Create a house (Realestate Agent)", {{name="price", help="Price of the house"},{name="tier", help="Name of the item (no label)"}}, true, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
	local price = tonumber(args[1])
	local tier = tonumber(args[2])
	if Player.PlayerData.job.name == "realestate" then
		if price >= Config.MinAmounts[tostring(tier)] then
			TriggerClientEvent("rl-houses:client:createHouses", source, price, tier)
		else
			TriggerClientEvent('RLCore:Notify', source, "The min price of tier " .. tostring(tier) .. ' is ' .. tostring(Config.MinAmounts[tostring(tier)]) .. '$', "error")
		end
	end
end)

RLCore.Commands.Add("addgarage", "Add garage to nearest house", {}, false, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
	if Player.PlayerData.job.name == "realestate" then
		TriggerClientEvent("rl-houses:client:addGarage", source)
	end
end)

RegisterServerEvent('rl-houses:server:SetInsideMeta')
AddEventHandler('rl-houses:server:SetInsideMeta', function(insideId, bool)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local insideMeta = Player.PlayerData.metadata["inside"]

    if bool then
        insideMeta.apartment.apartmentType = nil
        insideMeta.apartment.apartmentId = nil
        insideMeta.house = insideId

        Player.Functions.SetMetaData("inside", insideMeta)
    else
        insideMeta.apartment.apartmentType = nil
        insideMeta.apartment.apartmentId = nil
        insideMeta.house = nil

        Player.Functions.SetMetaData("inside", insideMeta)
    end
end)

RLCore.Functions.CreateCallback('rl-phone:server:GetPlayerHouses', function(source, callback)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	local MyHouses = {}
	local cb = callback

	RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_houses` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(result)
		if result[1] ~= nil then
			for k, v in pairs(result) do
				table.insert(MyHouses, {
					name = v.house,
					keyholders = {},
					owner = Player.PlayerData.citizenid,
					price = Config.Houses[v.house].price,
					label = Config.Houses[v.house].adress,
					tier = Config.Houses[v.house].tier,
					garage = Config.Houses[v.house].garage,
				})

				if v.keyholders ~= "null" then
					v.keyholders = json.decode(v.keyholders)
					if v.keyholders ~= nil then
						for f, data in pairs(v.keyholders) do
							RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` = '"..data.."'", function(keyholderdata)
								if keyholderdata[1] ~= nil then
									keyholderdata[1].charinfo = json.decode(keyholderdata[1].charinfo)
									table.insert(MyHouses[k].keyholders, keyholderdata[1])
								end
							end)
						end
					else
						MyHouses[k].keyholders[1] = Player.PlayerData
					end
				else
					MyHouses[k].keyholders[1] = Player.PlayerData
				end
			end
				
			cb(MyHouses)
		else
			cb({})
		end
	end)
end)

RLCore.Functions.CreateCallback('rl-phone:server:GetHouseKeys', function(source, cb)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	local MyKeys = {}

	RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_houses`", function(result)
		for k, v in pairs(result) do
			if v.keyholders ~= "null" then
				v.keyholders = json.decode(v.keyholders)
				for s, p in pairs(v.keyholders) do
					if p == Player.PlayerData.citizenid and (v.citizenid ~= Player.PlayerData.citizenid) then
						table.insert(MyKeys, {
							HouseData = Config.Houses[v.house]
						})
					end
				end
			end

			if v.citizenid == Player.PlayerData.citizenid then
				table.insert(MyKeys, {
					HouseData = Config.Houses[v.house]
				})
			end
		end

		cb(MyKeys)
	end)
end)

function escape_sqli(source)
    local replacements = { ['"'] = '\\"', ["'"] = "\\'" }
    return source:gsub( "['\"]", replacements ) -- or string.gsub( source, "['\"]", replacements )
end

RLCore.Functions.CreateCallback('rl-phone:server:MeosGetPlayerHouses', function(source, cb, input)
	local src = source
	if input ~= nil then
		local search = escape_sqli(input)
		local searchData = {}
		
			RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `players` WHERE `citizenid` = "'..search..'" OR `charinfo` LIKE "%'..search..'%"', function(result)
				if result[1] ~= nil then
					RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_houses` WHERE `citizenid` = '"..result[1].citizenid.."'", function(houses)
						if houses[1] ~= nil then
								for k, v in pairs(houses) do
									if Config.Houses[v.house].tier ~= 8 then
										table.insert(searchData, {
											name = v.house,
											keyholders = keyholders,
											owner = v.citizenid,
											price = Config.Houses[v.house].price,
											label = Config.Houses[v.house].adress,
											tier = Config.Houses[v.house].tier,
											garage = Config.Houses[v.house].garage,
											charinfo = json.decode(result[1].charinfo),
											coords = {
												x = Config.Houses[v.house].coords.enter.x,
												y = Config.Houses[v.house].coords.enter.y,
												z = Config.Houses[v.house].coords.enter.z,
											}
										})
									end
								end
							
							cb(searchData)
						end
					end)
				else
					cb(nil)
				end
			end)
		
	else
		cb(nil)
	end
end)

RLCore.Functions.CreateUseableItem("police_stormram", function(source, item)
	local Player = RLCore.Functions.GetPlayer(source)

	if Player.PlayerData.job.name == "police" then
		TriggerClientEvent("rl-houses:client:HomeInvasion", source)
	else
		TriggerClientEvent('RLCore:Notify', source, "This is only possible for emergency services!", "error")
	end
end)

RegisterServerEvent('rl-houses:server:SetHouseRammed')
AddEventHandler('rl-houses:server:SetHouseRammed', function(bool, house)
	Config.Houses[house].IsRammed = bool
	TriggerClientEvent('rl-houses:client:SetHouseRammed', -1, bool, house)
end)

RLCore.Commands.Add("enter", "Enter house.", {}, false, function(source, args)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
	
	if RLCore.Functions.HasPermission(src, 'god') then
		TriggerClientEvent('rl-houses:client:EnterHouse', src, true)
	else
		TriggerClientEvent('rl-houses:client:EnterHouse', src, false)
	end
end)

RLCore.Commands.Add("ring", "Ring the bell at home.", {}, false, function(source, args)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
 
    TriggerClientEvent('rl-houses:client:RequestRing', src)
end)

local DoorLocked = true
RegisterServerEvent('rl-houses:server:doorState')
AddEventHandler('rl-houses:server:doorState', function(bool)
	if bool == nil then
		TriggerClientEvent('rl-houses:client:doorState', source, DoorLocked)
		return
	end

	DoorLocked = bool
	TriggerClientEvent('rl-houses:client:doorState', -1, DoorLocked)
end)