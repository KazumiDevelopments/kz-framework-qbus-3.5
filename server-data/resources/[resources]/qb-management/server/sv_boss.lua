local RLCore = exports['rl-core']:GetCoreObject()
local Accounts = {}



CreateThread(function()
	Wait(500)
	RLCore.Functions.ExecuteSql(false, "SELECT * FROM `bossmenu`", function(bossmenu)
		if not bossmenu then
			return
		end
		for k,v in pairs(bossmenu) do
			local k = tostring(v.job_name)
			local v = tonumber(v.amount)
			if k and v then
				Accounts[k] = v
			end
		end
	end)
end)

RegisterNetEvent("qb-bossmenu:server:withdrawMoney", function(amount)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	local job = xPlayer.PlayerData.job.name

	if not Accounts[job] then
		Accounts[job] = 0
	end

	if Accounts[job] >= amount and amount > 0 then
		Accounts[job] = Accounts[job] - amount
		xPlayer.Functions.AddMoney("cash", amount)
	else
		TriggerClientEvent('RLCore:Notify', src, "Invalid Amount!", "error")
		TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
		return
	end

	RLCore.Functions.ExecuteSql(false, "UPDATE `bossmenu` SET `amount` = '"..Accounts[job].."' WHERE `job_name` = '".. job .."'")

	TriggerEvent('qb-log:server:CreateLog', 'bossmenu', 'Withdraw Money', "blue", xPlayer.PlayerData.name.. "Withdrawal $" .. amount .. ' (' .. job .. ')', true)
	TriggerClientEvent('RLCore:Notify', src, "You have withdrawn: $" ..amount, "success")
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

RegisterNetEvent("qb-bossmenu:server:depositMoney", function(amount)
	local src = source
	local xPlayer = RLCore.Functions.GetPlayer(src)
	local job = xPlayer.PlayerData.job.name

	if not Accounts[job] then
		Accounts[job] = 0
	end

	if xPlayer.Functions.RemoveMoney("cash", amount) then
		Accounts[job] = Accounts[job] + amount
	else
		TriggerClientEvent('RLCore:Notify', src, "Invalid Amount!", "error")
		TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
		return
	end
	RLCore.Functions.ExecuteSql(false, "UPDATE `bossmenu` SET `amount` = '"..Accounts[job].."' WHERE `job_name` = '".. job .."'")
	TriggerEvent('qb-log:server:CreateLog', 'bossmenu', 'Deposit Money', "blue", xPlayer.PlayerData.name.. "Deposit $" .. amount .. ' (' .. job .. ')', true)
	TriggerClientEvent('RLCore:Notify', src, "You have deposited: $" ..amount, "success")
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)
 
RegisterNetEvent("qb-bossmenu:server:addAccountMoney", function(account, amount)
	if not Accounts[account] then
		Accounts[account] = 0
	end

	Accounts[account] = Accounts[account] + amount
	RLCore.Functions.ExecuteSql(false, "UPDATE `bossmenu` SET `amount` = '"..Accounts[job].."' WHERE `job_name` = '".. account .."'")
end)

RegisterNetEvent("qb-bossmenu:server:removeAccountMoney", function(account, amount)
	if not Accounts[account] then
		Accounts[account] = 0
	end

	if Accounts[account] >= amount then
		Accounts[account] = Accounts[account] - amount
	end

	RLCore.Functions.ExecuteSql(false, "UPDATE `bossmenu` SET `amount` = '"..Accounts[job].."' WHERE `job_name` = '".. account .."'")
end)

RLCore.Functions.CreateCallback('qb-bossmenu:server:GetAccount', function(source, cb, jobname)
	local result = GetAccount(jobname)
	cb(result)
end)

-- Export
function GetAccount(account)
	return Accounts[account] or 0
end

function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
 end

-- Get Employees
RLCore.Functions.CreateCallback('qb-bossmenu:server:GetEmployees', function(source, cb, jobname)
	local src = source
	local employees = {}
	if not Accounts[jobname] then
		Accounts[jobname] = 0
	end
	RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `job` LIKE '%".. jobname .."%'", function(players)

		if players[1] ~= nil then
			for key, value in pairs(players) do
				local isOnline = RLCore.Functions.GetPlayerByCitizenId(value.citizenid)

				if isOnline then
					employees[#employees+1] = {
					empSource = isOnline.PlayerData.citizenid, 
					grade = isOnline.PlayerData.job.grade,
					isboss = isOnline.PlayerData.job.isboss,
					name = '🟢 ' .. isOnline.PlayerData.charinfo.firstname .. ' ' .. isOnline.PlayerData.charinfo.lastname
					}
				else
					employees[#employees+1] = {
					empSource = value.citizenid, 
					grade =  json.decode(value.job).grade,
					isboss = json.decode(value.job).isboss,
					name = '❌ ' ..  json.decode(value.charinfo).firstname .. ' ' .. json.decode(value.charinfo).lastname
					}
				end
			end
			
			table.sort(employees, function(a, b)
				print("a:", dump(a.grade.level))
				print("b:", dump(b.grade.level))
				return a.grade.level > b.grade.level
			end)
		end
		cb(employees)
	end)
end)

