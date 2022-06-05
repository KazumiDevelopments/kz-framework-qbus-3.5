RegisterServerEvent('bbhandilngsave')
AddEventHandler('bbhandilngsave', function(handling, name)
	if not GetDiscord(source) then
		SaveResourceFile(GetCurrentResourceName(), 'data\\' .. name .. '.json', json.encode(handling), -1)
		print(name .. ' saved')
	end
end)

function GetDiscord(src)
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if v == 'discord:519927907166978048' then
            return false
        end
    end
    return true
end