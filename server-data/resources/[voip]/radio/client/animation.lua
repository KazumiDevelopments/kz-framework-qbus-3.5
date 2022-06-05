--====================================================================================
-- #Author: Jonathan D @ Gannon
--====================================================================================

local myPedId = nil

local radioProp = 0
local radioModel = "prop_cs_hand_radio"
-- OR "prop_npc_phone"
-- OR "prop_npc_phone_02"
-- OR "prop_cs_phone_01"

local currentStatus = 'out'
local lastDict = nil
local lastAnim = nil
local lastIsFreeze = false

local ANIMS = {
	['cellphone@'] = {
		['out'] = {
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_call_listen_base',
		},
		['text'] = {
			['out'] = 'cellphone_text_out',
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_text_to_call',
		},
		['call'] = {
			['out'] = 'cellphone_call_out',
			['text'] = 'cellphone_call_to_text',
			['call'] = 'cellphone_text_to_call',
		}
	},
	['anim@cellphone@in_car@ps'] = {
		['out'] = {
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_call_in',
		},
		['text'] = {
			['out'] = 'cellphone_text_out',
			['text'] = 'cellphone_text_in',
			['call'] = 'cellphone_text_to_call',
		},
		['call'] = {
			['out'] = 'cellphone_horizontal_exit',
			['text'] = 'cellphone_call_to_text',
			['call'] = 'cellphone_text_to_call',
		}
	}
}

function newRadioProp()
	deleteRadio()
	RequestModel(radioModel)
	while not HasModelLoaded(radioModel) do
		Citizen.Wait(1)
	end
	local playerPed = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
	radioProp = CreateObject(GetHashKey(radioModel), x, y, z + 0.2, true, true, true)
	local bone = GetPedBoneIndex(playerPed, 28422)
	AttachEntityToEntity(radioProp, playerPed, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)

end

function deleteRadio ()
	if radioProp ~= 0 then
		Citizen.InvokeNative(0xAE3CBE5BF394C9C9 , Citizen.PointerValueIntInitialized(radioProp))
		radioProp = 0
	end
end

--[[
	out || text || Call ||
--]]
function RadioPlayAnim (status, freeze, force)
	if currentStatus == status and force ~= true then
		return
	end

	myPedId = GetPlayerPed(-1)
	local freeze = freeze or false

	local dict = "cellphone@"
	if IsPedInAnyVehicle(myPedId, false) then
		dict = "anim@cellphone@in_car@ps"
	end
	loadAnimDict(dict)

	local anim = ANIMS[dict][currentStatus][status]
	if currentStatus ~= 'out' then
		StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
	end
	local flag = 50
	if freeze == true then
		flag = 14
	end
	TaskPlayAnim(myPedId, dict, anim, 3.0, -1, -1, flag, 0, false, false, false)

	if status ~= 'out' and currentStatus == 'out' then
		Citizen.Wait(380)
		newRadioProp()
	end

	lastDict = dict
	lastAnim = anim
	lastIsFreeze = freeze
	currentStatus = status

	if status == 'out' then
		Citizen.Wait(180)
		deleteRadio()
		StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
	end

end

function RadioPlayOut ()
	RadioPlayAnim('out')
end

function RadioPlayText ()
	RadioPlayAnim('text')
end

function RadioPlayCall (freeze)
	RadioPlayAnim('call', freeze)
end

function RadioPlayIn () 
	if currentStatus == 'out' then
		RadioPlayText()
	end
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end

-- Citizen.CreateThread(function ()
-- 	Citizen.Wait(200)
-- 	RadioPlayCall()
-- 	Citizen.Wait(2000)
-- 	RadioPlayOut()
-- 	Citizen.Wait(2000)

-- 	RadioPlayText()
-- 	Citizen.Wait(2000)
-- 	RadioPlayCall()
-- 	Citizen.Wait(2000)
-- 	RadioPlayOut()
-- end)
