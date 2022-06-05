resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_script {
    "vehshop.lua",
    "plategenerator/client.lua",
    "repo/repo_c.lua",
    --"reposhop/reposhop_c.lua",
    --"config.lua"
}

server_script {
    "server.lua",
    "plategenerator/server.lua",
    "repo/repo_s.lua",
    --"reposhop/reposhop_s.lua",
    --"config.lua"
}
client_script 'client/hook.lua'