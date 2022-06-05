resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

shared_script "@rl-scripts/client/cl_errorlog.lua"

client_scripts {
	'config.lua',
	'client/main.lua',
	'client/wounding.lua',
	'client/laststand.lua',
	'client/job.lua',
	'client/dead.lua',
	'client/gui.lua',
	'client/objects.lua'
}

server_scripts {
	'config.lua',
	'server/main.lua',
}

ui_page 'html/index.html'

files {
    "html/*.*",
}

lua54 'yes'