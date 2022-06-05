local RLCore = exports['rl-core']:GetCoreObject()
local houseowneridentifier = {}
local houseownercid = {}
local housekeyholders = {}
local housesLoaded = false

-- Threads

CreateThread(function()
    local HouseGarages = {}
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `houselocations`", function(result)
        if result[1] then
            for k, v in pairs(result) do
                local owned = false
                if tonumber(v.owned) == 1 then
                    owned = true
                end
                local garage = json.decode(v.garage) or {}
                Config.Houses[v.name] = {
                    coords = json.decode(v.coords),
                    owned = v.owned,
                    price = v.price,
                    locked = true,
                    adress = v.label,
                    tier = v.tier,
                    garage = garage,
                    decorations = {}
                }
                HouseGarages[v.name] = {
                    label = v.label,
                    takeVehicle = garage
                }
            end
        end
    end)
    TriggerClientEvent("qb-garages:client:houseGarageConfig", -1, HouseGarages)
    TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Config.Houses)
end)

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

-- Commands

RLCore.Commands.Add("decorate", Lang:t("info.decorate_interior"), {}, false, function(source)
    local src = source
    TriggerClientEvent("qb-houses:client:decorate", src)
end)

RLCore.Commands.Add("createhouse", Lang:t("info.create_house"), {{name = "price", help = Lang:t("info.price_of_house")}, {name = "tier", help = Lang:t("info.tier_number")}}, true, function(source, args)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local price = tonumber(args[1])
    local tier = tonumber(args[2])
    if Player.PlayerData.job.name == "realestate" then
        TriggerClientEvent("qb-houses:client:createHouses", src, price, tier)
    else
        TriggerClientEvent('RLCore:Notify', src, Lang:t("error.realestate_only"), "error")
    end
end)

RLCore.Commands.Add("addgarage", Lang:t('info.add_garage'), {}, false, function(source)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "realestate" then
        TriggerClientEvent("qb-houses:client:addGarage", src)
    else
        TriggerClientEvent('RLCore:Notify', src, Lang:t("error.realestate_only"), "error")
    end
end)

RLCore.Commands.Add("ring", Lang:t("info.ring_doorbell"), {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-houses:client:RequestRing', src)
end)

-- Item

RLCore.Functions.CreateUseableItem("police_stormram", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
    if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
        TriggerClientEvent("qb-houses:client:HomeInvasion", source)
    else
        TriggerClientEvent('RLCore:Notify', source, Lang:t("error.emergency_services"), "error")
    end
end)

-- Functions

local function hasKey(identifier, cid, house)
    if houseowneridentifier[house] and houseownercid[house] then
        if houseowneridentifier[house] == identifier and houseownercid[house] == cid then
            return true
        else
            if housekeyholders[house] then
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

exports('hasKey', hasKey)

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

local function isHouseOwned(house)
    exports['ghmattimysql']:execute('SELECT owned FROM houselocations WHERE name = @name', {['@name'] = house}, function(result)
        if result[1] then
            if result[1].owned == 1 then
                return true
            end
        end
    end)
    return false
end

local function escape_sqli(source)
    local replacements = {
        ['"'] = '\\"',
        ["'"] = "\\'"
    }
    return source:gsub("['\"]", replacements)
end

-- Events

RegisterNetEvent('qb-houses:server:setHouses', function()
    local src = source
    TriggerClientEvent("qb-houses:client:setHouseConfig", src, Config.Houses)
end)

RegisterNetEvent('qb-houses:server:createBlip', function()
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    TriggerClientEvent("qb-houses:client:createBlip", -1, coords)
end)

RegisterNetEvent('qb-houses:server:addNewHouse', function(street, coords, price, tier)
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
    TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Config.Houses)
    TriggerClientEvent('RLCore:Notify', src, Lang:t("info.added_house", {value = label}))
    TriggerEvent('qb-log:server:CreateLog', 'house', Lang:t("log.house_created"), 'green', Lang:t("log.house_address", {label = label, price = price, tier = tier, agent = GetPlayerName(src)}))
end)

RegisterNetEvent('qb-houses:server:addGarage', function(house, coords)
    local src = source
    RLCore.Functions.ExecuteSql(false, "UPDATE `houselocations` SET `garage` = '"..json.encode(coords).."' WHERE `name` = '"..house.."'")
    local garageInfo = {
        label = Config.Houses[house].adress,
        takeVehicle = coords
    }
    TriggerClientEvent("qb-garages:client:addHouseGarage", -1, house, garageInfo)
    TriggerClientEvent('RLCore:Notify', src, Lang:t("info.added_garage", {value = garageInfo.label}))
end)

