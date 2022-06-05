RLCore = nil
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent(Config.TriggerPrefix .. ':GetObject', function(obj) RLCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

local isInMenu = false
local currentTats = {}
local Locations = {
	{1693.45667, 4823.17725, 42.1631294,600 },
	{-1177.865234375,-1780.5612792969,3.9084651470184,600},
	{198.4602355957,-1646.7690429688,29.803218841553,600},
	{298.19, -599.43, 43.29} ,
	{-712.215881,-155.352982, 37.4151268,600},
	{123.779823,-301.616455, 54.557827,600},
	{-1192.94495,-772.688965, 17.3255997,1500},
	--{454.75, -991.05, 30.69 ,600},
	{471.61776, 25.734638, 264.04019, 600},
	{ 425.236,-806.008,28.491 ,600},
	{ -162.658,-303.397,38.733 ,600},
	{ 75.950,-1392.891,28.376 ,600},
	{ -822.194,-1074.134,10.328 ,600},
	{ -1450.711,-236.83,48.809 ,600},
	{ 4.254,6512.813,30.877 ,600},
	{ 615.180,2762.933,41.088 ,600},
	{ 1196.785,2709.558,37.222,600},
	{ -3171.453,1043.857,19.863,600},
	{ -1100.959,2710.211,18.107,600},
	{ -1207.6564941406,-1456.8890380859,4.3784737586975,600},
	{ 121.76,-224.6,53.56,600},
	{ 1758.41, 2581.58, 45.72},
	{1849.69,3695.34,34.26}, -- sandy pd
	{-452.57,6014.21,31.72}, -- paleto pd
	{106.2,-1302.79,27.8,600}, -- VU Stripper room
	{100.19,3615.833,40.9145,600}, -- Lost MC Club house
	{472.42269, -990.841, 24.734664, 359.04434},
    {-54.36407, -1286.041, 29.225437 },
    {475.51443, -989.5452, 33.217071, 269.51901},
}

RegisterNetEvent("rl-outfits:client:tryUI")
AddEventHandler("rl-outfits:client:tryUI", function(outfits, tsd)
    local plyPed = PlayerPedId()
    local plyCoords = GetEntityCoords(plyPed)
    if tsd then
        TriggerEvent("rl-outfits:client:openUI", outfits)
        return
    end
    
    for k,v in pairs(Locations) do
        local distance = GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, v[1], v[2], v[3])

        if distance < 5 then
            TriggerEvent("rl-outfits:client:openUI", outfits)
        end
    end
end)

RegisterNetEvent("rl-outfits:client:openUI")
AddEventHandler("rl-outfits:client:openUI", function(outfits)
    local html = ""

    for i=1,7 do 
        if outfits[i] then
            html = html .. '<div class="box box-shadow option-enabled item selectoutfit" id="item-' .. i .. '"><span class="hoster-options" id="options-' .. i .. '"><span style="position: relative; top: 15%; margin-left: 27%;"><i id="item-' .. i .. '" class="fas fa-trash-alt deleteoutfit"></i></span></span><span id="option-text">' .. i .. '. ' .. outfits[i].name .. '</span></div>'
        else
            html = html .. '<div class="box box-shadow" id="item-' .. i .. '"><span class="hoster-options" id="options-' .. i .. '"><span style="position: relative; top: 15%; margin-left: 27%;"><i id="item-' .. i .. '" class="fas fas fa-plus createoutfit"></i></span></span><span id="option-text">' .. i .. '. Empty Slot</span></div>'
        end
    end

    SetNuiFocus(true, true)
    SendNUIMessage({ ['open'] = true, ['class'] = 'open' })
    SendNUIMessage({ ['open'] = true, ['class'] = 'update', ['outfits'] = html })
    isInMenu = true
end)

RegisterNetEvent("rl-outfits:client:updateUI")
AddEventHandler("rl-outfits:client:updateUI", function(outfits)
    local html = ""

    for i=1,7 do 
        if outfits[i] then
            html = html .. '<div class="box box-shadow option-enabled item selectoutfit" id="item-' .. i .. '"><span class="hoster-options" id="options-' .. i .. '"><span style="position: relative; top: 15%; margin-left: 27%;"><i id="item-' .. i .. '" class="fas fa-trash-alt deleteoutfit"></i></span></span><span id="option-text">' .. i .. '. ' .. outfits[i].name .. '</span></div>'
        else
            html = html .. '<div class="box box-shadow" id="item-' .. i .. '"><span class="hoster-options" id="options-' .. i .. '"><span style="position: relative; top: 15%; margin-left: 27%;"><i id="item-' .. i .. '" class="fas fas fa-plus createoutfit"></i></span></span><span id="option-text">' .. i .. '. Empty Slot</span></div>'
        end
    end

    SendNUIMessage({ ['open'] = true, ['class'] = 'update', ['outfits'] = html })
end)

