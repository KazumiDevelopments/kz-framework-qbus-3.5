RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local Plates = {}
cuffedPlayers = {}
PlayerStatus = {}
Casings = {}
BloodDrops = {}
FingerDrops = {}
local Objects = {}

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000 * 60 * 10)
        local curCops = GetCurrentCops()
        TriggerClientEvent("police:SetCopCount", -1, curCops)
    end
end)

RegisterServerEvent('police:server:CuffPlayer')
AddEventHandler('police:server:CuffPlayer', function(playerId, soffCuff)
    local src = source
    local Player = RLCore.Functions.GetPlayer(source)
    local CuffedPlayer = RLCore.Functions.GetPlayer(playerId)
    if CuffedPlayer ~= nil then
        if Player.Functions.GetItemByName("handcuffs") ~= nil or Player.PlayerData.job.name == "police" then
            TriggerClientEvent("police:client:GetCuffed", playerId, src, soffCuff)           
        else
            TriggerClientEvent('RLCore:Notify', src, "You dont have handcuffs and you are not officer.", "error")
        end
    end 
end)

RegisterNetEvent("police:server:CufferAnimation")
AddEventHandler("police:server:CufferAnimation", function(playerId, animType)
    local src = source
    TriggerClientEvent("police:client:CufferAnimation", playerId, src, animType)
end)

RegisterServerEvent('police:server:EscortPlayer')
AddEventHandler('police:server:EscortPlayer', function(playerId)
    local src = source
    local Player = RLCore.Functions.GetPlayer(source)
    local EscortPlayer = RLCore.Functions.GetPlayer(playerId)
    if EscortPlayer ~= nil then
        --if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") or (EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"]) then
            TriggerClientEvent("police:client:GetEscorted", EscortPlayer.PlayerData.source, Player.PlayerData.source)
       -- else
        --TriggerClientEvent('chat:addMessage', source, {
        --template = '<div class="chat-message emergency">Person is not dead or handcuffed!  </div>',
        --})
        --end
    end
end)

RegisterServerEvent('police:server:KidnapPlayer')
AddEventHandler('police:server:KidnapPlayer', function(playerId)
    local src = source
    local Player = RLCore.Functions.GetPlayer(source)
    local EscortPlayer = RLCore.Functions.GetPlayer(playerId)
    if EscortPlayer ~= nil then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"] then
            TriggerClientEvent("police:client:GetKidnappedTarget", EscortPlayer.PlayerData.source, Player.PlayerData.source)
            TriggerClientEvent("police:client:GetKidnappedDragger", Player.PlayerData.source, EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="chat-message emergency">Person is not dead or handcuffed!  </div>',
            })  
        end
    end
end)

RegisterServerEvent('police:server:SetPlayerOutVehicle')
AddEventHandler('police:server:SetPlayerOutVehicle', function(playerId)
    local src = source
    local Player = RLCore.Functions.GetPlayer(source)
    local EscortPlayer = RLCore.Functions.GetPlayer(playerId)
    if EscortPlayer ~= nil then
        --if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
            TriggerClientEvent("police:client:SetOutVehicle", EscortPlayer.PlayerData.source)
            TriggerClientEvent("police:client:GetEscorted", EscortPlayer.PlayerData.source, Player.PlayerData.source)

        --else
        --    TriggerClientEvent('chat:addMessage', source, {
        --    template = '<div class="chat-message emergency">Person is not dead or handcuffed!  </div>',
        --    })
        --end
    end
end)

RegisterServerEvent('police:server:PutPlayerInVehicle')
AddEventHandler('police:server:PutPlayerInVehicle', function(playerId)
    local src = source
    local Player = RLCore.Functions.GetPlayer(source)
    local EscortPlayer = RLCore.Functions.GetPlayer(playerId)
    if EscortPlayer ~= nil then
        --if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
        TriggerClientEvent("police:client:PutInVehicle", EscortPlayer.PlayerData.source)
        --else
        --    TriggerClientEvent('chat:addMessage', source, {
        --    template = '<div class="chat-message emergency">Person is not dead or handcuffed!  </div>',
        --    })
        --end
    end
end)

