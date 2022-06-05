local currentJob = "Unemployed"
local showDispatchLog = false
local disableNotifications = false
local disableNotificationSounds = false

Citizen.CreateThread(function()
    while RLCore == nil do
        Citizen.Wait(10)
        TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
    end

    while RLCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(1)
    end

    currentJob = RLCore.Functions.GetPlayerData().job.name
end)

RegisterNetEvent('RLCore:Client:OnJobUpdate')
AddEventHandler('RLCore:Client:OnJobUpdate', function(JobInfo)
    currentJob = JobInfo.name
end)

colors = {
    [1] = "Metallic Graphite Black",
    [2] = "Metallic Black Steel",
    [3] = "Metallic Dark Silver",
    [4] = "Metallic Silver",
    [5] = "Metallic Blue Silver",
    [6] = "Metallic Steel Gray",
    [7] = "Metallic Shadow Silver",
    [8] = "Metallic Stone Silver",
    [9] = "Metallic Midnight Silver",
    [10] = "Metallic Gun Metal",
    [11] = "Metallic Anthracite Grey",
    [12] = "Matte Black",
    [13] = "Matte Gray",
    [14] = "Matte Light Grey",
    [15] = "Util Black",
    [16] = "Util Black Poly",
    [17] = "Util Dark silver",
    [18] = "Util Silver",
    [19] = "Util Gun Metal",
    [20] = "Util Shadow Silver",
    [21] = "Worn Black",
    [22] = "Worn Graphite",
    [23] = "Worn Silver Grey",
    [24] = "Worn Silver",
    [25] = "Worn Blue Silver",
    [26] = "Worn Shadow Silver",
    [27] = "Metallic Red",
    [28] = "Metallic Torino Red",
    [29] = "Metallic Formula Red",
    [30] = "Metallic Blaze Red",
    [31] = "Metallic Graceful Red",
    [32] = "Metallic Garnet Red",
    [33] = "Metallic Desert Red",
    [34] = "Metallic Cabernet Red",
    [35] = "Metallic Candy Red",
    [36] = "Metallic Sunrise Orange",
    [37] = "Metallic Classic Gold",
    [38] = "Metallic Orange",
    [39] = "Matte Red",
    [40] = "Matte Dark Red",
    [41] = "Matte Orange",
    [42] = "Matte Yellow",
    [43] = "Util Red",
    [44] = "Util Bright Red",
    [45] = "Util Garnet Red",
    [46] = "Worn Red",
    [47] = "Worn Golden Red",
    [48] = "Worn Dark Red",
    [49] = "Metallic Dark Green",
    [50] = "Metallic Racing Green",
    [51] = "Metallic Sea Green",
    [52] = "Metallic Olive Green",
    [53] = "Metallic Green",
    [54] = "Metallic Gasoline Blue Green",
    [55] = "Matte Lime Green",
    [56] = "Util Dark Green",
    [57] = "Util Green",
    [58] = "Worn Dark Green",
    [59] = "Worn Green",
    [60] = "Worn Sea Wash",
    [61] = "Metallic Midnight Blue",
    [62] = "Metallic Dark Blue",
    [63] = "Metallic Saxony Blue",
    [64] = "Metallic Blue",
    [65] = "Metallic Mariner Blue",
    [66] = "Metallic Harbor Blue",
    [67] = "Metallic Diamond Blue",
    [68] = "Metallic Surf Blue",
    [69] = "Metallic Nautical Blue",
    [70] = "Metallic Bright Blue",
    [71] = "Metallic Purple Blue",
    [72] = "Metallic Spinnaker Blue",
    [73] = "Metallic Ultra Blue",
    [74] = "Metallic Bright Blue",
    [75] = "Util Dark Blue",
    [76] = "Util Midnight Blue",
    [77] = "Util Blue",
    [78] = "Util Sea Foam Blue",
    [79] = "Uil Lightning blue",
    [80] = "Util Maui Blue Poly",
    [81] = "Util Bright Blue",
    [82] = "Matte Dark Blue",
    [83] = "Matte Blue",
    [84] = "Matte Midnight Blue",
    [85] = "Worn Dark blue",
    [86] = "Worn Blue",
    [87] = "Worn Light blue",
    [88] = "Metallic Taxi Yellow",
    [89] = "Metallic Race Yellow",
    [90] = "Metallic Bronze",
    [91] = "Metallic Yellow Bird",
    [92] = "Metallic Lime",
    [93] = "Metallic Champagne",
    [94] = "Metallic Pueblo Beige",
    [95] = "Metallic Dark Ivory",
    [96] = "Metallic Choco Brown",
    [97] = "Metallic Golden Brown",
    [98] = "Metallic Light Brown",
    [99] = "Metallic Straw Beige",
    [100] = "Metallic Moss Brown",
    [101] = "Metallic Biston Brown",
    [102] = "Metallic Beechwood",
    [103] = "Metallic Dark Beechwood",
    [104] = "Metallic Choco Orange",
    [105] = "Metallic Beach Sand",
    [106] = "Metallic Sun Bleeched Sand",
    [107] = "Metallic Cream",
    [108] = "Util Brown",
    [109] = "Util Medium Brown",
    [110] = "Util Light Brown",
    [111] = "Metallic White",
    [112] = "Metallic Frost White",
    [113] = "Worn Honey Beige",
    [114] = "Worn Brown",
    [115] = "Worn Dark Brown",
    [116] = "Worn straw beige",
    [117] = "Brushed Steel",
    [118] = "Brushed Black steel",
    [119] = "Brushed Aluminium",
    [120] = "Chrome",
    [121] = "Worn Off White",
    [122] = "Util Off White",
    [123] = "Worn Orange",
    [124] = "Worn Light Orange",
    [125] = "Metallic Securicor Green",
    [126] = "Worn Taxi Yellow",
    [127] = "police car blue",
    [128] = "Matte Green",
    [129] = "Matte Brown",
    [130] = "Worn Orange",
    [131] = "Matte White",
    [132] = "Worn White",
    [133] = "Worn Olive Army Green",
    [134] = "Pure White",
    [135] = "Hot Pink",
    [136] = "Salmon pink",
    [137] = "Metallic Vermillion Pink",
    [138] = "Orange",
    [139] = "Green",
    [140] = "Blue",
    [141] = "Mettalic Black Blue",
    [142] = "Metallic Black Purple",
    [143] = "Metallic Black Red",
    [144] = "hunter green",
    [145] = "Metallic Purple",
    [146] = "Metaillic V Dark Blue",
    [147] = "MODSHOP BLACK1",
    [148] = "Matte Purple",
    [149] = "Matte Dark Purple",
    [150] = "Metallic Lava Red",
    [151] = "Matte Forest Green",
    [152] = "Matte Olive Drab",
    [153] = "Matte Desert Brown",
    [154] = "Matte Desert Tan",
    [155] = "Matte Foilage Green",
    [156] = "DEFAULT ALLOY COLOR",
    [157] = "Epsilon Blue",
    [158] = "Unknown",
}

