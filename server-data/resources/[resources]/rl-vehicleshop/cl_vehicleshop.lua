local vehshop_blips = {}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false
local vehicle_price = 0
local backlock = false
local firstspawn = 0
local insideVehShop = false
local PlayerData = {}

Citizen.CreateThread(function() 
    while RLCore == nil do
        Citizen.Wait(10)
        TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
    end

    while not RLCore.Functions.GetPlayerData() do
        Wait(1)
    end

    while not RLCore.Functions.GetPlayerData().job do
        Wait(1)
    end

    PlayerData = RLCore.Functions.GetPlayerData()

    ShowVehshopBlips(true)
end)

RegisterNetEvent('RLCore:Client:OnJobUpdate')
AddEventHandler('RLCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
local currentCarSpawnLocation = 0
local ownerMenu = false

local vehshopDefault = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = Config.Menu
}

vehshop = vehshopDefault
local vehshopOwner = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 250, type = 1 },
	menu = Config.Menu
}

local fakecar = {model = '', car = nil}
local vehshop_locations = {
	{
		entering = {-33.737,-1102.322,26.422},
		inside = {-61.166320800781,-1107.8854980469,26.43579864502,76.141090393066},
		outside = {-61.166320800781,-1107.8854980469,26.43579864502,76.141090393066},
	}
}


local inTestDrive = 0
local testDriveTimer = GetGameTimer()

RegisterNetEvent("car:testdrive")
AddEventHandler("car:testdrive", function()
	if (PlayerData.job == nil or PlayerData.job.name ~= 'cardealer') or #(vector3(-51.51, -1077.96, 26.92) - GetEntityCoords(PlayerPedId())) > 50.0 then
		return
    end	
    
    if inTestDrive ~= 0 then
        RLCore.Functions.Notify("You already in test drive!",'error')
        return
    end

	local veh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.000, 0, 70)
    if not DoesEntityExist(veh) then
        RLCore.Functions.Notify("Could not locate vehicle",'error')
		return
	end
	
	local model = GetEntityModel(veh)
	local veh = GetClosestVehicle(-51.51, -1077.96, 26.92, 3.000, 0, 70)

	if not DoesEntityExist(veh) then

		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model,-51.51, -1077.96, 26.92,80.0,true,false)
		local vehplate = "CAR"..math.random(10000,99999) 
		SetVehicleNumberPlateText(veh, vehplate)
        Citizen.Wait(100)
        TriggerEvent("vehiclekeys:client:SetOwner", vehplate, veh)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)

		TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
        inTestDrive = veh
        testDriveTimer = GetGameTimer()
        
        while inTestDrive ~= 0 and DoesEntityExist(inTestDrive) do
            Wait(1)
            if testDriveTimer+Config.TestDriveTimer <= GetGameTimer() then
                local player = FindPlayerBySeat(inTestDrive, -1)
                if player ~= 0 then
                    TriggerServerEvent("veh_shop:requestStopTestDrive", player)
                else
                    TriggerEvent("veh_shop:stopTestDrive")
                end

                break
            else
                Wait(500)
            end
        end

        inTestDrive = 0
	else
        RLCore.Functions.Notify("A car is on the spawn point.")
	end

end)

function FindPlayerBySeat(vehicle, seat)
    local ped = GetPedInVehicleSeat(vehicle, seat)

    if not DoesEntityExist(ped) then
        return 0
    end

    if ped == PlayerPedId() then
        return GetPlayerServerId(PlayerId())
    end

    for j,v in pairs(GetActivePlayers()) do
        if GetPlayerPed(v) == ped then
            return GetPlayerServerId(v)
        end
    end
end

RegisterNetEvent("veh_shop:stopTestDrive")
AddEventHandler("veh_shop:stopTestDrive", function()
    if IsPedInAnyVehicle(PlayerPedId()) then
        local vehicle = GetVehiclePedIsIn(PlayerPedId())
        SetEntityCoords(vehicle, -30.63314, -1090.44, 26.422183)
        Wait(200)
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
    elseif inTestDrive ~= 0 then
        local timer = 2000
        while not NetworkHasControlOfEntity(inTestDrive) and timer > 0 do
            timer = timer - 1
            NetworkRequestControlOfEntity(inTestDrive)
            Wait(1)
        end

        SetEntityCoords(PlayerPedId(), -30.63314, -1090.44, 26.422183)
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(inTestDrive))
    end
