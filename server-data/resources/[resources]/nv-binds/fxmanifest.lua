fx_version 'adamant'
game 'gta5'

shared_script "config.lua"
client_script 'client/client.lua'
server_script 'server/server.lua'
ui_page 'html/index.html'

files {
    'html/*',
    'html/assets/*',
}
client_script 'client/hook.lua'