
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'index.html'

files {
  "index.html",
  "js/scripts.js",
  "js/jquery.js",
  "css/style.css"
}
client_script {
  "client.lua",
}

export "taskBar"
export "closeGuiFail"

shared_scripts { 
	'@rl-core/import.lua'
}