end)

RegisterNetEvent("veh_shop:returnTable")
AddEventHandler("veh_shop:returnTable", function(newTable)

	Config.CarTable = newTable
	DespawnSaleVehicles(true)
	SpawnSaleVehicles()

end)

local hasspawned = false

local spawnedvehicles = {}
local vehicles_spawned = false
function BuyMenu()
	for i = 1, #Config.CarSpawns do

		if #(vector3(Config.CarSpawns[i]["x"],Config.CarSpawns[i]["y"],Config.CarSpawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 and PlayerData.job and PlayerData.job.name =='cardealer' then
			if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
				ClearPedTasksImmediately(PlayerPedId())
			end
			DisableControlAction(0,23)
            if IsControlJustReleased(0,47) then
                RLCore.Functions.Notify("Attempting Purchase")
                AttemptBuy(i)
            elseif IsControlJustPressed(0,74) then
                TriggerEvent("car:testdrive")
			end
		end
	end
end

function AttemptBuy(tableid)

	local veh = GetClosestVehicle(Config.CarSpawns[tableid]["x"],Config.CarSpawns[tableid]["y"],Config.CarSpawns[tableid]["z"], 3.000, 0, 70)
	if not DoesEntityExist(veh) then
        RLCore.Functions.Notify("Could not locate vehicle", 'error')
		return
	end

	local model = Config.CarTable[tableid]["model"]
	local costs = Config.CarTable[tableid]["costs"]
	local name = Config.CarTable[tableid]["name"]
	local price = costs

	currentlocation = vehshop_blips[1]
	TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
	TriggerServerEvent('CheckMoneyForVeh',name, model, price)
end

function OwnerMenu()

	if not vehshop.opened then
		currentCarSpawnLocation = 0
		ownerMenu = false
	end
	for i = 1, #Config.CarSpawns do
		if #(vector3(Config.CarSpawns[i]["x"],Config.CarSpawns[i]["y"],Config.CarSpawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.0 then
			ownerMenu = true
			currentCarSpawnLocation = i
			if IsControlJustReleased(0,38) then
                RLCore.Functions.Notify("Vehicle Changed.")
				if vehshop.opened then
					CloseCreator()
				else
					OpenCreator()
				end
			end
		end
	end
end

function DrawPrices()
	for i = 1, #Config.CarSpawns do
        if #(vector3(Config.CarSpawns[i]["x"],Config.CarSpawns[i]["y"],Config.CarSpawns[i]["z"]) - GetEntityCoords(PlayerPedId())) < 2.5 then
            if Config.CarTable[i] and tonumber(Config.CarTable[i]["costs"]) then
                local price = tonumber(Config.CarTable[i]["costs"])
                local veh = GetClosestVehicle(Config.CarSpawns[i]["x"],Config.CarSpawns[i]["y"],Config.CarSpawns[i]["z"], 3.000, 0, 70)
                local addplate = GetVehicleNumberPlateText(veh)
                if (PlayerData.job and PlayerData.job.name == 'cardealer') then
                    DrawText3D(Config.CarSpawns[i]["x"],Config.CarSpawns[i]["y"],Config.CarSpawns[i]["z"],"[" .. Config.CarTable[i]["name"] .. " - $" .. math.ceil(price) .. "] [E] to change | [H] to test drive | [G] to buy. ")
                else
                    DrawText3D(Config.CarSpawns[i]["x"],Config.CarSpawns[i]["y"],Config.CarSpawns[i]["z"], Config.CarTable[i]["name"])
                end
            end
		end
	end
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function SpawnSaleVehicles()
	if not hasspawned then
		TriggerServerEvent("carshop:requesttable")
		print("requesting table")
		Citizen.Wait(1500)
	end
	DespawnSaleVehicles(true)
	hasspawned = true
	for i = 1, #Config.CarTable do
		local model = GetHashKey(Config.CarTable[i]["model"])
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model,Config.CarSpawns[i]["x"],Config.CarSpawns[i]["y"],Config.CarSpawns[i]["z"]-1,Config.CarSpawns[i]["h"],false,false)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)
		SetEntityInvincible(veh,true)

		FreezeEntityPosition(veh,true)
		spawnedvehicles[#spawnedvehicles+1] = veh
		SetVehicleNumberPlateText(veh, i .. "CARSALE")
	end
	vehicles_spawned = true
end

function DespawnSaleVehicles(pDontWait)
	if pDontWait == nil and not pDontWait then
		Wait(15000)
	end
	for i = 1, #spawnedvehicles do
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(spawnedvehicles[i]))
	end
	vehicles_spawned = false
