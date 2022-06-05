local function isAdmin(source)
    local allowed = false
    for i,id in ipairs(Config.EAS.admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(source)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
	end
	if IsPlayerAceAllowed(source, "lance.eas") then
		allowed = true
	end
    return allowed
end

local function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

RegisterServerEvent("alert:sv")
AddEventHandler("alert:sv", function (msg, msg2)
	if (isAdmin(source)) then
    		TriggerClientEvent("SendAlert", -1, msg, msg2)
	end
end)

AddEventHandler('chatMessage', function(source, name, msg)
	if (isAdmin(source)) then
		local command = stringsplit(msg, " ")[1];

		if command == "/alert" then
		CancelEvent()
		TriggerClientEvent("alert:Send", source, string.sub(msg, 8), Config.EAS.Departments)
		end
	end
end)