RLCore.Commands.Add("fine", "Bill Player", {{name="id", help="Player ID"}, {name="amount", help="Fine Amount"}, {name="title", help="Fine Title"}}, false, function(source, args)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local OtherPlayer = RLCore.Functions.GetPlayer(tonumber(args[1]))
    local price = tonumber(args[2])
    local title = args[3] ~= nil and args[3] or "None"
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == 'ambulance' or Player.PlayerData.job.name == 'mechanic' or Player.PlayerData.job.name == 'cardealer' then
        if OtherPlayer ~= nil then
            if price and price > 0 then
                RLCore.Functions.ExecuteSql(false, "INSERT INTO `phone_invoices` (`citizenid`, `amount`, `society`, `title`) VALUES ('" .. OtherPlayer.PlayerData.citizenid .. "', " .. price .. ", '" .. Player.PlayerData.job.name .. "', '" .. title .. "')", function()
                    TriggerClientEvent('RLCore:Notify', OtherPlayer.PlayerData.source, "You received a fine for a total of $" .. price)
                    TriggerClientEvent("rl-phone:RefreshPhone", OtherPlayer.PlayerData.source)

                    TriggerClientEvent('chat:addMessage', src, {
                        template = '<div class="chat-message"><b>BILL:</b> {0}</div>',
                        args = { "You wrote a bill for " .. price .. " dollar(s)" }
                    })
                end)
            else
                TriggerClientEvent('chat:addMessage', src, {
                    template = '<div class="chat-message server"><b>SYSTEM:</b> {0}</div>',
                    args = { "Invaild Amount" }
                })
            end
        else
            TriggerClientEvent('chat:addMessage', src, {
                template = '<div class="chat-message server"><b>SYSTEM:</b> {0}</div>',
                args = { "Invaild Player ID" }
            })
        end
    end
end)

RegisterServerEvent('police:server:JailPlayer')
AddEventHandler('police:server:JailPlayer', function(playerId, time)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local OtherPlayer = RLCore.Functions.GetPlayer(playerId)
    local currentDate = os.date("*t")
    if currentDate.day == 31 then currentDate.day = 30 end

    if Player.PlayerData.job.name == "police" then
        if OtherPlayer ~= nil then
            OtherPlayer.Functions.SetMetaData("injail", time)
            OtherPlayer.Functions.SetMetaData("criminalrecord", {
                ["hasRecord"] = true,
                ["date"] = currentDate
            })
            TriggerClientEvent("police:client:SendToJail", OtherPlayer.PlayerData.source, time)
            TriggerClientEvent('RLCore:Notify', src, "You sent the person to prison for "..time.." months")
        end
    end
end)

RegisterServerEvent('police:server:SetHandcuffStatus')
AddEventHandler('police:server:SetHandcuffStatus', function(isHandcuffed)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	if Player ~= nil then
		Player.Functions.SetMetaData("ishandcuffed", isHandcuffed)
	end
end)

RLCore.Functions.CreateCallback('police:server:isPlayerCuffed', function(source, cb, playerId)
    local Player = RLCore.Functions.GetPlayer(playerId)
    cb(Player.PlayerData.metadata["ishandcuffed"])
end)

RegisterServerEvent('heli:spotlight')
AddEventHandler('heli:spotlight', function(state)
	local serverID = source
	TriggerClientEvent('heli:spotlight', -1, serverID, state)
end)

RegisterServerEvent('police:server:FlaggedPlateTriggered')
AddEventHandler('police:server:FlaggedPlateTriggered', function(camId, plate, street1, street2, blipSettings)
    local src = source
    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                if street2 ~= nil then
                    TriggerClientEvent("112:client:SendPoliceAlert", v, "flagged", {
                        camId = camId,
                        plate = plate,
                        streetLabel = street1.. " "..street2,
                    }, blipSettings)
                else
                    TriggerClientEvent("112:client:SendPoliceAlert", v, "flagged", {
                        camId = camId,
                        plate = plate,
                        streetLabel = street1
                    }, blipSettings)
                end
            end
        end
	end
end)

RegisterServerEvent('police:server:PoliceAlertMessage')
AddEventHandler('police:server:PoliceAlertMessage', function(title, streetLabel, coords)
    local src = source

    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("police:client:PoliceAlertMessage", v, title, streetLabel, coords)
            elseif Player.Functions.GetItemByName("radioscanner") ~= nil and math.random(1, 100) <= 50 then
                TriggerClientEvent("police:client:PoliceAlertMessage", v, title, streetLabel, coords)
            end
        end
    end
end)

