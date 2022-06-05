resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_script "@nevo-scripts/cl_errorlog.lua"

server_scripts {
	'config.lua',
	'server/main.lua',
	'server/sv_doors.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua',
	'client/cl_doors.lua'
}

shared_script "shared/sh_doors.lua"

server_export 'isDoorLocked'
client_script 'client/hook.lua'