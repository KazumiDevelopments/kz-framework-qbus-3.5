RegisterNetEvent('cd_drawtextui:ShowUI')
AddEventHandler('cd_drawtextui:ShowUI', function(action, text)
	SendNUIMessage({
		action = action,
		text = text,
	})
end)

RegisterNetEvent('cd_drawtextui:HideUI')
AddEventHandler('cd_drawtextui:HideUI', function()
	SendNUIMessage({
		action = 'hide'
	})
end)

Citizen.CreateThread(function()
    local alreadyEnteredZone = false
    local text = nil
    while true do
        wait = 5
        local ped = PlayerPedId()
        local inZone = false
        for cd = 1, #Config.Locations do
            local dist = #(GetEntityCoords(ped)-vector3(Config.Locations[cd].coords.x, Config.Locations[cd].coords.y, Config.Locations[cd].coords.z))
            if dist <= Config.Locations[cd].distance then
                wait = 5
                inZone  = true
                text = Config.Locations[cd].text

                if IsControlJustReleased(0, Config.Locations[cd].key) then
                    TriggerEvent(Config.Locations[cd].eventname)
                end
                break
            else
                wait = 2000
            end
        end

        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
        end

        if inZone and IsPauseMenuActive() then
            TriggerEvent('cd_drawtextui:HideUI')
            alreadyEnteredZone = false
        end

        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            TriggerEvent('cd_drawtextui:HideUI')
        end
        Citizen.Wait(wait)
    end
end)