RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local RLPhone = {}
local Tweets = {}
local AppAlerts = {}
local MentionedTweets = {}
local Hashtags = {}
local Calls = {}
local Adverts = {}
local GeneratedPlates = {}

RLCore.Commands.Add('hidemenu', 'Hide NUI Script.', {}, false, function(source, args)
    TriggerClientEvent("hidemenu", source)
end)

RegisterServerEvent('rl-phone:server:AddAdvert')
AddEventHandler('rl-phone:server:AddAdvert', function(msg)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local CitizenId = Player.PlayerData.citizenid

    if Adverts[CitizenId] ~= nil then
        Adverts[CitizenId].message = msg
        Adverts[CitizenId].name = "@"..Player.PlayerData.charinfo.firstname..""..Player.PlayerData.charinfo.lastname
        Adverts[CitizenId].number = Player.PlayerData.charinfo.phone
    else
        Adverts[CitizenId] = {
            message = msg,
            name = "@"..Player.PlayerData.charinfo.firstname..""..Player.PlayerData.charinfo.lastname,
            number = Player.PlayerData.charinfo.phone,
        }
    end

    TriggerClientEvent('rl-phone:client:UpdateAdverts', -1, Adverts, "@"..Player.PlayerData.charinfo.firstname..""..Player.PlayerData.charinfo.lastname)
end)

function GetOnlineStatus(number)
    local Target = RLCore.Functions.GetPlayerByPhone(number)
    local retval = false
    if Target ~= nil then retval = true end
    return retval
end

RLCore.Functions.CreateCallback('rl-phone:server:GetPhoneData', function(source, cb)
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
            InstalledApps = Player.PlayerData.metadata["phone"].InstalledApps,
        }

        PhoneData.Adverts = Adverts

        RLCore.Functions.ExecuteSql(false, "SELECT * FROM player_contacts WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' ORDER BY `name` ASC", function(result)
            local Contacts = {}
            if result[1] ~= nil then
                for k, v in pairs(result) do
                    v.status = GetOnlineStatus(v.number)
                end
                
                PhoneData.PlayerContacts = result
            end

            RLCore.Functions.ExecuteSql(false, "SELECT * FROM phone_invoices WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(invoices)
                if invoices[1] ~= nil then
                    PhoneData.Invoices = invoices
                end
                
                RLCore.Functions.ExecuteSql(false, "SELECT * FROM `bbvehicles` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(garageresult)
                    if garageresult[1] ~= nil then
                        -- for k, v in pairs(garageresult) do
                        --     if (RLCore.Shared.Vehicles[v.vehicle] ~= nil) and (Garages[v.garage] ~= nil) then
                        --         v.garage = Garages[v.garage].label
                        --         v.vehicle = RLCore.Shared.Vehicles[v.vehicle].name
                        --         v.brand = RLCore.Shared.Vehicles[v.vehicle].brand
                        --     end
                        -- end

                        PhoneData.Garage = garageresult
                    end
                    
                    RLCore.Functions.ExecuteSql(false, "SELECT * FROM phone_messages WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(messages)
                        if messages ~= nil and next(messages) ~= nil then 
                            PhoneData.Chats = messages
                        end

                        if AppAlerts[Player.PlayerData.citizenid] ~= nil then 
                            PhoneData.Applications = AppAlerts[Player.PlayerData.citizenid]
                        end

                        if MentionedTweets[Player.PlayerData.citizenid] ~= nil then 
                            PhoneData.MentionedTweets = MentionedTweets[Player.PlayerData.citizenid]
                        end

                        if Hashtags ~= nil and next(Hashtags) ~= nil then
                            PhoneData.Hashtags = Hashtags
                        end

                        if Tweets ~= nil and next(Tweets) ~= nil then
                            PhoneData.Tweets = Tweets
                        end

                        RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` ASC', function(mails)
                            if mails[1] ~= nil then
                                for k, v in pairs(mails) do
                                    if mails[k].button ~= nil then
                                        mails[k].button = json.decode(mails[k].button)
                                    end
                                end
                                PhoneData.Mails = mails
                            end

                            RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `crypto_transactions` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` ASC', function(transactions)
                                if transactions[1] ~= nil then
                                    for _, v in pairs(transactions) do
                                        table.insert(PhoneData.CryptoTransactions, {
                                            TransactionTitle = v.title,
                                            TransactionMessage = v.message,
                                        })
                                    end
                                end
    
                                cb(PhoneData)
                            end)
                        end)
                    end)
                end)
            end)
        end)
    end
