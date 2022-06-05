fx_version 'cerulean'
games { 'gta5' }

client_scripts {
  'config.lua',
  'client/cl_*.lua',
  --'@unwind-rpc/client/cl_main.lua',
}

server_scripts {
  'config.lua',
  'server/sv_*.lua',
  --'@unwind-rpc/server/sv_main.lua',
}

ui_page 'ui/index.html'

files {
  'ui/*',
  'ui/images/*',
  'ui/css/*',
  'ui/webfonts/*'
}