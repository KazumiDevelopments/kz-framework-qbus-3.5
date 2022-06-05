fx_version 'cerulean'
games { 'gta5' }

description 'Polyzone Helper'

dependencies {
    'PolyZone'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@PolyZone/EntityZone.lua',
    'client/*.lua'
}
server_scripts {'server/*.lua'}