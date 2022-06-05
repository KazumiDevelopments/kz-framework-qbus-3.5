local steamIds = {
    ["steam:11000010aa15521"] = true --kevin
}

--[[ local ESX = nil
-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
 ]]
RegisterServerEvent('urp-doors:alterlockstate2')
AddEventHandler('urp-doors:alterlockstate2', function()
    --URP.DoorCoords[10]["lock"] = 0

    TriggerClientEvent('urp-doors:alterlockstateclient', source, URP.DoorCoords)

end)

RegisterServerEvent('urp-doors:alterlockstate')
AddEventHandler('urp-doors:alterlockstate', function(alterNum)
    print('lockstate:', alterNum)
    URP.alterState(alterNum)
end)

RegisterServerEvent('urp-doors:ForceLockState')
AddEventHandler('urp-doors:ForceLockState', function(alterNum, state)
    URP.DoorCoords[alterNum]["lock"] = state
    TriggerClientEvent('esx:Door:alterState', -1,alterNum,state)
end)

RegisterServerEvent('urp-doors:requestlatest')
AddEventHandler('urp-doors:requestlatest', function()
    local src = source 
    local steamcheck = ESX.GetPlayerFromId(source).identifier
    if steamIds[steamcheck] then
        TriggerClientEvent('doors:HasKeys',src,true)
    end
    TriggerClientEvent('urp-doors:alterlockstateclient', source,URP.DoorCoords)
end)

function isDoorLocked(door)
    if URP.DoorCoords[door].lock == 1 then
        return true
    else 
        return false
    end
end