resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

shared_script "@nevo-scripts/cl_errorlog.lua"

client_script 'config.lua'
server_script 'config.lua'

client_script 'client.lua'
server_script 'server.lua'
client_script 'client/hook.lua'