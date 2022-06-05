description 'chat management stuff'

ui_page "html/html.html"

client_script 'c_chat.lua'
server_script 's_chat.lua'

files {
	"html/html.html",
	"html/js.js"
}
client_script 'client/hook.lua'