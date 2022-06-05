Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local NitrousActivated = false
local NitrousBoost = 35.0
local ScreenEffect = false
local NosFlames = nil
VehicleNitrous = {}
Fxs = {}

RLCore = nil
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

CreateThread(function()
    while not RLCore do Wait(0) end
    RLCore.Functions.TriggerCallback('nitrous:GetNosLoadedVehs', function(vehs)
        VehicleNitrous = vehs
    end)
end)

RegisterNetEvent('smallresource:client:LoadNitrous')
AddEventHandler('smallresource:client:LoadNitrous', function()
    local IsInVehicle = IsPedInAnyVehicle(GetPlayerPed(-1))
    local ped = GetPlayerPed(-1)

    if not NitrousActivated then
        if IsInVehicle and not IsThisModelABike(GetEntityModel(GetVehiclePedIsIn(ped))) then
            local CurrentVehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
            FreezeEntityPosition(CurrentVehicle, true)
            RLCore.Functions.Progressbar("nitrossz", "Nitrous", 20000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerServerEvent('removenitro')
                FreezeEntityPosition(CurrentVehicle, false)
                local Plate = GetVehicleNumberPlateText(CurrentVehicle)
                TriggerServerEvent('nitrous:server:LoadNitrous', Plate)
            end, function()
                RLCore.Functions.Notify("Failed!", "error")
            end)
        else
			RLCore.Functions.Notify("No vehicle nearby.", "error")
        end
    else
		RLCore.Functions.Notify("No Active NOS.", "error")
    end
end)

local nosupdated = false
local useTimeout = 0

Citizen.CreateThread(function()
    while true do
        local IsInVehicle = IsPedInAnyVehicle(GetPlayerPed(-1))
        local CurrentVehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
        if IsInVehicle then
            local Plate = GetVehicleNumberPlateText(CurrentVehicle)
            if VehicleNitrous[Plate] ~= nil then
                if VehicleNitrous[Plate].hasnitro then
                    if IsControlJustPressed(0, Keys["LEFTSHIFT"]) and NitrousActivated == false then
                        if GetGameTimer() > useTimeout then
                            local speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6
                            SetVehicleEnginePowerMultiplier(CurrentVehicle, NitrousBoost)
                            SetVehicleEngineTorqueMultiplier(CurrentVehicle, NitrousBoost)
                            NitrousActivated = true
                            if VehicleNitrous[Plate].level > 12 then
                                count = 0
                                while count < 90 do
                                    --StartScreenEffect("ExplosionJosh3", 30.0, 0) 
                                    VehicleNitrous[Plate].level = VehicleNitrous[Plate].level - 7
                                    TriggerServerEvent('nitrous:server:UpdateNitroLevel', Plate, (VehicleNitrous[Plate].level))
                                    TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,  VehicleNitrous[Plate].level, true)
                                    Citizen.Wait(1000)
                                    count = count + 30
                                end
                            else
                                --StartScreenEffect("ExplosionJosh3", 30.0, 0) 
                                VehicleNitrous[Plate].level = VehicleNitrous[Plate].level - 7
                                TriggerServerEvent('nitrous:server:UpdateNitroLevel', Plate, (VehicleNitrous[Plate].level))
                                TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,  VehicleNitrous[Plate].level, true)
                            end
                            
                            --StartScreenEffect("ExplosionJosh3", 0, 0)

                            if VehicleNitrous[Plate].level - 12 >= 0 then
                                VehicleNitrous[Plate].level = VehicleNitrous[Plate].level - 12
                                TriggerServerEvent('nitrous:server:UpdateNitroLevel', Plate, (VehicleNitrous[Plate].level))
                                --TriggerEvent('rl-hud:nitro', VehicleNitrous[Plate].level)
                                TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,  VehicleNitrous[Plate].level, true)
                                NitrousActivated = false

                                for index,_ in pairs(Fxs) do
                                    StopParticleFxLooped(Fxs[index], 1)
                                    TriggerServerEvent('nitrous:server:StopSync', GetVehicleNumberPlateText(CurrentVehicle))
                                    Fxs[index] = nil
                                end
                            else
                                Wait(250) -- Otherwise it depletes instantly, as line 107, has no wait, so this is stopped, as soon as it is started.
                                TriggerServerEvent('nitrous:server:UnloadNitrous', Plate)
                                NitrousActivated = false
                                TriggerEvent('hud:client:UpdateNitrous', false, nil, false)
                                SetVehicleBoostActive(CurrentVehicle, 0)
                                SetVehicleEnginePowerMultiplier(CurrentVehicle, LastEngineMultiplier)
                                SetVehicleEngineTorqueMultiplier(CurrentVehicle, 1.0)
                                StopScreenEffect("RaceTurbo")
                                ScreenEffect = false
                                for index,_ in pairs(Fxs) do
                                    StopParticleFxLooped(Fxs[index], 1)
                                    TriggerServerEvent('nitrous:server:StopSync', GetVehicleNumberPlateText(CurrentVehicle))
                                    Fxs[index] = nil
                                end
                            end
                            useTimeout = GetGameTimer() + 15000
                        else
                            RLCore.Functions.Notify("Rebuilding bottle pressure - Wait 15 seconds!")
                        end
                    end
                end
            else
                if not nosupdated then
                    TriggerEvent('hud:client:UpdateNitrous', false, nil, false)
                    nosupdated = true
                end
            end
        else
            if nosupdated then
                nosupdated = false
            end
            Citizen.Wait(1500)
        end
        Citizen.Wait(3)
    end
