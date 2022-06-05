local ObjectList = {}

RegisterNetEvent('police:client:spawnCone')
AddEventHandler('police:client:spawnCone', function()
    RLCore.Functions.Progressbar("spawn_object", "Placing Cone", 1800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("police:server:spawnObject", "cone")
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "anim@narcotics@trash", "drop_front", 1.0)
        RLCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('police:client:spawnBarier')
AddEventHandler('police:client:spawnBarier', function()
    RLCore.Functions.Progressbar("spawn_object", "Placing Barrier", 1800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("police:server:spawnObject", "barier")
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "anim@narcotics@trash", "drop_front", 1.0)
        RLCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('police:client:spawnSchotten')
AddEventHandler('police:client:spawnSchotten', function()
    RLCore.Functions.Progressbar("spawn_object", "Placing Object", 1800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("police:server:spawnObject", "schotten")
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "anim@narcotics@trash", "drop_front", 1.0)
        RLCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('police:client:spawnGlobalObj')
AddEventHandler('police:client:spawnGlobalObj', function(zlz)
    RLCore.Functions.Progressbar("spawn_object", "Placing Object", 1800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("police:server:spawnObject", zlz)
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "anim@narcotics@trash", "drop_front", 1.0)
        RLCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('police:client:spawnTent')
AddEventHandler('police:client:spawnTent', function()
    RLCore.Functions.Progressbar("spawn_object", "Placing Object", 1800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("police:server:spawnObject", "tent")
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "anim@narcotics@trash", "drop_front", 1.0)
        RLCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('police:client:spawnLight')
AddEventHandler('police:client:spawnLight', function()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    RLCore.Functions.Progressbar("spawn_object", "Placing Object..", 1800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("police:server:spawnObject", "light")
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "anim@narcotics@trash", "drop_front", 1.0)
        RLCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('police:client:deleteObject')
AddEventHandler('police:client:deleteObject', function()
    local objectId, dist = GetClosestPoliceObject()
    if dist < 5.0 then
        RLCore.Functions.Progressbar("remove_object", "Removing Object", 1800, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
            anim = "plant_floor",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(GetPlayerPed(-1), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
            TriggerServerEvent("police:server:deleteObject", objectId)
        end, function() -- Cancel
            StopAnimTask(GetPlayerPed(-1), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
            RLCore.Functions.Notify("Canceled..", "error")
        end)
    end
end)

RegisterNetEvent('police:client:deleteAreaObjects')
AddEventHandler('police:client:deleteAreaObjects', function()
    local areaobjects = GetAreaPoliceObject()
    RLCore.Functions.Progressbar("remove_object", "Removing Objects", 1800, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
        anim = "plant_floor",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
        TriggerServerEvent("police:server:deleteObjects", areaobjects)
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
        RLCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('police:client:removeObject')
AddEventHandler('police:client:removeObject', function(objectId)
    if ObjectList[objectId] then
        if ObjectList[objectId].object then
            NetworkRequestControlOfEntity(ObjectList[objectId].object)
            DeleteObject(ObjectList[objectId].object)
        end
        ObjectList[objectId] = nil
    end
end)

RegisterNetEvent('police:client:removeObjects')
AddEventHandler('police:client:removeObjects', function(objects)
    for _, id in pairs(objects) do
        if ObjectList[id] then
            if ObjectList[id].object then
                NetworkRequestControlOfEntity(ObjectList[id].object)
                DeleteObject(ObjectList[id].object)
            end
            ObjectList[id] = nil
        end
    end
end)

RegisterNetEvent('police:client:spawnObject')
AddEventHandler('police:client:spawnObject', function(objectId, type, player)
    if GetPlayerFromServerId(player) ~= -1 then
        local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player)))
        local heading = GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player)))
        local forward = GetEntityForwardVector(GetPlayerPed(-1))
        local x, y, z = table.unpack(coords + forward * 0.5)
        local spawnedObj = CreateObject(Config.Objects[type].model, x, y, z, false, false, false)
        PlaceObjectOnGroundProperly(spawnedObj)
        SetEntityHeading(spawnedObj, heading)
        FreezeEntityPosition(spawnedObj, Config.Objects[type].freeze)
        ObjectList[objectId] = {
            id = objectId,
            object = spawnedObj,
            coords = {
                x = x,
                y = y,
                z = z - 0.3,
            },
        }
    end
end)

function GetClosestPoliceObject()
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    local current = nil
    local dist = nil

    for id, data in pairs(ObjectList) do
        if current ~= nil then
            if(GetDistanceBetweenCoords(pos, ObjectList[id].coords.x, ObjectList[id].coords.y, ObjectList[id].coords.z, true) < dist)then
                current = id
                dist = GetDistanceBetweenCoords(pos, ObjectList[id].coords.x, ObjectList[id].coords.y, ObjectList[id].coords.z, true)
            end
        else
            dist = GetDistanceBetweenCoords(pos, ObjectList[id].coords.x, ObjectList[id].coords.y, ObjectList[id].coords.z, true)
            current = id
        end
    end
    return current, dist
end

function GetAreaPoliceObject()
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    local objList = {}

    for id, data in pairs(ObjectList) do
        if (GetDistanceBetweenCoords(pos, ObjectList[id].coords.x, ObjectList[id].coords.y, ObjectList[id].coords.z, true) < 10.0) then
            table.insert(objList, id)
        end
    end
    return objList
end

--[[ local SpikeConfig = {
    MaxSpikes = 5
}
local SpawnedSpikes = {}
local spikemodel = "P_ld_stinger_s"
local nearSpikes = false
local spikesSpawned = false
local ClosestSpike = nil

Citizen.CreateThread(function()
    while true do

        if isLoggedIn then
            GetClosestSpike()
        end

        Citizen.Wait(500)
    end
end)

function GetClosestSpike()
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    local current = nil

    for id, data in pairs(SpawnedSpikes) do
        if current ~= nil then
            if(GetDistanceBetweenCoords(pos, SpawnedSpikes[id].coords.x, SpawnedSpikes[id].coords.y, SpawnedSpikes[id].coords.z, true) < dist)then
                current = id
            end
        else
            dist = GetDistanceBetweenCoords(pos, SpawnedSpikes[id].coords.x, SpawnedSpikes[id].coords.y, SpawnedSpikes[id].coords.z, true)
            current = id
        end
    end
    ClosestSpike = current
end ]]

local usingSpikes = false

RegisterNetEvent('police:client:SpawnSpikeStrip')
AddEventHandler('police:client:SpawnSpikeStrip', function()
    SetSpikesOnGround()
end) 

RegisterNetEvent('police:client:RemoveSpikeStrip')
AddEventHandler('police:client:RemoveSpikeStrip', function()
    RemoveSpike2() 
    RLCore.Functions.Notify('Removing spikes...')
end) 


function SetSpikesOnGround()
    x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

    spike = GetHashKey("P_ld_stinger_s")

    RequestModel(spike)
    while not HasModelLoaded(spike) do
      Citizen.Wait(1)
	end
	RLCore.Functions.Notify('Deploying spikes...')
	doAnimation()
	Citizen.Wait(1700)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	usingSpikes = true
	--FreezeEntityPosition(GetPlayerPed(-1), false)
	Citizen.Wait(250)
	local playerheading = GetEntityHeading(GetPlayerPed(-1))
	coords1 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 3, 10, -0.7)
	coords2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -5, -0.5)

	obj1 = CreateObject(spike, coords1['x'], coords1['y'], coords1['z'], true, true, true)
	obj2 = CreateObject(spike, coords2['x'], coords2['y'], coords2['z'], true, true, true)
	obj3 = CreateObject(spike, coords2['x'], coords2['y'], coords2['z'], true, true, true)
	SetEntityHeading(obj1, playerheading)
	SetEntityHeading(obj2, playerheading)
	SetEntityHeading(obj3, playerheading)
	

	AttachEntityToEntity(obj1, GetPlayerPed(-1), 1, 0.0, 4.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
	AttachEntityToEntity(obj2, GetPlayerPed(-1), 1, 0.0, 8.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
	AttachEntityToEntity(obj3, GetPlayerPed(-1), 1, 0.0, 12.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
	
	DetachEntity(obj1, true, true)
	DetachEntity(obj2, true, true)
	DetachEntity(obj3, true, true)

	PlaceObjectOnGroundProperly(obj1)
	PlaceObjectOnGroundProperly(obj2)
	PlaceObjectOnGroundProperly(obj3)
	
	local blip = AddBlipForEntity(obj2)
	SetBlipAsFriendly(blip, true)
	SetBlipSprite(blip, 238)
	BeginTextCommandSetBlipName("STRING");
	AddTextComponentString(tostring("SPIKES"))
	EndTextCommandSetBlipName(blip)
	
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(100)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    local vehCoord = GetEntityCoords(veh)
    if IsPedInAnyVehicle(ped, false) then
	  if DoesObjectOfTypeExistAtCoords(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
         TriggerEvent("spike:die", veh)
         RemoveSpike()
       end
     end
   end
end)

function RemoveSpike()
   local ped = GetPlayerPed(-1)
   local veh = GetVehiclePedIsIn(ped, false)
   local vehCoord = GetEntityCoords(veh)
   if DoesObjectOfTypeExistAtCoords(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
      spike = GetClosestObjectOfType(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), false, false, false)
      SetEntityAsMissionEntity(spike, true, true)
	  DeleteObject(spike)
	  RemoveBlip(blip)
   end
end

function RemoveSpike2()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local pedCoord = GetEntityCoords(ped)
    if DoesObjectOfTypeExistAtCoords(pedCoord["x"], pedCoord["y"], pedCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
       spike = GetClosestObjectOfType(pedCoord["x"], pedCoord["y"], pedCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), false, false, false)
       SetEntityAsMissionEntity(spike, true, true)
       DeleteObject(spike)
       RemoveBlip(blip)
    end
 end

RegisterNetEvent("spike:die")
AddEventHandler("spike:die", function(veh)
	SetVehicleTyreBurst(veh, 0, false, 0.001)
	SetVehicleTyreBurst(veh, 45, false, 0.001)
	Citizen.Wait(40000)
	SetVehicleTyreBurst(veh, 1, false, 0.001)
	SetVehicleTyreBurst(veh, 47, false, 0.001)
	--Citizen.Wait(40000)
	-- SetVehicleTyreBurst(veh, 2, false, 0.001)
	-- Citizen.Wait(40000)
	-- SetVehicleTyreBurst(veh, 3, false, 0.001)
	-- Citizen.Wait(40000)
	-- SetVehicleTyreBurst(veh, 4, false, 0.001)
	-- Citizen.Wait(40000)
	-- SetVehicleTyreBurst(veh, 5, false, 0.001)
end)

function loadAnimDict(dict)
	while(not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
end

function doAnimation()
	local ped 	  = GetPlayerPed(-1)
	local coords  = GetEntityCoords(ped)

	--FreezeEntityPosition(ped, true)
	loadAnimDict("pickup_object")
	TaskPlayAnim(ped, "pickup_object", "pickup_low", 1.0, 1, -1, 33, 0, 0, 0, 0)
end

--[[ RegisterNetEvent('police:client:SyncSpikes')
AddEventHandler('police:client:SyncSpikes', function(table)
    SpawnedSpikes = table
end)

Citizen.CreateThread(function()
    while true do
        if isLoggedIn then
            if ClosestSpike ~= nil then
                local tires = {
                    {bone = "wheel_lf", index = 0},
                    {bone = "wheel_rf", index = 1},
                    {bone = "wheel_lm", index = 2},
                    {bone = "wheel_rm", index = 3},
                    {bone = "wheel_lr", index = 4},
                    {bone = "wheel_rr", index = 5}
                }

                for a = 1, #tires do
                    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                    local tirePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tires[a].bone))
                    local spike = GetClosestObjectOfType(tirePos.x, tirePos.y, tirePos.z, 15.0, GetHashKey(spikemodel), 1, 1, 1)
                    local spikePos = GetEntityCoords(spike, false)
                    local distance = Vdist(tirePos.x, tirePos.y, tirePos.z, spikePos.x, spikePos.y, spikePos.z)

                    if distance < 1.8 then
                        if not IsVehicleTyreBurst(vehicle, tires[a].index, true) or IsVehicleTyreBurst(vehicle, tires[a].index, false) then
                            SetVehicleTyreBurst(vehicle, tires[a].index, false, 1000.0)
                        end
                    end
                end
            end
        end

        Citizen.Wait(3)
    end
end)

Citizen.CreateThread(function()
    while true do
        if isLoggedIn then
            if ClosestSpike ~= nil then
                local ped = GetPlayerPed(-1)
                local pos = GetEntityCoords(ped)
                local dist = GetDistanceBetweenCoords(pos, SpawnedSpikes[ClosestSpike].coords.x, SpawnedSpikes[ClosestSpike].coords.y, SpawnedSpikes[ClosestSpike].coords.z, true)

                if dist < 4 then
                    if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                        if PlayerJob.name == "police" and PlayerJob.onduty then
                            DrawText3D(pos.x, pos.y, pos.z, '[E] Remove spike')
                            if IsControlJustPressed(0, Keys["E"]) then
                                NetworkRegisterEntityAsNetworked(SpawnedSpikes[ClosestSpike].object)
                                NetworkRequestControlOfEntity(SpawnedSpikes[ClosestSpike].object)            
                                SetEntityAsMissionEntity(SpawnedSpikes[ClosestSpike].object)        
                                DeleteEntity(SpawnedSpikes[ClosestSpike].object)
                                table.remove(SpawnedSpikes, ClosestSpike)
                                ClosestSpike = nil
                                TriggerServerEvent('police:server:SyncSpikes', SpawnedSpikes)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(3)
    end
end) ]]