local RLCore = exports['rl-core']:GetCoreObject()
local QBPhone = {}
local Tweets = {}
local AppAlerts = {}
local MentionedTweets = {}
local Hashtags = {}
local Calls = {}
local Adverts = {}
local GeneratedPlates = {}
local WebHook = ""
local bannedCharacters = {'%','$',';'}

-- Functions

local function GetOnlineStatus(number)
    local Target = RLCore.Functions.GetPlayerByPhone(number)
    local retval = false
    if Target ~= nil then
        retval = true
    end
    return retval
end

local function GenerateMailId()
    return math.random(111111, 999999)
end

local function escape_sqli(source)
    local replacements = {
        ['"'] = '\\"',
        ["'"] = "\\'"
    }
    return source:gsub("['\"]", replacements)
end

local function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces > 0 then
        local mult = 10 ^ numDecimalPlaces
        return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end

function QBPhone.AddMentionedTweet(citizenid, TweetData)
    if MentionedTweets[citizenid] == nil then
        MentionedTweets[citizenid] = {}
    end
    MentionedTweets[citizenid][#MentionedTweets[citizenid]+1] = TweetData
end

function QBPhone.SetPhoneAlerts(citizenid, app, alerts)
    if citizenid ~= nil and app ~= nil then
        if AppAlerts[citizenid] == nil then
            AppAlerts[citizenid] = {}
            if AppAlerts[citizenid][app] == nil then
                if alerts == nil then
                    AppAlerts[citizenid][app] = 1
                else
                    AppAlerts[citizenid][app] = alerts
                end
            end
        else
            if AppAlerts[citizenid][app] == nil then
                if alerts == nil then
                    AppAlerts[citizenid][app] = 1
                else
                    AppAlerts[citizenid][app] = 0
                end
            else
                if alerts == nil then
                    AppAlerts[citizenid][app] = AppAlerts[citizenid][app] + 1
                else
                    AppAlerts[citizenid][app] = AppAlerts[citizenid][app] + 0
                end
            end
        end
    end
end

local function SplitStringToArray(string)
    local retval = {}
    for i in string.gmatch(string, "%S+") do
        retval[#retval+1] = i
    end
    return retval
end

local function GenerateOwnerName()
    local names = {
        [1] = {
            name = "Jan Bloksteen",
            citizenid = "DSH091G93"
        },
        [2] = {
            name = "Jay Dendam",
            citizenid = "AVH09M193"
        },
        [3] = {
            name = "Ben Klaariskees",
            citizenid = "DVH091T93"
        },
        [4] = {
            name = "Karel Bakker",
            citizenid = "GZP091G93"
        },
        [5] = {
            name = "Klaas Adriaan",
            citizenid = "DRH09Z193"
        },
        [6] = {
            name = "Nico Wolters",
            citizenid = "KGV091J93"
        },
        [7] = {
            name = "Mark Hendrickx",
            citizenid = "ODF09S193"
        },
        [8] = {
            name = "Bert Johannes",
            citizenid = "KSD0919H3"
        },
        [9] = {
            name = "Karel de Grote",
            citizenid = "NDX091D93"
        },
        [10] = {
            name = "Jan Pieter",
            citizenid = "ZAL0919X3"
        },
        [11] = {
            name = "Huig Roelink",
            citizenid = "ZAK09D193"
        },
        [12] = {
            name = "Corneel Boerselman",
            citizenid = "POL09F193"
        },
        [13] = {
            name = "Hermen Klein Overmeen",
            citizenid = "TEW0J9193"
        },
        [14] = {
            name = "Bart Rielink",
            citizenid = "YOO09H193"
        },
        [15] = {
            name = "Antoon Henselijn",
            citizenid = "QBC091H93"
        },
        [16] = {
            name = "Aad Keizer",
            citizenid = "YDN091H93"
        },
        [17] = {
            name = "Thijn Kiel",
            citizenid = "PJD09D193"
        },
        [18] = {
            name = "Henkie Krikhaar",
            citizenid = "RND091D93"
        },
        [19] = {
            name = "Teun Blaauwkamp",
            citizenid = "QWE091A93"
        },
        [20] = {
            name = "Dries Stielstra",
            citizenid = "KJH0919M3"
        },
        [21] = {
            name = "Karlijn Hensbergen",
            citizenid = "ZXC09D193"
        },
        [22] = {
            name = "Aafke van Daalen",
            citizenid = "XYZ0919C3"
        },
        [23] = {
            name = "Door Leeferds",
            citizenid = "ZYX0919F3"
        },
        [24] = {
            name = "Nelleke Broedersen",
            citizenid = "IOP091O93"
        },
        [25] = {
            name = "Renske de Raaf",
            citizenid = "PIO091R93"
        },
        [26] = {
            name = "Krisje Moltman",
            citizenid = "LEK091X93"
        },
        [27] = {
            name = "Mirre Steevens",
            citizenid = "ALG091Y93"
        },
        [28] = {
            name = "Joosje Kalvenhaar",
            citizenid = "YUR09E193"
        },
        [29] = {
            name = "Mirte Ellenbroek",
            citizenid = "SOM091W93"
        },
        [30] = {
            name = "Marlieke Meilink",
            citizenid = "KAS09193"
        }
    }
    return names[math.random(1, #names)]
end

-- Callbacks

RLCore.Functions.CreateCallback('qb-phone:server:GetCallState', function(source, cb, ContactData)
    local Target = RLCore.Functions.GetPlayerByPhone(ContactData.number)
    if Target ~= nil then
        if Calls[Target.PlayerData.citizenid] ~= nil then
            if Calls[Target.PlayerData.citizenid].inCall then
                print("false, true")
                cb(false, true)
            else
                print("true, true")
                cb(true, true)
            end
        else
            print("true, true")
            cb(true, true)
        end
    else
        print("false, false")
        cb(false, false)
    end
end)

RLCore.Functions.CreateCallback('qb-phone:server:GetPhoneData', function(source, cb)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if Player ~= nil then
        local PhoneData = {
            Applications = {},
            PlayerContacts = {},
            MentionedTweets = {},
            Chats = {},
            Hashtags = {},
            Invoices = {},
            Garage = {},
            Mails = {},
            Adverts = {},
            CryptoTransactions = {},
            Tweets = {},
            Images = {},
            InstalledApps = Player.PlayerData.metadata["phone"].InstalledApps
        }
        PhoneData.Adverts = Adverts
        exports.ghmattimysql:execute("SELECT * FROM player_contacts WHERE citizenid = @citizenid ORDER BY name ASC", {["@citizenid"] = Player.PlayerData.citizenid}, function(result)
            local Contacts = {}
            if result[1] ~= nil then
                for k, v in pairs(result) do
                    v.status = GetOnlineStatus(v.number)
                end

                PhoneData.PlayerContacts = result
            end
        end)

        exports.ghmattimysql:execute("SELECT * FROM phone_invoices WHERE citizenid = @citizenid", {["@citizenid"] = Player.PlayerData.citizenid}, function(invoices)
            if invoices[1] ~= nil then
                for k, v in pairs(invoices) do
                    local Ply = RLCore.Functions.GetPlayerByCitizenId(v.sender)
                    if Ply ~= nil then
                        v.number = Ply.PlayerData.charinfo.phone
                    else
                        local res = MySQL.query.await('SELECT * FROM players WHERE citizenid = ?', {v.sender})
                        if res[1] ~= nil then
                            res[1].charinfo = json.decode(res[1].charinfo)
                            v.number = res[1].charinfo.phone
                        else
                            v.number = nil
                        end
                    end
                end
                PhoneData.Invoices = invoices
            end
        end)

        exports.ghmattimysql:execute("SELECT * FROM player_vehicles WHERE citizenid = @citizenid", {["@citizenid"] = Player.PlayerData.citizenid}, function(garageresult)
            if garageresult[1] ~= nil then
                for k, v in pairs(garageresult) do
                    local vehicleModel = v.vehicle
                    if (RLCore.Shared.Vehicles[vehicleModel] ~= nil) and (Garages[v.garage] ~= nil) then
                        v.garage = Garages[v.garage].label
                        v.vehicle = RLCore.Shared.Vehicles[vehicleModel].name
                        v.brand = RLCore.Shared.Vehicles[vehicleModel].brand
                    end

                end
                PhoneData.Garage = garageresult
            end
        end)

        exports.ghmattimysql:execute("SELECT * FROM phone_messages WHERE citizenid = @citizenid", {["@citizenid"] = Player.PlayerData.citizenid}, function(messages)
            if messages ~= nil and next(messages) ~= nil then
                PhoneData.Chats = messages
            end
        end)

        if AppAlerts[Player.PlayerData.citizenid] ~= nil then
            PhoneData.Applications = AppAlerts[Player.PlayerData.citizenid]
        end

        if MentionedTweets[Player.PlayerData.citizenid] ~= nil then
            PhoneData.MentionedTweets = MentionedTweets[Player.PlayerData.citizenid]
        end

        if Hashtags ~= nil and next(Hashtags) ~= nil then
            PhoneData.Hashtags = Hashtags
        end

        exports.ghmattimysql:execute("SELECT * FROM phone_tweets WHERE date > NOW() - INTERVAL 24 hour", function(Tweets)
            if Tweets ~= nil and next(Tweets) ~= nil then
                PhoneData.Tweets = Tweets
            end
        end)

        exports.ghmattimysql:execute("SELECT * FROM player_mails WHERE citizenid = @citizenid ORDER BY `date` ASC", {["@citizenid"] = Player.PlayerData.citizenid}, function(mails)
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
                PhoneData.Mails = mails
            end
        end)

        exports.ghmattimysql:execute("SELECT * FROM crypto_transactions WHERE citizenid = @citizenid ORDER BY `date` ASC", {["@citizenid"] = Player.PlayerData.citizenid}, function(transactions)

            if transactions[1] ~= nil then
                for _, v in pairs(transactions) do
                    PhoneData.CryptoTransactions[#PhoneData.CryptoTransactions+1] = {
                        TransactionTitle = v.title,
                        TransactionMessage = v.message
                    }
                end
            end
        end)
        exports.ghmattimysql:execute("SELECT * FROM phone_gallery WHERE citizenid = @citizenid ORDER BY `date` DESC", {["@citizenid"] = Player.PlayerData.citizenid}, function(images)

            if images ~= nil and next(images) ~= nil then
                PhoneData.Images = images
            end
        end)
        cb(PhoneData)
    end
end)

RLCore.Functions.CreateCallback('qb-phone:server:PayInvoice', function(source, cb, society, amount, invoiceId, sendercitizenid)
    local Invoices = {}
    local Ply = RLCore.Functions.GetPlayer(source)
    local SenderPly = RLCore.Functions.GetPlayerByCitizenId(sendercitizenid)
    local invoiceMailData = {}
    if SenderPly and Config.BillingCommissions[society] then
        local commission = round(amount * Config.BillingCommissions[society])
        SenderPly.Functions.AddMoney('bank', commission)
        invoiceMailData = {
            sender = 'Billing Department',
            subject = 'Commission Received',
            message = string.format('You received a commission check of $%s when %s %s paid a bill of $%s.', commission, Ply.PlayerData.charinfo.firstname, Ply.PlayerData.charinfo.lastname, amount)
        }
    elseif not SenderPly and Config.BillingCommissions[society] then
        invoiceMailData = {
            sender = 'Billing Department',
            subject = 'Bill Paid',
            message = string.format('%s %s paid a bill of $%s', Ply.PlayerData.charinfo.firstname, Ply.PlayerData.charinfo.lastname, amount)
        }
    end
    Ply.Functions.RemoveMoney('bank', amount, "paid-invoice")
    TriggerEvent('qb-phone:server:sendNewMailToOffline', sendercitizenid, invoiceMailData)
    TriggerEvent("qb-bossmenu:server:addAccountMoney", society, amount)
    MySQL.query('DELETE FROM phone_invoices WHERE id = ?', {invoiceId})
    exports.ghmattimysql:execute("SELECT * FROM phone_invoices WHERE citizenid = @citizenid", {["@citizenid"] = Ply.PlayerData.citizenid}, function(invoices)
        if invoices[1] ~= nil then
            Invoices = invoices
        end
    end)
    cb(true, Invoices)
end)

RLCore.Functions.CreateCallback('qb-phone:server:DeclineInvoice', function(source, cb, sender, amount, invoiceId)
    local Invoices = {}
    local Ply = RLCore.Functions.GetPlayer(source)

    exports.ghmattimysql:execute('DELETE FROM phone_invoices WHERE id = @id', {['@id'] = invoiceId}, function (invoiceId)
        exports.ghmattimysql:execute("SELECT * FROM phone_invoices WHERE citizenid = @citizenid", {["@citizenid"] = Ply.PlayerData.citizenid}, function(invoices)
            if invoices[1] ~= nil then
                Invoices = invoices
            end
        end)
    end)
    cb(true, Invoices)
end)

RLCore.Functions.CreateCallback('qb-phone:server:GetContactPictures', function(source, cb, Chats)
    for k, v in pairs(Chats) do
        local Player = RLCore.Functions.GetPlayerByPhone(v.number)

        local query = '%' .. v.number .. '%'

        exports.ghmattimysql:execute("SELECT * FROM players WHERE charinfo LIKE query = @query", {["@query"] = query}, function(result)
        
            if result[1] ~= nil then
                local MetaData = json.decode(result[1].metadata)

                if MetaData.phone.profilepicture ~= nil then
                    v.picture = MetaData.phone.profilepicture
                else
                    v.picture = "default"
                end
            end
        end)
    end
    SetTimeout(100, function()
        cb(Chats)
    end)
end) --HERE

RLCore.Functions.CreateCallback('qb-phone:server:GetContactPicture', function(source, cb, Chat)
    local query = '%' .. Chat.number .. '%'

    exports.ghmattimysql:execute("SELECT * FROM players WHERE charinfo LIKE query = @query", {["@query"] = query}, function(result)
        local MetaData = json.decode(result[1].metadata)
        if MetaData.phone.profilepicture ~= nil then
            Chat.picture = MetaData.phone.profilepicture
        else
            Chat.picture = "default"
        end
        SetTimeout(100, function()
            cb(Chat)
        end)
    end)
end)

RLCore.Functions.CreateCallback('qb-phone:server:GetPicture', function(source, cb, number)
    local Picture = nil
    local query = '%' .. number .. '%'
    exports.ghmattimysql:execute("SELECT * FROM players WHERE charinfo LIKE query = @query", {["@query"] = query}, function(result)
    
        if result[1] ~= nil then
            local MetaData = json.decode(result[1].metadata)
            if MetaData.phone.profilepicture ~= nil then
                Picture = MetaData.phone.profilepicture
            else
                Picture = "default"
            end
            cb(Picture)
        else
            cb(nil)
        end
    end)
end)

RLCore.Functions.CreateCallback('qb-phone:server:FetchResult', function(source, cb, search)
    local src = source
    local search = escape_sqli(search)
    local searchData = {}
    local ApaData = {}

    local query = 'SELECT * FROM `players` WHERE `citizenid` = "'..search..'"'
    -- Split on " " and check each var individual
    local searchParameters = SplitStringToArray(search)
    
    -- Construct query dynamicly for individual parm check
    if #searchParameters > 1 then
        query = query .. ' OR `charinfo` LIKE "%'..searchParameters[1]..'%"'
        for i = 2, #searchParameters do
            query = query .. ' AND `charinfo` LIKE  "%' .. searchParameters[i] ..'%"'
        end
    else
        query = query .. ' OR `charinfo` LIKE "%'..search..'%"'
    end
    
    RLCore.Functions.ExecuteSql(false, query, function(result)
        RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `apartments`', function(ApartmentData)
            for k, v in pairs(ApartmentData) do
                ApaData[v.citizenid] = ApartmentData[k]
            end

            if result[1] ~= nil then
                for k, v in pairs(result) do
                    local charinfo = json.decode(v.charinfo)
                    local metadata = json.decode(v.metadata)
                    local appiepappie = {}
                    if ApaData[v.citizenid] ~= nil and next(ApaData[v.citizenid]) ~= nil then
                        appiepappie = ApaData[v.citizenid]
                    end
                    table.insert(searchData, {
                        citizenid = v.citizenid,
                        firstname = charinfo.firstname,
                        lastname = charinfo.lastname,
                        birthdate = charinfo.birthdate,
                        phone = charinfo.phone,
                        nationality = charinfo.nationality,
                        gender = charinfo.gender,
                        warrant = false,
                        driverlicense = metadata["licences"]["driver"],
                        appartmentdata = appiepappie,
                    })
                end
                cb(searchData)
            else
                cb(nil)
            end
        end)
    end)
end)

RLCore.Functions.CreateCallback('qb-phone:server:GetVehicleSearchResults', function(source, cb, search)
    local search = escape_sqli(search)
    local searchData = {}
    local query = '%' .. search .. '%'
    RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_vehicles` WHERE `plate` LIKE "%'..search..'%" OR `citizenid` = "'..search..'"', function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                RLCore.Functions.ExecuteSql(true, 'SELECT * FROM `players` WHERE `citizenid` = "'..result[k].citizenid..'"', function(player)
                    if player[1] ~= nil then
                        local charinfo = json.decode(player[1].charinfo)
                        local vehicleInfo = RLCore.Shared.Vehicles[result[k].vehicle]
                        if vehicleInfo ~= nil then
                            searchData[#searchData+1] = {
                                plate = result[k].plate,
                                status = true,
                                owner = charinfo.firstname .. " " .. charinfo.lastname,
                                citizenid = result[k].citizenid,
                                label = vehicleInfo["name"]
                            }
                        else
                            searchData[#searchData+1] = {
                                plate = result[k].plate,
                                status = true,
                                owner = charinfo.firstname .. " " .. charinfo.lastname,
                                citizenid = result[k].citizenid,
                                label = "Name not found.."
                            }
                        end
                    end
                end)
            end
        else
            if GeneratedPlates[search] ~= nil then
                searchData[#searchData+1] = {
                    plate = GeneratedPlates[search].plate,
                    status = GeneratedPlates[search].status,
                    owner = GeneratedPlates[search].owner,
                    citizenid = GeneratedPlates[search].citizenid,
                    label = "Brand unknown.."
                }
            else
                local ownerInfo = GenerateOwnerName()
                GeneratedPlates[search] = {
                    plate = search,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.citizenid
                }
                searchData[#searchData+1] = {
                    plate = search,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.citizenid,
                    label = "Brand unknown.."
                }
            end
        end
        cb(searchData)
    end)
end)

RLCore.Functions.CreateCallback('qb-phone:server:ScanPlate', function(source, cb, plate)
    local src = source
    local vehicleData = {}
    if plate ~= nil then 
        RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_vehicles` WHERE `plate` = "'..plate..'"', function(result)
            if result[1] ~= nil then
                RLCore.Functions.ExecuteSql(true, 'SELECT * FROM `players` WHERE `citizenid` = "'..result[1].citizenid..'"', function(player)
                    local charinfo = json.decode(player[1].charinfo)
                    vehicleData = {
                        plate = plate,
                        status = true,
                        owner = charinfo.firstname .. " " .. charinfo.lastname,
                        citizenid = result[1].citizenid,
                    }
                end)
            elseif GeneratedPlates ~= nil and GeneratedPlates[plate] ~= nil then 
                vehicleData = GeneratedPlates[plate]
            else
                local ownerInfo = GenerateOwnerName()
                GeneratedPlates[plate] = {
                    plate = plate,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.citizenid,
                }
                vehicleData = {
                    plate = plate,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.citizenid,
                }
            end
            cb(vehicleData)
        end)
    else
        TriggerClientEvent('RLCore:Notify', src, "No vehicle around..", "error")
        cb(nil)
    end
end)

local function GetGarageNamephone(name)
    for k,v in pairs(Garages) do
        if k == name then
            return true
        end
    end
end

RLCore.Functions.CreateCallback('qb-phone:server:GetGarageVehicles', function(source, cb)
    local Player = RLCore.Functions.GetPlayer(source)
    local Vehicles = {}
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `player_vehicles` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                local VehicleData = RLCore.Shared.Vehicles[v.vehicle]
                local VehicleGarage = "None"
                if v.garage ~= nil then
                    if GetGarageNamephone(v.garage) then
                        if Garages[v.garage] or GangGarages[v.garage] or JobGarages[v.garage] then
                            if Garages[v.garage] ~= nil then
                                VehicleGarage = Garages[v.garage]["label"]
                            elseif GangGarages[v.garage] ~= nil then
                                VehicleGarage = GangGarages[v.garage]["label"]
                            elseif JobGarages[v.garage] ~= nil then
                                VehicleGarage = JobGarages[v.garage]["label"]
                            end
                        end
                    else
                        VehicleGarage = v.garage
                    end
                end
                
                local VehicleState = "In"
                if v.state == 0 then
                    VehicleState = "Out"
                elseif v.state == 2 then
                    VehicleState = "Impounded"
                end

                local vehdata = {}
                if VehicleData["brand"] ~= nil then
                    vehdata = {
                        fullname = VehicleData["brand"] .. " " .. VehicleData["name"],
                        brand = VehicleData["brand"],
                        model = VehicleData["name"],
                        plate = v.plate,
                        garage = VehicleGarage,
                        state = VehicleState,
                        fuel = v.fuel,
                        engine = v.engine,
                        body = v.body
                    }
                else
                    vehdata = {
                        fullname = VehicleData["name"],
                        brand = VehicleData["name"],
                        model = VehicleData["name"],
                        plate = v.plate,
                        garage = VehicleGarage,
                        state = VehicleState,
                        fuel = v.fuel,
                        engine = v.engine,
                        body = v.body
                    }
                end
                Vehicles[#Vehicles+1] = vehdata
            end
            cb(Vehicles)
        else
            cb(nil)
        end
    end)
end)

RLCore.Functions.CreateCallback('qb-phone:server:HasPhone', function(source, cb)
    local Player = RLCore.Functions.GetPlayer(source)
    if Player ~= nil then
        local HasPhone = Player.Functions.GetItemByName("phone")
        if HasPhone ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
end)

RLCore.Functions.CreateCallback('qb-phone:server:CanTransferMoney', function(source, cb, amount, iban)
    local newAmount = tostring(amount)
    local newiban = tostring(iban)
    for k, v in pairs(bannedCharacters) do
        newAmount = string.gsub(newAmount, '%' .. v, '')
        newiban = string.gsub(newiban, '%' .. v, '')
    end
    iban = newiban
    amount = tonumber(newAmount)
    
    local Player = RLCore.Functions.GetPlayer(source)
    if (Player.PlayerData.money.bank - amount) >= 0 then
        RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `charinfo` LIKE '%"..iban.."%'", function(result)
            if result[1] ~= nil then
                local Reciever = RLCore.Functions.GetPlayerByCitizenId(result[1].citizenid)
                Player.Functions.RemoveMoney('bank', amount)
                if Reciever ~= nil then
                    Reciever.Functions.AddMoney('bank', amount)
                else
                    local RecieverMoney = json.decode(result[1].money)
                    RecieverMoney.bank = (RecieverMoney.bank + amount)
                    RLCore.Functions.ExecuteSql(false, "UPDATE `players` SET `money` = '"..json.encode(RecieverMoney).."' WHERE `citizenid` = '"..result[1].citizenid.."'")
                end
                cb(true)
            else
                cb(false)
            end
        end)
    end
end)

RLCore.Functions.CreateCallback('qb-phone:server:GetCurrentLawyers', function(source, cb)
    local Lawyers = {}
    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "lawyer" or Player.PlayerData.job.name == "realestate" or
                Player.PlayerData.job.name == "mechanic" or Player.PlayerData.job.name == "taxi" or
                Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance") and
                Player.PlayerData.job.onduty then
                Lawyers[#Lawyers+1] = {
                    name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
                    phone = Player.PlayerData.charinfo.phone,
                    typejob = Player.PlayerData.job.name
                }
            end
        end
    end
    cb(Lawyers)
end)

RLCore.Functions.CreateCallback("qb-phone:server:GetWebhook",function(source,cb)
		cb(WebHook)
end)

-- Events

RegisterNetEvent('qb-phone:server:AddAdvert', function(msg, url)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local CitizenId = Player.PlayerData.citizenid
    if Adverts[CitizenId] ~= nil then
        Adverts[CitizenId].message = msg
        Adverts[CitizenId].name = "@" .. Player.PlayerData.charinfo.firstname .. "" .. Player.PlayerData.charinfo.lastname
        Adverts[CitizenId].number = Player.PlayerData.charinfo.phone
        Adverts[CitizenId].url = url
    else
        Adverts[CitizenId] = {
            message = msg,
            name = "@" .. Player.PlayerData.charinfo.firstname .. "" .. Player.PlayerData.charinfo.lastname,
            number = Player.PlayerData.charinfo.phone,
            url = url
        }
    end
    TriggerClientEvent('qb-phone:client:UpdateAdverts', -1, Adverts, "@" .. Player.PlayerData.charinfo.firstname .. "" .. Player.PlayerData.charinfo.lastname)
end)

RegisterNetEvent('qb-phone:server:DeleteAdvert', function()
    local Player = RLCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid
    Adverts[citizenid] = nil
    TriggerClientEvent('qb-phone:client:UpdateAdvertsDel', -1, Adverts)
end)

RegisterNetEvent('qb-phone:server:SetCallState', function(bool)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)
    if Calls[Ply.PlayerData.citizenid] ~= nil then
        Calls[Ply.PlayerData.citizenid].inCall = bool
    else
        Calls[Ply.PlayerData.citizenid] = {}
        Calls[Ply.PlayerData.citizenid].inCall = bool
    end
end)

