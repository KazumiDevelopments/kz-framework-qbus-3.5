RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

local SafeCodes = {}
local usedCameras = {}

Citizen.CreateThread(function()
    while true do 
        SafeCodes = {
            [1] = math.random(1000, 9999),
            [2] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [3] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [4] = math.random(1000, 9999),
            [5] = math.random(1000, 9999),
            [6] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [7] = math.random(1000, 9999),
            [8] = math.random(1000, 9999),
            [9] = math.random(1000, 9999),
            [10] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [11] = math.random(1000, 9999),
            [12] = math.random(1000, 9999),
            [13] = math.random(1000, 9999),
            [14] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [15] = math.random(1000, 9999),
            [16] = math.random(1000, 9999),
            [17] = math.random(1000, 9999),
            [18] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [19] = math.random(1000, 9999),
        }
        Citizen.Wait((1000 * 60) * 40)
    end
end)

RegisterServerEvent('rl-storerobbery:server:takeMoney')
AddEventHandler('rl-storerobbery:server:takeMoney', function(register, isDone)
    local src   = source
    local Player = RLCore.Functions.GetPlayer(src)

    Player.Functions.AddMoney('cash', math.random(65, 125), "robbery-store")
    if isDone then
        if math.random(1, 100) <= 17 then
            local code = SafeCodes[Config.Registers[register].safeKey]
            local info = {}
            if Config.Safes[Config.Registers[register].safeKey].type == "keypad" then
                info = {
                    label = "Safe code: "..tostring(code)
                }
            else
                info = {
                    label = "Safe code: "..tostring(math.floor((code[1] % 360) / 3.60)).."-"..tostring(math.floor((code[2] % 360) / 3.60)).."-"..tostring(math.floor((code[3] % 360) / 3.60)).."-"..tostring(math.floor((code[4] % 360) / 3.60)).."-"..tostring(math.floor((code[5] % 360) / 3.60))
                }
            end
            Player.Functions.AddItem("stickynote", 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["stickynote"], "add")
        end
    end
end)

RegisterServerEvent('rl-storerobbery:server:setRegisterStatus')
AddEventHandler('rl-storerobbery:server:setRegisterStatus', function(register)
	local Player = RLCore.Functions.GetPlayer(src)
    TriggerClientEvent('rl-storerobbery:client:setRegisterStatus', -1, register, true)
    Config.Registers[register].robbed   = true
    Config.Registers[register].time     = Config.resetTime
	dclog(Player, 'Store has been robbed.')
end)

RegisterServerEvent('rl-storerobbery:server:setSafeStatus')
AddEventHandler('rl-storerobbery:server:setSafeStatus', function(safe)
    TriggerClientEvent('rl-storerobbery:client:setSafeStatus', -1, safe, true)
    Config.Safes[safe].robbed = true

    SetTimeout(math.random(40, 80) * (60 * 1000), function()
        TriggerClientEvent('rl-storerobbery:client:setSafeStatus', -1, safe, false)
        Config.Safes[safe].robbed = false
    end)
end)

RegisterServerEvent('rl-storerobbery:server:SafeReward')
AddEventHandler('rl-storerobbery:server:SafeReward', function(safe)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash', math.random(1000, 3000), "robbery-safe-reward")
    local luck = math.random(1, 100)
    local odd = math.random(1, 100)
    if luck <= 10 then
        Player.Functions.AddItem("rolex", math.random(3, 7))
        TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["rolex"], "add")
        if luck == odd then
            Citizen.Wait(500)
            Player.Functions.AddItem("goldbar", math.random(1, 2))
            TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["goldbar"], "add")
        end
    end
end)

RegisterServerEvent('rl-storerobbery:server:callCops')
AddEventHandler('rl-storerobbery:server:callCops', function(type, safe)
    local src = source
    local cameraId = 4
    if type == "safe" then
        cameraId = Config.Safes[safe].camId
    else
        cameraId = Config.Registers[safe].camId
    end

    if not usedCameras[cameraId] then
        usedCameras[cameraId] = true
        TriggerClientEvent("police:camera", -1, cameraId)
    end
end)

Citizen.CreateThread(function()
    
    while true do
        for k, v in pairs(Config.Registers) do
            if Config.Registers[k].time > 0 and (Config.Registers[k].time - Config.tickInterval) >= 0 then
                Config.Registers[k].time = Config.Registers[k].time - Config.tickInterval
            else
                usedCameras = {}
                Config.Registers[k].time = 0
                Config.Registers[k].robbed = false
                TriggerClientEvent('rl-storerobbery:client:setRegisterStatus', -1, k, false)
            end
        end
        Citizen.Wait(Config.tickInterval)
    end
end)

RLCore.Functions.CreateCallback('rl-storerobbery:server:isCombinationRight', function(source, cb, safe)
    cb(SafeCodes[safe])
end)

RLCore.Functions.CreateCallback('rl-storerobbery:server:getPadlockCombination', function(source, cb, safe)
    cb(SafeCodes[safe])
end)

RLCore.Functions.CreateCallback('rl-storerobbery:server:getRegisterStatus', function(source, cb)
    cb(Config.Registers)
end)

RLCore.Functions.CreateCallback('rl-storerobbery:server:getSafeStatus', function(source, cb)
    cb(Config.Safes)
end)

function dclog(Player, text)
    local playerName = System(Player.getName())
   
    local discord_webhook = Config.DiscordWebhook
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "Store Robbery Log",
      ["embeds"] = {{
        ["author"] = {
          ["name"] = playerName .. ' - ' .. Player.identifier
        },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
      }}
    }
    data['embeds'][1]['description'] = text
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end