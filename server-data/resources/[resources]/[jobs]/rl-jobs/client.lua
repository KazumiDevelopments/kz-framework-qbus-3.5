RLCore = nil
local playerJob, playerData = {}, {}
local isInRun, runJob, taskingRun = false, '', false
local blip, ModuleReady = nil, false

RegisterNetEvent("RLCore:Client:OnJobUpdate")
AddEventHandler("RLCore:Client:OnJobUpdate", function(jobInfo)
	playerJob = jobInfo
	playerData = RLCore.Functions.GetPlayerData()
end)


RegisterNetEvent("rl-job:client:main")
AddEventHandler("rl-job:client:main", function(job)
	if taskingRun then
		return
	end
	
	local randomLocations = math.random(1, #Config.DropOffLocations[job])
	CreateBlip(job, randomLocations)

	taskingRun = true
	local toolong = Config.Jobs[job]['settings'].runtimer * 4200

	while taskingRun do
		Wait(1)
		local plycoords = GetEntityCoords(PlayerPedId())
		local dstcheck = #(plycoords - vector3(Config.DropOffLocations[job][randomLocations]["x"],Config.DropOffLocations[job][randomLocations]["y"],Config.DropOffLocations[job][randomLocations]["z"])) 

		toolong = toolong - 1
		if toolong < 0 then
			TriggerEvent('RLCore:Notify', Config.Jobs[job]['settings'].timedout, "error")
			taskingRun = false
		end

		if dstcheck < 10.0 then
			local crds = Config.DropOffLocations[job][randomLocations]["x"], Config.DropOffLocations[job][randomLocations]["y"], Config.DropOffLocations[job][randomLocations]["z"]
			DrawText3D(Config.DropOffLocations[job][randomLocations]["x"], Config.DropOffLocations[job][randomLocations]["y"], Config.DropOffLocations[job][randomLocations]["z"] + 0.3, Config.Jobs[job]['settings'].dropoff)

			local LocDeliver = vector3(Config.DropOffLocations[job][randomLocations]["x"], Config.DropOffLocations[job][randomLocations]["y"], Config.DropOffLocations[job][randomLocations]["z"])
			if not IsPedInAnyVehicle(PlayerPedId()) and IsControlJustReleased(0,38) then
				Citizen.Wait(1500)
				DoDropOff(LocDeliver)
				taskingRun = false
			end
		end
	end
	DeleteBlip()
end)

Citizen.CreateThread(function()
	TriggerEvent("debug", 'Jobs: Wating for module!', 'normal')

	while RLCore == nil do
		TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)
		Citizen.Wait(200)
	end

	while RLCore.Functions.GetPlayerData() == nil do
		Wait(0)
	end

	while RLCore.Functions.GetPlayerData().job == nil do
		Wait(0)
	end

	playerData = RLCore.Functions.GetPlayerData()
	playerJob = RLCore.Functions.GetPlayerData().job

	TriggerEvent("debug", 'Jobs: Module Ready!', 'normal')
	ModuleReady = true
	
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		local job = Config.Jobs[playerJob.name]
		if job ~= nil then
			local dst_boss = #(GetEntityCoords(playerPed) - job['locations'].boss)
			local dst_cooking = #(GetEntityCoords(playerPed) - job['locations'].cook)
			local dst_packaging = #(GetEntityCoords(playerPed) - job['locations'].packaging)
			local dst_ready = #(GetEntityCoords(playerPed) - job['locations'].ready)
			local dst_shop = #(GetEntityCoords(playerPed) - job['locations'].shop)

			if dst_boss < 1.5 and not isInRun then
				DrawText3D(job['locations'].boss.x, job['locations'].boss.y, job['locations'].boss.z, job['settings'].boss)
				if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
					TriggerServerEvent("bb-bossmenu:server:openMenu")
					Wait(2000)
				end
			end

			if dst_cooking < 1.5 and not isInRun then
				DrawText3D(job['locations'].cook.x, job['locations'].cook.y, job['locations'].cook.z, job['settings'].cooking)
				if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
					Wait(10)
					TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BBQ", 0, true)

					local skillbarAmount, done = math.random(1, 4), true
					for counter = 1, skillbarAmount do
						local finished = exports["rl-taskbarskill"]:taskBar(math.random(1600, 2500), math.random(5, 15))
						if finished ~= 100 then
        	    			done = false
						end
					end

					Wait(7000)
					ClearPedTasks(playerPed)
					if done == true then
						TriggerServerEvent('rl-jobs:server:addItem', job['settings'].food_item, 2)
						RLCore.Functions.Notify(job['settings'].made_items, "success")
					end
				end
            end

			if dst_packaging < 1.5 and not isInRun then
				DrawText3D(job['locations'].packaging.x, job['locations'].packaging.y, job['locations'].packaging.z, job['settings'].packaging) 
				if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
					Wait(10)
					RLCore.Functions.TriggerCallback('rl-jobs:server:getItemCount', function(hasItems)
						if hasItems then
							playerAnim(2)

							local skillbarAmount, done = math.random(1, 4), true
							for counter = 1, skillbarAmount do
								local finished = exports["rl-taskbarskill"]:taskBar(math.random(2000, 2500), math.random(5, 15))
								if finished ~= 100 then
        	    					done = false
								end
							end
						
							Wait(7000)
							ClearPedTasks(playerPed)
							if done == true then
								TriggerServerEvent('rl-jobs:server:removeItem', job['settings'].food_item, 2)
								TriggerServerEvent('rl-jobs:server:addItem', job['settings'].bag_item, 1)
								RLCore.Functions.Notify(job['settings'].packed_items, "success")
							end
						else
							RLCore.Functions.Notify(job['settings'].not_enoght, "error")
						end
					end, job['settings'].food_item, 2)
				end
			end

			if dst_ready < 1.5 and not isInRun then
				DrawText3D(job['locations'].ready.x, job['locations'].ready.y, job['locations'].ready.z, job['settings'].ready)
				if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
					Wait(10)
					RLCore.Functions.Progressbar("rljobs_preparing", job['settings'].preparing, 3000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = false,
					}, {}, {}, {}, function()
						TriggerServerEvent('rl-jobs:server:readyForDelivery', job['name'], job['settings'].bag_item)
					end, function()
						RLCore.Functions.Notify("Failed!", "error")
					end)
				end
            end
			
            if dst_shop < 1.5 and not isInRun then
				DrawText3D(job['locations'].shop.x, job['locations'].shop.y, job['locations'].shop.z, job['settings'].shop)
				if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
                    Wait(10)

                    local shop = {}
                    shop.label = "Main Shop"
                    shop.items = job['shopitems']
                    shop.slots = #job['shopitems']
                    
                    TriggerServerEvent("inventory:server:OpenInventory", "shop", "shop_" .. math.random(111, 9999) , shop)
                end
			end
		end

		for _, job in pairs(Config.Jobs) do
			if not job['settings'].private_deliveries then
				local dst_pickup = #(GetEntityCoords(playerPed) - job['locations'].pickup)
				local dst_cancle = #(GetEntityCoords(playerPed) - job['locations'].cancle)

				if dst_pickup < 1.5 and not isInRun then
					DrawText3D(job['locations'].pickup.x, job['locations'].pickup.y, job['locations'].pickup.z, job['settings'].pickup)
					if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
                        Wait(10)
						TriggerServerEvent('rl-jobs:server:startFromDelivery', job['name'])
					end
				end

				if dst_cancle < 1.5 and isInRun then
					DrawText3D(job['locations'].cancle.x, job['locations'].cancle.y, job['locations'].cancle.z, job['settings'].cancle)
					if not IsPedInAnyVehicle(playerPed) and IsControlJustReleased(0,38) then
						Wait(10)
						TriggerServerEvent('rl-jobs:server:removeItem', job['settings'].bag_item, 1)
						
						isInRun, runJob, taskingRun = false, '', false
					end
				end
			end
		end
    end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()

        if isInRun and runJob then
			if taskingRun then
				Wait(30000)
			else
				TriggerEvent("rl-job:client:main", runJob)
			end
		end
		Wait(0)
    end
