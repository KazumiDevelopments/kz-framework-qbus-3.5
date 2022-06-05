local RainingID, PooingID, PeeingID, SpellID = nil, nil, nil, nil

local Throttles = {}

function Throttled(name, time)
    if not Throttles[name] then
        Throttles[name] = true
        Citizen.SetTimeout(time or 500, function() Throttles[name] = false end)
        return false
    end

    return true
end

function GetRandomString(lenght)
    local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local randomString, stringLenght = '', lenght or 10
    local charTable = {}

    for char in chars:gmatch"." do
        table.insert(charTable, char)
    end

    for i = 1, stringLenght do
        randomString = randomString .. charTable[math.random(1, #charTable)]
    end
    return randomString
end

function MakeItRain()
    if Throttled("fx:money", 1000) then return end
    TriggerEvent("animation:PlayAnimation","makeitrain")
    RainingID = GetRandomString(12)
    TriggerServerEvent("fx:money:start", RainingID)
end

function MakeItStop()
    if RainingID == nil then return end
    TriggerEvent("animation:PlayAnimation","cancel")
    TriggerServerEvent("fx:money:stop", RainingID)
    RainingID = nil
end

local peePooWhitelist = {
  ["STEAM_0:1:720857"] = true, -- Dw
  ["STEAM_0:1:17549569"] = true, -- Koil
}
local mySteamId = nil

Citizen.CreateThread(function()
  Wait(10000)
  TriggerServerEvent("np-fx:setSteamId")
end)

RegisterNetEvent("np-fix:setSteamIdClient")
AddEventHandler("np-fix:setSteamIdClient", function(id)
  mySteamId = id
end)

function IsPeePooWhitelist()
  return peePooWhitelist[mySteamId] == true
end

function MakeItPoo()
  if not IsPeePooWhitelist() then return end
  if Throttled("fx:money", 1000) then return end
  TriggerEvent("animation:PlayAnimation","shit")
  PooingID = GetRandomString(12)
  TriggerServerEvent("fx:poo:start", PooingID)
end

function MakeItStopPoo()
  if not IsPeePooWhitelist() then return end
  if PooingID == nil then return end
  TriggerEvent("animation:PlayAnimation","cancel")
  TriggerServerEvent("fx:poo:stop", PooingID)
  PooingID = nil
end

function MakeItPee()
  if not IsPeePooWhitelist() then return end
  if Throttled("fx:money", 1000) then return end
  TriggerEvent("animation:PlayAnimation","pee")
  PeeingID = GetRandomString(12)
  TriggerServerEvent("fx:pee:start", PeeingID)
end

function MakeItStopPee()
  if not IsPeePooWhitelist() then return end
  if PeeingID == nil then return end
  TriggerEvent("animation:PlayAnimation","cancel")
  TriggerServerEvent("fx:pee:stop", PeeingID)
  PeeingID = nil
end

RegisterCommand("+makeItPoo", MakeItPoo, false)
RegisterCommand("-makeItPoo", MakeItStopPoo, false)

RegisterCommand("+makeItPee", MakeItPee, false)
RegisterCommand("-makeItPee", MakeItStopPee, false)

--exports["np-keybinds"]:registerKeyMapping(""","Misc", "Make it Rain", "+makeItRain", "-makeItRain")
RegisterCommand("+makeItRain", MakeItRain, false)
RegisterCommand("-makeItRain", MakeItStop, false)

