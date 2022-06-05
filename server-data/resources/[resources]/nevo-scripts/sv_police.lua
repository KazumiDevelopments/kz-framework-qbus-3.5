RegisterServerEvent("nevo:ready")
AddEventHandler("nevo:ready", function()
    RLCore.Commands.Add('livery', 'Set vehicle livery (Emergency Only)', {}, false, function(source, args)
        local src = source
        local Player = RLCore.Functions.GetPlayer(src)
        local livery = tonumber(args[1])
    
        if Player and (Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'ambulance') then
            if Player then
                TriggerClientEvent('police:livery', src, livery)
                TriggerEvent('bb-logs:server:createLog', 'commands', 'Livery Command', "Used Livery Command " .. args[1], src)
            else
                TriggerClientEvent('chat:addMessage', src, {
                    template = '<div class="chat-message server">SYSTEM: {0}</div>',
                    args = { 'This command is for emergency services!' }
                })
            end
        else
            TriggerClientEvent('chat:addMessage', src, {
                template = '<div class="chat-message server">Usage /livery [Number]</div>',
            })
        end
    end)

    RLCore.Commands.Add('extras', 'Set vehicle Extras (Emergency Only)', {{name="extra", help="all / remove / 1-10"}}, false, function(source, args)
        local src = source
        local Player = RLCore.Functions.GetPlayer(src)
        local extra = tonumber(args[1])
    
        --if Player and (Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'ambulance') then
        if args[1] then
            if Player then
                TriggerClientEvent('police:extras', src, extra ~= nil and extra or args[1])
                TriggerEvent('bb-logs:server:createLog', 'commands', 'Extras Command', "Used Extras Command " .. args[1], src)
            else
                TriggerClientEvent('chat:addMessage', src, {
                    template = '<div class="chat-message server">SYSTEM: {0}</div>',
                    args = { 'This command is for emergency services!' }
                })
            end
        else
            TriggerClientEvent('chat:addMessage', src, {
                template = '<div class="chat-message server">Usage /livery [Number]</div>',
            })
        end
        
    end)
    
    RLCore.Commands.Add('fix', 'Fix Vehicle (Emergency Only)', {}, false, function(source, args)
        local src = source
        local Player = RLCore.Functions.GetPlayer(src)
    
        if Player and (Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'ambulance') then
            TriggerClientEvent('police:fix', src)
        else
            TriggerClientEvent('chat:addMessage', src, {
                template = '<div class="chat-message server">SYSTEM: {0}</div>',
                args = { 'This command is for emergency services!' }
            })
        end
        
    end)

    RLCore.Commands.Add('tint', 'Set Tint (Emergency Only)', {}, false, function(source, args)
        local src = source
        local Player = RLCore.Functions.GetPlayer(src)
        if Player and (Player.PlayerData.job.name == 'police') then
            TriggerClientEvent('police:windowtint', src, tonumber(args[1]))
        else
            TriggerClientEvent('chat:addMessage', src, {
                template = '<div class="chat-message server">SYSTEM: {0}</div>',
                args = { 'This command is for emergency services!' }
            })
        end
        
    end)

    RLCore.Commands.Add('evidence', 'Open Evidence Box (Emergency Only)', {}, false, function(source, args)
        local src = source
        local Player = RLCore.Functions.GetPlayer(src)
    
        if Player and (Player.PlayerData.job.name == 'police') then
            TriggerClientEvent('police:evidence', src, tonumber(args[1]))
        else
            TriggerClientEvent('chat:addMessage', src, {
                template = '<div class="chat-message server">SYSTEM: {0}</div>',
                args = { 'This command is for emergency services!' }
            })
        end
        
    end)

    RLCore.Commands.Add('sv', 'Spawn Vehicle (/sv help) (Emergency Only)', {}, false, function(source, args)
        local src = source
        local Player = RLCore.Functions.GetPlayer(src)
    
        if Player and (Player.PlayerData.job.name == 'police') then
            TriggerClientEvent('police:sv', src, args[1])
        else
            TriggerClientEvent('chat:addMessage', src, {
                template = '<div class="chat-message server">SYSTEM: {0}</div>',
                args = { 'This command is for emergency services!' }
            })
        end
        
    end)

    RLCore.Commands.Add('pchat', 'Officers Chat', {}, false, function(source, args)
        local src = source
        local Player = RLCore.Functions.GetPlayer(src)
        local hasphone = Player.Functions.GetItemByName('phone') ~= nil and true or false
        
        if not Player.PlayerData.metadata["ishandcuffed"] and not Player.PlayerData.metadata["isdead"] then
            if hasphone == true then
                if Player and (Player.PlayerData.job.name == 'police' and Player.PlayerData.job.onduty) then
                    TriggerClientEvent('police:chatMessage', -1, {(Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.metadata.callsign .. ')'), table.concat(args, " ")})
                    TriggerClientEvent('bb-911:client:justcalled', src)
                else
                    TriggerClientEvent('chat:addMessage', src, {
                        template = '<div class="chat-message server">SYSTEM: {0}</div>',
                        args = { 'This command is for emergency services!' }
                    })
                end
            else
                TriggerClientEvent('RLCore:Notify', src, "You dont have a phone!", 'error')
            end
        else
            TriggerClientEvent('RLCore:Notify', src, "You cant do it while you're dead/cuffed!", 'error')
        end
    end)
end)

RegisterServerEvent("police:unmaskGranted")
AddEventHandler("police:unmaskGranted", function(player)
    TriggerClientEvent('police:unmaskAccepted', player)
end)