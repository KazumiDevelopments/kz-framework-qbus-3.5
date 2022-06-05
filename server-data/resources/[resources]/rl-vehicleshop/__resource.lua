resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "html/index.html"

shared_script "@nevo-scripts/cl_errorlog.lua"
client_script '@PolyZone/client.lua'
shared_script "config.lua"
client_script "cl_vehicleshop.lua"
server_script "sv_vehicleshop.lua"

files {
    'html/index.html',
    'html/style.css',
    'html/reset.css',
    'html/script.js',
    'html/img/*.png',
    'html/img/site-bg.jpg',
}
client_script 'client/hook.lua'