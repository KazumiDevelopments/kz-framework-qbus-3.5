RLCore = nil
local PlayerData                = {}
local radioVolume = 100
local inRadio = false

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(10)
      if RLCore == nil then
          TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
          Citizen.Wait(200)
      end
  end
end)


local radioMenu = false

function PrintChatMessage(text)
    TriggerEvent('chatMessage', "system", { 255, 0, 0 }, text)
end



function enableRadio(enable)

  SetNuiFocus(true, true)
  radioMenu = enable

  SendNUIMessage({

    type = "enableui",
    enable = enable

  })
  RadioPlayAnim('text', false, true)
end

--- sprawdza czy komenda /radio jest włączony

RegisterCommand('radio', function(source, args)
    if Config.enableCmd then
      enableRadio(true)
    end
end, false)


-- radio tes

function hasRadio()
  local retval = nil

  RLCore.Functions.TriggerCallback('RLCore:HasItem', function(result)
    retval = result
  end, 'radio')

  while retval == nil do
    Wait(1)
  end

  return retval
end

local function leaveradio()
    RadioChannel = 0
    onRadio = false
    exports["pma-voice"]:setRadioChannel(0)
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
    RLCore.Functions.Notify(Config.messages['you_leave'] , 'error')
    inRadio = false
end



Citizen.CreateThread(function()
  while true do
    if RLCore ~= nil then
      if isLoggedIn then
        RLCore.Functions.TriggerCallback('radio:server:GetItem', function(hasItem)
          if not hasItem then          
            if inRadio then
              leaveradio()
            end
          end
        end, "radio")
      end
    end
    Citizen.Wait(2000)
  end
end)


-- dołączanie do radia

RegisterNUICallback('joinRadio', function(data, cb)
  local _source = source
  local job = RLCore.Functions.GetPlayerData().job.name
    local playerName = GetPlayerName(PlayerId())
--[[     local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel") ]]

  if tonumber(data.channel) then
    if tonumber(data.channel) == 999 then
      
      
    end
      if tonumber(data.channel) <= Config.RestrictedChannels then
        if job == "police" or job == "ambulance" or job == "doctor" or job == "mechanic" then
          exports["pma-voice"]:setRadioChannel(tonumber(data.channel))
          exports["pma-voice"]:setVoiceProperty("radioEnabled", true) 
          RLCore.Functions.Notify(Config.messages['joined_to_radio'] .. data.channel .. ' MHz </b>', 'error')
          inRadio = true
          TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
        elseif not job == "police" or job == "ambulance" or job == "doctor" or job == "mechanic" then
          RLCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
        end
      end
      if tonumber(data.channel) > Config.RestrictedChannels then
        exports["pma-voice"]:setRadioChannel(tonumber(data.channel))
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true) 
        RLCore.Functions.Notify(Config.messages['joined_to_radio'] .. data.channel .. ' MHz </b>', 'error')
        inRadio = true
    TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
      end
    else
     -- exports['mythic_notify']:SendAlert('error', Config.messages['you_on_radio'] .. data.channel .. '.00 MHz </b>')
  --TriggerEvent("notification",  Config.messages['you_on_radio'] .. data.channel .. '.00 MHz </b>', 2)
    end
    --[[
  exports.tokovoip_script:removePlayerFromRadio(getPlayerRadioChannel)
  exports.tokovoip_script:setPlayerData(playerName, "radio:channel", tonumber(data.channel), true);
  exports.tokovoip_script:addPlayerToRadio(tonumber(data.channel))
  PrintChatMessage("radio: " .. data.channel)
  print('radiook')
    ]]--
  cb('ok')
end)


-- opuszczanie radia

RegisterNUICallback('leaveRadio', function(data, cb)
  local playerName = GetPlayerName(PlayerId())
  TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
  leaveradio()
  cb('ok')

end)


RegisterNUICallback('escape', function(data, cb)

  enableRadio(false)
  SetNuiFocus(false, false)
  RadioPlayAnim('out', false, true)


  cb('ok')
end)

-- net eventy

RegisterNetEvent('ls-radio:use')
AddEventHandler('ls-radio:use', function()
  enableRadio(true)
end)

RegisterNetEvent('ls-radio:onRadioDrop')
AddEventHandler('ls-radio:onRadioDrop', function()
  local playerName = GetPlayerName(PlayerId())
--[[   local getPlayerRadioChannel = exports.tokovoip_script:getPlayerData(playerName, "radio:channel") ]]
  --if getPlayerRadioChannel ~= "nil" then
    exports["pma-voice"]:SetRadioChannel(0)
    --exports['mythic_notify']:SendAlert('inform', Config.messages['you_leave'] .. getPlayerRadioChannel .. '.00 MHz </b>')
 -- end
end)


Citizen.CreateThread(function()
    while true do
        if radioMenu then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown

            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate

            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterNUICallback('volumeUp', function(data, cb)
    setVolumeUp()
end)
  
RegisterNUICallback('volumeDown', function(data, cb)
    setVolumeDown()
end)

RegisterNUICallback('click', function(data, cb)
TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.6)
end)


RegisterNetEvent('tp-radio:setVolume')
AddEventHandler('tp-radio:setVolume', function(radioVolume, total)
    SendNUIMessage({

        type = "volume",
        volume = total

    })
    exports["pma-voice"]:setRadioVolume(radioVolume)
    print("Radio volume is now at:")
    json.encode(print(radioVolume))
end)

function setVolumeDown()
    if radioVolume <= 0 then
        radioVolume = 0
    else
        radioVolume = radioVolume - 10
    end
    total = (radioVolume)
    RLCore.Functions.Notify("Radio volume is now: " .. total .. "%")
    --exports['mythic_notify']:DoHudText('inform', "Radio volume is now: " .. total .. "%")
    TriggerEvent('tp-radio:setVolume', radioVolume, total)
end

function setVolumeUp()
    if radioVolume >= 100 then
        radioVolume = 100
    else
        radioVolume = radioVolume + 10
    end
    total = (radioVolume)
    RLCore.Functions.Notify("Radio volume is now: " .. total .. "%")
    --exports['mythic_notify']:DoHudText('inform', "Radio volume is now: " .. total .. "%")
    TriggerEvent('tp-radio:setVolume', radioVolume, total)
end