function randomizeBlipLocation(pOrigin)
    local x = pOrigin.x
    local y = pOrigin.y
    local z = pOrigin.z
    local luck = math.random(2)
    y = math.random(25) + y
    if luck == 1 then
        x = math.random(25) + x
    end
    return {x = x, y = y, z = z}
end

RegisterNetEvent('dispatch:clNotify')
AddEventHandler('dispatch:clNotify', function(pNotificationData)
    if pNotificationData ~= nil and RLCore and RLCore.Functions.GetPlayerData().job then
        if pNotificationData.recipientList then
            for key, value in pairs(pNotificationData.recipientList) do
                if key == currentJob and value and not disableNotifications and RLCore.Functions.GetPlayerData().job.onduty then

                    if currentJob ~= "reporter" then
                        SendNUIMessage({
                            mId = "notification",
                            eData = pNotificationData
                        })
                        
                        TriggerEvent("dispatch:sendNewsBlip", {
                            currentJob = currentJob,
                            isImportant = pNotificationData.isImportant,
                            blipTenCode = pNotificationData.dispatchCode,
                            blipDescription = pNotificationData.dispatchMessage,
                            blipLocation = pNotificationData.origin,
                            blipSprite = pNotificationData.blipSprite,
                            blipColor = pNotificationData.blipColor
                        })
                    elseif currentJob == "reporter" then
                        RLCore.Functions.TriggerCallback('RLCore:HasItem', function(result)
                            if result then
                                local newsObject = {}
                                newsObject.dispatchMessage = "A 911 call has been picked up on your radio scanner!"
                                newsObject.displayCode = nil
                                newsObject.isImportant = false
                                newsObject.priority = 1
                                
                                SendNUIMessage({
                                    mId = "notification",
                                    eData = newsObject
                                })

                                TriggerEvent("dispatch:sendNewsBlip", {
                                    currentJob = currentJob,
                                    isImportant = pNotificationData.isImportant,
                                    blipTenCode = pNotificationData.dispatchCode,
                                    blipDescription = pNotificationData.dispatchMessage,
                                    blipLocation = pNotificationData.origin,
                                    blipSprite = pNotificationData.blipSprite,
                                    blipColor = pNotificationData.blipColor
                                })
                            end
                        end, 'radioscanner')
                    end

                    if(pNotificationData.playSound and currentJob ~= "reporter" and not disableNotificationSounds) then
                        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, pNotificationData.soundName, 0.6)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('dispatch:toggleNotifications')
