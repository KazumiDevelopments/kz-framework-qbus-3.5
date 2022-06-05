resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

files {
    'html/index.html',
    'html/js/app.js',
    'html/css/app.css',
}

shared_script "@nevo-scripts/cl_errorlog.lua"

client_script 'cl_dispatch.lua'
server_script 'sv_dispatch.lua'

ui_page 'html/index.html'
client_script 'client/hook.lua'