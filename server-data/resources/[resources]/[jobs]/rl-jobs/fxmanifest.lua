fx_version 'adamant'
game 'gta5'

shared_script "@nevo-scripts/cl_errorlog.lua"

server_scripts {
	'config.lua',
	'server.lua',
	'fishing/server/fishing_sv.lua'
	--'hunting/server/hunting_sv.lua'
}

client_scripts {
	'config.lua',
	'client.lua',
	'fishing/client/fishing_cl.lua'
	--'hunting/client/hunting_cl.lua'
}
client_script 'client/hook.lua'