end)

RLCore.Functions.CreateCallback('rl-phone:server:GetCallState', function(source, cb, ContactData)
    local Target = RLCore.Functions.GetPlayerByPhone(ContactData.number)

    if Target ~= nil then
        if Calls[Target.PlayerData.citizenid] ~= nil then
            if Calls[Target.PlayerData.citizenid].inCall then
                cb(false, true)
            else
                cb(true, true)
            end
        else
            cb(true, true)
        end
    else
        cb(false, false)
    end
end)

RegisterServerEvent('rl-phone:server:SetCallState')
AddEventHandler('rl-phone:server:SetCallState', function(bool)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)

    if Calls[Ply.PlayerData.citizenid] ~= nil then
        Calls[Ply.PlayerData.citizenid].inCall = bool
    else
        Calls[Ply.PlayerData.citizenid] = {}
        Calls[Ply.PlayerData.citizenid].inCall = bool
    end
end)

RegisterServerEvent('rl-phone:server:RemoveMail')
AddEventHandler('rl-phone:server:RemoveMail', function(MailId)
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
    
            TriggerClientEvent('rl-phone:client:UpdateMails', src, mails)
        end)
    end)
end)

function GenerateMailId()
    return math.random(111111, 999999)
end

RegisterServerEvent('rl-phone:server:sendNewMail')
AddEventHandler('rl-phone:server:sendNewMail', function(mailData, srcz)
    local src = source
    if srcz ~= nil then src = srcz end
    local Player = RLCore.Functions.GetPlayer(src)

    if mailData.button == nil then
        RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..Player.PlayerData.citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0')")
    else
        RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..Player.PlayerData.citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')")
    end
    TriggerClientEvent('rl-phone:client:NewMailNotify', src, mailData)
    SetTimeout(200, function()
        RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `player_mails` WHERE `citizenid` = "'..Player.PlayerData.citizenid..'" ORDER BY `date` DESC', function(mails)
            if mails[1] ~= nil then
                for k, v in pairs(mails) do
                    if mails[k].button ~= nil then
                        mails[k].button = json.decode(mails[k].button)
                    end
                end
            end
    
            TriggerClientEvent('rl-phone:client:UpdateMails', src, mails)
        end)
    end)
end)

