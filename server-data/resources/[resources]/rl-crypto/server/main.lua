RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RLCore.Commands.Add("setcryptoworth", "Set crypto worth", {{name="crypto", help="Name of the crypto currency"}, {name="Value", help="New value of the crypto currency"}}, false, function(source, args)
    local src = source
    local crypto = tostring(args[1])

    if crypto ~= nil then
        if Crypto.Worth[crypto] ~= nil then
            local NewWorth = math.ceil(tonumber(args[2]))
            
            if NewWorth ~= nil then
                local PercentageChange = math.ceil(((NewWorth - Crypto.Worth[crypto]) / Crypto.Worth[crypto]) * 100)
                local ChangeLabel = "+"
                if PercentageChange < 0 then
                    ChangeLabel = "-"
                    PercentageChange = (PercentageChange * -1)
                end
                if Crypto.Worth[crypto] == 0 then
                    PercentageChange = 0
                    ChangeLabel = ""
                end

                table.insert(Crypto.History[crypto], {
                    PreviousWorth = Crypto.Worth[crypto],
                    NewWorth = NewWorth
                })

                TriggerClientEvent('RLCore:Notify', src, "You have changed the value of" ..Crypto.Labels [crypto] .. "from: ($" .. Crypto.Worth [crypto] .. "to: $" .. NewWorth .. ") (" .. ChangeLabel .. "" ..PercentageChange .. "%)")
                Crypto.Worth[crypto] = NewWorth
                TriggerClientEvent('rl-crypto:client:UpdateCryptoWorth', -1, crypto, NewWorth)
                RLCore.Functions.ExecuteSql(false, "UPDATE `crypto` SET `worth` = '"..NewWorth.."', `history` = '"..json.encode(Crypto.History[crypto]).."' WHERE `crypto` = '"..crypto.."'")
            else
                TriggerClientEvent('RLCore:Notify', src, "You have not given a new value .. Current values: "..Crypto.Worth[crypto])
            end
        else
            TriggerClientEvent('RLCore:Notify', src, "This Crypto does not exist :(, available: RLBit")
        end
    else
        TriggerClientEvent('RLCore:Notify', src, "You have not provided Crypto, available: RLBit")
    end
end, "god")

RLCore.Commands.Add("checkcryptoworth", "", {}, false, function(source, args)
    local src = source
    TriggerClientEvent('RLCore:Notify', src, "The RLbit has a value of: $"..Crypto.Worth["RLBit"])
end)

RLCore.Commands.Add("crypto", "", {}, false, function(source, args)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local MyPocket = math.ceil(Player.PlayerData.money.crypto * Crypto.Worth["RLBit"])

    TriggerClientEvent('RLCore:Notify', src, "You have:" ..Player.PlayerData.money.crypto .. "RLBit, worth: $" .. MyPocket .. ", -")
end)

RegisterServerEvent('rl-crypto:server:FetchWorth')
AddEventHandler('rl-crypto:server:FetchWorth', function()
    for name,_ in pairs(Crypto.Worth) do
        RLCore.Functions.ExecuteSql(false, "SELECT * FROM `crypto` WHERE `crypto` = '"..name.."'", function(result)
            if result[1] ~= nil then
                Crypto.Worth[name] = result[1].worth
                if result[1].history ~= nil then
                    Crypto.History[name] = json.decode(result[1].history)
                    TriggerClientEvent('rl-crypto:client:UpdateCryptoWorth', -1, name, result[1].worth, json.decode(result[1].history))
                else
                    TriggerClientEvent('rl-crypto:client:UpdateCryptoWorth', -1, name, result[1].worth, nil)
                end
            end
        end)
    end
end)

RegisterServerEvent('rl-crypto:server:ExchangeFail')
AddEventHandler('rl-crypto:server:ExchangeFail', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local ItemData = Player.Functions.GetItemByName("cryptostick")

    if ItemData ~= nil then
        Player.Functions.RemoveItem("cryptostick", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["cryptostick"], "remove")
        TriggerClientEvent('RLCore:Notify', src, "Attempt failed, the stick crashed ..", 'error', 5000)
    end
end)

RegisterServerEvent('rl-crypto:server:Rebooting')
AddEventHandler('rl-crypto:server:Rebooting', function(state, percentage)
    Crypto.Exchange.RebootInfo.state = state
    Crypto.Exchange.RebootInfo.percentage = percentage
end)

RegisterServerEvent('rl-crypto:server:GetRebootState')
AddEventHandler('rl-crypto:server:GetRebootState', function()
    local src = source
    TriggerClientEvent('rl-crypto:client:GetRebootState', src, Crypto.Exchange.RebootInfo)
end)

RegisterServerEvent('rl-crypto:server:SyncReboot')
AddEventHandler('rl-crypto:server:SyncReboot', function()
    TriggerClientEvent('rl-crypto:client:SyncReboot', -1)
end)

