resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_script "@nevo-scripts/cl_errorlog.lua"

server_scripts {
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua'
}
client_script 'client/hook.lua'