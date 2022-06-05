RLCore = nil
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10) -- 
        if RLCore == nil then
            TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
            Citizen.Wait(200)
        end
    end
end)