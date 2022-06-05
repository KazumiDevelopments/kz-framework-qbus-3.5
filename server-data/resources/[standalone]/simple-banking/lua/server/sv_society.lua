function GetSociety(name)
    local result = RLCore.Functions.ExecuteSql(false,'SELECT * FROM society WHERE name= ?', {name}) --exports['ghmattimysql']:execute("SELECT * FROM `society` WHERE `name` ='"..name.."' ")
    local data = result[1]

    return data
end


RegisterNetEvent('rl-banking:society:server:WithdrawMoney')
AddEventHandler('rl-banking:society:server:WithdrawMoney', function(pSource, a, n)
    local src = pSource
    if not src then return end

    local player = RLCore.Functions.GetPlayer(src)
    if not player then return end

    if not a then return end
    if not n then return end

    local s = GetSociety(n)
    local sMoney = tonumber(s.money)
    local amount = tonumber(a)
    local withdraw = sMoney - amount

    local setter = RLCore.Functions.ExecuteSql(false,"UPDATE society SET money =  ? WHERE name = ?", {withdraw, n})
end)

RegisterServerEvent('rl-banking:society:server:DepositMoney')
AddEventHandler('rl-banking:society:server:DepositMoney', function(pSource, a, n)
    local src = pSource
    if not src then return end

    local player = RLCore.Functions.GetPlayer(src)
    if not player then return end

    if not a then return end
    if not n then return end

    local s = GetSociety(n)
    local sMoney = tonumber(s.money)
    local amount = tonumber(a)
    local deposit = sMoney + amount

    
    local setter = RLCore.Functions.ExecuteSql(false,"UPDATE society SET money =  ? WHERE name = ?", {deposit, n})
end)