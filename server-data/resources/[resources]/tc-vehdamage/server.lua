--server event
RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local degHealth = {
    ["breaks"] = 0,-- has neg effect
    ["axle"] = 0,	-- has neg effect
    ["radiator"] = 0, -- has neg effect
    ["clutch"] = 0,	-- has neg effect
    ["transmission"] = 0, -- has neg effect
    ["electronics"] = 0, -- has neg effect
    ["fuel_injector"] = 0, -- has neg effect
    ["fuel_tank"] = 0 
}

RegisterNetEvent('veh.examine')
AddEventHandler('veh.examine', function(plate)
    local _src = source

    exports['ghmattimysql']:execute('SELECT * FROM bbvehicles WHERE plate = @plate', {
        ['@plate'] = plate
      }, function(result)


        print(result[1].engine_damage, result[1].body_damage)
        if result[1] ~= nil then
            print("1")
            TriggerClientEvent('towgarage:triggermenu',_src, result[1].degredation, result[1].engine_damage, result[1].body_damage)
        else
            print("2")
            TriggerClientEvent("DoLongHudTexts",_src, "This vehicle is not listed",2) 
        end
      end)
    
end)


RegisterNetEvent('scrap:towTake')
AddEventHandler('scrap:towTake', function(degname,itemname,amount,current,plate)
local _src = source
local matAmount = amount
        local amount = amount*10

        exports['ghmattimysql']:execute('SELECT * FROM bbvehicles WHERE plate = @plate', {
            ['@plate'] = plate
          }, function(result)

                local deg = result[1].degredation
                degMe = result[1].degredation
                local temp = deg:split(",")
                if(temp[1] ~= nil) then	

                    for i,v in ipairs(temp) do
                        if i == 1 then
                            degHealth.breaks = tonumber(v)
                            if degHealth.breaks == nil then
                                degHealth.breaks = 0
                            end
                        elseif i == 2 then
                            degHealth.axle = tonumber(v)
                        elseif i == 3 then
                            degHealth.radiator = tonumber(v)
                        elseif i == 4 then
                            degHealth.clutch = tonumber(v)
                        elseif i == 5 then
                            degHealth.transmission = tonumber(v)
                        elseif i == 6 then
                            degHealth.electronics = tonumber(v)
                        elseif i == 7 then
                            degHealth.fuel_injector = tonumber(v)
                        elseif i == 8 then	
                            degHealth.fuel_tank = tonumber(v)
                        end
                    end
                end
            local updateDB = ""  
            if degname == "breaks" then 
            degHealth["breaks"] = degHealth["breaks"] + amount
            if degHealth["breaks"] > 100 then
                degHealth["breaks"] = 100
            end
            updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
            elseif degname == "axle" then
                degHealth["axle"] = degHealth["axle"] + amount
                if degHealth["axle"] > 100 then
                    degHealth["axle"] = 100
                end
            updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
            elseif degname == "radiator" then
                degHealth["radiator"] = degHealth["radiator"] + amount
                if degHealth["radiator"] > 100 then
                    degHealth["radiator"] = 100
                end
            updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
            elseif degname == "clutch" then
                degHealth["clutch"] = degHealth["clutch"] + amount
                if degHealth["clutch"] > 100 then
                    degHealth["clutch"] = 100
                end
            updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
            elseif degname == "transmission" then
                degHealth["transmission"] = degHealth["transmission"] + amount
                if degHealth["transmission"] > 100 then
                    degHealth["transmission"] = 100
                end
            updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
            elseif degname == "electronics" then
                degHealth["electronics"] = degHealth["electronics"] + amount
                if degHealth["electronics"] > 100 then
                    degHealth["electronics"] = 100
                end
            updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
            elseif degname == "fuel_injector" then
                degHealth["fuel_injector"] = degHealth["fuel_injector"] + amount
                if degHealth["fuel_injector"] > 100 then
                    degHealth["fuel_injector"] = 100
                end
            updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
            elseif degname == "fuel_tank" then
                degHealth["fuel_tank"] = degHealth["fuel_tank"] + amount
                if degHealth["fuel_tank"] > 100 then
                    degHealth["fuel_tank"] = 100
                end
            updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
            end


            exports['ghmattimysql']:execute("UPDATE bbvehicles SET degredation = @degredation WHERE plate = @plate", {
                ['@degredation'] = updateDB,
                ['plate'] = plate
            })

            --print(updateDB)
            --[[ MySQL.Async.execute("UPDATE bbvehicles SET degredation = @degredation WHERE plate = @plate", {
                ['@degredation'] = updateDB,
                ['plate'] = plate
            }) ]]

            -- print(degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"])
            end)
            TriggerClientEvent('DoShortHudText',_src,'Complete Repairs', 2)
            Wait(500)
            TriggerClientEvent('veh:requestUpdate',_src)
            TriggerEvent('mech:remove:materials',itemname,matAmount)
end)


RegisterNetEvent('veh.callDegredation')
AddEventHandler('veh.callDegredation', function(plate,status)

    local _src = source

    exports['ghmattimysql']:execute('SELECT * FROM bbvehicles WHERE plate = @plate', {
        ['@plate'] = plate
      }, function(result)

    --[[ MySQL.Async.fetchAll('SELECT * FROM bbvehicles WHERE plate = @plate', {
        ['@plate'] = plate
      }, function (result)  ]]

        if result[1] ~= nil then
            TriggerClientEvent('veh.getSQL',_src, result[1].degredation)
        else
            --TriggerClientEvent("DoLongHudTexts",_src, "This vehicle is not listed",2) 
        end   
        TriggerClientEvent("veh:checkVeh",_src, degration) 
      end)
    
end)



RegisterNetEvent('veh.updateVehicleHealth')
AddEventHandler('veh.updateVehicleHealth', function(tempReturn)
    local src = source
    local plate = ""
    local engine_damage = 0
    local body_damage = 0
    local fuel = 0

    for k,v in pairs(tempReturn[1]) do
            if k == 1 then       
                plate = v
            elseif k == 2 then
                engine_damage = v
            elseif k == 3 then
                body_damage = v
            elseif k == 4 then
                fuel = v
            end
    end
    exports['ghmattimysql']:execute("UPDATE bbvehicles SET engine_damage = @engine_damage, body_damage = @body_damage, fuel = @fuel WHERE plate = @plate", {
        ['@engine_damage'] = engine_damage,
        ['@body_damage'] = body_damage,
        ['@fuel'] = fuel,
         ['plate'] = plate
    })


    --[[ MySQL.Async.execute("UPDATE bbvehicles SET engine_damage = @engine_damage, body_damage = @body_damage, fuel = @fuel WHERE plate = @plate", {
        ['@engine_damage'] = engine_damage,
        ['@body_damage'] = body_damage,
        ['@fuel'] = fuel,
         ['plate'] = plate
    }) ]]

end)

RegisterNetEvent('veh.updateVehicleDegredationServer')
AddEventHandler('veh.updateVehicleDegredationServer', function(plate,br,ax,rad,cl,tra,elec,fi,ft)
    print(json.encode(plate,br,ax,rad,cl,tra,elec,fi,ft))
    --ONLY GETTING THE PLATE NOTHING ELSE!!!!!
    exports['ghmattimysql']:execute('SELECT plate FROM bbvehicles WHERE plate = @plate', {
        ['@plate'] = plate
      }, function(result)
    --[[ MySQL.Async.fetchAll('SELECT plate FROM bbvehicles WHERE plate = @plate', {
        ['@plate'] = plate
      }, function (result) ]]
       print(result[1].plate)
        if result[1] ~= nil then
            print(json.encode(result))
            local degri = ""..br..","..ax..","..rad..","..cl..","..tra..","..elec..","..fi..","..ft..""  
            print(json.encode(degri))

            exports['ghmattimysql']:execute("UPDATE bbvehicles SET degredation = @degredation WHERE plate = @plate", {
                 ['@degredation'] = tostring(degri),
                 ['plate'] = plate
            })

            --[[ MySQL.Async.execute("UPDATE bbvehicles SET degredation = @degredation WHERE plate = @plate", {
                ['@degredation'] = tostring(degri),
                 ['plate'] = plate
            }) ]]
        else
            local degri = ""..br..","..ax..","..rad..","..cl..","..tra..","..elec..","..fi..","..ft..""  
            -- print('not mine veh_damage',degri)
          
        end
      end)
end)

function string:split(delimiter)
    local result = { }
    local from  = 1
    local delim_from, delim_to = string.find( self, delimiter, from  )
    while delim_from do
      table.insert( result, string.sub( self, from , delim_from-1 ) )
      from  = delim_to + 1
      delim_from, delim_to = string.find( self, delimiter, from  )
    end
    table.insert( result, string.sub( self, from  ) )
    return result
  end


  