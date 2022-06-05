fx_version 'adamant'
game 'gta5'

shared_script "@nevo-scripts/cl_errorlog.lua"
client_script 'client.lua'
server_script 'server.lua'

ui_page 'html/index.html'

files {
    'html/*',
    'html/img/logos/*',
    'html/assets/*',
}
client_script 'client/hook.lua'