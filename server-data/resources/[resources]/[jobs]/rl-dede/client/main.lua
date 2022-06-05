RLCore = nil
Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if RLCore == nil then
            TriggerEvent("RLCore:GetObject", function(obj) RLCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

local playerJob, playerData = {}, {}
local htmlString, lasthtmlString = "", ""
RegisterNetEvent("RLCore:Client:OnJobUpdate")
AddEventHandler("RLCore:Client:OnJobUpdate", function(jobInfo)
	playerJob = jobInfo
	playerData = RLCore.Functions.GetPlayerData()
end)

CreateThread(function()
    while RLCore == nil do Wait(0) end
    while RLCore.Functions.GetPlayerData() == nil do Wait(0) end
	while RLCore.Functions.GetPlayerData().job == nil do Wait(0) end

	playerData = RLCore.Functions.GetPlayerData()
	playerJob = RLCore.Functions.GetPlayerData().job
    StoreBlip = AddBlipForCoord(29.285978, -1345.748, 29.49702)
    SetBlipSprite(StoreBlip, 52)
    SetBlipScale(StoreBlip, 0.7)
    SetBlipColour(StoreBlip, 1)
    SetBlipDisplay(StoreBlip, 4)
    SetBlipAsShortRange(StoreBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName('Dede Supermarket')
    EndTextCommandSetBlipName(StoreBlip)

    while true do
        local PlayerPed = GetPlayerPed(-1)
        local PlayerPos = GetEntityCoords(PlayerPed)
        local InRange = false
        local htmlString = ""

        for shop, data in pairs(Config.Locations['shops']) do
            local position = Config.Locations['shops'][shop]["coords"]
            
            for _, loc in pairs(data["coords"]) do
                local dst = #(loc - PlayerPos)
                if dst < 4.0 then
                    InRange = true
                    
                    if dst < 1.0 then
                        local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(loc.x, loc.y, loc.z)
                        htmlString = htmlString .. "<span style=\"position: absolute; left: ".. xxx * 100 .."%;top: ".. yyy * 100 .."%;\"><img \" width=\"100px\" height=\"100px\" src=\"".. shop ..".png\"></img></span>"
                        if IsControlJustPressed(0, Config.Keys["E"]) then
                            local ShopItems = {}
                            ShopItems.label = data["label"]
                            ShopItems.items = data["products"]
                            ShopItems.slots = 30
                            TriggerServerEvent("inventory:server:OpenInventory", "dede", "Dedeshop_" .. shop, ShopItems)
                        end
                    else
                        local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(loc.x, loc.y, loc.z)
                        local size = 100 / (dst * 1.5)
                        htmlString = htmlString .. "<span style=\"position: absolute; left: ".. xxx * 100 .."%;top: ".. yyy * 100 .."%;\"><img \" width=\"" .. size .. "px\" height=\"" .. size .. "px\" src=\"".. shop ..".png\"></img></span>"
                    end
                end
            end
        end

        
        if playerJob.name == 'dedeshop' then
			local dst_boss = #(PlayerPos - Config.Locations['job']['boss'])
			local dst_stash = #(PlayerPos - Config.Locations['job']['stash'])
            local dst_vendings = #(PlayerPos - Config.Locations['job']['vendings'])
            
			if playerJob.isboss then
                if dst_boss < 1.5 then
                    InRange = true
					DrawText3D(Config.Locations['job']['boss'].x, Config.Locations['job']['boss'].y, Config.Locations['job']['boss'].z, '~b~[E]~w~ Boss Menu ~r~[Boss Only]')
					if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
						TriggerServerEvent("bb-bossmenu:server:openMenu")
						Wait(2000)
					end
                end
                
                if dst_vendings < 1.5 then
                    InRange = true
					DrawText3D(Config.Locations['job']['vendings'].x, Config.Locations['job']['vendings'].y, Config.Locations['job']['vendings'].z, '~b~[E]~w~ Vendings Menu ~r~[Boss Only]')
					if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
						TriggerServerEvent("bb-bossmenu:server:openMenu")
						Wait(2000)
					end
				end
			end

            if dst_stash < 1.5 then
                InRange = true
				DrawText3D(Config.Locations['job']['stash'].x, Config.Locations['job']['stash'].y, Config.Locations['job']['stash'].z, '~b~[E]~w~ Stash')
				if not IsPedInAnyVehicle(playerPed) and IsControlJustPressed(0, 38) then
					TriggerServerEvent("inventory:server:OpenInventory", "stash", "dedeshop", {
						maxweight = 4000000,
						slots = 500,
					})
				
					TriggerEvent("inventory:client:SetCurrentStash", "dedeshop")
				end
			end
		end

        if lasthtmlString ~= htmlString then
            SendNUIMessage({ html = htmlString })
            lasthtmlString = htmlString
        end

        if not InRange then
            Citizen.Wait(250)
        end
        Citizen.Wait(3)
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