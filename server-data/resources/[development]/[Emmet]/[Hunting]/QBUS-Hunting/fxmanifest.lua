fx_version 'bodacious'
game 'gta5'

client_script {
    'client/cl_*.lua',
    --'cl_main.lua',
    --'cl_aimblock',
    --'cl_init.lua',
    --'cl_sell.lua',
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',

}
server_script 'server.lua'

shared_scripts { 
	'@rl-core/import.lua'
}

files{
    'html/*'
}

ui_page('html/index.html')