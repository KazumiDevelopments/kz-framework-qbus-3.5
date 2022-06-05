fx_version 'cerulean'
game 'gta5'

description 'QB-MechanicJob'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
	'client/main.lua',
	'client/drivingdistance.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

exports {
	'GetVehicleStatusList',
	'GetVehicleStatus',
	'SetVehicleStatus',
}

lua54 'yes'
