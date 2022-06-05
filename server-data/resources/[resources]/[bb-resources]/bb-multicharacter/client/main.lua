RLCore = nil


Config = {
    PedCoords = {x = -3968.05, y = 2015.41, z = 502.3}, 

    spawns = {
        --[[middle]][1] = {
            coords = vector3(-3962.39,2016.98, 501.0),
            heading = 135.93
        },

        --[[right1]][2] = {
            coords = vector3(-3961.72,2015.95,501.0),
            heading = 116.3
        },

        --[[left1]][3] = {
            coords = vector3(-3961.34,2014.76, 501.0),
            heading = 99.31
        },

        --[[left2]][4] = {
            coords = vector3(-3961.44,2013.62, 501.0),
            heading = 70.8
        },

        --[[left2]][5] = {
            coords = vector3(-3961.79,2012.71, 501.0),
            heading = 71.44
        },

        --[[left2]][6] = {
            coords = vector3(-3962.47,2011.84, 501.0),
            heading = 50.23
        },

        --[[left2]][7] = {
            coords = vector3(-3963.5, 2011.16,501.0),
            heading = 25.5
        },

        --[[right2]][8] = {
            coords = vector3(-3964.55, 2011.02, 501.0),
            heading = 355.56
        }
    },

    blacklisted = {
        
    }
}

local charPed = nil
local createdChars = {}
local currentChar = nil
local choosingCharacter = false
local currentMarker = nil
local cam = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

local initialSpawn = false

AddEventHandler("playerSpawned", function()
    if not initialSpawn then
        initialSpawn = true
        TriggerEvent('bb-multicharacter:client:chooseChar')
        TriggerServerEvent("bb-multicharacter:server:choosingChar")
        TriggerServerEvent('mumble:infinity:server:mutePlayer')
    end
end)

function openCharMenu(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
    })
    choosingCharacter = bool

    Citizen.Wait(500)
    SetRainFxIntensity(0.0)
    TriggerEvent('rl-weathersync:client:DisableSync')
    Citizen.Wait(100)
    SetWeatherTypePersist('EXTRASUNNY')
    SetWeatherTypeNow('EXTRASUNNY')
    SetWeatherTypeNowPersist('EXTRASUNNY')
    NetworkOverrideClockTime(12, 0, 0)


    if bool == true then
        DoScreenFadeIn(2000)
        createCamera('create')
        Wait(750)

        local html = ""
        for k, v in ipairs(createdChars) do
            local pedCoords = GetPedBoneCoords(v.ped, 0x2e28, 0.0, 0.0, 0.0)
            local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(pedCoords.x, pedCoords.y, pedCoords.z)
            if v.isreg then
                html = html .. "<div id=\"" .. v.key .. "\" onmouseover=\"update_char_marker(this.id)\" onClick=\"select_character(this.id)\"><p style=\"left: ".. xxx * 100 .."%;top: ".. yyy * 90 .."%;-webkit-transform: translate(-50%, 0%);max-width: 100%; position: absolute; padding-top: 170px; padding-right: 30px; padding-bottom: 100px; padding-left: 80px;;\"></p></div>"
            else
                html = html .. "<div id=\"" .. v.key .. "\" onmouseover=\"update_char_marker(this.id)\" onClick=\"create_character(this.id)\"><p style=\"left: ".. xxx * 100 .."%;top: ".. yyy * 90 .."%;-webkit-transform: translate(-50%, 0%);max-width: 100%; position: absolute; padding-top: 170px; padding-right: 30px; padding-bottom: 100px; padding-left: 80px;;\"></p><p style=\"left: ".. xxx * 100 .."%;top: ".. yyy * 100 .."%;;text-shadow: 1px 0px 5px #000000FF, -1px 0px 0px #000000FF, 0px -1px 0px #000000FF, 0px 1px 5px #000000FF;-webkit-transform: translate(-50%, 0%);max-width: 100%;position: fixed;text-align: center;color: #FFFFFF; font-family:Heebo;font-size: 20px;\"><img \" width=\"30px\" height=\"30px\" src=\"plus.png\"></img></span></p></div>"
            end
        end

        SendNUIMessage({
            action = "setinfo",
            data = html,
        })
    else
        createCamera('exit')
    end
end

RegisterNetEvent('bb-multicharacter:client:closeNUI')
AddEventHandler('bb-multicharacter:client:closeNUI', function()
    SetNuiFocus(false, false)
end)

local Countdown = 1
function deletePeds()
    for _, v in pairs(createdChars) do
        SetEntityAsMissionEntity(v.ped, true, true)
        DeleteEntity(v.ped)
    end
    createdChars = {}
