RLCore = nil
local PlayerData = {}
local pedspawned = false

Citizen.CreateThread(function()
	while RLCore == nil do
		TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('RLCore:Client:OnPlayerLoaded')
AddEventHandler('RLCore:Client:OnPlayerLoaded', function(Player)
    PlayerData =  RLCore.Functions.GetPlayerData()
end)

RegisterNetEvent('RLCore:Client:OnJobUpdate')
AddEventHandler('RLCore:Client:OnJobUpdate', function(job)
     PlayerJob = job
end)

 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k, v in pairs(Config.Pedlocation) do
			local pos = GetEntityCoords(PlayerPedId())	
			local dist = #(v.Cords - pos)
			
			if dist < 40 and pedspawned == false then
				TriggerEvent('spawn:ped',v.Cords,v.h)
				pedspawned = true
			end
			if dist >= 35 then
				pedspawned = false
				DeletePed(npc)
			end
		end
	end
end)

RegisterNetEvent('spawn:ped')
AddEventHandler('spawn:ped',function(coords,heading)
	local hash = GetHashKey('ig_trafficwarden')
	if not HasModelLoaded(hash) then
		RequestModel(hash)
		Wait(10)
	end
	while not HasModelLoaded(hash) do 
		Wait(10)
	end

    pedspawned = true
	npc = CreatePed(5, hash, coords, heading, false, false)
	FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
	loadAnimDict("amb@world_human_cop_idles@male@idle_b") 
	while not TaskPlayAnim(npc, "amb@world_human_cop_idles@male@idle_b", "idle_e", 8.0, 1.0, -1, 17, 0, 0, 0, 0) do
	Wait(1000)
	end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

RegisterNetEvent('dox:garage')
AddEventHandler('dox:garage', function(pd)
    local vehicle = pd.vehicle
    local coords = { ['x'] = 458.95, ['y'] = -993.23, ['z'] = 25.377454, ['h'] = 0 }
    RLCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetVehicleNumberPlateText(veh, "GOV"..tostring(math.random(10000, 99999)))
        exports['lj-fuel']:SetFuel(veh, 100.0)
        SetEntityHeading(veh, coords.h)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)     
end) 

RegisterNetEvent('dox:storecar')
AddEventHandler('dox:storecar', function()

    RLCore.Functions.Notify('Vehicle Stored!')
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    DeleteVehicle(car)
    DeleteEntity(car) 
end)



RegisterNetEvent('garage:menu', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Police Garage",
            txt = ""
        },
        {
            id = 2,
            header = "Charger",
            txt = "Police Charger",
            params = {
                event = "dox:garage",
                args = {
                    vehicle = 'npolchar',
                    
                }
            }
        },
        {
            id = 3,
            header = "Crown Vic",
            txt = "Police Crown Vic",
            params = {
                event = "dox:garage",
                args = {
                    vehicle = 'npolvic',
                    
                }
            }
        },
        {
            id = 4,
            header = "Explorer",
            txt = "Police Explorer",
            params = {
                event = "dox:garage",
                args = {
                    vehicle = 'npolexp',
                    
                }
            }
        },
        {
            id = 5,
            header = "Challenger",
            txt = "Pursuit Challenger",
            params = {
                event = "dox:garage",
                args = {
                    vehicle = 'npolchal',
                    
                }
            }
        },
        {
            id = 6,
            header = "Mustang",
            txt = "Pursuit Mustang",
            params = {
                event = "dox:garage",
                args = {
                    vehicle = 'npolstang',
                    
                }
            }
        },
        {
            id = 7,
            header = "Corvette",
            txt = "Pursuit Corvette",
            params = {
                event = "dox:garage",
                args = {
                    vehicle = 'npolvette',
                    
                }
            }
        },
        {
            id = 8,
            header = "Undercover",
            txt = "Tuner Undercover",
            params = {
                event = "dox:garage",
                args = {
                    vehicle = 'npolretinue',
                    
                }
            }
        },
        {
            id = 9, 
            header = "Quad",
            txt = "Ranger Quadbike",
            params = {
                event = "dox:garage",
                args = {
                    vehicle = 'npolblazer',
                    
                }
            }
        },
        {
            id = 10,
            header = "Motobike",
            txt = "Police Bike",
            params = {
                event = "dox:garage",
                args = {
                    vehicle = 'npolmm',
                    
                }
            }
        },
        {
            id = 11,
            header = "Store Vehicle",
            txt = "Store Vehicle Inside Garage",
            params = {
                event = "dox:storecar",
                args = {
                    
                }
            }
        },
        
    })
end)
