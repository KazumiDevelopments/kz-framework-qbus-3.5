local carorder = {
    [1] = {name = 'POLVIC2', x = 425.5407, y = -976.1185, z = 25.699813, h = 271.07153, handel = nil},
    [2] = {name = 'POLTAURUS', x = 425.5407, y = -978.8673, z = 25.699813, h = 271.07153, handel = nil},
    [3] = {name = 'POLCHAR', x = 425.5407, y = -981.5893, z = 25.699813, h = 271.07153, handel = nil},
    [4] = {name = '18CHGRLEO', x = 425.4165, y = -984.346, z = 25.699813, h = 271.07153, handel = nil},
    [5] = {name = '2015POLSTANG', x = 425.4539, y = -989.0507, z = 25.699813, h = 271.07153, handel = nil},

    [6] = {name = 'EXPLEO', x = 425.68551, y = -991.8132, z = 25.699806, h = 271.07153, handel = nil},
    [7] = {name = 'TRHAWK', x = 425.72311, y = -994.5032, z = 25.699806, h = 271.07153, handel = nil},
    [8] = {name = 'TAHOE', x = 425.74923, y = -997.1234, z = 25.699813, h = 271.07153, handel = nil},

}

local parking = {
    pullout = {x = 431.25741, y = -990.1937, z = 25.287361, h = 178.50997},
    putaway = {x = 452.40509, y = -991.1527, z = 25.287998, h = 359.06387},
    gaycar = nil,
    here = false,
}

RLCore = nil

Citizen.CreateThread(function()
    while RLCore == nil do
		TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
		Citizen.Wait(10)
    end
    while true do
        local ppos = GetEntityCoords(PlayerPedId(), false)
        local dist1 = GetDistanceBetweenCoords(parking.putaway.x, parking.putaway.y, parking.putaway.z, ppos.x, ppos.y, ppos.z, true)
        local dist2 = GetDistanceBetweenCoords(parking.pullout.x, parking.pullout.y, parking.pullout.z, ppos.x, ppos.y, ppos.z, true)
        if dist1 <= 7.5 and IsPedInAnyVehicle(PlayerPedId(), false) then
            DrawMarker(2, parking.putaway.x, parking.putaway.y, parking.putaway.z + 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
            if IsControlJustPressed(0, 38) and dist1 <= 1.5 then
                parking.gaycar = GetVehiclePedIsIn(PlayerPedId(), false)
                TaskLeaveVehicle(PlayerPedId(), parking.gaycar, 64)
                Citizen.Wait(2000)
                DeleteEntity(parking.gaycar)
            end
        end
        for k, v in pairs(carorder) do
            if DoesEntityExist(v.handel) then
                parking.here = true
                local cpos = GetEntityCoords(v.handel, false)
                local dist2 = GetDistanceBetweenCoords(cpos.x + 2.5, cpos.y, cpos.z + 0.5, ppos.x, ppos.y, ppos.z, true)
                if dist2 <= 1 then
                    DrawText3Ds(cpos.x + 2.5, cpos.y, cpos.z + 0.5, 'Press [E] To Drive!')
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent('rl:police:garage:jobcheck', v.name)
                    end
                end
                if dist2 > 100 then
                    if parking.here then
                        DeSpawnCars(v)
                    else
                        parking.here = false
                    end
                end
            else
                parking.here = false
                while not HasModelLoaded(GetHashKey(v.name)) do
                    RequestModel(GetHashKey(v.name))
                    Wait(1)
                end
                if dist2 <= 50 then
                    Citizen.Wait(1000)
                    SpawnCars(v)
                end
            end
        end
        Citizen.Wait(0)
    end
end)

function DrawText3Ds(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x,y,z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

function SpawnCars(v)
    v.handel = CreateVehicle(GetHashKey(v.name), v.x, v.y, v.z, v.h, false, true)
    SetModelAsNoLongerNeeded(GetHashKey(v.name))
    SetVehicleOnGroundProperly(v.handel)
    SetEntityInvincible(v.handel, true)
    FreezeEntityPosition(v.handel, true)
    SetVehicleDoorsLocked(v.handel, 2)
    SetVehicleLivery(v.handel, 1)
    print('spawned '.. v.name ..'!')
end

function DeSpawnCars(v)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(v.handel))
    print('cleaned '.. v.name ..'!')
end

RegisterNetEvent('rl:police:garage:jobcheck:back')
AddEventHandler('rl:police:garage:jobcheck:back', function(name, can)
    if can == 1 then
        local v = CreateVehicle(GetHashKey(name), parking.pullout.x, parking.pullout.y, parking.pullout.z, parking.pullout.h, true, true)
        SetPedIntoVehicle(PlayerPedId(), v, -1)
        exports['lj-fuel']:SetFuel(v, 100)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(v), v)
    elseif can == 2 then
        RLCore.Functions.Notify("Your Too Low Of A Rank To Drive This!", "error")
    elseif can == 3 then
        RLCore.Functions.Notify("Your Not A Police Officer!", "error")
    end
end)


