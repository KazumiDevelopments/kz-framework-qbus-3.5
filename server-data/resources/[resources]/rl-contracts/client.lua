local RLCore = nil
local guiEnabled = false
local hasOpened = false
local listedcontracts = {}
local viewnumberlisted = 0
local endloop = false
local acceptingcontract = false
local currentData = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10) -- 
        if RLCore == nil then
            TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

-- Open Gui and Focus NUI
function openGui()
  SetPlayerControl(PlayerId(), 0, 0)
  guiEnabled = true
  SetNuiFocus(true)
  Citizen.Trace("OPENING")
  SendNUIMessage({openSection = "openContracts"})

  local inveh = IsPedSittingInAnyVehicle(PlayerPedId())

  TriggerEvent("notepad")


  -- If this is the first time we've opened the phone, load all warrants
  if hasOpened == false then
    lstContacts = {}
    hasOpened = true
  end
end

function openGuiContract()
  SetPlayerControl(PlayerId(), 0, 0)
  guiEnabled = true
  SetNuiFocus(true,true)
  Citizen.Trace("OPENING")
  SendNUIMessage({openSection = "openContractStart"})

  local inveh = IsPedSittingInAnyVehicle(PlayerPedId())

  TriggerEvent("notepad")

end

-- Close Gui and disable NUI
function closeGui()
  ped = PlayerPedId();
  ClearPedTasks(ped);
  Citizen.Trace("CLOSING")
  endloop = true
  SetNuiFocus(false,false)
  SendNUIMessage({openSection = "close"})
  guiEnabled = false
  SetPlayerControl(PlayerId(), 1, 0)
end

RegisterNUICallback('giveID', function(data, cb)
  closeGui()
  TriggerServerEvent("contract:send",data.target, data.conamount, data.coninformation)
end)

RegisterNUICallback('previousID', function(data, cb)
  TriggerEvent("ContractsList",listedcontracts,viewnumberlisted - 1)
end)

RegisterNUICallback('nextID', function(data, cb)
  TriggerEvent("ContractsList",listedcontracts,viewnumberlisted + 1)
end)

RegisterNUICallback('accept', function(data, cb)
  if currentData and acceptingcontract then
    TriggerServerEvent("contract:accept",currentData.price,currentData.author,true)
    acceptingcontract = false
    closeGui()
  end
end)

RegisterNUICallback('deny', function(data, cb)
  if currentData and acceptingcontract then
    TriggerServerEvent("contract:accept",currentData.price,currentData.author,false)
    acceptingcontract = false
    closeGui()
  end
end)

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)

  if currentData and acceptingcontract then
    TriggerServerEvent("contract:accept",currentData.price,currentData.author,false)
    acceptingcontract = false
  end

  closeGui()
  cb('ok')
end)

function openDummyContract(price,strg,author)
  SetNuiFocus(false,false)
  Citizen.Trace("OPENING")
  SendNUIMessage({openSection = "openContractDummy", price = price, strg = strg, author = author})
end

function DrawText3Ds(text)
    local x,y,z=table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.5, 0.0))
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
    local factor = 60 / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent("contract:requestaccept")
AddEventHandler("contract:requestaccept", function(price,strg, author)
    if not acceptingcontract then
        acceptingcontract = true
        openDummyContract(price,strg, author)
        SetNuiFocus(true,true)

        currentData = { price = price,strg = strg,author = author }
    end
end)

RegisterNetEvent('contracts:close')
AddEventHandler('contracts:close', function()
  closeGui()
end)

RegisterNetEvent('startcontract')
AddEventHandler('startcontract', function(target)
  openGuiContract()      
end)

RegisterNetEvent('ContractsList')
AddEventHandler('ContractsList', function(contracts,viewnumber)
  if #contracts > 0 then

    viewnumberlisted = viewnumber
    
    closeGui()
    -- no idea why I have to do this, its annoying as fuck though.
    Citizen.Wait(10)
    openGui()
    guiEnabled = true
    listedcontracts = contracts
    
    if viewnumberlisted > #listedcontracts then
      viewnumberlisted = 1
    end

    if viewnumberlisted < 1 then
      viewnumberlisted = #listedcontracts
    end  

    Citizen.Trace("opened." .. viewnumberlisted)
    local contractID = "<h3>Contract Identification Number</h3> <br><h1>" .. listedcontracts[viewnumberlisted]["ContractID"] .. "</h1>"
    local contractAmount = "<h3>Contract Amount Payable</h3> <br><h1> $" .. listedcontracts[viewnumberlisted]["amount"] .. " USD</h1>"
    local contractInfo = "<h3>Signed Contract Agreement</h3> <br>" .. listedcontracts[viewnumberlisted]["Info"]
    SendNUIMessage({openSection = "contractUpdate", NUIcontractID = contractID, NUIcontractAmount = contractAmount, NUIcontractInfo = contractInfo})
  end
end)