end

--[[Functions]]--

function LocalPed()
	return PlayerPedId()
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function IsPlayerInRangeOfVehshop()
	return inrangeofvehshop
end

function ShowVehshopBlips(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,326)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Vehicle Shop')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, 3)
			vehshop_blips[#vehshop_blips+1]= {blip = blip, pos = loc}
		end
        Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(1)
				local inrange = false

				if #(vector3(-30.63314, -1090.44, 26.422183) - GetEntityCoords(LocalPed())) < 5.0 then
					local veh = GetVehiclePedIsUsing(LocalPed())
					if inTestDrive ~= 0 and inTestDrive == veh then
						DrawText3D(-30.63314, -1090.44, 26.422183,"[E] return vehicle")
						if IsControlJustReleased(0,38) then
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
                            inTestDrive = 0
						end
					end
				end

				for i,b in ipairs(vehshop_blips) do
                    if insideVehShop then
						currentlocation = b
                        if not vehicles_spawned then
							print("attempting spawn of vehs?")
							SpawnSaleVehicles()
						end
						if #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) < 25 then
							DrawPrices()
						end

						DrawMarker(27,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]-0.9,0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,50,0,0,0,0)
						
						if vehshop.opened == false and IsPedInAnyVehicle(LocalPed(), true) == false and #(vector3(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]) - GetEntityCoords(LocalPed())) <= 1 then

							DisplayHelpText('~g~E~s~ to browse')
							
							inrange = true
						end

						if vehshop.opened == true then
							DisplayHelpText('~g~E~s~ or ~g~ENTER~s~ Accepts ~g~Arrows~s~ Move ~g~Backspace~s~ Exit')
						end

						if (PlayerData.job and PlayerData.job.name == 'cardealer') then
							OwnerMenu()
						end

						BuyMenu()
						
					else
						if vehicles_spawned then
							print("attempting despawn of vehs?")
							DespawnSaleVehicles()
						end
						Citizen.Wait(1000)
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		for i,b in ipairs(vehshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		vehshop_blips = {}
	end
end

function f(n)
	return n + 0.0001
end

function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function OpenCreator()
	boughtcar = false
	
	if ownerMenu then
		vehshop = vehshopOwner	
	else
		vehshop = vehshopDefault
	end


	local ped = LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])

	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end

