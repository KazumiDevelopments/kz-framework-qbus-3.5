
attachedPropPerm = 0
function removeAttachedPropPerm()
	if DoesEntityExist(attachedPropPerm) then
		DeleteEntity(attachedPropPerm)
		attachedPropPerm = 0
	end
end

RegisterNetEvent('destroyPropPerm')
AddEventHandler('destroyPropPerm', function()
	removeAttachedPropPerm()
end)

local APPbone = 0
local APPx = 0.0
local APPy = 0.0
local APPz = 0.0
local APPxR = 0.0
local APPyR = 0.0
local APPzR = 0.0

local holdingPackage = false

RegisterNetEvent('attachPropPerm')
AddEventHandler('attachPropPerm', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)

	if attachedPropPerm ~= 0 then
		removeAttachedPropPerm()
		return
	end
	TriggerEvent("DoLongHudText","Press 7 to drop or pickup the object.",37)

	holdingPackage = true
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent
	SetCurrentPedWeapon(PlayerPedId(), 0xA2719263)
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedPropPerm = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(attachedPropPerm, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)

	APPbone = bone
	APPx = x
	APPy = y
	APPz = z
	APPxR = xR
	APPyR = yR
	APPzR = zR

end)
function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function randPickupAnim()
  local randAnim = math.random(7)


    loadAnimDict('random@domestic')
    TaskPlayAnim(PlayerPedId(),'random@domestic', 'pickup_low',5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)

end

function propAttachDrop()
	if attachedPropPerm ~= 0 then

		if (`WEAPON_UNARMED` ~= GetSelectedPedWeapon(PlayerPedId()) and holdingPackage) then

			if not holdingPackage then

				local dst = #(GetEntityCoords(attachedPropPerm) - GetEntityCoords(PlayerPedId()))

				if dst < 2 then
				--	TaskTurnPedToFaceEntity(PlayerPedId(), attachedPropPerm, 1.0)
					holdingPackage = not holdingPackage
					randPickupAnim()
					Citizen.Wait(1000)
					PropCarryAnim()
					ClearPedTasks(PlayerPedId())
					ClearPedSecondaryTask(PlayerPedId())
					AttachEntityToEntity(attachedPropPerm, PlayerPedId(), APPbone, APPx, APPy, APPz, APPxR, APPyR, APPzR, 1, 1, 0, 0, 2, 1)
				end

			else
				holdingPackage = not holdingPackage
				ClearPedTasks(PlayerPedId())
				ClearPedSecondaryTask(PlayerPedId())
				randPickupAnim()
				Citizen.Wait(500)
				DetachEntity(attachedPropPerm)
			end

		end
	end
end

Citizen.CreateThread(function()
  exports["np-keybinds"]:registerKeyMapping("", "Player", "Drop Prop", "+propAttachDrop", "-propAttachDrop")
  RegisterCommand('+propAttachDrop', propAttachDrop, false)
  RegisterCommand('-propAttachDrop', function() end, false)
end)


function PropCarryAnim()
	-- anims for specific carrying props.
end

attachedProp = 0
function removeAttachedProp()
	if DoesEntityExist(attachedProp) then
		DeleteEntity(attachedProp)
		attachedProp = 0
	end
end

exports('GetAttachedProp', function()
	return attachedProp
end)

RegisterNetEvent('destroyProp')
AddEventHandler('destroyProp', function()
	removeAttachedProp()
end)

RegisterNetEvent('attachProp')
AddEventHandler('attachProp', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR, pVertexIndex, disableCollision)
	removeAttachedProp()
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent
	SetCurrentPedWeapon(PlayerPedId(), 0xA2719263)
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	if disableCollision then
		SetEntityCollision(attachedProp, false, false)
	end
	SetModelAsNoLongerNeeded(attachModel)
	AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, pVertexIndex and pVertexIndex or 2, 1)

end)

-- Phone
attachedPropPhone = 0
function removeAttachedPropPhone()
  DeleteEntity(attachedPropPhone)
  attachedPropPhone = 0
end

RegisterNetEvent('destroyPropPhone')
AddEventHandler('destroyPropPhone', function()
	removeAttachedPropPhone()
end)

RegisterNetEvent('attachPropPhone')
AddEventHandler('attachPropPhone', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedPropPhone()
	attachModelPhone = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent
	SetCurrentPedWeapon(PlayerPedId(), 0xA2719263)
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModelPhone)
	while not HasModelLoaded(attachModelPhone) do
		Citizen.Wait(0)
	end
	removeAttachedPropPhone()
	attachedPropPhone = CreateObject(attachModelPhone, 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(attachedPropPhone, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 0, 0, 0, 2, 1)
end)

RegisterNetEvent('attachPropPoliceIdBoard')
AddEventHandler('attachPropPoliceIdBoard', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
		removeAttachedProp()
    RequestAnimDict("mp_character_creation@lineup@male_a")
    while not HasAnimDictLoaded("mp_character_creation@lineup@male_a") do
        Citizen.Wait(0)
    end
    if not IsEntityPlayingAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "loop_raised", 3) then
        local animLength = GetAnimDuration("mp_character_creation@lineup@male_a", "loop_raised")
        TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "loop_raised", 1.0, 1.0, animLength, 54, 0, 0,0, 0)
    end
    attachModel = GetHashKey(attachModelSent)
    boneNumber = boneNumberSent
    SetCurrentPedWeapon(PlayerPedId(), 0xA2719263)
    local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
        Citizen.Wait(100)
    end
    attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end)

-- Radio
attachedPropRadio = 0
function removeAttachedPropRadio()
	if DoesEntityExist(attachedPropRadio) then
		DeleteEntity(attachedPropRadio)
		attachedPropRadio = 0
	end
end

RegisterNetEvent('destroyPropRadio')
AddEventHandler('destroyPropRadio', function()
	removeAttachedPropRadio()
end)

RegisterNetEvent('attachPropRadio')
AddEventHandler('attachPropRadio', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedPropRadio()
	attachModelRadio = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent
	SetCurrentPedWeapon(PlayerPedId(), 0xA2719263)
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModelRadio)
	while not HasModelLoaded(attachModelRadio) do
		Citizen.Wait(100)
	end
	attachedPropRadio = CreateObject(attachModelRadio, 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(attachedPropRadio, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 0, 0, 0, 2, 1)
end)


attachedProp69 = 0
function removeAttachedProp69()
	if DoesEntityExist(attachedProp69) then
		DeleteEntity(attachedProp69)
		attachedProp69 = 0
	end
end


RegisterNetEvent('destroyProp69')
AddEventHandler('destroyProp69', function()
	removeAttachedProp69()
end)
RegisterNetEvent('attachProp69')
AddEventHandler('attachProp69', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp69()
	attachModel69 = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent
	SetCurrentPedWeapon(PlayerPedId(), 0xA2719263)
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModel69)
	while not HasModelLoaded(attachModel69) do
		Citizen.Wait(100)
	end
	attachedProp69 = CreateObject(attachModel69, 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(attachedProp69, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 0, 0, 0, 2, 1)
end)


