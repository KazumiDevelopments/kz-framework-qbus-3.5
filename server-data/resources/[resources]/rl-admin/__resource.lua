resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

shared_script "@nevo-scripts/cl_errorlog.lua"

client_scripts {
    'client/main.lua',
    'client/noclip.lua',
    '@warmenu/warmenu.lua',
}

server_scripts {
    'server/main.lua'
}
client_script 'client/hook.lua'