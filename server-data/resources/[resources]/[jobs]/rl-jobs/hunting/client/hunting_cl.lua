Keys = {
	['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
	['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
	['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
	['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
	['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
	['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
	['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
	['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

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

Notify = "RLCore:Notify"

Inventory = 'inventory:client:ItemBox'


AnimalPositions = {
	{ x = -1505.2, y = 4887.39, z = 78.38 },
	{ x = -1164.68, y = 4806.76, z = 223.11 },
	{ x = -1410.63, y = 4730.94, z = 44.0369 },
	{ x = -1377.29, y = 4864.31, z = 134.162 },
	{ x = -1697.63, y = 4652.71, z = 22.2442 },
	{ x = -1259.99, y = 5002.75, z = 151.36 },
	{ x = -960.91, y = 5001.16, z = 183.0 },
}

Positions = {
	['StartHunting'] = { ['hint'] = '[E] Start Hunting', ['x'] = -769.23773193359, ['y'] = 5595.6215820313, ['z'] = 33.48571395874 },
	['Sell'] = { ['hint'] = '[E] Sell', ['x'] = 959.62, ['y'] = -1991.8, ['z'] = 30.23 },
}

RegisterNetEvent('RLCore:Client:OnPlayerLoaded')
AddEventHandler('RLCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    Citizen.Wait(1000)
    ScriptLoaded()
end)

RegisterCommand( "gg", function()
    ScriptLoaded()
    StartHuntingSession()
    SellItems()
end ) 



function DrawText3D2(x, y, z, text)
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

function ScriptLoaded()
    print("LOADED")
    Citizen.Wait(1000)
    LoadMarkers()
end

local AnimalsInSession = {}
local OnGoingHuntSession = false
local HuntCar = nil

function LoadMarkers()

	Citizen.CreateThread(function()
		for index, v in ipairs(Positions) do
			if index ~= 'SpawnATV' then
				local StartBlip = AddBlipForCoord(v.x, v.y, v.z)
				SetBlipSprite(StartBlip, 442)
				SetBlipColour(StartBlip, 75)
				SetBlipScale(StartBlip, 0.7)
				SetBlipAsShortRange(StartBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Hunting Spot')
				EndTextCommandSetBlipName(StartBlip)
			end
		end
	end)

    LoadModel('blazer')
    LoadModel('a_c_deer')
    LoadAnimDict('amb@medic@standing@kneel@base')
    LoadAnimDict('anim@gangops@facility@servers@bodysearch@')

    Citizen.CreateThread(function()
        while true do 
            local sleep = 500

            local plyCoords = GetEntityCoords(PlayerPedId())

            for index, value in pairs(Positions) do 
                if value.hint ~= nil then 

                    if OnGoingHuntSession and index == 'StartHunting' then 
                        value.hint = ' [E] Stop Hunting'
                    elseif not OnGoingHuntSession and index == 'StartHunting' then 
                        value.hint = ' [E] Start Hunting'
                    end 

                    local distance = GetDistanceBetweenCoords(plyCoords, value.x, value.y, value.z, true)

                    if distance < 5.0 then 
                        sleep = 5
                        DrawM(value.hint, 27, value.x, value.y, value.z-0.945, 255, 255, 255, 1.5, 15)
                        if distance < 1.0 then 
                            if IsControlJustReleased(0, Keys['E']) then 
                                if index == 'StartHunting' then 
                                    StartHuntingSession()
                                else 
                                    SellItems()
                                end 
                            end 
                        end 
                    end
                
                end
            end
            Citizen.Wait(sleep)
        end 
    end)
end

function StartHuntingSession()
    if OnGoingHuntSession then 
        RLCore.Functions.Notify("You Stopped Hunting", "error")

        OnGoingHuntSession = false 

        --RemoveItem()


        for index, value in pairs(AnimalsInSession) do 
            if DoesEntityExist(value.id) then 
                DeleteEntity(value.id)
            end
        end 
    else 
        RLCore.Functions.Notify("You Started Hunting", "success")

        OnGoingHuntSession = true 

        --GiveItem()

        -- Animals
        Citizen.CreateThread(function()

            for index, value in pairs(AnimalPositions) do 
				local Animal = CreatePed(5, GetHashKey('a_c_deer'), value.x, value.y, value.z, 0.0, true, false)
				SetEntityAsMissionEntity(Animal, true, true)
				SetEntityAsMissionEntity(Animal, true, true)
				--Blips
				local AnimalBlip = AddBlipForEntity(Animal)
				SetBlipSprite(AnimalBlip, 153)
				SetBlipColour(AnimalBlip, 1)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Deer - Animal')
				EndTextCommandSetBlipName(AnimalBlip)

                table.insert(AnimalsInSession, {id = Animal, x = value.x, y = value.y, z = value.z, Blipid = AnimalBlip})
            end 
            
            while OnGoingHuntSession do 
                local sleep = 500
                for index, value in ipairs(AnimalsInSession) do 
                    if DoesEntityExist(value.id) then
                        local AnimalCoords = GetEntityCoords(value.id)
                        local PlyCoords = GetEntityCoords(PlayerPedId())
                        local AnimalHealth = GetEntityHealth(value.id)

                        local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)

                        if AnimalHealth <= 0 then 
                            SetBlipColour(value.Blipid, 3)
                            if PlyToAnimal < 2.0 then 
                                sleep = 5

                                DrawText3D2(AnimalCoords.x, AnimalCoords.y, AnimalCoords.z + 1, ' [E] Slaughter Animal')

                                if IsControlJustReleased(0, Keys['E']) then
                                    if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KNIFE') then 
                                        if DoesEntityExist(value.id) then 
                                            table.remove(AnimalsInSession, index)
                                            SlaughterAnimal(value.id)
                                        end
                                    else 
                                        RLCore.Functions.Notify('You need to use a knife!', "error")
                                    end
                                end 
                            end 
                        end 
                    end 
                end 
                Citizen.Wait(sleep)
            end 
        end)
    end
end

function SlaughterAnimal(AnimalId)

	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )

	Citizen.Wait(5000)

	ClearPedTasksImmediately(PlayerPedId())

	local AnimalWeight = math.random(10, 160) / 10

    RLCore.Functions.Notify('You Slaughtered the animal and recieved' ..AnimalWeight.. 'KG of meat', "success")

    TriggerServerEvent('hunting:reward', AnimalWeight)

    DeleteEntity(AnimalId)
end

function SellItems()
    TriggerServerEvent('hunting:sell')
end 

function GiveItem()
    TriggerServerEvent('hunting:GiveWeapon')
end

function RemoveItem()
    TriggerServerEvent('hunting:RemoveWeapon')
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end   
end 

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

function DrawM(hint, type, x, y, z)
    DrawText3D2(x, y, z + 1.0, hint)
    DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
end

