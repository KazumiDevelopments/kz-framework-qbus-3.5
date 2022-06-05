----------------------------------------------------------------------------------------------------------------------------
local CoreName = nil
local ESX = nil

if Config['General']["Core"] == "QBCORE" then
    if Config['CoreSettings']["QBCORE"]["Version"] == "new" then
        CoreName = Config['CoreSettings']["QBCORE"]["Export"]
    else
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(10)
                if CoreName == nil then
                    TriggerEvent(Config['CoreSettings']["QBCORE"]["Trigger"], function(obj) CoreName = obj end)
                    Citizen.Wait(200)
                end
            end
        end)
    end
elseif Config['General']["Core"] == "ESX" then
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent(Config['CoreSettings']["ESX"]["Trigger"], function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end)
end
----------------------------------------------------------------------------------------------------------------------------

local authorized = false
local gay = nil
local DisablerUsed = false
local DisablerTimes = 0
local NUIPAGE = nil
local started = false
local startedcontractid = 0
local checked = false
local vinstarted = false
local CanUseComputer = false
local CanScratchVehicle = false
local MainThreadStarted = false
local URL = Config['Utils']["Laptop"]["DefaultBackground"]


OnTheDropoffWay = false
CompletedTask = false
DropblipCreated = false
CallingCops = false
Contracts = {}





AddEventHandler("onClientResourceStart", function(resource)
  if (resource == GetCurrentResourceName()) then
    Citizen.Wait(500)
    return TriggerServerEvent("boosting:loadNUI")
  end
end)



local function getField(field , vehicle)
  return GetVehicleHandlingFloat(vehicle, 'CHandlingData', field)
end

function CreateVeh(model , coord, id)
    local ModelHash = tostring(model)
    if not IsModelInCdimage(ModelHash) then return end
    RequestModel(ModelHash)
    while not HasModelLoaded(ModelHash) do
        Citizen.Wait(10)
    end
    Vehicle = CreateVehicle(ModelHash, coord.x, coord.y , coord.z, 0.0, true, false)
    SetModelAsNoLongerNeeded(ModelHash) 
    SetVehicleEngineOn(Vehicle, false, false)
    SetVehicleDoorsLocked(Vehicle, 2)
    local isMotorCycle = IsThisModelABike(Vehicle)
    local fInitialDriveMaxFlatVel = getField("fInitialDriveMaxFlatVel" , Vehicle)
    local fInitialDriveForce = getField("fInitialDriveForce" , Vehicle)
    local fDriveBiasFront = getField("fDriveBiasFront" ,Vehicle )
    local fInitialDragCoeff = getField("fInitialDragCoeff" , Vehicle)
    local fTractionCurveMax = getField("fTractionCurveMax" , Vehicle)
    local fTractionCurveMin = getField("fTractionCurveMin" , Vehicle )
    local fSuspensionReboundDamp = getField("fSuspensionReboundDamp" , Vehicle )
    local fBrakeForce = getField("fBrakeForce" ,Vehicle )
    local force = fInitialDriveForce
    local handling = (fTractionCurveMax + fSuspensionReboundDamp) * fTractionCurveMin
    local braking = ((fTractionCurveMin / fInitialDragCoeff) * fBrakeForce) * 7
    local accel = (fInitialDriveMaxFlatVel * force) / 10
    local speed = ((fInitialDriveMaxFlatVel / fInitialDragCoeff) * (fTractionCurveMax + fTractionCurveMin)) / 40
    local perfRating = ((accel * 5) + speed + handling + braking) * 15
    local vehClass = "F"
    if isMotorCycle then
      vehClass = "M"
    elseif perfRating > 900 then
      vehClass = "X"
    elseif perfRating > 700 then
      vehClass = "S"
    elseif perfRating > 550 then
      vehClass = "A"
    elseif perfRating > 400 then
      vehClass = "B"
    elseif perfRating > 325 then
      vehClass = "C"
    else
      vehClass = "D"
    end

    return ({c = vehClass , v = GetVehicleNumberPlateText(Vehicle) , vehicleshit = Vehicle})
end


RegisterNetEvent('boosting:ReceiveContract')
AddEventHandler('boosting:ReceiveContract' , function(contract)
     table.insert(Contracts, contract)
end)



