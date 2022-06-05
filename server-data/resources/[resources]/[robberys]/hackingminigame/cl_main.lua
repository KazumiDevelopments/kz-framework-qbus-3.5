local success = nil



  
exports("Open", function()
    success = nil
    SetNuiFocus(true , true)
    SendNUIMessage({show = true})
    while (success == nil) do
        Citizen.Wait(1)
    end
    SetNuiFocus(false , false)

    return success
    
end)


RegisterNUICallback('endTask', function(data)
    success = data.success
    SetNuiFocus(false , false)
    SendNUIMessage({show = false})

end)

