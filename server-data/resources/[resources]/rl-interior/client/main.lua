local IsNew = false

RegisterNetEvent('rl-interior:client:SetNewState', function(bool)
	IsNew = bool
end)

-- Functions

local function DespawnInterior(objects, cb)
    Citizen.CreateThread(function()
        for k, v in pairs(objects) do
            if DoesEntityExist(v) then
                DeleteEntity(v)
            end
        end

        cb()
    end)
end

function TeleportToInterior(x, y, z, h)
    Citizen.CreateThread(function()
        SetEntityCoords(PlayerPedId(), x, y, z, 0, 0, 0, false)
        SetEntityHeading(PlayerPedId(), h)

        Citizen.Wait(100)

        DoScreenFadeIn(1000)
    end)
end

-- Starting Apartment

function CreateApartmentFurnished(spawn)
	local objects = {}

    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"z":1.2,"y":4.29636328125,"x":3.572736328125,"h":2.2633972168}')
	POIOffsets.clothes = json.decode('{"z":1.2,"y":-2.6444736328,"x":0.524350097,"h":2.2633972168}')
	POIOffsets.stash = json.decode('{"z":0.5,"y":1.9440585937501,"x":-1.08997509763,"h":2.2633972168}')
	POIOffsets.logout = json.decode('{"z":0.8,"y":-3.0555111328,"x":-4.5689604492,"h":2.2633972168}')
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`gabz_pinkcage`)
	while not HasModelLoaded(`gabz_pinkcage`) do
	    Citizen.Wait(3)
	end
	local house = CreateObject(`gabz_pinkcage`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
	table.insert(objects, house)

	TeleportToInterior(spawn.x - 3.32089355468, spawn.y - 3.69636328125, spawn.z + 1.2, POIOffsets.exit.h)
	if IsNew then
		SetTimeout(750, function()
			TriggerEvent('rl-clothes:client:CreateFirstCharacter')
			IsNew = false
		end)
	end
    return { objects, POIOffsets }
end

-- Shells (in order by tier starting at 1)

local function CreateApartmentShell(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 4.693, "y": -6.015, "z": 1.11, "h":358.634}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_v16low`)
	while not HasModelLoaded(`shell_v16low`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_v16low`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
	objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateTier1House(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 1.561, "y": -14.305, "z": 1.147, "h":2.263}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_v16mid`)
	while not HasModelLoaded(`shell_v16mid`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_v16mid`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateTrevorsShell(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 0.374, "y": -3.789, "z": 2.428, "h":358.633}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_trevor`)
	while not HasModelLoaded(`shell_trevor`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_trevor`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
	objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateCaravanShell(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"z":3.3, "y":-2.1, "x":-1.4, "h":358.633972168}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_trailer`)
	while not HasModelLoaded(`shell_trailer`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_trailer`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
	objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateLesterShell(spawn)
	local objects = {}
    local POIOffsets = {}
    POIOffsets.exit = json.decode('{"x":-1.780, "y":-0.795, "z":1.1,"h":270.30}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_lester`)
	while not HasModelLoaded(`shell_lester`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_lester`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
	objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateRanchShell(spawn)
	local objects = {}
    local POIOffsets = {}
    POIOffsets.exit = json.decode('{"x":-1.257, "y":-5.469, "z":2.5, "h":270.57,}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_ranch`)
	while not HasModelLoaded(`shell_ranch`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_ranch`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
	objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateHouseRobbery(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 1.46, "y": -10.33, "z": 1.06, "h": 0.39}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`furnitured_midapart`)
	while not HasModelLoaded(`furnitured_midapart`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`furnitured_midapart`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

-- Warehouse Shells https://k4mb1.tebex.io/package/4673185

local function CreateWarehouse1(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -8.95, "y": 0.51, "z": 1.04, "h": 268.82}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_warehouse1`)
	while not HasModelLoaded(`shell_warehouse1`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_warehouse1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateWarehouse2(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 12.51, "y": -0.01, "z": 1.03, "h": 94.52}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_warehouse2`)
	while not HasModelLoaded(`shell_warehouse2`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_warehouse2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateWarehouse3(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 2.61, "y": -1.65, "z": 1.00, "h": 85.2}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_warehouse3`)
	while not HasModelLoaded(`shell_warehouse3`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_warehouse3`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

-- Highend Housing Shells https://k4mb1.tebex.io/package/4673131

local function CreateHighend1(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -2.23, "y": 9.01, "z": 8.69, "h": 178.81}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_apartment1`)
	while not HasModelLoaded(`shell_apartment1`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_apartment1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateHighend2(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -2.25, "y": 9.00, "z": 8.69, "h": 177.86}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_apartment2`)
	while not HasModelLoaded(`shell_apartment2`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_apartment2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateHighend3(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 11.75, "y": 4.55, "z": 8.13, "h": 129.16}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_apartment3`)
	while not HasModelLoaded(`shell_apartment3`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_apartment3`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

-- Deluxe Housing Shells https://k4mb1.tebex.io/package/4673159

local function CreateHighend(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -22.37, "y": -0.33, "z": 7.26, "h": 267.73}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_highend`)
	while not HasModelLoaded(`shell_highend`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_highend`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateHighendV2(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -10.51, "y": 0.86, "z": 6.56, "h": 270.38}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_highendv2`)
	while not HasModelLoaded(`shell_highendv2`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_highendv2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateMichael(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -9.49, "y": 5.54, "z": 9.91, "h": 270.86}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_michael`)
	while not HasModelLoaded(`shell_michael`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_michael`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

-- Office Shells https://k4mb1.tebex.io/package/4673258

local function CreateOffice2(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 3.66, "y": -1.94, "z": 1.26, "h": 92.73}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_office2`)
	while not HasModelLoaded(`shell_office2`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_office2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateOfficeBig(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -12.48, "y": 1.91, "z": 5.30, "h": 175.13}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_officebig`)
	while not HasModelLoaded(`shell_officebig`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_officebig`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

-- Store Shells https://k4mb1.tebex.io/package/4673264

local function CreateBarber(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 1.54, "y": 5.40, "z": 1.0, "h": 175.27}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_barber`)
	while not HasModelLoaded(`shell_barber`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_barber`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateGunstore(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -1.02, "y": -5.43, "z": 1.03, "h": 359.77}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_gunstore`)
	while not HasModelLoaded(`shell_gunstore`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_gunstore`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateStore1(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -2.61, "y": -4.73, "z": 1.08, "h": 1.0}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_store1`)
	while not HasModelLoaded(`shell_store1`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_store1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateStore2(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.64, "y": -5.07, "z": 1.02, "h": 1.91}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_store2`)
	while not HasModelLoaded(`shell_store2`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_store2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateStore3(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.14, "y": -7.87, "z": 2.01, "h": 358.15}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_store3`)
	while not HasModelLoaded(`shell_store3`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_store3`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

-- Medium Housing Shells https://k4mb1.tebex.io/package/4672307

local function CreateFranklinAunt(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -0.36, "y": -5.89, "z": 1.70, "h": 358.21}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_frankaunt`)
	while not HasModelLoaded(`shell_frankaunt`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_frankaunt`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateMedium2(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 6.04, "y": 0.34, "z": 1.03, "h": 357.99}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_medium2`)
	while not HasModelLoaded(`shell_medium2`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_medium2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateMedium3(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 3.32, "y": 1.23, "z": 2.57, "h": 273.46}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_medium3`)
	while not HasModelLoaded(`shell_medium3`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_medium3`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

-- Drug Lab Shells https://k4mb1.tebex.io/package/4672285

local function CreateCoke(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -6.24, "y": 8.48, "z": 1.00, "h": 179.30}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_coke1`)
	while not HasModelLoaded(`shell_coke1`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_coke1`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateCoke2(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -6.32, "y": 8.60, "z": 1.03, "h": 179.23}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_coke2`)
	while not HasModelLoaded(`shell_coke2`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_coke2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateMeth(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -6.39, "y": 8.54, "z": 1.03, "h": 178.84}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_meth`)
	while not HasModelLoaded(`shell_meth`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_meth`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateWeed2(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 17.85, "y": 11.75, "z": 1.01, "h": 88.11}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_weed2`)
	while not HasModelLoaded(`shell_weed2`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_weed2`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

-- Garage Shells https://k4mb1.tebex.io/package/4673177

local function CreateGarageLow(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 5.85, "y": 3.86, "z": 1.0, "h": 180.05}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_garages`)
	while not HasModelLoaded(`shell_garages`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_garages`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateGarageMed(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 13.90, "y": 1.63, "z": 1.0, "h": 87.05}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_garagem`)
	while not HasModelLoaded(`shell_garagem`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_garagem`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateGarageHigh(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 12.02, "y": -14.30, "z": 0.99, "h": 89.42}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	RequestModel(`shell_garagel`)
	while not HasModelLoaded(`shell_garagel`) do
	    Citizen.Wait(1000)
	end
	local house = CreateObject(`shell_garagel`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

-- Exports

exports('DespawnInterior', DespawnInterior)
exports('CreateRanchShell', CreateRanchShell)
exports('CreateTier1House', CreateTier1House)
exports('CreateLesterShell', CreateLesterShell)
exports('CreateHouseRobbery', CreateHouseRobbery)
exports('CreateTrevorsShell', CreateTrevorsShell)
exports('CreateCaravanShell', CreateCaravanShell)
exports('CreateApartmentShell', CreateApartmentShell)
exports('CreateApartmentFurnished', CreateApartmentFurnished)
-- Warehouse Shells (addon) https://k4mb1.tebex.io/package/4673185
exports('CreateWarehouse1', CreateWarehouse1)
exports('CreateWarehouse2', CreateWarehouse2)
exports('CreateWarehouse3', CreateWarehouse3)
-- Highend Shells (addon) https://k4mb1.tebex.io/package/4673131
exports('CreateHighend1', CreateHighend1)
exports('CreateHighend2', CreateHighend2)
exports('CreateHighend3', CreateHighend3)
-- Deluxe Shells (addon) https://k4mb1.tebex.io/package/4673159
exports('CreateHighend', CreateHighend)
exports('CreateHighendV2', CreateHighendV2)
exports('CreateMichael', CreateMichael)
-- Office Shells (addon) https://k4mb1.tebex.io/package/4673258
exports('CreateOffice2', CreateOffice2)
exports('CreateOfficeBig', CreateOfficeBig)
-- Store Shells (addon) https://k4mb1.tebex.io/package/4673264
exports('CreateBarber', CreateBarber)
exports('CreateGunstore', CreateGunstore)
exports('CreateStore1', CreateStore1)
exports('CreateStore2', CreateStore2)
exports('CreateStore3', CreateStore3)
-- Medium Housing Shells (addon) https://k4mb1.tebex.io/package/4672307
exports('CreateFranklinAunt', CreateFranklinAunt)
exports('CreateMedium2', CreateMedium2)
exports('CreateMedium3', CreateMedium3)
-- Drug Lab Shells (addon) https://k4mb1.tebex.io/package/4672285
exports('CreateCoke', CreateCoke)
exports('CreateCoke2', CreateCoke2)
exports('CreateMeth', CreateMeth)
exports('CreateWeed2', CreateWeed2)
-- Garage Shells (addon) https://k4mb1.tebex.io/package/4673177
exports('CreateGarageLow', CreateGarageLow)
exports('CreateGarageMed', CreateGarageMed)
exports('CreateGarageHigh', CreateGarageHigh)