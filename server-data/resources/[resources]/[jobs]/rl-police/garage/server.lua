RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterNetEvent('rl:police:garage:jobcheck')
AddEventHandler('rl:police:garage:jobcheck', function(value)    
        stupiduser = RLCore.Functions.GetPlayer(source)
        if value == 'POLVIC2' then
            if (stupiduser.PlayerData.job.name == "police" and stupiduser.PlayerData.job.grade.level >= 0) then
                TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 1)
            else
                if stupiduser.PlayerData.job.name ~= "police" then
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 3)
                else
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 2)
                end
            end
        end
        if value == 'POLTAURUS' then
            if (stupiduser.PlayerData.job.name == "police" and stupiduser.PlayerData.job.grade.level >= 0) then
                TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 1)
            else
                if stupiduser.PlayerData.job.name ~= "police" then
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 3)
                else
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 2)
                end
            end
        end
        if value == 'POLCHAR' then
            if (stupiduser.PlayerData.job.name == "police" and stupiduser.PlayerData.job.grade.level >= 0) then
                TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 1)
            else
                if stupiduser.PlayerData.job.name ~= "police" then
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 3)
                else
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 2)
                end
            end
        end
        if value == '2015POLSTANG' then
            if (stupiduser.PlayerData.job.name == "police" and stupiduser.PlayerData.job.grade.level >= 0) then
                TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 1)
            else
                if stupiduser.PlayerData.job.name ~= "police" then
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 3)
                else
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 2)
                end
            end
        end
        if value == 'TAHOE' then
            if (stupiduser.PlayerData.job.name == "police" and stupiduser.PlayerData.job.grade.level >= 0) then
                TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 1)
            else
                if stupiduser.PlayerData.job.name ~= "police" then
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 3)
                else
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 2)
                end
            end
        end

        --REARRANGE
        if value == '18CHGRLEO' then
            if (stupiduser.PlayerData.job.name == "police" and stupiduser.PlayerData.job.grade.level >= 0) then
                TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 1)
            else
                if stupiduser.PlayerData.job.name ~= "police" then
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 3)
                else
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 2)
                end
            end
        end
        if value == 'EXPLEO' then
            if (stupiduser.PlayerData.job.name == "police" and stupiduser.PlayerData.job.grade.level >= 0) then
                TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 1)
            else
                if stupiduser.PlayerData.job.name ~= "police" then
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 3)
                else
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 2)
                end
            end
        end
        if value == 'TRHAWK' then
            if (stupiduser.PlayerData.job.name == "police" and stupiduser.PlayerData.job.grade.level >= 0) then
                TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 1)
            else
                if stupiduser.PlayerData.job.name ~= "police" then
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 3)
                else
                    TriggerClientEvent('rl:police:garage:jobcheck:back', source, value, 2)
                end
            end
        end
    end)