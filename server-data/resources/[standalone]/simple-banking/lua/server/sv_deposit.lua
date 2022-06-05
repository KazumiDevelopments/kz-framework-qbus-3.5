RegisterServerEvent('rl-banking:server:Deposit')
AddEventHandler('rl-banking:server:Deposit', function(account, amount, note, fSteamID)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)

    if not Player or Player == -1 then
        return
    end

    if not amount or tonumber(amount) <= 0 then
        TriggerClientEvent("rl-banking:client:Notify", src, "error", "Invalid Amount!") 
        return
    end

    local amount = tonumber(amount)
    if amount > Player.PlayerData.money["cash"] then
        TriggerClientEvent("rl-banking:client:Notify", src, "error", "You can't afford this!") 
        return
    end

    if account == "personal"  then
        local amt = math.floor(amount)

        Player.Functions.RemoveMoney('cash', amt)
        Wait(500)
        Player.Functions.AddMoney('bank', amt)
        RefreshTransactions(src)
        AddTransaction(src, "personal", amount, "deposit", "N/A", (note ~= "" and note or "Deposited $"..format_int(amount).." cash."))
        return
    end

    if account == "business"  then
        local job = Player.PlayerData.job
        local job_grade = job.grade.name

        if (not SimpleBanking.Config["business_ranks"][string.lower(job_grade)] and not SimpleBanking.Config["business_ranks_overrides"][string.lower(job.name)]) then
            return
        end

        local low = string.lower(job.name)
        local grade = string.lower(job_grade)

        if (SimpleBanking.Config["business_ranks_overrides"][low] and not SimpleBanking.Config["business_ranks_overrides"][low][grade]) then
            return
        end


        local result = RLCore.Functions.ExecuteSql(false,'SELECT * FROM society WHERE name= ?', {job.name})
        local data = result[1]

        if data then
            local deposit = math.floor(amount)

            Player.Functions.RemoveMoney('cash', deposit)
            TriggerEvent('rl-banking:society:server:DepositMoney', src, deposit, data.name)
            AddTransaction(src, "business", amount, "deposit", job.label, (note ~= "" and note or "Deposited $"..format_int(amount).." cash into ".. job.label .."'s business account."))        end
    end

    if account == "organization"  then
        local gang = Player.PlayerData.gang
        local gang_grade = gang.grade.name
    
        if (not SimpleBanking.Config["gang_ranks"][string.lower(gang_grade)] and not SimpleBanking.Config["gang_ranks_overrides"][string.lower(gang.name)]) then
            return
        end
    
        local low = string.lower(gang.name)
        local grade = string.lower(gang_grade)
    
        if (SimpleBanking.Config["gang_ranks_overrides"][low] and not SimpleBanking.Config["gang_ranks_overrides"][low][grade]) then
            return
        end
    
        exports['ghmattimysql']:execute("SELECT * FROM society WHERE name = @name", {['@name'] = gang.name}, function(result)

            local data = result[1]
        
            if data then
                local deposit = math.floor(amount)
        
                Player.Functions.RemoveMoney('cash', deposit)
                TriggerEvent('rl-banking:society:server:DepositMoney',src, deposit, data.name)
                AddTransaction(src, "organization", amount, "deposit", gang.label, (note ~= "" and note or "Deposited $"..format_int(amount).." cash into ".. gang.label .."'s account."))
                
            end
        end)
    end
end)
