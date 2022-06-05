exports("openMenu", function(data)

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "createMenu",
        payload = {items = data}
    })

end)

exports("closeMenu", function(data)

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "hideMenu"
    })

end)


RegisterNUICallback("closeNui", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("closeMenu", function(data)
    if(data.close) then
        SetNuiFocus(false, false)
    end

    if(data.eventType == "client") then
        TriggerEvent(data.event, data.args)
    else
        TriggerServerEvent(data.event, data.args)
    end
end)