attachPropList = {

	["test"] = {
		["model"] = "prop_cs_brain_chunk", ["bone"] = 28422, ["x"] = 0.062,["y"] = 0.02,["z"] = 0.0,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0
	},

	["cigar1"] = {
		["model"] = "prop_cigar_01", ["bone"] = 47419, ["x"] = 0.010,["y"] = 0.00,["z"] = 0.0,["xR"] = 50.0,["yR"] = -80.0, ["zR"] = 0.0
	},

	["cigar2"] = {
		["model"] = "prop_cigar_02", ["bone"] = 47419, ["x"] = 0.010,["y"] = 0.00,["z"] = 0.0,["xR"] = 50.0,["yR"] = -80.0, ["zR"] = 0.0
	},

	["cigar3"] = {
		["model"] = "prop_cigar_03", ["bone"] = 47419, ["x"] = 0.010,["y"] = 0.00,["z"] = 0.0,["xR"] = 50.0,["yR"] = -80.0, ["zR"] = 0.0
	},

	["cigarette"] = {
		["model"] = "prop_cs_ciggy_01", ["bone"] = 28422, ["x"] = -0.0,["y"] = 0.0,["z"] = 0.0,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0
	},

	["cig01"] = {
		["model"] = "prop_amb_ciggy_01", ["bone"] = 28422, ["x"] = -0.024,["y"] = 0.0,["z"] = 0.0,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0
	},

	["cig02"] = {
		["model"] = "prop_amb_ciggy_01", ["bone"] = 58867, ["x"] = 0.06,["y"] = 0.0,["z"] = -0.02,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 90.0
	},

	["cigmouth"] = {
		["model"] = "prop_amb_ciggy_01", ["bone"] = 47419, ["x"] = 0.010,["y"] = -0.009,["z"] = -0.003,["xR"] = 55.0,["yR"] = 0.0, ["zR"] = 110.0
	},

	["healthpack01"] = {
		["model"] = "prop_ld_health_pack", ["bone"] = 28422, ["x"] = 0.18,["y"] = 0.0,["z"] = 0.0,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 0.0
	},

	["briefcase01"] = {
		["model"] = "prop_ld_case_01", ["bone"] = 28422, ["x"] = 0.08,["y"] = 0.0,["z"] = 0.0,["xR"] = 315.0,["yR"] = 288.0, ["zR"] = 0.0
	},

	["cashcase01"] = {
		["model"] = "prop_cash_case_01", ["bone"] = 28422, ["x"] = 0.05,["y"] = 0.0,["z"] = 0.0,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 0.0
	},

	["cashbag01"] = {
		["model"] = "prop_cs_heist_bag_01", ["bone"] = 24816, ["x"] = 0.15,["y"] = -0.4,["z"] = -0.38,["xR"] = 90.0,["yR"] = 0.0, ["zR"] = 0.0
	},

	["wadofbills"] = {
		["model"] = "prop_anim_cash_pile_01", ["bone"] = 60309, ["x"] = 0.0,["y"] = 0.0,["z"] = 0.0, ["xR"] = 180.0,["yR"] = 0.0, ["zR"] = 70.0
	},

	["notepad01"] = {
		["model"] = "prop_notepad_01", ["bone"] = 60309, ["x"] = 0.0,["y"] = -0.0,["z"] = -0.0,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0
	},

	["phone01"] = {
		["model"] = "prop_player_phone_01", ["bone"] = 57005, ["x"] = 0.14,["y"] = 0.01,["z"] = -0.02,["xR"] = 110.0,["yR"] = 120.0, ["zR"] = -15.0
	},

	["radio01"] = {
		["model"] = "prop_cs_hand_radio", ["bone"] = 57005, ["x"] = 0.14,["y"] = 0.01,["z"] = -0.02,["xR"] = 110.0,["yR"] = 120.0, ["zR"] = -15.0
	},

	["clipboard01"] = {
		["model"] = "p_amb_clipboard_01", ["bone"] = 60309, ["x"] = -0.01,["y"] = -0.015,["z"] = 0.005,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = -10.0
	},
	["clipboard02"] = {
		["model"] = "p_amb_clipboard_01", ["bone"] = 60309, ["x"] = 0.1,["y"] = -0.01,["z"] = 0.005,["xR"] = -95.0,["yR"] = 20.0, ["zR"] = -20.0
	},


	["tablet01"] = {
		["model"] = "prop_cs_tablet", ["bone"] = 60309, ["x"] = 0.02,["y"] = -0.01,["z"] = -0.03,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = -10.0
	},

	["binder01"] = {
		["model"] = "np_npc_binder", ["bone"] = 60309, ["x"] = 0.1,["y"] = 0.025,["z"] = -0.15,["xR"] = 0.0,["yR"] = 100.0, ["zR"] = -90.0
	},

	["openBook"] = {
		["model"] = "v_ilev_mp_bedsidebook", ["bone"] = 60309, ["x"] = 0.05,["y"] = 0.0,["z"] = 0.0,["xR"] = -90.0,["yR"] = 0.0, ["zR"] = 0.0
	},

	["pencil01"] = {
		["model"] = "prop_pencil_01", ["bone"] = 58870, ["x"] = 0.04,["y"] = 0.0225,["z"] = 0.08,["xR"] = 320.0,["yR"] = 0.0, ["zR"] = 220.0
	},

	["drugpackage01"] = {
		["model"] = "prop_meth_bag_01", ["bone"] = 28422, ["x"] = 0.1,["y"] = 0.0,["z"] = -0.01,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 40.0
	},

	["drugpackage02"] = {
		["model"] = "prop_weed_bottle", ["bone"] = 28422, ["x"] = 0.09,["y"] = 0.0,["z"] = -0.03,["xR"] = 135.0,["yR"] = -100.0, ["zR"] = 40.0
	},

	["drugtest01"] = {
		["model"] = "prop_cash_case_02", ["bone"] = 28422, ["x"] = -0.01,["y"] = -0.1,["z"] = -0.138,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0
	},

	["box01"] = {
		["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = 0.01,["y"] = 0.01,["z"] = 0.0,["xR"] = -255.0,["yR"] = -120.0, ["zR"] = 40.0
	},

	["bomb01"] = {
		["model"] = "prop_ld_bomb", ["bone"] = 28422, ["x"] = 0.22,["y"] = -0.01,["z"] = 0.0,["xR"] = -25.0,["yR"] = -100.0, ["zR"] = 0.0
	},



	["money01"] = {
		["model"] = "prop_anim_cash_note", ["bone"] = 28422, ["x"] = 0.1,["y"] = 0.04,["z"] = 0.0,["xR"] = 25.0,["yR"] = 0.0, ["zR"] = 10.0
	},

	["armor01"] = {
		["model"] = "prop_armour_pickup", ["bone"] = 28422, ["x"] = 0.3,["y"] = 0.01,["z"] = 0.0,["xR"] = 255.0,["yR"] = -90.0, ["zR"] = 10.0
	},

	["terd01"] = {
		["model"] = "prop_big_shit_01", ["bone"] = 61839, ["x"] = 0.015,["y"] = 0.0,["z"] = -0.01,["xR"] = 3.0,["yR"] = -90.0, ["zR"] = 180.0
	},

	["blackduffelbag"] = {
		["model"] = "xm_prop_x17_bag_01a", ["bone"] = 28422, ["x"] = 0.37,["y"] = 0.0,["z"] = 0.0,["xR"] = -50.0,["yR"] = -90.0, ["zR"] = 0.0
	},

	["medicalBag"] = {
		["model"] = "xm_prop_x17_bag_med_01a", ["bone"] = 28422, ["x"] = 0.37,["y"] = 0.0,["z"] = 0.0,["xR"] = -50.0,["yR"] = -90.0, ["zR"] = 0.0
	},

	["securityCase"] = {
		["model"] = "prop_security_case_01", ["bone"] = 28422, ["x"] = 0.1,["y"] = 0.0,["z"] = 0.0,["xR"] = -50.0,["yR"] = -90.0, ["zR"] = 0.0
	},

	["toolbox"] = {
		["model"] = "prop_tool_box_04", ["bone"] = 28422, ["x"] = 0.37,["y"] = 0.0,["z"] = 0.0,["xR"] = -50.0,["yR"] = -90.0, ["zR"] = 0.0
	},

	["boombox01"] = {
		["model"] = "prop_boombox_01", ["bone"] = 28422, ["x"] = 0.2,["y"] = 0.0,["z"] = 0.0,["xR"] = -35.0,["yR"] = -100.0, ["zR"] = 0.0
	},

	["bowlball01"] = {
		["model"] = "prop_bowling_ball", ["bone"] = 28422, ["x"] = 0.12,["y"] = 0.0,["z"] = 0.0,["xR"] = 75.0,["yR"] = 280.0, ["zR"] = -80.0
	},

	["bowlpin01"] = {
		["model"] = "prop_bowling_pin", ["bone"] = 28422, ["x"] = 0.12,["y"] = 0.0,["z"] = 0.0,["xR"] = 75.0,["yR"] = 280.0, ["zR"] = -80.0
	},

	["crate01"] = {
		["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = 0.0,["y"] = 0.0,["z"] = 0.0,["xR"] = 0.0,["yR"] = 0.0, ["zR"] = 0.0
	},

	["tvcamera01"] = {
		["model"] = "prop_v_cam_01", ["bone"] = 57005, ["x"] = 0.13,["y"] = 0.25,["z"] = -0.03,["xR"] = -85.0,["yR"] = 0.0, ["zR"] = -80.0
	},

	["boomMIKE01"] = {
		["model"] = "prop_v_bmike_01", ["bone"] = 57005, ["x"] = 0.1,["y"] = 0.0,["z"] = -0.03,["xR"] = 85.0,["yR"] = 0.0, ["zR"] = 96.0
	},

	["minigameThermite"] = {
		["model"] = "prop_oiltub_06", ["bone"] = 57005, ["x"] = 0.1,["y"] = 0.0,["z"] = -0.09,["xR"] = 145.0,["yR"] = 20.0, ["zR"] = 80.0
	},

	["minigameDrill"] = {
		["model"] = "hei_prop_heist_drill", ["bone"] = 57005, ["x"] = 0.15,["y"] = 0.0,["z"] = -0.05,["xR"] = 0.0,["yR"] = 90.0, ["zR"] = 90.0
	},

		-- 18905 left hand - 57005 right hand
	["tvmic01"] = {
		["model"] = "p_ing_microphonel_01", ["bone"] = 18905, ["x"] = 0.1,["y"] = 0.05,["z"] = 0.0,["xR"] = -85.0,["yR"] = -80.0, ["zR"] = -80.0
	},

	["tvmic02"] = {
		["model"] = "p_ing_microphonel_01_lsbn", ["bone"] = 18905, ["x"] = 0.1,["y"] = 0.05,["z"] = 0.05,["xR"] = -85.0,["yR"] = -80.0, ["zR"] = -80.0
	},

	["nosbottle"] = {
		["model"] = "p_cs_bottle_01", ["bone"] = 18905, ["x"] = 0.1,["y"] = 0.05,["z"] = 0.0,["xR"] = -85.0,["yR"] = -80.0, ["zR"] = -80.0
	},

	["newspaper01"] = {
		["model"] = "prop_cliff_paper", ["bone"] = 28422, ["x"] = -0.07,["y"] = 0.0,["z"] = 0.0,["xR"] = 90.0,["yR"] = 0.0, ["zR"] = 0.0
	},


	["golfbag01"] = {
		["model"] = "prop_golf_bag_01", ["bone"] = 24816, ["x"] = 0.12,["y"] = -0.3,["z"] = 0.0,["xR"] = -75.0,["yR"] = 190.0, ["zR"] = 92.0
	},

	["golfputter01"] = {
		["model"] = "prop_golf_putter_01", ["bone"] = 57005, ["x"] = 0.0,["y"] = -0.05,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},

	["golfiron01"] = {
		["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.125,["y"] = 0.04,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golfiron03"] = {
		["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.126,["y"] = 0.041,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golfiron05"] = {
		["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.127,["y"] = 0.042,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golfiron07"] = {
		["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.128,["y"] = 0.043,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golfwedge01"] = {
		["model"] = "prop_golf_pitcher_01", ["bone"] = 57005, ["x"] = 0.17,["y"] = 0.04,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},

	["golfdriver01"] = {
		["model"] = "prop_golf_driver", ["bone"] = 57005, ["x"] = 0.14,["y"] = 0.00,["z"] = 0.0,["xR"] = 160.0,["yR"] = -60.0, ["zR"] = 10.0
	},

	["knife"] = {
		["model"] = "prop_knife", ["bone"] = 28422,
		["x"] = 0.15,
		["y"] = 0.1,
		["z"] = -0.05,
		["xR"] = 0.0,
		["yR"] = 20.0,
		["zR"] = -40.0
	},

	["glowstickRight"] = {
		["model"] = "ba_prop_battle_glowstick_01", ["bone"] = 28422,
		["x"] = 0.0700,
		["y"] = 0.1400,
		["z"] = 0.0,
		["xR"] = -80.0,
		["yR"] = 20.0,
		["zR"] = 0.0
	},

	["glowstickLeft"] = {
		["model"] = "ba_prop_battle_glowstick_01",
		["bone"] = 60309,
		["x"] = 0.0700,
		["y"] = 0.0900,
		["z"] = 0.0,
		["xR"] = -120.0,
		["yR"] = 20.0,
		["zR"] = 0.0
	},
	["toyHorse"] = {
		["model"] = "ba_prop_battle_hobby_horse",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.0,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},
	["cup"] = {
		["model"] = "prop_plastic_cup_02",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.0,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},
	["hamburger"] = {
		["model"] = "prop_cs_burger_01",
		["bone"] = 18905,
		["x"] = 0.13,
		["y"] = 0.07,
		["z"] = 0.02,
		["xR"] = 120.0,
		["yR"] = 16.0,
		["zR"] = 60.0
	},
	["steak"] = {
		["model"] = "prop_cs_steak",
		["bone"] = 18905,
		["x"] = 0.13,
		["y"] = 0.07,
		["z"] = 0.02,
		["xR"] = 120.0,
		["yR"] = 16.0,
		["zR"] = 60.0
	},
	["sandwich"] = {
		["model"] = "prop_sandwich_01",
		["bone"] = 18905,
		["x"] = 0.13,
		["y"] = 0.05,
		["z"] = 0.02,
		["xR"] = -50.0,
		["yR"] = 16.0,
		["zR"] = 60.0
	},
	["donut"] = {
		["model"] = "prop_amb_donut",
		["bone"] = 18905,
		["x"] = 0.13,
		["y"] = 0.05,
		["z"] = 0.02,
		["xR"] = -50.0,
		["yR"] = 16.0,
		["zR"] = 60.0
	},
	["water"] = {
		["model"] = "prop_ld_flow_bottle",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.0,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},
	["coffee"] = {
		["model"] = "p_amb_coffeecup_01",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.0,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},
	["cola"] = {
		["model"] = "prop_ecola_can",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.0,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},
	["energydrink"] = {
		["model"] = "prop_energy_drink",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.0,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},
	["beer"] = {
		["model"] = "prop_beer_bottle",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = -0.15,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},
	["whiskey"] = {
		["model"] = "p_whiskey_bottle_s",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.0,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},
	["vodka"] = {
		["model"] = "prop_vodka_bottle",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = -0.32,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},
	["taco"] = {
		["model"] = "prop_taco_01",
		["bone"] = 18905,
		["x"] = 0.13,
		["y"] = 0.07,
		["z"] = 0.02,
		["xR"] = 160.0,
		["yR"] = 0.0,
		["zR"] = -50.0
	},
	["whiskeyglass"] = {
		["model"] = "prop_drink_whisky",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.0,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},
	["shotglass"] = {
		["model"] = "prop_shots_glass_cs",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.0,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},
	["fruit"] = {
		["model"] = "ng_proc_food_aple2a",
		["bone"] = 18905,
		["x"] = 0.13,
		["y"] = 0.07,
		["z"] = 0.02,
		["xR"] = 160.0,
		["yR"] = 0.0,
		["zR"] = 60.0
	},
	["tennis"] = {
		["model"] = "prop_tennis_rack_01",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.0,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},

	["stolentv"] = {
		["stolen"] = true,
		["blockGuns"] = true,
		["blockCar"] = true,
		["blockRunning"] = true,
		["destroyOnDamage"] = true,
		["inventoryBased"] = true,
		["model"] = "prop_tv_flat_02",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = -0.1,
		["z"] = 0.1,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},

	["stolenmusic"] = {
		["stolen"] = true,
		["blockGuns"] = true,
		["blockCar"] = true,
		["blockRunning"] = true,
		["destroyOnDamage"] = true,
		["inventoryBased"] = true,
		["model"] = "prop_speaker_06",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = -0.1,
		["z"] = 0.0,
		["xR"] = 30.0,
		["yR"] = 90.0,
		["zR"] = 0.0
	},

	["stolencoffee"] = {
		["stolen"] = true,
		["blockGuns"] = true,
		["blockCar"] = true,
		["blockRunning"] = true,
		["destroyOnDamage"] = true,
		["inventoryBased"] = true,
		["model"] = "prop_coffee_mac_02",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = -0.1,
		["z"] = -0.08,
		["xR"] = 0.0,
		["yR"] = 90.0,
		["zR"] = 0.0
	},

	["stolenmicrowave"] = {
		["stolen"] = true,
		["blockGuns"] = true,
		["blockCar"] = true,
		["blockRunning"] = true,
		["destroyOnDamage"] = true,
		["inventoryBased"] = true,
		["model"] = "prop_micro_02",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = -0.1,
		["z"] = -0.03,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},

	["stolencomputer"] = {
		["stolen"] = true,
		["blockGuns"] = true,
		["blockCar"] = true,
		["blockRunning"] = true,
		["destroyOnDamage"] = true,
		["inventoryBased"] = true,
		["model"] = "prop_dyn_pc_02",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = -0.1,
		["z"] = -0.03,
		["xR"] = 0.0,
		["yR"] = 90.0,
		["zR"] = 0.0
	},

	["stolenart"] = {
		["stolen"] = true,
		["blockGuns"] = true,
		["blockCar"] = true,
		["blockRunning"] = true,
		["destroyOnDamage"] = true,
		["inventoryBased"] = true,
		["model"] = "hei_prop_hei_bust_01",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = -0.3,
		["z"] = -0.2,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
  },

  ["trashbag"] = {
    ["model"] = "prop_cs_street_binbag_01",
    ["bone"] = 57005,
    ["x"] = 0.39,
    ["y"] = -0.22,
    ["z"] = 0.06,
    ["xR"] = 63.0,
    ["yR"] = -126.0,
    ["zR"] = -99.0,
    ["vertexIndex"] = 0
	},

	["police_id_board"] = {
		["model"] = "prop_police_id_board",
		["bone"] = 28422,
		["x"] = 0,
		["y"] = 0,
		["z"] = 0.1,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},

	["boe_bear"] = {
		["model"] = "denis3d_teddyboe",
		["bone"] = 57005,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.0,
		["xR"] = -60.0,
		["yR"] = -35.0,
		["zR"] = -15.0
  },
	["tcg_card"] = {
		["model"] = "np_npc_card",
		["bone"] = 57005,
		["x"] = 0.15,
		["y"] = 0.055,
		["z"] = -0.025,
		["xR"] = 170.0,
		["yR"] = 0.0,
		["zR"] = -240.0
  },
	["tcg_card_inspect"] = {
		["model"] = "np_npc_card",
		["bone"] = 57005,
		["x"] = 0.13,
		["y"] = 0.05,
		["z"] = -0.035,
		["xR"] = 35.0,
		["yR"] = 245.0,
		["zR"] = -15.0
  },
	["police_badge"] = {
		["model"] = "denis3d_policebadge_01",
		["bone"] = 57005,
		["x"] = 0.13,
		["y"] = 0.05,
		["z"] = -0.06,
		["xR"] = 40.0,
		["yR"] = 55.0,
		["zR"] = -267.0
  },
  ["prop_cs_walking_stick"] = {
    ["model"] = "prop_cs_walking_stick",
    ["bone"] = 28422, ["x"] = 0.06,["y"] = 0.03,["z"] = -0.01,["xR"] = 180.0,["yR"] = 288.0, ["zR"] = 0.0
  },
  ["bscoffee"] = {
		["model"] = "prop_food_bs_coffee",
		["bone"] = 28422,
		["x"] = 0.02,
		["y"] = 0.01,
		["z"] = -0.07,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 90.0
  },
  ["softdrink"] = {
		["model"] = "prop_food_bs_juice01",
		["bone"] = 28422,
		["x"] = 0.01,
		["y"] = 0.01,
		["z"] = -0.08,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 180.0
  },
  ["fries"] = {
		["model"] = "prop_food_bs_chips",
		["bone"] = 18905,
		["x"] = 0.1,
		["y"] = -0.01,
		["z"] = 0.05,
		["xR"] = 0.0,
		["yR"] = 90.0,
		["zR"] = 60.0
  },
  ["wineglass"] = {
  	["model"] = "prop_drink_redwine",
  	["bone"] = 28422,
  	["x"] = 0.0,
  	["y"] = 0.0,
  	["z"] = -0.08,
  	["xR"] = 0.0,
  	["yR"] = 0.0,
  	["zR"] = 0.0
  },
  ["roostertea"] = {
  	["model"] = "v_res_mcofcup",
  	["bone"] = 28422,
  	["x"] = -0.005,
  	["y"] = -0.01,
  	["z"] = -0.005,
  	["xR"] = 0.0,
  	["yR"] = 0.0,
  	["zR"] = 0.0
  },
  ["mug"] = {
  	["model"] = "prop_mug_02",
  	["bone"] = 28422,
  	["x"] = 0.02,
  	["y"] = -0.01,
  	["z"] = -0.005,
  	["xR"] = 0.0,
  	["yR"] = 0.0,
  	["zR"] = 140.0
  },
  ["darkmarketpackage"] = {
  	["animDict"] = "anim@heists@narcotics@trash",
  	["animName"] = "drop_side",
  	["model"] = "prop_idol_case_01",
  	["bone"] = 28422,
  	["x"] = 0.01,
  	["y"] = -0.02,
  	["z"] = -0.22,
  	["xR"] = 0.0,
  	["yR"] = 0.0,
  	["zR"] = 0.0,
  	["vertexIndex"] = 0,
  	["blockGuns"] = true,
  	["blockCar"] = true,
  	["blockRunning"] = true,
  	["inventoryBased"] = true,
  },
  ["weedpackage"] = {
    ["animDict"] = "anim@heists@narcotics@trash",
    ["animName"] = "drop_side",
    ["model"] = "hei_prop_heist_weed_block_01",
    ["bone"] = 28422,
    ["x"] = 0.01,
    ["y"] = -0.02,
    ["z"] = -0.12,
    ["xR"] = 0.0,
    ["yR"] = 0.0,
    ["zR"] = 0.0,
    ["vertexIndex"] = 0,
    ["blockGuns"] = true,
    ["blockCar"] = true,
    ["blockRunning"] = true,
    ["inventoryBased"] = true,
  },
  ["megaphone"] = {
    ["model"] = "prop_megaphone_01",
    ["bone"] = 28422,
    ["x"] = 0.04,
    ["y"] = -0.01,
    ["z"] = 0.0,
    ["xR"] = 22.0,
    ["yR"] = -4.0,
    ["zR"] = 87.0,
    ["vertexIndex"] = 0
  },
  ["wateringcan"] = {
    ["blockGuns"] = true,
    ["blockCar"] = true,
    ["blockRunning"] = true,
    ["animDict"] = "anim@heists@narcotics@trash",
    ["animName"] = "drop_side",
    ["model"] = "prop_wateringcan",
    ["bone"] = 28422,
    ["x"] = 0.0,
    ["y"] = -0.1,
    ["z"] = -0.25,
    ["xR"] = 0.0,
    ["yR"] = -10.0,
    ["zR"] = 0.0
  },
  ["boxscraps"] = {
    ["animDict"] = "anim@heists@narcotics@trash",
    ["animName"] = "drop_side",
    ["model"] = "prop_cs_cardbox_01",
    ["bone"] = 28422,
    ["x"] = 0.01,
    ["y"] = -0.02,
    ["z"] = -0.12,
    ["xR"] = 0.0,
    ["yR"] = 0.0,
    ["zR"] = 0.0,
    ["vertexIndex"] = 0,
    ["blockGuns"] = true,
    ["blockCar"] = true,
    ["blockRunning"] = true,
    ["inventoryBased"] = true,
  },
  ["digiscanner"] = {
    ["model"] = "w_am_metaldetector",
    ["bone"] = 18905,
    ["x"] = 0.13, -- z
    ["y"] = 0.03, -- right forward
    ["z"] = -0.03, -- back right
    ["xR"] = -150.0,
    ["yR"] = -10.0,
    ["zR"] = -10.0,
    ["vertexIndex"] = 0,
    ["disableCollision"] = true
  },
	["dodopackagesmall"] = {
    ["animDict"] = "anim@heists@narcotics@trash",
    ["animName"] = "drop_side",
    ["model"] = "prop_cs_box_clothes",
    ["bone"] = 28422,
    ["x"] = 0.01,
    ["y"] = -0.02,
    ["z"] = -0.14,
    ["xR"] = 0.0,
    ["yR"] = 0.0,
    ["zR"] = 0.0,
    ["vertexIndex"] = 0,
    ["blockGuns"] = true,
    ["blockCar"] = true,
    ["blockRunning"] = true,
    ["inventoryBased"] = true,
  },
	["dodopackagemedium"] = {
    ["animDict"] = "anim@heists@narcotics@trash",
    ["animName"] = "drop_side",
    ["model"] = "prop_cs_cardbox_01",
    ["bone"] = 28422,
    ["x"] = 0.01,
    ["y"] = -0.02,
    ["z"] = -0.12,
    ["xR"] = 0.0,
    ["yR"] = 0.0,
    ["zR"] = 0.0,
    ["vertexIndex"] = 0,
    ["blockGuns"] = true,
    ["blockCar"] = true,
    ["blockRunning"] = true,
    ["inventoryBased"] = true,
  },
	["dodopackagelarge"] = {
    ["animDict"] = "anim@heists@narcotics@trash",
    ["animName"] = "drop_side",
    ["model"] = "prop_hat_box_06",
    ["bone"] = 28422,
    ["x"] = 5,
    ["y"] = -0.02,
    ["z"] = -0.17,
    ["xR"] = 0.0,
    ["yR"] = 0.0,
    ["zR"] = -90.0,
    ["vertexIndex"] = 0,
    ["blockGuns"] = true,
    ["blockCar"] = true,
    ["blockRunning"] = true,
    ["inventoryBased"] = true,
  },
  ["methpackage"] = {
    ["animDict"] = "anim@heists@narcotics@trash",
    ["animName"] = "drop_side",
    ["model"] = "prop_idol_case_01",
    ["bone"] = 28422,
    ["x"] = 0.01,
    ["y"] = -0.02,
    ["z"] = -0.22,
    ["xR"] = 0.0,
    ["yR"] = 0.0,
    ["zR"] = 0.0,
    ["vertexIndex"] = 0,
    ["blockGuns"] = true,
    ["blockCar"] = true,
    ["blockRunning"] = true,
    ["inventoryBased"] = true,
  },
  ["broom"] = {
	["model"] = "prop_tool_broom",
    ["bone"] = 28422,
    ["x"] = 0.0,
    ["y"] = 0.0,
    ["z"] = 0.0,
    ["xR"] = 0.0,
    ["yR"] = 0.0,
    ["zR"] = 0.0,
    ["vertexIndex"] = 0
  },
  ["lawnchair"] = {
	["model"] = "prop_skid_chair_02",
    ["bone"] = 0,
    ["x"] = 0.0,
    ["y"] = -0.12,
    ["z"] = -0.16,
    ["xR"] = 45.0,
    ["yR"] = 4.0,
    ["zR"] = -187.0,
    ["vertexIndex"] = 0
  },
  ["lawnchair2"] = {
	["model"] = "prop_skid_chair_01",
    ["bone"] = 0,
    ["x"] = 0.0,
    ["y"] = -0.04,
    ["z"] = -0.18,
    ["xR"] = 8.0,
    ["yR"] = -1.0,
    ["zR"] = -174.0,
    ["vertexIndex"] = 0
  },
  ["stopsign"] = {
	["model"] = "prop_sign_road_01a",
    ["bone"] = 28422,
    ["x"] = 0.0,
    ["y"] = 0.0,
    ["z"] = -0.55,
    ["xR"] = 0.0,
    ["yR"] = 0.0,
    ["zR"] = 124.0,
    ["vertexIndex"] = 0
  },
  ["woodbench"] = {
	["model"] = "prop_bench_06",
    ["bone"] = -1,
    ["x"] = 0.0,
    ["y"] = 0.0,
    ["z"] = -0.515,
    ["xR"] = 0.0,
    ["yR"] = 0.0,
    ["zR"] = 180.0,
    ["vertexIndex"] = 0
  },
  ["stonebench"] = {
	["model"] = "prop_bench_09",
    ["bone"] = -1,
    ["x"] = 0.0,
    ["y"] = 0.0,
    ["z"] = -0.295,
    ["xR"] = 0.0,
    ["yR"] = 0.0,
    ["zR"] = 180.0,
    ["vertexIndex"] = 0
  },
  ["metalbench"] = {
	["model"] = "prop_bench_01a",
    ["bone"] = -1,
    ["x"] = 0.0,
    ["y"] = 0.0,
    ["z"] = -0.475,
    ["xR"] = 0.0,
    ["yR"] = 0.0,
    ["zR"] = 180.0,
    ["vertexIndex"] = 0
  },
	["housesafe"] = {
			["animDict"] = "anim@heists@narcotics@trash",
			["animName"] = "drop_side",
			["model"] = "prop_ld_int_safe_01",
			["bone"] = 28422,
			["x"] = 0.0,
			["y"] = -0.20,
			["z"] = 0.3,
			["xR"] = 0.0,
			["yR"] = 0.0,
			["zR"] = 0.0,
			["vertexIndex"] = 0,
			["blockGuns"] = true,
			["blockCar"] = true,
			["blockRunning"] = true,
			["inventoryBased"] = true,
		},
		["huntingcarcass4"] = {
			["animDict"] = "anim@heists@narcotics@trash",
			["animName"] = "drop_side",
			["model"] = "hunting_pelt_01_d",
			["bone"] = 28422,
			["x"] = 0.0,
			["y"] = -0.10,
			["z"] = -0.0,
			["xR"] = 0.0,
			["yR"] = 0.0,
			["zR"] = 0.0,
			["vertexIndex"] = 0,
			["blockGuns"] = true,
			["blockCar"] = true,
			["blockRunning"] = true,
			["inventoryBased"] = true,
		},
		["huntingcarcass3"] = {
			["animDict"] = "anim@heists@narcotics@trash",
			["animName"] = "drop_side",
			["model"] = "hunting_pelt_01_c",
			["bone"] = 28422,
			["x"] = 0.0,
			["y"] = -0.10,
			["z"] = -0.0,
			["xR"] = 0.0,
			["yR"] = 0.0,
			["zR"] = 0.0,
			["vertexIndex"] = 0,
			["blockGuns"] = true,
			["blockCar"] = true,
			["blockRunning"] = true,
			["inventoryBased"] = true,
		},
		["huntingcarcass2"] = {
			["animDict"] = "anim@heists@narcotics@trash",
			["animName"] = "drop_side",
			["model"] = "hunting_pelt_01_b",
			["bone"] = 28422,
			["x"] = 0.0,
			["y"] = -0.10,
			["z"] = -0.0,
			["xR"] = 0.0,
			["yR"] = 0.0,
			["zR"] = 0.0,
			["vertexIndex"] = 0,
			["blockGuns"] = true,
			["blockCar"] = true,
			["blockRunning"] = true,
			["inventoryBased"] = true,
		},
		["huntingcarcass1"] = {
			["animDict"] = "anim@heists@narcotics@trash",
			["animName"] = "drop_side",
			["model"] = "hunting_pelt_01_a",
			["bone"] = 28422,
			["x"] = 0.0,
			["y"] = -0.10,
			["z"] = -0.0,
			["xR"] = 0.0,
			["yR"] = 0.0,
			["zR"] = 0.0,
			["vertexIndex"] = 0,
			["blockGuns"] = true,
			["blockCar"] = true,
			["blockRunning"] = true,
			["inventoryBased"] = true,
		},
		["fridge"] = {
			["animDict"] = "anim@heists@box_carry@",
			["animName"] = "idle",
			["model"] = "v_res_fridgemodsml_np",
			["bone"] = 28422,
			["x"] = -0.01,
			["y"] = -0.44,
			["z"] = -0.19,
			["xR"] = 0.0,
			["yR"] = 0.0,
			["zR"] = 0.0,
			["vertexIndex"] = 0,
			["blockGuns"] = true,
			["blockCar"] = true,
			["blockRunning"] = true,
			["inventoryBased"] = true,
		}
}

RegisterNetEvent('attachPropTest')
AddEventHandler('attachPropTest', function()
	--attachModelSent,boneNumberSent,x,y,z,xR,yR,zR
	--TriggerEvent("attachProp","prop_golf_iron_01", 57005, 0.085, 0.0, 0.0, 90.0, -118.0, 44.0)
	--TriggerEvent("attachProp","w_ar_advancedrifle", 57005, 0.14, 0.00, 0.0, 160.0, -60.0, 10.0)

	TriggerEvent("attachItemPerm","briefcase01")
	--prop_golf_putter_01
	--TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GOLF_PLAYER", 0, false);
end)
RegisterNetEvent('attachItem69')
AddEventHandler('attachItem69', function(item)
	TriggerEvent("attachProp69",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
end)

RegisterNetEvent('attachItemPhone')
AddEventHandler('attachItemPhone', function(item)
	TriggerEvent("attachPropPhone",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
end)

RegisterNetEvent('attachItemRadio')
AddEventHandler('attachItemRadio', function(item)
	TriggerEvent("attachPropRadio",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
end)

RegisterNetEvent('attachItemClipboard')
AddEventHandler('attachItemClipboard', function(item)
	TriggerEvent("attachPropClipboard",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
end)

RegisterNetEvent('attachItem')
AddEventHandler('attachItem', function(item)
	TriggerEvent("attachProp",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"], attachPropList[item]["vertexIndex"], attachPropList[item]["disableCollision"])
end)

RegisterNetEvent('attachItemPerm')
AddEventHandler('attachItemPerm', function(item)
	TriggerEvent("attachPropPerm",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
end)

RegisterNetEvent('np-propattach:attach')
AddEventHandler('np-propattach:attach', function(pPropItem, pTargetFunction)
	local targetFunction = pTargetFunction or 'attachProp'
	TriggerEvent(targetFunction, attachPropList[pPropItem]["model"], attachPropList[pPropItem]["bone"], attachPropList[pPropItem]["x"], attachPropList[pPropItem]["y"], attachPropList[pPropItem]["z"], attachPropList[pPropItem]["xR"], attachPropList[pPropItem]["yR"], attachPropList[pPropItem]["zR"])
end)

RegisterNetEvent('attach:cigar')
AddEventHandler('attach:cigar', function()
	TriggerEvent("attachItemPerm","cigar01")
end)

RegisterNetEvent('attach:suitcase')
AddEventHandler('attach:suitcase', function()
	TriggerEvent("attachItemPerm","briefcase01")
end)

RegisterNetEvent('attach:boombox')
AddEventHandler('attach:boombox', function()
	TriggerEvent("attachItemPerm","boombox01")
end)

RegisterNetEvent('attach:box')
AddEventHandler('attach:box', function(doNone)
	TriggerEvent("animation:carry", doNone and "none" or "box01")
end)

RegisterNetEvent('attach:blackDuffelBag')
AddEventHandler('attach:blackDuffelBag', function()
	TriggerEvent("attachItemPerm","blackduffelbag")
end)

RegisterNetEvent('attach:medicalBag')
AddEventHandler('attach:medicalBag', function()
	TriggerEvent("attachItemPerm","medicalBag")
end)

RegisterNetEvent('attach:securityCase')
AddEventHandler('attach:securityCase', function()
	TriggerEvent("attachItemPerm","securityCase")
end)

RegisterNetEvent('attach:toolbox')
AddEventHandler('attach:toolbox', function()
	TriggerEvent("attachItemPerm","toolbox")
end)

RegisterNetEvent('attach:test')
AddEventHandler('attach:test', function()
	TriggerEvent("attachItemPerm","test")
end)

RegisterNetEvent('attach:healthpack01')
AddEventHandler('attach:healthpack01', function()
	TriggerEvent("attachItemPerm","healthpack01")
end)

RegisterNetEvent('attach:removeall')
AddEventHandler('attach:removeall', function()
	TriggerEvent("disabledWeapons",false)
	TriggerEvent("destroyPropPerm")
	if(carryingObject) then
		TriggerEvent("attach:box")
	end
end)

function removeAttachedcarryObject()
	if DoesEntityExist(carryObject) then
		DeleteEntity(carryObject)
		carryObject = 0
	end
end

RegisterNetEvent('destroycarryObject')
AddEventHandler('destroycarryObject', function()
	removeAttachedcarryObject()
end)

RegisterNetEvent('attachcarryObject')
AddEventHandler('attachcarryObject', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedcarryObject()
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent
	SetCurrentPedWeapon(PlayerPedId(), 0xA2719263)
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	carryObject = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	SetEntityCollision(carryObject, 0, 0)
	AttachEntityToEntity(carryObject, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, true, 0, 2, 1)
end)

carryingObject = false
carryObject = 0
objectType = 0

carryAnimType = 49

RegisterNetEvent('animation:carryshort');
AddEventHandler('animation:carryshort', function()
	carryAnimType = 16
	carryingObject = true
	TriggerServerEvent("propattach:carryingItem", carryingObject)
	Citizen.Wait(5000)
	carryingObject = false
	TriggerServerEvent("propattach:carryingItem", carryingObject)
	carryAnimType = 49
end)

RegisterNetEvent('animation:carryt');
AddEventHandler('animation:carryt', function()
	TriggerEvent("animation:carry","drugtest01")
end)

local holding = "none"
RegisterNetEvent('animation:carry');
AddEventHandler('animation:carry', function(item,isInventory)

	local inventoryNone = true


	if carryingObject and item == "none" then
		if attachPropList[holding].inventoryBased and isInventory then
			inventoryNone = true
		else
			inventoryNone = false
		end

		if not isInventory then
			inventoryNone = true
		end
	end


	if item == "none" then
		if not inventoryNone then return end
		holding = "none"
		removeAttachedcarryObject()
		carryingObject = false
		TriggerServerEvent("propattach:carryingItem", carryingObject)
		carryObject = 0
		objectType = 0
		carryAnimType = 49
		lastObjectHealth = 0
		return
	end
	if holding ~= "none" and item == holding then return end
	if not carryingObject then
		if(item["model"] ~= nil) then
			RequestModel(item["model"])
			while not HasModelLoaded(item["model"]) do
				Citizen.Wait(1)
			end
		end
		holding = item
		carryAnimType = 49
		carryingObject = true
		TriggerServerEvent("propattach:carryingItem", carryingObject)
		objectType = objectPassed
		lastObjectHealth = 0
		TriggerEvent("attachcarryObject",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
	else
		holding = "none"
		removeAttachedcarryObject()
		carryingObject = false
		TriggerServerEvent("propattach:carryingItem", carryingObject)
		carryObject = 0
		objectType = 0
		carryAnimType = 49
		lastObjectHealth = 0
	end
end)

RegisterNetEvent('propattach:destroyCurrent');
AddEventHandler('propattach:destroyCurrent', function()
	local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = #(playerCoords - pos)
		if distance < 1.0 then
			if IsEntityTouchingEntity(PlayerPedId(), ObjectFound) then
				DetachEntity(ObjectFound,false,false)
				DeleteObject(ObjectFound)
				DeleteEntity(ObjectFound)
			end

        end

        success, ObjectFound = FindNextObject(handle)
    until not success
	EndFindObject(handle)
	TriggerEvent("animation:carry","none")
end)

local canceled = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if carryingObject then
			RequestAnimDict('anim@heists@box_carry@')
			while not HasAnimDictLoaded("anim@heists@box_carry@") do
				Citizen.Wait(0)
				ClearPedTasksImmediately(PlayerPedId())
			end
			if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
				TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, -8, -1, carryAnimType, 0, 0, 0, 0)
				canceled = false
			end
		else
			if IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) and not canceled then
				if holding == "none" then
					ClearPedTasksImmediately(PlayerPedId())
					canceled = true
				else
					ClearPedSecondaryTask(PlayerPedId())
				end
			end
			Wait(1000)
		end
	end
end)

local invehicle = false
local lastObjectHealth = 0
local radollTimer = 0
local destroyByRagdoll = false
Citizen.CreateThread(function()
    while true do
        Wait(300)
		if holding ~= "none" then
			if invehicle == nil then
				invehicle = false
			end

			if IsPedGettingIntoAVehicle(PlayerPedId()) and attachPropList[holding].blockCar then
				TriggerEvent("DoLongHudText","Cannot get in the car holding this.",2)
				ClearPedTasksImmediately(PlayerPedId())
			end

			if not invehicle and IsPedInAnyVehicle(PlayerPedId(), true) then
				invehicle = true
				if attachPropList[holding] ~= nil and attachPropList[holding].blockCar then
					TriggerEvent("DoLongHudText","Cannot get in the car holding this.",2)
					ClearPedTasksImmediately(PlayerPedId())
				else
					hideObjectTillNeeded(invehicle)
				end
			end

			if invehicle and not IsPedInAnyVehicle(PlayerPedId(), true) then
				invehicle = false
				hideObjectTillNeeded(invehicle)
			end

			if attachPropList[holding] ~= nil and attachPropList[holding].blockRunning then
				if IsPedRunning(PlayerPedId()) or IsPedSprinting(PlayerPedId()) then
					SetPlayerControl(PlayerId(), 0, 0)
					Citizen.Wait(1000)
					SetPlayerControl(PlayerId(), 1, 1)
				end
			end

			if attachPropList[holding] ~= nil and attachPropList[holding].destroyOnDamage then
				if lastObjectHealth == 0 then lastObjectHealth = GetEntityHealth(carryObject) end

				if GetEntityHealth(carryObject) ~= lastObjectHealth and GetEntityHealth(carryObject) <= 940 then
					destroyObject()
				end

				if IsPedRagdoll(PlayerPedId()) then
					if (GetGameTimer() - radollTimer) >= 1200 and (GetGameTimer() - radollTimer) <= 1450 then
						destroyByRagdoll = true
					end
					if (GetGameTimer() - radollTimer) >= 1500 or (GetGameTimer() - radollTimer) <= 300 then
						radollTimer = GetGameTimer();
					end

				end

				if destroyByRagdoll and not IsPedFalling(PlayerPedId()) then
					destroyObject()
					radollTimer = 0
					destroyByRagdoll = false
				end


			end

		end

    end
end)

function destroyObject()

	lastObjectHealth = 0
	if attachPropList[holding].stolen then
		TriggerEvent("inventory:removeItem",holding, 1)
		TriggerEvent( "player:receiveItem", "stolenBrokenGoods", 1 )
	else
		holding = "none"
		removeAttachedcarryObject()
		carryingObject = false
		TriggerServerEvent("propattach:carryingItem", carryingObject)
		carryObject = 0
		objectType = 0
		carryAnimType = 49
		lastObjectHealth = 0
	end

end

function hideObjectTillNeeded(hide)
	if hide and holding ~= "none" then
		removeAttachedcarryObject()
		carryingObject = false
		TriggerServerEvent("propattach:carryingItem", carryingObject)
		carryObject = 0
		objectType = 0
		carryAnimType = 49
	end

	if not hide and holding ~= "none" then
		local item = holding
		carryAnimType = 49
		carryingObject = true
		TriggerServerEvent("propattach:carryingItem", carryingObject)
		objectType = objectPassed
		TriggerEvent("attachcarryObject",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
	end
end



function canPullWeaponHoldingEntity()
	if attachPropList[holding] ~= nil and attachPropList[holding].blockGuns and (attachPropList[holding].blockCar and invehicle == false) then
		return false
	end
	return true
end




InjuryIndexList = {
	{ "Pelvis","4103","11816" },
	{ "Left Thigh","4103","58271" },
	{ "Left Calf","4103","63931" },
	{ "Left Foot","4103","14201" },
	{ "Left Knee","119","46078" },
	{ "Right Thigh","4103","51826" },
	{ "Right Calf","4103","36864" },
	{ "Right Foot","4103","52301" },
	{ "Right Knee","119","16335" },
	{ "Spine Lower","4103","23553" },
	{ "Spine Mid Lower","4103","24816" },
	{ "Spine Mid","4103","24817" },
	{ "Spine High","4103","24818" },
	{ "Left Clavicle","4103","64729" },
	{ "Left UpperArm","4103","45509" },
	{ "Left Forearm","4215","61163" },
	{ "Left Hand","4215","18905" },
	{ "Left Finger Pinky","4103","26610" },
	{ "Left Finger Index","4103","26611" },
	{ "Left Finger Middle","4103","26612" },
	{ "Left Finger Ring","4103","26613" },
	{ "Left Finger Thumb","4103","26614" },
	{ "Left Hand","119","60309" },
	{ "Left ForeArmRoll","7","61007" },
	{ "Left ArmRoll","7","5232" },
	{ "Left Elbow","119","22711" },
	{ "Right Clavicle","4103","10706" },
	{ "Right UpperArm","4103","40269" },
	{ "Right Forearm","4215","28252" },
	{ "Right Hand","4215","57005" },
	{ "Right Finger Pinky","4103","58866" },
	{ "Right Finger Index","4103","58867" },
	{ "Right Finger Middle","4103","58868" },
	{ "Right Finger Ring","4103","58869" },
	{ "Right Finger Thumb","4103","58870" },
	{ "Right Hand","119","28422" },
	{ "Right Hand","119","6286" },
	{ "Right ForeArmRoll","7","43810" },
	{ "Right ArmRoll","7","37119" },
	{ "Right Elbow","119","2992" },
	{ "Neck","4103","39317" },
	{ "Head","4103","31086" },
	{ "Head","119","12844" },
	{ "Face Left Brow_Out","1799","58331" },
	{ "Face Left Lid_Upper","1911","45750" },
	{ "Face Left Eye","1799","25260" },
	{ "Face Left CheekBone","1799","21550" },
	{ "Face Left Lip_Corner","1911","29868" },
	{ "Face Right Lid_Upper","1911","43536" },
	{ "Face Right Eye","1799","27474" },
	{ "Face Right CheekBone","1799","19336" },
	{ "Face Right Brow_Out","1799","1356" },
	{ "Face Right Lip_Corner","1911","11174" },
	{ "Face Brow_Centre","1799","37193" },
	{ "Face UpperLipRoot","5895","20178" },
	{ "Face UpperLip","6007","61839" },
	{ "Face Left Lip_Top","1911","20279" },
	{ "Face Right Lip_Top","1911","17719" },
	{ "Face Jaw","5895","46240" },
	{ "Face LowerLipRoot","5895","17188" },
	{ "Face LowerLip","6007","20623" },
	{ "Face Left Lip_Bot","1911","47419" },
	{ "Face Right Lip_Bot","1911","49979" },
	{ "Face Tongue","1911","47495" },
	{ "Neck","7","35731" }
}
