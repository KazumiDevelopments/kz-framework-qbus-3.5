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

local inmate = 0
local mycell = 1
local imjailed = false
local lockdown = false


Citizen.CreateThread(function()
    
    while true do
        local waitCheck = #(GetEntityCoords(PlayerPedId()) - vector3(Config.Locations["reclaim_items"]["x"], Config.Locations["reclaim_items"]["y"], Config.Locations["reclaim_items"]["z"]))
        local waitCheck2 = #(GetEntityCoords(PlayerPedId()) - vector3(Config.Locations["shop"]["x"], Config.Locations["shop"]["y"], Config.Locations["shop"]["z"]))
        if waitCheck < 15 then
            DrawText3D(Config.Locations["reclaim_items"]["x"], Config.Locations["reclaim_items"]["y"], Config.Locations["reclaim_items"]["z"]+1, 'Press [E] to re-claim your possessions.')
            DrawMarker(27,vector3(Config.Locations["reclaim_items"]["x"], Config.Locations["reclaim_items"]["y"], Config.Locations["reclaim_items"]["z"]), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.001, 1.0001, 0.5001, 0, 25, 165, 100, false, true, 2, false, false, false, false)
        end
        if waitCheck < 1.5 then
            if IsControlJustPressed(0,46) then
                TriggerServerEvent("jail:reclaimPossessions")
                TriggerEvent("debug", 'Jail: Reclaim Possessions', 'success')
                RLCore.Functions.Notify("You have re-claimed your possessions.", "success")
                Wait(15000)
            end
        end
        if waitCheck2 < 15 then
            DrawText3D(Config.Locations["shop"]["x"], Config.Locations["shop"]["y"], Config.Locations["shop"]["z"]-0.2, 'Press [E] to open shop.')
            DrawMarker(27, vector3(Config.Locations["shop"]["x"], Config.Locations["shop"]["y"], Config.Locations["shop"]["z"]-0.8), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.001, 1.0001, 0.5001, 0, 25, 165, 100, false, true, 2, false, false, false, false)
            if IsControlJustPressed(0,46) then
                Config.Shop['slots'] = #Config.Shop['items']
                TriggerServerEvent("inventory:server:OpenInventory", "shop", "out-jail" ,Config.Shop)
            end
        end
        waitCheck = ((waitCheck < 15 or waitCheck2 < 2.5) and 1 or (waitCheck+waitCheck2)/2)
        Wait(math.ceil(waitCheck))
    end
end)