end)

function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end

RegisterNetEvent("rl-jobs:client:startDelivery")
AddEventHandler("rl-jobs:client:startDelivery", function(job)
	isInRun = true
	runJob = job
end)

Citizen.CreateThread(function()
	for _, job in pairs(Config.Jobs) do
		local blip = AddBlipForCoord(job['blip'].coords)

		SetBlipSprite (blip, job['blip'].sprite)
		SetBlipDisplay(blip, job['blip'].display)
		SetBlipScale  (blip, job['blip'].scale)
		SetBlipColour (blip, job['blip'].color)
		SetBlipAsShortRange(blip, true)
		
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(job['blip'].name)
		EndTextCommandSetBlipName(blip)
	end
end)

DrawText3D = function(x, y, z, text)
	local onScreen, _x,_y = World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local scale = 0.30
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
	end
end

DrawMarker3D = function(x, y, z)
	DrawMarker(2, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
end

function playerAnim(anim)
	if anim == 1 then
		loadAnimDict("mp_safehouselost@")
		TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
	elseif anim == 2 then
		loadAnimDict("anim@amb@business@cfm@cfm_drying_notes@")
		TaskPlayAnim( PlayerPedId(), "anim@amb@business@cfm@cfm_drying_notes@", "loading_v3_worker", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
	elseif anim == 3 then
		loadAnimDict("timetable@jimmy@doorknock@")
    	TaskPlayAnim(PlayerPedId(), "timetable@jimmy@doorknock@", "knockdoor_idle", 8.0, 8.0, -1, 4, 0, 0, 0, 0 )
	end
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded( dict )) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

function CreateBlip(job, rndLocation)
	if isInRun then
		blip = AddBlipForCoord(Config.DropOffLocations[job][rndLocation]["x"],Config.DropOffLocations[job][rndLocation]["y"],Config.DropOffLocations[job][rndLocation]["z"])
	end
    
	SetBlipSprite(blip, Config.DropOff.Sprite)
	SetBlipColour(blip, Config.DropOff.Color)
    SetBlipScale(blip, Config.DropOff.Scale)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.DropOff.Name)
    EndTextCommandSetBlipName(blip)
end

function DoDropOff(Location)
	Wait(10)
	playerAnim(3)
	Wait(3000)
	ClearPedTasks(PlayerPedId())
	playerAnim(1)
	DeleteBlip()
	
	Citizen.Wait(2000)
	TriggerServerEvent("rl-jobs:server:dropoff", runJob)
	isInRun, runJob = false, ''
end