RegisterNetEvent('qb-phone:server:RemoveMail', function(MailId)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    RLCore.Functions.ExecuteSql(false, 'DELETE FROM `player_mails` WHERE `mailid` = "'..MailId..'" AND `citizenid` = "'..Player.PlayerData.citizenid..'"')
    SetTimeout(100, function()
        RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` ASC', function(mails)
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end
    
            TriggerClientEvent('qb-phone:client:UpdateMails', src, mails)
        end)
    end)
end)

RegisterNetEvent('qb-phone:server:sendNewMail', function(mailData)
    local src = source
    if srcz ~= nil then src = srcz end
    local Player = RLCore.Functions.GetPlayer(src)

    if mailData.button == nil then
        RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..Player.PlayerData.citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0')")
    else
        RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..Player.PlayerData.citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')")
    end
    TriggerClientEvent('qb-phone:client:NewMailNotify', src, mailData)
    SetTimeout(200, function()
        RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` DESC', function(mails)
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end
    
            TriggerClientEvent('qb-phone:client:UpdateMails', src, mails)
        end)
    end)
end)

RegisterNetEvent('qb-phone:server:sendNewMailToOffline', function(citizenid, mailData)
    local Player = RLCore.Functions.GetPlayerByCitizenId(citizenid)

    if Player ~= nil then
        local src = Player.PlayerData.source

        if mailData.button == nil then
            RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..Player.PlayerData.citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0')")
            TriggerClientEvent('qb-phone:client:NewMailNotify', src, mailData)
        else
            RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..Player.PlayerData.citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')")
            TriggerClientEvent('qb-phone:client:NewMailNotify', src, mailData)
        end

        SetTimeout(200, function()
            RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` DESC', function(mails)
                if mails[1] ~= nil then
                    for k, v in pairs(mails) do
                        if mails[k].button ~= nil then
                            mails[k].button = json.decode(mails[k].button)
                        end
                    end
                end
        
                TriggerClientEvent('qb-phone:client:UpdateMails', src, mails)
            end)
        end)
    else
        if mailData.button == nil then
            RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0')")
        else
            RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')")
        end
    end
end)

RegisterNetEvent('qb-phone:server:sendNewEventMail', function(citizenid, mailData)
    if mailData.button == nil then
        RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0')")
    else
        RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')")
    end
    SetTimeout(200, function()
        RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` DESC', function(mails)
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end
    
            TriggerClientEvent('qb-phone:client:UpdateMails', src, mails)
        end)
    end)
