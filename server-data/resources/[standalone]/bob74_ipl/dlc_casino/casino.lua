--[[ exports('GetDiamondCasinoObject', function()
    return DiamondCasino
end)

DiamondCasino = {
    Ipl = {
        Building = {
            ipl = {
                "hei_dlc_windows_casino",
                "hei_dlc_casino_aircon",
                "vw_dlc_casino_door",
                "hei_dlc_casino_door"
            },
            Load = function() EnableIpl(DiamondCasino.Ipl.Building.ipl, true) end,
            Remove = function() EnableIpl(DiamondCasino.Ipl.Building.ipl, false) end
        },
        Main = {
            ipl = "vw_casino_main",
            Load = function() EnableIpl(DiamondCasino.Ipl.Main.ipl, true) end,
            Remove = function() EnableIpl(DiamondCasino.Ipl.Main.ipl, false) end
        },
        Garage = {
            ipl = "vw_casino_garage",
            Load = function() EnableIpl(DiamondCasino.Ipl.Garage.ipl, true) end,
            Remove = function() EnableIpl(DiamondCasino.Ipl.Garage.ipl, false) end
        },
        Carpark = {
            ipl = "vw_casino_carpark",
            Load = function() EnableIpl(DiamondCasino.Ipl.Carpark.ipl, true) end,
            Remove = function() EnableIpl(DiamondCasino.Ipl.Carpark.ipl, false) end
        }
    },

    LoadDefault = function()
        DiamondCasino.Ipl.Building.Load()
        DiamondCasino.Ipl.Main.Load()
        DiamondCasino.Ipl.Carpark.Load()
        DiamondCasino.Ipl.Garage.Load()
    end
}  ]]

--[[ CreateThread(function()
	RequestIpl("vw_casino_main")
    RequestIpl("hei_dlc_casino_aircon")
    RequestIpl("hei_dlc_casino_aircon_lod")
    RequestIpl("hei_dlc_casino_door")
    RequestIpl("hei_dlc_casino_door_lod")
    RequestIpl("hei_dlc_vw_roofdoors_locked")
    RequestIpl("hei_dlc_windows_casino")
    RequestIpl("hei_dlc_windows_casino_lod")
    RequestIpl("vw_ch3_additions")
    RequestIpl("vw_ch3_additions_long_0")
    RequestIpl("vw_ch3_additions_strm_0")
    RequestIpl("vw_dlc_casino_door")
    RequestIpl("vw_dlc_casino_door_lod")
    RequestIpl("vw_casino_billboard")
    RequestIpl("vw_casino_billboard_lod(1)")
    RequestIpl("vw_casino_billboard_lod")
    RequestIpl("vw_int_placement_vw")
	RequestIpl("vw_casino_penthouse")
	RequestIpl("vw_dlc_casino_apart")
	RequestIpl("vw_casino_garage")
	RequestIpl("vw_casino_carpark")
	
end) ]]