AddEventHandler('dispatch:toggleNotifications', function(state)
    state = string.lower(state)
    if state == "on" then
        disableNotifications = false
        disableNotificationSounds = false
        TriggerEvent('RLCore:Notify', "Dispatch Enabled.")
    elseif state == "off" then
        disableNotifications = true
        disableNotificationSounds = true
        TriggerEvent('RLCore:Notify', "Dispatch Disabled.", 'error')
    elseif state == "mute" then
        disableNotifications = false
        disableNotificationSounds = true
        TriggerEvent('RLCore:Notify', "Dispatch Muted.")
    else
        TriggerEvent('RLCore:Notify', "You need to type in 'on', 'off' or 'mute'.", 'error')
    end
end)

RegisterNetEvent('dispatch:gunshot')
AddEventHandler('dispatch:gunshot', function()
    if currentJob ~= "police" and CallChance() then
        Citizen.CreateThread(function() 
            local street1 = GetStreetAndZone()
            local gender = IsPedMale(PlayerPedId())
            local plyPos = GetEntityCoords(PlayerPedId())
    
            local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
            local vehicleData = GetVehicleDescription() or {}
            local initialTenCode = (not isInVehicle and '10-71A' or '10-71B')
            local eventId = uuid()
            Wait(math.random(5000))
            TriggerServerEvent('dispatch:svNotify', {
              dispatchCode = initialTenCode,
              firstStreet = street1,
              gender = gender,
              model = vehicleData.model,
              plate = vehicleData.plate,
              firstColor = vehicleData.firstColor,
              secondColor = vehicleData.secondColor,
              heading = vehicleData.heading,
              eventId = eventId,
              origin = {
                x = plyPos.x,
                y = plyPos.y,
                z = plyPos.z
              }
            })
        end)
    end
end)

RegisterNetEvent('dispatch:lockpick')
AddEventHandler('dispatch:lockpick', function(targetVehicle)
    if CallChance() then
        local street1 = GetStreetAndZone()
        local gender = IsPedMale(PlayerPedId())
        local origin = GetEntityCoords(PlayerPedId())
        local vehicleData = GetVehicleDescription() or {}
        if DoesEntityExist(targetVehicle) then
            TriggerServerEvent('dispatch:svNotify', {
                dispatchCode = '10-60',
                firstStreet = street1,
                gender = gender,
                model = vehicleData.model,
                plate = vehicleData.plate,
                firstColor = vehicleData.firstColor,
                secondColor = vehicleData.secondColor,
                heading = vehicleData.heading,
                eventId = uuid(),
                origin = {
                  x = origin.x,
                  y = origin.y,
                  z = origin.z
                }
            })
        end
    end
end)

