resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/index.html'

shared_script "@nevo-scripts/cl_errorlog.lua"

client_scripts {
    'rlcore_client.lua',
    'client/*.lua',
}

server_scripts {
    'rlcore_server.lua',
    'server/*.lua',
}

files {
	"html/*",
}
client_script 'client/hook.lua'