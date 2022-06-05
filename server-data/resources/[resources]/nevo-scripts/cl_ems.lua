RegisterNetEvent('ems:chatMessage')
AddEventHandler('ems:chatMessage', function(data)
    if not RLCore or not RLCore.Functions.GetPlayerData().job or RLCore.Functions.GetPlayerData().job.name ~= 'ambulance' or not RLCore.Functions.GetPlayerData().job.onduty then
        return
    end

    TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message server" style="background-color: rgba(255, 0, 21, 0.75);"><b>EMS Chat - {0}:</b> {1}</div>',
        args = data
    })
end)