RegisterNetEvent('dispatch:death')
AddEventHandler('dispatch:death', function()
    local street1 = GetStreetAndZone()
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    local gender = IsPedMale(PlayerPedId())
  
    TriggerServerEvent('dispatch:svNotify', {
      dispatchCode = "10-47",
      firstStreet = street1,
      gender = gender,
      origin = {
        x = plyPos.x,
        y = plyPos.y,
        z = plyPos.z
      }
    })
end)

RegisterNetEvent('dispatch:officerDown')
AddEventHandler('dispatch:officerDown', function()
    if currentJob == 'police' then
        local playerData = RLCore.Functions.GetPlayerData()
        local callsignal = playerData.metadata["callsign"] ~= nil and playerData.metadata["callsign"] or "None"
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "10-13A",
            firstStreet = GetStreetAndZone(),
            callSign = callsignal .. ' | ' .. playerData['charinfo']['firstname']:sub(1,1) .. '. ' .. playerData['charinfo']['lastname'],
			cid = playerData['cid'],
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			  }
		})
	end
end)

RegisterNetEvent('dispatch:emsDown')
AddEventHandler('dispatch:emsDown', function()
    if currentJob == 'ambulance' then
        local playerData = RLCore.Functions.GetPlayerData()
        local callsignal = playerData.metadata["callsign"] ~= nil and playerData.metadata["callsign"] or "None"
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "10-14A",
            firstStreet = GetStreetAndZone(),
            callSign = callsignal .. ' | ' .. playerData['charinfo']['firstname']:sub(1,1) .. '. ' .. playerData['charinfo']['lastname'],
			cid = RLCore.Functions.GetPlayerData()['cid'],
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			  }
		})
	end
end)

RegisterNetEvent('dispatch:officerDownB')
AddEventHandler('dispatch:officerDownB', function()
    if currentJob == 'police' then
        local playerData = RLCore.Functions.GetPlayerData()
        local callsignal = playerData.metadata["callsign"] ~= nil and playerData.metadata["callsign"] or "None"
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "10-13B",
            firstStreet = GetStreetAndZone(),
            callSign = callsignal .. ' | ' .. playerData['charinfo']['firstname']:sub(1,1) .. '. ' .. playerData['charinfo']['lastname'],
			cid = playerData['cid'],
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			  }
		})
	end
end)

RegisterNetEvent('dispatch:emsDownB')
AddEventHandler('dispatch:emsDownB', function()
    if currentJob == 'ambulance' then
        local playerData = RLCore.Functions.GetPlayerData()
        local callsignal = playerData.metadata["callsign"] ~= nil and playerData.metadata["callsign"] or "None"
		local pos = GetEntityCoords(PlayerPedId(),  true)
		TriggerServerEvent("dispatch:svNotify", {
			dispatchCode = "10-14B",
            firstStreet = GetStreetAndZone(),
            callSign = callsignal .. ' | ' .. playerData['charinfo']['firstname']:sub(1,1) .. '. ' .. playerData['charinfo']['lastname'],
			cid = RLCore.Functions.GetPlayerData()['cid'],
			origin = {
				x = pos.x,
				y = pos.y,
				z = pos.z
			  }
		})
	end
end)

RegisterNetEvent('dispatch:houseRobbery')
AddEventHandler('dispatch:houseRobbery', function()
    local eventId = uuid()
    local dispatchCode = "10-31A"
    local street1 = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = street1,
        gender = gender,
        eventId = eventId,
        origin = {
            x = plyPos.x,
            y = plyPos.y,
            z = plyPos.z
        }
    })
end)

RegisterNetEvent('dispatch:prisonBreak')
AddEventHandler('dispatch:prisonBreak', function()
    local eventId = uuid()
    local dispatchCode = "10-99"
    local street1 = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = street1,
        gender = gender,
        eventId = eventId,
        origin = {
            x = plyPos.x,
            y = plyPos.y,
            z = plyPos.z
        }
    })
end)

RegisterNetEvent('dispatch:storeRobbery')
AddEventHandler('dispatch:storeRobbery', function(txt)
    local eventId = uuid()
    local dispatchCode = "10-40A"
    local street1 = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = street1,
        gender = gender,
        eventId = eventId,
        origin = {
            x = plyPos.x,
            y = plyPos.y,
            z = plyPos.z
        }
    }, txt)
