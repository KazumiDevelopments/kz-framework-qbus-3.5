fx_version 'cerulean'
game 'gta5'

description 'QB-Realestate job'
version '1.0.0'

shared_scripts {
	'@rl-core/import.lua', 
	'config.lua'
}

client_scripts {
	'client/main.lua',
	'client/menu.lua',
}

server_scripts {
	'server/main.lua',
	'server/menu.lua',
}
