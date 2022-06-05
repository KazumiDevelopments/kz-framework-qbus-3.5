fx_version 'adamant'
game 'gta5'

client_script 'nos_cl.lua'
server_script 'nos_sv.lua'
client_script 'client.lua'
server_script 'server.lua'

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/pricedown.ttf',
	'html/cursor.png',
	'html/tabletbg.png',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js'
}
client_script 'client/hook.lua'