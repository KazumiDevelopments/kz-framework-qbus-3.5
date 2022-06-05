Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

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
    RLCore.Functions.Notify("Press 7 to drop or pickup the object.")
	--TriggerEvent("DoLongHudText","Press 7 to drop or pickup the object.",37)
	
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

--[[ Citizen.CreateThread(function()
  exports["np-keybinds-1"]:registerKeyMapping("", "Player", "Drop Prop", "+propAttachDrop", "-propAttachDrop")
  RegisterCommand('+propAttachDrop', propAttachDrop, false)
  RegisterCommand('-propAttachDrop', function() end, false)
end)
 ]]
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if IsControlJustReleased(0, 161) and holdingPackage then
            propAttachDrop()
        end
    end
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

--[[ RegisterCommand('titanic', function(source, args, rawCommand) 
	local ped = PlayerPedId()
	local PlayerJob = RLCore.Functions.GetPlayerData().job
    local pedCoords = GetEntityCoords(ped, false)
	local vehicle, distance = RLCore.Functions.GetClosestVehicle()
	if PlayerJob.name == "police" then
		if vehicle == 466946 then
			if distance <= 90.0 then
				SetPedIntoVehicle(ped, vehicle, -1)	   
			end
		end
	else
		RLCore.Functions.Notify("You are not the captain..", "error")
	end
end, false) ]] 

Citizen.CreateThread(function()
	while true do
		Wait(0)
		Citizen.InvokeNative(0xC54A08C85AE4D410, 0.3)
	end
end)