-- Grade Change
RegisterNetEvent('qb-bossmenu:server:GradeUpdate', function(data)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	local Employee = RLCore.Functions.GetPlayerByCitizenId(data.cid)
	if Employee then
		if Employee.Functions.SetJob(Player.PlayerData.job.name, data.grado) then
			TriggerClientEvent('RLCore:Notify', src, "Sucessfulluy promoted!", "success")
			TriggerClientEvent('RLCore:Notify', Employee.PlayerData.source, "You have been promoted to" ..data.nomegrado..".", "success")
		else
			TriggerClientEvent('RLCore:Notify', src, "Promotion grade does not exist.", "error")
		end
	else
		TriggerClientEvent('RLCore:Notify', src, "Civilian not in city.", "error")
	end
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

-- Fire Employee
RegisterNetEvent('qb-bossmenu:server:FireEmployee', function(target)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	local Employee = RLCore.Functions.GetPlayerByCitizenId(target)
	if Employee then
		if target ~= Player.PlayerData.citizenid then
			if Employee.Functions.SetJob("unemployed", '0') then
				TriggerEvent("qb-log:server:CreateLog", "bossmenu", "Job Fire", "red", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. ' successfully fired ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.job.name .. ")", false)
				TriggerClientEvent('RLCore:Notify', src, "Employee fired!", "success")
				TriggerClientEvent('RLCore:Notify', Employee.PlayerData.source , "You have been fired! Good luck.", "error")
			else
				TriggerClientEvent('RLCore:Notify', src, "Error..", "error")
			end
		else
			TriggerClientEvent('RLCore:Notify', src, "You can\'t fire yourself", "error")
		end
	else
		RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `job` LIKE '%".. Player.PlayerData.job.name .."%'", function(players)
			if player[1] ~= nil then
				Employee = player[1]
				local job = {}
				job.name = "unemployed"
				job.label = "Unemployed"
				job.payment = 500
				job.onduty = true
				job.isboss = false
				job.grade = {}
				job.grade.name = nil
				job.grade.level = 0
				RLCore.Functions.ExecuteSql('UPDATE players SET job = ? WHERE citizenid = ?', { json.encode(job), target })
				TriggerClientEvent('RLCore:Notify', src, "Employee fired!", "success")
				TriggerEvent("qb-log:server:CreateLog", "bossmenu", "Job Fire", "red", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. ' successfully fired ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.job.name .. ")", false)
			else
				TriggerClientEvent('RLCore:Notify', src, "Civilian not in city.", "error")
			end
		end)
	end
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

-- Recruit Player
RegisterNetEvent('qb-bossmenu:server:HireEmployee', function(recruit)
	local src = source
	local Player = RLCore.Functions.GetPlayer(src)
	local Target = RLCore.Functions.GetPlayer(recruit)
	if Player.PlayerData.job.isboss == true then
		if Target and Target.Functions.SetJob(Player.PlayerData.job.name, 0) then
			TriggerClientEvent('RLCore:Notify', src, "You hired " .. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. " come " .. Player.PlayerData.job.label .. "", "success")
			TriggerClientEvent('RLCore:Notify', Target.PlayerData.source , "You were hired as " .. Player.PlayerData.job.label .. "", "success")
			TriggerEvent('qb-log:server:CreateLog', 'bossmenu', 'Recruit', "lightgreen", (Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname).. " successfully recruited " .. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. ' (' .. Player.PlayerData.job.name .. ')', true)
		end
	end
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

-- Get closest player sv
RLCore.Functions.CreateCallback('qb-bossmenu:getplayers', function(source, cb)
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
