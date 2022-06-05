
RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

seeded = false


Citizen.CreateThread(function()
    while not seeded do
        math.randomseed(os.time())
        print("Unique Plates Seeded - " .. os.time())
        seeded = true
    end
end)

RegisterCommand("newplate", function(source, args, raw)
    local src = source
    local plate = UniquePlateCheck()
    TriggerClientEvent('tp-printplate', src, plate)
end, false)


RLCore.Functions.CreateCallback('tp-generateplate', function(source, cb)
    local newPlate = UniquePlateCheck()
    print(newPlate)
	cb(newPlate)
end) 

function GenerateUniquePlate()
    local upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local numbers = "0123456789"
    local characterSet = numbers .. upperCase
    local keyLength = 8
    local output = ""
    for    i = 1, keyLength do
        if i == 4 then -- coded by RooRoo <3
          output = output .. " "
        else
          local rand = math.random(#characterSet)
          output = output .. string.sub(characterSet, rand, rand)
        end
    end
    print(output)
    return output
end

function UniquePlateCheck()
    local plate = GenerateUniquePlate()
 
    local result = RLCore.Functions.ExecuteSql(false,"SELECT * FROM bbvehicles WHERE plate = @plate", {['@plate'] = plate})
    if result[1] then    -- Bad condition (Duplicate)
        print("Failure - Duplicate Plate!")
        Citizen.Wait(50)
        UniquePlateCheck()
    else
        print("Success - No duplicate plate found")
        return plate  -- Good Condition (No duplicate)
	end
end