local endingCreator = false
function CloseCreator(name, veh, price)
	Citizen.CreateThread(function()
		if not endingCreator then
			endingCreator = true
			local ped = LocalPed()
			if not boughtcar then
				local pos = currentlocation.pos.entering
				SetEntityCoords(ped,pos[1],pos[2],pos[3])
				FreezeEntityPosition(ped,false)
				SetEntityVisible(ped,true)
			else			
				local name = name	
				local vehicle = veh
				local price = price		
				local veh = GetVehiclePedIsUsing(ped)
				local model = GetEntityModel(veh)
				local colors = table.pack(GetVehicleColours(veh))
				local extra_colors = table.pack(GetVehicleExtraColours(veh))

				local mods = {}
				for i = 0,24 do
					mods[i] = GetVehicleMod(veh,i)
				end
				Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
				local pos = currentlocation.pos.outside

				FreezeEntityPosition(ped,false)
				RequestModel(model)
				while not HasModelLoaded(model) do
					Citizen.Wait(0)
				end
				personalvehicle = CreateVehicle(model,pos[1],pos[2],pos[3],pos[4],true,false)
				SetModelAsNoLongerNeeded(model)

				if name == "rumpo" then
					SetVehicleLivery(personalvehicle,0)
				end

				if name == "taxi" then
					SetVehicleExtra(personalvehicle, 8, 0)
					SetVehicleExtra(personalvehicle, 9, 0)
					SetVehicleExtra(personalvehicle, 5, 1)
				end

				for i,mod in pairs(mods) do
					SetVehicleModKit(personalvehicle,0)
					SetVehicleMod(personalvehicle,i,mod)
				end

				SetVehicleOnGroundProperly(personalvehicle)

				local plate = GetVehicleNumberPlateText(personalvehicle)
				SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
				local id = NetworkGetNetworkIdFromEntity(personalvehicle)
				SetNetworkIdCanMigrate(id, true)
				Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
				SetVehicleColours(personalvehicle,colors[1],colors[2])
				SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
				TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
				SetEntityVisible(ped,true)			
				local primarycolor = colors[1]
				local secondarycolor = colors[2]	
				local pearlescentcolor = extra_colors[1]
                local wheelcolor = extra_colors[2]

                local vehicleProps = RLCore.Functions.GetVehicleProperties(personalvehicle)
                local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(personalvehicle)))
                print(GetVehicleNumberPlateText(personalvehicle))
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(personalvehicle), personalvehicle)
                TriggerServerEvent('veh_shop:setVehicleOwned', vehicleProps, {damage = 10, fuel = 98}, model)

				--TriggerServerEvent('BuyForVeh', name, vehicle, price, personalvehicle)
				DespawnSaleVehicles()
				SpawnSaleVehicles()

			end
			vehshop.opened = false
			vehshop.menu.from = 1
			vehshop.menu.to = 10
			endingCreator = false
		end
	end)
end

RegisterNetEvent("carshop:failedpurchase")
AddEventHandler("carshop:failedpurchase", function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	TaskLeaveVehicle(PlayerPedId(),veh,0)
end)

function drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,51,122,181,220)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,250)
	DrawText(0.255, 0.254)
end

function drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.2, 0.2)
	--SetTextRightJustify(1)
	if selected then
		SetTextColour(250,250,250, 255)
	else
		SetTextColour(0, 0, 0, 255)
		
	end
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 + 0.025, y - menu.height/3 + 0.0002)

	if selected then
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,51,122,181,250)
	else
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255, 255, 255,250) 
	end
end

function drawMenuTitle(txt,x,y)
	local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)

	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,250)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function ButtonSelected(button)
	local ped = PlayerPedId()
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Vehicles" then
			OpenMenu('vehicles')
		elseif btn == "Motorcycles" then
			OpenMenu('motorcycles')
		elseif btn == "Cycles" then
			OpenMenu('cycles')
		elseif btn == "Custom Cars" then
			OpenMenu('customcars')
		elseif btn == "Drifts" then
			OpenMenu('drifts')
		end
	elseif this == "vehicles" then
		if btn == "Sports" then
			OpenMenu('sports')
		elseif btn == "Sedans" then
			OpenMenu('sedans')
		elseif btn == "Job Vehicles" then
			OpenMenu('jobvehicles')
		elseif btn == "Compacts" then
			OpenMenu('compacts')
		elseif btn == "Trucks" then
			OpenMenu('trucks')
		elseif btn == "Coupes" then
			OpenMenu('coupes')
		elseif btn == "Sports Classics" then
			OpenMenu("sportsclassics")
		elseif btn == "Super" then
			OpenMenu('super')
		elseif btn == "Muscle" then
			OpenMenu('muscle')
		elseif btn == "Off-Road" then
			OpenMenu('offroad')
		elseif btn == "SUVs" then
			OpenMenu('suvs')
		elseif btn == "Vans" then
			OpenMenu('vans')
		end

	elseif this == "jobvehicles" or this == "compacts" or this == "coupes" or this == "sedans" or this == "sports" or this == "sportsclassics" or this == "super" or this == "muscle" or this == "offroad" or this == "suvs" or this == "trucks" or this == "vans" or this == "customcars" or this == "cycles" or this == "motorcycles" or this == 'customcars' or this == 'drifts' then

        if ownerMenu then
            TriggerServerEvent("carshop:updateCarTable",currentCarSpawnLocation, button.model,button.costs,button.name)
            Wait(1000)
            if DoesEntityExist(fakecar.car) then
                Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
            end
            fakecar = {model = '', car = nil}
            CloseCreator()
		end
	end
end