local inDelivery = false
Citizen.CreateThread(function()
    while true do
        Wait(1)
        local start = #(GetEntityCoords(PlayerPedId()) - vector3(Config.Deliveries['start']["x"], Config.Deliveries['start']["y"], Config.Deliveries['start']["z"]))
        if start < 5 and imjailed then
            DrawText3D(Config.Deliveries['start']["x"], Config.Deliveries['start']["y"], Config.Deliveries['start']["z"], 'Press [E] to start delivery.')
            if start < 2.5 then
                if IsControlJustPressed(0,38) then
                    inDelivery = math.random(#Config.Deliveries['drops'])
                    while inDelivery do
                        Wait(1)
                        local distance = #(GetEntityCoords(PlayerPedId()) - vector3(Config.Deliveries['drops'][inDelivery]["x"], Config.Deliveries['drops'][inDelivery]["y"], Config.Deliveries['drops'][inDelivery]["z"]))
                        if distance < 2.5 then
                            DrawText3D(Config.Deliveries['drops'][inDelivery]["x"], Config.Deliveries['drops'][inDelivery]["y"], Config.Deliveries['drops'][inDelivery]["z"], 'Press [E] to drop delivery.')
                            if IsControlJustPressed(0,38) then
                                loadAnimDict("mp_safehouselost@")
                                TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
                                Citizen.Wait(2000)
                                inDelivery = false
                                TriggerServerEvent("jail:drop")
                            end
                        else
                            DrawText3D(Config.Deliveries['drops'][inDelivery]["x"], Config.Deliveries['drops'][inDelivery]["y"], Config.Deliveries['drops'][inDelivery]["z"], 'Drop delivery.')
                        end
                    end
                end
            end
        else
            Wait(1000)
        end
    end
end)

function drink()
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "mp_player_intdrink" ) 

    TaskPlayAnim( PlayerPedId(), "mp_player_intdrink", "loop_bottle", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Citizen.Wait(5000)

    endanimation()
end

function endanimation()
    ClearPedSecondaryTask(PlayerPedId())
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end


function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function MissionText(self, text, time)
    if not text then return end

    text = tostring(text)
    
    drawTxt(0.97, 1.43, 1.0,1.0,0.4, text, 255, 255, 255, 255)  -- INT: kmh
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('ai:removePeds')
AddEventHandler('ai:removePeds', function(cops,prisoners)
   for i,v in ipairs(cops) do
        local ped = NetworkGetEntityFromNetworkId(v)

        DeletePed(ped)
   end
   for i,v in ipairs(prisoners) do
        local ped = NetworkGetEntityFromNetworkId(v)

        DeletePed(ped)
   end  
end)



function DrawMarkerRad(markerType,x,y,z,arg1,arg2,arg3,arg4,arg5,arg6,sx,sy,sz,r,g,b,a,upDown,face,p19,rotate,texture,textureName,drawEnts)
    local dist = #(vector3(x,y,z) - GetEntityCoords(PlayerPedId()))
    if dist < 40 then
      local dist = math.floor(a - (dist * 10))
      if dist < 0 then dist = 0 end
      DrawMarker(markerType,x,y,z,arg1,arg2,arg3,arg4,arg5,arg6,sx,sy,sz,r,g,b,dist,upDown,face,p19,rotate,texture,textureName,drawEnts)
    end
end


local hasMoved = false
RegisterNetEvent('jail:lockdown')
AddEventHandler('jail:lockdown', function(lockdownState)
    lockdown = lockdownState
    if lockdown and imjailed and not hasMoved then
        mycell = math.random(1,32)
        mycell = math.ceil(mycell)
        SetEntityCoords(PlayerPedId(), Config.PrisonCells[mycell].x,Config.PrisonCells[mycell].y,Config.PrisonCells[mycell].z) 
        TriggerEvent("chatMessage", "DOC | " , { 33, 118, 255 }, "You have been placed into lockdown due to a disturbance.")
        hasMoved = true
    elseif not lockdown and imjailed then
        hasMoved = false
        TriggerEvent("chatMessage", "DOC | " , { 33, 118, 255 }, "Lockdown has ended.")
    end
end)


function JailIntro()
    TriggerEvent("debug", 'Jail: Intro', 'success')

    DoScreenFadeOut(10)
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'handcuff', 1.0)

    
    SetPedComponentVariation(PlayerPedId(), 1, -1, -1, -1)
    ClearPedProp(PlayerPedId(), 0)

    Citizen.Wait(1000)

    SetEntityCoords(PlayerPedId(),Config.Locations["takephotos"]["x"],Config.Locations["takephotos"]["y"],Config.Locations["takephotos"]["z"])
    SetEntityHeading(PlayerPedId(),270.0)
    Citizen.Wait(1500) 
    DoScreenFadeIn(500)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000) 
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)     
    SetEntityHeading(PlayerPedId(),-355.74) 

    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)  
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)         
    SetEntityHeading(PlayerPedId(),170.74) 

    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000) 
     TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)       

    SetEntityHeading(PlayerPedId(),270.0)

    Citizen.Wait(2000)
    DoScreenFadeOut(1100)   
    Citizen.Wait(2000)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'jaildoor', 1.0)

end

DoScreenFadeIn(1500)
outofrange = false
minutes = 0

