RLCore = nil

TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RLCore.Functions.TriggerCallback("showroom:purchaseVehicle", function(source, cb, model, price, amount)
	local src = source;
	local xPlayer = RLCore.Functions.GetPlayer(src)
	local cash = xPlayer.getAccounts()
	local plate = GeneratePlate()
	if 999999 >= price  then
        xPlayer.removeMoney(price)
		PurchaseCar(src, model, plate)
		cb(true, model)
		return
	else
		if tonumber(cash[2].money) >= price  then
        	xPlayer.removeMoney(price)
			PurchaseCar(src, model)
			cb(true, model)
			return
    	end 
	end;
end)

function PurchaseCar(source, model, plate)
	local src = source;
	local xPlayer = RLCore.Functions.GetPlayer(src)
	local model = model
	local plate = plate
	exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, vehicle, mods, plate) VALUES (@owner, @vehicle, @mods, @plate)', {
		['@owner'] = xPlayer.identifier,
		['@vehicle'] = model,
		['@mods'] = '{}',
		['@plate'] = plate,
	})
end

function GeneratePlate()
    local plate = math.random(0, 99)..""..GetRandomLetter(3)..""..math.random(0, 999)
    local result = exports.ghmattimysql:scalarSync('SELECT plate FROM owned_vehicles WHERE plate=@plate', {['@plate'] = plate})
    if result then
        plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
    end
    return plate:upper()
end

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end