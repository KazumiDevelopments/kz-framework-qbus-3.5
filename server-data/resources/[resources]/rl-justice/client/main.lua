RLCore = nil

Citizen.CreateThread(function()
    while RLCore == nil do
        TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
        Citizen.Wait(200)
    end 
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(245.05134, -387.3223, 44.866054)
	SetBlipSprite(blip, 58)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.7)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Los Santos Courthouse")
    EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent("rl-justice:client:showLawyerLicense")
AddEventHandler("rl-justice:client:showLawyerLicense", function(sourceId, data)
    local sourcePos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(sourceId)), false)
    local pos = GetEntityCoords(GetPlayerPed(-1), false)
    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, sourcePos.x, sourcePos.y, sourcePos.z, true) < 2.0) then
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message advert"><div class="chat-message-body"><strong>{0}:</strong><br><br> <strong>No-ID:</strong> {1} <br><strong>First Name:</strong> {2} <br><strong>Last name:</strong> {3} <br><strong>BSN:</strong> {4} </div></div>',
            args = {'Lawyer card', data.id, data.firstname, data.lastname, data.citizenid}
        })

        TriggerEvent("debug", 'Licenses: Show Lawyer', 'success')
    end
end)

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end