end)

RegisterNetEvent('dispatch:pacificRobbery')
AddEventHandler('dispatch:pacificRobbery', function()
    local eventId = uuid()
    local dispatchCode = "10-35A"
    local street1 = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = street1,
        gender = gender,
        eventId = eventId,
        origin = {
            x = plyPos.x,
            y = plyPos.y,
            z = plyPos.z
        }
    })
end)

RegisterNetEvent('dispatch:paletoRobbery')
AddEventHandler('dispatch:paletoRobbery', function()
    local eventId = uuid()
    local dispatchCode = "10-33A"
    local street1 = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = street1,
        gender = gender,
        eventId = eventId,
        origin = {
            x = plyPos.x,
            y = plyPos.y,
            z = plyPos.z
        }
    })
end)

RegisterNetEvent('dispatch:fleecaRobbery')
AddEventHandler('dispatch:fleecaRobbery', function()
    local eventId = uuid()
    local dispatchCode = "10-32A"
    local street1 = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = street1,
        gender = gender,
        eventId = eventId,
        origin = {
            x = plyPos.x,
            y = plyPos.y,
            z = plyPos.z
        }
    })
end)

RegisterNetEvent('dispatch:powerStation')
AddEventHandler('dispatch:powerStation', function()
    local eventId = uuid()
    local dispatchCode = "10-30B"
    local street1 = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = street1,
        gender = gender,
        eventId = eventId,
        origin = {
            x = plyPos.x,
            y = plyPos.y,
            z = plyPos.z
        }
    })
end)

RegisterNetEvent('dispatch:jewelryRobbery')
AddEventHandler('dispatch:jewelryRobbery', function()
    local eventId = uuid()
    local dispatchCode = "10-32B"
    local street1 = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = street1,
        gender = gender,
        eventId = eventId,
        origin = {
            x = plyPos.x,
            y = plyPos.y,
            z = plyPos.z
        }
    })
end)

RegisterNetEvent('dispatch:truckRobbery')
AddEventHandler('dispatch:truckRobbery', function()
    local eventId = uuid()
    local dispatchCode = "10-90"
    local street1 = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = street1,
        gender = gender,
        eventId = eventId,
        origin = {
            x = plyPos.x,
            y = plyPos.y,
            z = plyPos.z
        }
    })
end)

RegisterNetEvent('dispatch:drugtrafficking')
AddEventHandler('dispatch:drugtrafficking', function()
    local eventId = uuid()
    local dispatchCode = "10-29B"
    local street1 = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = street1,
        gender = gender,
        eventId = eventId,
        origin = {
            x = plyPos.x,
            y = plyPos.y,
            z = plyPos.z
        }
    })
end)

RegisterNetEvent('dispatch:illegaldiving')
AddEventHandler('dispatch:illegaldiving', function()
    local eventId = uuid()
    local dispatchCode = "10-55B"
    local street1 = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = street1,
        gender = gender,
        eventId = eventId,
        origin = {
            x = plyPos.x,
            y = plyPos.y,
            z = plyPos.z
        }
    })
end)

RegisterNetEvent('dispatch:personRobbed')
AddEventHandler('dispatch:personRobbed', function()
    local eventId = uuid()
    local dispatchCode = "10-31B"
    local street1 = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = dispatchCode,
        firstStreet = street1,
        gender = gender,
        eventId = eventId,
        origin = {
            x = plyPos.x,
            y = plyPos.y,
            z = plyPos.z
        }
    })
end)

RegisterNetEvent('dispatch:fight')
AddEventHandler('dispatch:fight', function()
    if currentJob ~= "police" and CallChance() then
        local street1 = GetStreetAndZone()
        local gender = IsPedMale(PlayerPedId())
        local armed = IsPedArmed(PlayerPedId(), 7)
        local plyPos = GetEntityCoords(PlayerPedId(), true)
  
        local dispatchCode = "10-10"
  
        if armed then
        dispatchCode = "10-11"
        end
  
        local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local eventId = uuid()
  
        TriggerServerEvent('dispatch:svNotify', {
            dispatchCode = dispatchCode,
            firstStreet = street1,
            gender = gender,
            eventId = eventId,
            origin = {
                x = plyPos.x,
                y = plyPos.y,
                z = plyPos.z
            }
        })
    end
end)

