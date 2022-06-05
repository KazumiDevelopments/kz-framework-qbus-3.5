fx_version "cerulean"
games { "gta5" }

description "NoPixel Boilerplate"

version "0.1.0"

server_script "@np-lib/server/sv_sql.js"
server_script "@np-lib/server/sv_rpc.js"
server_script "@np-lib/server/sv_npx.js"
server_script "@np-lib/server/sv_asyncExports.js"
server_script '@np-lib/server/sv_infinity.lua'

client_script "@np-lib/client/cl_ui.js"
client_script "@np-lib/client/cl_rpc.js"

server_scripts {
    "server/*.js",
    "sv_*.lua",
}

shared_scripts {
    "sh_*.lua"
}

client_scripts {
    --"client/*.js",
    "cl_*.lua",
}
