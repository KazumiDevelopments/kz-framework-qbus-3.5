Teleports = Teleports or {}
Teleports.Locations = {
    [1] = {
        [1] = {x = 3540.74, y = 3675.59, z = 20.99, h = 167.5, r = 1.0},
        [2] = {x = 3540.74, y = 3675.59, z = 28.11, h = 172.5, r = 1.0},
	},
    [2] = {
        [1] = {x = 345.69094, y = -582.5336, z = 28.79684, h = 75.367317, r = 1.0},
        [2] = {x = 327.12, y = -603.88, z = 43.28, h = 336.51, r = 1.0},
	},
    [3] = {
        [1] = {x = 124.29425, y = -1298.866, z = 29.264081, h = 303.54394, r = 1.0},
        [2] = {x = 125.57, y = -1296.88, z = 29.26, h = 115.70, r = 1.0},
    },
    [4] = {
        [1] = {x = 344.26708, y = -586.2727, z = 28.796852, h = 70.23883, r = 1.0},
        [2] = {x = 330.36489, y = -601.2376, z = 43.284057, h = 258.54037, r = 1.0},
	},
    --casino
    [5] = {
        [1] = {x = 935.81481, y = 46.784881, z = 81.095787, h = 70.23883, r = 1.0}, --IN
        [2] = {x = 1089.5623, y = 206.28173, z = -48.99974, h = 258.54037, r = 1.0}, --OUT
	},
    --
    [6] = {
        [1] = {x = 5012.6796, y = -5746.431, z = 15.484437, h = 330.67926, r = 1.0}, --IN
        [2] = {x = 894.82171, y = -3245.875, z = -98.25811, h = 85.518112, r = 1.0}, --OUT
	},
    [7] = {
        [1] = {x = 638.23107, y = 1.8978455, z = 82.786415, h = 70.731811, r = 1.0}, --IN
        [2] = {x = 2155.0029, y = 2920.9733, z = -61.90242, h = 87.584968, r = 1.0}, --OUT
	},
    [8] = {
        [1] = {x = 987.38598, y = 79.541336, z = 80.99059, h = 151.19772, r = 1.0}, --IN
        [2] = {x = 1578.267, y = 254.29321, z = -46.00509, h = 176.49485, r = 1.0}, --OUT
	},
    [9] = {
        [1] = {x = -1913.483, y = -574.1102, z = 11.435138, h = 321.24551, r = 1.0}, --IN
        [2] = {x = -1902.046, y = -572.2636, z = 19.097209, h = 127.36977, r = 1.0}, --OUT
	},
    [10] = {
        [1] = {x = 1119.3762, y = 267.28308, z = -51.04066, h = 351.56387, r = 1.0}, --IN
        [2] = {x = 980.73736, y = 56.600223, z = 116.16417, h = 50.964752, r = 1.0}, --OUT
	},
    [11] = {
        [1] = {x = 964.81066, y = 58.769523, z = 112.5531, h = 59.875156, r = 1.0}, --IN
        [2] = {x = 1085.2998, y = 214.06359, z = -49.20041, h = 138.58779, r = 1.0}, --OUT
	},
    -- TITANIC DOCKS
    --[[ [9] = {
        [1] = {x = 1293.2369, y = -3178.843, z = 5.9064054, h = 70.731811, r = 1.0}, --IN
        [2] = {x = 1315.1135, y = -3233.174, z = 8.579, h = 87.584968, r = 1.0}, --OUT
	}, ]]
}

JustTeleported = false

function DrawText3Ds(x, y, z, text)
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

Citizen.CreateThread(function()
    while true do
        local inRange = false
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)

        for loc,_ in pairs(Teleports.Locations) do
            for k, v in pairs(Teleports.Locations[loc]) do
                local dist = GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true)

                if dist < 2 then
                    inRange = true
                    --DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)

                    if dist < 1 then
                        DrawText3Ds(v.x, v.y, v.z, '[E] to Enter/Exit')
                        if IsControlJustReleased(0, 51) then

                            if v.x == 935.81481 then
                                --TriggerEvent("casino:client:enter")
                                RLCore.Functions.Notify('The casino is closed for the forseable future.')
                            else
                                if k == 1 then
                                    SetEntityCoords(ped, Teleports.Locations[loc][2].x, Teleports.Locations[loc][2].y, Teleports.Locations[loc][2].z)
                                elseif k == 2 then
                                    SetEntityCoords(ped, Teleports.Locations[loc][1].x, Teleports.Locations[loc][1].y, Teleports.Locations[loc][1].z)
                                end 
                            end
                            ResetTeleport()
                        end
                    end
                end
            end
        end

        if not inRange then
            Citizen.Wait(1000)
        end

        Citizen.Wait(3)
    end
end)

ResetTeleport = function()
    SetTimeout(1000, function()
        JustTeleported = false
    end)
end