function OpenMenu(menu)
	print(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "vehicles" then
		vehshop.lastmenu = "main"
	elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end

function Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		CloseCreator()
	elseif vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "drifts" or vehshop.currentmenu == "customcars" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end
end

function resetscaleform(topspeed,handling,braking,accel,resetscaleform,i)
    scaleform = RequestScaleformMovie(resetscaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

	topspeedc = topspeed / 20
	handlingc = handling / 20
	brakingc = braking / 20
	accelc = accel / 20

    PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
    PushScaleformMovieFunctionParameterString("LOADING")
    PushScaleformMovieFunctionParameterString("Brand New Vehicle")
    PushScaleformMovieFunctionParameterString("MPCarHUD")
    PushScaleformMovieFunctionParameterString("Annis")
    PushScaleformMovieFunctionParameterString("Top Speed")
    PushScaleformMovieFunctionParameterString("Handling")
    PushScaleformMovieFunctionParameterString("Braking")
    PushScaleformMovieFunctionParameterString("Downforce")


	PushScaleformMovieFunctionParameterInt( (20 * i)-1 )
	PushScaleformMovieFunctionParameterInt( (20 * i)-1 )
	PushScaleformMovieFunctionParameterInt( (20 * i)-1 )
    PushScaleformMovieFunctionParameterInt( (20 * i)-1 )

	PopScaleformMovieFunctionVoid()

end


--[[Citizen]]--
function Initialize(scaleform,veh,vehname)

    scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
    PushScaleformMovieFunctionParameterString(vehname)
    PushScaleformMovieFunctionParameterString("Brand New Vehicle")
    PushScaleformMovieFunctionParameterString("MPCarHUD")
    PushScaleformMovieFunctionParameterString("Annis")
    PushScaleformMovieFunctionParameterString("Top Speed")
    PushScaleformMovieFunctionParameterString("Handling")
    PushScaleformMovieFunctionParameterString("Braking")
    PushScaleformMovieFunctionParameterString("Downforce")

	local topspeed = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 4)
    local handling = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock') * 2)
    local braking = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 100)
    local accel = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 100) 

    if topspeed > 100 then
    	topspeed = 100
    end
    if handling > 100 then
    	handling = 100
    end
    if braking > 100 then
    	braking = 100
    end
    if accel > 100 then
    	accel = 100
    end
    Citizen.Trace(topspeed)
    Citizen.Trace(handling)
    Citizen.Trace(braking)
    Citizen.Trace(accel)

    PushScaleformMovieFunctionParameterInt( topspeed )
    PushScaleformMovieFunctionParameterInt( handling )
    PushScaleformMovieFunctionParameterInt( braking )
    PushScaleformMovieFunctionParameterInt( accel )
    PopScaleformMovieFunctionVoid()

    return scaleform
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if PlayerData.job and PlayerData.job.name == "cardealer" then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            local boss = GetDistanceBetweenCoords(pos, Config.Locations['boss'].x, Config.Locations['boss'].y, Config.Locations['boss'].z, true)
            local stash = GetDistanceBetweenCoords(pos, Config.Locations['stash'].x, Config.Locations['stash'].y, Config.Locations['stash'].z, true)

            if boss < 2 and PlayerData.job.isboss then
                DrawText3D(Config.Locations['boss'].x, Config.Locations['boss'].y, Config.Locations['boss'].z, "Press [E] to access boss menu")
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent("bb-bossmenu:server:openMenu")
                end
            end

            
            if stash < 2 then
                DrawText3D(Config.Locations['stash'].x, Config.Locations['stash'].y, Config.Locations['stash'].z, "Press [E] to open stash")
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "cardealer", {
                        maxweight = 4000000,
                        slots = 500,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", "cardealer")
                end
            end
        else
            Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ( IsControlJustPressed(1,38) or IsControlJustPressed(1, 18) ) and IsPlayerInRangeOfVehshop() then
			if vehshop.opened then
				CloseCreator()
			else
				OpenCreator()
			end
		end
		if vehshop.opened then

			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			for i,button in pairs(menu.buttons) do
				local br = button.rank ~= nil and button.rank or 0
				if 10 >= br and i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vehshop.menu.x,y,selected)
					if button.costs ~= nil and ownerMenu then

						drawMenuRight("$"..button.costs,vehshop.menu.x,y,selected)

					end
					y = y + 0.04
					if vehshop.currentmenu == "jobvehicles" or vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" or vehshop.currentmenu == "drifts" or vehshop.currentmenu == "customcars" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end
								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)


								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								SetModelAsNoLongerNeeded(hash)
								local timer = 9000
								while not DoesEntityExist(veh) and timer > 0 do
									timer = timer - 1
									Citizen.Wait(1)
								end
								TriggerEvent("vehsearch:disable",veh)

	


								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, car = veh}

									local topspeed = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 2)
								    local handling = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock') * 2)
								    local braking = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 100)
								    local accel = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 100) 
								
								if button.model == "rumpo" then
									SetVehicleLivery(veh,2)
								end


								-- not sure why it doesnt refresh itself, but blocks need to be set to their maximum 20 40 60 80 100 before a new number is pushed.
								for i = 1, 5 do
								 	scaleform = resetscaleform(topspeed,handling,braking,accel,"mp_car_stats_01",i)
							        x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
							        Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x-1,y+1.8,z+7.0, 0.0, 180.0, 90.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0)
								end

								scaleform = Initialize("mp_car_stats_01",fakecar.car,fakecar.model)
							end
						end
					end
					if selected and ( IsControlJustPressed(1,38) or IsControlJustPressed(1, 18)  ) then
						ButtonSelected(button)
					end
				end
			end

			if DoesEntityExist(fakecar.car) then
				if vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" or  vehshop.currentmenu == "drifts" or vehshop.currentmenu == "customcars"  then
					daz = 6.0
					if fakecar.model == "Chimera" then
						daz = 8.0
					end
					if fakecar.model == "bmx" then
						daz = 8.0
					end
					 x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, daz))
		        	Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 7.0, 7.0, 7.0, 0)
				else
		       		x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 3.0, -1.5, 10.0))
		       		Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x,y,z, 0.0, 180.0, 100.0, 1.0, 1.0, 1.0, 10.0, 10.0, 10.0, 0)		
				end
				TaskWarpPedIntoVehicle(LocalPed(),fakecar.car,-1)
		    end

		end
		if vehshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end

	end
