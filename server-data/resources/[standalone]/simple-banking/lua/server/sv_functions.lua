function AddTransaction(source, sAccount, iAmount, sType, sReceiver, sMessage, cb)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local CitizenId = Player.PlayerData.citizenid

    local iTransactionID = math.random(1000, 100000)

    local values = {
        ["citizenid"] = CitizenId,
        ["trans_id"] = iTransactionID,
        ["account"] = sAccount,
        ["amount"] = iAmount,
        ["trans_type"] = sType,
        ["receiver"] = sReceiver,
        ["message"] = sMessage,
        
    }

    local cols = "citizenid, trans_id, account, amount, trans_type, receiver, message"
    local vals = "'" .. CitizenId .. "', '" .. values["trans_id"] ..  "', '" .. values["account"] ..  "', '" .. values["amount"] ..  "', '" .. values["trans_type"] ..  "', '" .. values["receiver"] ..  "', '" .. values["message"] ..  "'" 
    exports.ghmattimysql:execute("INSERT INTO transaction_history ("..cols..") VALUES ("..vals..")", values, function()

        RefreshTransactions(src)
    end)
end

function RefreshTransactions(source)
    local src = source
    if not src then return end

    local Player = RLCore.Functions.GetPlayer(src)

    if not Player then return end
    exports.ghmattimysql:execute("SELECT * FROM transaction_history WHERE citizenid = @citizenid AND DATE(date) > (NOW() - INTERVAL "..SimpleBanking.Config["Days_Transaction_History"].." DAY)", {["@citizenid"] = Player.PlayerData.citizenid}, function(result)
        if result ~= nil then
            TriggerClientEvent("rl-banking:client:UpdateTransactions", src, result)
        end
    end)
end