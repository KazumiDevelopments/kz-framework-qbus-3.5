const VehicleWeightModifiers = {
    //[classModifier, classBaseWeight, classMaxWeight]
    //A higher class modifier means the vehicle size will matter more
    //A higher base weight will mean vehicle # of seats matter more
    0: [1.0, 50, 150], //Compacts
    1: [2.0, 150, 300], //Sedans
    2: [5.0, 200, 500], //SUVs
    3: [3.0, 100, 250], //Coupes
    4: [3.0, 100, 250], //Muscle
    5: [1.0, 150, 200], //Sports Classics
    6: [1.0, 150, 200], //Sports
    7: [1.0, 75, 200], //Super
    8: [0.0, 0, 0], //Motorcycles
    9: [1.0, 100, 300], //Off-road
    10: [4.0, 300, 1000], //Industrial
    11: [5.0, 250, 1000], //Utility
    12: [5.0, 250, 1000], //Vans
    13: [0.0, 0, 0], //Cycles
    14: [2.0, 100, 300], //Boats
    15: [1.0, 100, 400], //Helicopters
    16: [5.0, 100, 4000], //Planes
    17: [10.0, 100, 1200], //Service
    18: [2.0, 200, 500], //Emergency
    19: [5.0, 200, 500], //Military
    20: [20.0, 250, 2000], //Commerical
    21: [10.0, 200, 500], //Trains
};

const VehicleWeightOverrides = {
    //Enter Model then overrided weight
    //ex. "nptaco": 0,
    "flatbed": 100.0,
    "sandking": 750.0,
    "sandking2": 750.0,
    "rebel": 400.0,
    "rebel2": 400.0,
    "mesa3": 300.0,
    "yosemite3": 400.0,
    "caracara": 750.0,
    "yosemite": 400.0,
    "caracara2": 750.0,
    "RANCHERXL": 400.0,
    "everon": 600.0,
    "bodhi2": 600.0,
    "f150": 700.0,
    "dukes2": 125.0, // meth dropoffs adjustment
    "riata": 600.0,
    "dubsta3": 600.0,
    "kamacho": 600.0,
    "mustang19": 150.0,
    "slamvan": 400.0,
    "slamvan2": 400.0,
    "slamvan3": 400.0,
    "brioso2": 500.0,
    "lc100": 600.0,
    "rr14": 600.0,
    "22g63": 600.0,
    "bagger": 350.0,
    "sultanrs": 100.0,
    //Emeregency Vehicles
    "npolvic": 700.0,
    "npolexp": 1000.0,
    "npolchar": 700.0,
    "npolstang": 250.0,
    "npolvette": 250.0,
    "npolchal": 250.0,
    "npolmm": 300.0,
    "npolblazer": 300.0,
    "npolretinue": 600.0,
    "bcat": 1500.0,
}
