RLCore = nil

CreateThread(function()
    if IsDuplicityVersion() then
        TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
    else
        while RLCore == nil do
            Citizen.Wait(10)
            TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
        end
    end

    print("[Nevo] Module Ready")
    TriggerEvent("nevo:ready")
end)