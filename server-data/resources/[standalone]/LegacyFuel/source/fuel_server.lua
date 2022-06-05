RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

function round(value, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", value))
end

RegisterServerEvent('fuel:pay')
AddEventHandler('fuel:pay', function(price)
	local src = source
	local pData = RLCore.Functions.GetPlayer(src)
	local amount = round(price)

	if pData.Functions.RemoveMoney('cash', amount, "bought-fuel") then
		TriggerClientEvent("RLCore:Notify", src, "Your Vehicle has been refilled", "success")
	end
end)

