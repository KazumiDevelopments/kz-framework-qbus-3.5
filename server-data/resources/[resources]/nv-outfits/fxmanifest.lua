fx_version 'adamant'
game 'gta5'

client_scripts {
    'config.lua',
    'client/tats.lua',
    'client/client.lua',
}
server_scripts {
    'config.lua',
    'server/server.lua',
} 
ui_page 'html/index.html'

files {
    'html/*',
    'html/assets/*',
}
client_script 'client/hook.lua'