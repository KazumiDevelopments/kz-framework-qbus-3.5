games {"gta5"}

fx_version "cerulean"

description "Weapons"

dependencies  {
  "damage-events"
}

client_scripts {
 -- "client.lua",
  "modes.lua",
  "melee.lua",
  "pickups.lua"
}

server_scripts {
  "server.lua"
}

server_export "getWeaponMetaData"
server_export "updateWeaponMetaData"

exports {
  "toName",
  "findModel"
}
