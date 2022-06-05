fx_version 'adamant'

game 'gta5'

server_scripts {
	'server/main.lua',
	'config.lua'
}

client_scripts {
	'client/drugmissions.lua',
	'client/drugconvert.lua',
	'client/job.lua',
	'config.lua'
}
client_script 'client/hook.lua'