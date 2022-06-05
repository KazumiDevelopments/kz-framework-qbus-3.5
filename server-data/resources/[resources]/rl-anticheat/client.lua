local HaReL = {
    "esx:getSharedObject"
}

Citizen.CreateThread(function()
    for k,v in pairs(HaReL) do
        RegisterNetEvent(v)
        AddEventHandler(v, function()
            TriggerServerEvent("HaReL:sayHello")
        end)
    end
end