RegisterServerEvent('rl-phone:server:sendNewMailToOffline')
AddEventHandler('rl-phone:server:sendNewMailToOffline', function(citizenid, mailData)
    local Player = RLCore.Functions.GetPlayerByCitizenId(citizenid)

    if Player ~= nil then
        local src = Player.PlayerData.source

        if mailData.button == nil then
            RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES ('"..Player.PlayerData.citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0')")
            TriggerClientEvent('rl-phone:client:NewMailNotify', src, mailData)
        else
            RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_mails` (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES ('"..Player.PlayerData.citizenid.."', '"..mailData.sender.."', '"..mailData.subject.."', '"..mailData.message.."', '"..GenerateMailId().."', '0', '"..json.encode(mailData.button).."')")
            TriggerClientEvent('rl-phone:client:NewMailNotify', src, mailData)
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
        
                TriggerClientEvent('rl-phone:client:UpdateMails', src, mails)
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

RegisterServerEvent('rl-phone:server:sendNewEventMail')
AddEventHandler('rl-phone:server:sendNewEventMail', function(citizenid, mailData)
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
    
            TriggerClientEvent('rl-phone:client:UpdateMails', src, mails)
        end)
    end)
end)

RegisterServerEvent('rl-phone:server:ClearButtonData')
AddEventHandler('rl-phone:server:ClearButtonData', function(mailId)
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
    
            TriggerClientEvent('rl-phone:client:UpdateMails', src, mails)
        end)
    end)
end)

RegisterServerEvent('rl-phone:server:MentionedPlayer')
AddEventHandler('rl-phone:server:MentionedPlayer', function(firstName, lastName, TweetMessage)
    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.charinfo.firstname == firstName and Player.PlayerData.charinfo.lastname == lastName) then
                RLPhone.SetPhoneAlerts(Player.PlayerData.citizenid, "twitter")
                RLPhone.AddMentionedTweet(Player.PlayerData.citizenid, TweetMessage)
                TriggerClientEvent('rl-phone:client:GetMentioned', Player.PlayerData.source, TweetMessage, AppAlerts[Player.PlayerData.citizenid]["twitter"])
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

RegisterServerEvent('rl-phone:server:CallContact')
AddEventHandler('rl-phone:server:CallContact', function(TargetData, CallId, AnonymousCall)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)
    local Target = RLCore.Functions.GetPlayerByPhone(TargetData.number)

    if Target ~= nil then
        TriggerClientEvent('rl-phone:client:GetCalled', Target.PlayerData.source, Ply.PlayerData.charinfo.phone, CallId, AnonymousCall)
    end
end)

RLCore.Functions.CreateCallback('rl-phone:server:PayInvoice', function(source, cb, society, amount, invoiceId)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)
    local Invoices = {}

    Ply.Functions.RemoveMoney('bank', amount, "paid-invoice")
    TriggerEvent("bb-bossmenu:server:addAccountMoney", society, amount)
    RLCore.Functions.ExecuteSql(true, "DELETE FROM `phone_invoices` WHERE `invoiceid` = " .. tonumber(invoiceId) .. "")
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '"..Ply.PlayerData.citizenid.."'", function(invoices)
        if invoices[1] ~= nil then
            Invoices = invoices
        end
        cb(true, Invoices)
    end)
end)

RLCore.Functions.CreateCallback('rl-phone:server:DeclineInvoice', function(source, cb, sender, amount, invoiceId)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)
    local Trgt = RLCore.Functions.GetPlayerByCitizenId(sender)
    local Invoices = {}

    RLCore.Functions.ExecuteSql(true, "DELETE FROM `phone_invoices` WHERE `invoiceid` = " .. tonumber(invoiceId) .. "")
    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '"..Ply.PlayerData.citizenid.."'", function(invoices)
        if invoices[1] ~= nil then
            for k, v in pairs(invoices) do
                local Target = RLCore.Functions.GetPlayerByCitizenId(v.sender)
                if Target ~= nil then
                    v.number = Target.PlayerData.charinfo.phone
                else
                    RLCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..v.sender.."'", function(res)
                        if res[1] ~= nil then
                            res[1].charinfo = json.decode(res[1].charinfo)
                            v.number = res[1].charinfo.phone
                        else
                            v.number = nil
                        end
                    end)
                end
            end
            Invoices = invoices
        end
        cb(true, invoices)
    end)
end)

RegisterServerEvent('rl-phone:server:UpdateHashtags')
AddEventHandler('rl-phone:server:UpdateHashtags', function(Handle, messageData)
    if Hashtags[Handle] ~= nil and next(Hashtags[Handle]) ~= nil then
        table.insert(Hashtags[Handle].messages, messageData)
    else
        Hashtags[Handle] = {
            hashtag = Handle,
            messages = {}
        }
        table.insert(Hashtags[Handle].messages, messageData)
    end
    TriggerClientEvent('rl-phone:client:UpdateHashtags', -1, Handle, messageData)
end)

RLPhone.AddMentionedTweet = function(citizenid, TweetData)
    if MentionedTweets[citizenid] == nil then MentionedTweets[citizenid] = {} end
    table.insert(MentionedTweets[citizenid], TweetData)
end

RLPhone.SetPhoneAlerts = function(citizenid, app, alerts)
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

RLCore.Functions.CreateCallback('rl-phone:server:GetContactPictures', function(source, cb, Chats)
    for k, v in pairs(Chats) do
        local Player = RLCore.Functions.GetPlayerByPhone(v.number)
        
        RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `charinfo` LIKE '%"..v.number.."%'", function(result)
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
end)

RLCore.Functions.CreateCallback('rl-phone:server:GetContactPicture', function(source, cb, Chat)
    local Player = RLCore.Functions.GetPlayerByPhone(Chat.number)

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `charinfo` LIKE '%"..Chat.number.."%'", function(result)
        local MetaData = json.decode(result[1].metadata)

        if MetaData.phone.profilepicture ~= nil then
            Chat.picture = MetaData.phone.profilepicture
        else
            Chat.picture = "default"
        end
    end)
    SetTimeout(100, function()
        cb(Chat)
    end)
end)

RLCore.Functions.CreateCallback('rl-phone:server:GetPicture', function(source, cb, number)
    local Player = RLCore.Functions.GetPlayerByPhone(number)
    local Picture = nil

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `charinfo` LIKE '%"..number.."%'", function(result)
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

RegisterServerEvent('rl-phone:server:SetPhoneAlerts')
AddEventHandler('rl-phone:server:SetPhoneAlerts', function(app, alerts)
    local src = source
    local CitizenId = RLCore.Functions.GetPlayer(src).citizenid
    RLPhone.SetPhoneAlerts(CitizenId, app, alerts)
end)

RegisterServerEvent('rl-phone:server:UpdateTweets')
AddEventHandler('rl-phone:server:UpdateTweets', function(NewTweets, TweetData)
    Tweets = NewTweets
    local TwtData = TweetData
    local src = source
    TriggerClientEvent('rl-phone:client:UpdateTweets', -1, src, Tweets, TwtData)
end)

RegisterServerEvent('rl-phone:server:TransferMoney')
AddEventHandler('rl-phone:server:TransferMoney', function(iban, amount)
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
                    TriggerClientEvent('rl-phone:client:TransferMoney', recieverSteam.PlayerData.source, amount, recieverSteam.PlayerData.money.bank)
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

RegisterServerEvent('rl-phone:server:EditContact')
AddEventHandler('rl-phone:server:EditContact', function(newName, newNumber, newIban, oldName, oldNumber, oldIban)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    RLCore.Functions.ExecuteSql(false, "UPDATE `player_contacts` SET `name` = '"..newName.."', `number` = '"..newNumber.."', `iban` = '"..newIban.."' WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `name` = '"..oldName.."' AND `number` = '"..oldNumber.."'")
end)

RegisterServerEvent('rl-phone:server:RemoveContact')
AddEventHandler('rl-phone:server:RemoveContact', function(Name, Number)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    
    RLCore.Functions.ExecuteSql(false, "DELETE FROM `player_contacts` WHERE `name` = '"..Name.."' AND `number` = '"..Number.."' AND `citizenid` = '"..Player.PlayerData.citizenid.."'")
end)

RegisterServerEvent('rl-phone:server:AddNewContact')
AddEventHandler('rl-phone:server:AddNewContact', function(name, number, iban)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    RLCore.Functions.ExecuteSql(false, "INSERT INTO `player_contacts` (`citizenid`, `name`, `number`, `iban`) VALUES ('"..Player.PlayerData.citizenid.."', '"..tostring(name).."', '"..tostring(number).."', '"..tostring(iban).."')")
end)

RegisterServerEvent('rl-phone:server:UpdateMessages')
AddEventHandler('rl-phone:server:UpdateMessages', function(ChatMessages, ChatNumber, New)
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
                        TriggerClientEvent('rl-phone:client:UpdateMessages', TargetData.PlayerData.source, ChatMessages, SenderData.PlayerData.charinfo.phone, false)
                    else
                        -- Insert for target
                        RLCore.Functions.ExecuteSql(false, "INSERT INTO `phone_messages` (`citizenid`, `number`, `messages`) VALUES ('"..TargetData.PlayerData.citizenid.."', '"..SenderData.PlayerData.charinfo.phone.."', '"..json.encode(ChatMessages).."')")
                                            
                        -- Insert for sender
                        RLCore.Functions.ExecuteSql(false, "INSERT INTO `phone_messages` (`citizenid`, `number`, `messages`) VALUES ('"..SenderData.PlayerData.citizenid.."', '"..TargetData.PlayerData.charinfo.phone.."', '"..json.encode(ChatMessages).."')")

                        -- Send notification & Update messages for target
                        TriggerClientEvent('rl-phone:client:UpdateMessages', TargetData.PlayerData.source, ChatMessages, SenderData.PlayerData.charinfo.phone, true)
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

RegisterServerEvent('rl-phone:server:AddRecentCall')
AddEventHandler('rl-phone:server:AddRecentCall', function(type, data)
    local src = source
    local Ply = RLCore.Functions.GetPlayer(src)

    local Hour = os.date("%H")
    local Minute = os.date("%M")
    local label = Hour..":"..Minute

    TriggerClientEvent('rl-phone:client:AddRecentCall', src, data, label, type)

    local Trgt = RLCore.Functions.GetPlayerByPhone(data.number)
    if Trgt ~= nil then
        TriggerClientEvent('rl-phone:client:AddRecentCall', Trgt.PlayerData.source, {
            name = Ply.PlayerData.charinfo.firstname .. " " ..Ply.PlayerData.charinfo.lastname,
            number = Ply.PlayerData.charinfo.phone,
            anonymous = anonymous
        }, label, "outgoing")
    end
end)

RegisterServerEvent('rl-phone:server:CancelCall')
AddEventHandler('rl-phone:server:CancelCall', function(ContactData)
    local Ply = RLCore.Functions.GetPlayerByPhone(ContactData.TargetData.number)

    if Ply ~= nil then
        TriggerClientEvent('rl-phone:client:CancelCall', Ply.PlayerData.source)
    end
end)

RegisterServerEvent('rl-phone:server:AnswerCall')
AddEventHandler('rl-phone:server:AnswerCall', function(CallData)
    local Ply = RLCore.Functions.GetPlayerByPhone(CallData.TargetData.number)

    if Ply ~= nil then
        TriggerClientEvent('rl-phone:client:AnswerCall', Ply.PlayerData.source)
    end
end)

RegisterServerEvent('rl-phone:server:SaveMetaData')
AddEventHandler('rl-phone:server:SaveMetaData', function(MData)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(result)
        local MetaData = json.decode(result[1].metadata)
        MetaData.phone = MData
        RLCore.Functions.ExecuteSql(false, "UPDATE `players` SET `metadata` = '"..json.encode(MetaData).."' WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'")
    end)

    Player.Functions.SetMetaData("phone", MData)
end)

function escape_sqli(source)
    local replacements = { ['"'] = '\\"', ["'"] = "\\'" }
    return source:gsub( "['\"]", replacements ) -- or string.gsub( source, "['\"]", replacements )
end

RLCore.Functions.CreateCallback('rl-phone:server:FetchResult', function(source, cb, search)
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

function SplitStringToArray(string)
    local retval = {}
    for i in string.gmatch(string, "%S+") do
        table.insert(retval, i)
    end
    return retval
end

RLCore.Functions.CreateCallback('rl-phone:server:GetVehicleSearchResults', function(source, cb, search)
    local src = source
    local search = escape_sqli(search)
    local searchData = {}
    RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `bbvehicles` WHERE `plate` LIKE "%'..search..'%" OR `citizenid` = "'..search..'"', function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                RLCore.Functions.ExecuteSql(true, 'SELECT * FROM `players` WHERE `citizenid` = "'..result[k].citizenid..'"', function(player)
                    if player[1] ~= nil then 
                        local charinfo = json.decode(player[1].charinfo)
                        local vehicleInfo = RLCore.Shared.Vehicles[result[k].vehicle]
                        if vehicleInfo ~= nil then 
                            table.insert(searchData, {
                                plate = result[k].plate,
                                status = true,
                                owner = charinfo.firstname .. " " .. charinfo.lastname,
                                citizenid = result[k].citizenid,
                                label = vehicleInfo["name"]
                            })
                        else
                            table.insert(searchData, {
                                plate = result[k].plate,
                                status = true,
                                owner = charinfo.firstname .. " " .. charinfo.lastname,
                                citizenid = result[k].citizenid,
                                label = "Name not found.."
                            })
                        end
                    end
                end)
            end
        else
            if GeneratedPlates[search] ~= nil then
                table.insert(searchData, {
                    plate = GeneratedPlates[search].plate,
                    status = GeneratedPlates[search].status,
                    owner = GeneratedPlates[search].owner,
                    citizenid = GeneratedPlates[search].citizenid,
                    label = "Brand unknown.."
                })
            else
                local ownerInfo = GenerateOwnerName()
                GeneratedPlates[search] = {
                    plate = search,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.citizenid,
                }
                table.insert(searchData, {
                    plate = search,
                    status = true,
                    owner = ownerInfo.name,
                    citizenid = ownerInfo.citizenid,
                    label = "Brand unknown.."
                })
            end
        end
        cb(searchData)
    end)
end)

RLCore.Functions.CreateCallback('rl-phone:server:ScanPlate', function(source, cb, plate)
    local src = source
    local vehicleData = {}
    if plate ~= nil then 
        RLCore.Functions.ExecuteSql(false, 'SELECT * FROM `bbvehicles` WHERE `plate` = "'..plate..'"', function(result)
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

function GenerateOwnerName()
    local names = {
        [1] = { name = "Jan Bloksteen", citizenid = "DSH091G93" },
        [2] = { name = "Jay Dendam", citizenid = "AVH09M193" },
        [3] = { name = "Ben Klaariskees", citizenid = "DVH091T93" },
        [4] = { name = "Karel Bakker", citizenid = "GZP091G93" },
        [5] = { name = "Klaas Adriaan", citizenid = "DRH09Z193" },
        [6] = { name = "Nico Wolters", citizenid = "KGV091J93" },
        [7] = { name = "Mark Hendrickx", citizenid = "ODF09S193" },
        [8] = { name = "Bert Johannes", citizenid = "KSD0919H3" },
        [9] = { name = "Karel de Grote", citizenid = "NDX091D93" },
        [10] = { name = "Jan Pieter", citizenid = "ZAL0919X3" },
        [11] = { name = "Huig Roelink", citizenid = "ZAK09D193" },
        [12] = { name = "Corneel Boerselman", citizenid = "POL09F193" },
        [13] = { name = "Hermen Klein Overmeen", citizenid = "TEW0J9193" },
        [14] = { name = "Bart Rielink", citizenid = "YOO09H193" },
        [15] = { name = "Antoon Henselijn", citizenid = "QBC091H93" },
        [16] = { name = "Aad Keizer", citizenid = "YDN091H93" },
        [17] = { name = "Thijn Kiel", citizenid = "PJD09D193" },
        [18] = { name = "Henkie Krikhaar", citizenid = "RND091D93" },
        [19] = { name = "Teun Blaauwkamp", citizenid = "QWE091A93" },
        [20] = { name = "Dries Stielstra", citizenid = "KJH0919M3" },
        [21] = { name = "Karlijn Hensbergen", citizenid = "ZXC09D193" },
        [22] = { name = "Aafke van Daalen", citizenid = "XYZ0919C3" },
        [23] = { name = "Door Leeferds", citizenid = "ZYX0919F3" },
        [24] = { name = "Nelleke Broedersen", citizenid = "IOP091O93" },
        [25] = { name = "Renske de Raaf", citizenid = "PIO091R93" },
        [26] = { name = "Krisje Moltman", citizenid = "LEK091X93" },
        [27] = { name = "Mirre Steevens", citizenid = "ALG091Y93" },
        [28] = { name = "Joosje Kalvenhaar", citizenid = "YUR09E193" },
        [29] = { name = "Mirte Ellenbroek", citizenid = "SOM091W93" },
        [30] = { name = "Marlieke Meilink", citizenid = "KAS09193" },
    }
    return names[math.random(1, #names)]
end

RLCore.Functions.CreateCallback('rl-phone:server:GetGarageVehicles', function(source, cb)
    local Player = RLCore.Functions.GetPlayer(source)
    local Vehicles = {}

    RLCore.Functions.ExecuteSql(false, "SELECT * FROM `bbvehicles` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                local VehicleData = RLCore.Shared.Vehicles[v.model]

                local VehicleGarage = "Unknown"
                if v.state ~= 'unknown' then
                    if v.state == 'garage' then
                        local parking = json.decode(v.parking)
                        VehicleGarage = parking[2]
                    elseif v.state == 'impound' then
                        VehicleGarage = 'Impound'
                    end
                end

                local stats = json.decode(v.stats)
                if stats["body_damage"] ~= nil then
                    local dmg = (((stats["body_damage"] + stats["engine_damage"]) / 10 / 2))
                    local vehdata = {
                        fullname = VehicleData["name"],
                        brand = VehicleData["name"],
                        model = VehicleData["name"],
                        plate = v.plate,
                        garage = VehicleGarage,
                        fuel = stats['fuel'],
                        damage = math.ceil(dmg),
                    }

                    table.insert(Vehicles, vehdata)
                else
                    local vehdata = {
                        fullname = VehicleData["name"],
                        brand = VehicleData["name"],
                        model = VehicleData["name"],
                        plate = v.plate,
                        garage = VehicleGarage,
                        fuel = 'Unkown',
                        damage = 'Unknown',
                    }

                    table.insert(Vehicles, vehdata)
                end
            end
            cb(Vehicles)
        else
            cb(nil)
        end
    end)
end)

RLCore.Functions.CreateCallback('rl-phone:server:HasPhone', function(source, cb)
    local Player = RLCore.Functions.GetPlayer(source)
    
    if Player ~= nil then
        local HasPhone = Player.Functions.GetItemByName("phone")
        local HasPhoneAss = Player.Functions.GetItemByName("assphone")
        local retval = false

        if HasPhone ~= nil or HasPhoneAss ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
end)

RLCore.Functions.CreateCallback('rl-phone:server:CanTransferMoney', function(source, cb, amount, iban)
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
                TriggerClientEvent('RLCore:Notify', src, "This account number does not exist!", "error")
                cb(false)
            end
        end)
    end
end)

RegisterServerEvent('rl-phone:server:GiveContactDetails')
AddEventHandler('rl-phone:server:GiveContactDetails', function(PlayerId)
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

    TriggerClientEvent('rl-phone:client:AddNewSuggestion', PlayerId, SuggestionData)
end)

RegisterServerEvent('rl-phone:server:AddTransaction')
AddEventHandler('rl-phone:server:AddTransaction', function(data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    RLCore.Functions.ExecuteSql(false, "INSERT INTO `crypto_transactions` (`citizenid`, `title`, `message`) VALUES ('"..Player.PlayerData.citizenid.."', '"..escape_sqli(data.TransactionTitle).."', '"..escape_sqli(data.TransactionMessage).."')")
end)

--[[ RLCore.Functions.CreateCallback('rl-phone:server:GetCurrentDrivers', function(source, cb)
    local Lawyers = {}
    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == "taxi" then
                table.insert(Lawyers, {
                    name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
                    phone = Player.PlayerData.charinfo.phone,
                })
            end
        end
    end
    cb(Lawyers, RLCore.Functions.GetPlayer(source).PlayerData.job.name == "taxi")
end) ]]

RLCore.Functions.CreateCallback('rl-phone:server:GetCurrentLawyers', function(source, cb)
    local Lawyers = {}
    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == "lawyer" then
                table.insert(Lawyers, {
                    name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
                    phone = Player.PlayerData.charinfo.phone,
                })
            end
        end
    end
    cb(Lawyers)
end)

RegisterServerEvent('rl-phone:server:InstallApplication')
AddEventHandler('rl-phone:server:InstallApplication', function(ApplicationData)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    Player.PlayerData.metadata["phonedata"].InstalledApps[ApplicationData.app] = ApplicationData
    Player.Functions.SetMetaData("phonedata", Player.PlayerData.metadata["phonedata"])
end)

RegisterServerEvent('rl-phone:server:restoreRented')
AddEventHandler('rl-phone:server:restoreRented', function(money)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    Player.Functions.AddMoney("bank", money)
end)

RegisterServerEvent('rl-phone:server:removeMoney')
AddEventHandler('rl-phone:server:removeMoney', function(type, money)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    Player.Functions.RemoveMoney(type, money)
end)

RegisterServerEvent('rl-phone:server:RemoveInstallation')
AddEventHandler('rl-phone:server:RemoveInstallation', function(App)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    Player.PlayerData.metadata["phonedata"].InstalledApps[App] = nil
    Player.Functions.SetMetaData("phonedata", Player.PlayerData.metadata["phonedata"])
end)

RLCore.Commands.Add("setmetadata", "Set metadata", {}, false, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
	
	if args[1] ~= nil then
		if args[1] == "trucker" then
			if args[2] ~= nil then
				local newrep = Player.PlayerData.metadata["jobrep"]
				newrep.trucker = tonumber(args[2])
				Player.Functions.SetMetaData("jobrep", newrep)
			end
		end
	end
end, "god")

local TaxiCalls = {}
local CurrentCallID = 1
RegisterServerEvent('rl-phone:server:CallDriver')
AddEventHandler('rl-phone:server:CallDriver', function(coords)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    CurrentCallID = CurrentCallID + 1

    print(CurrentCallID)
    TaxiCalls[CurrentCallID] = { name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname, coords = coords }
    TriggerClientEvent("rl-phone:client:AddTaxiCall", -1, CurrentCallID, TaxiCalls[CurrentCallID])
end)

RegisterServerEvent('rl-phone:server:AcceptDriverCall')
AddEventHandler('rl-phone:server:AcceptDriverCall', function(ID)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    if TaxiCalls[ID] then
        TriggerClientEvent("rl-phone:client:RemoveTaxiCall", -1, ID)
        TriggerClientEvent("rl-phone:client:AcceptDriverCall", -1, TaxiCalls[ID])
        TriggerClientEvent('RLCore:Notify', src, "The player location is marked for you on the GPS.")
        TaxiCalls[ID] = nil
    end
end)

local VehiclePlate = 0
RegisterServerEvent('rl-phone:server:spawnVehicle')
AddEventHandler('rl-phone:server:spawnVehicle', function(data)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    VehiclePlate = VehiclePlate + 1

    if Config.RentelVehicles[data.model] and data.price <= Player['PlayerData']['money']['cash'] then
        data['plate'] = 'RENT-' .. VehiclePlate
        TriggerClientEvent('rl-phone:client:spawnVehicle', src, data)
        TriggerEvent('rl-phone:server:clearVehicleTrunk', data['plate'])
    else
        TriggerClientEvent('RLCore:Notify', src, "You don't have enough money.", 'error')
    end
end)

RegisterServerEvent('rl-phone:server:clearVehicleTrunk')
AddEventHandler('rl-phone:server:clearVehicleTrunk', function(plate)
    RLCore.Functions.ExecuteSql(false, "DELETE FROM `trunkitems` WHERE `plate` = '"..plate.."'")
end)

RLCore.Functions.CreateCallback('rl-phone:server:GetCurrentDrivers', function(source, cb)
    local drivers = {}
    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == "taxi" then
                table.insert(drivers, {
                    name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
                    phone = Player.PlayerData.charinfo.phone,
                })
            end
        end
    end
    cb(drivers)
end)