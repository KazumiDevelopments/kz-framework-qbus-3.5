cam = nil
cam2 = nil
local shouldKeep = false
local data, cid

RegisterNetEvent('bb-jguid:startDisplay')
AddEventHandler('bb-jguid:startDisplay', function(data1, cid1)
    SetRainFxIntensity(0.0)
    TriggerEvent('rl-weathersync:client:DisableSync')
    SetWeatherTypePersist('EXTRASUNNY')
    SetWeatherTypeNow('EXTRASUNNY')
    SetWeatherTypeNowPersist('EXTRASUNNY')
    NetworkOverrideClockTime(12, 0, 0)

    data, cid = data1, cid1
    DoScreenFadeOut(0)
    Wait(750)
    DoScreenFadeIn(2500)

    local point1 = { x = -1785.115, y = -1177.391, z = 17.363952, h = 316.41293 }
    local point2 = { x = -814.4752, y = -935.6069, z = 117.26395, h = 271.41296 }
    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, point1.x, point1.y, point1.z)
    SetEntityVisible(playerPed, false)
    FreezeEntityPosition(playerPed, true)
    DisableAllControlActions(0)

    Citizen.CreateThread(function()
        SetFocusArea(point1.x, point1.y, point1.z, 0.0, 0.0, 0.0)
        RequestCollisionAtCoord(point1.x, point1.y, point1.z)
        while not HasCollisionLoadedAroundEntity(playerPed) do
            print('[bb-joiningguid] Loading first prop collision.')
            Wait(0)
        end
    end)

    SendNUIMessage({
        type = "page",
        page = 0,
    })
    
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", point1.x, point1.y, point1.z, 0.0, 0.0, -10.0, 100.0, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", point2.x + 15.0, point2.y, point2.z, 0.0, 0.0, 25.0, 65.0, false, 0)
    SetCamActiveWithInterp(cam2, cam, 16500, true, true)

    Wait(9500)
    DoScreenFadeOut(3250)
    Wait(3250)
    DoScreenFadeIn(2500)
    
    
    print('OKOK ')
    local coordsConfig = {
        police = {
            ['ped'] = vector3(427.18994, -989.69, 35.685127),
            ['cam'] = vector3(398.34799, -981.3601, 42.516151),
            ['rotate'] = {-13.0, 0.0, -100.0},
            page = 1,
            color = "blue",
            title = "Mission Row Police Department",
            desc = "Los Santos Mission Row Police Department is open to all state, local, and tribal law enforcement agencies with primary law enforcement authority, hiring cops.",
        },

        ambulance = {
            ['cam'] = vector3(250.68339, -562.4584, 50.544818),
            ['ped'] = vector3(250.12683, -569.783, 43.269943),
            ['rotate'] = {0.0, 0.0, -110.0},
            page = 1,
            color = "red",
            title = "Pillbox Hospital",
            desc = "One of Los Santos hospitals, open 24/7, you may visit when needed, BE AWARE OF #CO-VID19.",
        },

        driving = {
            ['ped'] = vector3(210.66172, 353.2199, 105.61553),
            ['cam'] = vector3(210.66172, 353.2199, 105.61553 + 5.0),
            ['rotate'] = {-3.0, 0.0, -55.0},
            page = 1,
            color = "purple",
            title = "Driving School",
            desc = "Come over today to get your Driving Lincense, awesome teachers, wild driving experience and cheapest price out there.",
        },
        
        cityhall = {
            ['ped'] = vector3(-544.4662, -204.8041, 38.214733),
            ['cam'] =vector3(-519.7556, -247.9703, 48.449748),
            ['rotate'] = {-18.0, 0.0, 30.0},
            page = 1,
            color = "green",
            title = "Cityhall",
            desc = "The Cityhall contains all the imporant city stuff, before coming make sure you pass the security test and well dressed.",
        },
        
        banks = {
            ['ped'] = vector3(159.54644, -1027.273, 29.377624),
            ['cam'] = vector3(159.54644, -1027.273, 32.377624),
            ['rotate'] = {-7.0, 0.0, 140.0},
            page = 1,
            color = "lightgreen",
            title = "Banks",
            desc = "Fleeca banks are open everyday from 8am to 12pm, visit whenever you want, check out our banking app to reserve your ticket before coming!.",
        },

        bennys = {
            ['ped'] = vector3(-201.5164, -1299.591, 31.295988),
            ['cam'] = vector3(-201.5164, -1299.591, 31.295988),
            ['rotate'] = {7.0, 0.0, 160.0},
            page = 1,
            color = "gray",
            title = "Bennys",
            desc = "Benny's Original Motor Works is a custom vehicle shop that open everyday with greatest employees you can every find in the vehicle shop scene.",
        },
        
        casino = {
            ['ped'] = vector3(898.4837, 49.313392, 79.01506),
            ['cam'] = vector3(847.30102, 39.089492, 82.294769),
            ['rotate'] = {7.0, 0.0, -95.0},
            page = 1,
            color = "pink",
            title = "Casino",
            desc = "Before even GOING THERE, this is a 18+, so prepare your ID and grab some nice amount of cash to bet on, food & drink is free on buying premium ticket.",
        },
        
        taxis = {
            ['ped'] = vector3(907.62921, -164.304, 74.116699),
            ['cam'] = vector3(910.31402, -200.2135, 76.092155),
            ['rotate'] = {3.0, 0.0, 10.0},
            page = 1,
            color = "yellow",
            title = "Taxis",
            desc = "Tired of public transport ? grab a taxi driver by one click on our App, we're looking ememployees aswell, register at City Hall.",
        },
    }

    for _, v in pairs(coordsConfig) do
        print(_)
        SetFocusArea(v['ped'].x, v['ped'].y, v['ped'].z, 0.0, 0.0, 0.0)
        SetEntityCoords(playerPed, v['ped'])
        RequestCollisionAtCoord(v['ped'])
        
        cam = SetCamParams(cam, v['cam'].x, v['cam'].y, v['cam'].z, v['rotate'][1], v['rotate'][2], v['rotate'][3], 48.0, false, 0)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)

        Wait(2000)
        DoScreenFadeIn(2500)
        print(v.title)
        shouldKeep = true
        CreateThread(function()
            Wait(2000)
            SendNUIMessage({
                type = "skip",
            })
            SetNuiFocus(true, true)
        end)
        
        SendNUIMessage({
            type = "page",
            page = v.page,
            color = v.color,
            title = v.title,
            desc = v.desc,
        })
        
        local a = 1300
        while a > 0 and shouldKeep do
            Wait(0)
            print(a)
            a = a - 1
        end

        DoScreenFadeOut(1800)
        Wait(1800)
    end
    
    DeleteCamera()
end)

RegisterNUICallback('skipTut', function()
    shouldKeep = false
    --DeleteCamera()
end)

function DeleteCamera()
    DoScreenFadeOut(1200)
    ClearFocus()
    SetNuiFocus(false, false)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    SetCamActive(cam2, false)
    DestroyCam(cam2, true)
    RenderScriptCams(false, false, 1, true, true)
    SetEntityVisible(playerPed, true)

    SendNUIMessage({
        type = "close",
    })

    TriggerServerEvent('bb-multicharacter:server:createCharacter', data, cid)
    TriggerServerEvent('bb-multicharacter:server:GiveStarterItems')
end