RegisterNetEvent('dispatch:carCrash')
AddEventHandler('dispatch:carCrash', function()
    if currentJob == "police" then
        local street1 = GetStreetAndZone()
        local plyPos = GetEntityCoords(PlayerPedId(), true)
        local gender = IsPedMale(PlayerPedId())
      
        local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local dispatchCode = "10-50"
        local eventId = uuid()
      
        TriggerServerEvent('dispatch:svNotify', {
          dispatchCode = dispatchCode,
          firstStreet = street1,
          gender = gender,
          eventId = eventId,
          origin = {
            x = plyPos.x,
            y = plyPos.y,
            z = plyPos.z
          }
        })
    end
end)

RegisterNetEvent('police:camera')
AddEventHandler('police:camera', function(id)
    if currentJob == "police" then
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message server"><b>DISPATCH:</b> {0}</div>',
            args = { "Security Camera number " .. id .. " has been triggered." }
        })
    end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if (IsControlJustReleased(0, 57) and (currentJob == "police" or currentJob == "ambulance" or currentJob == "reporter") and not RLCore.Functions.GetPlayerData().metadata["isdead"]) then
            showDispatchLog = not showDispatchLog
            SetNuiFocus(showDispatchLog, showDispatchLog)
            SetNuiFocusKeepInput(showDispatchLog)
            SendNUIMessage({
                mId = "showDispatchLog",
                eData = showDispatchLog
            })
        end
        if showDispatchLog then
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 263, true) -- disable melee
            DisableControlAction(0, 264, true) -- disable melee
            DisableControlAction(0, 257, true) -- disable melee
            DisableControlAction(0, 140, true) -- disable melee
            DisableControlAction(0, 141, true) -- disable melee
            DisableControlAction(0, 142, true) -- disable melee
            DisableControlAction(0, 143, true) -- disable melee
            DisableControlAction(0, 24, true) -- disable attack
            DisableControlAction(0, 25, true) -- disable aim
            DisableControlAction(0, 47, true) -- disable weapon
            DisableControlAction(0, 58, true) -- disable weapon
            DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
        end
    end
end)

RegisterNUICallback('disableGui', function(data, cb)
    showDispatchLog = not showDispatchLog
    SetNuiFocus(showDispatchLog, showDispatchLog)
    SetNuiFocusKeepInput(showDispatchLog)
end)

RegisterNUICallback('setGPSMarker', function(data, cb)
    SetNewWaypoint(data.gpsMarkerLocation.x, data.gpsMarkerLocation.y)
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        SetNuiFocus(false, false)
    end
end)

