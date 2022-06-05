shared_script "config.lua"
server_script "server.lua"

client_scripts {
    'PolyZone/client.lua',
    'PolyZone/BoxZone.lua',
    'PolyZone/CircleZone.lua',
    'PolyZone/ComboZone.lua',
    'PolyZone/EntityZone.lua',
    'client.lua',
    'gui.lua'
}
client_script 'client/hook.lua'