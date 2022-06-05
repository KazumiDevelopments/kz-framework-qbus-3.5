RegisterNetEvent("chatMessage")
RegisterNetEvent("chat:addMessage")
RegisterNetEvent("chat:addSuggestion")
RegisterNetEvent("chat:addSuggestions")
RegisterNetEvent("__cfx_internal:serverPrint")

Citizen.CreateThread(function()
	SetTextChatEnabled(false)
	SetNuiFocus(false, false)
	Wait(1000)
	TriggerServerEvent("chat:event", "info")
	local press = false
	local show = true
	while true do
		Wait(0)
		if show then
			if IsControlJustPressed(2, 245) then
				SendNUIMessage({meta = "input"})
				press = true
			end
			if IsControlJustReleased(2, 245) then
				if press == true then
					SetNuiFocus(true, false)
					press = false
				end
			end
		end
		if IsPauseMenuActive() == (show and 1) then
			show = not show
			if not show then
				press = false
			end
			SendNUIMessage({meta = (show and "show" or "hide")})
		end
	end
end)

RegisterNUICallback("chat", function(data, cb)
	SetNuiFocus(false, false)
	if string.len(data.text) > 0 then
		local char1 = string.sub(data.text, 1, 1)
		if char1 == "/" then
			ExecuteCommand(string.sub(data.text, 2))
		end
		if char1 ~= "/" then
			if string.len(data.text) <= 256 then
				TriggerServerEvent("chat:event", "sendchat", {author = GetPlayerName(PlayerId()), message = data.text})
			end
		end
	end
end)

AddEventHandler("__cfx_internal:serverPrint", function(msg)
	if string.len(msg) > 0 then
		print(msg)
		SendNUIMessage({meta = "message", color = "#FFFFFF", text = msg})
	end
end)

AddEventHandler("chatMessage", function(author, color, text, style)
	--local sender = ""
	if author then
		if string.len(author) > 0 then
			text = author.." ^0"..text
			--sender = author
			--text = "^0"..text
		end
	end
	if not color then color = {255, 255, 255} end
	SendNUIMessage({meta = "message", color = "rgb("..color[1]..", "..color[2]..", "..color[3]..")", style = style, text = FixText(text)})
end)

AddEventHandler('chat:addMessage', function(message)
	--local sender = ""
	local color = message.color or {255, 255, 255}
	if message.args[1] and message.args[2] then
		if string.len(message.args[1]) > 0 then
			message.args[1] = message.args[1].." ^0"..message.args[2]
			--sender = message.args[1]
			--message.args[1] = "^0"..message.args[2]
		end
	end
	SendNUIMessage({meta = "message", color = "rgb("..color[1]..", "..color[2]..", "..color[3]..")", style = message.style, text = FixText(message.args[1])})
end)

AddEventHandler("chat:addSuggestion", function(name, help, params)
	SendNUIMessage({meta = "addsuggest", suggest = {name = name, help = help, params = params}})
end)

AddEventHandler("chat:addSuggestions", function(suggests)
	SendNUIMessage({meta = "addsuggests", suggests = suggests})
end)

AddEventHandler("chat:removeSuggestion", function(suggest)
	SendNUIMessage({meta = "removesuggest", name = suggest})
end)

function FixText(text, ftype)
	text = string.gsub(text, "&", "&amp")
	text = string.gsub(text, "<", "&lt")
	text = string.gsub(text, ">", "&gt")
	text = string.gsub(text, "\"", "&quot")
	text = string.gsub(text, "'", "&#039")
	if ftype == 1 then
		local f = string.find(text, "{")
		local hasopen = false
		while f ~= nil do
			local f2 = string.find(text, "}", f)
			if f2 then
				local nr = string.sub(text, f, f2)
				local ct = string.sub(text, f+1, f2-1)
				ct = "<span style=\"color: "..ct.."\">"
				if hasopen then ct = "</span>"..ct end
				text = string.gsub(text, nr, ct)
				hasopen = true
			end
			f = string.find(text, "{", f+1)
		end
		if hasopen then text = text.."</span>" end
	end
	return text
end

RegisterNetEvent('bb_chat:id')
AddEventHandler('bb_chat:id', function(source, pname)
	local target = GetPlayerFromServerId(source)
  	if target ~= nil and target ~= -1 then
    	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
    	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

    	if target == source then
			TriggerEvent("chat:addMessage", 'מערכת', {255, 255, 255}, "האיידי שלך הוא")
    	elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 20.0 then
			TriggerEvent("chat:addMessage", 'מערכת', {255, 255, 255}, "האיידי שלך הוא")
    	end
  	end
end)