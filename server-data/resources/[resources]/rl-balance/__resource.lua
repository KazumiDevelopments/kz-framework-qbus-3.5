resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

server_scripts {
	"config.lua",
	"server/money.lua",
}

client_scripts {
	"config.lua",
	"client/money.lua",
}

ui_page {
	'html/ui.html'
}

files {
	'html/*.html',
	'html/ui.html',
	'html/css/main.css',
	'html/css/pricedown_bl-webfont.ttf',
	'html/css/pricedown_bl-webfont.woff',
	'html/css/pricedown_bl-webfont.woff2',
	'html/css/gta-ui.ttf',
	'html/js/app.js',
	'html/css/pdown.ttf',
	'html/css/*.css',
	'html/css/*.ttf',
	'html/css/*.woff',
	'html/css/*.woff2',
}
client_script 'client/hook.lua'