end)

RegisterNetEvent('qb-phone:server:ClearButtonData', function(mailId)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    RLCore.Functions.ExecuteSql(false, 'UPDATE `player_mails` SET `button` = "" WHERE `mailid` = "'..mailId..'" AND `citizenid` = "'..Player.PlayerData.citizenid..'"')
    SetTimeout(200, function()
        RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` DESC', function(mails)
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end
    
            TriggerClientEvent('qb-phone:client:UpdateMails', src, mails)
        end)
    end)
end)

RegisterNetEvent('qb-phone:server:MentionedPlayer', function(firstName, lastName, TweetMessage)
    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.charinfo.firstname == firstName and Player.PlayerData.charinfo.lastname == lastName) then
                RLPhone.SetPhoneAlerts(Player.PlayerData.citizenid, "twitter")
                RLPhone.AddMentionedTweet(Player.PlayerData.citizenid, TweetMessage)
                TriggerClientEvent('qb-phone:client:GetMentioned', Player.PlayerData.source, TweetMessage, AppAlerts[Player.PlayerData.citizenid]["twitter"])
            else
                RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `charinfo` LIKE '%"..firstName.."%' AND `charinfo` LIKE '%"..lastName.."%'", function(result)
                    if result[1] ~= nil then
                        local MentionedTarget = result[1].citizenid
                        RLPhone.SetPhoneAlerts(MentionedTarget, "twitter")
                        RLPhone.AddMentionedTweet(MentionedTarget, TweetMessage)
                    end
                end)
            end
        end
	end
end)

RegisterNetEvent('qb-phone:server:CallContact', function(TargetData, CallId, AnonymousCall)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)
    local Target = RLCore.Functions.GetPlayerByPhone(TargetData.number)

    if Target ~= nil then
        TriggerClientEvent('qb-phone:client:GetCalled', Target.PlayerData.source, Ply.PlayerData.charinfo.phone, CallId, AnonymousCall)
    end
end)

RegisterNetEvent('qb-phone:server:BillingEmail', function(data, paid)
    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local target = RLCore.Functions.GetPlayer(v)
        if target.PlayerData.job.name == data.society then
            if paid then
                local name = '' .. RLCore.Functions.GetPlayer(source).PlayerData.charinfo.firstname .. ' ' .. RLCore.Functions.GetPlayer(source).PlayerData.charinfo.lastname .. ''
                TriggerClientEvent('qb-phone:client:BillingEmail', target.PlayerData.source, data, true, name)
            else
                local name = '' .. RLCore.Functions.GetPlayer(source).PlayerData.charinfo.firstname .. ' ' .. RLCore.Functions.GetPlayer(source).PlayerData.charinfo.lastname .. ''
                TriggerClientEvent('qb-phone:client:BillingEmail', target.PlayerData.source, data, false, name)
            end
        end
    end
end)

RegisterNetEvent('qb-phone:server:UpdateHashtags', function(Handle, messageData)
    if Hashtags[Handle] ~= nil and next(Hashtags[Handle]) ~= nil then
        Hashtags[Handle].messages[#Hashtags[Handle].messages+1] = messageData
    else
        Hashtags[Handle] = {
            hashtag = Handle,
            messages = {}
        }
        Hashtags[Handle].messages[#Hashtags[Handle].messages+1] = messageData
    end
    TriggerClientEvent('qb-phone:client:UpdateHashtags', -1, Handle, messageData)
end)

RegisterNetEvent('qb-phone:server:SetPhoneAlerts', function(app, alerts)
    local src = source
    local CitizenId = RLCore.Functions.GetPlayer(src).citizenid
    QBPhone.SetPhoneAlerts(CitizenId, app, alerts)
end)

RegisterNetEvent('qb-phone:server:DeleteTweet', function(tweetId)
    local src = source
    for i = 1, #Tweets do
        if Tweets[i].tweetId == tweetId then
            Tweets[i] = nil
        end
    end
    TriggerClientEvent('qb-phone:client:UpdateTweets', -1, src, Tweets, {}, true)
end)
--HERE 
RegisterNetEvent('qb-phone:server:UpdateTweets', function(NewTweets, TweetData)
    local src = source

    exports.ghmattimysql:execute('INSERT INTO phone_tweets (citizenid, firstName, lastName, message, date, url, picture, tweetid) VALUES (@citizenid, @firstName, @lastName, @message, NOW(), @url, @picture, @tweetid)', {
        ['@citizenid'] = TweetData.citizenid,
        ['@firstName'] = TweetData.firstName,
        ['@lastName'] = TweetData.lastName,
        ['@message'] = TweetData.message,
        ['@url'] = TweetData.url:gsub("[%<>\"()\' $]",""),
        ['@picture'] = TweetData.picture,
        ['@tweetid'] = TweetData.tweetId,
    })

    TriggerClientEvent('qb-phone:client:UpdateTweets', -1, src, NewTweets, TweetData, false)
end)
 
RegisterNetEvent('qb-phone:server:TransferMoney', function(iban, amount)
    local src = source
    local sender = RLCore.Functions.GetPlayer(src)

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `charinfo` LIKE '%"..iban.."%'", function(result)
        if result[1] ~= nil then
            local recieverSteam = RLCore.Functions.GetPlayerByCitizenId(result[1].citizenid)

            if recieverSteam ~= nil then
                local PhoneItem = recieverSteam.Functions.GetItemByName("phone")
                recieverSteam.Functions.AddMoney('bank', amount, "phone-transfered-from-"..sender.PlayerData.citizenid)
                sender.Functions.RemoveMoney('bank', amount, "phone-transfered-to-"..recieverSteam.PlayerData.citizenid)

                if PhoneItem ~= nil then
                    TriggerClientEvent('qb-phone:client:TransferMoney', recieverSteam.PlayerData.source, amount, recieverSteam.PlayerData.money.bank)
                end
            else
                local moneyInfo = json.decode(result[1].money)
                moneyInfo.bank = round((moneyInfo.bank + amount))
                RLCore.Functions.ExecuteSql(false, "UPDATE `players` SET `money` = '"..json.encode(moneyInfo).."' WHERE `citizenid` = '"..result[1].citizenid.."'")
                sender.Functions.RemoveMoney('bank', amount, "phone-transfered")
            end
        else
            TriggerClientEvent('RLCore:Notify', src, "This account number does not exist!", "error")
        end
    end)
end)

RegisterNetEvent('qb-phone:server:EditContact', function(newName, newNumber, newIban, oldName, oldNumber, oldIban)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    RLCore.Functions.ExecuteSql(false, "UPDATE `player_contacts` SET `name` = '"..newName.."', `number` = '"..newNumber.."', `iban` = '"..newIban.."' WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `name` = '"..oldName.."' AND `number` = '"..oldNumber.."'")
end)

RegisterNetEvent('qb-phone:server:RemoveContact', function(Name, Number)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    
    RLCore.Functions.ExecuteSql(false, "DELETE FROM `player_contacts` WHERE `name` = '"..Name.."' AND `number` = '"..Number.."' AND `citizenid` = '"..Player.PlayerData.citizenid.."'")
end)

RegisterNetEvent('qb-phone:server:AddNewContact', function(name, number, iban)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_contacts` (`citizenid`, `name`, `number`, `iban`) VALUES ('"..Player.PlayerData.citizenid.."', '"..tostring(name).."', '"..tostring(number).."', '"..tostring(iban).."')")
end)

RegisterNetEvent('qb-phone:server:UpdateMessages', function(ChatMessages, ChatNumber, New)
    local src = source
    local SenderData = RLCore.Functions.GetPlayer(src)

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `charinfo` LIKE '%"..ChatNumber.."%'", function(Player)
        if Player[1] ~= nil then
            local TargetData = RLCore.Functions.GetPlayerByCitizenId(Player[1].citizenid)

            if TargetData ~= nil then
                RLCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_messages` WHERE `citizenid` = '"..SenderData.PlayerData.citizenid.."' AND `number` = '"..ChatNumber.."'", function(Chat)
                    if Chat[1] ~= nil then
                        -- Update for target
                        RLCore.Functions.ExecuteSql(false, "UPDATE `phone_messages` SET `messages` = '"..json.encode(ChatMessages).."' WHERE `citizenid` = '"..TargetData.PlayerData.citizenid.."' AND `number` = '"..SenderData.PlayerData.charinfo.phone.."'")
                                
                        -- Update for sender
                        RLCore.Functions.ExecuteSql(false, "UPDATE `phone_messages` SET `messages` = '"..json.encode(ChatMessages).."' WHERE `citizenid` = '"..SenderData.PlayerData.citizenid.."' AND `number` = '"..TargetData.PlayerData.charinfo.phone.."'")
                    
                        -- Send notification & Update messages for target
                        TriggerClientEvent('qb-phone:client:UpdateMessages', TargetData.PlayerData.source, ChatMessages, SenderData.PlayerData.charinfo.phone, false)
                    else
                        -- Insert for target
                        RLCore.Functions.ExecuteSql(false, "INSERT INTO `phone_messages` (`citizenid`, `number`, `messages`) VALUES ('"..TargetData.PlayerData.citizenid.."', '"..SenderData.PlayerData.charinfo.phone.."', '"..json.encode(ChatMessages).."')")
                                            
                        -- Insert for sender
                        RLCore.Functions.ExecuteSql(false, "INSERT INTO `phone_messages` (`citizenid`, `number`, `messages`) VALUES ('"..SenderData.PlayerData.citizenid.."', '"..TargetData.PlayerData.charinfo.phone.."', '"..json.encode(ChatMessages).."')")

                        -- Send notification & Update messages for target
                        TriggerClientEvent('qb-phone:client:UpdateMessages', TargetData.PlayerData.source, ChatMessages, SenderData.PlayerData.charinfo.phone, true)
                    end
                end)
            else
                RLCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_messages` WHERE `citizenid` = '"..SenderData.PlayerData.citizenid.."' AND `number` = '"..ChatNumber.."'", function(Chat)
                    if Chat[1] ~= nil then
                        -- Update for target
                        RLCore.Functions.ExecuteSql(false, "UPDATE `phone_messages` SET `messages` = '"..json.encode(ChatMessages).."' WHERE `citizenid` = '"..Player[1].citizenid.."' AND `number` = '"..SenderData.PlayerData.charinfo.phone.."'")
                                
                        -- Update for sender
                        Player[1].charinfo = json.decode(Player[1].charinfo)
                        RLCore.Functions.ExecuteSql(false, "UPDATE `phone_messages` SET `messages` = '"..json.encode(ChatMessages).."' WHERE `citizenid` = '"..SenderData.PlayerData.citizenid.."' AND `number` = '"..Player[1].charinfo.phone.."'")
                    else
                        -- Insert for target
                        RLCore.Functions.ExecuteSql(false, "INSERT INTO `phone_messages` (`citizenid`, `number`, `messages`) VALUES ('"..Player[1].citizenid.."', '"..SenderData.PlayerData.charinfo.phone.."', '"..json.encode(ChatMessages).."')")
                        
                        -- Insert for sender
                        Player[1].charinfo = json.decode(Player[1].charinfo)
                        RLCore.Functions.ExecuteSql(false, "INSERT INTO `phone_messages` (`citizenid`, `number`, `messages`) VALUES ('"..SenderData.PlayerData.citizenid.."', '"..Player[1].charinfo.phone.."', '"..json.encode(ChatMessages).."')")
                    end
                end)
            end
        end
    end)
