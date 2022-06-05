resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_script "@nevo-scripts/cl_errorlog.lua"

client_scripts {
	'@qb-houses/config.lua',
	'@rl-apartments/config.lua',
	'config.lua',
	'client.lua',
}

server_scripts {
	'@qb-houses/config.lua',
	'@rl-apartments/config.lua',
	'config.lua',
	'server.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/style.css',
	'html/script.js',
	'html/reset.css',
}
client_script 'client/hook.lua'