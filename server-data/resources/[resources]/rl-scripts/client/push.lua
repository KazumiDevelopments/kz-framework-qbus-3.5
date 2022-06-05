local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }
  
  function ShowNotification(text)
      SetNotificationTextEntry("STRING")
      AddTextComponentString(text)
      DrawNotification(false, false)
  end
  
  function DrawText3D(coords, text, size)
      local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
      local camCoords      = GetGameplayCamCoords()
      local dist           = GetDistanceBetweenCoords(camCoords, coords.x, coords.y, coords.z, true)
      local size           = size
  
      if size == nil then
          size = 1
      end
  
      local scale = (size / dist) * 2
      local fov   = (1 / GetGameplayCamFov()) * 100
      local scale = scale * fov
  
      if onScreen then
          SetTextScale(0.0 * scale, 0.55 * scale)
          SetTextFont(0)
          SetTextProportional(1)
          SetTextColour(255, 255, 255, 255)
          SetTextDropshadow(0, 0, 0, 0, 255)
          SetTextEdge(2, 0, 0, 0, 150)
          SetTextDropShadow()
          SetTextOutline()
          SetTextEntry('STRING')
          SetTextCentre(1)
  
          AddTextComponentString(text)
          DrawText(x, y)
      end
  end
  
  local First = vector3(0.0, 0.0, 0.0)
  local Second = vector3(5.0, 5.0, 5.0)
  
  local Vehicle = {Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil}
  Citizen.CreateThread(function()
      Citizen.Wait(200)
      while true do
          local ped = PlayerPedId()
          local posped = GetEntityCoords(GetPlayerPed(-1))
          local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0)
          local rayHandle = CastRayPointToPoint(posped.x, posped.y, posped.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
          local a, b, c, d, closestVehicle = GetRaycastResult(rayHandle)
          local Distance = GetDistanceBetweenCoords(c.x, c.y, c.z, posped.x, posped.y, posped.z, false);
  
          local vehicleCoords = GetEntityCoords(closestVehicle)
          local dimension = GetModelDimensions(GetEntityModel(closestVehicle), First, Second)
  
          if Distance < 6.0  and not IsPedInAnyVehicle(ped, false) then
              Vehicle.Coords = vehicleCoords
              Vehicle.Dimensions = dimension
              Vehicle.Vehicle = closestVehicle
              Vehicle.Distance = Distance
              if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
                  Vehicle.IsInFront = false
              else
                  Vehicle.IsInFront = true
              end
          else
              Vehicle = {Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil}
          end
          Citizen.Wait(500)
      end
  end)
  
  
  Citizen.CreateThread(function()
      local lerpCurrentAngle = 0.0
  
      while true do 
          Citizen.Wait(5)
          local ped = PlayerPedId()
          if Vehicle.Vehicle ~= nil then
              if IsControlPressed(0, Keys["LEFTSHIFT"]) and IsVehicleSeatFree(Vehicle.Vehicle, -1) and not IsEntityAttachedToEntity(ped, Vehicle.Vehicle) and IsControlJustPressed(0, Keys["E"]) then
                  if not IsEntityUpsidedown(Vehicle.Vehicle) then
                      
                      NetworkRequestControlOfEntity(Vehicle.Vehicle)
                      local coords = GetEntityCoords(ped)
                      if Vehicle.IsInFront then    
                          AttachEntityToEntity(PlayerPedId(), Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y * -1 + 0.1 , Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
                      else
                          AttachEntityToEntity(PlayerPedId(), Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y - 0.3, Vehicle.Dimensions.z  + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
                      end
  
                      RequestAnimDict('missfinale_c2ig_11')
                      TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
                      Citizen.Wait(200)
                      while true do
                          Citizen.Wait(5)
  
                          local speed = GetFrameTime() * 50
                          if IsDisabledControlPressed(0, Keys["A"]) then
                              SetVehicleSteeringAngle(Vehicle.Vehicle, lerpCurrentAngle)
                              lerpCurrentAngle = lerpCurrentAngle + speed
                          elseif IsDisabledControlPressed(0, Keys["D"]) then
                              SetVehicleSteeringAngle(Vehicle.Vehicle, lerpCurrentAngle)
                              lerpCurrentAngle = lerpCurrentAngle - speed
                          else
                              SetVehicleSteeringAngle(Vehicle.Vehicle, lerpCurrentAngle)
      
                              --Slowly restore to center.
                              if lerpCurrentAngle < -0.02 then    
                                  lerpCurrentAngle = lerpCurrentAngle + speed
                              elseif lerpCurrentAngle > 0.02 then
                                  lerpCurrentAngle = lerpCurrentAngle - speed
                              else
                                  lerpCurrentAngle = 0.0
                              end
                          end
  
                          -- Clamp the values between -15 and 15.
                          if lerpCurrentAngle > 30.0 then
                              lerpCurrentAngle = 30.0
                          elseif lerpCurrentAngle < -30.0 then
                              lerpCurrentAngle = -30.0
                          end
  
                          if Vehicle.IsInFront then
                              SetVehicleForwardSpeed(Vehicle.Vehicle, -1.0)
                          else
                              SetVehicleForwardSpeed(Vehicle.Vehicle, 1.0)
                          end
  
                          if HasEntityCollidedWithAnything(Vehicle.Vehicle) then
                              SetVehicleOnGroundProperly(Vehicle.Vehicle)
                          end
  
                          if not IsDisabledControlPressed(0, Keys["E"]) then
                              DetachEntity(ped, false, false)
                              StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
                              FreezeEntityPosition(ped, false)
                              break
                          end
                      end
                  end
              end
          end
      end
  end)
  
  Citizen.CreateThread(function()
      while true do
      Citizen.Wait(0)
      local ped = PlayerPedId()
      local veh = GetVehiclePedIsIn(ped)
          if IsEntityUpsidedown(veh) then
              DisableControlAction(0, 59) -- leaning left/right
              DisableControlAction(0, 60) -- leaning up/down
          end               
      end
  end)