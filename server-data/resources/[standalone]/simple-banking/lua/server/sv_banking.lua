RLCore = exports['rl-core']:GetCoreObject()
RLCore.Functions.CreateCallback("rl-banking:server:GetBankData", function(source, cb)
    local src = source
    if not src then return end

    local Player = RLCore.Functions.GetPlayer(src)

    if not Player then return end

    local PlayerMoney = Player.PlayerData.money["bank"] or 0 
    local CitizenId = Player.PlayerData.citizenid 

    local TransactionHistory = {}
    local TransactionRan = false
    local tbl = {}
    tbl[1] = {
        type = "personal",
        amount = PlayerMoney
    }

    local job = Player.PlayerData.job
    
    if (job.name and job.grade.name) then
        json.encode(print(job.name))
        json.encode(print(job.grade.name))
        json.encode(print(SimpleBanking.Config["business_ranks_overrides"]))

        if(SimpleBanking.Config["business_ranks"][string.lower(job.grade.name)] or SimpleBanking.Config["business_ranks_overrides"][string.lower(job.name)] and SimpleBanking.Config["business_ranks_overrides"][string.lower(job.name)][string.lower(job.grade.name)]) then
            exports['ghmattimysql']:execute("SELECT * FROM society WHERE name = @name", {['@name'] = job.name}, function(result)
                local data = result[1]

                if data ~= nil then
                    tbl[#tbl + 1] = {
                        type = "business",
                        name = job.label,
                        amount = format_int(data.money) or 0
                    }
                end
            end)
        end
    end

    --[[ local gang = Player.PlayerData.gang

    if (gang.name and gang.grade.name) then
        if(SimpleBanking.Config["gang_ranks"][string.lower(gang.grade.name)] or SimpleBanking.Config["gang_ranks_overrides"][string.lower(gang.name)] and SimpleBanking.Config["gang_ranks_overrides"][string.lower(gang.name)][string.lower(gang.grade.name)]) then

            local result = RLCore.Functions.ExecuteSql(false,'SELECT * FROM society WHERE name= ?', {gang.name})
            local data = result[1]

            if data ~= nil then
                tbl[#tbl + 1] = {
                    type = "organization",
                    name = gang.label,
                    amount = format_int(data.money) or 0
                }
            end
        end
    end ]]
    exports.ghmattimysql:execute("SELECT * FROM transaction_history WHERE citizenid = @citizenid AND DATE(date) > (NOW() - INTERVAL "..SimpleBanking.Config["Days_Transaction_History"].." DAY)", {["@citizenid"] = Player.PlayerData.citizenid}, function(result)
    

        if result ~= nil then
            TransactionRan = true
            TransactionHistory = result
        end
    
    
        repeat
            Wait(0)
        until 
            TransactionRan
        cb(tbl, TransactionHistory)
    end)
end)
