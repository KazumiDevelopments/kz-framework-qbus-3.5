local converting = false

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

-- COKE BRICK >> COKE (10G)
RegisterNetEvent("BrickToCoke10g")
AddEventHandler("BrickToCoke10g", function()
    if converting then
      return
    end
    converting = true
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		loadAnimDict("anim@amb@business@coc@coc_unpack_cut@")
		TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0, 1.0, -1, 1, -1, 0, 0, 0)
		Progressbar(5000,"Cutting Cocaine Brick to 10g's")
		StopAnimTask(GetPlayerPed(-1), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0)
	end
    converting = false
end)

-- COKE (10G) >> COKE (1G)
RegisterNetEvent("Coke10gToCoke1g")
AddEventHandler("Coke10gToCoke1g", function()
    if converting then
      return
    end
    converting = true
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		loadAnimDict("anim@amb@business@coc@coc_unpack_cut@")
		TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0, 1.0, -1, 1, -1, 0, 0, 0)
		Progressbar(5000,"Sorting 10g's Cocaine into 1g's")
		StopAnimTask(GetPlayerPed(-1), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0)
	end
    converting = false
end)

-- METH BRICK >> METH (10G)
RegisterNetEvent("BrickToMeth10g")
AddEventHandler("BrickToMeth10g", function()
    if converting then
      return
    end
    converting = true
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		loadAnimDict("anim@amb@business@coc@coc_unpack_cut@")
		TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0, 1.0, -1, 1, -1, 0, 0, 0)
		Progressbar(5000,"Cutting Meth Brick into 10g's")
		StopAnimTask(GetPlayerPed(-1), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0)
	end
    converting = false
end)

-- METH (10G) >> METH (1G)
RegisterNetEvent("Meth10gToMeth1g")
AddEventHandler("Meth10gToMeth1g", function()
    if converting then
      return
    end
    converting = true
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		loadAnimDict("anim@amb@business@coc@coc_unpack_cut@")
		TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0, 1.0, -1, 1, -1, 0, 0, 0)
		Progressbar(5000,"Sorting 10g's Meth into 1g's")
		StopAnimTask(GetPlayerPed(-1), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0)
	end
    converting = false
end)

-- WEED BRICK >> WEED (20G)
RegisterNetEvent("BrickToWeed20g")
AddEventHandler("BrickToWeed20g", function()
    if converting then
      return
    end
    converting = true
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		loadAnimDict("mini@repair")
		TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
		Progressbar(5000,"Cutting Weed Brick into 20g's")
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
	end
    converting = false
end)

-- WEED (20G) >> WEED (4G)
RegisterNetEvent("Weed20gToWeed4g")
AddEventHandler("Weed20gToWeed4g", function()
    if converting then
      return
    end
    converting = true
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		loadAnimDict("mini@repair")
		TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
		Progressbar(5000,"Packing Q Bags")
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
	end
    converting = false
end)

-- WEED (4G) >> JOINT (2G)
RegisterNetEvent("Weed4gToJoint2g")
AddEventHandler("Weed4gToJoint2g", function()
    if converting then
      return
    end
    converting = true
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
		loadAnimDict("mini@repair")
		TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
		Progressbar(5000,"Rolling Joints")
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
	end
    converting = false
end)