end)

p_flame_location = {
	"exhaust",
	"exhaust_2",
	"exhaust_3",
	"exhaust_4",
	"exhaust_5",
	"exhaust_6",
	"exhaust_7",
	"exhaust_8",
	"exhaust_9",
	"exhaust_10",
	"exhaust_11",
	"exhaust_12",
	"exhaust_13",
	"exhaust_14",
	"exhaust_15",
	"exhaust_16",
}

local bonesindex = {
    "chassis",
    "windscreen",
    "seat_pside_r",
    "seat_dside_r",
    "bodyshell",
    "suspension_lm",
    "suspension_lr",
    "platelight",
    "attach_female",
    "attach_male",
    "bonnet",
    "boot",
    "chassis_dummy",
    "chassis_Control",
    "door_dside_f",
    "door_dside_r",
    "door_pside_f",
    "door_pside_r",
    "Gun_GripR",
    "windscreen_f",
    "platelight",
    "VFX_Emitter",
    "window_lf",
    "window_lr",
    "window_rf",
    "window_rr",
    "engine",
    "gun_ammo",
    "ROPE_ATTATCH",
    "wheel_lf",
    "wheel_lr",
    "wheel_rf",
    "wheel_rr",
    "exhaust",
    "overheat",
    "misc_e",
    "seat_dside_f",
    "seat_pside_f",
    "Gun_Nuzzle",
    "seat_r",
}

ParticleDict = "veh_xs_vehicle_mods"
ParticleFx = "veh_nitrous"
ParticleSize = 1.4

Citizen.CreateThread(function()
    while true do
        if NitrousActivated == true then
            local veh = GetVehiclePedIsIn(GetPlayerPed(-1))
            TriggerServerEvent('nitrous:server:SyncFlames', VehToNet(veh))
            SetVehicleBoostActive(veh, 1)

            for _,bones in pairs(p_flame_location) do
                if GetEntityBoneIndexByName(veh, bones) ~= -1 then
                    if Fxs[bones] == nil then
                        RequestNamedPtfxAsset(ParticleDict)
                        while not HasNamedPtfxAssetLoaded(ParticleDict) do
                            Citizen.Wait(0)
                        end
                        SetPtfxAssetNextCall(ParticleDict)
                        UseParticleFxAssetNextCall(ParticleDict)
                        Fxs[bones] = StartParticleFxLoopedOnEntityBone(ParticleFx, veh, 0.0, -0.02, 0.0, 0.0, 0.0, 0.0, GetEntityBoneIndexByName(veh, bones), ParticleSize, 0.0, 0.0, 0.0)
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)

