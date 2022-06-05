local RLCore = exports['rl-core']:GetCoreObject()
local GangaccountGangs = {}

CreateThread(function()
	Wait(500)
	RLCore.Functions.ExecuteSql(false, "SELECT * FROM `gangmenu`", function(gangmenu)
		if not gangmenu then
			return
		end
		for k,v in pairs(gangmenu) do
			local k = tostring(v.job_name)
			local v = tonumber(v.amount)
			if k and v then
				GangaccountGangs[k] = v
			end
		end
	end)
end)

RegisterNetEvent("qb-gangmenu:server:withdrawMoney", function(amount)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	local gang = xPlayer.PlayerData.gang.name

	if not GangaccountGangs[gang] then
		GangaccountGangs[gang] = 0
	end

	if GangaccountGangs[gang] >= amount and amount > 0 then
		GangaccountGangs[gang] = GangaccountGangs[gang] - amount
		xPlayer.Functions.AddMoney("cash", amount, 'Boss menu withdraw')
	else
		TriggerClientEvent('RLCore:Notify', src, "Invalid amount!", "error")
		TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
		return
	end
	RLCore.Functions.ExecuteSql(false, "UPDATE `gangmenu` SET `amount` = '"..GangaccountGangs[gang].."' WHERE `job_name` = '".. gang .."'")
	TriggerEvent('qb-log:server:CreateLog', 'gangmenu', 'Withdraw Money', 'yellow', xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname .. ' successfully withdrew $' .. amount .. ' (' .. gang .. ')', false)
	TriggerClientEvent('RLCore:Notify', src, "You have withdrawn: $" ..amount, "success")
	TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
end)

RegisterNetEvent("qb-gangmenu:server:depositMoney", function(amount)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	local gang = xPlayer.PlayerData.gang.name

	if not GangaccountGangs[gang] then
		GangaccountGangs[gang] = 0
	end

	if xPlayer.Functions.RemoveMoney("cash", amount) then
		GangaccountGangs[gang] = GangaccountGangs[gang] + amount
	else
		TriggerClientEvent('RLCore:Notify', src, "Invalid amount!", "error")
		TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
		return
	end

	RLCore.Functions.ExecuteSql(false, "UPDATE `gangmenu` SET `amount` = '"..GangaccountGangs[gang].."' WHERE `job_name` = '".. gang .."'")
	TriggerEvent('qb-log:server:CreateLog', 'gangmenu', 'Deposit Money', 'yellow', xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname .. ' successfully deposited $' .. amount .. ' (' .. gang .. ')', false)
	TriggerClientEvent('RLCore:Notify', src, "You have deposited: $" ..amount, "success")
	TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
end)

RegisterNetEvent("qb-gangmenu:server:addaccountGangMoney", function(accountGang, amount)
	if not GangaccountGangs[accountGang] then
		GangaccountGangs[accountGang] = 0
	end

	GangaccountGangs[accountGang] = GangaccountGangs[accountGang] + amount
	RLCore.Functions.ExecuteSql(false, "UPDATE `gangmenu` SET `amount` = '"..GangaccountGangs[accountGang].."' WHERE `job_name` = '".. accountGang .."'")
end)

RegisterNetEvent("qb-gangmenu:server:removeaccountGangMoney", function(accountGang, amount)
	if not GangaccountGangs[accountGang] then
		GangaccountGangs[accountGang] = 0
	end

	if GangaccountGangs[accountGang] >= amount then
		GangaccountGangs[accountGang] = GangaccountGangs[accountGang] - amount
	end

	RLCore.Functions.ExecuteSql(false, "UPDATE `gangmenu` SET `amount` = '"..GangaccountGangs[accountGang].."' WHERE `job_name` = '".. accountGang .."'")
end)

RLCore.Functions.CreateCallback('qb-gangmenu:server:GetAccount', function(source, cb, GangName)
	local gangmoney = GetaccountGang(GangName)
	cb(gangmoney)
end)

-- Export
function GetaccountGang(accountGang)
	return GangaccountGangs[accountGang] or 0
end

-- Get Employees
RLCore.Functions.CreateCallback('qb-gangmenu:server:GetEmployees', function(source, cb, gangname)
	local src = source
	local employees = {}
	if not GangaccountGangs[gangname] then
		GangaccountGangs[gangname] = 0
	end

	RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `gang` LIKE '%".. gangname .."%'", function(players)
		if players[1] ~= nil then
			for key, value in pairs(players) do
				local isOnline = RLCore.Functions.GetPlayerByCitizenId(value.citizenid)

				if isOnline then
					employees[#employees+1] = {
					empSource = isOnline.PlayerData.citizenid,
					grade = isOnline.PlayerData.gang.grade,
					isboss = isOnline.PlayerData.gang.isboss,
					name = '🟢' .. isOnline.PlayerData.charinfo.firstname .. ' ' .. isOnline.PlayerData.charinfo.lastname
					}
				else
					employees[#employees+1] = {
					empSource = value.citizenid,
					grade =  json.decode(value.gang).grade,
					isboss = json.decode(value.gang).isboss,
					name = '❌' ..  json.decode(value.charinfo).firstname .. ' ' .. json.decode(value.charinfo).lastname
					}
				end
			end
		end
	end)
	cb(employees)
