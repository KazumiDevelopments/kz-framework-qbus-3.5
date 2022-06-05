function DrawTxt(text, x, y)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.4)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

RegisterNUICallback("closeWindow", function(data, cb)
    SendNUIMessage({
		action = "closemenu",
	})
	SetNuiFocus(false, false)
    cb("ok")
end)

function openSaverMenu(x, y, z, h)
	local xpos, ypos, zpos, hpos = string.sub(tostring(x), 0, 9), string.sub(tostring(y), 0, 9), string.sub(tostring(z), 0, 9), string.sub(tostring(h), 0, 9)
	local tmpTable = { ['x'] = x, ['y'] = y, ['z'] = z, ['h'] = h}
	SendNUIMessage({
		action = "openmenu",
		x = xpos,
		y = ypos,
		z = zpos,
		h = hpos,
		json = json.encode(tmpTable)
	})
	SetNuiFocus(true, true)
end

RegisterCommand('coords', function()
	local coords = GetEntityCoords(PlayerPedId())
	openSaverMenu(coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()))
end)

RegisterCommand('nuifocus', function(source, args)
	SetNuiFocus(false, false)
end)
-- tr rl-multicharacter:client:chooseChar