fx_version 'cerulean'
game 'gta5'

description 'Nopixel inspired qb-garages'
version 'v2.1'
author 'Haritha#3955'

server_script {
    'Server/sv_main.lua',
}

client_script {
    'Client/cl_functions.lua',
    'Client/cl_main.lua'
}

shared_script {
    'config.lua',
    --'@rl-core/import.lua'
}