RegisterNetEvent("rl-outfits:client:SetClothing")
AddEventHandler("rl-outfits:client:SetClothing", function(data)
    SetSkin(data.model, true)
    SetClothing(data.drawables, data.props, data.drawtextures, data.proptextures)
    Citizen.Wait(500)
    SetPedHairColor(PlayerPedId(), tonumber(data.hairColor[1]), tonumber(data.hairColor[2]))
    SetPedHeadBlend(data.headBlend)
    SetHeadStructure(data.headStructure)
    SetHeadOverlayData(data.headOverlay)
    Wait(1000)
    if data['tats'] then
        currentTats = data['tats']
        print(json.encode(currentTats))
        SetTats(GetTats())
    end 
end)

RegisterNUICallback('closeNUI', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('CreateOutfit', function(data)
    local plyPed = PlayerPedId()
    local temp_data = {
        model = GetEntityModel(PlayerPedId()),
        hairColor = GetPedHair(),
        headBlend = GetPedHeadBlendData(),
        headOverlay = GetHeadOverlayData(),
        headStructure = GetHeadStructure(),
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        proptextures = GetPropTextures(),
    }
    
    TriggerServerEvent("rl-outfits:server:create", data.slot, data.name, temp_data)
end)

RegisterNUICallback('DeleteOutfit', function(data)
    TriggerServerEvent("rl-outfits:server:delete", data.slot)
end)

RegisterNUICallback('SelectOutfit', function(data)
    TriggerServerEvent("rl-outfits:server:use", data.slot)
end)

local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}
local prop_names = {"hats", "glasses", "earrings", "mouth", "lhand", "rhand", "watches", "braclets"}
local head_overlays = {"Blemishes","FacialHair","Eyebrows","Ageing","Makeup","Blush","Complexion","SunDamage","Lipstick","MolesFreckles","ChestHair","BodyBlemishes","AddBodyBlemishes"}
local face_features = {"Nose_Width","Nose_Peak_Hight","Nose_Peak_Lenght","Nose_Bone_High","Nose_Peak_Lowering","Nose_Bone_Twist","EyeBrown_High","EyeBrown_Forward","Cheeks_Bone_High","Cheeks_Bone_Width","Cheeks_Width","Eyes_Openning","Lips_Thickness","Jaw_Bone_Width","Jaw_Bone_Back_Lenght","Chimp_Bone_Lowering","Chimp_Bone_Lenght","Chimp_Bone_Width","Chimp_Hole","Neck_Thikness"}
local tatCategory = GetTatCategs()
local tattooHashList = CreateHashList()

function SetSkin(model, setDefault)
    SetEntityInvincible(PlayerPedId(),true)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while (not HasModelLoaded(model)) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
        local player = PlayerPedId()
        FreezePedCameraRotation(player, true)
    end
    SetEntityInvincible(PlayerPedId(),false)
end

function SetHeadOverlayData(data)
    local player = PlayerPedId()
    if json.encode(data) ~= "[]" then
        for i = 1, #head_overlays do
            SetPedHeadOverlay(player,  i-1, tonumber(data[i].overlayValue),  tonumber(data[i].overlayOpacity))
        end

        SetPedHeadOverlayColor(player, 0, 0, tonumber(data[1].firstColour), tonumber(data[1].secondColour))
        SetPedHeadOverlayColor(player, 1, 1, tonumber(data[2].firstColour), tonumber(data[2].secondColour))
        SetPedHeadOverlayColor(player, 2, 1, tonumber(data[3].firstColour), tonumber(data[3].secondColour))
        SetPedHeadOverlayColor(player, 3, 0, tonumber(data[4].firstColour), tonumber(data[4].secondColour))
        SetPedHeadOverlayColor(player, 4, 2, tonumber(data[5].firstColour), tonumber(data[5].secondColour))
        SetPedHeadOverlayColor(player, 5, 2, tonumber(data[6].firstColour), tonumber(data[6].secondColour))
        SetPedHeadOverlayColor(player, 6, 0, tonumber(data[7].firstColour), tonumber(data[7].secondColour))
        SetPedHeadOverlayColor(player, 7, 0, tonumber(data[8].firstColour), tonumber(data[8].secondColour))
        SetPedHeadOverlayColor(player, 8, 2, tonumber(data[9].firstColour), tonumber(data[9].secondColour))
        SetPedHeadOverlayColor(player, 9, 0, tonumber(data[10].firstColour), tonumber(data[10].secondColour))
        SetPedHeadOverlayColor(player, 10, 1, tonumber(data[11].firstColour), tonumber(data[11].secondColour))
        SetPedHeadOverlayColor(player, 11, 0, tonumber(data[12].firstColour), tonumber(data[12].secondColour))
    end
end

function SetPedHeadBlend(data)
    local player = PlayerPedId()
    SetPedHeadBlendData(player,
        tonumber(data['shapeFirst']),
        tonumber(data['shapeSecond']),
        tonumber(data['shapeThird']),
        tonumber(data['skinFirst']),
        tonumber(data['skinSecond']),
        tonumber(data['skinThird']),
        tonumber(data['shapeMix']),
        tonumber(data['skinMix']),
        tonumber(data['thirdMix']),
    false)
end