function InmateAnim()
    if ( DoesEntityExist( inmate ) and not IsEntityDead( inmate ) ) then 
        loadAnimDict( "random@mugging4" )
        TaskPlayAnim( inmate, "random@mugging4", "agitated_loop_a", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    end
end

function InmateDelete()
    if DoesEntityExist(inmate) then 
        SetPedAsNoLongerNeeded(inmate)
        DeletePed(inmate)
    end
end

function InmateCreate()
    local hashKey = -1313105063
    local pedType = 5
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end
    inmate = CreatePed(pedType, hashKey, 1642.08, 2522.16, 45.57, 43.62, false, false)
end

function InmatePedSettings()
    SetEntityInvincible(inmate,true)
    ClearPedTasks(inmate)
    ClearPedSecondaryTask(inmate)
    TaskSetBlockingOfNonTemporaryEvents(inmate, true)
    SetPedFleeAttributes(inmate, 0, 0)
    SetPedCombatAttributes(inmate, 17, 1)
    SetPedSeeingRange(inmate, 0.0)
    SetPedHearingRange(inmate, 0.0)
    SetPedAlertness(inmate, 0)
    SetPedKeepTask(inmate, true)
end

RegisterNetEvent('beginJail')
AddEventHandler('beginJail', function(time, delivery)
    if not imjailed then
        TriggerEvent("debug", 'Jail: Items Saved', 'success')
        TriggerServerEvent("jail:saveItems")
    end

    imjailed = false
    local playerPed = PlayerPedId()

    mycell = math.random(1,#Config.PrisonCells)
    minutes = tonumber(time)

    JailIntro()
    FreezeEntityPosition(playerPed, false)
    
    DoScreenFadeOut(1)
    if mycell == nil then
        mycell = 1
    end
    SetEntityCoords(playerPed, Config.PrisonCells[mycell].x,Config.PrisonCells[mycell].y,Config.PrisonCells[mycell].z ) 
 
    InmateDelete()
    InmateCreate()
    InmatePedSettings()
    InmateAnim()


    Citizen.Wait(500)
    FreezeEntityPosition(playerPed, false)
    DoScreenFadeIn(1500)
    TriggerServerEvent("RLCore:Server:SetMetaData", "injail", minutes)
    imjailed = true
    RemoveAllPedWeapons(playerPed)
    TriggerEvent("notification", "You have been jailed. You can pick up your shit when you leave.")

    local playerName = GetPlayerName(PlayerId())
    local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel") 
    if getPlayerRadioChannel == "nil" then
        -- Do nothing
    else
        exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
        exports.tokovoip_script:setPlayerData(playerName, "radio:channel", "nil", true) 
        TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
    end

    local timer = minutes
    while imjailed do
        Citizen.Wait(60000)

        timer = timer - 1
        TriggerServerEvent("RLCore:Server:SetMetaData", "injail", timer)

        if timer > 0 then
            local playerPed = PlayerPedId()
            if (#(GetEntityCoords(playerPed) - vector3(Config.PrisonCells[mycell].x,Config.PrisonCells[mycell].y,Config.PrisonCells[mycell].z)) > 340) then
                SetEntityCoords(playerPed, Config.PrisonCells[mycell].x,Config.PrisonCells[mycell].y,Config.PrisonCells[mycell].z) 
            end

            TriggerEvent('chat:addMessage', {
                template = '<div class="chat-message" style="backgroud-color: rgb(33, 118, 255);">You have ' .. timer .. ' months remaining</div>',
                args = {}
            })
        else
            print('2')
            imjailed = false
        end
    end

    TriggerServerEvent("RLCore:Server:SetMetaData", "injail", 0)
    TriggerEvent("notification", "You are free!.",1)
    SetEntityCoords(playerPed, Config.Locations["outjail"]["x"], Config.Locations["outjail"]["y"],Config.Locations["outjail"]["z"])
end)

RegisterNetEvent('endJailTime')
AddEventHandler('endJailTime', function()
    imjailed = false
    TriggerEvent("debug", 'Jail: End Jail Time', 'success')
end)

selectedCell = 0

function DrawText3D(x,y,z, text) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end