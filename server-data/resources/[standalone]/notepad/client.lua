-- Settings
local guiEnabled = false
local hasOpened = false
local serverNotes = {}
local Controlkey = {["generalUse"] = {38,"E"},["generalUseSecondaryWorld"] = {47,"G"}} 

function openGui()
  SetPlayerControl(PlayerId(), 0, 0)
  guiEnabled = true
  SetNuiFocus(true)
  Citizen.Trace("OPENING")
  SendNUIMessage({openSection = "openNotepad"})

  local inveh = IsPedSittingInAnyVehicle(PlayerPedId())
  TriggerEvent("notepad")
end

function openGuiRead(text)
  SetPlayerControl(PlayerId(), 0, 0)
  guiEnabled = true
  SetNuiFocus(true)
  Citizen.Trace("OPENING")
  SendNUIMessage({openSection = "openNotepadRead", TextRead = text})
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function closeGui()
  guiEnabled = false
  ped = PlayerPedId();
  ClearPedTasks(ped);
  Citizen.Trace("CLOSING")
  SetNuiFocus(false)
  SendNUIMessage({openSection = "close"})
  ClearPedSecondaryTask(PlayerPedId())
  DetachEntity(prop, 1, 1)
  DeleteObject(prop)
  DetachEntity(secondaryprop, 1, 1)
  DeleteObject(secondaryprop)
  SetPlayerControl(PlayerId(), 1, 0)
end

RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNUICallback('drop', function(data, cb)
  closeGui()
  local coords = GetEntityCoords(PlayerPedId())
  TriggerServerEvent("server:newNote",data.noteText,coords["x"],coords["y"],coords["z"])
end)

RegisterNetEvent('notepad')
AddEventHandler('notepad', function()
    local player = PlayerPedId()
    local ad = "missheistdockssetup1clipboard@base"
                
    local prop_name = prop_name or 'prop_notepad_01'
    local secondaryprop_name = secondaryprop_name or 'prop_pencil_01'
    
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( ad )
        if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
            TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
            Citizen.Wait(100)
            ClearPedSecondaryTask(PlayerPedId())
            DetachEntity(prop, 1, 1)
            DeleteObject(prop)
            DetachEntity(secondaryprop, 1, 1)
            DeleteObject(secondaryprop)
        else
            local x,y,z = table.unpack(GetEntityCoords(player))
            prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
            secondaryprop = CreateObject(GetHashKey(secondaryprop_name), x, y, z+0.2,  true,  true, true)
            AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 18905), 0.1, 0.02, 0.05, 10.0, 0.0, 0.0, true, true, false, true, 1, true) -- lkrp_notepadpad
            AttachEntityToEntity(secondaryprop, player, GetPedBoneIndex(player, 58866), 0.12, 0.0, 0.001, -150.0, 0.0, 0.0, true, true, false, true, 1, true) -- pencil
            TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
        end     
    end
end)

function DrawText3Ds(x,y,z, text)
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

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)


    if #serverNotes == 0 then
      Citizen.Wait(1000)
    else
      local plyLoc = GetEntityCoords(PlayerPedId())
      local closestNoteDistance = 900.0
      local closestNoteId = 0
      for i = 1, #serverNotes do
        local distance = #(plyLoc - vector3( serverNotes[i]["x"],serverNotes[i]["y"],serverNotes[i]["z"]))

        if distance < 10.0 then
            DrawMarker(27, serverNotes[i]["x"],serverNotes[i]["y"],serverNotes[i]["z"]-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 2.0, 255, 255,150, 75, 0, 0, 2, 0, 0, 0, 0)
        end

        if distance < closestNoteDistance then
          closestNoteDistance = distance
          closestNoteId = i
        end
      end

      if closestNoteDistance > 100.0 then
        Citizen.Wait(math.ceil(closestNoteDistance*10))
      end
      if serverNotes[closestNoteId] ~= nil then
        local distance = #(plyLoc - vector3( serverNotes[closestNoteId]["x"],serverNotes[closestNoteId]["y"],serverNotes[closestNoteId]["z"]))
        if distance < 2.0 then
            DrawMarker(27, serverNotes[closestNoteId]["x"],serverNotes[closestNoteId]["y"],serverNotes[closestNoteId]["z"]-0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 2.0, 255, 255, 155, 75, 0, 0, 2, 0, 0, 0, 0)
            DrawText3Ds(serverNotes[closestNoteId]["x"],serverNotes[closestNoteId]["y"],serverNotes[closestNoteId]["z"]-0.4, "~g~"..Controlkey["generalUse"][2].."~s~ to read,~g~ "..Controlkey["generalUseSecondaryWorld"][2].."~s~ to destroy")

            if IsControlJustReleased(0, Controlkey["generalUse"][1]) then
                openGuiRead(serverNotes[closestNoteId]["text"])
            end
            if IsControlJustReleased(0, Controlkey["generalUseSecondaryWorld"][1]) then
              TriggerServerEvent("server:destroyNote",closestNoteId)
            end

        end
      else
        if serverNotes[closestNoteId] ~= nil then
          table.remove(serverNotes,closestNoteId)
        end
      end
    end
  end
end)

RegisterNetEvent('Notepad:close')
AddEventHandler('Notepad:close', function()
  closeGui()
end)

RegisterNetEvent('client:updateNotes')
AddEventHandler('client:updateNotes', function(serverNotesPassed)
    serverNotes = serverNotesPassed
end)

RegisterNetEvent('client:updateNotesAdd')
AddEventHandler('client:updateNotesAdd', function(newNote)
    serverNotes[#serverNotes+1] = newNote 
end)
RegisterNetEvent('client:updateNotesRemove')
AddEventHandler('client:updateNotesRemove', function(id)
    table.remove(serverNotes,id)
end)

RegisterNetEvent('Notepad:open')
AddEventHandler('Notepad:open', function()
    local veh = GetVehiclePedIsUsing(PlayerPedId())  
    if GetPedInVehicleSeat(veh, -1) ~= PlayerPedId() then
      openGui()
      guiEnabled = true
    end
end)

CreateThread(function()
  Wait(200)
  TriggerServerEvent("server:requestNotes")
end)