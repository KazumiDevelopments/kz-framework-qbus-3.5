RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterServerEvent('paystripclub:pay')
AddEventHandler('paystripclub:pay', function()
	local src = source
    local Player = RLCore.Functions.GetPlayer(src)

	if Player.PlayerData.money.cash >= 150 then
		Player.Functions.RemoveMoney("cash", 150)
		TriggerEvent("bb-bossmenu:server:addAccountMoney", "vanilla", 150)
		TriggerClientEvent('RLCore:Notify', src, "You paid 150$ Entry Fee for VU.", "success")
	else
		TriggerClientEvent('RLCore:Notify', src, 'Not enough money.', 'error')
		end
		TriggerClientEvent("strippers:mail", -1, {
            sender = "Vanilla Unicorn",
            subject = "Vanilla Unicorn Receipt",
            message = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " has paid 150$ entry fee for the vanilla unicorn.",
            button = {}
		})
end)

RegisterServerEvent("strippers:spawn")
AddEventHandler("strippers:spawn", function(spawned)
	TriggerClientEvent("strippers:spawn", spawned)
end)

RegisterServerEvent("strippers:updateStrippers")
AddEventHandler("strippers:updateStrippers", function(data)
	TriggerClientEvent("strippers:updateStrippers", -1, data)
	Config.Strippers['locations'] = data
end)

RegisterServerEvent('stripclubstack:pay')
AddEventHandler('stripclubstack:pay', function()
    local src = source
    local Player = RLCore.Functions.GetPlayer(src)
	
    if Player.PlayerData.money.cash >= 200 then
		Player.Functions.RemoveMoney("cash", 200)
		TriggerEvent("bb-bossmenu:server:addAccountMoney", "vanilla", 200)
    else
        TriggerClientEvent('RLCore:Notify', src, 'Not enough money.', 'error')
    end
end)

RegisterServerEvent("strippers:serverDeletePed")
AddEventHandler("strippers:serverDeletePed", function(model, coords)
	TriggerClientEvent("strippers:clientDeletePed", -1, model, coords)
end)