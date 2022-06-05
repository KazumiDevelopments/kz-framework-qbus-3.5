Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

RLCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
            Citizen.Wait(200)
        end
    end
end)
-- Code
local timeout = false
local inCityhallPage = false
local qbCityhall = {}

qbCityhall.Open = function()
    SendNUIMessage({
        action = "open"
    })
    SetNuiFocus(true, true)
    inCityhallPage = true
end

qbCityhall.Close = function()
    SendNUIMessage({
        action = "close"
    })
    SetNuiFocus(false, false)
    inCityhallPage = false
end

qbCityhall.DrawText3Ds = function(coords, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    inCityhallPage = false
end)

local inRange = false


Citizen.CreateThread(function()
   --[[ CityhallBlip = AddBlipForCoord(Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z)

    SetBlipSprite (CityhallBlip, 487)
    SetBlipDisplay(CityhallBlip, 4)
    SetBlipScale  (CityhallBlip, 0.8)
    SetBlipAsShortRange(CityhallBlip, true)
    SetBlipColour(CityhallBlip, 0)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("City Hall")
    EndTextCommandSetBlipName(CityhallBlip)--]]

    DrivingSchoolBlip = AddBlipForCoord(Config.DrivingSchool.coords.x, Config.DrivingSchool.coords.y, Config.DrivingSchool.coords.z)

    SetBlipSprite (DrivingSchoolBlip, 380)
    SetBlipDisplay(DrivingSchoolBlip, 4)
    SetBlipScale  (DrivingSchoolBlip, 0.8)
    SetBlipAsShortRange(DrivingSchoolBlip, true)
    SetBlipColour(DrivingSchoolBlip, 44)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Driving Instructor")
    EndTextCommandSetBlipName(DrivingSchoolBlip)
end)

local creatingCompany = false
local currentName = nil
Citizen.CreateThread(function()
    while true do

        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        inRange = false

        local dist = GetDistanceBetweenCoords(pos, Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z, true)
        local dist2 = GetDistanceBetweenCoords(pos, Config.DrivingSchool.coords.x, Config.DrivingSchool.coords.y, Config.DrivingSchool.coords.z, true)

        if dist < 20 then
            inRange = true
            --DrawMarker(2, Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.2, 155, 152, 234, 155, false, false, false, true, false, false, false)
            if GetDistanceBetweenCoords(pos, Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z, true) < 1.5 then
                qbCityhall.DrawText3Ds(Config.Cityhall.coords, '[E] City Hall')
                if IsControlJustPressed(0, Keys["E"]) then
                    qbCityhall.Open()
                end
            end
            --DrawMarker(2, Config.DriverTest.coords.x, Config.DriverTest.coords.y, Config.DriverTest.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.2, 155, 152, 234, 155, false, false, false, true, false, false, false)
                if GetDistanceBetweenCoords(pos, Config.DriverTest.coords.x, Config.DriverTest.coords.y, Config.DriverTest.coords.z, true) < 1.5 then
                    --[[if creatingCompany then
                        qbCityhall.DrawText3Ds(Config.DriverTest.coords, '~g~E~w~ - Create company ($ '.. Config.CompanyPrice ..') | ~r~ G ~w~ - Stop')
                        if IsControlJustPressed(0, Keys["E"]) then
                            TriggerServerEvent("rl-companies:server:createCompany", currentName)
                            creatingCompany = false
                        end
                        if IsControlJustPressed(0, Keys["G"]) then
                            creatingCompany = false
                        end
                    else]]
                        qbCityhall.DrawText3Ds(Config.DriverTest.coords, '[E] Request Driving Test')
                        if IsControlJustPressed(0, Keys["E"]) then
                            RLCore.Functions.TriggerCallback('RLCore:server:checklicence', function(result, type)
                                if result == 'has licence' then
                                    RLCore.Functions.Notify("You have already obtained your driving license, request it alongside")
                                elseif timeout == false then
                                    CreateThread(function()
                                        timeout = true
                                        Wait(300000)
                                        timeout = false
                                    end)
                                    TriggerServerEvent("rl-cityhall:server:sendDriverTest")
                                else
                                    RLCore.Functions.Notify("Please wait a While Before Requesting Again.", 'error')
                                end
                            end, 'driver')
                        end

                
                    --[[if IsControlJustPressed(0, Keys["G"]) then
                        DisplayOnscreenKeyboard(1, "Naam", "", "Naam", "", "", "", 128 + 1)
                        while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
                            Citizen.Wait(7)
                        end
                        currentName = GetOnscreenKeyboardResult()
                        if currentName ~= nil and currentName ~= "" then
                            creatingCompany = true
                        end
                    end]]--
            end
        end

        if dist2 < 20 then
            inRange = true
            --DrawMarker(2, Config.DrivingSchool.coords.x, Config.DrivingSchool.coords.y, Config.DrivingSchool.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.2, 155, 152, 234, 155, false, false, false, true, false, false, false)
            if GetDistanceBetweenCoords(pos, Config.DrivingSchool.coords.x, Config.DrivingSchool.coords.y, Config.DrivingSchool.coords.z, true) < 1.5 then
                qbCityhall.DrawText3Ds(Config.DrivingSchool.coords, '[E] Request driving lessons')
                if IsControlJustPressed(0, Keys["E"]) then
                    RLCore.Functions.TriggerCallback('RLCore:server:checklicence', function(result)
                        if result == 'has licence' then
                            RLCore.Functions.Notify("You have already obtained your driving license, pick it up at the town hall!")
                        elseif timeout == false then
                            CreateThread(function()
                                timeout = true
                                Wait(300000)
                                timeout = false
                            end)
                            TriggerServerEvent("rl-cityhall:server:sendDriverTest")
                        else
                            RLCore.Functions.Notify("Please wait a While Before Requesting Again.", 'error')
                        end
                    end, 'driver')
                end
            end
        end

        if not inRange then
            Citizen.Wait(1000)
        end

        Citizen.Wait(2)
    end
end)

