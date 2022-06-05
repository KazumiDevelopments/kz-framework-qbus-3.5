local properties = nil

RegisterNUICallback("buttonSubmit", function(data, cb)
    SetNuiFocus(false)
    properties:resolve(data.data)
    properties = nil
    cb("ok")
end)

RegisterNUICallback("closeMenu", function(data, cb)
    SetNuiFocus(false)
    properties:resolve(nil)
    properties = nil
    cb("ok")
end)

function ShowInput(data)
    Wait(150)
    if not data then return end
    if properties then return end

    properties = promise.new()

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })

    return Citizen.Await(properties)
end

exports("ShowInput", ShowInput)