end)

-- Grade Change
RegisterNetEvent('qb-gangmenu:server:GradeUpdate', function(data)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	local Employee = RLCore.Functions.GetPlayerByCitizenId(data.cid)
	if Employee then
		if Employee.Functions.SetGang(Player.PlayerData.gang.name, data.grado) then
			TriggerClientEvent('RLCore:Notify', src, "Successfully promoted!", "success")
			TriggerClientEvent('RLCore:Notify', Employee.PlayerData.source, "You have been promoted to " ..data.nomegrado..".", "success")
		else
			TriggerClientEvent('RLCore:Notify', src, "Grade does not exist.", "error")
		end
	else
		TriggerClientEvent('RLCore:Notify', src, "Civilian is not in city.", "error")
	end
	TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
end)

-- Fire Member
RegisterNetEvent('qb-gangmenu:server:FireMember', function(target)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	local Employee = RLCore.Functions.GetPlayerByCitizenId(target)
	if Employee then
		if target ~= Player.PlayerData.citizenid then
			if Employee.Functions.SetGang("none", '0') then
				TriggerEvent("qb-log:server:CreateLog", "gangmenu", "Gang Fire", "orange", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. ' successfully fired ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.gang.name .. ")", false)
				TriggerClientEvent('RLCore:Notify', src, "Gang Member fired!", "success")
				TriggerClientEvent('RLCore:Notify', Employee.PlayerData.source , "You have been expelled from the gang!", "error")
			else
				TriggerClientEvent('RLCore:Notify', src, "Error.", "error")
			end
		else
			TriggerClientEvent('RLCore:Notify', src, "You can\'t kick yourself out of the gang!", "error")
		end
	else
		RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` LIKE '%".. target .."%'", function(players)
			if player[1] ~= nil then
				Employee = player[1]
				local gang = {}
				gang.name = "none"
				gang.label = "No Affiliation"
				gang.payment = 0
				gang.onduty = true
				gang.isboss = false
				gang.grade = {}
				gang.grade.name = nil
				gang.grade.level = 0
				RLCore.Functions.ExecuteSql('UPDATE players SET gang = ? WHERE citizenid = ?', {json.encode(gang), target})
				TriggerClientEvent('RLCore:Notify', src, "Gang member fired!", "success")
				TriggerEvent("qb-log:server:CreateLog", "gangmenu", "Gang Fire", "orange", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. ' successfully fired ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.gang.name .. ")", false)
			else
				TriggerClientEvent('RLCore:Notify', src, "Civilian is not in city.", "error")
			end
		end)
	end
	TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
end)

-- Recruit Player
RegisterNetEvent('qb-gangmenu:server:HireMember', function(recruit)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	local Target = RLCore.Functions.GetPlayer(recruit)
	if Player.PlayerData.gang.isboss == true then
		if Target and Target.Functions.SetGang(Player.PlayerData.gang.name, 0) then
			TriggerClientEvent('RLCore:Notify', src, "You hired " .. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. " come " .. Player.PlayerData.gang.label .. "", "success")
			TriggerClientEvent('RLCore:Notify', Target.PlayerData.source , "You have been hired as " .. Player.PlayerData.gang.label .. "", "success")
			TriggerEvent('qb-log:server:CreateLog', 'gangmenu', 'Recruit', 'yellow', (Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname).. ' successfully recruited ' .. Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.gang.name .. ')', false)
		end
	end
	TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
end)

-- Get closest player sv
RLCore.Functions.CreateCallback('qb-gangmenu:getplayers', function(source, cb)
	local src = source
	local players = {}
	local PlayerPed = GetPlayerPed(src)
	local pCoords = GetEntityCoords(PlayerPed)
	for k, v in pairs(RLCore.Functions.GetPlayers()) do
		local targetped = GetPlayerPed(v)
		local tCoords = GetEntityCoords(targetped)
		local dist = #(pCoords - tCoords)
		if PlayerPed ~= targetped and dist < 10 then
			local ped = RLCore.Functions.GetPlayer(v)
			players[#players+1] = {
			id = v,
			coords = GetEntityCoords(targetped),
			name = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname,
			citizenid = ped.PlayerData.citizenid,
			sources = GetPlayerPed(ped.PlayerData.source),
			sourceplayer = ped.PlayerData.source
			}
		end
	end
		table.sort(players, function(a, b)
			return a.name < b.name
		end)
	cb(players)
end)