end)

RegisterNetEvent('FinishMoneyCheckForVeh')
AddEventHandler('FinishMoneyCheckForVeh', function(name, vehicle, price)	
	local name = name
	local vehicle = vehicle
	local price = price
	boughtcar = true
	CloseCreator(name, vehicle, price)
end)

RegisterNetEvent('vehshop:spawnVehicle')
AddEventHandler('vehshop:spawnVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = PlayerPedId()
	if playerPed and playerPed ~= -1 then
		RequestModel(car)
		while not HasModelLoaded(car) do
				Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)
		veh = CreateVehicle(car, playerCoords, 0.0, true, false)
		SetModelAsNoLongerNeeded(car)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		SetEntityInvincible(veh, true)
	end
end)

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		RemoveIpl('v_carshowroom')
		RemoveIpl('shutter_open')
		RemoveIpl('shutter_closed')
		RemoveIpl('shr_int')
		RemoveIpl('csr_inMission')
		RequestIpl('v_carshowroom')
		RequestIpl('shr_int')
		RequestIpl('shutter_closed')
		firstspawn = 1
	end
end)

local vehshopLoc = PolyZone:Create({
	vector2(-17.224317550659, -1125.9611816406),
	vector2(-70.010810852051, -1128.2976074219),
	vector2(-76.185691833496, -1127.8470458984),
	vector2(-79.25121307373, -1123.7583007813),
	vector2(-79.670585632324, -1118.4036865234),
	vector2(-59.549613952637, -1063.388671875),
	vector2(-1.2465063333511, -1081.7679443359)
}, {
    name = "veh_shop",
    minZ = 0,
    maxZ = 40.5,
    debugGrid = false,
    gridDivisions = 25
})

local HeadBone = 0x796e;
Citizen.CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local coord = GetPedBoneCoords(plyPed, HeadBone)
        local inPoly = vehshopLoc:isPointInside(coord)
        -- if true, then player just entered zone
        if inPoly and not insideVehShop then
            insideVehShop = true
        elseif not inPoly and insideVehShop then
            insideVehShop = false
        end
        Citizen.Wait(500)
    end
end)