RegisterNetEvent('qb-houses:server:viewHouse', function(house)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)

    local houseprice = Config.Houses[house].price
    local brokerfee = (houseprice / 100 * 5)
    local bankfee = (houseprice / 100 * 10)
    local taxes = (houseprice / 100 * 6)

    TriggerClientEvent('qb-houses:client:viewHouse', src, houseprice, brokerfee, bankfee, taxes,
        pData.PlayerData.charinfo.firstname, pData.PlayerData.charinfo.lastname)
end)

RegisterNetEvent('qb-houses:server:buyHouse', function(house)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)
    local price = Config.Houses[house].price
    local HousePrice = math.ceil(price * 1.21)
    local bankBalance = pData.PlayerData.money["bank"]

    local isOwned = isHouseOwned(house)
    if isOwned then
        TriggerClientEvent('RLCore:Notify', src, Lang:t("error.already_owned"), "error")
        CancelEvent()
        return
    end

    if (bankBalance >= HousePrice) then
        houseowneridentifier[house] = pData.PlayerData.license
        houseownercid[house] = pData.PlayerData.citizenid
        housekeyholders[house] = {
            [1] = pData.PlayerData.citizenid
        }
        RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_houses` (`house`, `identifier`, `citizenid`, `keyholders`) VALUES ('"..house.."', '"..pData.PlayerData.steam.."', '"..pData.PlayerData.citizenid.."', '"..json.encode(housekeyholders[house]).."')")

		RLCore.Functions.ExecuteSql(true, "UPDATE `houselocations` SET `owned` = 1 WHERE `name` = '"..house.."'")
		TriggerClientEvent('qb-houses:client:SetClosestHouse', src)
        pData.Functions.RemoveMoney('bank', HousePrice, "bought-house") -- 21% Extra house costs
        TriggerEvent('qb-bossmenu:server:addAccountMoney', "realestate", (HousePrice / 100) * math.random(18, 25))
        TriggerEvent('qb-log:server:CreateLog', 'house', Lang:t("log.house_purchased"), 'green', Lang:t("log.house_purchased_by", {house = house:upper(), price = HousePrice, firstname = pData.PlayerData.charinfo.firstname, lastname = pData.PlayerData.charinfo.lastname}))
    else
        TriggerClientEvent('RLCore:Notify', source, Lang:t("error.not_enough_money"), "error")
    end
end)

RegisterNetEvent('qb-houses:server:lockHouse', function(bool, house)
    TriggerClientEvent('qb-houses:client:lockHouse', -1, bool, house)
end)

RegisterNetEvent('qb-houses:server:SetRamState', function(bool, house)
    Config.Houses[house].IsRaming = bool
    TriggerClientEvent('qb-houses:server:SetRamState', -1, bool, house)
end)

RegisterNetEvent('qb-houses:server:giveKey', function(house, target)
    local pData = RLCore.Functions.GetPlayer(target)
    housekeyholders[house][#housekeyholders[house]+1] = pData.PlayerData.citizenid
    MySQL.Async.execute('UPDATE player_houses SET keyholders = ? WHERE house = ?',
        {json.encode(housekeyholders[house]), house})
end)

RegisterNetEvent('qb-houses:server:removeHouseKey', function(house, citizenData)
    local src = source
    local newHolders = {}
    if housekeyholders[house] then
        for k, v in pairs(housekeyholders[house]) do
            if housekeyholders[house][k] ~= citizenData.citizenid then
                newHolders[#newHolders+1] = housekeyholders[house][k]
            end
        end
    end
    housekeyholders[house] = newHolders
    TriggerClientEvent('RLCore:Notify', src, Lang:t("error.remove_key_from", {firstname = citizenData.firstname, lastname = citizenData.lastname}), 'error')
    RLCore.Functions.ExecuteSql(false, "UPDATE `player_houses` SET `keyholders` = '"..json.encode(housekeyholders[house]).."' WHERE `house` = '"..house.."'")
end)

RegisterNetEvent('qb-houses:server:OpenDoor', function(target, house)
    local OtherPlayer = RLCore.Functions.GetPlayer(target)
    if OtherPlayer then
        TriggerClientEvent('qb-houses:client:SpawnInApartment', OtherPlayer.PlayerData.source, house)
    end
end)

RegisterNetEvent('qb-houses:server:RingDoor', function(house)
    local src = source
    TriggerClientEvent('qb-houses:client:RingDoor', -1, src, house)
end)

RegisterNetEvent('qb-houses:server:savedecorations', function(house, decorations)
    RLCore.Functions.ExecuteSql(false, "UPDATE `player_houses` SET `decorations` = '"..json.encode(decorations).."' WHERE `house` = '"..house.."'")
	TriggerClientEvent("qb-houses:server:sethousedecorations", -1, house, decorations)
end)

RegisterNetEvent('qb-houses:server:LogoutLocation', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local MyItems = Player.PlayerData.items
    RLCore.Functions.ExecuteSql(true, "UPDATE `players` SET `inventory` = '"..RLCore.EscapeSqli(json.encode(MyItems)).."' WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'")
	RLCore.Player.Logout(src)
    TriggerClientEvent('bb-multicharacter:client:chooseChar', src)
end)

RegisterNetEvent('qb-houses:server:giveHouseKey', function(target, house)
    local src = source
    local tPlayer = RLCore.Functions.GetPlayer(target)
    if tPlayer then
        if housekeyholders[house] then
            for _, cid in pairs(housekeyholders[house]) do
                if cid == tPlayer.PlayerData.citizenid then
                    TriggerClientEvent('RLCore:Notify', src, Lang:t("error.already_keys"), 'error', 3500)
                    return
                end
            end
            housekeyholders[house][#housekeyholders[house]+1] = tPlayer.PlayerData.citizenid
            RLCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `keyholders` = '"..json.encode(housekeyholders[house]).."' WHERE `house` = '"..house.."'")
            TriggerClientEvent('qb-houses:client:refreshHouse', tPlayer.PlayerData.source)

            TriggerClientEvent('RLCore:Notify', tPlayer.PlayerData.source, Lang:t("success.recieved_key", {value = Config.Houses[house].adress}), 'success', 2500)
        else
            local sourceTarget = RLCore.Functions.GetPlayer(src)
            housekeyholders[house] = {
                [1] = sourceTarget.PlayerData.citizenid
            }
            housekeyholders[house][#housekeyholders[house]+1] = tPlayer.PlayerData.citizenid
            RLCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `keyholders` = '"..json.encode(housekeyholders[house]).."' WHERE `house` = '"..house.."'")
            TriggerClientEvent('qb-houses:client:refreshHouse', tPlayer.PlayerData.source)
            TriggerClientEvent('RLCore:Notify', tPlayer.PlayerData.source, Lang:t("success.recieved_key", {value = Config.Houses[house].adress}), 'success', 2500)
        end
    else
        TriggerClientEvent('RLCore:Notify', src, Lang:t("error.something_wrong"), 'error', 2500)
    end
end)

RegisterNetEvent('qb-houses:server:setLocation', function(coords, house, type)
    if type == 1 then
		RLCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `stash` = '"..json.encode(coords).."' WHERE `house` = '"..house.."'")
	elseif type == 2 then
		RLCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `outfit` = '"..json.encode(coords).."' WHERE `house` = '"..house.."'")
	elseif type == 3 then
		RLCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `logout` = '"..json.encode(coords).."' WHERE `house` = '"..house.."'")
	end
    TriggerClientEvent('qb-houses:client:refreshLocations', -1, house, json.encode(coords), type)
end)

RegisterNetEvent('qb-houses:server:SetHouseRammed', function(bool, house)
    Config.Houses[house].IsRammed = bool
    TriggerClientEvent('qb-houses:client:SetHouseRammed', -1, bool, house)
end)

RegisterNetEvent('qb-houses:server:SetInsideMeta', function(insideId, bool)
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

-- Callbacks

RLCore.Functions.CreateCallback('qb-houses:server:buyFurniture', function(source, cb, price)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)
    local bankBalance = pData.PlayerData.money["bank"]

    if bankBalance >= price then
        pData.Functions.RemoveMoney('bank', price, "bought-furniture")
        cb(true)
    else
        TriggerClientEvent('RLCore:Notify', src, Lang:t("error.not_enough_money"), "error")
        cb(false)
    end
end)

RLCore.Functions.CreateCallback('qb-houses:server:ProximityKO', function(source, cb, house)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local retvalK = false
    local retvalO = false

    if Player then
        local identifier = Player.PlayerData.license
        local CharId = Player.PlayerData.citizenid
        if hasKey(identifier, CharId, house) then
            retvalK = true
        elseif Player.PlayerData.job.name == "realestate" then
            retvalK = true
        else
            retvalK = false
        end
    end

    if houseowneridentifier[house] and houseownercid[house] then
        retvalO = true
    else
        retvalO = false
    end

    cb(retvalK, retvalO)
end)

RLCore.Functions.CreateCallback('qb-houses:server:hasKey', function(source, cb, house)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local retval = false
    if Player then
        local identifier = Player.PlayerData.license
        local CharId = Player.PlayerData.citizenid
        if hasKey(identifier, CharId, house) then
            retval = true
        elseif Player.PlayerData.job.name == "realestate" then
            retval = true
        else
            retval = false
        end
    end

    cb(retval)
end)

RLCore.Functions.CreateCallback('qb-houses:server:isOwned', function(source, cb, house)
    if houseowneridentifier[house] and houseownercid[house] then
        cb(true)
    else
        cb(false)
    end
end)

RLCore.Functions.CreateCallback('qb-houses:server:getHouseOwner', function(source, cb, house)
    cb(houseownercid[house])
end)

RLCore.Functions.CreateCallback('qb-houses:server:getHouseKeyHolders', function(source, cb, house)
    local retval = {}
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if housekeyholders[house] then
        for i = 1, #housekeyholders[house], 1 do
            if Player.PlayerData.citizenid ~= housekeyholders[house][i] then
                RLCore.Functions.ExecuteSql(false, "SELECT `charinfo` FROM `players` WHERE `citizenid` = '"..housekeyholders[house][i].."'", function(result)
                    if result[1] then
                        local charinfo = json.decode(result[1].charinfo)
                        retval[#retval+1] = {
                            firstname = charinfo.firstname,
                            lastname = charinfo.lastname,
                            citizenid = housekeyholders[house][i]
                        }
                    end
                end)
            end
        end
        cb(retval)
    else
        cb(nil)
    end
end)

RLCore.Functions.CreateCallback('qb-phone:server:TransferCid', function(source, cb, NewCid, house)
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` = '"..NewCid.."'", function(result)
        if result[1] then
            local HouseName = house.name
            housekeyholders[HouseName] = {}
            housekeyholders[HouseName][1] = NewCid
            houseownercid[HouseName] = NewCid
            houseowneridentifier[HouseName] = result[1].license
            RLCore.Functions.ExecuteSql(false, "UPDATE `player_houses` SET citizenid='"..NewCid.."', keyholders='"..json.encode(housekeyholders[HouseName]).."', identifier='"..result[1].steam.."' WHERE `house` = '"..HouseName.."'")
			cb(true)
        else
            cb(false)
        end
    end)
