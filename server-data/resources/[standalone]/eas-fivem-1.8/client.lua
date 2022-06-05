RegisterNetEvent("SendAlert")
AddEventHandler("SendAlert", function(msg, msg2)
    SendNUIMessage({
        type    = "alert",
        enable  = true,
        issuer  = msg,
        message = msg2,
        volume  = Config.EAS.Volume
    })
end)

RegisterNetEvent("alert:Send")
AddEventHandler("alert:Send", function(msg, departments)
    for i, v in pairs(departments) do
        if msg == i then
            DisplayOnscreenKeyboard(1, "", "", "", "", "", "", 600)
            while (UpdateOnscreenKeyboard() == 0) do
                DisableAllControlActions(0);
                Wait(0);
            end
            if (GetOnscreenKeyboardResult()) then
                msg = departments[i].name
                local msg2 = GetOnscreenKeyboardResult()
                TriggerServerEvent("alert:sv", msg, msg2)
                SendAlert(msg, msg2)
            end
        end
    end
end)
