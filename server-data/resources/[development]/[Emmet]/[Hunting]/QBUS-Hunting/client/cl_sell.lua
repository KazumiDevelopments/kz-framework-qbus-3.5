local carcasses = {
    { name = "huntingcarcass1", price = 100, illegal = false },
    { name = "huntingcarcass2", price = 175, illegal = false },
    { name = "huntingcarcass3", price = 225, illegal = false },
    { name = "huntingcarcass4", price = 300, illegal = false },
}


local function sellAnimals()
TriggerServerEvent("Dox-hunting:server:sell")
end

local listening = false
local function listenForKeypress()
    listening = true
    Citizen.CreateThread(function()
        while listening do
            if IsControlJustReleased(0, 38) then
                listening = false
                exports["aw3-ui"]:hideInteraction()
                sellAnimals()
            end
            Wait(0)
        end
    end)
end

local huntingsales = false
AddEventHandler("polyzonehelper:enter", function(name)
    if name ~= "huntingsales" then return end
    exports["aw3-ui"]:showInteraction("[E] Sell Animal Carcass")
    listenForKeypress()
end)

AddEventHandler("polyzonehelper:exit", function(name)
    if name ~= "huntingsales" then return end
    exports["aw3-ui"]:hideInteraction()
    listening = false
end)

function isNight()
	local hour = GetClockHours()
	if hour > 21 or hour < 3 then
	  return true
	end
  end