--[[
    BarBaroNN's Sell Vehicles, Made by BarBaroNN#0006.
    All rights reserved.
]]--

RLCore = nil
local ActiveSells = {}
local VehicleObjects = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if RLCore == nil then
			TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
			Citizen.Wait(200)
		end
	end
end)

CreateThread(function()
	Wait(2500)
	RLCore.Functions.TriggerCallback('bb-sellveh:getlist', function(isOwner)
		ActiveSells = isOwner
	end)
end)

local HoldE = 600
Citizen.CreateThread(function()
	while true do
    	Citizen.Wait(0)

    	for k, v in pairs(ActiveSells) do
			if v ~= nil then
				if v[4] then
					local stock = v[4] > 0 and true or false
					local txt
					if stock then
						txt = "Model : " .. v[2] .. " | Stock : ~g~" .. tostring(v[4]) .. "\n~w~Price : " .. v[6] + v[3] .. "$"
					else
						txt = "Model : " .. v[2] .. " | Stock : ~r~Out of stock\n~w~Price : " .. v[6] + v[3] .. "$"
					end
					local vehicle = v[1]
			
					local vehiclePosition = vehicle
					local playerPed = PlayerPedId()
					local playerPosition = GetEntityCoords(playerPed)
				
					if #(vehiclePosition - playerPosition) < 5 then
						DrawText3Ds(vehiclePosition.x, vehiclePosition.y, vehiclePosition.z + 0.5 , txt)
					end
				end
    		end
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
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0225, 0.015+ factor, 0.04, 0, 0, 0, 68)
end

RegisterNetEvent('bb-sellveh:client:publicsale:updateList')
AddEventHandler('bb-sellveh:client:publicsale:updateList', function(data)
	ActiveSells[data[5]] = data
end)

RegisterNetEvent('bb-sellveh:client:publicsale:removeList')
AddEventHandler('bb-sellveh:client:publicsale:removeList', function(key, stock)
	ActiveSells[key][4] = stock
end)