RegisterNetEvent('boosting:CreateContract')
AddEventHandler('boosting:CreateContract' , function(shit)
  local num = math.random(#Config.Vehicles)
  local dick = Config.Vehicles[num].vehicle
  local coord = Config.VehicleCoords[math.random(#Config.VehicleCoords)]
  local owner = Config.CitizenNames[math.random(#Config.CitizenNames)].name  
  local response = CreateVeh(dick , vector3(0.0,0.0,0.0))
  
  VehiclePrice = Config['Utils']["ClassPrices"][response.c]
  if(shit == nil) then
    shit = false
  else
    shit = true
  end
  if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.TriggerCallback('boosting:GetExpireTime', function(result)
      if result then
        local data = {
          vehicle = dick,
          price = Config.Vehicles[num].price,
          owner = owner,
          price = VehiclePrice,
          type = response.c,
          expires = '6 Hours',
          time = result,
          id = #Contracts+1,
          coords = coord,
          plate = 'ddd',
          started = false,
          vin = shit

      }
        local class = data.type
        if(HasItem('pixellaptop') == true) then
          if Config['General']["UseNotificationsInsteadOfEmails"] then
            CoreName.Functions.Notify("You have recieved a "..class.. " Boosting...", "success", 3500)   
          else
            RevievedOfferEmail(data.owner, data.type)
          end
        end
        table.insert(Contracts , data)
      end
    end)
  elseif Config['General']["Core"] == "ESX" then
    ESX.TriggerServerCallback('boosting:GetExpireTime', function(result)
      if result then
        local data = {
          vehicle = dick,
          price = Config.Vehicles[num].price,
          owner = owner,
          price = VehiclePrice,
          type = response.c,
          expires = '6 Hours',
          time = result,
          id = #Contracts+1,
          coords = coord,
          plate = 'ddd',
          started = false,
          vin = shit
  
      }
      local class = data.type
      if(HasItem('pixellaptop') == true) then
        if Config['General']["UseNotificationsInsteadOfEmails"] then
          ShowNotification("You have recieved a "..class.. " Boosting...", "success")
        else
          RevievedOfferEmail(data.owner, data.type)
        end
        table.insert(Contracts , data)
        end
      end
    end)
  elseif Config['General']["Core"] == "NPBASE" then
    local ExpireTime = RPC.execute("boosting:GetExpireTime")

    if ExpireTime then
      local data = {
        vehicle = dick,
        price = Config.Vehicles[num].price,
        owner = owner,
        price = VehiclePrice,
        type = response.c,
        expires = '6 Hours',
        time = result,
        id = #Contracts+1,
        coords = coord,
        plate = 'ddd',
        started = false,
        vin = shit
  
    }
    if(HasItem('pixellaptop') == true) then
      if Config['General']["UseNotificationsInsteadOfEmails"] then
        local class = data.type
        TriggerEvent("DoLongHudText","You have recieved a "..class.. " Boosting...")
      else
        RevievedOfferEmailNPBASE(data.owner, data.type)
      end
      table.insert(Contracts , data)
      end
    end
  end
  DeleteVehicle(response.vehicleshit)
end)



RegisterNetEvent("boosting:StartContract")
AddEventHandler("boosting:StartContract" , function(id , vin)
  for k,v in ipairs(Contracts) do
      if(tonumber(v.id) == tonumber(id)) then
          local extracoors = v.coords
          local shit = CreateVeh(v.vehicle , v.coords , k)
          SetEntityHeading(Vehicle, extracoors.h)
          CreateBlip(v.coords)
          Contracts[k].plate = shit.v
          if(vin == true) then
              vinstarted = true
          else
              started = true
          end
          startedcontractid = v.id
        if not Config['General']["UseNotificationsInsteadOfEmails"] then
          if Config['General']["Core"] == "QBCORE" then
              CreateListEmail()
          elseif Config['General']["Core"] == "ESX" then
              CreateListEmail()
          elseif Config['General']["Core"] == "NPBASE" then
              CreateListEmailNPBASE()
          end
        end
      end
  end
end)


RegisterNetEvent("boosting:DeleteContract")
AddEventHandler("boosting:DeleteContract" , function(id)
  for k,v in ipairs(Contracts) do
    if(tonumber(v.id) == tonumber(id)) then
      table.remove(Contracts, k)
      started = false
      DeleteCircle()
    end
  end
end)

RegisterNetEvent("boosting:DeleteAllContracts")
AddEventHandler("boosting:DeleteAllContracts" , function()
  for k,v in ipairs(Contracts) do
      table.remove(Contracts, k)
      started = false
      DeleteCircle()
  end
end)

RegisterNUICallback("transfercontract", function(data)
 if Config['General']["Core"] == "QBCORE" then
  CoreName.Functions.TriggerCallback('boosting:getusercontracts', function(usercontracts)
  count = 0
  for x, y in ipairs(usercontracts) do
  count = count + 1
  end
  for k,v in ipairs(Contracts) do
    if v.id == data.contract.id then
	  local newid = count + 1
      local contract = {
        vehicle = GetDisplayNameFromVehicleModel(v.vehicle),
        price = v.price,
        owner = v.owner,
        type = v.type,
        expires = '6 Hours',
        id = newid,
        started = v.started,
        vin = v.vin
      }
    TriggerServerEvent("boosting:transfercontract", contract, data.target)
	table.remove(Contracts, v.id)
    end
   end
  end, data.target)
 elseif Config['General']["Core"] == "ESX" then
  ESX.TriggerServerCallback('boosting:getusercontracts', function(usercontracts)
  count = 0
  for x, y in ipairs(usercontracts) do
  count = count + 1
  end
  for k,v in ipairs(Contracts) do
    if v.id == data.contract.id then
	  local newid = count + 1
      local contract = {
        vehicle = GetDisplayNameFromVehicleModel(v.vehicle),
        price = v.price,
        owner = v.owner,
        type = v.type,
        expires = '6 Hours',
        id = newid,
        started = v.started,
        vin = v.vin
      }
    TriggerServerEvent("boosting:transfercontract", contract, data.target)
	table.remove(Contracts, v.id)
    end
   end
  end, data.target)
 end
end)

RegisterNUICallback("joinBoostQueue", function()
  TriggerServerEvent("boosting:joinQueue")
end)

RegisterNUICallback('leaveBoostQueue', function()
  TriggerServerEvent('boosting:leaveQueue')
  --TriggerEvent('boosting:DeleteAllContracts')
end)

RegisterNUICallback('dick', function(data)
  if Config['General']["Core"] == "QBCORE" then
    if Config['General']["MinPolice"] == 0 then
      TriggerEvent("boosting:StartContract" , data.id)
      Contracts[data.id].started = true
      SetNuiFocus(false ,false)
    else
      CoreName.Functions.TriggerCallback('boosting:server:GetActivity', function(result)
	  if(tonumber(BNEBoosting['functions'].GetCurrentBNE().bne) >= tonumber(data.price)) then
        if result >= Config['General']["MinPolice"] then
          TriggerEvent("boosting:StartContract" , data.id)
          Contracts[data.id].started = true
          SetNuiFocus(false ,false)
        else
          TriggerEvent("DoLongHudText","Not enough police",2)
          SetNuiFocus(false ,false)
        end
    else
     ShowNotification("Not enough BNE",'error')
     SetNuiFocus(false ,false)
	end
    end)  
   end
  elseif Config['General']["Core"] == "ESX" then
    ESX.TriggerServerCallback('boosting:server:GetActivity', function(result)
	if(tonumber(BNEBoosting['functions'].GetCurrentBNE().bne) >= tonumber(data.price)) then
      if result >= Config['General']["MinPolice"] then
        BNEBoosting['functions'].RemoveBNE(tonumber(data.price))	  
        TriggerEvent("boosting:StartContract" , data.id)
        Contracts[data.id].started = true
        SetNuiFocus(false ,false)
      else
        ShowNotification("Not enough police",'error')
        SetNuiFocus(false ,false)
      end
	else
     ShowNotification("Not enough BNE",'error')
     SetNuiFocus(false ,false)
	end
   end)  
  elseif Config['General']["Core"] == "NPBASE" then
   if(tonumber(BNEBoosting['functions'].GetCurrentBNE().bne) >= tonumber(data.price)) then
    if exports[Config['CoreSettings']["NPBASE"]["HandlerScriptName"]]:isPed("countpolice") >= Config['General']["MinPolice"] then
      TriggerEvent("boosting:StartContract" , data.id)
      Contracts[data.id].started = true
      SetNuiFocus(false ,false)
    else
      TriggerEvent("DoLongHudText","Not enough police",2)
      SetNuiFocus(false ,false)
    end
    else
     ShowNotification("Not enough BNE",'error')
     SetNuiFocus(false ,false)
	end
  end
end)


RegisterNUICallback('decline', function(data)
  TriggerEvent("boosting:DeleteContract" , data.id)
  -- SetNuiFocus(false ,false)
end)

RegisterNUICallback('close', function(data)
  SetNuiFocus(false ,false)
end)

RegisterNUICallback('vin', function(data)
  SetNuiFocus(false ,false)
  if(tonumber(BNEBoosting['functions'].GetCurrentBNE().bne) >= tonumber(Config['Utils']["VIN"]["BNEPrice"])) then
    Contracts[data.id].started = true
    BNEBoosting['functions'].RemoveBNE(Config['Utils']["VIN"]["BNEPrice"])
    TriggerEvent("boosting:StartContract" , data.id , true)
  else
    if Config['General']["Core"] == "QBCORE" then
      CoreName.Functions.Notify(Config['Utils']["Notifications"]["NotEnoughBNE"], "error", 3500)    
    elseif Config['General']["Core"] == "ESX" then
        ShowNotification(Config['Utils']["Notifications"]["NotEnoughBNE"],'error')
    elseif Config['General']["Core"] == "NPBASE" then
        TriggerEvent("DoLongHudText",Config['Utils']["Notifications"]["NotEnoughBNE"],2)
    end
  end
end)



RegisterNUICallback('updateurl' , function(data)
  URL = data.url
  BNEBoosting['functions'].SetBackground(data.url)
end)


RegisterNetEvent("boosting:DisablerUsed")
AddEventHandler("boosting:DisablerUsed" , function()
  if OnTheDropoffWay then
    local Class = Contracts[startedcontractid].type 
    if (Config['Utils']["Contracts"]["DisableTrackingOnDCB"]) and (Class == "D" or Class == "C" or Class == "B") then
      if Config['General']["Core"] == "QBCORE" then
        CoreName.Functions.Notify(Config['Utils']["Notifications"]["NoTrackerOnThisVehicle"], "error", 3500)    
      elseif Config['General']["Core"] == "ESX" then
          ShowNotification(Config['Utils']["Notifications"]["NoTrackerOnThisVehicle"],'error')
      elseif Config['General']["Core"] == "NPBASE" then
          TriggerEvent("DoLongHudText",Config['Utils']["Notifications"]["NoTrackerOnThisVehicle"],2)
      end
    elseif(vinstarted == false) then
      if(DisablerTimes < 4) then
        DisablerUsed = true
        local minigame = exports['hackingminigame']:Open()   
        if(minigame == true and DisablerTimes < 4) then
          if(DisablerTimes == 3) then
            DisablerTimes = DisablerTimes + 1
            CallingCops = false
            TriggerServerEvent("boosting:removeblip")
            if Config['General']["Core"] == "QBCORE" then
              CoreName.Functions.Notify(Config['Utils']["Notifications"]["TrackerRemoved"], "success", 3500)    
            elseif Config['General']["Core"] == "ESX" then
                ShowNotification(Config['Utils']["Notifications"]["TrackerRemoved"],'success')
            elseif Config['General']["Core"] == "NPBASE" then
                TriggerEvent("DoLongHudText",Config['Utils']["Notifications"]["TrackerRemoved"])
            end
          elseif(DisablerTimes < 3) then
            Config['Utils']["Blips"]["BlipUpdateTime"] = 7000
            DisablerTimes = DisablerTimes + 1
            TriggerServerEvent("boosting:SetBlipTime")
            if Config['General']["Core"] == "QBCORE" then
              CoreName.Functions.Notify(Config['Utils']["Notifications"]["SuccessHack"], "success", 3500)    
            elseif Config['General']["Core"] == "ESX" then
                ShowNotification(Config['Utils']["Notifications"]["SuccessHack"],'success')
            elseif Config['General']["Core"] == "NPBASE" then
                TriggerEvent("DoLongHudText",Config['Utils']["Notifications"]["SuccessHack"])
            end
          end
       
         
        end
      end
    end
  else if vinstarted == true then
    if(DisablerTimes < 6) then
      DisablerUsed = true
      local minigame = exports['hackingminigame']:Open()   
      if(minigame == true) then
        Config['Utils']["Blips"]["BlipUpdateTime"] = Config['Utils']["Blips"]["BlipUpdateTime"] + 5000
        DisablerTimes = DisablerTimes + 1
        TriggerServerEvent("boosting:SetBlipTime")
        if Config['General']["Core"] == "QBCORE" then
          CoreName.Functions.Notify(Config['Utils']["Notifications"]["SuccessHack"], "success", 3500)    
        elseif Config['General']["Core"] == "ESX" then
            ShowNotification(Config['Utils']["Notifications"]["SuccessHack"],'success')
        elseif Config['General']["Core"] == "NPBASE" then
            TriggerEvent("DoLongHudText",Config['Utils']["Notifications"]["SuccessHack"])
        end
      end
    else
      if(DisablerTimes == 6) then
        CallingCops = false
        TriggerServerEvent("boosting:removeblip")
        CanUseComputer = true
        if Config['General']["Core"] == "QBCORE" then
          CoreName.Functions.Notify(Config['Utils']["Notifications"]["TrackerRemovedVINMission"]["VINMission"], "success", 3500)    
        elseif Config['General']["Core"] == "ESX" then
            ShowNotification(Config['Utils']["Notifications"]["TrackerRemovedVINMission"]["VINMission"],'success')
        elseif Config['General']["Core"] == "NPBASE" then
            TriggerEvent("DoLongHudText",Config['Utils']["Notifications"]["TrackerRemovedVINMission"]["VINMission"])
        end
        if not MainThreadStarted then
          MainThread()
        end
      end
    end
  else
   if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.Notify(Config['Utils']["Notifications"]["NoMissionDetected"], "error", 3500)    
    elseif Config['General']["Core"] == "ESX" then
        ShowNotification(Config['Utils']["Notifications"]["NoMissionDetected"],'error')
    elseif Config['General']["Core"] == "NPBASE" then
        TriggerEvent("DoLongHudText",Config['Utils']["Notifications"]["NoMissionDetected"],2)
    end
  end
end
end)

local NuiLoaded = false

RegisterNetEvent("boosting:DisplayUI")
AddEventHandler("boosting:DisplayUI" , function()

  if NuiLoaded then      
    for k,v in ipairs(Contracts) do
      local data = {
        vehicle = GetDisplayNameFromVehicleModel(v.vehicle),
        price = v.price,
        owner = v.owner,
        type = v.type,
        expires = '6 Hours',
        id = v.id,
        started = v.started,
        vin = v.vin
      }
      SendNUIMessage({add = 'true' , data = data })
    end
    if( BNEBoosting['functions'].GetCurrentBNE().back ~= nil ) then
      URL =  BNEBoosting['functions'].GetCurrentBNE().back
    end
    SetNuiFocus(true ,true)
	Timehours = tostring(GetClockHours())
	Timeminutes = tostring(GetClockMinutes())
	if (#Timehours == 1) then
	realtimehours = '0'..GetClockHours()
	else
	realtimehours = GetClockHours()
	end
	if (#Timeminutes == 1) then
	realtimeminutes = '0'..GetClockMinutes()
	else
	realtimeminutes = GetClockMinutes()
	end
    timetosend = realtimehours..":"..realtimeminutes
    SendNUIMessage({show = 'true' , logo = Config['Utils']["Laptop"]["LogoUrl"] , background = URL, time = timetosend, BNE = BNEBoosting['functions'].GetCurrentBNE().bne , defaultback = Config['Utils']["Laptop"]["DefaultBackground"]})
  else
    if Config['General']["Core"] == "QBCORE" then
      CoreName.Functions.Notify(Config['Utils']["Notifications"]["UiStillLoadingMsg"], "error", 3500)    
    elseif Config['General']["Core"] == "ESX" then
        ShowNotification(Config['Utils']["Notifications"]["UiStillLoadingMsg"],'error')
    elseif Config['General']["Core"] == "NPBASE" then
        TriggerEvent("DoLongHudText",Config['Utils']["Notifications"]["UiStillLoadingMsg"],2)
    end
    Citizen.Wait(3000)
    NuiLoaded = true
  end
end)



local colorNames = {
  ['0'] = "Metallic Black",
  ['1'] = "Metallic Graphite Black",
  ['2'] = "Metallic Black Steal",
  ['3'] = "Metallic Dark Silver",
  ['4'] = "Metallic Silver",
  ['5'] = "Metallic Blue Silver",
  ['6'] = "Metallic Steel Gray",
  ['7'] = "Metallic Shadow Silver",
  ['8'] = "Metallic Stone Silver",
  ['9'] = "Metallic Midnight Silver",
  ['10'] = "Metallic Gun Metal",
  ['11'] = "Metallic Anthracite Grey",
  ['12'] = "Matte Black",
  ['13'] = "Matte Gray",
  ['14'] = "Matte Light Grey",
  ['15'] = "Util Black",
  ['16'] = "Util Black Poly",
  ['17'] = "Util Dark silver",
  ['18'] = "Util Silver",
  ['19'] = "Util Gun Metal",
  ['20'] = "Util Shadow Silver",
  ['21'] = "Worn Black",
  ['22'] = "Worn Graphite",
  ['23'] = "Worn Silver Grey",
  ['24'] = "Worn Silver",
  ['25'] = "Worn Blue Silver",
  ['26'] = "Worn Shadow Silver",
  ['27'] = "Metallic Red",
  ['28'] = "Metallic Torino Red",
  ['29'] = "Metallic Formula Red",
  ['30'] = "Metallic Blaze Red",
  ['31'] = "Metallic Graceful Red",
  ['32'] = "Metallic Garnet Red",
  ['33'] = "Metallic Desert Red",
  ['34'] = "Metallic Cabernet Red",
  ['35'] = "Metallic Candy Red",
  ['36'] = "Metallic Sunrise Orange",
  ['37'] = "Metallic Classic Gold",
  ['38'] = "Metallic Orange",
  ['39'] = "Matte Red",
  ['40'] = "Matte Dark Red",
  ['41'] = "Matte Orange",
  ['42'] = "Matte Yellow",
  ['43'] = "Util Red",
  ['44'] = "Util Bright Red",
  ['45'] = "Util Garnet Red",
  ['46'] = "Worn Red",
  ['47'] = "Worn Golden Red",
  ['48'] = "Worn Dark Red",
  ['49'] = "Metallic Dark Green",
  ['50'] = "Metallic Racing Green",
  ['51'] = "Metallic Sea Green",
  ['52'] = "Metallic Olive Green",
  ['53'] = "Metallic Green",
  ['54'] = "Metallic Gasoline Blue Green",
  ['55'] = "Matte Lime Green",
  ['56'] = "Util Dark Green",
  ['57'] = "Util Green",
  ['58'] = "Worn Dark Green",
  ['59'] = "Worn Green",
  ['60'] = "Worn Sea Wash",
  ['61'] = "Metallic Midnight Blue",
  ['62'] = "Metallic Dark Blue",
  ['63'] = "Metallic Saxony Blue",
  ['64'] = "Metallic Blue",
  ['65'] = "Metallic Mariner Blue",
  ['66'] = "Metallic Harbor Blue",
  ['67'] = "Metallic Diamond Blue",
  ['68'] = "Metallic Surf Blue",
  ['69'] = "Metallic Nautical Blue",
  ['70'] = "Metallic Bright Blue",
  ['71'] = "Metallic Purple Blue",
  ['72'] = "Metallic Spinnaker Blue",
  ['73'] = "Metallic Ultra Blue",
  ['74'] = "Metallic Bright Blue",
  ['75'] = "Util Dark Blue",
  ['76'] = "Util Midnight Blue",
  ['77'] = "Util Blue",
  ['78'] = "Util Sea Foam Blue",
  ['79'] = "Uil Lightning blue",
  ['80'] = "Util Maui Blue Poly",
  ['81'] = "Util Bright Blue",
  ['82'] = "Matte Dark Blue",
  ['83'] = "Matte Blue",
  ['84'] = "Matte Midnight Blue",
  ['85'] = "Worn Dark blue",
  ['86'] = "Worn Blue",
  ['87'] = "Worn Light blue",
  ['88'] = "Metallic Taxi Yellow",
  ['89'] = "Metallic Race Yellow",
  ['90'] = "Metallic Bronze",
  ['91'] = "Metallic Yellow Bird",
  ['92'] = "Metallic Lime",
  ['93'] = "Metallic Champagne",
  ['94'] = "Metallic Pueblo Beige",
  ['95'] = "Metallic Dark Ivory",
  ['96'] = "Metallic Choco Brown",
  ['97'] = "Metallic Golden Brown",
  ['98'] = "Metallic Light Brown",
  ['99'] = "Metallic Straw Beige",
  ['100'] = "Metallic Moss Brown",
  ['101'] = "Metallic Biston Brown",
  ['102'] = "Metallic Beechwood",
  ['103'] = "Metallic Dark Beechwood",
  ['104'] = "Metallic Choco Orange",
  ['105'] = "Metallic Beach Sand",
  ['106'] = "Metallic Sun Bleeched Sand",
  ['107'] = "Metallic Cream",
  ['108'] = "Util Brown",
  ['109'] = "Util Medium Brown",
  ['110'] = "Util Light Brown",
  ['111'] = "Metallic White",
  ['112'] = "Metallic Frost White",
  ['113'] = "Worn Honey Beige",
  ['114'] = "Worn Brown",
  ['115'] = "Worn Dark Brown",
  ['116'] = "Worn straw beige",
  ['117'] = "Brushed Steel",
  ['118'] = "Brushed Black steel",
  ['119'] = "Brushed Aluminium",
  ['120'] = "Chrome",
  ['121'] = "Worn Off White",
  ['122'] = "Util Off White",
  ['123'] = "Worn Orange",
  ['124'] = "Worn Light Orange",
  ['125'] = "Metallic Securicor Green",
  ['126'] = "Worn Taxi Yellow",
  ['127'] = "police car blue",
  ['128'] = "Matte Green",
  ['129'] = "Matte Brown",
  ['130'] = "Worn Orange",
  ['131'] = "Matte White",
  ['132'] = "Worn White",
  ['133'] = "Worn Olive Army Green",
  ['134'] = "Pure White",
  ['135'] = "Hot Pink",
  ['136'] = "Salmon pink",
  ['137'] = "Metallic Vermillion Pink",
  ['138'] = "Orange",
  ['139'] = "Green",
  ['140'] = "Blue",
  ['141'] = "Mettalic Black Blue",
  ['142'] = "Metallic Black Purple",
  ['143'] = "Metallic Black Red",
  ['144'] = "hunter green",
  ['145'] = "Metallic Purple",
  ['146'] = "Metaillic V Dark Blue",
  ['147'] = "MODSHOP BLACK1",
  ['148'] = "Matte Purple",
  ['149'] = "Matte Dark Purple",
  ['150'] = "Metallic Lava Red",
  ['151'] = "Matte Forest Green",
  ['152'] = "Matte Olive Drab",
  ['153'] = "Matte Desert Brown",
  ['154'] = "Matte Desert Tan",
  ['155'] = "Matte Foilage Green",
  ['156'] = "DEFAULT ALLOY COLOR",
  ['157'] = "Epsilon Blue",
}

function getStreetandZone(coords)
	local zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
	local currentStreetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
	currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
	playerStreetsLocation = currentStreetName .. ", " .. zone
	return playerStreetsLocation
end


NotifySent = false

Citizen.CreateThread(function()
  while true do
    Wait(0)
    while started == true do
      Wait(1000)
      local veh = GetVehiclePedIsIn(GetPlayerPed(PlayerId()) , false)
      if(veh ~= 0) then
        local PlayerPed = PlayerPedId()
        if(GetVehicleNumberPlateText(veh) == Contracts[startedcontractid].plate) then
          local PedVehicle = GetVehiclePedIsIn(PlayerPed)
          local Driver = GetPedInVehicleSeat(PedVehicle, -1)
          if Driver == PlayerPed then
            if not(DropblipCreated) then
              OnTheDropoffWay = true
              DropblipCreated = true
              local Class = Contracts[startedcontractid].type 
              if (Config['Utils']["Contracts"]["DisableTrackingOnDCB"]) and (Class == "D" or Class == "C" or Class == "B") then
                CallingCops = false
              else
               --TriggerEvent("boosting:SendNotify" , {plate = Contracts[startedcontractid].plate})
                local primary, secondary = GetVehicleColours(veh)
                primary = colorNames[tostring(primary)]
                secondary = colorNames[tostring(secondary)]
                local hash = GetEntityModel(Vehicle)
                local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                if not NotifySent then
                  TriggerServerEvent("boosting:CallCopsNotify" , Contracts[startedcontractid].plate , modelName, primary..', '..secondary , getStreetandZone(GetEntityCoords(PlayerPed)))
                  CallingCops = true
                  NotifySent = true
                end
              end
              CreateDropPoint()
              DeleteCircle()
            end
          end
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    while vinstarted == true do
      Wait(1000)
      local veh = GetVehiclePedIsIn(GetPlayerPed(PlayerId()) , false)
      if(veh ~= 0) then
        local PlayerPed = PlayerPedId()
        if(GetVehicleNumberPlateText(veh) == Contracts[startedcontractid].plate) then
          local PedVehicle = GetVehiclePedIsIn(PlayerPed)
          local Driver = GetPedInVehicleSeat(PedVehicle, -1)
          if Driver == PlayerPed then
            local Class = Contracts[startedcontractid].type 
            if (Config['Utils']["Contracts"]["DisableTrackingOnDCB"]) and (Class == "D" or Class == "C" or Class == "B") then
              CallingCops = false
            else
              local primary, secondary = GetVehicleColours(veh)
                primary = colorNames[tostring(primary)]
                secondary = colorNames[tostring(secondary)]
                local hash = GetEntityModel(Vehicle)
                local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                if not NotifySent then
                  TriggerServerEvent("boosting:CallCopsNotify" , Contracts[startedcontractid].plate , modelName, primary..', '..secondary , getStreetandZone(GetEntityCoords(PlayerPed)))
                  CallingCops = true
                  NotifySent = true
                end
            end
            DeleteCircle()
          end
        end
      end
    end
  end
end)



-- Citizen.CreateThread(function()
  -- while true do
    -- Citizen.Wait(Config['Utils']["Contracts"]["TimeBetweenContracts"])
    -- local shit = math.random(1,10)
    -- local DVTen = Config['Utils']["Contracts"]["ContractChance"] / 10
    -- if(shit <= DVTen) then
      -- if Config['Utils']["VIN"]["ForceVin"] then
        -- TriggerEvent('boosting:CreateContract', true)
      -- else
        -- TriggerEvent("boosting:CreateContract")
      -- end
    -- end
  -- end
-- end)




Citizen.CreateThread(function()
  while true do
    if OnTheDropoffWay then
      Citizen.Wait(1000)
      local coordA = GetEntityCoords(PlayerPedId())
      local veh = GetVehiclePedIsIn(GetPlayerPed(PlayerId()) , false)
      if(veh ~= 0) then
        local PlayerPed = PlayerPedId()
        if(GetVehicleNumberPlateText(veh) == Contracts[startedcontractid].plate) then
          local PedVehicle = GetVehiclePedIsIn(PlayerPed)
          local aDist = GetDistanceBetweenCoords(Config.BoostingDropOff[rnd]["x"],Config.BoostingDropOff[rnd]["y"],Config.BoostingDropOff[rnd]["z"], coordA["x"],coordA["y"],coordA["z"])
          if aDist < 10.0 then
            CallingCops = false
            CompletedTask = true
            Citizen.Wait(300)
            DeleteBlip()
            if OnTheDropoffWay then
              TriggerEvent('boosting:ContractDone')
            end
            OnTheDropoffWay = false
            DisablerTimes = 0
          end
        end
      end
    else
      Wait(5000)
    end
  end
end)

AddEventHandler('onResourceStart', function(resource)
  if resource == GetCurrentResourceName() then
      Wait(100)
     TriggerServerEvent('SHIT:SHIT')
  end
end)

RegisterNetEvent("boosting:ContractDone")
AddEventHandler("boosting:ContractDone" , function()
  if CompletedTask then
    if Config['General']["Core"] == "QBCORE" then
      CoreName.Functions.Notify(Config['Utils']["Notifications"]["DropOffMsg"], "success", 3500)    
    elseif Config['General']["Core"] == "ESX" then
        ShowNotification(Config['Utils']["Notifications"]["DropOffMsg"],'success')
    elseif Config['General']["Core"] == "NPBASE" then
        TriggerEvent("DoLongHudText",Config['Utils']["Notifications"]["DropOffMsg"])
    end
    TriggerServerEvent("boosting:removeblip")
    Citizen.Wait(math.random(25000,35000))
    TriggerServerEvent('boosting:finished')
	local niceprice = VehiclePrice * Config['General']["BNErewardmultiplier"]
    BNEBoosting['functions'].AddBne(niceprice)
    print(nice)
    table.remove(Contracts , startedcontractid)
    started = false
    SetEntityAsMissionEntity(Vehicle,true,true)
    DeleteEntity(Vehicle)
    CompletedTask = false
    DropblipCreated = false
    CallingCops = false
    NotifySent= false
  end
end)


--- HAS ITEM CHECK

function HasItem(item)
  local hasitem = false
  if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.TriggerCallback(Config['CoreSettings']['QBCORE']["HasItem"], function(result)
        hasitem = result
    end, item)
    Citizen.Wait(500)
    return hasitem
  elseif Config['General']["Core"] == "ESX" then
    ESX.TriggerServerCallback('boosting:canPickUp', function(result)
      hasitem = result
    end , item)
    Citizen.Wait(500)
    return hasitem
  elseif Config['General']["Core"] == "NPBASE" then
    hasitem = exports[Config['CoreSettings']['NPBASE']["HasItem"]]:hasEnoughOfItem(item, 1, false, true)
    Citizen.Wait(500)
    return hasitem
  end
end

---------------- Cop Blip Thingy ------------------

local copblip


Citizen.CreateThread(function()
  while true do
    if CallingCops then
      Citizen.Wait(Config['Utils']["Blips"]["BlipUpdateTime"])
      local coords = GetEntityCoords(PlayerPedId())
      if CallingCops then
        TriggerServerEvent('boosting:alertcops', coords.x, coords.y, coords.z)
      end
    else
      Wait(500)
    end
  end
end)


RegisterNetEvent('boosting:SendNotify')
AddEventHandler('boosting:SendNotify' , function(data)
  if Config['General']["PoliceNeedLaptopToseeNotifications"] then
    if(HasItem('pixellaptop') == true) then
      SendNUIMessage({addNotify = 'true' , plate = data.plate , model = data.model , color = data.color , place = data.place , length = Config['Utils']['Laptop']['CopNotifyLength']})
    end
  else
    SendNUIMessage({addNotify = 'true' , plate = data.plate , model = data.model , color = data.color , place = data.place , length = Config['Utils']['Laptop']['CopNotifyLength']})
  end
end)

RegisterNetEvent('boosting:removecopblip')
AddEventHandler('boosting:removecopblip', function()
  DeleteCopBlip()
end)

RegisterNetEvent('boosting:setcopblip')
AddEventHandler('boosting:setcopblip', function(cx,cy,cz)
  if Config['General']["PoliceNeedLaptopToseeNotifications"] then
    if(HasItem('pixellaptop') == true) then
      CreateCopBlip(cx,cy,cz)
    end
  else
    CreateCopBlip(cx,cy,cz)
  end
end)

RegisterNetEvent('boosting:setBlipTime')
AddEventHandler('boosting:setBlipTime', function()
  Config['Utils']["Blips"]["BlipUpdateTime"] = 7000
end)




RegisterNetEvent("boosting:StartUI")
AddEventHandler("boosting:StartUI"  , function()
  NuiLoaded = true
end)



--------- EMIAL ---------------
function CreateListEmail()
  TriggerServerEvent(Config['General']["EmailEvent"], {
    sender = Contracts[startedcontractid].owner,
    subject = "Boosting details",
    message = "Yo buddy , this is the vehicle details.<br /><br /><strong>Vehicle Model:  "..GetDisplayNameFromVehicleModel(Contracts[startedcontractid].vehicle).."<br />Vehicle Class :"..Contracts[startedcontractid].type.."<br />Vehicle Plate :"..Contracts[startedcontractid].plate.." </strong><br />",
    button = {}
  })
end

function CreateListEmailNPBASE()
  TriggerEvent(Config['General']["EmailEvent"], 'EMAIL', "Yo buddy , this is the vehicle details.<br /><br /><strong>Vehicle Model:  "..GetDisplayNameFromVehicleModel(Contracts[startedcontractid].vehicle).."<br />Vehicle Class :"..Contracts[startedcontractid].type.."<br />Vehicle Plate :"..Contracts[startedcontractid].plate.." </strong><br />")
end

function RevievedOfferEmailNPBASE(owner, class)
  TriggerEvent(Config['General']["EmailEvent"], 'EMAIL', "You have recieved a "..class.. " Boosting... <br />")
end


function RevievedOfferEmail(owner, class)
  TriggerServerEvent(Config['General']["EmailEvent"], {
    sender = owner,
    subject = "Contract Offer",
    message = "You have recieved a "..class.. " Boosting... <br />",
    button = {}
  })
end
-------------------------------


---------- COMMAND --------------
Citizen.CreateThread(function()
  if Config['Utils']["Commands"]["boosting_test"] ~= 'nil' then
    RegisterCommand(Config['Utils']["Commands"]["boosting_test"], function()
      if Config['Utils']["VIN"]["ForceVin"] then
        TriggerEvent('boosting:CreateContract', true)
      else
        TriggerEvent("boosting:CreateContract")
      end
    end)
  end

end)

Citizen.CreateThread(function()
  if Config['Utils']["Commands"]["force_close_nui"] ~= 'nil' then
    RegisterCommand(Config['Utils']["Commands"]["force_close_nui"], function()
      SetNuiFocus(false ,false)
    end)
  end
end)
-------------------------------



Citizen.CreateThread(function()
  if Config['Utils']["Commands"]["get_vehicle_class"] ~= 'nil' then
    RegisterCommand(Config['Utils']["Commands"]["get_vehicle_class"], function()
      local veh = GetVehiclePedIsIn(PlayerPedId())
      local fInitialDriveMaxFlatVel = getField("fInitialDriveMaxFlatVel" , veh)
      local fInitialDriveForce = getField("fInitialDriveForce" , veh)
      local fDriveBiasFront = getField("fDriveBiasFront" ,veh )
      local fInitialDragCoeff = getField("fInitialDragCoeff" , veh)
      local fTractionCurveMax = getField("fTractionCurveMax" , veh)
      local fTractionCurveMin = getField("fTractionCurveMin" , veh )
      local fSuspensionReboundDamp = getField("fSuspensionReboundDamp" , veh )
      local fBrakeForce = getField("fBrakeForce" ,veh )
      local force = fInitialDriveForce
      local handling = (fTractionCurveMax + fSuspensionReboundDamp) * fTractionCurveMin
      local braking = ((fTractionCurveMin / fInitialDragCoeff) * fBrakeForce) * 7
      local accel = (fInitialDriveMaxFlatVel * force) / 10
      local speed = ((fInitialDriveMaxFlatVel / fInitialDragCoeff) * (fTractionCurveMax + fTractionCurveMin)) / 40
      local perfRating = ((accel * 5) + speed + handling + braking) * 15
      local vehClass = "F"
      if isMotorCycle then
        vehClass = "M"
      elseif perfRating > 900 then
        vehClass = "X"
      elseif perfRating > 700 then
        vehClass = "S"
      elseif perfRating > 550 then
        vehClass = "A"
      elseif perfRating > 400 then
        vehClass = "B"
      elseif perfRating > 325 then
        vehClass = "C"
      else
        vehClass = "D"
      end
      print(vehClass)
    end)
  end
end)


---------------------- VIN SCRATCH ------------------------



local ScratchAnimDict = "mp_car_bomb"
local ScratchAnim = "car_bomb_mechanic"

local function AddVehicleToGarage()
  local EntityModel = GetEntityModel(Vehicle)
  local DiplayName = GetDisplayNameFromVehicleModel(EntityModel)
  if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.Notify("Vin scratch complete!", "success", 3500)   
    local vehicleProps = CoreName.Functions.GetVehicleProperties(Vehicle)	
    TriggerServerEvent('boosting:AddVehicle',string.lower(DiplayName) ,Contracts[startedcontractid].plate, vehicleProps)
  elseif Config['General']["Core"] == "ESX" then
      ShowNotification("Vin scratch complete!",'success')
      local vehicleProps = ESX.Game.GetVehicleProperties(Vehicle)
      TriggerServerEvent('boosting:AddVehicle',string.lower(DiplayName) ,Contracts[startedcontractid].plate,vehicleProps)
  elseif Config['General']["Core"] == "NPBASE" then
      TriggerEvent("DoLongHudText","Vin scratch complete!")
      TriggerServerEvent('boosting:AddVehicle',string.lower(DiplayName) ,Contracts[startedcontractid].plate)
  end
  vinstarted = false
  CanScratchVehicle = false
  table.remove(Contracts , startedcontractid)
  
end

RegisterNetEvent("boosting:client:UseComputer")
AddEventHandler("boosting:client:UseComputer" , function()
  if Config['General']["Core"] == "QBCORE" then
    if CanUseComputer then
      CoreName.Functions.Progressbar("boosting_scratch", "Connection to network...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
        }, {
          animDict = ScratchAnimDict,
          anim = ScratchAnim,
          flags = 16,
        }, {}, {}, function() -- Done
          TriggerEvent('boosting:client:2ndUseComputer')
        end, function() -- Cancel
          StopAnimTask(PlayerPedId(), ScratchAnimDict, "exit", 1.0)
          CoreName.Functions.Notify("Failed!", "error", 3500)
      end)
    else
      CoreName.Functions.Notify("Can't use this now!", "error", 3500)
    end
  elseif Config['General']["Core"] == "ESX" then
    if CanUseComputer then
      LoadDict(ScratchAnimDict)
      FreezeEntityPosition(PlayerPedId(),true)
      TaskPlayAnim(PlayerPedId(), ScratchAnimDict, ScratchAnim, 3.0, -8, -1, 63, 0, 0, 0, 0 )
      local finished = exports[Config['CoreSettings']["ESX"]["ProgressBarScriptName"]]:taskBar(5000, 'Connection to network...')
      if (finished == 100) then
        CanScratchVehicle = true
        ShowNotification(Config['Utils']["Notifications"]["FinishComputer"],'success')
        CanUseComputer = false
        FreezeEntityPosition(PlayerPedId(),false)
        ClearPedTasks(PlayerPedId())
      end
    else
      ShowNotification("Can't use this now",'error')
    end
  elseif Config['General']["Core"] == "NPBASE" then
    if CanUseComputer then
      LoadDict(ScratchAnimDict)
      FreezeEntityPosition(PlayerPedId(),true)
      TaskPlayAnim(PlayerPedId(), ScratchAnimDict, ScratchAnim, 3.0, -8, -1, 63, 0, 0, 0, 0 )
      local finished = exports[Config['CoreSettings']["NPBASE"]["ProgressBarScriptName"]]:taskBar(5000, 'Connection to network...')
      if (finished == 100) then
        TriggerEvent('boosting:client:2ndUseComputer')
      end
    else
      TriggerEvent("DoLongHudText","Can't use this now!",2)
    end
  end
end)

RegisterNetEvent("boosting:client:2ndUseComputer")
AddEventHandler("boosting:client:2ndUseComputer" , function()
  if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.Progressbar("boosting_scratch", "Wiping online paperwork...", 5000, false, true, {
      disableMovement = true,
      disableCarMovement = true,
      disableMouse = false,
      disableCombat = true,
      }, {
        animDict = ScratchAnimDict,
        anim = ScratchAnim,
        flags = 16,
      }, {}, {}, function() -- Done
        CanScratchVehicle = true
        CoreName.Functions.Notify(Config['Utils']["Notifications"]["FinishComputer"], "success" , 3500)
        CanUseComputer = false
      end, function() -- Cancel
        StopAnimTask(PlayerPedId(), ScratchAnimDict, "exit", 1.0)
        CoreName.Functions.Notify("Failed!", "error", 3500)
    end)
  elseif Config['General']["Core"] == "NPBASE" then
    LoadDict(ScratchAnimDict)
    FreezeEntityPosition(PlayerPedId(),true)
    TaskPlayAnim(PlayerPedId(), ScratchAnimDict, ScratchAnim, 3.0, -8, -1, 63, 0, 0, 0, 0 )
    local finished = exports[Config['CoreSettings']["NPBASE"]["ProgressBarScriptName"]]:taskBar(5000, 'Wiping online paperwork...')
    if (finished == 100) then
      CanScratchVehicle = true
      TriggerEvent("DoLongHudText",Config['Utils']["Notifications"]["FinishComputer"])
      CanUseComputer = false
      FreezeEntityPosition(PlayerPedId(),false)
      ClearPedTasks(PlayerPedId())
    end   
  end
end)

RegisterNetEvent("boosting:client:ScratchVehicle")
AddEventHandler("boosting:client:ScratchVehicle" , function()
  if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.Progressbar("boosting_scratch", "Scratching Vin", 10000, false, true, {
      disableMovement = true,
      disableCarMovement = true,
      disableMouse = false,
      disableCombat = true,
      }, {
        animDict = ScratchAnimDict,
        anim = ScratchAnim,
        flags = 16,
      }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), ScratchAnimDict, "exit", 1.0)
        AddVehicleToGarage()
        CoreName.Functions.Notify(Config['Utils']["Notifications"]["VehicleAdded"], "success", 3500)
        DeleteBlip()
        CallingCops = false
      end, function() -- Cancel
        StopAnimTask(PlayerPedId(), ScratchAnimDict, "exit", 1.0)
        CoreName.Functions.Notify("Failed!", "error", 3500)
    end)
  elseif Config['General']["Core"] == "ESX" then
    LoadDict(ScratchAnimDict)
    FreezeEntityPosition(PlayerPedId(),true)
    TaskPlayAnim(PlayerPedId(), ScratchAnimDict, ScratchAnim, 3.0, -8, -1, 63, 0, 0, 0, 0 )
    local finished = exports[Config['CoreSettings']["ESX"]["ProgressBarScriptName"]]:taskBar(10000, 'Scratching Vin')
    if (finished == 100) then
      AddVehicleToGarage()
      ShowNotification(Config['Utils']["Notifications"]["VehicleAdded"],'success')
      CallingCops = false
      DeleteBlip()
      FreezeEntityPosition(PlayerPedId(),false)
    end
  elseif Config['General']["Core"] == "NPBASE" then
    LoadDict(ScratchAnimDict)
    FreezeEntityPosition(PlayerPedId(),true)
    TaskPlayAnim(PlayerPedId(), ScratchAnimDict, ScratchAnim, 3.0, -8, -1, 63, 0, 0, 0, 0 )
    local finished = exports[Config['CoreSettings']["NPBASE"]["ProgressBarScriptName"]]:taskBar(10000, 'Scratching Vin')
    if (finished == 100) then
      AddVehicleToGarage()
      TriggerEvent("DoLongHudText",Config['Utils']["Notifications"]["VehicleAdded"])
      CallingCops = false
      DeleteBlip()
    end 
  end
  NotifySent = false
end)

Citizen.CreateThread(function()
  while true do
    if CanScratchVehicle then
      Citizen.Wait(1000)
      local playerped = PlayerPedId()
      local coordA = GetEntityCoords(playerped, 1)
      local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
      local targetVehicle = getVehicleInDirection(coordA, coordB)
      if targetVehicle ~= 0 then
        local d1,d2 = GetModelDimensions(GetEntityModel(targetVehicle))
        local moveto = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0,d2["y"]+0.5,0.2)
        local dist = #(vector3(moveto["x"],moveto["y"],moveto["z"]) - GetEntityCoords(PlayerPedId()))
        local count = 1000
        if(GetVehicleNumberPlateText(veh) == Contracts[startedcontractid].plate) then
          while dist > 2.5 and count > 0 do
            dist = #(vector3(moveto["x"],moveto["y"],moveto["z"]) - GetEntityCoords(PlayerPedId()))
            Citizen.Wait(1)
            count = count - 1
          end
        end
        if dist < 2.5 then
          TriggerEvent('boosting:client:ScratchVehicle')
          CanScratchVehicle = false
          break
        end
      end
    else
      Wait(5000)
    end
  end
end)

Keys = { ['E'] = 38 }

function MainThread()
  while true do 
    if CanUseComputer then
      Citizen.Wait(1)
      local pos = GetEntityCoords(PlayerPedId())
      if (#(pos - vector3(Config['Utils']["VIN"]["VinLocations"].x, Config['Utils']["VIN"]["VinLocations"].y, Config['Utils']["VIN"]["VinLocations"].z)) < 10.0) then
        DrawMarker(2, Config['Utils']["VIN"]["VinLocations"].x, Config['Utils']["VIN"]["VinLocations"].y, Config['Utils']["VIN"]["VinLocations"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
        MainThreadStarted = true
        if (#(pos - vector3(Config['Utils']["VIN"]["VinLocations"].x, Config['Utils']["VIN"]["VinLocations"].y, Config['Utils']["VIN"]["VinLocations"].z)) < 1.5) then
          if Config['General']["Core"] == "QBCORE" then
            CoreName.Functions.DrawText3D(Config['Utils']["VIN"]["VinLocations"].x, Config['Utils']["VIN"]["VinLocations"].y, Config['Utils']["VIN"]["VinLocations"].z, "~g~E~w~ - Use Computer")
          elseif Config['General']["Core"] == "ESX" then
            local coordsoftext = vector3(Config['Utils']["VIN"]["VinLocations"].x, Config['Utils']["VIN"]["VinLocations"].y, Config['Utils']["VIN"]["VinLocations"].z)
            ESX.Game.Utils.DrawText3D(coordsoftext, "~g~E~w~ - Use Computer")
          elseif Config['General']["Core"] == "NPBASE" then
            DrawText3D2(Config['Utils']["VIN"]["VinLocations"].x, Config['Utils']["VIN"]["VinLocations"].y, Config['Utils']["VIN"]["VinLocations"].z, "~g~E~w~ - Use Computer")
          end
          if IsControlJustReleased(0, Keys["E"]) then
            TriggerEvent('boosting:client:UseComputer')
            return
          end
        end 
      end
    else
      Wait(5000)
    end
  end
end

function getVehicleInDirection(coordFrom, coordTo)
  local offset = 0
  local rayHandle
  local vehicle

  for i = 0, 100 do
      rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)   
      a, b, c, d, vehicle = GetRaycastResult(rayHandle)
      
      offset = offset - 1

      if vehicle ~= 0 then break end
  end
  
  local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
  
  if distance > 25 then vehicle = nil end

  return vehicle ~= nil and vehicle or 0
end


RegisterNetEvent('boosting:client:synccontracts')
AddEventHandler('boosting:client:synccontracts', function()
   TriggerServerEvent('boosting:server:synccontracts', Contracts)
end)