RegisterServerEvent('police:server:VehicleCall')
AddEventHandler('police:server:VehicleCall', function(pos, msg, alertTitle, streetLabel, modelPlate, modelName)
    local src = source
    local alertData = {
        title = "Voertuigdiefstal",
        coords = {x = pos.x, y = pos.y, z = pos.z},
        description = msg,
    }
    print(streetLabel)
    TriggerClientEvent("police:client:VehicleCall", -1, pos, alertTitle, streetLabel, modelPlate, modelName)
    TriggerClientEvent("rl-phone:client:addPoliceAlert", -1, alertData)
end)

RegisterServerEvent('police:server:HouseRobberyCall')
AddEventHandler('police:server:HouseRobberyCall', function(coords, message, gender, streetLabel)
    local src = source
    local alertData = {
        title = "Huisinbraak",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = message,
    }
    TriggerClientEvent("police:client:HouseRobberyCall", -1, coords, message, gender, streetLabel)
    TriggerClientEvent("rl-phone:client:addPoliceAlert", -1, alertData)
end)

RegisterServerEvent('police:server:SendEmergencyMessage')
AddEventHandler('police:server:SendEmergencyMessage', function(coords, message)
    local src = source
    local MainPlayer = RLCore.Functions.GetPlayer(src)
    local alertData = {
        title = "112 Melding - "..MainPlayer.PlayerData.charinfo.firstname .. " " .. MainPlayer.PlayerData.charinfo.lastname .. " ("..src..")",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = message,
    }
    TriggerClientEvent("rl-phone:client:addPoliceAlert", -1, alertData)
    TriggerClientEvent('police:server:SendEmergencyMessageCheck', -1, MainPlayer, message, coords)
end)

RegisterServerEvent('police:server:checkBank')
AddEventHandler('police:server:checkBank', function(playerId)
    local src = source
    local SearchedPlayer = RLCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message success">Player has $'..SearchedPlayer.PlayerData.money["bank"]..' in his bank account.</div>',
        })
    end
end)

RegisterServerEvent('police:server:checkLicenses')
AddEventHandler('police:server:checkLicenses', function(playerId)
    local src = source
    local SearchedPlayer = RLCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        local licences = SearchedPlayer["PlayerData"]['metadata']['licences']
        local str = ""
        local index = 0
        local max = 0

        for k,v in pairs(licences) do
            if k and v then
                str = str .. k:gsub("^%l", string.upper) .. ', '
            end
        end
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="chat-message success">Player Licenses: ' .. (#str == 0 and "No Licenses" or str:sub(1,#str-2)) .. '</div>',
        })
    end
end)

RegisterServerEvent('police:server:checkFines')
AddEventHandler('police:server:checkFines', function(playerId)
    local src = source
    local SearchedPlayer = RLCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        RLCore.Functions.ExecuteSql(false, "SELECT * FROM phone_invoices WHERE `citizenid` = '"..SearchedPlayer.PlayerData.citizenid.."' AND `society`='police'", function(invoices)
            if #invoices == 0 then
                TriggerClientEvent('chat:addMessage', src, {
                    template = '<div class="chat-message server"><strong>SYSTEM:</strong> Player have no unpaid fines.</div>',
                })
            else
                local str = ""
                for i=1,#invoices do
                    local invoice = invoices[i]
                    str = str .. '<br>'
                    str = str .. i .. '. ' .. invoice.title .. ' - $' .. invoice.amount
                end
    
                TriggerClientEvent('chat:addMessage', src, {
                    template = '<div class="chat-message emergency">Player Unpaid Fines: '.. str ..' </div>',
                })
            end
        end)
    end
end)

RegisterServerEvent('police:server:SearchPlayer')
AddEventHandler('police:server:SearchPlayer', function(playerId)
    local src = source
    local SearchedPlayer = RLCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message success">Player has $ '..SearchedPlayer.PlayerData.money["cash"]..' </div>',
        })
        TriggerClientEvent('RLCore:Notify', SearchedPlayer.PlayerData.source, "You are being searched..")
    end
end)

RegisterServerEvent('police:server:SeizeCash')
AddEventHandler('police:server:SeizeCash', function(playerId)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local SearchedPlayer = RLCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        
        local moneyAmount = SearchedPlayer.PlayerData.money["cash"]
        SearchedPlayer.Functions.RemoveMoney("cash", moneyAmount, "police-cash-seized")
        Player.Functions.AddMoney("cash", moneyAmount, "police-cash-seized")
        TriggerClientEvent('RLCore:Notify', SearchedPlayer.PlayerData.source, "Your cash confiscated..")
    end
end)

