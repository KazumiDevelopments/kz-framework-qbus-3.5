Keys = {
	['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
	['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
	['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
	['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
	['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
	['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
	['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
	['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

RLCore = nil
isLoggedIn = false

Citizen.CreateThread(function()
	while RLCore == nil do
		TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
		Citizen.Wait(0)
	end
end)

local sellItemsSet = false
local sellPrice = 0
local sellHardwareItemsSet = false
local sellHardwarePrice = 0

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z)
	SetBlipSprite(blip, 108)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.7)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Pawnshop")
	EndTextCommandSetBlipName(blip)

	while true do 
		Citizen.Wait(1)
		local inRange = false
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z, true) < 5.0 then
			inRange = true
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z, true) < 1.5 then
				if not sellItemsSet then 
					sellPrice = GetSellingPrice()
					sellItemsSet = true
				elseif sellItemsSet and sellPrice ~= 0 then
					DrawText3D(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z, "[E] Pawn items ($"..sellPrice..")")
					if IsControlJustReleased(0, Keys["E"]) then
						TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
						RLCore.Functions.Progressbar("sell_pawn_items", "Selling ​​Items ..", math.random(10000, 20000), false, true, {}, {}, {}, {}, function() -- Done
							ClearPedTasks(GetPlayerPed(-1))
							TriggerServerEvent("rl-pawnshop:server:sellPawnItems")
							TriggerEvent("debug", 'Pawn Shop: Sell ​​Stuff', 'success')
							sellItemsSet = false
							sellPrice = 0
						end, function() -- Cancel
							ClearPedTasks(GetPlayerPed(-1))
							RLCore.Functions.Notify("Canceled..", "error")
						end)
					end
				else
					DrawText3D(Config.PawnLocation.x, Config.PawnLocation.y, Config.PawnLocation.z, "Pawnshop: You have nothing to sell ..")
				end
			end
		end
		if not inRange then
			sellPrice = 0
			sellItemsSet = false
			Citizen.Wait(2500)
		end
	end
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.PawnHardwareLocation.x, Config.PawnHardwareLocation.y, Config.PawnHardwareLocation.z)
	SetBlipSprite(blip, 478)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.7)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 7)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Hardware Pawnshop")
	EndTextCommandSetBlipName(blip)

	while true do 
		Citizen.Wait(1)
		local inRange = false
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.PawnHardwareLocation.x, Config.PawnHardwareLocation.y, Config.PawnHardwareLocation.z, true) < 5.0 then
			inRange = true
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.PawnHardwareLocation.x, Config.PawnHardwareLocation.y, Config.PawnHardwareLocation.z, true) < 1.5 then
				if not sellHardwareItemsSet then 
					sellHardwarePrice = GetSellingHardwarePrice()
					sellHardwareItemsSet = true
				elseif sellHardwareItemsSet and sellHardwarePrice ~= 0 then
					DrawText3D(Config.PawnHardwareLocation.x, Config.PawnHardwareLocation.y, Config.PawnHardwareLocation.z, "[E] Sell Electronic Items ($"..sellHardwarePrice..")")
					if IsControlJustReleased(0, Keys["E"]) then
						TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
						RLCore.Functions.Progressbar("sell_pawn_items", "Selling ​​Items ..", math.random(10000, 20000), false, true, {}, {}, {}, {}, function() -- Done
							ClearPedTasks(GetPlayerPed(-1))
							TriggerServerEvent("rl-pawnshop:server:sellHardwarePawnItems")
							sellHardwareItemsSet = false
							sellHardwarePrice = 0
						end, function() -- Cancel
							ClearPedTasks(GetPlayerPed(-1))
							RLCore.Functions.Notify("Canceled..", "error")
						end)
					end
				else
					DrawText3D(Config.PawnHardwareLocation.x, Config.PawnHardwareLocation.y, Config.PawnHardwareLocation.z, "Pawnshop: You have nothing to sell..")
				end
			end
		end
		if not inRange then
			sellHardwarePrice = 0
			sellHardwareItemsSet = false
			Citizen.Wait(2500)
		end
	end
end)

function GetSellingPrice()
	local price = 0
	RLCore.Functions.TriggerCallback('rl-pawnshop:server:getSellPrice', function(result)
		price = result
	end)
	Citizen.Wait(500)
	return price
end

function GetSellingHardwarePrice()
	local price = 0
	RLCore.Functions.TriggerCallback('rl-pawnshop:server:getSellHardwarePrice', function(result)
		price = result
	end)
	Citizen.Wait(500)
	return price
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end