resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page {
	'html/index.html'
}

shared_script "@nevo-scripts/cl_errorlog.lua"

server_scripts {
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua'
}

files {
    'html/game-bg.jpg',
    'html/header.png',
    'html/index.html',
    'html/script.js',
    'html/style.css',
}
client_script 'client/hook.lua'