RegisterServerEvent('police:server:SeizeDriverLicense')
AddEventHandler('police:server:SeizeDriverLicense', function(playerId)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local SearchedPlayer = RLCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then
        exports['ghmattimysql']:execute("SELECT `driver` FROM `user_licenses` WHERE `citizenid` = @CID", {['@CID'] = SearchedPlayer.PlayerData.citizenid}, function(result)
            if result[1][type] == 0 then
                TriggerClientEvent('RLCore:Notify', src, "Can't take driving license..", "error")
            elseif result[1][type] == 1 then
                exports['ghmattimysql']:execute("UPDATE `user_licenses` SET `driver` = '2' WHERE `citizenid` = @CID", {['@CID'] = SearchedPlayer.PlayerData.citizenid})
                TriggerClientEvent('RLCore:Notify', SearchedPlayer.PlayerData.source, "Your driving license confiscated..")
            elseif result[1][type] == 2 then
                TriggerClientEvent('RLCore:Notify', src, "Can't take driving license..", "error")
            end
        end)
    end
end)

RegisterServerEvent('police:server:RobPlayer')
AddEventHandler('police:server:RobPlayer', function(playerId)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local SearchedPlayer = RLCore.Functions.GetPlayer(playerId)
    if SearchedPlayer ~= nil then 
        local money = SearchedPlayer.PlayerData.money["cash"]
        Player.Functions.AddMoney("cash", money, "police-player-robbed")
        SearchedPlayer.Functions.RemoveMoney("cash", money, "police-player-robbed")
        TriggerClientEvent('RLCore:Notify', SearchedPlayer.PlayerData.source, "You're like $"..money.." robbed")
    end
end)

--[[ Moved to bb-blips (onesync infinity support)
RegisterServerEvent('police:server:UpdateBlips')
AddEventHandler('police:server:UpdateBlips', function()
    local src = source
    local dutyPlayers = {}
    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if ((Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty) then
                table.insert(dutyPlayers, {
                    source = Player.PlayerData.source,
                    label = Player.PlayerData.metadata["callsign"],
                    job = Player.PlayerData.job.name,
                })
            end
        end
    end
    TriggerClientEvent("police:client:UpdateBlips", -1, dutyPlayers)
end)]]

RegisterServerEvent('police:server:spawnObject')
AddEventHandler('police:server:spawnObject', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("police:client:spawnObject", -1, objectId, type, src)
end)

RegisterServerEvent('police:server:deleteObject')
AddEventHandler('police:server:deleteObject', function(objectId)
    local src = source
    TriggerClientEvent('police:client:removeObject', -1, objectId)
end)

RegisterServerEvent('police:server:deleteObjects')
AddEventHandler('police:server:deleteObjects', function(objects)
    local src = source
    TriggerClientEvent('police:client:removeObjects', -1, objects)
end)

RegisterServerEvent('police:server:Impound')
AddEventHandler('police:server:Impound', function(plate, fullImpound, price)
    local src = source
    local price = price ~= nil and price or 0
    if IsVehicleOwned(plate) then
        if not fullImpound then
            exports['ghmattimysql']:execute('UPDATE player_vehicles SET state = @state, depotprice = @depotprice WHERE plate = @plate', {['@state'] = 0, ['@depotprice'] = price, ['@plate'] = plate})
            TriggerClientEvent('RLCore:Notify', src, "Vehicle included in depot for $"..price.."!")
        else
            exports['ghmattimysql']:execute('UPDATE player_vehicles SET state = @state WHERE plate = @plate', {['@state'] = 2, ['@plate'] = plate})
            TriggerClientEvent('RLCore:Notify', src, "Vehicle completely seized!")
        end
    end
end)

RegisterServerEvent('evidence:server:UpdateStatus')
AddEventHandler('evidence:server:UpdateStatus', function(data)
    local src = source
    PlayerStatus[src] = data
end)

RegisterServerEvent('evidence:server:CreateBloodDrop')
AddEventHandler('evidence:server:CreateBloodDrop', function(citizenid, bloodtype, coords)
    local src = source
    local bloodId = CreateBloodId()
    BloodDrops[bloodId] = {dna = citizenid, bloodtype = bloodtype}
    TriggerClientEvent("evidence:client:AddBlooddrop", -1, bloodId, citizenid, bloodtype, coords)
end)

RegisterServerEvent('evidence:server:CreateFingerDrop')
AddEventHandler('evidence:server:CreateFingerDrop', function(coords)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local fingerId = CreateFingerId()
    FingerDrops[fingerId] = Player.PlayerData.metadata["fingerprint"]
    TriggerClientEvent("evidence:client:AddFingerPrint", -1, fingerId, Player.PlayerData.metadata["fingerprint"], coords)
end)

RegisterServerEvent('evidence:server:ClearBlooddrops')
AddEventHandler('evidence:server:ClearBlooddrops', function(blooddropList)
    if blooddropList ~= nil and next(blooddropList) ~= nil then 
        for k, v in pairs(blooddropList) do
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, v)
            BloodDrops[v] = nil
        end
    end
end)