end)

RLCore.Functions.CreateCallback('qb-houses:server:getHouseDecorations', function(source, cb, house)
    local retval = nil
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_houses` WHERE `house` = '"..house.."'", function(result)
        if result[1] then
            if result[1].decorations then
                retval = json.decode(result[1].decorations)
            end
        end
        cb(retval)
    end)
end)

RLCore.Functions.CreateCallback('qb-houses:server:getHouseLocations', function(source, cb, house)
    local retval = nil
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_houses` WHERE `house` = '"..house.."'", function(result)
        if result[1] then
            retval = result[1]
        end
        cb(retval)
    end)
end)

RLCore.Functions.CreateCallback('qb-houses:server:getHouseKeys', function(source, cb)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
end)

RLCore.Functions.CreateCallback('qb-houses:server:getOwnedHouses', function(source, cb)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)
    if pData then
        exports['ghmattimysql']:execute('SELECT * FROM player_houses WHERE identifier = @identifier AND citizenid = @citizenid', {['@identifier'] = pData.PlayerData.steam, ['@citizenid'] = pData.PlayerData.citizenid}, function(houses)
		    local ownedHouses = {}
            for i = 1, #houses, 1 do
                ownedHouses[#ownedHouses+1] = houses[i].house
            end
            if houses then
                cb(ownedHouses)
            else
                cb(nil)
            end
        end)
    end
end)