RegisterNetEvent('rl-cityhall:client:sendDriverEmail')
AddEventHandler('rl-cityhall:client:sendDriverEmail', function(charinfo)
    SetTimeout(math.random(2500, 4000), function()

        local zcharinfo = RLCore.Functions.GetPlayerData().charinfo
        TriggerServerEvent('rl-phone:server:sendNewMail', {
            sender = "Township",
            subject = "Request driving lessons",
            message = "Hi, " .. zcharinfo.firstname .. ' ' .. zcharinfo.lastname .. ",<br /><br />We have just received a message that someone wants to get driving lessons/Drivers license. <br /> If you are willing to teach, please contact:<br />Name: <strong>".. charinfo.firstname .. " " .. charinfo.lastname .. "</strong><br />Phone Number: <strong>"..charinfo.phone.."</strong><br/><br/>Sincerely,<br />Cityhall",
            button = {}
        })
    end)
end)

local idTypes = {
    ["id-kaart"] = {
        label = "ID card",
        item = "id_card"
    },
    ["drivers"] = {
        label = "Drivers License",
        item = "driver_license"
    },
    ['weapon'] = {
        label = "Concealed Carry Licence",
        item = "weapon_card"
    }
}

RegisterNUICallback('requestId', function(data)
    if inRange then
        local idType = data.idType
        local PlayerData = RLCore.Functions.GetPlayerData()
        TriggerServerEvent('rl-cityhall:server:requestId', idTypes[idType])
        RLCore.Functions.Notify('You got a copy of your ID card for $ 50', 'success', 3500)
    else
        RLCore.Functions.Notify('Unfortunately it wont work mate...', 'error')
    end
end)

local lic = {
    'driver',
    'weapon1'
}

local lic2 = {
    licenseType,
    label,
    av = {},
}

RegisterNUICallback('requestLicenses', function(data, cb)
    local availableLicenses = {}
    for i = 0, 2 do
        if lic[i] ~= nil then
            RLCore.Functions.TriggerCallback('RLCore:server:checklicence', function(result)
                if result == "has licence" then 
                    if i == 1 then
                        lic2.licenseType = "drivers" 
                        lic2.label = "Drivers license"
                    else
                        lic2.licenseType = "weapon" 
                        lic2.label = "weapon license"
                    end
                    table.insert(lic2.av, {
                        idType = lic2.licenseType,
                        label = lic2.label
                    })
                elseif result == 'no licence' then
                    if i == 2 then
                        table.insert(lic2.av, {
                            idType = "weaponR",
                            label = "weapon license"
                        })
                    end
                end
            end, lic[i])
            Citizen.Wait(200)
        end
    end
    cb(lic2.av)
    table.remove(lic2.av)
    table.remove(lic2.av)
end)

local AvailableJobs = {
    "trucker",
    --"taxi",
    "tow",
    --"garbage",
}

function IsAvailableJob(job)
    local retval = false
    for k, v in pairs(AvailableJobs) do
        if v == job then
            retval = true
        end
    end
    return retval
end

RegisterNUICallback('applyJob', function(data)
    if inRange then
        if IsAvailableJob(data.job) then
            TriggerServerEvent('rl-cityhall:server:ApplyJob', data.job)
        else
            TriggerServerEvent('rl-cityhall:server:banPlayer')
            TriggerServerEvent("bb-logs:server:createLog", "anticheat", "POST Request (Abuse)", "red", "** @everyone " ..GetPlayerName(player).. "** has been banned for exploiting localhost: 13172, sending POST requests")         
        end
    else
        RLCore.Functions.Notify('Unfortunately it wont work mate...', 'error')
    end
end)

RegisterNUICallback('Licence', function(tog)
    TriggerServerEvent('rl-cityhall:server:weaponlicense:check1', tog)
end)

RegisterNUICallback('Check', function()
    print(RLCore.Functions.GetPlayerData().metadata["licences"]["weapon1"])
end)