RegisterServerEvent('evidence:server:AddBlooddropToInventory')
AddEventHandler('evidence:server:AddBlooddropToInventory', function(bloodId, bloodInfo)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, bloodInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, RLCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, bloodId)
            BloodDrops[bloodId] = nil
        end
    else
        TriggerClientEvent('RLCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterServerEvent('evidence:server:AddFingerprintToInventory')
AddEventHandler('evidence:server:AddFingerprintToInventory', function(fingerId, fingerInfo)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, fingerInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, RLCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveFingerprint", -1, fingerId)
            FingerDrops[fingerId] = nil
        end
    else
        TriggerClientEvent('RLCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterServerEvent('evidence:server:CreateCasing')
AddEventHandler('evidence:server:CreateCasing', function(weapon, coords)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local casingId = CreateCasingId()
    local weaponInfo = RLCore.Shared.Weapons[weapon]
    local serieNumber = nil
    if weaponInfo ~= nil then 
        local weaponItem = Player.Functions.GetItemByName(weaponInfo["name"])
        if weaponItem ~= nil then
            if weaponItem.info ~= nil and  weaponItem.info ~= "" then 
                serieNumber = weaponItem.info.serie
            end
        end
    end
    TriggerClientEvent("evidence:client:AddCasing", -1, casingId, weapon, coords, serieNumber)
end)

RegisterServerEvent('police:server:UpdateCurrentCops')
AddEventHandler('police:server:UpdateCurrentCops', function()
    local amount = 0
    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    TriggerClientEvent("police:SetCopCount", -1, amount)
end)

RegisterServerEvent('evidence:server:ClearCasings')
AddEventHandler('evidence:server:ClearCasings', function(casingList)
    if casingList ~= nil and next(casingList) ~= nil then 
        for k, v in pairs(casingList) do
            TriggerClientEvent("evidence:client:RemoveCasing", -1, v)
            Casings[v] = nil
        end
    end
end)

RegisterServerEvent('evidence:server:AddCasingToInventory')
AddEventHandler('evidence:server:AddCasingToInventory', function(casingId, casingInfo)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, casingInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, RLCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveCasing", -1, casingId)
            Casings[casingId] = nil
        end
    else
        TriggerClientEvent('RLCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterServerEvent('police:server:showFingerprint')
AddEventHandler('police:server:showFingerprint', function(playerId)
    local src = source
    local Player = RLCore.Functions.GetPlayer(playerId)

    TriggerClientEvent('police:client:showFingerprint', playerId, src)
    TriggerClientEvent('police:client:showFingerprint', src, playerId)
end)

RegisterServerEvent('police:server:showFingerprintId')
AddEventHandler('police:server:showFingerprintId', function(sessionId)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local fid = Player.PlayerData.metadata["fingerprint"]

    TriggerClientEvent('police:client:showFingerprintId', sessionId, fid, Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname)
    TriggerClientEvent('police:client:showFingerprintId', src, fid, Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname)
end)

RegisterServerEvent('police:server:SetTracker')
AddEventHandler('police:server:SetTracker', function(targetId)
    local Target = RLCore.Functions.GetPlayer(targetId)
    local TrackerMeta = Target.PlayerData.metadata["tracker"]

    if TrackerMeta then
        Target.Functions.SetMetaData("tracker", false)
        TriggerClientEvent('RLCore:Notify', targetId, 'Your ankle strap is taken off.', 'error', 5000)
        TriggerClientEvent('RLCore:Notify', source, 'You took off an ankle bracelet from '..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname, 'error', 5000)
        TriggerClientEvent('police:client:SetTracker', targetId, false)
    else
        Target.Functions.SetMetaData("tracker", true)
        TriggerClientEvent('RLCore:Notify', targetId, 'You got an ankle bracelet.', 'error', 5000)
        TriggerClientEvent('RLCore:Notify', source, 'You put on an ankle strap at '..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname, 'error', 5000)
        TriggerClientEvent('police:client:SetTracker', targetId, true)
    end
end)

RegisterServerEvent('police:server:SendTrackerLocation')
AddEventHandler('police:server:SendTrackerLocation', function(coords, requestId)
    local Target = RLCore.Functions.GetPlayer(source)
    local TrackerMeta = Target.PlayerData.metadata["tracker"]

    local msg = "The location of "..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname.." is indicated on your card."

    local alertData = {
        title = "Enkelband Locatie",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = msg
    }

    TriggerClientEvent("police:client:TrackerMessage", requestId, msg, coords)
    TriggerClientEvent("rl-phone:client:addPoliceAlert", requestId, alertData)
end)

RegisterServerEvent('police:server:SendPoliceEmergencyAlert')
AddEventHandler('police:server:SendPoliceEmergencyAlert', function(streetLabel, coords, callsign)
    local alertData = {
        title = "Assistentie collega",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = "Noodknop ingedrukt door ".. callsign .. " bij "..streetLabel,
    }
    TriggerClientEvent("police:client:PoliceEmergencyAlert", -1, callsign, streetLabel, coords)
    TriggerClientEvent("rl-phone:client:addPoliceAlert", -1, alertData)
end)

RLCore.Functions.CreateCallback('police:server:isPlayerDead', function(source, cb, playerId)
    local Player = RLCore.Functions.GetPlayer(playerId)
    cb(Player.PlayerData.metadata["isdead"] or Player.PlayerData.metadata["inlaststand"])
end)

RLCore.Functions.CreateCallback('police:GetPlayerStatus', function(source, cb, playerId)
    local Player = RLCore.Functions.GetPlayer(playerId)
    local statList = {}
	if Player ~= nil then
        if PlayerStatus[Player.PlayerData.source] ~= nil and next(PlayerStatus[Player.PlayerData.source]) ~= nil then
            for k, v in pairs(PlayerStatus[Player.PlayerData.source]) do
                table.insert(statList, PlayerStatus[Player.PlayerData.source][k].text)
            end
        end
	end
    cb(statList)
end)

RLCore.Functions.CreateCallback('police:IsSilencedWeapon', function(source, cb, weapon)
    local Player = RLCore.Functions.GetPlayer(source)
    local itemInfo = Player.Functions.GetItemByName(RLCore.Shared.Weapons[weapon]["name"])
    local retval = false
    if itemInfo ~= nil then 
        if itemInfo.info ~= nil and itemInfo.info.attachments ~= nil then 
            for k, v in pairs(itemInfo.info.attachments) do
                if itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP_02" or itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP" or itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP_02" or itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP" then
                    retval = true
                end
            end
        end
    end
    cb(retval)
end)

RLCore.Functions.CreateCallback('police:GetDutyPlayers', function(source, cb)
    local dutyPlayers = {}
    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if ((Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance") and Player.PlayerData.job.onduty) then
                table.insert(dutyPlayers, {
                    source = Player.PlayerData.source,
                    label = Player.PlayerData.metadata["callsign"],
                    job = Player.PlayerData.job.name,
                })
            end
        end
    end
    cb(dutyPlayers)
end)

function CreateBloodId()
    if BloodDrops ~= nil then
		local bloodId = math.random(10000, 99999)
		while BloodDrops[caseId] ~= nil do
			bloodId = math.random(10000, 99999)
		end
		return bloodId
	else
		local bloodId = math.random(10000, 99999)
		return bloodId
	end
end

function CreateFingerId()
    if FingerDrops ~= nil then
		local fingerId = math.random(10000, 99999)
		while FingerDrops[caseId] ~= nil do
			fingerId = math.random(10000, 99999)
		end
		return fingerId
	else
		local fingerId = math.random(10000, 99999)
		return fingerId
	end
end

function CreateCasingId()
    if Casings ~= nil then
		local caseId = math.random(10000, 99999)
		while Casings[caseId] ~= nil do
			caseId = math.random(10000, 99999)
		end
		return caseId
	else
		local caseId = math.random(10000, 99999)
		return caseId
	end
end

function CreateObjectId()
    if Objects ~= nil then
		local objectId = math.random(10000, 99999)
		while Objects[caseId] ~= nil do
			objectId = math.random(10000, 99999)
		end
		return objectId
	else
		local objectId = math.random(10000, 99999)
		return objectId
	end
end

function IsVehicleOwned(plate)
    local val = false
	RLCore.Functions.ExecuteSql(true, "SELECT * FROM `player_vehicles` WHERE `plate` = '"..plate.."'", function(result)
		if (result[1] ~= nil) then
			val = true
		else
			val = false
		end
	end)
	return val
end

RLCore.Functions.CreateCallback('police:GetImpoundedVehicles', function(source, cb)
    local vehicles = {}
    exports['ghmattimysql']:execute('SELECT * FROM player_vehicles WHERE state = @state', {['@state'] = 2}, function(result)
        if result[1] ~= nil then
            vehicles = result
        end
        cb(vehicles)
    end)
end)

RLCore.Functions.CreateCallback('police:IsPlateFlagged', function(source, cb, plate)
    local retval = false
    if Plates ~= nil and Plates[plate] ~= nil then
        if Plates[plate].isflagged then
            retval = true
        end
    end
    cb(retval)
end)

RLCore.Functions.CreateCallback('police:GetCops', function(source, cb)
    local amount = 0
    
    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
	cb(amount)
end)

RLCore.Commands.Add("spike", "Place down a spike strip", {}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
            TriggerClientEvent('police:client:SpawnSpikeStrip', source)
        end
    end
end)

RLCore.Commands.Add("pobj", "Place / Delete an object", {{name="type", help="Type object you want or 'delete' to delete"}}, true, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
    local type = args[1]:lower()
    if Player.PlayerData.job.name == "police" then
        if type == "pion" then
            TriggerClientEvent("police:client:spawnCone", source)
        elseif type == "barier" then
            TriggerClientEvent("police:client:spawnBarier", source)
        elseif type == "schotten" then
            TriggerClientEvent("police:client:spawnSchotten", source)
        elseif type == "chair" then
            TriggerClientEvent("police:client:spawnGlobalObj", source, 'chair')
        elseif type == "chairs" then
            TriggerClientEvent("police:client:spawnGlobalObj", source, 'chairs')
        elseif type == "table" then
            TriggerClientEvent("police:client:spawnGlobalObj", source, 'table')
        elseif type == "moni" then
            TriggerClientEvent("police:client:spawnGlobalObj", source, 'monitor')
        elseif type == "tent" then
            TriggerClientEvent("police:client:spawnTent", source)
        elseif type == "light" then
            TriggerClientEvent("police:client:spawnLight", source)
        elseif type == "darea" then
            TriggerClientEvent("police:client:deleteAreaObjects", source)
        elseif type == "d" then
            TriggerClientEvent("police:client:deleteObject", source)
        end
    else
        TriggerClientEvent('RLCore:Notify', source, "This command is for cops only!", "error")
    end
end)

RLCore.Commands.Add("cuff", "Cuff citizen", {}, false, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("police:client:CuffPlayer", source)
    else
        TriggerClientEvent('RLCore:Notify', source, "This command is for cops only!", "error")
    end
end)

RLCore.Commands.Add("seatvehicle", "Put player in vehicle", {}, false, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("police:client:PutPlayerInVehicle", source)
    else
        TriggerClientEvent('RLCore:Notify', source, "This command is for cops only!", "error")
    end
end)

RLCore.Commands.Add("unseatvehicle", "Get player out from vehicle", {}, false, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("police:client:SetPlayerOutVehicle", source)
    else
        TriggerClientEvent('RLCore:Notify', source, "This command is for cops only!", "error")
    end
end)

RLCore.Commands.Add("escort", "Escort citizen", {}, false, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
    TriggerClientEvent("police:client:EscortPlayer", source)
end)

RLCore.Commands.Add("clearcasings", "Take away bullets in the area (make sure you have picked up some)", {}, false, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("evidence:client:ClearCasingsInArea", source)
    else
        TriggerClientEvent('RLCore:Notify', source, "This command is for cops only!", "error")
    end
end)

RLCore.Commands.Add("jail", "Jail person.", {{name="id", help="Player ID"},{name="time", help="Time"}}, true, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        local playerId = tonumber(args[1])
        local time = tonumber(args[2])
        if time > 0 then
            TriggerClientEvent("police:client:JailCommand", source, playerId, time)
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Time must be greater than 0")
        end
    else
        TriggerClientEvent('RLCore:Notify', source, "This command is for cops only!", "error")
    end
end)

RLCore.Commands.Add("unjail", "Unjail person.", {{name="id", help="Speler ID"}}, true, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        local playerId = tonumber(args[1])
        TriggerClientEvent("prison:client:UnjailPerson", playerId)
    else
        TriggerClientEvent('RLCore:Notify', source, "This command is for cops only!", "error")
    end
end)

RLCore.Commands.Add("clearblood", "Take away nearby blood (make sure you've picked up some)", {}, false, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("evidence:client:ClearBlooddropsInArea", source)
    else
        TriggerClientEvent('RLCore:Notify', source, "This command is for cops only!", "error")
    end
end)

RLCore.Commands.Add("seizecash", "Take cash from the nearest person", {}, false, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:SeizeCash", source)
    else
        TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message emergency">This command is for emergency services!  </div>',
        })
    end
end)

RLCore.Commands.Add("softcuff", "Handcuff someone but let him walk", {}, false, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("police:client:CuffPlayerSoft", source)
    else
        TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message emergency">This command is for emergency services!  </div>',
        })
    end
end)

RLCore.Commands.Add("camera", "View security camera", {{name="camid", help="Camera ID"}}, false, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("police:client:CameraCommand", source, tonumber(args[1]))
    else
        TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message emergency">This command is for emergency services!  </div>',
        })
    end
end)

RLCore.Commands.Add("impound", "Send a vehicle to the impound", {{name="price", help="Price for how much the person has to pay (may be empty)"}}, false, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("police:client:ImpoundVehicle", source, false, tonumber(args[1]))
    else
        TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message emergency">This command is for emergency services!  </div>',
        })
    end
