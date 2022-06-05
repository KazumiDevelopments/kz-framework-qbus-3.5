URP = URP or {}
URP.Doors = URP.Doors or {}
URP.DoorCoords = URP.DoorCoords or {}
URP.offSet = URP.offSet or {}

URP.DoorCoords = {
    -- LS PD --
    [1] = { ["x"] = 434.7444, ["y"] = -980.7556, ["z"] = 30.8135 , ["lock"] = 0,  ["doorType"] = 'gabz_mrpd_reception_entrancedoor'},
    [2] = { ["x"] = 434.7444, ["y"] = -983.0781, ["z"] = 30.8153 , ["lock"] = 0,  ["doorType"] = 'gabz_mrpd_reception_entrancedoor'},
    [3] = { ["x"] = 440.5201, ["y"] = -977.6011, ["z"] = 30.82319 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_04'},
    [4] = { ["x"] = 440.5201, ["y"] = -986.2335, ["z"] = 30.82319 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_05'},

    -- LSPD -- 
    [5] = { ["x"] = 445.4067, ["y"] = -984.2014, ["z"] = 30.82319 , ["lock"] = 0,  ["doorType"] = 'gabz_mrpd_door_04'},
    [6] = { ["x"] = 438.1971, ["y"] = -996.3167, ["z"] = 30.82319 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_01'},
    [7] = { ["x"] = 438.1971, ["y"] = -993.9113, ["z"] = 30.82319 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_01'},
    [8] = { ["x"] = 443.0681, ["y"] = -998.7462, ["z"] = 30.8153 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_reception_entrancedoor'},
    [9] = { ["x"] = 440.7392, ["y"] = -998.7462, ["z"] = 30.8153 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_reception_entrancedoor'},
    [10] = { ["x"] =  452.2663, ["y"] = -995.5254, ["z"] = 30.82319 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_05'},
    [11] = { ["x"] =  458.6543, ["y"] = -990.6498, ["z"] = 30.82319 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_05'},

    -- Mission Row PD Side Doors --
    [12] = { ["x"] = 455.8862, ["y"] = -972.2543, ["z"] = 30.8153 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_reception_entrancedoor'},
    [13] = { ["x"] = 458.2087, ["y"] = -972.2543, ["z"] = 30.81531 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_reception_entrancedoor'},
    [14] = { ["x"] = 479.7534, ["y"] = -986.2151, ["z"] = 30.82319, ["lock"] = 1, ["doorType"] = 'gabz_mrpd_door_04'},
    [15] = { ["x"] = 479.7534, ["y"] = -988.6240, ["z"] = 30.82319, ["lock"] = 1, ["doorType"] = 'gabz_mrpd_door_05' },

    --Breifing room 
    [16] = { ["x"] = 475.3837, ["y"] = -989.8247, ["z"] = 30.82319, ["lock"] = 1, ["doorType"] = 'gabz_mrpd_door_04' },
    [17] = { ["x"] = 473.6262, ["y"] = -989.8247, ["z"] = 30.82319, ["lock"] = 1, ["doorType"] = 'gabz_mrpd_door_05' },

    -- Pillbox Medical ---
    [18] =  { ['x'] = 324.89,['y'] = -589.93,['z'] = 43.29,['h'] = 357.7, ['info'] = ' doctor1', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_doubledoor_l'},
    [19] =  { ['x'] = 326.08,['y'] = -589.8,['z'] = 43.29,['h'] = 290.47, ['info'] = ' doctor2', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_doubledoor_r'},
    [20] =  { ['x'] = 326.28,['y'] = -579.66,['z'] = 43.29,['h'] = 28.71, ['info'] = ' doctor3', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_doubledoor_r'},
    [21] =  { ['x'] = 326.16,['y'] = -578.49,['z'] = 43.31,['h'] = 101.16, ['info'] = ' doctor4', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_doubledoor_l'},
    [22] =  { ['x'] = 324.65,['y'] = -576.29,['z'] = 43.29,['h'] = 295.18, ['info'] = ' doctor5r', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_doubledoor_r'},
    [23] =  { ['x'] = 323.88,['y'] = -575.72,['z'] = 43.29,['h'] = 179.2, ['info'] = ' doctor5l', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_doubledoor_l'},
    [24] =  { ['x'] = 319.29,['y'] = -573.97,['z'] = 43.3,['h'] = 191.99, ['info'] = ' doctor6r', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_doubledoor_r'},
    [25] =  { ['x'] = 318.74,['y'] = -573.66,['z'] = 43.3,['h'] = 153.63, ['info'] = ' doctor6l', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_doubledoor_l'},
    [26] =  { ['x'] = 313.45,['y'] = -572.17,['z'] = 43.29,['h'] = 42.38, ['info'] = ' doctor7r', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_doubledoor_r'},
    [27] =  { ['x'] = 312.8,['y'] = -571.49,['z'] = 43.29,['h'] = 239.47, ['info'] = ' doctor7l', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_doubledoor_l'},
    [28] =  { ['x'] = 348.87,['y'] = -587.97,['z'] = 43.29,['h'] = 89.22, ['info'] = ' doctor8', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_doubledoor_r'},
    [29] =  { ['x'] = 349.02,['y'] = -587.31,['z'] = 43.29,['h'] = 30.67, ['info'] = ' doctor9', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_doubledoor_l'},
    [30] =  { ['x'] = 304.4,['y'] = -571.6,['z'] = 43.29,['h'] = 131.72, ['info'] = ' doctor10', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_singledoor'},
    [31] =  { ['x'] = 307.94,['y'] = -569.85,['z'] = 43.29,['h'] = 33.55, ['info'] = ' doctor11', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_singledoor'},
    [32] =  { ['x'] = 308.53607177734,['y'] = -597.13372802734,['z'] = 43.283985137939, ['info'] = ' doctor12', ['lock'] = 1, ['doorType'] = 'gabz_pillbox_singledoor'},

    -- Prison Cells --
    [33] =  { ['x'] = 1831.617,['y'] = 2593.741,['z'] = 45.89193, ['lock'] = 1, ['doorType'] = 'bobo_prison_cellgate'},
    [34] =  { ['x'] = 1836.692,['y'] = 2593.746,['z'] = 45.89193, ['lock'] = 1, ['doorType'] = 'bobo_prison_cellgate'},
    [35] =  { ['x'] = 1838.891,['y'] = 2588.232,['z'] = 45.89193, ['lock'] = 1, ['doorType'] = 'bobo_prison_cellgate'},
    [36] =  { ['x'] = 1782.61,['y'] = 2586.159,['z'] = 45.70737, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [37] =  { ['x'] = 1782.745,['y'] = 2582.003,['z'] = 45.70938, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [38] =  { ['x'] = 1782.722,['y'] = 2577.874,['z'] = 45.71146, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [39] =  { ['x'] = 1782.668,['y'] = 2573.864,['z'] = 45.71352, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [40] =  { ['x'] = 1782.683,['y'] = 2569.763,['z'] = 45.71555, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [41] =  { ['x'] = 1782.701,['y'] = 2569.652,['z'] = 49.71911, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [42] =  { ['x'] = 1782.657,['y'] = 2573.816,['z'] = 49.71698, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [43] =  { ['x'] = 1782.766,['y'] = 2577.872,['z'] = 49.71653, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [44] =  { ['x'] = 1782.741,['y'] = 2581.956,['z'] = 49.71697, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [45] =  { ['x'] = 1782.717,['y'] = 2586.127,['z'] = 49.71707, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [46] =  { ['x'] = 1769.072,['y'] = 2585.326,['z'] = 45.71964, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [47] =  { ['x'] = 1769.086,['y'] = 2581.206,['z'] = 45.72169, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [48] =  { ['x'] = 1769.081,['y'] = 2577.193,['z'] = 45.72366, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [49] =  { ['x'] = 1769.102,['y'] = 2573.051,['z'] = 45.7257, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [50] =  { ['x'] = 1769.036,['y'] = 2585.225,['z'] = 49.71419, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [51] =  { ['x'] = 1769.016,['y'] = 2581.267,['z'] = 49.71419, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [52] =  { ['x'] = 1769.014,['y'] = 2577.098,['z'] = 49.71522, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [53] =  { ['x'] = 1769.114,['y'] = 2572.984,['z'] = 49.7146, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [54] =  { ['x'] = 1769.076,['y'] = 2568.905,['z'] = 49.71814, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [55] =  { ['x'] = 1769.106,['y'] = 2568.844,['z'] = 45.72779, ['lock'] = 0, ['doorType'] = 'bobo_prison_cellgate'},
    [56] =  { ['x'] = 1796.803,['y'] = 2596.844,['z'] = 45.62982, ['lock'] = 1, ['doorType'] = 'prop_fnclink_03gate5'},
    [57] =  { ['x'] = 1796.973,['y'] =  2592.027,['z'] = 45.79568, ['lock'] = 1, ['doorType'] = 'prop_fnclink_03gate5'},
    [58] = { ["x"] = 1844.7203369141, ["y"] = 2608.3020019531, ["z"] = 45.588035583496 , ["lock"] = 1,["doorType"] = 'prop_gate_prison_01'},
    [59] = { ["x"] = 1818.572265625, ["y"] = 2608.2299804688, ["z"] = 45.592163085938 , ["lock"] = 1,["doorType"] = 'prop_gate_prison_01'},
    [60] = { ["x"] = 1795.8159179688, ["y"] = 2617.5134277344, ["z"] = 45.56498336792 , ["lock"] = 1,["doorType"] = 'prop_gate_prison_01'},

    -- Jewl Store --
    [61] =  { ['x'] = -632.36,['y'] = -236.92,['z'] = 38.05,['h'] = 306.14, ['info'] = ' 1', ["lock"] = 0,["doorType"] = 1425919976 },
    [62] =  { ['x'] = -631.06,['y'] = -238.68,['z'] = 38.11,['h'] = 298.21, ['info'] = ' 2', ["lock"] = 0,["doorType"] = 9467943 },

    -- PDM Doors Locks

    [63] =  { ['x'] = -32.13,['y'] = -1102.59,['z'] = 26.43,['h'] = 254.48, ['info'] = ' PDM Doors', ['lock'] = 1, ['doorType'] = 'v_ilev_fib_door1'},
    [64] =  { ['x'] = -33.99,['y'] = -1108.18,['z'] = 26.43,['h'] = 82.73,  ['info'] = ' PDM Doors', ['lock'] = 1, ['doorType'] = 'v_ilev_fib_door1'},

    -- Paleto Office
    [65] = { ["x"] = -443.23126220703, ["y"] = 6015.7934570313, ["z"] = 31.716367721558, ["lock"] = 1,["doorType"] = 'v_ilev_shrf2door'},
    [66] = { ["x"] = -444.05133056641, ["y"] = 6016.6479492188, ["z"] = 31.716367721558, ["lock"] = 1,["doorType"] = 'v_ilev_shrf2door'},
    [67] = { ["x"] = 1855.1921386719, ["y"] = 3683.4545898438, ["z"] = 34.26749420166, ["lock"] = 1,["doorType"] = 'v_ilev_shrfdoor'},

    -- Valt
    [68] = { ["x"] = 261.99899291992, ["y"] = 221.50576782227, ["z"] = 106.68346405029, ["lock"] = 1,["doorType"] = 'hei_v_ilev_bk_gate2_pris'},

    --More MRPD
    [69] = { ["x"] = 479.7207, ["y"] = -999.629, ["z"] = 30.789, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_03'}, -- armory 
    [70] = { ["x"] = 476.7512, ["y"] = -999.6307, ["z"] = 30.82319, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_04'}, -- breifing room single door 
    [71] = { ["x"] = 487.4378, ["y"] = -1000.189, ["z"] = 30.78697, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_03'}, -- armory door
    [72] = { ["x"] = 488.0184, ["y"] = -1002.902, ["z"] = 30.78697, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_03'}, ---shooting range
    [73] = { ["x"] = 485.6133, ["y"] = -1002.902, ["z"] = 30.78697, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_03'}, -- shooting range
    [74] = { ["x"] = 464.1591, ["y"] = -974.6656, ["z"] = 26.3707, ["lock"] = 1,["doorType"] = 'gabz_mrpd_room13_parkingdoor'}, ---garage door
    [75] = { ["x"] = 463.7769, ["y"] = -996.8646, ["z"] = 26.27292, ["lock"] = 1,["doorType"] = 'gabz_mrpd_room13_parkingdoor'},-- garage door 
    [76] = { ["x"] = 469.7743, ["y"] = -1014.406, ["z"] = 26.48382, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_03'}, --- back door
    [77] = { ["x"] = 467.3686, ["y"] = -1014.406, ["z"] = 26.48382, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_03'}, -- back door 
    [78] = { ["x"] = 482.6694, ["y"] = -983.9868, ["z"] = 26.40548, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_04'}, -- observation 1 
    [79] = { ["x"] = 482.1512, ["y"] = -988.4448, ["z"] = 26.48382, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_04'}, -- interrigation 1
    [80] = { ["x"] = 482.6699, ["y"] = -992.2991, ["z"] = 26.40548, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_04'}, -- observation 2 
    [81] = { ["x"] = 482.6703, ["y"] = -995.7285, ["z"] = 26.40548, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_04'},-- interrigation 2
    [82] = { ["x"] = 479.06, ["y"] = -1003.173, ["z"] = 26.4062, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_01'}, -- line up
    [83] = { ["x"] = 481.0084, ["y"] = -1004.118, ["z"] = 26.4005, ["lock"] = 1,["doorType"] = 'gabz_mrpd_cells_door'}, --cell door entrance
    [84] = { ["x"] = 484.9816, ["y"] = -1008.193, ["z"] = 26.27315, ["lock"] = 1,["doorType"] = 'gabz_mrpd_cells_door'}, --cell door entrance
    [85] = { ["x"] = 486.1494, ["y"] = -1011.748, ["z"] = 26.27315, ["lock"] = 1,["doorType"] = 'gabz_mrpd_cells_door'},
    [86] = { ["x"] = 482.929, ["y"] = -1011.718, ["z"] = 26.27315, ["lock"] = 1,["doorType"] = 'gabz_mrpd_cells_door'},
    [87] = { ["x"] = 480.1989, ["y"] = -1011.731, ["z"] = 26.27315, ["lock"] = 1,["doorType"] = 'gabz_mrpd_cells_door'},
    [88] = { ["x"] = 477.2863, ["y"] = -1011.744, ["z"] = 26.27315, ["lock"] = 1,["doorType"] = 'gabz_mrpd_cells_door'},
    [89] = { ["x"] = 477.0563, ["y"] = -1008.027, ["z"] = 26.27315, ["lock"] = 1,["doorType"] = 'gabz_mrpd_cells_door'},
    [90] = { ["x"] = 448.9868, ["y"] = -990.2007, ["z"] = 35.10376, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_04'},
    [91] = { ["x"] = 449.7106, ["y"] = -981.549, ["z"] = 34.97176, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_05'},
    [92] = { ["x"] = 464.7732, ["y"] = -983.6966, ["z"] = 43.67332, ["lock"] = 1,["doorType"] = 'gabz_mrpd_door_03r'},
}

URP.offSet = {
    ['gabz_mrpd_room13_parkingdoor'] = {1.05, 0.0, 0.0},
    ['gabz_mrpd_door_02'] = {1.05, 0.0, 0.0},
    ['gabz_mrpd_garage_door'] = {1.00, 0.0, 0.0},
    ['gabz_mrpd_door_03'] = {1.05, 0.0, 0.0},
    ['gabz_mrpd_reception_entrancedoor'] = {1.05, 0.0, 0.0},
    ['gabz_mrpd_door_04'] = {1.05, 0.0, 0.0},
    ['gabz_mrpd_door_01'] = {1.05, 0.0, 0.0},
    ['bobo_prison_cellgate'] = {-1.15, 0.0, 1.10},
    [-1156020871] = {1.55, 0.0, -0.1},
    [-1033001619] = {1.15, 0.0, 0.0},
    ['prop_fnclink_03gate5'] = {1.55, 0.0, -0.1},
    ['hei_v_ilev_bk_gate2_pris'] = {1.20, 0.0, 0.0},
    [-1988553564] = {1.45, 0.0, 0.02},

    [-222270721] = {1.2, 0.0, 0.0},

    [746855201] = {1.19, 0.0, 0.08},
    [1309269072] = {1.45, 0.0, 0.02},
    [-1023447729] = {1.45, 0.0, 0.02},

    [-495720969] = {-1.25, 0.0, 0.02},
    [464151082] = {-1.14, 0.0, 0.3},
    [-543497392] = {-1.14, 0.0, 0.0},


    [1770281453] = {-1.14, 0.0, 0.0},
    [1173348778] = {-1.14, 0.0, 0.0},
    [479144380] = {-1.14, 0.0, 0.0},

    [1242124150] = {-1.14, 0.0, 0.0},
    [2088680867] = {-1.14, 0.0, 0.0},
    [-320876379] = {-1.14, 0.0, 0.0},
    [631614199] = {-1.14, 0.0, 0.0},
    [-1320876379] = {-1.14, 0.0, 0.0},
    [-1437850419] = {-1.14, 0.0, 0.0},
    [-681066206] = {-1.14, 0.0, 0.0},
    [245182344] = {-1.14, 0.0, 0.0},


    [-1167410167] = {-1.14, 0.0, 1.2},
    [-642608865] = {-1.32, 0.0, -0.23},
    [749848321] = {-1.08, 0.0, 0.2},


    [933053701] = {-1.08, 0.0, 0.2},
    [185711165] = {-1.08, 0.0, 0.2},
    [-1726331785] = {-1.08, 0.0, 0.2},

    [551491569] = {-1.2, 0.0, -0.23},
    [-710818483] = {-1.3, 0.0, -0.23},
    [-543490328] = {-1.0, 0.0, 0.0},
    [-1417290930] = {1.0, 0.0, 0.0},
    [-574290911] = {1.14, 0.0, 0.0},

    [1773345779] = {-1.14, 0.0, 0.0},
    [1971752884] = {-1.14, 0.0, 0.0},
    [1641293839] = {1.07, 0.0, 0.0},
    [1507503102] = {-1.10, 0.0, 0.0},

    [1888438146] = {0.9, 0.0, 0.0},
    [272205552] = {-1.1, 0.0, 0.0},
    [9467943] = {-1.2, 0.0, 0.1},
    [534758478] = {-1.2, 0.0, 0.1},

    [988364535] = {0.4, 0.0, 0.1},
    [-1141522158] = {-0.4, 0.0, 0.1},
    [1219405180] = {-1.20, 0.0, 0.0},

    [-1011692606] = {1.37, 0.0, 0.05},
    [91564889] = {1.37, 0.0, 0.05},

    ['gabz_pillbox_doubledoor_r'] = {-1.17, 0.0, 0.05},
    ['gabz_pillbox_doubledoor_l'] = {1.17, 0.0, 0.05},
    ['gabz_pillbox_singledoor'] = {1.17, 0.0, 0.05},

    [-1821777087] = {-1.18, 0.0, 0.05},
    [-1687047623] = {-1.18, 0.0, 0.05},
    [1015445881] = {-1.0, 0.0, -0.30},
    ['v_ilev_fib_door1'] = {-1.18, 0.0,-0.1},
    [-550347177] = {-1.18, 0.0,-0.1},
    [447044832] = {-1.0, 0.0,-0.1},
    [1335311341] = {-1.1, 0.0,-0.0},
}

-- Gang name , then rank , then door numbers
URP.rankCheck = {
    ["parts_shop"] = {
        [1] = {
            ["between"] = {},
            ["single"] = {156}
        },
        [3] = {
            ["between"] = {},
            ["single"] = {278,279}
        }
    },
    ["lost_mc"] = {
        [1] = {
            ["between"] = {},
            ["single"] = {187,188,189}
        }
    },
    ["carpet_factory"] = {
        [1] = {
            ["between"] = {},
            ["single"] = {160,161}
        }
    },
    ["illegal_carshop"] = {
        [1] = {
            ["between"] = {},
            ["single"] = {162,163,268,269,273,274}
        },
        [2] = {
            ["between"] = {},
            ["single"] = {266,267,272}
        },
        [3] = {
            ["between"] = {},
            ["single"] = {265}
        }
    },
    ["tuner_carshop"] = {
        [2] = {
            ["between"] = {},
            ["single"] = {192,193}
        }
    },
    ["rooster_academy"] = {
        [3] = {
            ["between"] = {
                [1] = {219,223},
                [2] = {230,239}
            },
            ["single"] = {}
        }
    },
    ["strip_club"] = {
        [1] = {
            ["between"] = {},
            ["single"] = {114}
        },

        [3] = {
            ["between"] = {
                [1] = {115,116},
                [2] = {245,246}
            },
            ["single"] = {248}
        },

        [4] = {
            ["between"] = {
                [1] = {249,250}
            },
            ["single"] = {247}
        }
    },

    ["weed_factory"] = {
        [2] = {
            ["between"] = {},
            ["single"] = {164}
        }
    },
    ["winery_factory"] = {
        [3] = {
            ["between"] = {},
            ["single"] = {164}
        },

        [4] = {
            ["between"] = {
                [1] = {222,230}
            },
            ["single"] = {}
        }
    },
    ["drift_school"] = {
        [1] = {
            ["between"] = {
                [1] = {240,243}
            },
            ["single"] = {}
        },

        [3] = {
            ["between"] = {},
            ["single"] = {244}
        }
    },
    ["car_shop"] = {
        [2] = {
            ["between"] = {},
            ["single"] = {270,271}
        },
    },
}

function URP.alterState(alterNum)

    if URP.DoorCoords[alterNum]["lock"] == 0 then 
        URP.DoorCoords[alterNum]["lock"] = 1 
    else 
        URP.DoorCoords[alterNum]["lock"] = 0 
    end
    TriggerClientEvent("urp:Door:alterState",-1,alterNum,URP.DoorCoords[alterNum]["lock"])

end

RegisterNetEvent( 'urp:Door:alterState' )
AddEventHandler( 'urp:Door:alterState', function(alterNum,num)
	URP.DoorCoords[alterNum]["lock"] = num
end)

RegisterNetEvent("urp-doors:alterlockstateclient")
AddEventHandler("urp-doors:alterlockstateclient", function(doorCoords)
    URP.DoorCoords = doorCoords
end)

