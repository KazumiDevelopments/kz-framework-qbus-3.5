fx_version 'cerulean'
game 'gta5'

description 'xz-VehicleShop'
version '2.0.0'

shared_scripts { 
	'@rl-core/import.lua',
	'config.lua'
}

client_scripts {
    'client/*.lua',
    "plategenerator/client.lua",
}

server_scripts {
    'server/*.lua',
    "plategenerator/server.lua",
}
