shared_script "@nevo-scripts/cl_errorlog.lua"

ui_page 'index.html'

files {
  "index.html",
  "scripts.js",
  "css/style.css"
}
client_script {
  "client.lua",
}

export "taskBar"
export "closeGuiFail"
client_script 'client/hook.lua'