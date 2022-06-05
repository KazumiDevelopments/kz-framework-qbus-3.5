RLCore = nil
isLoggedIn = false
PlayerJob = {}

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
        end
        if RLCore ~= nil then
            TriggerEvent("hud:client:SetMoney")
            return
        end
    end
end)

RegisterNetEvent("RLCore:Client:OnPlayerUnload")
AddEventHandler("RLCore:Client:OnPlayerUnload", function()
    isLoggedIn = false
    SendNUIMessage({
        action = "hudtick",
        show = true,
    })
end)

RegisterNetEvent("RLCore:Client:OnPlayerLoaded")
AddEventHandler("RLCore:Client:OnPlayerLoaded", function()
    isLoggedIn = true
    PlayerJob = RLCore.Functions.GetPlayerData().job
end)
