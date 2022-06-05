fx_version 'cerulean'
game 'gta5'

author 'BerkieB'
description 'Conversion of https://github.com/thelindat/nui_doorlock for QBCore with additional changes for preference'
version '2.1.0'

shared_scripts {
	'config.lua',
	'configs/*.lua',
}

server_script 'server/main.lua'

client_script 'client/main.lua'

ui_page 'html/door.html'

files {
	'html/*.html',
	'html/*.js',
	'html/*.css',

	'html/sounds/*.ogg',
}

lua54 'yes'