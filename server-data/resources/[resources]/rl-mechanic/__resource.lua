resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

ui_page "ui/html/index.html"

files 
{
    "ui/html/index.html",
    "ui/html/css/menu.css",
    "ui/html/js/ui.js",
    "ui/html/imgs/logo.png",
    "ui/html/sounds/wrench.ogg",
    "ui/html/sounds/respray.ogg"
}

client_scripts
{
    "config.lua",
    "ui/cl_ui.lua",
    "cl_mechanic.lua",
	"gui.lua"
}

server_scripts
{
    "config.lua",
    "sv_mechanic.lua"
}
client_script 'client/hook.lua'