function GetPedHair()
    local player = PlayerPedId()
    local hairColor = {}
    hairColor[1] = GetPedHairColor(player)
    hairColor[2] = GetPedHairHighlightColor(player)
    return hairColor
end

function SetHeadStructure(data)
    local player = PlayerPedId()
    for i = 1, #face_features do
        SetPedFaceFeature(player, i-1, data[i])
    end
end

function GetPedHeadBlendData()
    local player = PlayerPedId()
    local blob = string.rep("\0\0\0\0\0\0\0\0", 6 + 3 + 1) -- Generate sufficient struct memory.
    if not Citizen.InvokeNative(0x2746BD9D88C5C5D0, player, blob, true) then -- Attempt to write into memory blob.
        return nil
    end

    return {
        shapeFirst = string.unpack("<i4", blob, 1),
        shapeSecond = string.unpack("<i4", blob, 9),
        shapeThird = string.unpack("<i4", blob, 17),
        skinFirst = string.unpack("<i4", blob, 25),
        skinSecond = string.unpack("<i4", blob, 33),
        skinThird = string.unpack("<i4", blob, 41),
        shapeMix = string.unpack("<f", blob, 49),
        skinMix = string.unpack("<f", blob, 57),
        thirdMix = string.unpack("<f", blob, 65),
        hasParent = string.unpack("b", blob, 73) ~= 0,
    }
end

function GetHeadOverlayData()
    local player = PlayerPedId()
    local headData = {}
    for i = 1, #head_overlays do
        local retval, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(player, i-1)
        if retval then
            headData[i] = {}
            headData[i].name = head_overlays[i]
            headData[i].overlayValue = overlayValue
            headData[i].colourType = colourType
            headData[i].firstColour = firstColour
            headData[i].secondColour = secondColour
            headData[i].overlayOpacity = overlayOpacity
        end
    end
    return headData
end

function GetHeadStructure(data)
    local player = PlayerPedId()
    local structure = {}
    for i = 1, #face_features do
        structure[i] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function GetDrawables()
    local player = PlayerPedId()
    local drawables = {}
    local model = GetEntityModel(player)
    local mpPed = false
    if (model == `mp_f_freemode_01` or model == `mp_m_freemode_01`) then
        mpPed = true
    end
    for i = 0, #drawable_names-1 do
        if mpPed and drawable_names[i+1] == "undershirts" and GetPedDrawableVariation(player, i) == -1 then
            SetPedComponentVariation(player, i, 15, 0, 2)
        end
        drawables[i] = {drawable_names[i+1], GetPedDrawableVariation(player, i)}
    end
    return drawables
end

function GetProps()
    local player = PlayerPedId()
    local props = {}
    for i = 0, #prop_names-1 do
        props[i] = {prop_names[i+1], GetPedPropIndex(player, i)}
    end
    return props
end

function GetDrawTextures()
    local player = PlayerPedId()
    local textures = {}
    for i = 0, #drawable_names-1 do
        table.insert(textures, {drawable_names[i+1], GetPedTextureVariation(player, i)})
    end
    return textures
end

function GetPropTextures()
    local player = PlayerPedId()
    local textures = {}
    for i = 0, #prop_names-1 do
        table.insert(textures, {prop_names[i+1], GetPedPropTextureIndex(player, i)})
    end
    return textures
end

function SetClothing(drawables, props, drawTextures, propTextures)
    local player = PlayerPedId()
    for i = 1, #drawable_names do
        if drawables[0] == nil then
            if drawable_names[i] == "undershirts" and drawables[tostring(i-1)][2] == -1 then
                SetPedComponentVariation(player, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(player, i-1, drawables[tostring(i-1)][2], drawTextures[i][2], 2)
            end
        else
            if drawable_names[i] == "undershirts" and drawables[i-1][2] == -1 then
                SetPedComponentVariation(player, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(player, i-1, drawables[i-1][2], drawTextures[i][2], 2)
            end
        end
    end

    for i = 1, #prop_names do
        local propZ = (drawables[0] == nil and props[tostring(i-1)][2] or props[i-1][2])
        ClearPedProp(player, i-1)
        SetPedPropIndex(player, i-1, propZ,propTextures[i][2], true)
    end
end

function GetTats()
    print(json.encode(currentTats))

    local tempTats = {}
    if currentTats == nil then return {} end
    for i = 1, #currentTats do
        for key in pairs(tattooHashList) do
            for j = 1, #tattooHashList[key] do
                if tattooHashList[key][j][1] == currentTats[i][2] then
                    tempTats[key] = j
                end
            end
        end
    end
    return tempTats
end

function SetTats(data)
    currentTats = {}
    for k, v in pairs(data) do
        for categ in pairs(tattooHashList) do
            if k == categ then
                local something = tattooHashList[categ][tonumber(v)]
                if something ~= nil then
                    table.insert(currentTats, {something[2], something[1]})
                end
            end
        end
    end
    ClearPedDecorations(PlayerPedId())
    for i = 1, #currentTats do
        ApplyPedOverlay(PlayerPedId(), currentTats[i][1], currentTats[i][2])
    end
end