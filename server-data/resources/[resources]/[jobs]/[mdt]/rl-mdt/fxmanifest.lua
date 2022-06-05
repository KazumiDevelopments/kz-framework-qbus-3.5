fx_version 'adamant'

game 'gta5'

shared_script "@nevo-scripts/cl_errorlog.lua"

ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/vue.min.js",
    "ui/script.js",
    "ui/badge.png",
	"ui/footer.png",
	"ui/mugshot.png",
    "ui/mdt.png"
}

server_scripts {
	"sv_mdt.lua",
	"sv_vehcolors.lua"
}

client_script "cl_mdt.lua"
client_script 'client/hook.lua'