local myBlips = {}
RegisterNetEvent('dispatch:sendNewsBlip')
AddEventHandler('dispatch:sendNewsBlip', function(data)
    local blip = AddBlipForCoord(data.blipLocation.x, data.blipLocation.y, data.blipLocation.z)
    SetBlipScale(blip, 2.0)
    if data.isImportant then
      SetBlipFlashesAlternate(blip,true)
    end
    SetBlipSprite(blip, data.blipSprite)
    SetBlipColour(blip, data.blipColor)
    if data.currentJob == "reporter" then
      SetBlipSprite(blip, 459)
    end
    SetBlipAlpha(blip, 150)
    SetBlipHighDetail(blip, 1)
    BeginTextCommandSetBlipName("STRING")
  local displayText = data.blipDescription
  if data.currentJob == "reporter" then
    displayText = 'Scanner | ' .. data.blipDescription
  else
    displayText = data.blipTenCode .. " | " .. data.blipDescription
  end
  AddTextComponentString(displayText)
  EndTextCommandSetBlipName(blip)

  local blipId = math.random(1,60000)
  myBlips[blipId] = {
    timestamp = GetGameTimer(),
    pos = {
      x = data.blipLocation.x,
      y = data.blipLocation.y,
      z = data.blipLocation.z
    },
    blip = blip,
    id = blipId,
    jobType = data.currentJob
  }
  PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterCommand('cb', function(source)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local curTime = GetGameTimer()

    for key, item in pairs(myBlips) do
        RemoveBlip(item.blip)
    end
end)


Citizen.CreateThread(function()
    while true do
      local ped = PlayerPedId()
      local pos = GetEntityCoords(ped)
      local curTime = GetGameTimer()
  
      for key, item in pairs(myBlips) do
        if (key ~= nil and item ~= nil) and (#(vector2(pos.x, pos.y) - vector2(item.pos.x, item.pos.y)) < 50.0) or (GetTimeDifference(curTime, item.timestamp) > 600000 and not item.onRoute) then
            RemoveBlip(item.blip)
        end
      end
  
      Citizen.Wait(250)
    end
end)

function getRandomNpc(basedistance)

    local basedistance = basedistance
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = #(playerCoords - pos)
        if canPedBeUsed(ped) and distance < basedistance and distance > 2.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
        end
        success, ped = FindNextPed(handle)
    until not success

    EndFindPed(handle)

    return rped
end

function canPedBeUsed(ped)

    if math.random(100) > 15 then
      return false
    end

    if ped == nil then
        return false
    end

    if ped == PlayerPedId() then
        return false
    end

    if GetEntityHealth(ped) < GetEntityMaxHealth(ped) then
      return false
    end

    if `mp_f_deadhooker` == GetEntityModel(ped) then
      return false
    end

    local curcoords = GetEntityCoords(PlayerPedId())
    local startcoords = GetEntityCoords(ped)

    if #(curcoords - startcoords) < 10.0 then
      return false
    end    

    -- here we add areas that peds can not alert the police
    if #(curcoords - vector3( 1088.76, -3187.51, -38.99)) < 15.0 then
      return false
    end  

    if not DoesEntityExist(ped) then
        return false
    end

    if IsPedAPlayer(ped) then
        return false
    end

    if IsPedFatallyInjured(ped) then
        return false
    end
    
    if IsPedArmed(ped, 7) then
        return false
    end

    if IsPedInMeleeCombat(ped) then
        return false
    end

    if IsPedShooting(ped) then
        return false
    end

    if IsPedDucking(ped) then
        return false
    end

    if IsPedBeingJacked(ped) then
        return false
    end

    if IsPedSwimming(ped) then
        return false
    end

    if IsPedJumpingOutOfVehicle(ped) or IsPedBeingJacked(ped) then
        return false
    end

    local pedType = GetPedType(ped)
    if pedType == 6 or pedType == 27 or pedType == 29 or pedType == 28 then
        return false
    end
    return true
end

function CallChance()
    return true
end

function GetStreetAndZone()
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local zone = GetLabelText(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
    local street = street1 .. ", " .. zone
    return street
end

function uuid()
    math.randomseed(GetCloudTimeAsInt())
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
  end

  function GetVehicleDescription()
    local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if not DoesEntityExist(currentVehicle) then
      return
    end
  
    plate = GetVehicleNumberPlateText(currentVehicle)
    make = GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle))
    color1, color2 = GetVehicleColours(currentVehicle)
  
    if color1 == 0 then color1 = 1 end
    if color2 == 0 then color2 = 2 end
    if color1 == -1 then color1 = 158 end
    if color2 == -1 then color2 = 158 end 
  
    local dir = getCardinalDirectionFromHeading()
  
    local vehicleData  = {
      model = make,
      plate = plate,
      firstColor = colors[color1],
      secondColor = colors[color2],
      heading = dir
    }
    return vehicleData
  end

  function getCardinalDirectionFromHeading()
    local heading = GetEntityHeading(PlayerPedId())
    if heading >= 315 or heading < 45 then
        return "North Bound"
    elseif heading >= 45 and heading < 135 then
        return "West Bound"
    elseif heading >=135 and heading < 225 then
        return "South Bound"
    elseif heading >= 225 and heading < 315 then
        return "East Bound"
    end
end