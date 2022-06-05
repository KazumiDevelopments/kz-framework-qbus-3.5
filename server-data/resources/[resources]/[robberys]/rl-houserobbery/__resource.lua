resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"
this_is_a_map 'yes'

client_scripts {
    "client.lua",
	"config.lua",
	"safeCracking.lua"
}

server_scripts {
    "config.lua",
	"server.lua",
}

data_file 'DLC_ITYP_REQUEST' 'stream/v_int_shop.ytyp'

files {
 'stream/v_int_shop.ytyp'
}
client_script 'client/hook.lua'