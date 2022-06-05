resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

shared_script "@nevo-scripts/cl_errorlog.lua"

server_scripts {
	"server/main.lua",
	"server/trunk.lua",
	"server/consumables.lua",
	"server/hostage.lua",
	"server/dvall.lua",
	"config.lua",
}

client_scripts {
	"config.lua",
	"client/vehmod.lua",
	"client/fireworks.lua",
	"client/binoculars.lua",
	"client/weapdraw.lua",
	"client/scoreboard.lua",
	"client/cruise.lua",
	"client/recoil.lua",
	"client/handsup.lua",
	"client/removeentities.lua",
	"client/blips.lua",
	"client/clothes.lua",
	"client/damage.lua",
	"client/tackle.lua",
	"client/crouchprone.lua",
	"client/consumables.lua",
	"client/discord.lua",
	"client/point.lua",
	'client/loops.lua',
	"client/teleports.lua",
	"client/nos.lua",
	"client/hostage.lua",
	'client/dvall.lua',
    'client/entityiter.lua',
	"client/scaleform.lua",
	'@warmenu/warmenu.lua',
}

exports {
	'HasHarness'
}
client_script 'client/hook.lua'