end)

RegisterNetEvent('qb-phone:server:AddRecentCall', function(type, data)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)
    local Hour = os.date("%H")
    local Minute = os.date("%M")
    local label = Hour .. ":" .. Minute
    TriggerClientEvent('qb-phone:client:AddRecentCall', src, data, label, type)
    local Trgt = RLCore.Functions.GetPlayerByPhone(data.number)
    if Trgt ~= nil then
        TriggerClientEvent('qb-phone:client:AddRecentCall', Trgt.PlayerData.source, {
            name = Ply.PlayerData.charinfo.firstname .. " " .. Ply.PlayerData.charinfo.lastname,
            number = Ply.PlayerData.charinfo.phone,
            anonymous = data.anonymous
        }, label, "outgoing")
    end
end)

RegisterNetEvent('qb-phone:server:CancelCall', function(ContactData)
    local Ply = RLCore.Functions.GetPlayerByPhone(ContactData.TargetData.number)
    if Ply ~= nil then
        TriggerClientEvent('qb-phone:client:CancelCall', Ply.PlayerData.source)
    end
end)

RegisterNetEvent('qb-phone:server:AnswerCall', function(CallData)
    local Ply = RLCore.Functions.GetPlayerByPhone(CallData.TargetData.number)
    if Ply ~= nil then
        TriggerClientEvent('qb-phone:client:AnswerCall', Ply.PlayerData.source)
    end
end)

