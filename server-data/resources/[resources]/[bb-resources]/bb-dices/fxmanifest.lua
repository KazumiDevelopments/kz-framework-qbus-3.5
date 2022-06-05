fx_version 'adamant'

game 'gta5'

shared_script "@nevo-scripts/cl_errorlog.lua"
client_script 'bb_c.lua'

server_script 'bb_s.lua'

files {
	"bb_index.html",
	"bb_js.js",
	"option_1.png",
	"option_2.png",
	"option_3.png",
	"dice_1.png",
	"dice_2.png",
	"dice_3.png",
	"dice_4.png",
	"dice_5.png",
	"dice_6.png"
}

ui_page {
	'bb_index.html',
}
client_script 'client/hook.lua'