RLCore.Functions.CreateCallback('qb-houses:server:getSavedOutfits', function(source, cb)
    local src = source
    local pData = RLCore.Functions.GetPlayer(src)

    if pData then
        exports['ghmattimysql']:execute('SELECT * FROM player_outfits WHERE citizenid = @citizenid', {['@citizenid'] = pData.PlayerData.citizenid}, function(result)
            if result[1] then
                cb(result)
            else
                cb(nil)
            end
        end)
    end
end)

RLCore.Functions.CreateCallback('qb-phone:server:GetPlayerHouses', function(source, cb)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local MyHouses = {}
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_houses` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(result)
        if result and result[1] then
            for k, v in pairs(result) do
                MyHouses[#MyHouses+1] = {
                    name = v.house,
                    keyholders = {},
                    owner = Player.PlayerData.citizenid,
                    price = Config.Houses[v.house].price,
                    label = Config.Houses[v.house].adress,
                    tier = Config.Houses[v.house].tier,
                    garage = Config.Houses[v.house].garage
                }

                if v.keyholders ~= "null" then
                    v.keyholders = json.decode(v.keyholders)
                    if v.keyholders then
                        for f, data in pairs(v.keyholders) do
                            RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` = '"..data.."'", function(keyholderdata)
                                if keyholderdata[1] then
                                    keyholderdata[1].charinfo = json.decode(keyholderdata[1].charinfo)

                                    local userKeyHolderData = {
                                        charinfo = {
                                            firstname = keyholderdata[1].charinfo.firstname,
                                            lastname = keyholderdata[1].charinfo.lastname
                                        },
                                        citizenid = keyholderdata[1].citizenid,
                                        name = keyholderdata[1].name
                                    }
                                    MyHouses[k].keyholders[#MyHouses[k].keyholders+1] = userKeyHolderData
                                end
                            end)
                        end
                    else
                        MyHouses[k].keyholders[1] = {
                            charinfo = {
                                firstname = Player.PlayerData.charinfo.firstname,
                                lastname = Player.PlayerData.charinfo.lastname
                            },
                            citizenid = Player.PlayerData.citizenid,
                            name = Player.PlayerData.name
                        }
                    end
                else
                    MyHouses[k].keyholders[1] = {
                        charinfo = {
                            firstname = Player.PlayerData.charinfo.firstname,
                            lastname = Player.PlayerData.charinfo.lastname
                        },
                        citizenid = Player.PlayerData.citizenid,
                        name = Player.PlayerData.name
                    }
                end
            end

            SetTimeout(100, function()
                cb(MyHouses)
            end)
        else
            cb({})
        end
    end)
