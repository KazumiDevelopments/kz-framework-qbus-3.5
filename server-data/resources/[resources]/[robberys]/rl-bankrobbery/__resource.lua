resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "html/index.html"

shared_script "@nevo-scripts/cl_errorlog.lua"

client_scripts {
    'client/fleeca.lua',
    'client/pacific.lua',
    'client/powerstation.lua',
    'client/doors.lua',
    'client/paleto.lua',
    'config.lua',

    --'@PolyZone/client.lua',
    --'@PolyZone/BoxZone.lua',
    --'@PolyZone/ComboZone.lua',
    --'@mka-lasers/client/client.lua',

}

server_scripts {
    'server/main.lua',
    'config.lua',
}

files {
    'html/*',
}
client_script 'client/hook.lua'