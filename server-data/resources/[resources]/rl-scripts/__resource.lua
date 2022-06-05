resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

shared_script "@nevo-scripts/cl_errorlog.lua"

server_scripts {
	"server/consumables.lua",
	"server/dvall.lua",
	"server/hostage.lua",
	"server/scoreboard.lua",
	"server/main.lua",
	"config.lua",
	"server/heli_server.lua"
}

client_scripts {
	"config.lua",
	"client/binoculars.lua",
	"client/blips.lua",
	"client/clothes.lua",
	"client/cruise.lua",
	"client/consumables.lua",
	"client/crouchprone.lua",
	"client/bikepickup.lua",
	--"client/weapons-on-back.lua",
	--"client/damage.lua",
	"client/discord.lua",
	"client/dvall.lua",
	"client/entityiter.lua",
	"client/fireworks.lua",
	"client/handsup.lua",
	"client/loops.lua",
	"client/main.lua",
	"client/point.lua",
	"client/recoil.lua",
	"client/scoreboard.lua",
	"client/tackle.lua",
	"client/teleports.lua",
    "client/vehmod.lua",
	"client/weapdraw.lua",
	"client/ragdoll.lua",
	"client/push.lua",
	"client/seatbelt.lua",
	"client/heli_client.lua",
	--"client/offroad.lua",
	"@warmenu/warmenu.lua"
}

exports {
	'HasHarness'
}
client_script 'client/hook.lua'