end)

RLCore.Functions.CreateCallback('qb-phone:server:GetHouseKeys', function(source, cb)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local MyKeys = {}

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_houses`", function(result)
        for k, v in pairs(result) do
            if v.keyholders ~= "null" then
                v.keyholders = json.decode(v.keyholders)
                for s, p in pairs(v.keyholders) do
                    if p == Player.PlayerData.citizenid and (v.citizenid ~= Player.PlayerData.citizenid) then
                        MyKeys[#MyKeys+1] = {
                            HouseData = Config.Houses[v.house]
                        }
                    end
                end
            end

            if v.citizenid == Player.PlayerData.citizenid then
                MyKeys[#MyKeys+1] = {
                    HouseData = Config.Houses[v.house]
                }
            end
        end
    end)
    cb(MyKeys)
end)

RLCore.Functions.CreateCallback('qb-phone:server:MeosGetPlayerHouses', function(source, cb, input)
    if input then
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

--REALESTATE JOB
RegisterNetEvent('qb-houses:server:updateTier', function()
    local HouseGarages = {}
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `houselocations`", function(result)
        if result[1] then
            for k, v in pairs(result) do
                local owned = false
                if tonumber(v.owned) == 1 then
                    owned = true
                end
                local garage = json.decode(v.garage) or {}
                Config.Houses[v.name] = {
                    coords = json.decode(v.coords),
                    owned = v.owned,
                    price = newprice,
                    locked = true,
                    adress = v.label,
                    tier = v.tier,
                    garage = garage,
                    decorations = {}
                }
                HouseGarages[v.name] = {
                    label = v.label,
                    takeVehicle = garage
                }
            end
        end
    end)
    TriggerClientEvent("qb-garages:client:houseGarageConfig", -1, HouseGarages)
    TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Config.Houses)
end)

RegisterNetEvent('qb-houses:server:updatePrice', function(price)
    local newprice = price
    local HouseGarages = {}
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `houselocations`", function(result)
        if result[1] then
            for k, v in pairs(result) do
                local owned = false
                if tonumber(v.owned) == 1 then
                    owned = true
                end
                local garage = json.decode(v.garage) or {}
                Config.Houses[v.name] = {
                    coords = json.decode(v.coords),
                    owned = v.owned,
                    price = newprice,
                    locked = true,
                    adress = v.label,
                    tier = v.tier,
                    garage = garage,
                    decorations = {}
                }
                HouseGarages[v.name] = {
                    label = v.label,
                    takeVehicle = garage
                }
            end
        end
        TriggerClientEvent("qb-garages:client:houseGarageConfig", -1, HouseGarages)
        TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Config.Houses)    
    end)
end)