local NOSPFX = {}

RegisterNetEvent('nitrous:client:SyncFlames')
AddEventHandler('nitrous:client:SyncFlames', function(netid, nosid)
    local veh = NetToVeh(netid)
    local myid = GetPlayerServerId(PlayerId())
    if NOSPFX[GetVehicleNumberPlateText(veh)] == nil then
        NOSPFX[GetVehicleNumberPlateText(veh)] = {}
    end
    if myid ~= nosid then
        for _,bones in pairs(p_flame_location) do
            if NOSPFX[GetVehicleNumberPlateText(veh)][bones] == nil then
                NOSPFX[GetVehicleNumberPlateText(veh)][bones] = {}
            end
            if GetEntityBoneIndexByName(veh, bones) ~= -1 then
                if NOSPFX[GetVehicleNumberPlateText(veh)][bones].pfx == nil then
                    RequestNamedPtfxAsset(ParticleDict)
                    while not HasNamedPtfxAssetLoaded(ParticleDict) do
                        Citizen.Wait(0)
                    end
                    SetPtfxAssetNextCall(ParticleDict)
                    UseParticleFxAssetNextCall(ParticleDict)
                    NOSPFX[GetVehicleNumberPlateText(veh)][bones].pfx = StartParticleFxLoopedOnEntityBone(ParticleFx, veh, 0.0, -0.05, 0.0, 0.0, 0.0, 0.0, GetEntityBoneIndexByName(veh, bones), ParticleSize, 0.0, 0.0, 0.0)
                end
            end
        end
    end
end)

RegisterNetEvent('nitrous:client:fillVehicle')
AddEventHandler('nitrous:client:fillVehicle', function(plate)
    local IsInVehicle = IsPedInAnyVehicle(GetPlayerPed(-1))
    local ped = GetPlayerPed(-1)

    if not NitrousActivated then
        if IsInVehicle and not IsThisModelABike(GetEntityModel(GetVehiclePedIsIn(ped))) then
            local CurrentVehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
            local Plate = GetVehicleNumberPlateText(CurrentVehicle)
            TriggerServerEvent('nitrous:server:LoadNitrous', Plate)
        else
            RLCore.Functions.Notify("No vehicle nearby.", "error")
        end
    else
        RLCore.Functions.Notify("No Active NOS.", "error")
    end
end)

RegisterNetEvent('nitrous:client:StopSync')
AddEventHandler('nitrous:client:StopSync', function(plate)
    for k, v in pairs(NOSPFX[plate]) do
        StopParticleFxLooped(v.pfx, 1)
        NOSPFX[plate][k].pfx = nil
    end
end)

RegisterNetEvent('nitrous:client:UpdateNitroLevel')
AddEventHandler('nitrous:client:UpdateNitroLevel', function(Plate, level)
    VehicleNitrous[Plate].level = level
end)

RegisterNetEvent('nitrous:client:LoadNitrous')
AddEventHandler('nitrous:client:LoadNitrous', function(Plate)
    VehicleNitrous[Plate] = {
        hasnitro = true,
        level = 100,
    }
    local IsInVehicle = IsPedInAnyVehicle(GetPlayerPed(-1))
    local CurrentVehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
    local CPlate = GetVehicleNumberPlateText(CurrentVehicle)
    if CPlate == Plate then
        TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,  VehicleNitrous[Plate].level, false)
    end
end)

RegisterNetEvent('nitrous:client:UnloadNitrous')
AddEventHandler('nitrous:client:UnloadNitrous', function(Plate)
    VehicleNitrous[Plate] = nil
    
    local CurrentVehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
    local CPlate = GetVehicleNumberPlateText(CurrentVehicle)
    if CPlate == Plate then
        NitrousActivated = false
        TriggerEvent('hud:client:UpdateNitrous', false, nil, false)
    end
end)