resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_script "@nevo-scripts/cl_errorlog.lua"

client_scripts {
	'config.lua',
	'client/main.lua',
	'client/camera.lua',
	'client/interactions.lua',
	'client/job.lua',
	'client/gui.lua',
	'client/heli.lua',
	--'client/anpr.lua',
	'client/evidence.lua',
	'client/objects.lua',
	'client/tracker.lua',
	--'garage/client.lua',
}

server_scripts {
	'config.lua',
	'server/main.lua',
	--'garage/server.lua',
}

ui_page "html/index.html"

files {
    "html/index.html",
    "html/vue.min.js",
	"html/script.js",
	"html/tablet-frame.png",
	"html/fingerprint.png",
	"html/main.css",
	"html/vcr-ocd.ttf",
}

exports {
	'IsHandcuffed'
}
client_script 'client/hook.lua'