RegisterServerEvent('rl-crypto:server:ExchangeSuccess')
AddEventHandler('rl-crypto:server:ExchangeSuccess', function(LuckChance)
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
    local ItemData = Player.Functions.GetItemByName("cryptostick")

    if ItemData ~= nil then
        local LuckyNumber = math.random(1, 10)
        local DeelNumber = 1000000
        local Amount = (math.random(611111, 1599999) / DeelNumber)
        if LuckChance == LuckyNumber then
            Amount = (math.random(1599999, 2599999) / DeelNumber)
        end

        Player.Functions.RemoveItem("cryptostick", 1)
        Player.Functions.AddMoney('crypto', Amount)
        TriggerClientEvent('RLCore:Notify', src, "You have exchanged your Cryptostick for: "..Amount .." RLBit (\'s) ", "success", 3500)
        TriggerClientEvent('inventory:client:ItemBox', src, RLCore.Shared.Items["cryptostick"], "remove")
        TriggerClientEvent('rl-phone:client:AddTransaction', src, Player, {}, "There are "..Amount .." RLBit (s) credited!", "Credit")
    end
end)

RLCore.Functions.CreateCallback('rl-crypto:server:HasSticky', function(source, cb)
    local Player = RLCore.Functions.GetPlayer(source)
    local Item = Player.Functions.GetItemByName("cryptostick")

    if Item ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RLCore.Functions.CreateCallback('rl-crypto:server:GetCryptoData', function(source, cb, name)
    local Player = RLCore.Functions.GetPlayer(source)
    local CryptoData = {
        History = Crypto.History[name],
        Worth = Crypto.Worth[name],
        Portfolio = Player.PlayerData.money.crypto,
        WalletId = Player.PlayerData.metadata["walletid"],
    }

    cb(CryptoData)
end)

RLCore.Functions.CreateCallback('rl-crypto:server:BuyCrypto', function(source, cb, data)
    local Player = RLCore.Functions.GetPlayer(source)

    if Player.PlayerData.money.bank >= tonumber(data.Price) then
        local CryptoData = {
            History = Crypto.History["RLBit"],
            Worth = Crypto.Worth["RLBit"],
            Portfolio = Player.PlayerData.money.crypto + tonumber(data.Coins),
            WalletId = Player.PlayerData.metadata["walletid"],
        }
        Player.Functions.RemoveMoney('bank', tonumber(data.Price))
        TriggerClientEvent('rl-phone:client:AddTransaction', source, Player, data, "You have bought "..tonumber (data.Coins) .." RLBit (s)!", "Credit")
        Player.Functions.AddMoney('crypto', tonumber(data.Coins))
        cb(CryptoData)
    else
        cb(false)
    end
end)

RLCore.Functions.CreateCallback('rl-crypto:server:SellCrypto', function(source, cb, data)
    local Player = RLCore.Functions.GetPlayer(source)

    if Player.PlayerData.money.crypto >= tonumber(data.Coins) then
        local CryptoData = {
            History = Crypto.History["RLBit"],
            Worth = Crypto.Worth["RLBit"],
            Portfolio = Player.PlayerData.money.crypto - tonumber(data.Coins),
            WalletId = Player.PlayerData.metadata["walletid"],
        }
        Player.Functions.RemoveMoney('crypto', tonumber(data.Coins))
        TriggerClientEvent('rl-phone:client:AddTransaction', source, Player, data, "You have sold "..tonumber (data.Coins) .." RLBit (s)! "," Depreciation")
        Player.Functions.AddMoney('bank', tonumber(data.Price))
        cb(CryptoData)
    else
        cb(false)
    end
end)

RLCore.Functions.CreateCallback('rl-crypto:server:TransferCrypto', function(source, cb, data)
    local Player = RLCore.Functions.GetPlayer(source)

    if Player.PlayerData.money.crypto >= tonumber(data.Coins) then
        RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `metadata` LIKE '%"..data.WalletId.."%'", function(result)
            if result[1] ~= nil then
                local CryptoData = {
                    History = Crypto.History["RLBit"],
                    Worth = Crypto.Worth["RLBit"],
                    Portfolio = Player.PlayerData.money.crypto - tonumber(data.Coins),
                    WalletId = Player.PlayerData.metadata["walletid"],
                }
                Player.Functions.RemoveMoney('crypto', tonumber(data.Coins))
                TriggerClientEvent('rl-phone:client:AddTransaction', source, Player, data, "Je hebt "..tonumber(data.Coins).." RLBit (s) transferred! "," Depreciation ")
                local Target = RLCore.Functions.GetPlayerByCitizenId(result[1].citizenid)

                if Target ~= nil then
                    Target.Functions.AddMoney('crypto', tonumber(data.Coins))
                    TriggerClientEvent('rl-phone:client:AddTransaction', Target.PlayerData.source, Player, data, "Er zijn "..tonumber(data.Coins).." RLBit (s) credited! "," Credit ")
                else
                    MoneyData = json.decode(result[1].money)
                    MoneyData.crypto = MoneyData.crypto + tonumber(data.Coins)
                    RLCore.Functions.ExecuteSql(false, "UPDATE `players` SET `money` = '"..json.encode(MoneyData).."' WHERE `citizenid` = '"..result[1].citizenid.."'")
                end
                cb(CryptoData)
            else
                cb("notvalid")
            end
        end)
    else
        cb("notenough")
    end
end)