RegisterNetEvent('carryEntity')
AddEventHandler('carryEntity', function(Context,pEntity)
    TriggerEvent("DoShortHudText","Press E to drop the Entity.")
    -- we can add offsets here later to specific models, right now this is for bikes.
    AttachEntityToEntity(pEntity, PlayerPedId(), 28422, 0.0, 0.3, 0.2, 0.0, 0.0, 90.0, 1, 1, 0, 1, 0, 1)
    local CarryTime = 0
    RequestAnimDict('anim@heists@box_carry@')
    while not HasAnimDictLoaded("anim@heists@box_carry@") do
        Citizen.Wait(0)
    end
    while pEntity ~= 0 and IsEntityAttachedToEntity(pEntity,PlayerPedId()) do
        local ped = PlayerPedId()
        Citizen.Wait(1)
        CarryTime = CarryTime + 1
        CarryEntityAnim()
        if IsControlJustPressed(0,38) then
            CleanEntityAttach(pEntity)
        end
        if AbuseCheck(ped) then
            SetPedToRagdoll(ped, 500, 500, 3, 0, 0, 0)
            CleanEntityAttach(pEntity)
        end
        if CarryTime > (1000*60) then
            TriggerEvent("DoShortHudText","You got tired from carrying the Entity :(")
            CleanEntityAttach(pEntity)
        end
    end
    CleanEntityAttach(pEntity)
end)

function AbuseCheck(ped)
    if 
    IsPedSprinting(ped) or 
    IsPedRunning(ped) or 
    IsPedClimbing(ped) or 
    IsPedJumping(ped) or 
    `WEAPON_UNARMED` ~= GetSelectedPedWeapon(PlayerPedId())  
    then
        return true
    end
    return false
end

function CarryEntityAnim()
    if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
        TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
    end
end

function CleanEntityAttach(pEntity)
    ClearPedTasks(PlayerPedId())
    DetachEntity(pEntity)
    SetVehicleOnGroundProperly(pEntity)
end