RegisterNetEvent('qb-phone:server:SaveMetaData', function(MData)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(result)
        local MetaData = json.decode(result[1].metadata)
        MetaData.phone = MData
        RLCore.Functions.ExecuteSql(false, "UPDATE `players` SET `metadata` = '"..json.encode(MetaData).."' WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'")
    end)

    Player.Functions.SetMetaData("phone", MData)
end)

RegisterNetEvent('qb-phone:server:GiveContactDetails', function(PlayerId)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local SuggestionData = {
        name = {
            [1] = Player.PlayerData.charinfo.firstname,
            [2] = Player.PlayerData.charinfo.lastname
        },
        number = Player.PlayerData.charinfo.phone,
        bank = Player.PlayerData.charinfo.account
    }

    TriggerClientEvent('qb-phone:client:AddNewSuggestion', PlayerId, SuggestionData)
end)

RegisterNetEvent('qb-phone:server:AddTransaction', function(data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    RLCore.Functions.ExecuteSql(false, "INSERT INTO `crypto_transactions` (`citizenid`, `title`, `message`) VALUES ('"..Player.PlayerData.citizenid.."', '"..escape_sqli(data.TransactionTitle).."', '"..escape_sqli(data.TransactionMessage).."')")
end)

RegisterNetEvent('qb-phone:server:InstallApplication', function(ApplicationData)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    Player.PlayerData.metadata["phonedata"].InstalledApps[ApplicationData.app] = ApplicationData
    Player.Functions.SetMetaData("phonedata", Player.PlayerData.metadata["phonedata"])
end)

RegisterNetEvent('qb-phone:server:RemoveInstallation', function(App)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    Player.PlayerData.metadata["phonedata"].InstalledApps[App] = nil
    Player.Functions.SetMetaData("phonedata", Player.PlayerData.metadata["phonedata"])
end)

RegisterNetEvent('qb-phone:server:addImageToGallery', function(image)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    RLCore.Functions.ExecuteSql(false, "INSERT INTO `phone_gallery` (`citizenid`, `image`) VALUES ('"..Player.PlayerData.citizenid.."', '"..image.."')")
end)

RegisterNetEvent('qb-phone:server:getImageFromGallery', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    exports.ghmattimysql:execute("SELECT * FROM phone_gallery WHERE citizenid = @citizenid ORDER BY `date` DESC", {["@citizenid"] = Player.PlayerData.citizenid}, function(images)
        TriggerClientEvent('qb-phone:refreshImages', src, images)
    end)
end)

RegisterNetEvent('qb-phone:server:RemoveImageFromGallery', function(data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local image = data.image
    RLCore.Functions.ExecuteSql(false, 'DELETE FROM `phone_gallery` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" AND `image` = "'..image..'"')
end)

-- Command

RLCore.Commands.Add("setmetadata", "Set Player Metadata (God Only)", {}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
    if args[1] then
        if args[1] == "trucker" then
            if args[2] then
                local newrep = Player.PlayerData.metadata["jobrep"]
                newrep.trucker = tonumber(args[2])
                Player.Functions.SetMetaData("jobrep", newrep)
            end
        end
    end
end, "god")

RLCore.Commands.Add('bill', 'Bill A Player', {{name = 'id', help = 'Player ID'}, {name = 'amount', help = 'Fine Amount'}}, false, function(source, args)
    local biller = RLCore.Functions.GetPlayer(source)
    local billed = RLCore.Functions.GetPlayer(tonumber(args[1]))
    local amount = tonumber(args[2])
    if biller.PlayerData.job.name == "police" or biller.PlayerData.job.name == 'ambulance' or biller.PlayerData.job.name == 'mechanic' then
        if billed ~= nil then
            if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                if amount and amount > 0 then
                    MySQL.insert(
                        'INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?)',
                        {billed.PlayerData.citizenid, amount, biller.PlayerData.job.name,
                         biller.PlayerData.charinfo.firstname, biller.PlayerData.citizenid})
                    TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                    TriggerClientEvent('RLCore:Notify', source, 'Invoice successfully sent', 'success')
                    TriggerClientEvent('RLCore:Notify', billed.PlayerData.source, 'New Invoice Received')
                else
                    TriggerClientEvent('RLCore:Notify', source, 'Must be a valid amount above 0', 'error')
                end
            else
                TriggerClientEvent('RLCore:Notify', source, 'You cannot bill yourself...', 'error')
            end
        else
            TriggerClientEvent('RLCore:Notify', source, 'Player not Online', 'error')
        end
    else
        TriggerClientEvent('RLCore:Notify', source, 'No Access', 'error')
    end
end)


-- ping

local Pings = {}

RegisterNetEvent('qb-pings:server:SendPing2', function(id)
    local src = source

    TriggerClientEvent('qb-pings:client:DoPing', src, tonumber(id))
end)

RegisterNetEvent('qb-pings:server:acceptping', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if Pings[src] ~= nil then
        TriggerClientEvent('qb-pings:client:AcceptPing', src, Pings[src], RLCore.Functions.GetPlayer(Pings[src].sender))
        TriggerClientEvent('RLCore:Notify', Pings[src].sender, Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.." accepted your ping request!")
        Pings[src] = nil
    else
        TriggerClientEvent('RLCore:Notify', src, "You have no ping...", "error")
    end
end)

RegisterNetEvent('qb-pings:server:denyping', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if Pings[src] ~= nil then
        TriggerClientEvent('RLCore:Notify', Pings[src].sender, "Your ping request has been rejected...", "error")
        TriggerClientEvent('RLCore:Notify', src, "You turned down the ping...", "success")
        Pings[src] = nil
    else
        TriggerClientEvent('RLCore:Notify', src, "You have no ping...", "error")
    end
end)

RegisterNetEvent('qb-pings:server:SendPing', function(id, coords)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local Target = RLCore.Functions.GetPlayer(id)

    if Target ~= nil then
        local OtherItem = Target.Functions.GetItemByName("phone")
        if OtherItem ~= nil then
            TriggerClientEvent('RLCore:Notify', src, "You have requested the location of "..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname)
            Pings[id] = {
                coords = coords,
                sender = src,
            }
            TriggerClientEvent('RLCore:Notify', id, "You have received a ping request from "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname..". Use the app to allow or reject!")
            TriggerClientEvent('qb-phone:ping:client:UiUppers', id, true)
        else
            TriggerClientEvent('RLCore:Notify', src, "Could not send ping...", "error")
        end
    else
        TriggerClientEvent('RLCore:Notify', src, "This person is not in the city...", "error")
    end
end)

RegisterNetEvent('qb-pings:server:SendLocation', function(PingData, SenderData)
    TriggerClientEvent('qb-pings:client:SendLocation', PingData.sender, PingData, SenderData)
end)


RLCore.Commands.Add("p#", "Provide Phone Number", {}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
    local number = Player.PlayerData.charinfo.phone
	TriggerClientEvent("qb-phone:client-annphonenumber", -1, source, GetPlayerName(source), number)
end)

local CasinoTable = {}
local BetNumber = 0
RegisterNetEvent('qb-phone:server:CasinoAddBet', function(data)
    BetNumber = BetNumber + 1
    CasinoTable[BetNumber] = {['Name'] = data.name, ['chanse'] = data.chanse, ['id'] = BetNumber}
    TriggerClientEvent('qb-phone:client:addbetForAll', -1, CasinoTable)
end)

local CasinoBetList = {}
local casino_status = true

RegisterNetEvent('qb-phone:server:BettingAddToTable', function(data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local amount = tonumber(data.amount)
    local CSN = Player.PlayerData.citizenid
    if casino_status then
        if Player.PlayerData.money.bank >= amount then
            if not CasinoBetList[CSN] then
                Player.Functions.RemoveMoney('bank', amount, "casino betting")
                CasinoBetList[CSN] = {['csn'] = CSN, ['amount'] = amount, ['player'] = data.player, ['chanse'] = data.chanse, ['id'] = data.id}
            else
                TriggerClientEvent('RLCore:Notify', src, "You are already betting...", "error")
            end
        else
            TriggerClientEvent('RLCore:Notify', src, "You do not have enough money!", "error")
        end
    else
        TriggerClientEvent('RLCore:Notify', src, "Betting is not active...", "error")
    end
end)

RegisterNetEvent('qb-phone:server:DeleteAndClearTable', function()
    local src = source
    CasinoTable = {}
    CasinoBetList = {}
    BetNumber = 0
    TriggerClientEvent('qb-phone:client:addbetForAll', -1, CasinoTable)
    TriggerClientEvent('RLCore:Notify', src, "Done", "success")
end)

RLCore.Functions.CreateCallback('qb-phone:server:CheckHasBetTable', function(source, cb)
    cb(CasinoTable)
end)


RegisterNetEvent('qb-phone:server:casino_status', function()
    casino_status = not casino_status
end)

RLCore.Functions.CreateCallback('qb-phone:server:CheckHasBetStatus', function(source, cb)
    cb(casino_status)
end)

RegisterNetEvent('qb-phone:server:WineridCasino', function(data)
    local Winer = data.id
    for k, v in pairs(CasinoBetList) do
        if v.id == Winer then
            local OtherPly = RLCore.Functions.GetPlayerByCitizenId(v.csn)
            if OtherPly then
                local amount = v.amount * v.chanse
                OtherPly.Functions.AddMoney('bank', tonumber(amount), "casino winner")
            end
        end
    end
end)

RegisterNetEvent('qb-phone:server:SetJobJobCenter', function(data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if Player.Functions.SetJob(data.job) then
        TriggerClientEvent('RLCore:Notify', src, 'Changed your job to: '..data.label)
    else
        TriggerClientEvent('RLCore:Notify', src, 'Invalid Job...', 'error')
    end
end)

local EmploymentGroup = {}
RegisterNetEvent('qb-phone:server:employment_CreateJobGroup', function(data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local CSN = Player.PlayerData.citizenid
    if Player then
        if not EmploymentGroup[CSN] then
            EmploymentGroup[CSN] = {['CSN'] = CSN, ['GName'] = data.name, ['GPass'] = data.pass, ['Users'] = 1, ['UserName'] = {CSN,}}
            TriggerClientEvent('qb-phone:client:EveryoneGrupAddsForAll', -1, EmploymentGroup)
            TriggerClientEvent('RLCore:Notify', src, "Group created!", "success")
        else
            TriggerClientEvent('RLCore:Notify', src, "You have already created a group...", "error")
        end
    end
end)

RegisterNetEvent('qb-phone:server:employment_DeleteGroup', function(data)
    EmploymentGroup[data.delete] = nil
    TriggerClientEvent('qb-phone:client:EveryoneGrupAddsForAll', -1, EmploymentGroup)
end)

RLCore.Functions.CreateCallback('qb-phone:server:GetGroupsApp', function(source, cb)
    cb(EmploymentGroup)
end)

RegisterNetEvent('qb-phone:server:employment_JoinTheGroup', function(data)
    local src = source
    for k, v in pairs(EmploymentGroup) do
        for ke, ve in pairs(v['UserName']) do
            if ve == data.PCSN then
                TriggerClientEvent('RLCore:Notify', src, "You have already joined a group!", "error")
                return
            end
        end
        table.insert(EmploymentGroup[data.id]['UserName'], data.PCSN)
        EmploymentGroup[data.id]['Users'] = v.Users + 1
        TriggerClientEvent('RLCore:Notify', src, "You joined the group!", "success")
        TriggerClientEvent('qb-phone:client:EveryoneGrupAddsForAll', -1, EmploymentGroup)
        return
    end
end)

RLCore.Functions.CreateCallback('qb-phone:server:employment_CheckPlayerNames', function(source, cb, csn)
    local Names = {}
    for k, v in pairs(EmploymentGroup[csn]['UserName']) do
        local OtherPlayer = RLCore.Functions.GetPlayerByCitizenId(v)
        if OtherPlayer then
            local Name = OtherPlayer.PlayerData.charinfo.firstname.." "..OtherPlayer.PlayerData.charinfo.lastname
            table.insert(Names, Name)
        end
    end
    cb(Names)
end)

RLCore.Functions.CreateCallback('qb-phone:server:GetGroupCSNs', function(source, cb, csn)
    if EmploymentGroup[csn] then
        cb(EmploymentGroup[csn]['UserName'])
    else
        cb(false)
    end
end)

RegisterNetEvent('qb-phone:server:employment_leave_grouped', function(data)
    local src = source
    for k, v in pairs(EmploymentGroup[data.id]['UserName']) do
        if v == data.csn then
            table.remove(EmploymentGroup[data.id]['UserName'], k)
            EmploymentGroup[data.id]['Users'] = EmploymentGroup[data.id]['Users'] - 1
            TriggerClientEvent('RLCore:Notify', src, "Done", "success")
            TriggerClientEvent('qb-phone:client:EveryoneGrupAddsForAll', -1, EmploymentGroup)
            return
        end
    end
end)

RegisterNetEvent('qb-phone:server:SendBillForPlayer_debt', function(data)
    local src = source
    local biller = RLCore.Functions.GetPlayer(src)
    local billed = RLCore.Functions.GetPlayer(tonumber(data.ID))
    local amount = tonumber(data.Amount)
    if billed then
            if amount and amount > 0 then
                exports.ghmattimysql:execute('INSERT INTO phone_debt (citizenid, amount, sender, sendercitizenid, reason) VALUES (@citizenid, @amount, @sender, @sendercitizenid, @reason)', {
                    ['@citizenid'] = billed.PlayerData.citizenid,
                    ['@amount'] = amount,
                    ['@sender'] = biller.PlayerData.charinfo.firstname.." "..biller.PlayerData.charinfo.lastname,
                    ['@sendercitizenid'] = biller.PlayerData.citizenid,
                    ['@reason'] = data.Reason,
                })

                TriggerClientEvent('RLCore:Notify', src, 'Debt successfully sent!', 'success')
                TriggerClientEvent('RLCore:Notify', billed.PlayerData.source, 'New Debt Received')
                Wait(1)
                TriggerClientEvent('qb-phone:RefreshPhoneForDebt', billed.PlayerData.source)
            else
                TriggerClientEvent('RLCore:Notify', src, 'Must be a valid amount above 0', 'error')
            end
    else
        TriggerClientEvent('RLCore:Notify', src, 'Player not Online', 'error')
    end
end)

RLCore.Functions.CreateCallback('qb-phone:server:GetHasBills_debt', function(source, cb)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM phone_debt WHERE `citizenid` = '"..Ply.PlayerData.citizenid.."'", function(Debt) 
        Wait(400)
        if Debt[1] ~= nil then
            cb(Debt)
        end
    end)
end)

RegisterNetEvent('qb-phone:server:debit_AcceptBillForPay', function(data)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)
    local OtherPly = RLCore.Functions.GetPlayerByCitizenId(data.CSN)
    local ID = tonumber(data.id)
    local Amount = tonumber(data.Amount)
    if OtherPly then
        if Ply.PlayerData.money.bank then
            Ply.Functions.RemoveMoney('bank', Amount, "Remove Money For Debt")
            OtherPly.Functions.AddMoney('bank', Amount,"Add Money For Debt")
            RLCore.Functions.ExecuteSql(true, "DELETE FROM `phone_debt` WHERE `id` = " .. ID .. "")
            Wait(1)
            TriggerClientEvent('qb-phone:RefreshPhoneForDebt', OtherPly.PlayerData.source)
        else
            TriggerClientEvent('RLCore:Notify', src, 'You don\'t have enough money...', 'error')
        end
    else
        TriggerClientEvent('RLCore:Notify', src, 'Player not Online', 'error')
    end
end)

RegisterNetEvent('qb-phone:server:wenmo_givemoney_toID', function(data)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)
    local OtherPly = RLCore.Functions.GetPlayer(tonumber(data.ID))
    local Amount = tonumber(data.Amount)
    local Reason = data.Reason
    if OtherPly then
        if Ply.PlayerData.money.bank then
            Ply.Functions.RemoveMoney('bank', Amount, "Wenmo: "..Reason)
            OtherPly.Functions.AddMoney('bank', Amount,"Wenmo: "..Reason)
        else
            TriggerClientEvent('RLCore:Notify', src, 'You don\'t have enough money', 'error')
        end
    else
        TriggerClientEvent('RLCore:Notify', src, 'Player not Online', 'error')
    end
end)

RegisterNetEvent('qb-phone:server:documents_Save_Note_As', function(data)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)
    if data.Type == "New" then

        exports.ghmattimysql:execute('INSERT INTO phone_note (citizenid, title, text, lastupdate) VALUES (@citizenid, @amount, @sender, @sendercitizenid)', {
            ['@citizenid'] = Ply.PlayerData.citizenid,
            ['@title'] = data.Title,
            ['@text'] = data.Text,
            ['@lastupdate'] = data.Time,
        })

        TriggerClientEvent('RLCore:Notify', src, 'Note Saved')
    elseif data.Type == "Update" then
        local ID = tonumber(data.ID)
        
        RLCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_note` WHERE `id` = '"..ID.."'", function(Note)
            if Note[1] ~= nil then
                MySQL.query('DELETE FROM phone_note WHERE id = ?', {ID})

                exports.ghmattimysql:execute('INSERT INTO phone_note (citizenid, title, text, lastupdate) VALUES (@citizenid, @amount, @sender, @sendercitizenid)', {
                    ['@citizenid'] = Ply.PlayerData.citizenid,
                    ['@title'] = data.Title,
                    ['@text'] = data.Text,
                    ['@lastupdate'] = data.Time,
                })

                TriggerClientEvent('RLCore:Notify', src, 'Note Updated', 'success')
            end
        end)
    elseif data.Type == "Delete" then
        local ID = tonumber(data.ID)
        RLCore.Functions.ExecuteSql(true, "DELETE FROM `phone_note` WHERE `id` = " .. ID .. "")

        TriggerClientEvent('RLCore:Notify', src, 'Note Deleted', 'error')
    end
    Wait(100)
    TriggerClientEvent('qb-phone:RefReshNotes_Free_Documents', src)
end)

RLCore.Functions.CreateCallback('qb-phone:server:GetNote_for_Documents_app', function(source, cb)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)


    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_note` WHERE `citizenid` = '"..Ply.PlayerData.citizenid.."'", function(Note)
        Wait(400)
        if Note[1] ~= nil then
            cb(Note)
        end
    end)
end)


local LSBNTable = {}
local LSBNTableID = 0
RegisterNetEvent('qb-phone:server:Send_lsbn_ToChat', function(data)
    LSBNTableID = LSBNTableID + 1
    if data.Type == "Text" then
        LSBNTable[LSBNTableID] = {['Text'] = data.Text, ['Image'] = "none", ['ID'] = LSBNTableID, ['Type'] = data.Type, ['Time'] = data.Time,}
    elseif data.Type == "Image" then
        LSBNTable[LSBNTableID] = {['Text'] = data.Text, ['Image'] = data.Image, ['ID'] = LSBNTableID, ['Type'] = data.Type, ['Time'] = data.Time,}
    end
    local Tables = {
        {
            ['Text'] = data.Text, ['Image'] = data.Image, ['ID'] = LSBNTableID, ['Type'] = data.Type, ['Time'] = data.Time,
        },
    }
    TriggerClientEvent('qb-phone:LSBN-reafy-for-add', -1, Tables, true, data.Text)
end)

RegisterNetEvent('qb-phone:server:GetLSBNchats', function()
    local src = source
    TriggerClientEvent('qb-phone:LSBN-reafy-for-add', src, LSBNTable, false, nil)
end)