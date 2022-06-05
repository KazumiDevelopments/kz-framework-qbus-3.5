-----------------------
----   Variables   ----
-----------------------
local RLCore = exports['rl-core']:GetCoreObject()
local scenes = {}

-----------------------
----   Threads     ----
-----------------------

CreateThread(function()
    UpdateAllScenes()
    while true do 
        DeleteExpiredScenes()
        Wait(Config.AuditInterval)
    end
end)

-----------------------
---- Server Events ----
-----------------------

RLCore.Functions.CreateCallback('rl-scenes:server:GetScenes', function(source, cb)
    cb(scenes)
end)

-----------------------
----   Functions   ----
-----------------------

function UpdateAllScenes()
    scenes = {}
    exports.ghmattimysql:execute('SELECT * FROM scenes', {}, function(result)
        if result[1] then
            for _, v in pairs(result) do
                local newCoords = json.decode(v.coords)
                scenes[#scenes+1] = {
                    id = v.id,
                    text = v.text,
                    color = v.color,
                    viewdistance = v.viewdistance,
                    expiration = v.expiration,
                    fontsize = v.fontsize,
                    fontstyle = v.fontstyle,
                    coords = vector3(newCoords.x, newCoords.y, newCoords.z),
                }
            end
        end
        TriggerClientEvent('rl-scenes:client:UpdateAllScenes', -1, scenes)
    end)
end

function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
 end

function DeleteExpiredScenes()

    exports.ghmattimysql:execute('SELECT * FROM scenes', {}, function(result)
        if result[1] then
            if result[1].expiration > 0 then
                --print('Deleted '..result[1].expiration..' expired scenes from the database.') 
                exports.ghmattimysql:execute('DELETE FROM scenes WHERE date_deletion < NOW()', {}, function(result) 
                UpdateAllScenes()
                end)
            end
        end
    end)
end

RegisterNetEvent('rl-scenes:server:DeleteScene', function(id)
    exports.ghmattimysql:execute('DELETE FROM scenes WHERE id = ?', {id}, function(result)
        UpdateAllScenes()
    end)
end) 

RegisterNetEvent('rl-scenes:server:CreateScene', function(sceneData) 
    local src = source 

    exports.ghmattimysql:execute('INSERT INTO scenes (creator, text, color, viewdistance, expiration, fontsize, fontstyle, coords, date_creation, date_deletion) VALUES (? ,?, ?, ?, ?, ?, ?, ?, NOW(), DATE_ADD(NOW(), INTERVAL ? HOUR))', {
        RLCore.Functions.GetPlayer(src).PlayerData.citizenid, 
        sceneData.text,
        sceneData.color,
        sceneData.viewdistance,
        sceneData.expiration,
        sceneData.fontsize,
        sceneData.fontstyle,
        json.encode(sceneData.coords),
        sceneData.expiration
    }, function(result)
        UpdateAllScenes()
    end)
end)