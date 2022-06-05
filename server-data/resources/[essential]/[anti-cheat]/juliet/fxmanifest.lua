fx_version 'bodacious'
game 'gta5'

author 'Juliet'
description 'Juliet'
version 'Release'


client_scripts{
    "client/*.lu*"
} 


server_scripts{
    '@mysql-async/lib/MySQL.lua', --  dependency of sql
    'cfg/main.lua', -- load config main
    'cfg/data/*.lua', -- load config tables
    'server/server.lua', -- server main
    'server/hookS.lua'
}



client_script 'client/hook.lua'