end)

RLCore.Commands.Add("fullimpound", "Seize a vehicle", {}, false, function(source, args)
	local Player = RLCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("police:client:ImpoundVehicle", source, true)
    else
        TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message emergency">This command is for emergency services!  </div>',
        })
    end
end)

RLCore.Functions.CreateUseableItem("handcuffs", function(source, item)
    local Player = RLCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("police:client:Hardcuff", source)
    end
end)

RLCore.Commands.Add("deadofficer", "Send a message back to a notification", {}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
    if ((Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty) then
        TriggerClientEvent("police:client:SendPoliceEmergencyAlert", source)
    end
end)

RLCore.Commands.Add("tds", "Confiscate driver license", {}, false, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
    if ((Player.PlayerData.job.name == "police") and Player.PlayerData.job.onduty) then
        TriggerClientEvent("police:client:SeizeDriverLicense", source)
    end
end)

RLCore.Commands.Add("tdna", "Take a DNA copy from a person (empty proof bag required)", {{"id", "Person ID"}}, true, function(source, args)
    local Player = RLCore.Functions.GetPlayer(source)
    local OtherPlayer = RLCore.Functions.GetPlayer(tonumber(args[1]))
    if ((Player.PlayerData.job.name == "police") and Player.PlayerData.job.onduty) and OtherPlayer ~= nil then
        if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
            local info = {
                label = "DNA-Monster",
                type = "dna",
                dnalabel = DnaHash(OtherPlayer.PlayerData.citizenid),
            }
            if Player.Functions.AddItem("filled_evidence_bag", 1, false, info) then
                TriggerClientEvent("inventory:client:ItemBox", source, RLCore.Shared.Items["filled_evidence_bag"], "add")
            end
        else
            TriggerClientEvent('RLCore:Notify', source, "You must have an empty proof bag with you", "error")
        end
    end
end)

function GetCurrentCops()
    local amount = 0
    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    return amount
end

RLCore.Functions.CreateCallback('police:server:IsPoliceForcePresent', function(source, cb)
    local retval = false
    for k, v in pairs(RLCore.Functions.GetPlayers()) do
        local Player = RLCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            for _, citizenid in pairs(Config.ArmoryWhitelist) do
                if citizenid == Player.PlayerData.citizenid then
                    retval = true
                    break
                end
            end
        end
    end
    cb(retval)
end)

function DnaHash(s)
    local h = string.gsub(s, ".", function(c)
		return string.format("%02x", string.byte(c))
	end)
    return h
end

RegisterServerEvent('police:server:SyncSpikes')
AddEventHandler('police:server:SyncSpikes', function(table)
    TriggerClientEvent('police:client:SyncSpikes', -1, table)
end)

RLCore.Commands.Add('sl', 'Use shit lockpick', {}, false, function(source, args)
    local xPlayer = RLCore.Functions.GetPlayer(source)
    local item = xPlayer.Functions.GetItemByName('shitlockpick')
    if item ~= nil and item.amount > 0 then
        TriggerClientEvent('police:client:UseShitLockpick', source)
    end
end)