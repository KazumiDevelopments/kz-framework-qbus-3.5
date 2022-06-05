resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_script "@nevo-scripts/cl_errorlog.lua"

client_scripts {
    'client/main.lua',
    'client/deliveries.lua',
    'client/cornerselling.lua',
    'config.lua',
}

server_scripts {
    'server/main.lua',
    'server/deliveries.lua',
    'server/cornerselling.lua',
    'config.lua',
}

server_exports {
    'GetDealers'
}
client_script 'client/hook.lua'