end

function CreatePeds()
    RLCore.Functions.TriggerCallback('bb-multicharacter:server:GetUserCharacters', function(res)
        local result = res
        local html = ""
        local dontHasStuff = {}
        
        for i = 1, 5, 1 do
            local has = false
            for k, v in ipairs(result) do
                if v.cid == i then
                    has = true
                    break
                end
            end
            if not has then
                table.insert(dontHasStuff, i)
            end
        end

        for k, v in ipairs(dontHasStuff) do
            Citizen.CreateThread(function()
                local randommodels = {
                    "mp_m_freemode_01",
                    "mp_f_freemode_01",
                }
                local model = GetHashKey(randommodels[math.random(1, #randommodels)])
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(0)
                end
                print("GetChars-then Freeze")
                local charPed = CreatePed(3, model, Config.spawns[v].coords.x, Config.spawns[v].coords.y, Config.spawns[v].coords.z - 0.98, Config.spawns[v].heading, false, true)
                SetEntityAlpha(charPed, 100)
                SetPedComponentVariation(charPed, 0, 0, 0, 2)
                FreezeEntityPosition(charPed, true)
                SetEntityInvincible(charPed, true)
                PlaceObjectOnGroundProperly(charPed)
                SetBlockingOfNonTemporaryEvents(charPed, true)
                table.insert(createdChars, {key = v, ped = charPed, isreg = false})
            end)
        end

        for k, v in ipairs(result) do
            RLCore.Functions.TriggerCallback('bb-multicharacter:server:getSkin', function(data, inf)
                Wait(500)
                local citizenid, cid, name = inf[1], inf[2], inf[3]
                local model = data.model ~= nil and tonumber(data.model) or 1885233650
                if model ~= nil then
                    CreateThread(function()
                        for k, v in pairs(Config.blacklisted) do
                            if model == k then
                                model = v
                            end
                        end

                        print(model)

                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            Citizen.Wait(0)
                        end

                        print("GetSkins-then Freeze")
        
                        local charPed = CreatePed(3, model, Config.spawns[cid].coords.x, Config.spawns[cid].coords.y, Config.spawns[cid].coords.z - 0.98, Config.spawns[cid].heading, false, true)
                        SetPedComponentVariation(charPed, 0, 0, 0, 2)
                        FreezeEntityPosition(charPed, true)
                        SetEntityInvincible(charPed, true)
                        PlaceObjectOnGroundProperly(charPed)
                        SetBlockingOfNonTemporaryEvents(charPed, true)
                        SetClothing(charPed, data.drawables, data.props, data.drawtextures, data.proptextures)
                        SetFace(charPed, data.headBlend, data.hairColor, data.headStructure, data.headOverlay)
                        table.insert(createdChars, {key = cid, ped = charPed, dat = inf,isreg = true})
                    end)
                else
                    Citizen.CreateThread(function()
                        local randommodels = {
                            "mp_m_freemode_01",
                            "mp_f_freemode_01",
                        }
                        local model = GetHashKey(randommodels[math.random(1, #randommodels)])
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            Citizen.Wait(0)
                        end
                        local charPed = CreatePed(3, model, Config.spawns[cid].coords.x, Config.spawns[cid].coords.y, Config.spawns[cid].coords.z - 0.98, Config.spawns[cid].heading, false, true)
                        SetPedComponentVariation(charPed, 0, 0, 0, 2)
                        FreezeEntityPosition(charPed, true)
                        SetEntityInvincible(charPed, true)
                        PlaceObjectOnGroundProperly(charPed)
                        SetBlockingOfNonTemporaryEvents(charPed, true)
                        table.insert(createdChars, {key = cid, ped = charPed, dat = inf,isreg = true})
                    end)
                end
            end, v.citizenid, {v.citizenid, v.cid, json.decode(v.charinfo).firstname .. ' ' .. json.decode(v.charinfo).lastname})
        end
    end)
end


function selectChar()
    openCharMenu(true)
end

RegisterCommand("show", function(source, args, raw)
    TriggerEvent('bb-multicharacter:client:chooseChar')
    TriggerServerEvent('mumble:infinity:server:mutePlayer')
end)

function getPedFromCharID(id)
    for k, v in pairs(createdChars) do
        if v.key == id then
            if not v.isreg then
                SetEntityAlpha(v.ped, 255)
            end
            return v
        end
    end
    return nil
end

RegisterNUICallback('setupCharacters', function()
    RLCore.Functions.TriggerCallback("test:yeet", function(result)
        SendNUIMessage({
            action = "setupCharacters",
            characters = result
        })
    end)
end)

RegisterNUICallback('closeUI', function()
    openCharMenu(false)
end)

RegisterNUICallback('disconnectButton', function()
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)
    TriggerServerEvent('bb-multicharacter:server:disconnect')
end)


RegisterNUICallback('selectCharacter', function()
    deletePeds()
    DoScreenFadeOut(10)
    TriggerServerEvent('bb-multicharacter:server:loadUserData', currentChar)
    openCharMenu(false)
end)

RegisterNUICallback('getCloserToCharacter', function(data)
    local pedData = getPedFromCharID(tonumber(data.charid))
    currentChar = pedData
    --createCamera('char', pedData.ped)

    if currentChar.isreg then
        SendNUIMessage({
            action = "setCharData",
            name = currentChar.dat[3],
            cid = currentChar.dat[1],
        })
    end
    currentMarker = nil
end)

RegisterNUICallback('updateCharMarker', function(data)
    if data.charid ~= false then
        local pedData = getPedFromCharID(tonumber(data.charid))
        currentMarker = GetEntityCoords(pedData.ped)
        if not pedData.isreg then
            SetEntityAlpha(pedData.ped, 100)
        end
    else
        currentMarker = nil
    end
end)

Citizen.CreateThread(function ()
    while true do
        if currentMarker ~= nil then
            DrawMarker(0, currentMarker.x, currentMarker.y, currentMarker.z + 1.2 , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.1, 255, 3, 53, 255, 0, 0, 0, 1, 0, 0, 0)
        end
        Wait(3)
    end
end)

RegisterNUICallback('getOffChar', function()
    createCamera('create')
    if not currentChar.isreg then
        SetEntityAlpha(currentChar.ped, 100)
    end
    currentChar = nil
    currentMarker = nil
end)

RegisterNUICallback('createNewCharacter', function(data)
    local cData = data
    DoScreenFadeOut(150)
    if cData.gender == "man" then
        cData.gender = 0
    elseif cData.gender == "woman" then
        cData.gender = 1
    end

    TriggerServerEvent('bb-multicharacter:server:createCharacter', cData, currentChar.key)
    TriggerServerEvent('bb-multicharacter:server:GiveStarterItems')
    deletePeds()
    openCharMenu(false)
    Citizen.Wait(500)
end)

RegisterNetEvent('bb-multicharacter:refreshPeds')
AddEventHandler('bb-multicharacter:refreshPeds', function()
    
    deletePeds()
    currentChar = nil
    openCharMenu(false)
    CreatePeds()
    openCharMenu(true)
end)

RegisterNUICallback('removeCharacter', function()
    TriggerServerEvent('bb-multicharacter:server:deleteCharacter', currentChar.dat[1])
    DoScreenFadeOut(750)
    Wait(500)
    deletePeds()
    currentChar = nil
    TriggerEvent('bb-multicharacter:client:chooseChar')
    TriggerServerEvent('mumble:infinity:server:mutePlayer')
end)

RegisterNUICallback('removeBlur', function()
    SetTimecycleModifier('default')
end)

RegisterNUICallback('setBlur', function()
    SetTimecycleModifier('hud_def_blur')
end)



function createCamera(typ, pedData)
    SetRainFxIntensity(0.0)

    if typ == 'create' then
        DoScreenFadeIn(1000)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -3968.05, 2015.41, 502.3, -14.0, 0.0, 250.0, 53.00, false, 0)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
    elseif typ == 'exit' then
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        RenderScriptCams(false, false, 1, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), false)
    elseif typ == 'char' then
        local coords = GetOffsetFromEntityInWorldCoords(pedData, 0, 2.0, 0)
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
        if(not DoesCamExist(cam)) then
            cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 0, true, true)
            SetCamCoord(cam, coords.x, coords.y, coords.z + 0.5)
            SetCamRot(cam, 0.0, 0.0, GetEntityHeading(pedData) + 180)
        end
    end
end

-- Gta V Switch
local cloudOpacity = 0.01
local muteSound = true

function ToggleSound(state)
    if state then
        StartAudioScene("MP_LEADERBOARD_SCENE");
    else
        StopAudioScene("MP_LEADERBOARD_SCENE");
    end
end

function InitialSetup()
    ToggleSound(muteSound)
    if not IsPlayerSwitchInProgress() then
        SwitchOutPlayer(PlayerPedId(), 1, 1)
    end
end

function ClearScreen()
    HideHudAndRadarThisFrame()
    SetDrawOrigin(0.0, 0.0, 0.0, 0)
end

RegisterNetEvent('bb-multicharacter:client:chooseChar')
AddEventHandler('bb-multicharacter:client:chooseChar', function()
    print("CURR CHAR", currentChar)
    if currentChar ~= nil then
        print("IM RUNNING CUZ IM")
        deletePeds()
        currentChar = nil
    end

    SetNuiFocus(false, false)
    DoScreenFadeOut(0)

    ToggleSound(muteSound)
    if not IsPlayerSwitchInProgress() then
        SwitchOutPlayer(PlayerPedId(), 1, 1)
        print("START SKY UPWARDS BS")
    end

    while GetPlayerSwitchState() ~= 5 do
        Citizen.Wait(0)
        ClearScreen()
    end

    ClearScreen()
    Citizen.Wait(0)
    
    local timer = GetGameTimer()
    ToggleSound(false)

    CreatePeds()
    ShutdownLoadingScreenNui()
    SetEntityCoords(GetPlayerPed(-1), vector3(-3968.05, 2015.41, 502.3))
    SetEntityVisible(GetPlayerPed(-1), false, false)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    Citizen.CreateThread(function()
        RequestCollisionAtCoord(Config.spawns[1].coords)
        while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
            print('[bb-multicharacter] Loading spawn collision.')
            Wait(0)
        end
    end)


    --DoScreenFadeIn(250)
    while true do
        ClearScreen()
        Citizen.Wait(0)
        if GetGameTimer() - timer > 5000 then
            SwitchInPlayer(PlayerPedId())
            ClearScreen()
            CreateThread(function()
                Wait(500)
                DoScreenFadeOut(350)
            end)

            while GetPlayerSwitchState() ~= 12 do
                Citizen.Wait(0)
                ClearScreen()
            end

            
            break
        end
    end

    print("Spawning choo choo")


    SetEntityCoordsNoOffset(PlayerPedId(), vector3(-3972.28, 2017.22, 500.92), false, false, false, false)
    FreezeEntityPosition(PlayerPedId(), true)

    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
        Wait(0)
    end

    while not HasCollisionForModelLoaded(GetHashKey("sp_01_station")) do
        Wait(0)
    end

    while not HasModelLoaded(GetHashKey("sp_01_station")) do
        Wait(100)
    end
    Wait(2500)

    spawnTrain()


    NetworkSetTalkerProximity(0.0)
    openCharMenu(true)

    
end)

local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}
local prop_names = {"hats", "glasses", "earrings", "mouth", "lhand", "rhand", "watches", "braclets"}
local head_overlays = {"Blemishes","FacialHair","Eyebrows","Ageing","Makeup","Blush","Complexion","SunDamage","Lipstick","MolesFreckles","ChestHair","BodyBlemishes","AddBodyBlemishes"}
local face_features = {"Nose_Width","Nose_Peak_Hight","Nose_Peak_Lenght","Nose_Bone_High","Nose_Peak_Lowering","Nose_Bone_Twist","EyeBrown_High","EyeBrown_Forward","Cheeks_Bone_High","Cheeks_Bone_Width","Cheeks_Width","Eyes_Openning","Lips_Thickness","Jaw_Bone_Width","Jaw_Bone_Back_Lenght","Chimp_Bone_Lowering","Chimp_Bone_Lenght","Chimp_Bone_Width","Chimp_Hole","Neck_Thikness"}

function SetClothing(ped, drawables, props, drawTextures, propTextures)
    for i = 1, #drawable_names do
        if drawables[0] == nil then
            if drawable_names[i] == "undershirts" and drawables[tostring(i-1)][2] == -1 then
                SetPedComponentVariation(ped, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(ped, i-1, drawables[tostring(i-1)][2], drawTextures[i][2], 2)
            end
        else
            if drawable_names[i] == "undershirts" and drawables[i-1][2] == -1 then
                SetPedComponentVariation(ped, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(ped, i-1, drawables[i-1][2], drawTextures[i][2], 2)
            end
        end
    end

    for i = 1, #prop_names do
        local propZ = (drawables[0] == nil and props[tostring(i-1)][2] or props[i-1][2])
        ClearPedProp(ped, i-1)
        SetPedPropIndex(ped,i-1,propZ,propTextures[i][2], true)
    end
end

function SetFace(player, head, haircolor, headStructure, headOverlay)
    if head then
        SetPedHeadBlendData(player,
            tonumber(head['shapeFirst']),
            tonumber(head['shapeSecond']),
            tonumber(head['shapeThird']),
            tonumber(head['skinFirst']),
            tonumber(head['skinSecond']),
            tonumber(head['skinThird']),
            tonumber(head['shapeMix']),
            tonumber(head['skinMix']),
            tonumber(head['thirdMix']),
        false)
    end

    if headStructure then
        for i = 1, #face_features do
            SetPedFaceFeature(player, i-1, headStructure[i])
        end
    end

    if haircolor then
        SetPedHairColor(player, tonumber(haircolor[1]), tonumber(haircolor[2]))
    end

    if headOverlay then
        if json.encode(headOverlay) ~= "[]" then
            for i = 1, #head_overlays do
                SetPedHeadOverlay(player,  i-1, tonumber(headOverlay[i].overlayValue),  tonumber(headOverlay[i].overlayOpacity))
            end
    
            SetPedHeadOverlayColor(player, 0, 0, tonumber(headOverlay[1].firstColour), tonumber(headOverlay[1].secondColour))
            SetPedHeadOverlayColor(player, 1, 1, tonumber(headOverlay[2].firstColour), tonumber(headOverlay[2].secondColour))
            SetPedHeadOverlayColor(player, 2, 1, tonumber(headOverlay[3].firstColour), tonumber(headOverlay[3].secondColour))
            SetPedHeadOverlayColor(player, 3, 0, tonumber(headOverlay[4].firstColour), tonumber(headOverlay[4].secondColour))
            SetPedHeadOverlayColor(player, 4, 2, tonumber(headOverlay[5].firstColour), tonumber(headOverlay[5].secondColour))
            SetPedHeadOverlayColor(player, 5, 2, tonumber(headOverlay[6].firstColour), tonumber(headOverlay[6].secondColour))
            SetPedHeadOverlayColor(player, 6, 0, tonumber(headOverlay[7].firstColour), tonumber(headOverlay[7].secondColour))
            SetPedHeadOverlayColor(player, 7, 0, tonumber(headOverlay[8].firstColour), tonumber(headOverlay[8].secondColour))
            SetPedHeadOverlayColor(player, 8, 2, tonumber(headOverlay[9].firstColour), tonumber(headOverlay[9].secondColour))
            SetPedHeadOverlayColor(player, 9, 0, tonumber(headOverlay[10].firstColour), tonumber(headOverlay[10].secondColour))
            SetPedHeadOverlayColor(player, 10, 1, tonumber(headOverlay[11].firstColour), tonumber(headOverlay[11].secondColour))
            SetPedHeadOverlayColor(player, 11, 0, tonumber(headOverlay[12].firstColour), tonumber(headOverlay[12].secondColour))
        end
    end
end

function VecLerp(x1, y1, z1, x2, y2, z2, l, clamp)
    if clamp then
        if l < 0.0 then l = 0.0 end
        if l > 1.0 then l = 1.0 end
    end
    local x = Lerp(x1, x2, l)
    local y = Lerp(y1, y2, l)
    local z = Lerp(z1, z2, l)
    return vector3(x, y, z)
end

function Lerp(a, b, t)
    return a + (b - a) * t
end

function LocationInWorld(coords,camera)

    local position = GetCamCoord(camera)

    --- Getting Object using raycast
    local ped = PlayerPedId()
    local raycast = StartShapeTestRay(position.x,position.y,position.z, coords.x,coords.y,coords.z, 8, ped, 0)
    local retval, hit, endCoords, surfaceNormal, entity = GetShapeTestResult(raycast)
    
    return entity

end

local isTrainMoving = false

function spawnTrain()

	local tempmodel = GetHashKey("metrotrain")
	RequestModel(tempmodel)
	while not HasModelLoaded(tempmodel) do
		RequestModel(tempmodel)
		Citizen.Wait(0)
	end 

    local coords = vector3(-3948.49,2036.35,499.1)
    vehicle = CreateVehicle(tempmodel, coords, 160.0, false, false)
    FreezeEntityPosition(vehicle, true)
     
    local heading = GetEntityHeading(vehicle)
    local coords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -11.0, 0.0)

    vehicleBack = CreateVehicle(tempmodel, coords, 158.0, false, false)
    FreezeEntityPosition(vehicleBack, true)
    AttachEntityToEntity(vehicleBack , vehicle , 51 , 0.0, -11.0, 0.0, 180.0, 180.0, 0.0, false, false, false, false, 0, true)

    Citizen.CreateThread(function()
        print("CHOOCHOO")
    	isTrainMoving = true
	    for i=1,100 do
	    	local posoffset = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 0.0, 0.0)
	    	local setpos = VecLerp(-3948.49,2036.35,499.1, -3957.58,2008.75, 499.1, i/100, true)
	    	SetEntityCoords(vehicle,setpos)
	  		Wait(15)
	    end
	    isTrainMoving = false
	end)
end

function deleteTrain()
	if vehicle ~= nil then
		DeleteEntity(vehicle)
		DeleteEntity(vehicleBack)
	end
end