let itemList = {};

// START WEAPONS

// CUSTOM WEAPONS

// Flamethrower
itemList['728397530'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Flamethrower',
  price: 0,
  craft: [[
    { itemid: 'aluminium', amount: 10 },
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 100 },
  ]],
  weight: 35,
  nonStack: true,
  model: '',
  image: 'np_flamethrower.png',
  weapon: true,
};

itemList['flamethrowerammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Flamethrower Canister',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_flamethrower_ammo.png',
};



itemList['flamethrowerpart1'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Flamethrower Part',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_flamethrower_part1.png',
};

itemList['flamethrowerpart2'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Flamethrower Part',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_flamethrower_part2.png',
};

itemList['flamethrowerpart3'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Flamethrower Part',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_flamethrower_part3.png',
};

itemList['flamethrowerpart4'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Flamethrower Part',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_flamethrower_part4.png',
};

itemList['flamethrowerpart5'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Flamethrower Part',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_flamethrower_part5.png',
};

itemList['flamethrowerpart6'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Flamethrower Part',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_flamethrower_part6.png',
};

// Paintball Gun
itemList['-2009644972'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Paintball Gun',
  price: 0,
  craft: [[
    { itemid: 'aluminium', amount: 10 },
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 100 },
  ]],
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_paintballgun.png',
  weapon: true,
};

// Paintball Gun
itemList['727643628'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Tranquilizer Gun',
  price: 0,
  craft: [[
    { itemid: 'aluminium', amount: 10 },
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 100 },
  ]],
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_tranq.png',
  weapon: true,
};

// Rail Gun
itemList['1834241177'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'EMP Gun',
  price: 1000,
  weight: 51,
  nonStack: true,
  model: '',
  image: 'np_empgun.png',
  weapon: true,
  information: 'Government (PD/EMS/DOC) Issued Equipment',
};

itemList['1064738331'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Brick',
  craft: [[
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 250,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_brick.png',
  weapon: true,
};

itemList['-691061592'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Book',
  craft: [[
    { itemid: 'rollingpaper', amount: 10 },
  ]],
  price: 250,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_book_w.png',
  weapon: true,
};

itemList['571920712'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cash',
  price: 100,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_cash.png',
  weapon: true,
};

itemList['-828058162'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Stolen Shoes',
  price: 1,
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_stolenshoes.png',
  information: 'These are not yours, bro.',
};

itemList['-1953168119'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Staff of Regeneration',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_staff01.png',
  information: 'Is that a big staff in your pocket or are you just happy to see me?',
};

// weapon_ltl
itemList['218362403'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Rubber Slug Shotgun',
  price: 10,
  weight: 25,
  craft: [[
    { itemid: 'aluminium', amount: 70 },
    { itemid: 'steel', amount: 70 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_lessthanlethal.png',
  weapon: true,
  information: 'PD and DOC Issued LTL Weapon',
};

// weapon_shiv
itemList['-262696221'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Prison Shiv',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'scrapmetal', amount: 1 },
  ]],
  price: 250,
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_shiv.png',
  weapon: true,
  contraband: true,
};

// weapon_pistol

// weapon_browning
itemList['148457251'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Browning Hi-Power',
  price: 250,
  weight: 6,
  craft: [
    [
      { itemid: 'aluminium', amount: 15 },
      { itemid: 'steel', amount: 15 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 5 },
      { itemid: 'refinedsteel', amount: 5 },
    ]
  ],
  nonStack: true,
  model: '',
  image: 'np_browning.png',
  weapon: true,
};

// weapon_dp9 (it's called dp9, just rock with it)
itemList['-2012211169'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Diamondback DB9',
  price: 250,
  weight: 6,
  craft: [
    [
      { itemid: 'aluminium', amount: 15 },
      { itemid: 'steel', amount: 15 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 5 },
      { itemid: 'refinedsteel', amount: 5 },
    ]
  ],
  nonStack: true,
  model: '',
  image: 'np_DB9.png',
  weapon: true,
};


itemList['-1746263880'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Colt Python',
  price: 250,
  weight: 11,
  craft: [
    [
      { itemid: 'aluminium', amount: 150 },
      { itemid: 'plastic', amount: 150 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 45 },
      { itemid: 'refinedplastic', amount: 45 },
    ],
  ],
  nonStack: true,
  model: '',
  image: 'np_colt.png',
  weapon: true,
};


// weapon_xxxxxx
itemList['453432689'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'colt 1911',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 6,
  nonStack: true,
  model: '',
  image: 'np_pistol.png',
  weapon: true,
};

// weapon_pistol_mk2
itemList['-1075685676'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Beretta M9',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_pistol2.png',
  weapon: true,
};

// weapon_combatpistol
itemList['1593441988'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'FN FNX-45',
  price: 250,
  craft: [[
    { itemid: 'steel', amount: 65 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 5,
  nonStack: true,
  blockScrap: true,
  model: '',
  image: 'np_combat-pistol.png',
  weapon: true,
};

// weapon_heavypistol
itemList['-771403250'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Entreprise Wide Body 1911a',
  price: 250,
  craft: [[
    { itemid: 'steel', amount: 65 },
    { itemid: 'plastic', amount: 65 },
    { itemid: 'rubber', amount: 65 },
  ]],
  weight: 7,
  nonStack: true,
  blockScrap: true,
  model: '',
  image: 'np_heavy-pistol.png',
  weapon: true,
};


// weapon_taser
itemList['-820634585'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'PD Taser',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_stun-gun.png',
  weapon: true,
  information: 'Government (PD/EMS/DOC) Issued Equipment',
};

// weapon_glock
itemList['-120179019'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Glock 18',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 9,
  nonStack: true,
  model: '',
  image: 'np_glock.png',
  weapon: true,
  information: 'Government (PD/EMS/DOC) Issued Equipment',
};

// weapon_pistol50
itemList['-1716589765'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Desert Eagle',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 130 },
      { itemid: 'plastic', amount: 130 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 43 },
      { itemid: 'refinedplastic', amount: 43 },
    ],
  ],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_pistol-50.png',
  weapon: true,
};

// weapon_microsmg3
itemList['-134995899'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Mac-10',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 30 },
      { itemid: 'plastic', amount: 60 },
      { itemid: 'rubber', amount: 30 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 10 },
      { itemid: 'refinedplastic', amount: 20 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_micro-smg.png',
  weapon: true,
};

// smg / auto pistol
// weapon_appistol
itemList['584646201'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Glock 18C',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 80 },
      { itemid: 'plastic', amount: 70 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 25 },
      { itemid: 'refinedplastic', amount: 25 },
    ],
  ],
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_glock18c.png',
  weapon: true,
};

// weapon_microsmg2
itemList['-942620673'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Uzi',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 30 },
      { itemid: 'plastic', amount: 60 },
      { itemid: 'rubber', amount: 30 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 10 },
      { itemid: 'refinedplastic', amount: 20 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_micro-smg2.png',
  weapon: true,
};

// weapon_smg
itemList['736523883'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'MP5',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 30 },
      { itemid: 'plastic', amount: 60 },
      { itemid: 'rubber', amount: 30 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 10 },
      { itemid: 'refinedplastic', amount: 20 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_mp5.png',
  weapon: true,
};

// weapon_m4
itemList['1192676223'] = {
  fullyDegrades: false,
  decayrate: 0.75,
  displayname: 'M4',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 50 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_m4.png',
  weapon: true,
  information: 'Government (PD/EMS/DOC) Issued Equipment',
};

itemList['-1768145561'] = {
  fullyDegrades: false,
  decayrate: 0.75,
  displayname: 'FN SCAR-L',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 50 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_scar.png',
  weapon: true,
  information: 'Government (PD/EMS/DOC) Issued Equipment - Subject to change',
};

// weapon_m14
itemList['-1719357158'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'mk14',
  price: 550,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'plastic', amount: 500 },
      { itemid: 'rubber', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 150 },
      { itemid: 'refinedplastic', amount: 150 },
      { itemid: 'refinedrubber', amount: 150 },
    ]
  ],
  weight: 43,
  nonStack: true,
  model: '',
  image: 'np_mk14.png',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
  weapon: true,
};

// weapon_m24
itemList['100416529'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'm24',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 50 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_m24.png',
  weapon: true,
};

// weapon_g22
itemList['-1536150836'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'AWM',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 50 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_awm.png',
  weapon: true,
};

// weapon_mg
itemList['-1660422300'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'PK machine gun',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 50 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_pkm.png',
  weapon: true,
};

// weapon_dragunov
itemList['-90637530'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Dragunov',
  price: 500,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'plastic', amount: 500 },
      { itemid: 'rubber', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 150 },
      { itemid: 'refinedplastic', amount: 150 },
      { itemid: 'refinedrubber', amount: 150 },
    ]
  ],
  weight: 43,
  nonStack: true,
  model: '',
  image: 'np_dragunov.png',
  weapon: true,
};

// weapon_assaultrifle
itemList['-1074790547'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'AK 47',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'plastic', amount: 500 },
      { itemid: 'rubber', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 150 },
      { itemid: 'refinedplastic', amount: 150 },
      { itemid: 'refinedrubber', amount: 150 },
    ]
  ],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_assault-rifle.png',
  weapon: true,
};

// weapon_advancedrifle
itemList['-1357824103'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'OTs-14 Groza',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'plastic', amount: 500 },
      { itemid: 'rubber', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 150 },
      { itemid: 'refinedplastic', amount: 150 },
      { itemid: 'refinedrubber', amount: 150 },
    ]
  ],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_groza.png',
  weapon: true,
};

// weapon_assaultrifle2
itemList['497969164'] = {
  fullyDegrades: false,
  decayrate: 3.0,
  displayname: 'M70',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'plastic', amount: 500 },
      { itemid: 'rubber', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 150 },
      { itemid: 'refinedplastic', amount: 150 },
      { itemid: 'refinedrubber', amount: 150 },
    ]
  ],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_m70.png',
  weapon: true,
};

// weapon_dbshotgun
itemList['-275439685'] = {
  fullyDegrades: false,
  decayrate: 3.0,
  displayname: 'Sawn-off Shotgun',
  price: 250,
  craft: [
    [
      { itemid: 'steel', amount: 200 },
      { itemid: 'copper', amount: 100 },
      { itemid: 'scrapmetal', amount: 100 },
    ],
    [
      { itemid: 'refinedsteel', amount: 50 },
      { itemid: 'refinedcopper', amount: 25 },
      { itemid: 'refinedscrap', amount: 25 },
    ]
  ],
  weight: 14,
  nonStack: true,
  model: '',
  image: 'np_db-shotgun.png',
  weapon: true,
};

// weapon_pumpshotgun
itemList['487013001'] = {
  fullyDegrades: false,
  decayrate: 3.0,
  displayname: 'IZh-81',
  price: 250,
  craft: [
    [
      { itemid: 'steel', amount: 150 },
      { itemid: 'copper', amount: 150 },
      { itemid: 'scrapmetal', amount: 150 },
    ],
    [
      { itemid: 'refinedsteel', amount: 30 },
      { itemid: 'refinedcopper', amount: 30 },
      { itemid: 'refinedscrap', amount: 30 },
    ]
  ],
  weight: 21,
  nonStack: true,
  model: '',
  image: 'np_izh81.png',
  weapon: true,
};

// weapon_pumpshotgun_mk2
itemList['1432025498'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Remington 870',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 21,
  nonStack: true,
  model: '',
  image: 'np_remington.png',
  weapon: true,
  information: 'Government (PD/EMS/DOC) Issued Equipment',
};

// WEAPON_COMBATPDW
itemList['171789620'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'SIG MPX',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_mpx.png',
  weapon: true,
  information: 'Government (PD/EMS/DOC) Issued Equipment',
};

// WEAPON_COMPACTRIFLE
itemList['1649403952'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Draco NAK9',
  price: 10,
  craft: [
    [
      { itemid: 'aluminium', amount: 300 },
      { itemid: 'steel', amount: 300 },
      { itemid: 'rubber', amount: 300 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 70 },
      { itemid: 'refinedsteel', amount: 70 },
      { itemid: 'refinedrubber', amount: 70 },
    ]
  ],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_draco.png',
  weapon: true,
};

// weapon_gepard used to apply skin and still generate data for the weapon
itemList['-1518444656'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Gepard',
  price: 10,
  craft: [
    [
      { itemid: 'aluminium', amount: 300 },
      { itemid: 'steel', amount: 300 },
      { itemid: 'rubber', amount: 300 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 70 },
      { itemid: 'refinedsteel', amount: 70 },
      { itemid: 'refinedrubber', amount: 70 },
    ]
  ],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_gepard.png',
  weapon: true,
};
//WEAPON_MINISMG2
itemList['-1472189665'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Skorpion',
  price: 10,
  craft: [
    [
      { itemid: 'aluminium', amount: 100 },
      { itemid: 'steel', amount: 100 },
      { itemid: 'rubber', amount: 100 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 20 },
      { itemid: 'refinedsteel', amount: 20 },
      { itemid: 'refinedrubber', amount: 20 },
    ]
  ],
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_skorpion.png',
  weapon: true,
};

// explosive type shit

itemList['-1813897027'] = {
  fullyDegrades: false,
  decayrate: 0.01,
  displayname: 'Stun Grenade (SWAT)',
  price: 100,
  weight: 5,
  craft: [[
    { itemid: 'aluminium', amount: 350 },
    { itemid: 'scrapmetal', amount: 350 },
    { itemid: 'rubber', amount: 300 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_stungrenade.png',
  information: 'So police can breach a building without feeling like a ______! If you are not SWAT certified do not buy this.',
  weapon: true,
  contraband: true,
};

itemList['1233104067'] = {
  fullyDegrades: false,
  decayrate: 0.25,
  displayname: 'Flare',
  price: 100,
  weight: 5,
  craft: [[
    { itemid: 'aluminium', amount: 350 },
    { itemid: 'scrapmetal', amount: 350 },
    { itemid: 'rubber', amount: 300 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_flare.png',
  information: '',
  weapon: true,
  contraband: true,
};

itemList['-1600701090'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'M67 grenade',
  price: 100,
  weight: 5,
  craft: [[
    { itemid: 'aluminium', amount: 110 },
    { itemid: 'scrapmetal', amount: 150 },
    { itemid: 'rubber', amount: 100 },
  ], [
    { itemid: 'refinedaluminium', amount: 35 },
    { itemid: 'scrapmetal', amount: 150 },
    { itemid: 'refinedrubber', amount: 35 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_grenade.png',
  information: '',
  weapon: true,
  contraband: true,
};

itemList['-37975472'] = {
  fullyDegrades: false,
  decayrate: 0.25,
  displayname: 'Smoke Grenade',
  price: 100,
  weight: 5,
  craft: [[
    { itemid: 'aluminium', amount: 150 },
    { itemid: 'scrapmetal', amount: 150 },
    { itemid: 'rubber', amount: 150 },
  ], [
    { itemid: 'refinedaluminium', amount: 45 },
    { itemid: 'refinedscrap', amount: 45 },
    { itemid: 'refinedrubber', amount: 45 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_stungrenade.png',
  information: '',
  weapon: true,
  contraband: true,
};

itemList['smokegrenadeswat'] = {
  fullyDegrades: false,
  decayrate: 0.01,
  displayname: 'Smoke Grenade (SWAT)',
  price: 100,
  weight: 25,
  craft: [[
    { itemid: 'aluminium', amount: 150 },
    { itemid: 'scrapmetal', amount: 150 },
    { itemid: 'rubber', amount: 150 },
  ], [
    { itemid: 'refinedaluminium', amount: 45 },
    { itemid: 'refinedscrap', amount: 45 },
    { itemid: 'refinedrubber', amount: 45 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_stungrenade.png',
  information: 'Mil-Spec. High price, low quality. If you are not SWAT certified do not buy this.',
  contraband: true,
};

itemList['smokegrenadenpa'] = {
  fullyDegrades: false,
  decayrate: 0.01,
  displayname: 'Smoke Grenade',
  price: 100,
  weight: 25,
  craft: [[
    { itemid: 'aluminium', amount: 150 },
    { itemid: 'scrapmetal', amount: 150 },
    { itemid: 'rubber', amount: 150 },
  ], [
    { itemid: 'refinedaluminium', amount: 45 },
    { itemid: 'refinedscrap', amount: 45 },
    { itemid: 'refinedrubber', amount: 45 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_stungrenade.png',
  information: 'NPA Edition.',
  contraband: true,
};

// Pipebomb pipe bomb
itemList['-1169823560'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Pipebomb',
  price: 250,
  weight: 7,
  craft: [[
    { itemid: 'aluminium', amount: 310 },
    { itemid: 'scrapmetal', amount: 350 },
    { itemid: 'rubber', amount: 300 },
  ], [
    { itemid: 'refinedaluminium', amount: 100 },
    { itemid: 'refinedscrap', amount: 100 },
    { itemid: 'refinedrubber', amount: 100 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_pipe-bomb.png',
  weapon: true,
  contraband: true,
};

// Molotov (Molly)
itemList['615608432'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Molly',
  craft: [
    [
      { itemid: 'aluminium', amount: 75 },
      { itemid: 'whiskey', amount: 3 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 12 },
      { itemid: 'whiskey', amount: 3 },
    ]
  ],
  price: 250,
  weight: 35,
  nonStack: false,
  model: '',
  image: 'np_molotov.png',
  weapon: true,
  contraband: true,
};

// Sticky Bomb C4
itemList['741814745'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Sticky Bomb',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 1250 },
    { itemid: 'scrapmetal', amount: 1250 },
    { itemid: 'rubber', amount: 1250 },
  ], [
    { itemid: 'refinedaluminium', amount: 415 },
    { itemid: 'scrapmetal', amount: 1250 },
    { itemid: 'refinedrubber', amount: 415 },
  ]],
  weight: 22,
  nonStack: true,
  model: '',
  image: 'np_sticky-bomb.png',
  weapon: true,
  contraband: true,
};

// random weapons

// Nail gun nailgun
itemList['1748076076'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Nail gun',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_nailgun.png',
  weapon: true,
};

// Parachute
itemList['-72657034'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Parachute',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 100 },
  ]],
  weight: 30,
  nonStack: true,
  model: '',
  image: 'np_parachute.png',
  weapon: false,
};
itemList['airxchute'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Parachute',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 500 },
    { itemid: 'plastic', amount: 1500 },
    { itemid: 'rubber', amount: 2500 },
  ]],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_parachute.png',
  weapon: false,
};
itemList['navychute'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Parachute',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 500 },
    { itemid: 'plastic', amount: 1500 },
    { itemid: 'rubber', amount: 2500 },
  ]],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_parachute.png',
  weapon: false,
};

itemList['airbornechute'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Parachute',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 500 },
    { itemid: 'plastic', amount: 1500 },
    { itemid: 'rubber', amount: 2500 },
  ]],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_parachute.png',
  weapon: false,
};

// koil gun
itemList['-1355376991'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'koils gun :) hehe ',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 155 },
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_pistol-50.png',
  weapon: true,
};

// Fire Extinguisher
itemList['101631238'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Fire Ext',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'scrapmetal', amount: 40 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_fire-extinguisher.png',
  weapon: true,
};

// Petrol can
itemList['883325847'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Petrol Can',
  price: 250,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_petrol-can.png',
  weapon: true,
};

// blunt weapons
//WEAPON_SLEDGEHAM
itemList['1923739240'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Sledge Hammer',
  craft: [
    [
      { itemid: 'steel', amount: 75 },
      { itemid: 'scrapmetal', amount: 75 },
    ],
    [
      { itemid: 'refinedsteel', amount: 25 },
      { itemid: 'refinedscrap', amount: 25 },
    ],
  ],
  price: 1,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_sledgehammer.png',
  information: 'Big and girthy.',
  weapon: true,
  contraband: true,
};

itemList['419712736'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Pipe Wrench',
  craft: [
    [
      { itemid: 'steel', amount: 75 },
      { itemid: 'scrapmetal', amount: 75 },
    ],
    [
      { itemid: 'refinedsteel', amount: 25 },
      { itemid: 'refinedscrap', amount: 25 },
    ],
  ],
  price: 1,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_wrench.png',
  information: 'I\'m here to fix your pipes.',
  weapon: true,
  contraband: true,
};

itemList['-102323637'] = {
  fullyDegrades: true,
  decayrate: 2.00,
  displayname: 'Old broken bottle',
  craft: [[
    { itemid: 'refinedglass', amount: 10 },
  ]],
  price: 1,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_glass-bottle.png',
  information: 'Looks like a green, premium, Karlsberg bottle.',
};

//weapon_knuckle
itemList['3638508604'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Knuckle',
  craft: [
    [
      { itemid: 'aluminium', amount: 125 },
      { itemid: 'scrapmetal', amount: 10 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 35 },
      { itemid: 'refinedscrap', amount: 3 },
    ]
  ],
  price: 250,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_knuckle-dusters.png',
  weapon: true,
  contraband: true,
};

itemList['knuckle_chain'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Chain Dusters',
  craft: [[
    { itemid: 'refinedscrap', amount: 20 },
    { itemid: 'refinedsteel', amount: 15 },
  ]],
  price: 250,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_chain_dusters.png',
  weapon: false,
  contraband: true,
};

itemList['gavel'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Gavel',
  price: 250,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_gavel.png',
  weapon: false,
};

itemList['1141786504'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Golfclub',
  price: 250,
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_golfclub.png',
  weapon: true,
};

itemList['1317494643'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Hammer',
  price: 250,
  weight: 8,
  nonStack: true,
  model: '',
  image: 'np_hammer.png',
  weapon: true,
};

itemList['1737195953'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Nightstick',
  price: 0,
  weight: 4,
  nonStack: true,
  model: '',
  image: 'np_nightstick.png',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
  weapon: true,
};

itemList['2227010557'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Crowbar',
  price: 250,
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_crowbar.png',
  weapon: true,
};

itemList['-1786099057'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Model M Keyboard',
  price: 250,
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_keyboard.png',
  weapon: true,
};


// sharp weapons

itemList['-1239161099'] = {
  fullyDegrades: false,
  decayrate: 5.0,
  displayname: 'Katana',
  price: 1,
  craft: [[
    { itemid: 'refinedsteel', amount: 650 },
  ]],
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_katana.png',
  information: 'When you were partying, I studied the blade.',
  weapon: true,
  contraband: true,
};

itemList['1692590063'] = {
  fullyDegrades: false,
  decayrate: 5.0,
  displayname: 'Katana',
  price: 1,
  craft: [[
    { itemid: 'refinedsteel', amount: 650 },
    { itemid: 'refinedaluminium', amount: 250 },
  ]],
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_katana.png',
  information: 'When you were partying, I studied the blade.',
  weapon: true,
  contraband: true,
};

itemList['cursedkatanaweapon'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cursed Katana',
  price: 1,
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_cursed-katana.png',
  information: 'Infused with the blood of a Dragon; a normal human mind cannot control such power.',
  weapon: true,
  contraband: true,
};

itemList['talonweapon'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Talon Sword',
  price: 1,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_talonsword.png',
  information: 'We are everywhere, we are everyone, fear us for we lurk in the shadows. We are Talon.',
  weapon: false,
  contraband: true,
};

itemList['-538741184'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Shank',
  craft: [[
    { itemid: 'steel', amount: 25 },
    { itemid: 'aluminium', amount: 100 },
  ]],
  price: 250,
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_switchblade.png',
  weapon: true,
};

itemList['2460120199'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Dagger',
  craft: [
    [
      { itemid: 'aluminium', amount: 125 },
      { itemid: 'scrapmetal', amount: 10 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 35 },
      { itemid: 'scrapmetal', amount: 10 },
    ]
  ],
  price: 250,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_dagger.png',
  weapon: true,
  contraband: true,
};

itemList['600439132'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Lime',
  craft: [[
    { itemid: 'refinedaluminium', amount: 25 },
    { itemid: 'refinedrubber', amount: 25 },
  ]],
  price: 250,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_lime.png',
  weapon: true,
  contraband: true,
};

itemList['126349499'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Snowball',
  price: 250,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_snowball.png',
  weapon: true,
  contraband: false,
};

itemList['-1024456158'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Bat',
  craft: [[
    { itemid: 'refinedaluminium', amount: 25 },
    { itemid: 'refinedrubber', amount: 25 },
  ]],
  price: 250,
  weight: 14,
  nonStack: true,
  model: '',
  image: 'np_baseball-bat.png',
  weapon: true,
  contraband: true,
};

itemList['-2000187721'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Secure Briefcase',
  price: 250,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_securitycase.png',
  weapon: true,
  contraband: true,
};

itemList['28811031'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Briefcase',
  price: 250,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_suitcase.png',
  weapon: true,
  contraband: true,
};

itemList['2578778090'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Knife',
  price: 250,
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_knife.png',
  weapon: true,
};

itemList['3713923289'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Machete',
  craft: [
    [
      { itemid: 'aluminium', amount: 140 },
      { itemid: 'rubber', amount: 40 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 35 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  price: 250,
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_machete.png',
  weapon: true,
  contraband: true,
};

itemList['4191993645'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Hatchet',
  price: 250,
  weight: 17,
  nonStack: true,
  model: '',
  image: 'np_hatchet.png',
  weapon: true,
};

// weapon attachments

// weapon ammo
itemList['subammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Sub Ammo x50',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_sub-ammo.png',
};

itemList['heavyammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Heavy Ammo x50',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_rifle-ammo.png',
};

itemList['sniperammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Sniper Ammo x25',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_sniper-ammo.png',
};

// LMG ammo is not actually being used for anything and has no "use function". It's the same as Heavy Ammo.
itemList['lmgammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'LMG Ammo x100',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 300,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_lmg-ammo.png',
  contraband: true,
};

itemList['shotgunammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'SG Ammo x50',
  craft: [[
    { itemid: 'refinedsteel', amount: 1 },
    { itemid: 'plastic', amount: 1 },
  ]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_shotgun-ammo.png',
};

itemList['pistolammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Pistol Ammo x50',
  craft: [
    [
      { itemid: 'aluminium', amount: 1 },
      { itemid: 'plastic', amount: 1 },
      { itemid: 'rubber', amount: 1 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 1 },
    ]
  ],
  price: 10,
  weight: 2,
  blockScrap: true,
  nonStack: false,
  model: '',
  image: 'np_pistol-ammo.png',
};

itemList['rifleammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Rifle Ammo x50',
  craft: [[
    { itemid: 'aluminium', amount: 10 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 10 },
  ]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_rifle-ammo.png',
  contraband: true,
};

itemList['pistolammoPD'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Pistol Ammo x50 PD',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
  image: 'np_pistol-ammo.png',
};

itemList['subammoPD'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Sub Ammo x50 PD',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
  image: 'np_sub-ammo.png',
};

itemList['rifleammoPD'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Rifle Ammo x50 PD',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_rifle-ammo.png',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
  contraband: true,
};

itemList['shotgunammoPD'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Shotgun Ammo x50',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
  image: 'np_shotgun-ammo.png',
};

itemList['taserammo'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Taser Cartridges',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
  image: 'np_taserammo.png',
};

itemList['empammo'] = {
  fullyDegrades: true,
  decayrate: 0.08,
  displayname: 'EMP Cartridge',
  price: 150,
  weight: 20,
  nonStack: false,
  model: '',
  image: 'np_emp_ammo.png',
};

itemList['nails'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Nails',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_nails.png',
};

itemList['paintballs'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Paintballs',
  craft: [[
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_paintball_ammo.png',
};

itemList['rubberslugs'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: '12-Gauge Rubber Slugs',
  craft: [[
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 3,
  nonStack: false,
  model: '',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
  image: 'np_rubberslugs.png',
};

// weapon_rayminigun
itemList['-1238556825'] = {
  fullyDegrades: false,
  decayrate: 1,
  displayname: 'Widowmaker',
  price: 1000,
  craft: [],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_rayminigun.png',
  weapon: true,
};

itemList['widowmakerammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Widow Maker Ammo',
  price: 100,
  weight: 7,
  nonStack: false,
  model: '',
  image: 'np_223ammo.png',
};

// END WEAPONS

// custom items with decay
itemList['spikes'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'PD Spike Kit',
  price: 10,
  weight: 20,
  nonStack: false,
  model: '',
  image: 'np_spikes.png',
  information: 'Considered Police Equipment - (only lasts around 10 seconds)',
};


itemList['repairkit'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'Repair Kit',
  craft: [[{ itemid: 'electronics', amount: 25 }]],
  price: 150,
  weight: 10,
  nonStack: false,
  model: '',
  image: 'np_basic_repair-kit.png',
};

itemList['wheelchair'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Wheelchair',
  price: 250,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_wheelchair.png',
  information: 'For broken legs n stuff',
};

// drugs

itemList['1gcocaine'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.5,
  displayname: '10g cocaine',
  craft: [[{ itemid: 'cocainebrick', amount: 0.01 }]],
  price: 100,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_cocaine-baggy.png',
  information: 'Looks really high quality. ',
  contraband: true,
  insertTo: ['ammonium_bicarbonate', 'cokeline']
};

itemList['1gcrack'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.5,
  displayname: '5g Crack',
  craft: [[
    { itemid: 'bakingsoda', amount: 1 },
    { itemid: 'coke5g', amount: 1 },
  ]],
  price: 100,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_crack.png',
  information: 'Crack... ',
  insertTo: ['crackpipe']
};

itemList['cocainebrick'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.5,
  displayname: 'Air Tight Cocaine Brick (1kg)',
  price: 50000,
  weight: 20,
  nonStack: false,
  model: '',
  image: 'np_cocaine-brick.png',
  information: 'GIVE US THE 9s YOU FUCKING PUSSY.',
  contraband: false,
};


itemList['coke50g'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.5,
  displayname: 'Coke Brick (50g)',
  price: 1000,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_cocaine-brick.png',
  information: 'Increases your Stamina and Movement Speed <br> Breaks down into product.',
  contraband: true,
};

itemList['coke5g'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.5,
  displayname: 'Coke Baggy (5g)',
  craft: [[{ itemid: 'coke50g', amount: 0.1 }]],
  price: 150,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_cocaine-baggy.png',
  information: 'Increases your Stamina and Movement Speed',
  contraband: true,
};

itemList['joint'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.2,
  displayname: '3g Joint',
  craft: [[
    { itemid: 'weedq', amount: 0.5 },
    { itemid: 'rollingpaper', amount: 1 },
  ]],
  price: 25,
  weight: 2,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_joint.png',
  information: 'Its a Joint, man. ',
  contraband: true,
};

itemList['maleseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Marijuana Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_weed-seed.png',
  information: 'Add this to a planted female seed to make it pregnant? You are pretty sure this seed has a penis.',
  contraband: true,
  seed: true,
};

itemList['femaleseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Female Marijuana Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_weed-seed.png',
  information: 'Surely I can just plant this, right?',
  contraband: true,
  seed: true,
};

itemList['oxy'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.75,
  displayname: 'Oxy 100mg',
  price: 150,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_Oxy.png',
  information: '',
  contraband: true,
};

itemList['oxybettalife'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.75,
  displayname: 'Oxy 100mg',
  craft: [[{ itemid: 'oxy', amount: 3 }]],
  price: 150,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_Oxy.png',
  information: 'Prescribed by Betta Life Pharmacy (Prescription required)',
  contraband: true,
};

itemList['weed12oz'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.0025,
  displayname: 'Weed 250 Oz',
  price: 250,
  weight: 35,
  nonStack: false,
  model: '',
  image: 'np_box-of-weed-12-18-oz.png',
  information: 'Lowers Stress <br> Breaks Down into other Product',
  contraband: true,
};

itemList['weed5oz'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.5,
  displayname: 'Weed 5 Oz',
  price: 500,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_weed-brick-40-Oz.png',
  information: 'Lowers Stress <br> Breaks Down into other Product',
  contraband: true,
};

itemList['weedoz'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.3,
  displayname: 'Weed Oz',
  price: 200,
  weight: 4,
  nonStack: false,
  model: '',
  image: 'np_weed-4-Oz.png',
  information: 'Lowers Stress',
  contraband: true,
};

itemList['weedq'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.3,
  displayname: 'Weed Q',
  craft: [[{ itemid: 'weedoz', amount: 0.25 }]],
  price: 65,
  weight: 2,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_weed-oz.png',
  information: 'Lowers Stress',
  contraband: true,
};

itemList['wetbud'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.3,
  displayname: 'Wet Bud (100 grams)',
  price: 30,
  weight: 35,
  nonStack: true,
  model: '',
  image: 'wet.png',
  information: 'Needs to be stored somewhere dry.',
  contraband: true,
};

itemList['driedbud'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.3,
  displayname: 'Dried Bud (100 Grams)',
  price: 30,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'buddry2.png',
  information: 'Pack It?',
  contraband: true,
};

itemList['smallbud'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.3,
  displayname: 'Packed Bud (20 Grams)',
  price: 30,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'buddry.png',
  information: 'Sell It?',
  contraband: true,
};

itemList['joint2'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.2,
  displayname: '2g Joint',
  craft: [[
    { itemid: 'smallbud', amount: 0.1 },
    { itemid: 'rollingpaper', amount: 1 },
  ]],
  price: 20,
  weight: 1,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_joint.png',
  information: 'Its a Joint, man. ',
  contraband: true,
};

itemList['lsdtab'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.3,
  displayname: 'LSD Tab',
  price: 200,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_lsdtab.png',
  information: 'For spectacular trips, or whatever.',
  contraband: true,
};

itemList['badlsdtab'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.3,
  displayname: 'LSD Tab',
  price: 200,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_badlsdtab.png',
  information: 'For spectacular trips, or whatever.',
  contraband: true,
};

// Fruits / Alcohol crafting
itemList['apple'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Apple',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_apple.png',
  information: '',
  foodCategory: ['sugar'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
  produce: true,
};

itemList['banana'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Banana',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_banana.png',
  information: '',
  foodCategory: ['sugar'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
  produce: true,
};

itemList['cherry'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Cherry',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cherry.png',
  information: '',
  foodCategory: ['sugar'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
  produce: true,
};

itemList['coconut'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Coconut',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_coconut.png',
  information: '',
  foodCategory: ['sugar'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
  produce: true,
};

itemList['grain'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Grain',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_grain.png',
  information: '',
  foodCategory: ['grain'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
  produce: true,
};

itemList['grapes'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Grapes',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_grapes.png',
  information: '',
  foodCategory: ['sugar'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
  produce: true,
};

itemList['kiwi'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Kiwi',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_kiwi.png',
  information: '',
  foodCategory: ['sugar'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
  produce: true,
};

itemList['lemon'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Lemon',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_lemon.png',
  information: '',
  foodCategory: ['sugar'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
  produce: true,
};

itemList['lime'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Lime',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_lime.png',
  information: '',
  foodCategory: ['sugar'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
  produce: true,
};

itemList['orange'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Orange',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_orange.png',
  information: '',
  foodCategory: ['sugar'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
  produce: true,
};

itemList['peach'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Peach',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_peach.png',
  information: '',
  foodCategory: ['sugar'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
  produce: true,
};

itemList['potato'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Potato',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_potato.png',
  information: '',
  foodCategory: ['vegetables'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
  produce: true,
};

itemList['strawberry'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Strawberry',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_strawberry.png',
  information: '',
  foodCategory: ['sugar'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
  produce: true,
};

itemList['watermelon'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.75,
  displayname: 'Watermelon',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_watermelon.png',
  information: '',
  foodCategory: ['sugar'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
  produce: true,
};

// HOA Mead

itemList['bottle_cap'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Bottle Cap',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_hoa_cap.png',
  information: 'Bottle cap saying HOA on it.',
};

itemList['mead_watermelon'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Watermelon Mead',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'watermelon', amount: 5 },
    { itemid: 'water', amount: 1 },
    { itemid: 'honey', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_mead_watermelon.png',
  information: 'The danish vikings really knew how to get hammered.',
};

itemList['mead_Strawberry'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Strawberry Mead',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'strawberry', amount: 5 },
    { itemid: 'water', amount: 1 },
    { itemid: 'honey', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_mead_strawberry.png',
  information: 'The danish vikings really knew how to get hammered.',
};

itemList['mead_potato'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Potato Mead',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'potato', amount: 5 },
    { itemid: 'water', amount: 1 },
    { itemid: 'honey', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_mead_potato.png',
  information: 'Why.',
};

itemList['mead_peach'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Peach Mead',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'peach', amount: 5 },
    { itemid: 'water', amount: 1 },
    { itemid: 'honey', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_mead_peach.png',
  information: 'The danish vikings really knew how to get hammered.',
};

itemList['mead_orange'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Orange Mead',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'orange', amount: 5 },
    { itemid: 'water', amount: 1 },
    { itemid: 'honey', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_mead_orange.png',
  information: 'The danish vikings really knew how to get hammered.',
};

itemList['mead_lime'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Lime Mead',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'lime', amount: 5 },
    { itemid: 'water', amount: 1 },
    { itemid: 'honey', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_mead_lime.png',
  information: 'The danish vikings really knew how to get hammered.',
};

itemList['mead_lemon'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Lemon Mead',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'lemon', amount: 5 },
    { itemid: 'water', amount: 1 },
    { itemid: 'honey', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_mead_lemon.png',
  information: 'The danish vikings really knew how to get hammered.',
};

itemList['mead_kiwi'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Kiwi Mead',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'kiwi', amount: 5 },
    { itemid: 'water', amount: 1 },
    { itemid: 'honey', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_mead_kiwi.png',
  information: 'The danish vikings really knew how to get hammered.',
};

itemList['mead_grape'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Grape Mead',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'grape', amount: 5 },
    { itemid: 'water', amount: 1 },
    { itemid: 'honey', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_mead_grape.png',
  information: 'The danish vikings really knew how to get hammered.',
};

itemList['mead_coconut'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Coconut Mead',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'coconut', amount: 5 },
    { itemid: 'water', amount: 1 },
    { itemid: 'honey', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_mead_coconut.png',
  information: 'The danish vikings really knew how to get hammered.',
};

itemList['mead_cherry'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Cherry Mead',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'cherry', amount: 5 },
    { itemid: 'water', amount: 1 },
    { itemid: 'honey', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_mead_cherry.png',
  information: 'The danish vikings really knew how to get hammered.',
};

itemList['mead_banana'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Banana Mead',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'banana', amount: 5 },
    { itemid: 'water', amount: 1 },
    { itemid: 'honey', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_mead_banana.png',
  information: 'The danish vikings really knew how to get hammered.',
};

itemList['mead_apple'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Apple Mead',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'apple', amount: 5 },
    { itemid: 'water', amount: 1 },
    { itemid: 'honey', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_mead_apple.png',
  information: 'The danish vikings really knew how to get hammered.',
};

// Drinks for VU
itemList['drink1'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Orange Lemon',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'orange', amount: 1 },
    { itemid: 'lemon', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_drink1.png',
  information: 'A perfect happy hour choice for vodka drinkers. Sates Thirst',
};

itemList['drink2'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cherry Berry',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'cherry', amount: 1 },
    { itemid: 'strawberry', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_drink2.png',
  information: ' Berry bliss. Sates Thirst',
};

itemList['drink3'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Banana Peach',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'banana', amount: 1 },
    { itemid: 'peach', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_drink3.png',
  information: 'Tastes just like fruity bubblegum. Sates Thirst',
};

itemList['drink4'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Orange Banana',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'orange', amount: 1 },
    { itemid: 'banana', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_drink4.png',
  information: 'Some sweetness to your summer. Sates Thirst',
};

itemList['drink5'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cherry Kiwi',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'cherry', amount: 1 },
    { itemid: 'kiwi', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_drink5.png',
  information: 'Fruity and refreshing. Sates Thirst',
};

itemList['drink6'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Berry Watermelon',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'strawberry', amount: 1 },
    { itemid: 'watermelon', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_drink6.png',
  information: 'Cool, Sweet, Colorful. Sates Thirst',
};

itemList['drink7'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Apple Lime',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'lime', amount: 1 },
    { itemid: 'apple', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_polarbear.png',
  information: 'Curbs sweet cravings. Sates Thirst',
};

itemList['drink8'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cherry Peach',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'cherry', amount: 1 },
    { itemid: 'peach', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_rumcoke.png',
  information: 'Perfect for cooling off on hot days. Sates Thirst',
};

itemList['drink9'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Coconut Lime',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'coconut', amount: 1 },
    { itemid: 'lime', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_straightvodka.png',
  information: 'Blended with an island twist. Sates Thirst',
};

itemList['drink10'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'White Paw',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'grapes', amount: 1 },
    { itemid: 'watermelon', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_whitepaw.png',
  information: 'Enjoy on your porch admiring the stars. Sates Thirst',
};

itemList['absinthe'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.3,
  displayname: 'Absinthe',
  craft: [[
    { itemid: 'glass', amount: 1 },
    { itemid: 'moonshine', amount: 1 },
  ]],
  price: 200,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_absinthe.png',
  information: 'The strongest you can get, 95%.',
};

itemList['shot1'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Orange Lemon',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'orange', amount: 1 },
    { itemid: 'lemon', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot1.png',
  information: 'Sates Thirst',
};

itemList['shot2'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cherry Berry',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'cherry', amount: 1 },
    { itemid: 'strawberry', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot2.png',
  information: 'Sates Thirst',
};

itemList['shot3'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Banana Peach',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'banana', amount: 1 },
    { itemid: 'peach', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot3.png',
  information: 'Sates Thirst',
};

itemList['shot4'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Orange Banana',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'orange', amount: 1 },
    { itemid: 'banana', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot4.png',
  information: 'Sates Thirst',
};

itemList['shot5'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cherry Kiwi',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'cherry', amount: 1 },
    { itemid: 'kiwi', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot5.png',
  information: 'Sates Thirst',
};

itemList['shot6'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Berry Watermelon',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'strawberry', amount: 1 },
    { itemid: 'watermelon', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot6.png',
  information: 'Sates Thirst',
};

itemList['shot7'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lime Apple',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'lime', amount: 1 },
    { itemid: 'apple', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot7.png',
  information: 'Sates Thirst',
};

itemList['shot8'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cherry Peach',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'cherry', amount: 1 },
    { itemid: 'peach', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot8.png',
  information: 'Sates Thirst',
};

itemList['shot9'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Coconut Lime',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'coconut', amount: 1 },
    { itemid: 'lime', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot9.png',
  information: 'Sates Thirst',
};

itemList['shot10'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Grapes Watermelon',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'grapes', amount: 1 },
    { itemid: 'watermelon', amount: 1 },
    { itemid: 'vodka', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_shot10.png',
  information: 'Sates Thirst',
};

// other drugy shit

itemList['aspirin'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Aspirin',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_aspirin.png',
  information: 'Its an Aspirin',
};

itemList['cabsinthe'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cannabis Absinthe',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cannabis-absinthe.png',
  information: 'Duuude..bro...',
};

itemList['redwine'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Red Wine',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_red-wine-bottle.png',
  information: 'No crime just wine',
};

itemList['rum'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Rum',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_rum.png',
  information: 'Why is it gone?',
};

itemList['tequila'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Tequila',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_tequila.png',
  information: 'Tequilya brand',
};

itemList['tequilashot'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Shot of Tequila',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_tequila-shot.png',
  information: 'Uno mas por favor',
};

itemList['vodka'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Vodka',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_vodka.png',
  information: 'Sates Thirst',
};

itemList['whiskey'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Whiskey',
  price: 5,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_whiskey.png',
  information: 'Sates Thirst',
};

itemList['420bar'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '420 Bar',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_420-bar.png',
  information: 'Duuuude brah...',
};

itemList['69box'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '69 Cigar Box',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_69-cigar-box.png',
  information: 'A taste of Cuba',
};

itemList['69pack'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '69 Brand Pack',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_69-brand-pack.png',
  information: 'Just one more',
};

itemList['champagne'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Champagne',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_champagne.png',
  information: 'Time to celebrate',
};

itemList['cgummies'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cannabis Gummies',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cannabis-gummies.png',
  information: 'Duuude...',
};

itemList['chloroform'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Chloroform',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_chloroform.png',
  information: 'Special Cross recipe',
};

itemList['ibuprofen'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Ibuprofen',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_ibuprofen.png',
  information: 'Cures all. Right?',
};

itemList['drugx'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Drug X',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_drug-x.png',
  information: 'Now in testing by Humane Labs',
};

// food

itemList['beer'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Beer',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_beer.png',
  information: 'Sates Thirst',
};

itemList['bfsandwich'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Breakfast Sandwich',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_breakfast-sandwich.png',
  information: 'Rise and shine',
};

itemList['cbballs'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cluckin Balls',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cluckin-balls.png',
  information: 'Ooh..salty. 440Cal',
};

itemList['cbbucket'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Chicken Bucket',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_chicken-bucket.png',
  information: 'I like chicken! 2350Cal',
};

itemList['cbclucker'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Little Clucker',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_little-clucker.png',
  information: 'Cluckin toy not included',
};

itemList['cbdrink'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cluckin Drink',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cluckin-drink.png',
  information: 'Hell Cluckin Yeah',
};

itemList['cbfarmers'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "Farmer's Surprise",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_farmers-surprise.png',
  information: 'The chewy bits arent harmful',
};

itemList['cbfowl'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Fowl Burger',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_fowl-burger.png',
  information: 'If you enjoyed it, the chicken didnt die in vain! 900Cal',
};

itemList['cbfries'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cluckin Fries',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cluckin-fries.png',
  information: 'Cluckinsize included. 680Cal',
};

itemList['cbrings'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cluckin Rings',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cluckin-rings.png',
  information: 'Suffering never tasted so good! 850Cal',
};

itemList['cbrownie'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cannabis Brownie',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cannabis-brownie.png',
  information: 'Dude...',
};

itemList['cbveggy'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Veggy Salad',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_veggy-salad.png',
  information: 'Mystery chewy bits included. 750Cal',
};

itemList['cocoab'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cocoa Butter',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cocoa-butter.png',
  information: 'Hecho en Guatemala',
};

itemList['cookie'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Cookie',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 2,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cookie.png',
  information: 'Baked with love',
};

itemList['tobacco'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Tobacco',
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_tobacco.png',
  information: 'Used for ciggies',
};

itemList['gause'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Gause',
  price: 4,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_gause.png',
  information: 'Used for making bandages',
};

itemList['crabcakes'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Crab Cakes',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_crab-cakes.png',
  information: 'Scrumptious',
};

itemList['energybar'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Energy Bar',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_energy-bar.png',
  information: 'Ego Chaser bars for chads',
};

itemList['pizza'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pizza Slice',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_pizza-slice.png',
  information: 'Check for pineapple',
};

itemList['sushiplate'] = {
  fullyDegrades: true,
  decayrate: 0.005,
  displayname: 'Sushi Plate',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_sushi-plate.png',
  information: "Exquisite. You'll feel charmed by the water.",
};

itemList['sushiplatec'] = {
  fullyDegrades: true,
  decayrate: 0.005,
  displayname: 'Sushi Plate',
  craft: [[{ itemid: 'fishingflounder', amount: 1 }, { itemid: 'fishingcod', amount: 1 }]],
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_sushi-plate.png',
  information: "Exquisite. You'll feel charmed by the water.",
};

itemList['beefdish'] = {
  fullyDegrades: true,
  decayrate: 0.005,
  displayname: 'Beef Dish',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_beefdish.png',
  information: "Delicious. You will feel charmed by the mountains.",
};

itemList['beefdishc'] = {
  fullyDegrades: true,
  decayrate: 0.005,
  displayname: 'Beef Dish',
  craft: [[{ itemid: 'freshmeat', amount: 1 }]],
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_beefdish.png',
  information: "Delicious. You will feel charmed by the mountains.",
};

itemList['sushiroll'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Sushi Rolls',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_sushi-rolls.png',
  information: 'Made fresh',
};

itemList['wings'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Wings',
  craft: [[{ itemid: 'foodingredient', amount: 3 }]],
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_wings.png',
  information: 'Dont lick your fingers',
};

itemList['chips'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Chips',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_chips.png',
  information: 'Phat Chips yeeeaaah. Thickens blood.',
};

itemList['chocobar'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Chocolate Bar',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_chocolate-bar.png',
  information: 'Mmm...Meteorite Bar',
};

itemList['maccheese'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Mac & Cheese',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_macn-cheese.png',
  information: 'Kraft Dinner, just like Grandma used to make. Relieves stress',
};

itemList['meteorite'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Fukang Meteorite',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_fukang-meteorite.png',
  information: 'Out of this world',
};

itemList['pancakes'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pancakes',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_pancakes.png',
  information: 'Flat but tasty',
};

itemList['panini'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Panini Sandwich',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_panini-sandwich.png',
  information: 'Piquant',
};

itemList['pinacolada'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pina Colada',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_pina-colada.png',
  information: 'And getting caught in the rain',
};

itemList['popcorn'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Popcorn',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_popcorn.png',
  information: 'Dis gon b gud',
};

itemList['ramen'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Ramen',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ramen.png',
  information: 'Itadakimasu!',
};

itemList['bubblelasagna'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "'Lasagna'",
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_bubblelasagna.png',
  information: 'Cooked.. somehow..',
};

itemList['spaghetti'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Spaghetti',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_spaghetti.png',
  information: 'Knees weak...',
};

itemList['spaghettican'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Can of Spaghetti',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_spaghetti-can.png',
  information: 'Fresh from the trunk, awight?',
};

itemList['torta'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Torta',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_torta.png',
  information: 'El mejor jamon',
};

// dayz food

itemList['coffee'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Coffee',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_coffee.png',
  information: 'Wow, its strong.',
};

itemList['cola'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Cola',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_coke.png',
  information: 'Sates Thirst',
};

itemList['burrito'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Burrito',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_burrito.png',
  information: 'Burrito',
};

itemList['eggsbacon'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Eggs and Bacon',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_eggs-and-bacon.png',
  information: 'Great start to your morning',
};

itemList['donut'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Donut',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_donut.png',
  information: 'Powered by Francis™',
};

itemList['applepie'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Apple Pie',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_creampie.png',
  information: 'Apple Pie with Cream. Emphasis on the Cream.',
};

itemList['foodgoods'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Food goods',
  price: 500,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_food-goods.png',
};

itemList['foodingredient'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Ingredients',
  price: 10,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_ingredients.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
};

itemList['merchingredient'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Generic Material',
  price: 10,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_merchandise.png',
  information: 'Used to craft other items',
};

itemList['fries'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Fries',
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fries.png',
  information: 'Sates Hunger and thickens blood',
};

itemList['greencow'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Green Cow',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_green-cow.png',
  information: 'Slightly Increases Stamina and Speed',
};

itemList['churro'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Churro',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_churro.png',
  information: 'Basically a long donut. Gives a sugar rush when eaten.',
};

itemList['bakingsoda'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Baking Soda',
  price: 50,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_bakingsoda.png',
  information: 'Its Baking Soda..? Not for human consumption.',
};

itemList['bleederburger'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'The Bleeder',
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_the-bleeder.png',
  information: 'Sates Hunger and reduces stress.',
};

itemList['water'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Water',
  price: 5,
  weight: 1,
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  nonStack: false,
  model: '',
  image: 'np_water.png',
  information: 'Sates Thirst',
};

itemList['kdragonwater'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Enchanted Water',
  price: 20,
  weight: 1,
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  nonStack: false,
  model: '',
  image: 'np_water.png',
  information: 'Blessed with the Blood of a Dragon',
};

itemList['hotdog'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Hot Dog',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_hotdog.png',
  information: 'Dont ask what is in it',
};

itemList['icecream'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Ice Cream',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_icecream.png',
  information: 'Made from real human titty milk. Prevents stress from being gained or relieved.',
};

itemList['jailfood'] = {
  fullyDegrades: true,
  decayrate: 0.001,
  displayname: 'Jail Food',
  price: 0,
  weight: 25,
  nonStack: false,
  model: '',
  image: 'np_jailfood.png',
  information: "Looks as bad as the Sheriff's aim.",
};

itemList['jaildrink'] = {
  fullyDegrades: true,
  decayrate: 0.001,
  displayname: 'Jail Drink',
  price: 0,
  weight: 10,
  nonStack: false,
  model: '',
  image: 'np_jaildrink.png',
  information: "Looks as bad as the Chief of Police's aim.",
};

itemList['sandwich'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  displayname: 'Sandwich',
  price: 250,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_sandwich.png',
  information: 'Sates Hunger',
};

itemList['torpedo'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Torpedo',
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_torpedo.png',
  information: 'Sates Hunger and reduces stress.',
};

itemList['treat'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Dog Treat',
  price: 69,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_treat.png',
  information: 'Feed to dog',
};

itemList['hamburger'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Hamburger',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_hamburger.png',
  information: 'Sates Hunger',
};

itemList['weedtaco'] = {
  fullyDegrades: true,
  decayrate: 0.00024,
  displayname: 'Delivery',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 10,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_paperbag.png',
  information: 'This aint free taco.',
  contraband: true,
};

itemList['fishtaco'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Fish Taco',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishtaco.png',
  information: 'Make like the fishes.',
};

itemList['heartstopper'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'The Heart Stopper',
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_the-heart-stopper.png',
  information: 'Sates Hunger and reduces stress.',
};

itemList['moneyshot'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Money Shot',
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_money-shot.png',
  information: 'Sates Hunger and reduces stress.',
};

itemList['questionablemeatburger'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Questionable Meat Burger',
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_q_meat.png',
  information: 'Sates Hunger...',
};

itemList['questionablemeat'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Questionable Meat',
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_patty_raw.png',
  information: 'Wtf?',
};

itemList['meatfree'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Meat Free',
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_meat-free.png',
  information: 'Sates Hunger and reduces stress.',
};

itemList['mshake'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Milkshake',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_milkshake.png',
  information: 'Hand-scooped for you.',
};

itemList['taco'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Taco',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_taco.png',
  information: 'This aint free taco.',
};

itemList['freshmeat'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Fresh Meat',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_rawmeat.png',
  information: 'Meat, Wow..',
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

itemList['beef'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Beef',
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_rawmeat.png',
  foodCategory: ['protein'],
  foodEnhancement: 0.6,
  foodEnhancementFromMeta: false,
};

itemList['raw_steak'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Raw Steak',
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_steak_raw.png',
  foodCategory: ['protein'],
  foodEnhancement: 0.8,
  foodEnhancementFromMeta: false,
};

itemList['blue_rare_steak'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Blue Rare Steak',
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_steak_blue_rare.png',
  foodCategory: ['protein'],
  foodEnhancement: 0.8,
  foodEnhancementFromMeta: false,
};

itemList['rare_steak'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Rare Steak',
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_steak_rare.png',
  foodCategory: ['protein'],
  foodEnhancement: 0.8,
  foodEnhancementFromMeta: false,
};

itemList['medium_rare_steak'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Medium Rare Steak',
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_steak_medium_rare.png',
  foodCategory: ['protein'],
  foodEnhancement: 0.8,
  foodEnhancementFromMeta: false,
};

itemList['medium_steak'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Medium Steak',
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_steak_medium.png',
  foodCategory: ['protein'],
  foodEnhancement: 0.8,
  foodEnhancementFromMeta: false,
};

itemList['medium_well_steak'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Medium Well Steak',
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_steak_medium_well.png',
  foodCategory: ['protein'],
  foodEnhancement: 0.8,
  foodEnhancementFromMeta: false,
};

itemList['well_done_steak'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Well Done Steak',
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_steak_well_done.png',
  foodCategory: ['protein'],
  foodEnhancement: 0.1,
  foodEnhancementFromMeta: false,
};

// materials

itemList['aluminium'] = {
  craft: [[{ itemid: 'recyclablematerial', amount: 1 }]],
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Aluminium',
  price: 10,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_aluminum.png',
};

itemList['plastic'] = {
  craft: [[{ itemid: 'recyclablematerial', amount: 1 }]],
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Plastic',
  price: 11,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_plastic.png',
};

itemList['copper'] = {
  craft: [[{ itemid: 'recyclablematerial', amount: 1 }]],
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Copper',
  price: 10,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_copper.png',
};

itemList['electronics'] = {
  craft: [[{ itemid: 'recyclablematerial', amount: 1 }]],
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Electronics',
  price: 15,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_electronics.png',
};

itemList['rubber'] = {
  craft: [[{ itemid: 'recyclablematerial', amount: 1 }]],
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Rubber',
  price: 10,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_rubber.png',
};

itemList['scrapmetal'] = {
  craft: [[{ itemid: 'recyclablematerial', amount: 1 }]],
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Scrap Metal',
  price: 15,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_scrap-metal.png',
};

itemList['steel'] = {
  craft: [[{ itemid: 'recyclablematerial', amount: 1 }]],
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Steel',
  price: 15,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_steel.png',
};

itemList['glass'] = {
  craft: [[{ itemid: 'recyclablematerial', amount: 1 }]],
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Glass',
  price: 12,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_glass.png',
};

itemList['advlockpick'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Adv Lock Pick',
  price: 2500,
  craft: [
    [
      { itemid: 'aluminium', amount: 50 },
      { itemid: 'plastic', amount: 50 },
      { itemid: 'rubber', amount: 50 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 15 },
      { itemid: 'refinedplastic', amount: 12 },
      { itemid: 'refinedrubber', amount: 15 },
    ]
  ],
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_advanced-lockpick.png',
};

itemList['hackingdevice'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Security System Hacking Device',
  price: 12500,
  craft: [
    [
      { itemid: 'refinedaluminium', amount: 33 },
      { itemid: 'refinedcopper', amount: 33 },
      { itemid: 'refinedrubber', amount: 33 },
      { itemid: 'refinedplastic', amount: 33 },
    ]
  ],
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_hacking_device.png',
  information: 'Marked for Police Seizure',
}

itemList['pixelvirusvaccine'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Nanites suppressor',
  price: 12500,
  craft: [],
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_tl_nanitesupressor.png',
  information: 'Use it to supress the infection',
}

itemList['bikearmor'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Bike Armor',
  price: 500,
  weight: 50,
  craft: [
    [
      { itemid: 'refinedaluminium', amount: 8 },
      { itemid: 'refinedcopper', amount: 8 },
      { itemid: 'refinedrubber', amount: 8 },
      { itemid: 'refinedplastic', amount: 8 },
    ]
  ],
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_bikearmor.png',
  information: 'Protects you from motorbike accidents.',
};

itemList['armor'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'Chest Armor',
  craft: [[
    { itemid: 'aluminium', amount: 5 },
    { itemid: 'plastic', amount: 5 },
    { itemid: 'rubber', amount: 5 },
  ]],
  price: 400,
  weight: 37,
  nonStack: false,
  model: '',
  image: 'np_chest-armor.png',
  information: 'Protects you from bleeding and stumbling on injuries.',
};

itemList['pdarmor'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: '(PD) Chest Armor',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 50,
  weight: 37,
  nonStack: false,
  model: '',
  image: 'np_chest-armor.png',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
};

itemList['bandage'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'First Aid Kit',
  price: 50,
  weight: 3,
  nonStack: false,
  model: 'prop_ld_health_pack',
  image: 'np_bandage.png',
  information: 'Heals Wounds and Reduces Bleeding',
};

itemList['bandagelarge'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'Large First Aid Kit',
  price: 50,
  weight: 10,
  nonStack: false,
  model: 'prop_ld_health_pack',
  image: 'np_bandage.png',
  information: 'Heals Wounds and Reduces Bleeding',
  craft: [[
    { itemid: 'bandage', amount: 4 },
  ]],
};

itemList['casinosoap'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'Luck be a Lather',
  price: 50,
  weight: 5,
  nonStack: false,
  model: 'prop_ld_health_pack',
  image: 'np_casino_soap.png',
  information: 'Feeling Lucky? From Clean Getaway Soap Co.',
};

itemList['casinogoldcoin'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'Diamond Hotel Krugerrand',
  price: 50,
  weight: 1,
  nonStack: false,
  image: 'np_casinogoldcoin.png',
  information: 'Useful for stuff',
};

// general items

itemList['aluminiumoxide'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Aluminium Oxide',
  price: 55,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_aluminum-oxide.png',
};

itemList['advrepairkit'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Adv Repair Kit',
  craft: [
    [
      { itemid: 'electronics', amount: 15 },
      { itemid: 'aluminium', amount: 15 }
    ]
  ],
  price: 100,
  weight: 20,
  nonStack: false,
  model: '',
  image: 'np_repair-toolkit.png',
  information: '1 Time use - degrades engine parts more than basic tool kits, repairs engine to full.',
};

itemList['tirerepairkit'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire Repair Kit',
  craft: [[
    { itemid: 'steel', amount: 2 },
    { itemid: 'copper', amount: 1 },
    { itemid: 'rubber', amount: 6 },
  ]],
  price: 20,
  weight: 5,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_tire_repair-kit.png',
  information: 'For swapping damaged tires.',
};

itemList['assphone'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Ass Phone',
  price: 500,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_poophone.png',
  information:
    'You cant seem to work out the lock code?',
};

// custom items

itemList['ace'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Ace of Spades',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_ace-of-spades.png',
  information: 'Up your sleeve',
};

itemList['action'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Action Figure',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_action-figure.png',
  information: 'Superhero: Impotent Rage',
};

itemList['agothic'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'American Gothic',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_american-gothic.png',
  information: 'Wood 1930',
};

itemList['armxray'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Arm X-Ray',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_arm-xray.png',
  information: 'Ouch...',
};

itemList['atacos'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Tacos de Asada',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_tacos-de-asada.png',
  information: 'I could eat ten',
};

itemList['azpapers'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Aztecas Papers',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_aztecas-papers.png',
  information: 'Orale',
};

itemList['anime'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Anime Poster',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_anime-poster.png',
  information: 'Weebs in uwu',
};

itemList['antlers'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Antlers',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_antlers.png',
  information: 'A fine prize',
};

itemList['aodcut'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'AoD MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_aod-cut.png',
  information: "The fruits of Lester Arnold's labor",
};

itemList['bluebelt'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Blue 622 Belt',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_blue-belt.png',
  information: 'Blue 622 - Sensei',
};

itemList['blackbelt'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Black Belt',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_black-belt.png',
  information: 'Master Rank 4/4',
};

itemList['blackchip'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Black Chip',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_black-chip.png',
  information: 'Feel nice in your hand',
};

itemList['bglass'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Beer Glass',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_glass-of-beer.png',
  information: 'Wait for this all to blow over',
};

itemList['bobross'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Bob Ross Photo',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_bob-ross-photo.png',
  information: 'Happy little loose ends...',
};

itemList['bondicut'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Bondi Boys Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_bondi-cut.png',
  information: 'And an old rocking chair',
};

itemList['bspapers'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Ballas Papers',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_ballas-papers.png',
  information: 'You good?',
};

itemList['bucket'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Bucket',
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_bucket.png',
};

itemList['burialmask'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Burial Mask',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_burial-mask.png',
  information: 'Mask of Tutankhamun',
};

itemList['braab'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Braab Shirt',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_braab-tshirt.png',
  information: 'Yikes',
};

itemList['brain'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Brain MRI',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_brain-mri.png',
  information: 'Ow...',
};

itemList['bonsai'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Bonsai Tree',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_bonsai-tree.png',
  information: 'Be one with nature',
};

itemList['cactus'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cactus',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cactus.png',
  information: 'For the lazy',
};

itemList['cathat'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "Children's Book",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_childrens-book.png',
  information: 'Its story time...',
};

// spell books and shit
itemList['spellbook-mana'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "Mana Potion",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_mana.png',
  information: 'Its obviously fake and childish...',
};
itemList['spellbook-poop'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "Poop",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_spellred.png',
  information: 'Probably used for LARP.... (Point on use)',
};

itemList['spellbook-test'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "Test",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_spellred.png',
  information: 'Probably used for LARP.... (Point on use)',
};

itemList['spellbook-buff'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "Strength Buff",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_spellred.png',
  information: 'Probably used for LARP.... (Point on use)',
};
itemList['spellbook-speed'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "Swiftness",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_spellblue.png',
  information: 'Probably used for LARP.... (Point on use)',
};

itemList['spellbook-flame'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "Hand Flame",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_spellred.png',
  information: 'Probably used for LARP.... (Point on use)',
};

itemList['spellbook-roar'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "Dragons Roar",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_spellred.png',
  information: 'Feel my wrath! (You can not see this item)',
};

itemList['spellbook-blink'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "Sloths Shadowstep",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_spellred.png',
  information: 'You dont need to move fast if you can teleport! (You can not see this item)',
};

itemList['spellbook-shock'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "Arcane Stun",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_spellnormal.png',
  information: 'Probably used for LARP.... (Point on use)',
};

itemList['spellbook-heal'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "Nourish",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_spellnormal.png',
  information: 'Probably used for LARP....',
};

itemList['spellbook-slow'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "Slow Time",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_spellblue.png',
  information: 'Probably used for LARP.... (Point on use)',
};

// spell book ends

itemList['camille'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Camille',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_camille.png',
  information: 'Monet 1866',
};

itemList['carbattery'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Car Battery',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_car-battery.png',
  information: 'Car Battery',
};

itemList['carhood'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Car Hood',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_car-hood.png',
  information: 'Car Hood',
};

itemList['cashroll'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Roll of Cash',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cash-roll.png',
  information: 'Whats the count..',
};

itemList['cashstack'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Stack of Cash',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cash-stack.png',
  information: 'All nice and sequential.',
};

itemList['bdiamond'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Blue Diamond',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_blue-diamond.png',
  information: 'Bavaria 1918.',
};

itemList['band'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Band of Notes',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cash-stack.png',
  information: 'Lots of low denominators - Indicates drug sales.',
};

itemList['rollcash'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Roll of Small Notes',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cash-roll.png',
  information: 'Lots of low denominators - Indicates drug sales.',
};

itemList['battery'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Battery',
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_battery.png',
};

itemList['bazooka'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Bazooka Suppressor',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_bazooka-suppressor.png',
  information: 'Good for a single shot.',
};

itemList['binoculars'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Binoculars',
  craft: [[
    { itemid: 'aluminium', amount: 5 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 300,
  weight: 10,
  nonStack: false,
  model: '',
  image: 'np_binoculars.png',
};

itemList['blindfold'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Blindfold',
  price: 250,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_blindfold.png',
};

itemList['bloodbag'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Blood Bag',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_blood-bag.png',
  information: 'Just my type',
};

itemList['bloodvial'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Blood Vial',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_blood-tube.png',
  information: 'Simon ese',
};

itemList['blueb'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Blue Bandana',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_blue-bandana.png',
  information: 'Simon ese',
};

itemList['bluechip'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Blue Chip',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_blue-chip.png',
  information: 'Double or nothing',
};

itemList['bmary'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Bloody Mary',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_bloody-mary.png',
  information: 'With a hint of lemon',
};

itemList['Boombox'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Boombox',
  price: 350,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_boombox.png',
  information: 'Its a prop, wow?',
};

itemList['Box'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Box',
  price: 350,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_box.png',
  information: 'Its a prop, wow?',
};

itemList['breadboard'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Breadboard',
  price: 60,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_breadboard.png',
};

itemList['camera'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Nikea NP1000',
  price: 2000,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_camera.png',
  information: 'Works 100% of the time 60% of the time.',
};

itemList['casing'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Bullet Casing',
  price: 10,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_pistol-ammo.png',
};

itemList['certificate'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Certificate',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_certificate.png',
  information: 'You made it!',
};

itemList['cgpapers'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'CG Papers',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cg-papers.png',
  information: 'Wata woozers',
};

itemList['chalice'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pimp Chalice',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_pimp-chalice.png',
  information: 'Morgan Freidmans Legendary Pimp Chalice.',
};

itemList['champion'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Championship Belt',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_champion-belt.png',
  information: 'Money is in the rematch.',
};

itemList['chestxray'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Chest X-Ray',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_chest-xray.png',
  information: 'Argh...',
};

itemList['chglass'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Champagne Glass',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_champagne-glass.png',
  information: 'To us',
};

itemList['cigar'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cigar',
  price: 30,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cigar.png',
};

itemList['ciggy'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Cigarette',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cigarette.png',
};

itemList['ciggypack'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Cigarettes',
  price: 30,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_ciggypack.png',
  information: 'A packet of smokes, they smell and taste like shit, but they relieve stress, the stress created by the addiction sure, but they relieve stress.',
};

itemList['civtrophy'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Civilian of the Year',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_civ-trophy.png',
  information: 'The greatest law-abiding citizen',
};

itemList['ckatana'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Sheathed Cursed Katana',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cursed-katana.png',
  information: 'A normal human mind cannot control such power.',
};

itemList['clotion'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cannabis Lotion',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cannabis-lotion.png',
  information: 'Bro..duuudee..',
};

itemList['clover'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Four-leaf Clover',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_clover.png',
  information: '+255 Luck',
};

itemList['comp'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Composition',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_composition.png',
  information: 'What do you think it means?',
};

itemList['corpsefeet'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Feet',
  price: 50,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'feet2.png',
  information: 'Wheres the rest of the body?',
};

itemList['corpsehands'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Hands',
  price: 50,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'hands.png',
  information: 'Wheres the rest of the body?',
};

itemList['coupon10'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '10% Off Coupon',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_coupon-ten.png',
  information: 'Limit only one per sale!',
};

itemList['coupon15'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '15% Off Coupon',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_coupon-fifteen.png',
  information: 'Does not include jail time',
};

itemList['coupon25'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '25% Off Coupon',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_coupon-25.png',
  information: 'Expires 01/2045',
};

itemList['cpelt'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cougar Pelt',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cougar-pelt.png',
  information: 'The hunter becomes the hunted',
};

itemList['crane'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Origami Crane',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_origami-crane.png',
  information: 'Gaff approved',
};

itemList['csuey'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Chop Suey',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_chop-suey.png',
  information: 'Hopper 1929',
};

itemList['ctooth'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cougar Tooth',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cougar-tooth.png',
  information: 'Stalks its prey',
};

itemList['ctrophy'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cooking Trophy',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cooking-trophy.png',
  information: 'Shokugeki victory',
};

itemList['cuffs'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Hand Cuffs',
  craft: [[{ itemid: 'scrapmetal', amount: 500 }]],
  price: 250,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_hand-cuffs.png',
  information: 'Marked for Police Seizure',
};

itemList['cultneck'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cult Necklace',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cult-necklace.png',
  information: 'One of us...',
};

itemList['bashneck'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'White Gold Necklace',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_bash_necklace.png',
  information: 'The necklace says BASH on it.',
};

itemList['dcboard'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Diamond Chessboard',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_diamond-chessboard.png',
  information: 'Deep Blue cant appreciate this',
};

itemList['dcert'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Death Certificate',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_d-certificate.png',
  information: 'In memoriam',
};

itemList['decrypterenzo'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Decrypter Enzo',
  price: 300,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_decrypter-enzo.png',
};

itemList['decrypterfv2'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Decrypter Fv2',
  price: 300,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_decrypter-fv2.png',
};

itemList['decryptersess'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Decrypter Sess',
  price: 300,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_decrypter-sess.png',
};

itemList['dhide'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Deer Hide',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_deer-hide.png',
  information: 'Call peta',
};

itemList['diamondrec'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Diamond Record',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_diamond-record.png',
  information: '10 Million units sold!!',
};

itemList['dice'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pair of Dice',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_dice.png',
  information: 'Just takin out the trash',
};

itemList['francisdice'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Dice',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_loadeddice.png',
  information: 'The dice feel different in the hand.',
};

itemList['dodo'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Dodo Statue',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_dodo-statue.png',
  information: 'Arent these extinct?',
};

itemList['dodospit'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Dodo Spit',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_dodo-spit.png',
  information: 'What the..why?!',
};

itemList['doramaar'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Dora Maar au Chat',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_dora-maar-auchat.png',
  information: 'Picasso 1941',
};

itemList['dragon'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Dragon',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_dragon.png',
  information: 'Hopefully its not useless like in GOT',
};

itemList['dream'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Dreamcatcher',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_dreamcatcher.png',
  information: 'Sleep well',
};

itemList['drill'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Drill',
  craft: [[
    { itemid: 'aluminium', amount: 25 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 150,
  weight: 80,
  nonStack: false,
  model: '',
  image: 'np_drill.png',
};

itemList['drillbit'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Drill Bit',
  price: 100,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_drill-bit.png',
};

itemList['drivingtest'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Driving Test',
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_driving-test.png',
};

itemList['dskull'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Diamond Skull',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_diamond-skull.png',
  information: 'For the Love of God - Hirst 2007',
};

itemList['DuffelBag'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Black Duffel Bag',
  price: 350,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_duffel.png',
  information: 'Its a prop, wow?',
};

itemList['dusche'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Dusche Gold',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_dusche-gold.png',
  information: 'Let it pour',
};

itemList['dye'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Dye',
  price: 10,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_dye.png',
};

itemList['electronickit'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Electronic Kit',
  craft: [[{ itemid: 'electronics', amount: 230 }]],
  price: 900,
  weight: 15,
  nonStack: false,
  model: '',
  image: 'np_electronic-kit.png',
};

itemList['emptybaggies'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Empty Baggies',
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_pack-of-empty-baggies.png',
};

itemList['enchiladas'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Enchiladas',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_enchiladas.png',
  information: 'Mas chile por favor',
};

itemList['ering'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Engagement Ring',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_engagement-ring.png',
  information: 'Hope its a yes...',
};

itemList['erpring'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Gold Band Ring.',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_engagement-ring.png',
  information: "Its a Sapphire Diamond & Gold ring. You look upon the ring and it reads 'Isaacs Dearest'...",
};

itemList['evidence'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Evidence',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence.png',
};

itemList['np_evidence_marker_yellow'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Evidence',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_yellow.png',
};

itemList['np_evidence_marker_red'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Evidence',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_red.png',
};

itemList['np_evidence_marker_white'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Evidence',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_white.png',
};

itemList['np_evidence_marker_orange'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Evidence',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_orange.png',
};

itemList['np_evidence_marker_light_blue'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Evidence',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_light_blue.png',
};

itemList['np_evidence_marker_purple'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Evidence',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_purple.png',
};

itemList['evidencebag'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Evidence Bag',
  price: 0,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_evidence-bag.png',
};

itemList['pdbadge'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'PD Badge',
  price: 0,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_pd_badge.png',
};

itemList['airbornewings'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Airborne Wings',
  price: 0,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_airborne-wings.png',
};

itemList['faberge'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Faberge Egg',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_faberge-egg.png',
  information: 'Rockford Hills easter egg',
};

itemList['failtest'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Failed Test',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_failed-test.png',
  information: 'Try again later',
};

itemList['fakeplate'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'Fake Plate Kit',
  craft: [
    [
      { itemid: 'scrapmetal', amount: 20 },
      { itemid: 'plastic', amount: 20 }
    ]
  ],
  price: 50,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_plate.png',
  information: 'Use on a vehicle to alter its plate or change it back - 1 time use..',
};

itemList['fbumper'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Front Bumper',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_front-bumper.png',
  information: 'Ill have the tuna, no crust',
};

itemList['feathers'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Feathers',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_feathers.png',
  information: 'Get plucked',
};

itemList['femmes'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "Les Femmes d'Alger",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_les-femmes-dalger.png',
  information: 'Picasso 1955',
};

itemList['fertilizer'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Fertilizer',
  price: 500,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_fertilizer.png',
  information: 'Cool.',
};

itemList['filetm'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Filet Mignon',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_filet-mignon.png',
  information: 'Succulent',
};

itemList['flowers'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Flowers',
  price: 50,
  weight: 10,
  nonStack: false,
  model: '',
  image: 'np_flowers.png',
  information: 'Wow, so beautiful.',
};

itemList['flyer'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Flyer',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_flyer.png',
  information: 'Invite people to your business or event!',
};

itemList['flyer'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Flyer',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_flyer.png',
  information: 'Invite people to your business or event!',
};

itemList['frappuccino'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Frappuccino',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_frappuccino.png',
  information: 'Its like I have ESPN or something',
};

itemList['frisbee'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Frisbee',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_frisbee.png',
  information: 'And she would throw it back to me',
};

itemList['ftartlet'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Fruit Tartlet',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_fruit-tartlet.png',
  information: 'Flavorsome',
};

itemList['ftoast'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'French Toast',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_french-toast.png',
  information: 'Delectable',
};

itemList['fuse'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Fuse',
  price: 30,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fuse.png',
};

itemList['gachet'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Portrait of Dr.Gachet',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_portrait-of-drgachet.png',
  information: 'Van Gogh 1890',
};

itemList['glowing'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Glowing Substance',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_glowing-substance.png',
  information: 'May cause unexpected mutations',
};

itemList['glucose'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '500g Glucose',
  price: 50,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_glucose.png',
  information: 'Mmmm Glucose.',
};

itemList['goldbar'] = {
  fullyDegrades: false,
  illegal: true,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Gold Bar',
  craft: [[{ itemid: 'rolexwatch', amount: 100 }]],
  price: 5000,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_gold-bar.png',
};

itemList['goldchip'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Gold Chip',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_gold-chip.png',
  information: 'All in',
};

itemList['goldcoin'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Gold Coin',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_gold-coin.png',
  information: 'Check inside for chocolate',
};

itemList['goldrec'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Gold Record',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_gold-record.png',
  information: '500, 000 units sold',
};

itemList['grandtete'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Grand Tete Mince',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_grand-tete-mince.png',
  information: 'Giacometti 1954',
};

itemList['greekbust'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Greek Bust',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_greek-bust.png',
  information: 'You sure its Greek?',
};

itemList['greenb'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Green Bandana',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_green-bandana.png',
  information: 'Ay yo my mans',
};

itemList['greenbelt'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Green Belt',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_green-belt.png',
  information: 'Adept Rank 2/4',
};

itemList['greenchip'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Green Chip',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_green-chip.png',
  information: 'Fold em',
};

itemList['Gruppe6Card'] = {
  fullyDegrades: true,
  illegal: true,
  craft: [[{ itemid: 'ciggy', amount: 30 }]],
  decayrate: 0.003,
  displayname: 'G6 C Card',
  price: 3500,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'gruppe6.png',
  information: 'Looks handy',
}; // black
itemList['Gruppe6Card2'] = {
  fullyDegrades: false,
  illegal: true,
  craft: [[
    { itemid: 'assphone', amount: 5 },
    { itemid: 'methlabproduct', amount: 35 },
    { itemid: 'ciggy', amount: 150 },
  ]],
  decayrate: 0.0,
  displayname: 'G6 HS Card',
  price: 3500,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'gruppe62.png',
  information: 'Looks handy',
};

itemList['Gruppe6Card22'] = {
  fullyDegrades: false,
  illegal: true,
  craft: [[
    { itemid: 'assphone', amount: 5 },
    { itemid: 'methlabproduct', amount: 55 },
    { itemid: 'ciggy', amount: 1000 },
  ]],
  decayrate: 0.0,
  displayname: 'G6 V Card',
  price: 3500,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'gruppe622.png',
  information: 'Looks handy',
};

itemList['Gruppe6Card222'] = {
  fullyDegrades: false,
  illegal: true,
  craft: [[
    { itemid: 'assphone', amount: 5 },
    { itemid: 'methlabproduct', amount: 55 },
    { itemid: 'ciggy', amount: 1000 },
  ]],
  decayrate: 0.0,
  displayname: 'G6 V2 Card',
  price: 3500,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'Gruppe6222.png',
  information: 'Looks handy',
};

itemList['Gruppe6Card3'] = {
  fullyDegrades: false,
  illegal: true,
  craft: [[
    { itemid: 'assphone', amount: 5 },
    { itemid: 'methlabproduct', amount: 15 },
    { itemid: 'ciggy', amount: 30 },
  ]],
  decayrate: 0.0,
  displayname: 'G6 P Card',
  price: 3500,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'gruppe63.png',
  information: 'Looks handy',
}; // purple

itemList['gsfpapers'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'GSF Papers',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_gsf-papers.png',
  information: 'Triple OG approved',
};

itemList['gticket'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Golden Ticket',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_golden-ticket.png',
  information: 'Ask Coop',
};

itemList['gum'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Gum',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_gum.png',
  information: 'Release Gum. You chew, you suck then POW',
};

itemList['hairtonic'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Hair Tonic',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_hair-tonic.png',
  information: 'If youre malding try this',
};

itemList['hairtie'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Hair Tie',
  price: 25,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_hairtie.png',
  information: 'We all know what this is really for...',
};

itemList['harness'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Racing Harness',
  craft: [[{ itemid: 'rubber', amount: 10 }]],
  price: 10000,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_harness.png',
  information: 'Stops you from being YEETED',
};

itemList['heavycutters'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Heavy Cutters',
  price: 700,
  weight: 9,
  nonStack: false,
  model: '',
  image: 'np_heavy-cutters.png',
};

itemList['heavydutydrill'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Heavy Duty Drill',
  craft: [[
    { itemid: 'aluminium', amount: 85 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 300,
  weight: 5,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_heavy-duty-drill.png',
};

itemList['hlights'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Headlights',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_headlights.png',
  information: 'Cant detail a car with the cover on',
};

itemList['holybook'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Holy Book',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_holy-book.png',
  information: 'For followers only...',
};

itemList['holyhum'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Holy Hummus',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_holy-hummus.png',
  information: 'Praise be',
};

itemList['homme'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "L'Homme Qui Marche",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lhomme-qui-marche.png',
  information: 'Giacometti 1960',
};

itemList['horchata'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Horchata',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_horchata.png',
  information: 'A la gran puchica!',
};

itemList['icbelt'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Intercontinental Belt',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_intercontinental-belt.png',
  information: 'Bah gawd!',
};

itemList['idcard'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Citizen Card',
  price: 500,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_citizen-card.png',
};

itemList['IFAK'] = {
  fullyDegrades: false,
  decayrate: 0.1,
  displayname: 'IFAK',
  price: 8,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'ifak.png',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
};

itemList['inkedmoneybag'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Inked Money Bag',
  price: 100000,
  weight: 10,
  nonStack: false,
  heist_loot: true,
  model: '',
  image: 'np_inked-money-bag.png',
  information: 'Made with cheap ink that expires',
};

itemList['inkset'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Inked Set',
  price: 500,
  weight: 15,
  nonStack: false,
  model: '',
  image: 'np_inked-money-bag.png',
};

itemList['ironoxide'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Iron Oxide',
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_iron-oxide.png',
};

itemList['jadeite'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Jadeite Stone',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_jadeite-stone.png',
  information: 'With envy',
};

itemList['joker'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Joker Card',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_joker.png',
  information: 'How bout a magic trick?',
};

itemList['katana'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Katana',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_katana.png',
  information: 'Steel folded over 1000 times',
};

itemList['keyfob'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Key Fob',
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_keyfob.png',
  information: 'Used for opening doors remotely.',
};

itemList['key1'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Key 1',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_key1.png',
  information: 'Numbered Key',
};

itemList['key2'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Key 2',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_key2.png',
  information: 'Numbered Key',
};

itemList['key3'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Key 3',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_key3.png',
  information: 'Numbered Key',
};

itemList['keya'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Key A',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_keya.png',
  information: 'Lettered Key',
};

itemList['keyb'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Key B',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_keyb.png',
  information: 'Lettered Key',
};

itemList['keyc'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Key C',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_keyc.png',
  information: 'Lettered Key',
};

itemList['latte'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Latte',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_latte.png',
  information: 'Thats so fetch',
};

itemList['lbpapers'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'LB Papers',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lb-papers.png',
  information: 'I plead guilty mon',
};

itemList['lighter'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lighter',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lighter.png',
  information: 'Dont start a fire with this. ',
};

itemList['lockpick'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Lockpick Set',
  craft: [
    [
      { itemid: 'aluminium', amount: 5 },
      { itemid: 'plastic', amount: 3 },
      { itemid: 'rubber', amount: 3 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 2 },
    ]
  ],
  price: 250,
  weight: 1,
  nonStack: false,
  model: '',
  information: 'Unlocks things, if you have the skill!',
  image: 'np_lockpick-set.png',
};

itemList['locksystem'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Air Pressure Lockpick',
  price: 3500,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'locksystem.png',
  information: 'Used to blow out small locks - one time use.',
};

itemList['log'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Log',
  price: 10,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_wood.png',
};

itemList['logger'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Logger Beer',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_logger-beer.png',
  information: 'Ming Ha Ling Bev. 2013',
};

itemList['lostcut'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter',
};

itemList['lostcut_aw'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Al Weaselton',
};

itemList['lostcut_cc'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Cooch Cassidy',
};

itemList['lostcut_cs'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Catherine Scratch',
};

itemList['lostcut_ga'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Gary Adams',
};

itemList['lostcut_gm'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Gazza Maloo',
};

itemList['lostcut_gs'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Greyson Sparks',
};

itemList['lostcut_jp'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Jason Paul',
};

itemList['lostcut_ng'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Negan Graham',
};

itemList['lostcut_rc'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Reginald Campbell',
};

itemList['lostcut_rd'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Reid Dankleaf',
};

itemList['lostcut_rr'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Rudi Rinsen',
};

itemList['lostcut_so'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: "Sandy Shores Chapter<br />Property of Samuel O'Faolain",
};

itemList['lostcut_vm'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Victor Mason',
};

itemList['lostcut_wd'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Wyatt Derp',
};

itemList['lostcut_gt'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of George Temple',
};

itemList['lostcut_ww'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Wade Willson',
};

itemList['lostcut_hm'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Holden Maloo',
};

itemList['lostcut_tr'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Taran Raid',
};

itemList['lostcut_dw'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />In honor of Denzel Washington',
};

itemList['lostcut_cd'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Cut',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-cut.png',
  information: 'Sandy Shores Chapter<br />Property of Cherry Divine',
};

itemList['lostpapers'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lost MC Papers',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_lost-papers.png',
  information: 'Does not work with meth',
};

itemList['lotion'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Hand Lotion',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_hand-lotion.png',
  information: 'My hands are dry I swear',
};

itemList['lspapers'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'LS Papers',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_ls-papers.png',
  information: 'The city with the safest banks',
};

itemList['madamelr'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Madame LR',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_madame-lr.png',
  information: 'Brancusi 1918',
};

itemList['maneki'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Maneki Neko',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_maneki-neko.png',
  information: 'Good fortune beckons',
};

itemList['markedbills'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Marked Bills',
  price: 300,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_inked-money-bag.png',
};

itemList['martini'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Martini',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_martini.png',
  information: 'Shaken, not stirred',
};

itemList['mdiptych'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Marilyn Diptych',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_marilyn-diptych.png',
  information: 'Warhol 1962',
};


itemList['adrenaline'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'Adrenaline Syringe',
  price: 50,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_adrenaline.png',
  information: 'Adrenaline, gives a good pump! If you are not SWAT certified do not buy this.',
};

itemList['MedicalBag'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Medical Bag',
  price: 350,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_medbag.png',
  information: 'Its a prop, wow?',
};

itemList['mfalcon'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Maltese Falcon',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_maltese-falcon.png',
  information: 'Highly prized movie prop',
};

itemList['misfit'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Headphones',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_headphones.png',
  information: 'We out here cuh',
};

itemList['mixtape'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Mixtape',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_mixtape.png',
  information: 'Check it, yo',
};

itemList['mk2usbdevice'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'MKII USB Device',
  price: 300,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_mkii-usb-device.png',
};

itemList['mobilephone'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Mobile Phone',
  price: 100,
  craft: [
    [
      { itemid: 'electronics', amount: 10 },
    ]
  ],
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_mobile-phone.png',
};

itemList['burnerphone'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Burner Phone',
  price: 5,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_mobile-phone.png',
};

itemList['monalisa'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Mona Lisa',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_mona-lisa.png',
  information: 'Da Vinci 1517',
};

itemList['moonshine'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Moonshine Jug',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_moonshine-jug.png',
  information: 'Using the same jugs since 1910. Charisma incoming!',
};

itemList['moonshinej'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Moonshine Jar',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_jar-of-moonshine.png',
  information: 'Almost paint thinner',
};

itemList['mtrophy'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Mic Trophy',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_mic-trophy.png',
  information: 'A star is born',
};

itemList['muffin'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Muffin',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_muffin.png',
  information: 'Is your muffin buttered?',
};

itemList['mugbeer'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Mug of Beer',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_mug-of-beer.png',
  information: 'Cheers!',
};

itemList['mvial'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Mysterious Vial',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_mysterious-vial.png',
  information: 'Do not drink',
};

itemList['nachos'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Nachos',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_nachos.png',
  information: 'Delicioso',
};

itemList['negg'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Napoleonic Egg',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_napoleonic-egg.png',
  information: 'Faberge Series (2/3)',
};

itemList['nitrous'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Nitrous Oxide',
  craft: [
    [
      { itemid: 'aluminium', amount: 600 },
      { itemid: 'plastic', amount: 25 }
    ]
  ],
  price: 300,
  weight: 35,
  nonStack: false,
  model: '',
  image: 'np_nitrous-oxide.png',
};

itemList['copium'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Copium',
  craft: [[{ itemid: 'electronics', amount: 10 }]],
  price: 300,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_copium.png',
};

itemList['nmenu'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Nanakaze Menu',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_nanakaze-menu.png',
  information: 'Take a look feller',
};

itemList['no10'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'No. 10',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_no10.png',
  information: 'Rothko 1950',
};

itemList['no5'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'No. 5',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_no5.png',
  information: 'Pollock 1948',
};

itemList['oil'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Oil',
  price: 10,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_oil.png',
};

itemList['okaylockpick'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Not-Shit Ass Lockpick',
  price: 0,
  craft: [[{ itemid: 'shitlockpick', amount: 100 }]],
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_shitlockpick.png',
  information: 'TBH its still shit, so shit its almost identical... almost.',
}; //'Heavy Shotgun'


itemList['homemadekey'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Small Key',
  price: 0,
  craft: [
    [
      { itemid: 'shitlockpick', amount: 5 },
      { itemid: 'aluminium', amount: 105 },
      { itemid: 'plastic', amount: 105 },
      { itemid: 'rubber', amount: 40 },
    ],
    [
      { itemid: 'oil', amount: 5 },
      { itemid: 'aluminium', amount: 105 },
      { itemid: 'plastic', amount: 105 },
      { itemid: 'rubber', amount: 40 },
    ]
  ],
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_homemadelockpick.png',
  information: 'Looks worthless, or is it?',
}; //'Heavy Shotgun'


itemList['onigiri'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Onigiri',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_onigiri.png',
  information: 'Delicious rice balls',
};

itemList['onion'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Onion',
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_onion.png',
  information: 'Are your eyes watering?',
  foodCategory: ['vegetables'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
  produce: true,
};

itemList['oxygentank'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Oxygen Tank',
  craft: [[
    { itemid: 'aluminium', amount: 105 },
    { itemid: 'plastic', amount: 105 },
    { itemid: 'rubber', amount: 40 },
  ]],
  price: 2500,
  weight: 100,
  nonStack: false,
  model: '',
  image: 'np_oxygen-tank.png',
};

itemList['oxygentanknavy'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Oxygen Tank',
  craft: [[
    { itemid: 'aluminium', amount: 105 },
    { itemid: 'plastic', amount: 105 },
    { itemid: 'rubber', amount: 40 },
  ]],
  price: 2500,
  weight: 100,
  nonStack: false,
  model: '',
  image: 'np_oxygen-tank.png',
};

itemList['pallet'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pallet of Boxes',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_pallet-of-boxes.png',
  information: 'Transportable goods',
};

itemList['passtest'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Passed Test',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_passed-test.png',
  information: 'Excellent work',
};

itemList['paynepic'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Portrait of Payne',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_payne-portrait.png',
  information: 'Cue tongue pop',
};

itemList['pearlneck'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pearl Necklace',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_dragon',
  information: 'Good way to finish a date',
};

itemList['pegg'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pink Faberge Egg',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_pink-faberge-egg.png',
  information: 'Faberge Series (3/3)',
};

itemList['petchicken'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pet Chicken',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_pet-chicken.png',
  information: 'Careful around Cluckin Bell',
};

itemList['petfish'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pet Fish',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_pet-fish.png',
  information: 'Gold fish memory',
};

itemList['petrock'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pet Rock',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_pet-rock.png',
  information: 'You dont even have to feed it',
};

itemList['petturtle'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pet Turtle',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_pet-turtle.png',
  information: 'Cowabunga',
};

itemList['pix1'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Pixerium Stick Small',
  price: 300,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_decrypter-fv2.png',
};

itemList['pix2'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Pixerium Stick Large',
  price: 1000,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_decrypter-enzo.png',
};

itemList['platinumrec'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Platinum Record',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_platinum-record.png',
  information: '1 Million units sold!',
};

itemList['popsicle'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Popsicle',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_popsicle.png',
  information: 'Is that sea salt?',
};

itemList['portal'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Portal',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_portal.png',
  information: 'Paden 2012',
};

itemList['ppapers'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Prison Papers',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_prison-papers.png',
  information: 'Dont ask where its been...',
};

itemList['pupusas'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pupusas',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_pupusas.png',
  information: 'Mas curtido vos',
};

itemList['purpleb'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Purple Bandana',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_purple-bandana.png',
  information: 'Straight outta da cul-de-sac',
};

itemList['qhearts'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Queen of Hearts',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_queen-of-hearts.png',
  information: 'Off with their heads!',
};

itemList['qualityscales'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'High Quality Scales',
  craft: [[
    { itemid: 'aluminium', amount: 25 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 1000,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_high-quality-scales.png',
  information: 'Weighs Baggies with no loss',
};
itemList["shortradio"] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "CB Radio",
  craft: [[
    { itemid: "electronics", amount: 500 },
  ]],
  price: 3000,
  weight: 5,
  nonStack: true,
  model: "",
  image: "np_radio.png",
  information: "Non-encrypted - Used to chat with other people close by.",
};

itemList["civradio"] = {
  fullyDegrades: true,
  deg: true,
  decayrate: 0.25,
  displayname: "Standard Radio",
  craft: [[
    { itemid: "electronics", amount: 50 },
  ]],
  price: 3000,
  weight: 5,
  nonStack: true,
  model: "",
  image: "np_radio.png",
  information: "Non-encrypted - Used to chat with other people on private radio channels. Will be seized in crime.",
};

itemList['radio'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'PD Radio',
  craft: [[
    { itemid: 'electronics', amount: 30 },
    { itemid: 'plastic', amount: 5 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 50,
  weight: 5,
  nonStack: true,
  blockScrap: true,
  model: '',
  image: 'np_radio.png',
  information: 'Encrypted - Used to chat with other people on PD radio channels.',
};

itemList['rbumper'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Rear Bumper',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_rear-bumper.png',
  information: 'You owe me a ten second car',
};

itemList['recoupon10'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '10% Off Deal',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_recoupon10.png',
  information: 'May not be used for drugs',
};

itemList['recoupon15'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '15% Off Deal',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_recoupon15.png',
  information: 'We are not liable for any raids or robberies',
};

itemList['recoupon20'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '20% Off Deal',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_recoupon20.png',
  information: 'May or may not be exchanged for a hug from Mr. Payne',
};

itemList['recoupon5'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '5% Off Deal',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_recoupon5.png',
  information: 'Southside shootings are complimentary',
};

itemList['recyclablematerial'] = {
  fullyDegrades: true,
  decayrate: 0.03,
  displayname: 'Recyclable Material',
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_recyclable-material.png',
};

itemList['redb'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Red Bandana',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_red-bandana.png',
  information: 'Lean with me',
};

itemList['redbelt'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Red Belt',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_red-belt.png',
  information: 'Expert Rank 3/4',
};

itemList['redchip'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Red Chip',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_red-chip.png',
  information: 'Calling your bluff',
};

itemList['redpack'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Redwood Pack',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_redwood-pack.png',
  information: 'I can stop anytime',
};

itemList['refinedwood'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Refined Wood',
  price: 15,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_wood.png',
};

itemList['repairtoolkit'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Repair Toolkit',
  craft: [[
    { itemid: 'aluminium', amount: 5 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 50,
  weight: 20,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_repair-toolkit.png',
  information: 'Used by Tow Truck drivers and repair people.',
};

itemList['riflebody'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Rifle Body',
  price: 70,
  weight: 10,
  nonStack: false,
  model: '',
  image: 'np_rifle-body.png',
};

itemList['riflebodybox'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Box (10+ Rifle Bodys)',
  price: 200,
  weight: 85,
  nonStack: false,
  model: '',
  image: 'np_rifle-box.png',
};

itemList['rims'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Racing Rims',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_racing-rims.png',
  information: 'Best rims for the job',
};

itemList['rnovel'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Romance Novel',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_romance-novel.png',
  information: 'A hurricane of passion',
};

itemList['benjiwatch'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  isStolen: false,
  displayname: 'Benjis Watch',
  price: 50,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_benjiwatch.png',
  information: 'It has an inscription on the back - Forever Yours',
};

itemList['rolexwatch'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  isStolen: true,
  displayname: 'Rolex Watch (p)',
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_rolex-watch.png',
};

itemList['rollingpaper'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Rolling Paper',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_rolling-paper.png',
  information: 'Required to roll joints!',
};

itemList['rooster'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Rooster Pin',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_rooster-pin.png',
  information: 'With egg in hand...',
};

itemList['rose'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Rose',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_rose.png',
  information: 'Cue dramatic monologue',
};

itemList['rpelt'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Rabbit Pelt',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_rabbit-pelt.png',
  information: 'Magdumping ruins the pelt',
};

itemList['rtrophy'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Racing Trophy',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_racing-trophy.png',
  information: 'All I do is win',
};

itemList['ruby'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Ruby',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_ruby.png',
  information: 'Like a sunrise',
};

itemList['russian'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Matryoshka Doll',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_matryoshka-doll.png',
  information: 'If he dies, he dies, cyka.',
};

itemList['sake'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Sake',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_sake.png',
  information: 'Kampai!',
};

itemList['salvator'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Salvator Mundi',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_salvator-mundi.png',
  information: 'Da Vinci 1500',
};

itemList['sbsxray'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'SBS X-Ray',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_sbs-xray.png',
  information: 'Warlord size',
};

itemList['scanner'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Radio Scanner',
  craft: [[
    { itemid: 'aluminium', amount: 5 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 500,
  weight: 15,
  nonStack: false,
  model: '',
  image: 'np_radio-scanner.png',
  information: 'Used to receive random radio chatter.',
};

itemList['scissors'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Scissors',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_scissors.png',
  information: 'Fuck me up fam',
};

itemList['scoin'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Gold Coin',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_secret-coin.png',
  information: 'Ens causa sui',
};

itemList['scream'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'The Scream',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_the-scream.png',
  information: 'Munch 1893',
};

itemList['screen'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Screen',
  price: 120,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_screen.png',
};

itemList['scripted'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Script',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_script.png',
  information: 'Scripted? Reee',
};

itemList['sealedbucket'] = {
  fullyDegrades: false,
  price: 5,
  decayrate: 0.0,
  displayname: 'Fisher Bucket',
  weight: 99,
  nonStack: true,
  model: '',
  image: 'np_sealed-bucket.png',
  whitelist: [
    "fishes"
  ],
};

itemList['sealedevidencebag'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Sealed Evidence Bag',
  price: 0,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_sealed-evidence-bag.png',
};

itemList['seat'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Seat',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_seat.png',
  information: 'Only for the most hardcore of racers',
};

itemList['secretfile'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Secret File',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_secret-file.png',
  information: 'High level clearance required',
};

itemList['securityblack'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Security Card',
  price: 1500,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'cblk.png',
  information: 'Some sort of security card..',
};

itemList['securityblue'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Security Card',
  price: 1500,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'cb.png',
  information: 'Some sort of security card..',
};

itemList['SecurityCase'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Security Case',
  price: 350,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_securitycase.png',
  information: 'Its a prop, wow?',
};

itemList['securitygold'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Security Card',
  price: 1500,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'cgld.png',
  information: 'Some sort of security card..',
};

itemList['securitygreen'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Security Card',
  price: 1500,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'cg.png',
  information: 'Some sort of security card..',
};

itemList['securityred'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Security Card',
  price: 1500,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'cr.png',
  information: 'Some sort of security card..',
};

itemList['sfinger'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Severed Finger',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_severed-finger.png',
  information: "Now we're even",
};

itemList['sgrace'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Saying Grace',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_saying-grace.png',
  information: 'Rockwell 1951',
};

itemList['shampoo'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Shampoo',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_shampoo.png',
  information: 'Full of body and volume',
};

itemList['shearsoj'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Shears of Justice',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_shears-of-justice.png',
  information: 'Justice prevails',
};

itemList['shipbox'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Shipping Box',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_shipping-box.png',
  information: 'Free 2day shipping',
};

itemList['shipcrate'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Shipping Crate',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_shipping-crate.png',
  information: 'This side up',
};

itemList['shitlockpick'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Ass Lockpick',
  price: 0,
  craft: [[{ itemid: 'jailfood', amount: 1 }]],
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_shitlockpick.png',
  information:
    'Why the fuck is this so heavy? CoPixel das why.',
}; //'Heavy Shotgun'
itemList['silvercoin'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Silver Coin',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_silver-coin.png',
  information: 'Dont lose it',
};

itemList['slushy'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'The best slushy ever.',
  price: 0,
  weight: 15,
  nonStack: false,
  model: '',
  image: 'np_slushy.png',
  information:
    'The only thing in Jail that tastes good.',
};

itemList['smallscales'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Small Scales',
  craft: [[
    { itemid: 'aluminium', amount: 25 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_small-scale.png',
  information: 'Weighs Baggies with minimal loss',
};

itemList['smirror'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Side Mirror',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_side-mirror.png',
  information: "On green, I'm going for it",
};

itemList['snakeskin'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Snakeskin',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_snakeskin.png',
  information: 'Sssss',
};

itemList['snowpic'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Photo of Snow',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_snow-photo.png',
  information: 'My beloved Jacqueline Snow',
};

itemList['snowvhs'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'The Ultimate Boomer',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_snow-vhs.png',
  information:
    'Filmed On the Samsung flip phone from 2003 this high quality boomer production value will have you questioning.... Is that a dick?',
};

itemList['sound'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Sound System',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_sound-system.png',
  information: 'Makes your ears bleed',
};

itemList['sozepic'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Photo of Soze',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_soze-photo.png',
  information: "The State PO-lice's finest",
};

itemList['spoiler'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Spoiler',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_spoiler.png',
  information: 'Quarter mile at a time',
};

itemList['sprunk'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Sprunk',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_sprunk.png',
  information: 'The Essence of Life',
};

itemList['sskirts'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Side Skirts',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_side-skirts.png',
  information: 'Ride or die, remember?',
};

itemList['starrynight'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Starry Night',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_starry-night.png',
  information: 'Neither ear nor there',
};

itemList['stolen10ctchain'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: '10ct Gold Chain (p)',
  price: 2230,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_10ct-gold-chain.png',
};

itemList['stolen2ctchain'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: '2ct Gold Chain (p)',
  price: 15,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_2ct-gold-chain.png',
};

itemList['stolen5ctchain'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: '5ct Gold Chain (p)',
  price: 95,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_5ct-gold-chain.png',
};

itemList['stolen8ctchain'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: '8ct Gold Chain (p)',
  price: 375,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_8ct-gold-chain.png',
};

itemList['stolencasiowatch'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Casio Watch (p)',
  craft: [[
    { itemid: 'genericelectronicpart', amount: 2 }
  ]],
  price: 65,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_casio-watch.png',
};

itemList['stolengameboy'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Gameboy (p)',
  craft: [[
    { itemid: 'genericelectronicpart', amount: 4 }
  ]],
  price: 125,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_gameboy.png',
};

itemList['stoleniphone'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 1.0,
  displayname: 'Apple Iphone (p)',
  craft: [[
    { itemid: 'genericelectronicpart', amount: 4 },
  ]],
  price: 75,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_apple-iphone.png',
};

itemList['stolennokia'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 1.0,
  displayname: 'Nokia Phone (p)',
  craft: [[
    { itemid: 'genericelectronicpart', amount: 2 },
  ]],
  price: 65,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_nokia-phone.png',
};

itemList['stolenoakleys'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Oakley Sunglasses (p)',
  price: 250,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_oakley-sunglasses.png',
};

itemList['stolenpixel3'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 1.0,
  displayname: 'Pixel 3 Phone (p)',
  craft: [[
    { itemid: 'genericelectronicpart', amount: 2 },
  ]],
  price: 65,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_pixel-2-phone.png',
};

itemList['stolenpsp'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'PSP (p)',
  craft: [[
    { itemid: 'genericelectronicpart', amount: 2 },
  ]],
  price: 65,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_psp.png',
};

itemList['stolenraybans'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Ray Ban Sunglasses (p)',
  price: 190,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_raybans.png',
};

itemList['stolens8'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 1.0,
  displayname: 'Samsung S8 (p)',
  craft: [[
    { itemid: 'genericelectronicpart', amount: 7 },
  ]],
  price: 250,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_samsung-s8.png',
};

itemList['stooth'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Shark Tooth',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_shark-tooth.png',
  information: 'Gonna need a bigger boat',
};

itemList['Suitcase'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Suitcase',
  price: 350,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_suitcase.png',
  information: 'Its a prop, wow?',
};

itemList['sunflower'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Sunflower',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_sunflower.png',
  information: 'Super effective vs zombies',
};

itemList['swheel'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Steering Wheel',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_steering-wheel.png',
  information: 'Winning is winning...',
};

itemList['tagbelt'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Tag Team Belt',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_tag-team-belt.png',
  information: 'Off the turbuckle',
};

itemList['tbag'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Transport Bag',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_transport-bag.png',
  information: 'Keeping your organs fresh',
};

itemList['tbear'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Teddy Bear',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_teddy-bear.png',
  information: 'Hug me',
};

itemList['tealb'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Teal Bandana',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_teal-bandana.png',
  information: 'Simon ese',
};

itemList['telvis'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Triple Elvis',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_triple-elvis.png',
  information: 'Warhol 1963',
};

itemList['textbooka'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Textbook A',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_textbook-a.png',
  information: 'Buy new of course',
};

itemList['thermite'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Thermite',
  craft: [[
    { itemid: 'aluminium', amount: 10 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 10 },
  ]],
  price: 0,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_thermite.png',
};

itemList['ticket'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Ticket',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_ticket.png',
  information: 'Admit one',
};

itemList['tissuebox'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Box of Tissues',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_tissue-box.png',
  information: 'Not what it seems I swear',
};

itemList['Toolbox'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Toolbox',
  price: 350,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_toolbox.png',
  information: 'Its a prop, wow?',
};

itemList['toothneck'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Tooth Necklace',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_tooth-necklace.png',
  information: 'Shes a beauty',
};

itemList['trophy'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Trophy',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_trophy.png',
  information: 'Winner!',
};

itemList['boomerphone'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Boomer Phone',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_boomerphone.png',
  information: 'Made for boomers, extra large buttons and screen.',
};

itemList['umbrella'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Umbrella',
  price: 500,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_umbrella.png',
};

itemList['umetal'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Unknown Metal',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_unknown-metal.png',
  information: 'Dont lick your fingers',
};

// itemList['usbdevice'] = {
//   fullyDegrades: false,
//   decayrate: 0.0,
//   displayname: 'Unknown USB Device',
//   price: 300,
//   weight: 5,
//   nonStack: false,
//   model: '',
//   image: 'np_unknown-usb-device.png',
// };

itemList['valuablegoods'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Valuable Goods',
  craft: [[{ itemid: 'goldbar', amount: 7 }]],
  price: 4000,
  weight: 4,
  nonStack: false,
  model: '',
  image: 'np_valuable-goods.png',
};

itemList['viagra'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Viagra',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_viagra.png',
  information: 'Magic little blue pill',
};

itemList['voodoo'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Voodoo Doll',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_voodoo-doll.png',
  information: 'Beware the spirits',
};

itemList['vpapers'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Vagos Papers',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_vagos-papers.png',
  information: 'No prrrraaaaaablem',
};

itemList['vpnxj'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'VPN',
  price: 300,

  craft: [
    [
      { itemid: 'refinedaluminium', amount: 11 },
      { itemid: 'refinedcopper', amount: 11 },
      { itemid: 'refinedplastic', amount: 11 },
    ]
  ],

  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_vpn-xj.png',
};

itemList['vpnxja'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Advanced VPN',
  price: 300,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_vpn-xj.png',
};

itemList['vulture'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Vulture Statue',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_vulture-statue.png',
  information: 'For the culture',
};

itemList['wallet'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Wallet',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_wallet.png',
  information: 'Includes picture of mom',
};

itemList['watch'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: "PD Watch & Compass",
  price: 50,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_watch.png',
  information: "Government (PD/EMS/DOC) Issued Equipment",
};

itemList['wedding'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Wedding Ring',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_wedding-ring.png',
  information: 'Did you know fifty percent...',
};

itemList['weeping'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Weeping Woman',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_weeping-woman.png',
  information: 'Picasso 1937',
};

itemList['wglass'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Glass of Whiskey',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_glass-of-whiskey.png',
  information: 'On the rocks',
};

itemList['whitebelt'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'White Belt',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_white-belt.png',
  information: 'Novice Rank 1/4',
};

itemList['whitechip'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'White Chip',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_white-chip.png',
  information: 'Hit me',
};

itemList['whitepearl'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'White Pearl',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_white-pearl.png',
};

itemList['whitewine'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'White Wine',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_white-wine-bottle.png',
  information: 'Made from real crime free grapes',
};

itemList['wineglass'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Glass of Wine',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_glass-wine.png',
  information: 'Quite exquisite',
};

itemList['mugoftea'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Mug of Tea',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_mugoftea.png',
  information: 'Mmmmmm...',
};

itemList['wlilies'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Water Lilies',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_water-lilies.png',
  information: 'Monet 1907',
};

itemList['xscondom'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'XSmall Condom',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_xs-condom.png',
  information: 'Its the motion in the ocean',
};

itemList['ydiamond'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Yellow Diamond',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_yellow-diamond.png',
  information: 'Forever',
};

itemList['yellowb'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Yellow Bandana',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_yellow-bandana.png',
  information: 'Im tellin you',
};

itemList['zebra'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Zebra',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_zebra.png',
  information: 'Vasarely 1937',
};

itemList['fakesnowvhs'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Bootleg Boomer',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_fake-snow-vhs.png',
  information: 'At this point you can not even tell if it is a dick or the roundhay garden scene from 1888.',
};

itemList['wigglue'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Wig glue',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_wig-glue.png',
  information: 'Recommended by Snow.',
};

itemList['babyoil'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Baby Oil',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_baby_oil.png',
  information: 'Pure baby mineral oil forms a silky moisturizing barrier to help prevent excess moisture loss and lock in up to 10 times more moisture on wet skin than an ordinary lotion can on dry skin. Also makes your dome shiny AF.',
};

itemList['marstonrevolver'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: "John Marston's Cattleman Revolver",
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_marston-revolver.png',
  information: 'Owned by John Marston, this Cattleman Revolver features a black steel frame inlaid with gold and a custom bone grip.',
};

itemList['cloak'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cloak',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cloak.png',
  information: 'Only to be used for some cloak and dagger shit by NoPixel management.',
};

itemList['stolentv'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Flat Panel TV (p)',
  craft: [[
    //{ itemid: 'aluminium', amount: 1 },
    //{ itemid: 'steel', amount: 1 },
    //{ itemid: 'copper', amount: 1 },
    //{ itemid: 'scrapmetal', amount: 1 },
    //{ itemid: 'rubber', amount: 1 },
    //{ itemid: 'plastic', amount: 5 },
    { itemid: 'genericelectronicpart', amount: 18 },
  ]],
  price: 710,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_stolentv.png',
};

itemList['stolenmusic'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Music Equipment (p)',
  craft: [[
    //{ itemid: 'aluminium', amount: 1 },
    //{ itemid: 'steel', amount: 1 },
    //{ itemid: 'copper', amount: 1 },
    //{ itemid: 'scrapmetal', amount: 1 },
    //{ itemid: 'rubber', amount: 1 },
    { itemid: 'genericelectronicpart', amount: 9 },
    //{ itemid: 'glass', amount: 1 },
    { itemid: 'stolenBrokenGoods', amount: 1 },
  ]],
  price: 210,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_stolenmusic.png',
};

itemList['stolencoffee'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Coffe Machine (p)',
  price: 350,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_stolencoffee.png',
};

itemList['stolenmicrowave'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Microwave (p)',
  price: 440,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_stolenmicrowave.png',
};

itemList['stolencomputer'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Computer Equipment (p)',
  craft: [[
    //{ itemid: 'aluminium', amount: 1 },
    //{ itemid: 'steel', amount: 1 },
    //{ itemid: 'copper', amount: 1 },
    //{ itemid: 'scrapmetal', amount: 1 },
    //{ itemid: 'rubber', amount: 1 },
    { itemid: 'genericelectronicpart', amount: 12 },
    //{ itemid: 'glass', amount: 1 },
    { itemid: 'stolenBrokenGoods', amount: 1 },
  ]],
  price: 475,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_stolencomputer.png',
};

itemList['stolenart'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Art (p)',
  price: 2015,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_stolenart.png',
};

itemList['stolenBrokenGoods'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Broken Goods (p)',
  price: 25,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_stolenBrokenGoods.png',
};

// Event items
itemList['Bankbox'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Bank Box',
  price: 1,
  weight: 10,
  nonStack: false,
  model: '',
  image: 'np_bankbox.png',
  information: 'A locked bank box.',
};

itemList['Bankboxkey'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Briefcase Key',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_bankboxkey.png',
  information: 'A key that seems to fit somewhere.',
};

itemList['Heirloom'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Family Heirloom',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_heirloom.png',
  information: 'Ring with a weird emblem carved in to it.',
};

itemList['Hobonickel1'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Hobonickel',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_hobonickel1.png',
  information: 'A fancy looking coin. Maybe you should keep this on your person.',
};

itemList['Hobonickel2'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Hobonickel',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_hobonickel2.png',
  information: 'A fancy looking coin. Maybe you should keep this on your person.',
};

itemList['Hobonickel3'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Hobonickel',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_hobonickel3.png',
  information: 'A fancy looking coin. Maybe you should keep this on your person.',
};

itemList['Routemap'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Route Map',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_routemap.png',
  information: 'A map that is showing you the way.',
};

itemList['Securebriefcase'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Secure Briefcase',
  price: 1,
  weight: 10,
  nonStack: false,
  model: '',
  image: 'np_securebriefcase.png',
  information: 'A Briefcase that only a handful of people can open.',
};

itemList['Securitykey'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Security Key',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_securitykey.png',
  information: 'And interesting looking key. Does not seem to fit in a lock.',
};

itemList['Largesupplycrate'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Large Supply crate',
  price: 1,
  weight: 150,
  nonStack: true,
  model: '',
  image: 'np_supplycrate_large.png',
  information: 'A very big and heavy crate.',
};

itemList['Mediumsupplycrate'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Medium Supply crate',
  price: 1,
  weight: 100,
  nonStack: true,
  model: '',
  image: 'np_supplycrate_medium.png',
  information: 'A semi-heavy crate containing something.',
};

itemList['Smallsupplycrate'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Small Arms Crate',
  price: 1,
  craft: [
    [
      { itemid: 'aluminium', amount: 200 },
      { itemid: 'steel', amount: 400 },
      { itemid: 'rubber', amount: 200 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 60 },
      { itemid: 'refinedsteel', amount: 120 },
      { itemid: 'refinedrubber', amount: 60 },
    ]
  ],
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_smallarmscrate.png',
  information: "A small unmarked crate.",
};

itemList['Smallsupplycrate2'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Small Supply Crate',
  price: 1,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_supplycrate_small.png',
  information: "A small crate containing something.",
};

itemList['foodsupplycrate'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Food Supply crate',
  price: 1,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_supplycrate_medium.png',
  information: 'Special delivery for Siz Fulker!',
};

//Human parts
itemList['bodybag'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Body bag',
  price: 1,
  weight: 100,
  nonStack: true,
  model: '',
  image: 'np_bodybag.png',
  information: 'A heavy body bag. I wonder what is inside?',
};

itemList['bodygarbagebag'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Garbage bag',
  price: 1,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_bodygarbagebag.png',
  information: 'A heavy bloodied trash bag. I wonder what is inside?',
};

itemList['organcooler'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Organ Cooler',
  price: 1,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_organcooler.png',
  information: 'Organ cooler? I wonder what it contains!',
};

itemList['organcooleropen'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Open Organ Cooler',
  price: 1,
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_organcooler.png',
  information: 'An empty organ cooler. Where is the content?',
};

itemList['humanbody'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Human Corpse',
  price: 1,
  weight: 100,
  nonStack: true,
  model: '',
  image: 'np_humanbody.png',
  information: 'A human corpse. How long has this been here?',
};

itemList['humanhead'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Severed Head',
  price: 1,
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_humanhead.png',
  information: 'A bloody severed head.',
};

itemList['humantorso'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Severed Torso',
  price: 1,
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_humantorso.png',
  information: 'A bloody severed torso.',
};

itemList['humanarm'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Severed Arm',
  price: 1,
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_humanarm.png',
  information: 'A bloody severed arm.',
};

itemList['humanhand'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Severed Hand',
  price: 1,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_humanhand.png',
  information: 'A bloody severed hand.',
};

itemList['humanleg'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Severed Leg',
  price: 1,
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_humanleg.png',
  information: 'A bloody severed leg.',
};

itemList['humanfinger'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Severed finger',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_humanfinger.png',
  information: 'A bloody severed finger. Where is the rest?',
};

itemList['humanear'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Severed Ear',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_humanear.png',
  information: 'A bloody severed ear.',
};

itemList['humanskull'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Human Skull',
  price: 1,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_humanskull.png',
  information: 'A human skull.',
};

itemList['humanbones'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Human Bones',
  price: 1,
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_humanbones.png',
  information: 'A collection of human bones.',
};

itemList['humanbone'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Human Bone',
  price: 1,
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_humanbone.png',
  information: 'A bone that looks to be from a human.',
};

itemList['humanheart'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Human Heart',
  price: 1,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_humanheart.png',
  information: 'A bloody heart.',
};

itemList['humaneye'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Human Eyeball',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_humaneye.png',
  information: 'A severed torn out eyeball.',
};

itemList['humanbrain'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Human Brain',
  price: 1,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_humanbrain.png',
  information: 'A bloody brain.',
};

itemList['humanintestines'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Human Intestines',
  price: 1,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_humanintestines.png',
  information: 'A bunch of intestines.',
};

itemList['humankidney'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Human Kidney',
  price: 1,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_humankidney.png',
  information: 'A bloody kidney.',
};

itemList['humanliver'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Human Liver',
  price: 1,
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_humanliver.png',
  information: 'A bloody liver.',
};

itemList['humanlungs'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Human Lungs',
  price: 1,
  weight: 4,
  nonStack: true,
  model: '',
  image: 'np_humanlungs.png',
  information: 'A bloody pair of lungs.',
};

itemList['humannail'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Human Nail',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_humannail.png',
  information: 'A single torn out nail.',
};

itemList['humanpancreas'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Human Pancreas',
  price: 1,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_humanpancreas.png',
  information: 'A bloody pancreas.',
};

itemList['humantongue'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Human Tongue',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_humantongue.png',
  information: 'A tongue without its human.',
};

itemList['humantooth'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Human Tooth',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_humantooth.png',
  information: 'A single tooth with root and all.',
};

// Coop request - gallery stoof
itemList['gallery1star'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '1 Star Contract',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_1star.png',
  information: '1 Star Contract',
};

itemList['gallery2star'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '2 Star Contract',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_2star.png',
  information: '2 Star Contract',
};

itemList['gallery3star'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '3 Star Contract',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_3star.png',
  information: '3 Star Contract',
};

itemList['gallery4star'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '4 Star Contract',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_4star.png',
  information: '4 Star Contract',
};

itemList['gallery5star'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '5 Star Contract',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_5star.png',
  information: '5 Star Contract',
};

itemList['gallerypremium'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Membership Card',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_premium.png',
  information: 'Premiere Membership Card',
};

itemList['galleryregular'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Membership Card',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_regular.png',
  information: 'Regular Membership Card',
};

itemList['galleryvip'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Membership Card',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_vip.png',
  information: 'VIP Membership Card',
};

itemList['curvyelephant'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pet Elephant',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_pet-elephant.png',
  information: 'Pretty curvy',
};

// Start Of Fishing Items
itemList['illegalhook'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Illegal Hook',
  craft: [],
  price: 500,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_illegal_hook.png',
  information: 'Hmm maybe fish will like this more?',
};

itemList['fishingrod'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Fishing Rod',
  price: 100,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_fishing-rod.png',
  information: 'Lets fish',
};

itemList['fishingbass'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Bass',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishing-bass.png',
  information: 'Striped Bass. Bass like the fish, not the officer',
  fishes: true,
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

itemList['fishingcarp'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Carp',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishing-carp.png',
  information: 'Carp. Carpe diem!',
  fishes: true,
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

itemList['fishingcatfish'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Catfish',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishing-cat.png',
  information: 'Catfish. Did you just get done catfish noodlin?',
  fishes: true,
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

itemList['fishingyellowperch'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Yellow Perch',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishing-yellowperch.png',
  information: 'Yellow Perch. Did they tell you not to perch or not to poach?',
  fishes: true,
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

itemList['fishingalligatorturtle'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Alligator Snapping Turtle',
  price: 1,
  weight: 75,
  nonStack: false,
  model: '',
  image: 'np_fishing-alligator-snapping-turtle.png',
  information: 'Alligator Snapping Turtle. This thing could snap your fingers off like twigs.',
  fishes: true,
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

itemList['fishingsockeyesalmon'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Sockeye Salmon',
  price: 1,
  weight: 75,
  nonStack: false,
  model: '',
  image: 'np_fishing-sockeye-salmon.png',
  information: 'Sockeye Salmon. It looks like you caught this one before it could reach its spawning grounds...',
  fishes: true,
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

itemList['fishingsturgeon'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Sturgeon',
  price: 1,
  weight: 75,
  nonStack: false,
  model: '',
  image: 'np_fishing-sturgeon.png',
  information: 'Green Sturgeon. It looks prehistoric and rare. Maybe it has caviar? ',
  fishes: true,
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};


itemList['fishingbluefish'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Bluegill',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishing-bluefish.png',
  information: 'Bluegill. Catching this took no skill.',
  fishes: true,
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

itemList['fishingflounder'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Flounder',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishing-flounder.png',
  information: 'I went fishing and all I got was this lousy flounder',
  fishes: true,
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

itemList['fishingmackerel'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Mackerel',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishing-mackerel.png',
  information: 'Sometimes holy',
  fishes: true,
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

itemList['fishingcod'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Cod',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishing-cod.png',
  information: 'Modern Warfare',
  fishes: true,
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

itemList['fishingwhale'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Baby Whale',
  price: 1,
  weight: 100,
  nonStack: true,
  model: '',
  image: 'np_fishing-whale.png',
  information: 'A fucking whale! Someone might be interested in buying it? Lol, jk. Throw it back. Unless..?',
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

itemList['fishingdolphin'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Baby Dolphin',
  price: 1,
  weight: 100,
  nonStack: true,
  model: '',
  image: 'np_fishing-dolphin.png',
  information: 'A fucking dolphin! Someone might be interested in buying it? Lol, jk. Throw it back. Unless..?',
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

itemList['fishingshark'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Baby Shark',
  price: 1,
  weight: 100,
  nonStack: true,
  model: '',
  image: 'np_fishing-shark.png',
  information: 'A fucking shark! Someone might be interested in buying it? Lol, jk. Throw it back. Unless..?',
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

itemList['fishingnet'] = {
  fullyDegrades: false,
  decayrate: 0.02,
  displayname: 'Gill Net',
  price: 250,
  craft: [],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_fishnet.png',
  weapon: false,
};

// FISHING JUNK

itemList['fishingboot'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Boot',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishingboot.png',
  information: 'insert shit here',
};

itemList['fishinglog'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Log',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishinglog.png',
  information: 'insert shit here',
};

itemList['fishingtin'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Tincan',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishingtin.png',
  information: 'insert shit here',
};

itemList['fishingtacklebox'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Tackle box',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishingtacklebox.png',
  information: 'insert shit here',
};

itemList['fishingchest'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Treasure chest',
  price: 1,
  weight: 25,
  nonStack: false,
  model: '',
  image: 'np_fishingchest.png',
  information: 'insert shit here',
};

itemList['fishinglockbox'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Lockbox',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishinglockbox.png',
  information: 'insert shit here',
};

itemList['fishingtunac'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Tuna Chip',
  craft: [[{ itemid: 'electronics', amount: 100 }]],
  price: 500,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_tuner.png',
  information: 'Works better on boats.',
};

// FISHING END
// HUNTING

itemList['3648318199'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Hunting Rifle',
  price: 500,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_huntingrifle.png',
  weapon: false,
};

itemList['huntingammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: '223 Hunting Rounds',
  price: 100,
  weight: 7,
  nonStack: false,
  model: '',
  image: 'np_223ammo.png',
};

itemList['huntingknife'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Hunting Knife',
  price: 100,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_huntingknife.png',
};

itemList['huntingbait'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Animal Bait',
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_huntingbait.png',
  information: 'Smells like old fish and shoes',
};

itemList['huntingcarcass1'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Animal Pelt',
  price: 1,
  weight: 75,
  nonStack: true,
  model: '',
  image: 'np_huntingcarcass1.png',
  information: 'What is this? Did you shoot it with an AK?',
};

itemList['huntingcarcass2'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Animal Pelt',
  price: 1,
  weight: 75,
  nonStack: true,
  model: '',
  image: 'np_huntingcarcass2.png',
  information: 'Someone might pay a pretty penny for this',
};

itemList['huntingcarcass3'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Animal Pelt',
  price: 1,
  weight: 75,
  nonStack: true,
  model: '',
  image: 'np_huntingcarcass3.png',
  information: 'I am sure we can turn this in to something fancy',
};

itemList['huntingcarcass4'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Animal Pelt',
  price: 1,
  weight: 150,
  nonStack: true,
  model: '',
  image: 'np_huntingcarcass4.png',
  information: 'Hunting in the South Side are we?',
};

itemList['huntingpelt'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Animal Pelt',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_huntingpelt.png',
  information: 'This used to keep an animal warm in the winter! You ANIMAL!',
};

itemList['huntingmeat'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Animal Meat',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_animalmeat.png',
  information: 'I am sure this could turn in to a killer burger',
  foodCategory: ['protein'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
};

// HUNTING END

// HEISTS
// practice
itemList['heistlaptopprac'] = {
  fullyDegrades: true,
  decayrate: 0.107,
  displayname: 'Laptop',
  price: 200,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_laptop_prac.png',
  information: 'Practice makes perfect. Marked for police seizure.',
};

// fleeca
itemList['heistlaptop3'] = {
  fullyDegrades: true,
  decayrate: 0.0075,
  displayname: 'Laptop',
  price: 1,
  weight: 20,
  nonStack: true,
  model: '',
  craft: [[{ itemid: 'electronics', amount: 1500 }]],
  image: 'np_laptop03.png',
  information: 'Pre-configured to access certain systems. Marked for police seizure.',
};

// paleto
itemList['heistlaptop2'] = {
  fullyDegrades: true,
  decayrate: 0.0075,
  displayname: 'Laptop',
  price: 1,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_laptop02.png',
  information: 'Pre-configured to access certain systems. Marked for police seizure.',
};

// vault upper
itemList['heistlaptop4'] = {
  fullyDegrades: true,
  decayrate: 0.0075,
  displayname: 'Laptop',
  price: 1,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_laptop04.png',
  information: 'Pre-configured to access certain systems. Marked for police seizure.',
};

// vault lower
itemList['heistlaptop1'] = {
  fullyDegrades: true,
  decayrate: 0.0075,
  displayname: 'Laptop',
  price: 1,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_laptop01.png',
  information: 'Pre-configured to access certain systems. Marked for police seizure.',
};

// fleeca
itemList['heistusb4'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Phone Dongle',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_green.png',
  information: 'Marked for Police Seizure',
};

itemList['heistusb5'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Laptop Dongle',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_green.png',
  information: 'Marked for Police Seizure',
};

itemList['heistusb6'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Laptop Dongle',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_pink.png',
  information: 'Marked for Police Seizure',
};

itemList['heistusbsr'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Master Key (25%)',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_pink.png',
  information: 'Combine multiple USBs to create a master encryption key.',
};

itemList['heistusbsrmk'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Master Key (100%)',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_pink.png',
  information: 'Master Key to access encrypted data.',
};

itemList['powercodes'] = {
  fullyDegrades: true,
  decayrate: 0.000124,
  displayname: 'Authorization Codes',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_receipt.png',
  information: 'Temporary access to city systems',
};

itemList['relayprobe'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Relay Reader',
  price: 500,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_electronic-kit.png',
  information: 'Reads relay power state',
};

// paleto
itemList['heistusb1'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Phone Dongle',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_blue.png',
  information: 'Marked for Police Seizure',
};

// vault upper
itemList['heistusb2'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Phone Dongle',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_red.png',
  information: 'Marked for Police Seizure',
};

// vault lower
itemList['heistusb3'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Phone Dongle',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_gold.png',
  information: 'Marked for Police Seizure',
};

// lower vault keyboard
itemList['vcomputerusb'] = {
  fullyDegrades: true,
  decayrate: 0.0075,
  displayname: 'Lower Vault Computer USB',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_heist_usb_black.png',
  information: 'Marked for Police Seizure',
};

itemList['thermitecharge'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Thermite Charge',
  price: 250,
  weight: 6,
  nonStack: false,
  model: '',
  image: 'np_thermite_charge.png',
  information: 'This thing burns!',
  craft: [
    [
      { itemid: 'aluminium', amount: 75 },
      { itemid: 'copper', amount: 75 },
      { itemid: 'rubber', amount: 50 },
      { itemid: 'plastic', amount: 75 },
      { itemid: 'electronics', amount: 100 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 18 },
      { itemid: 'refinedcopper', amount: 18 },
      { itemid: 'refinedrubber', amount: 12 },
      { itemid: 'refinedplastic', amount: 18 },
      { itemid: 'electronics', amount: 100 },
    ]
  ]
}

itemList['bobcatsecuritycard'] = {
  fullyDegrades: false,
  illegal: true,
  craft: [],
  decayrate: 0.0,
  displayname: 'Bobcat Security Keycard',
  price: 3500,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'gruppe62.png',
  information: 'For Gruppe6 contractors.',
};

itemList['casinoblueprintscase'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Secure Case',
  price: 350,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_securitycase.png',
  information: 'Etched on the side it reads "Blueprints to the Casino"',
};

itemList['casinoblueprints'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Diamond Casino & Resort',
  craft: [],
  price: 400,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'closed-book.png',
  information: 'Blueprints and information for Mr Dean Watson, or future owners.',
};

// YACHT
itemList['heistmicroenvelope'] = {
  fullyDegrades: true,
  deg: true,
  decayrate: 0.005,
  displayname: 'Microchipped Envelope',
  price: 350,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_microchipped_envelope.png',
  information: 'Wirelessly connected to the Yacht Security System',
};

// yacht ipad
itemList['heistpadyacht'] = {
  fullyDegrades: true,
  deg: true,
  decayrate: 0.075,
  displayname: 'PixelPad',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_heist_pad_blue.png',
  information: 'Pre-configured to access certain systems. Marked for police seizure.',
};
// HEISTS END

// METH
// lab key optimus prime
itemList['methlabkey'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Key to a Door',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_meth_key.png',
  information: '',
  contraband: true,
};

itemList['methlabbatch'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Batch of Raw Meth',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_meth_batch.png',
  information: 'Crystal-like. Needs to be stored somewhere cool and dry to cure.',
  contraband: true,
};

itemList['methlabcured'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Batch of Cured Meth',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_meth_cured.png',
  information: 'Ready for bagging!',
  contraband: true,
};

itemList['methlabbaggy'] = {
  fullyDegrades: false,
  decayrate: 0.02,
  displayname: 'Small Packaging Bag',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_meth_empty_baggy.png',
  information: '',
};

itemList['methlabproduct'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Meth (1g)',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_meth-baggy.png',
  information: '',
  contraband: true,
  insertTo: ['methpipe']
};
// METH END

// RACING
itemList['racingusb0'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Race Creating Dongle',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_racing_usb_blue.png',
  information: 'You do not see this...',
};

itemList['racingusb1'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Phone Dongle',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_racing_usb_blue.png',
  information: 'Marked for Police Seizure',
};

itemList['racingusb2'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Phone Dongle',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_racing_usb_blue.png',
  information: 'Marked for Police Seizure',
};

itemList['racingusb3'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Phone Dongle',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_racing_usb_blue.png',
  information: 'Access to SASP Time Trials App',
};

// RACING END
//MECHANIC REPAIR SHOPS

itemList['repairtoolkit'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Repair Toolkit',
  craft: [[{ itemid: 'aluminium', amount: 5 }]],
  price: 10,
  weight: 15,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_repair-toolkit.png',
  information: 'Used by Tow Truck drivers and repair people.',
};

//X CLASS REPAIR PARTS

itemList['xfixbrake'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Brake Parts (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_brake_parts_x.png',
  information: 'New brake discs, pads, calipers, hubs & accessories',
};
itemList['xfixaxle'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Axle Parts (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_axle_parts_x.png',
  information: 'New axle components',
};

itemList['xfixradiator'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Radiator Parts (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cooling_parts_x.png',
  information: 'New radiator and cooling parts',
};

itemList['xfixclutch'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Clutch Parts (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_clutch_parts_x.png',
  information: 'New clutch disc and pressure plate',
};

itemList['xfixtransmission'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Transmission Parts (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_transmission_parts_x.png',
  information: 'New gear sets, shafts, converters and clutch packs',
};

itemList['xfixelectronics'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Vehicle Electronics (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_electronic_parts_x.png',
  information: 'Various vehicle electrical components',
};

itemList['xfixinjector'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Fuel Injectors (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fuel_injectors_x.png',
  information: 'New fuel injectors',
};

itemList['xfixtire'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire Repair Kit (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_tire_kit_x.png',
  information: 'For swapping and repairing worn or damaged tires',
};

itemList['xfixbody'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Body Panels (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_body_panels_x.png',
  information: 'New vehicle body panels',
};

itemList['xfixengine'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Engine Parts (X)',
  craft: [[
    { itemid: 'xgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_engine_parts_x.png',
  information: 'New engine parts',
};

//S CLASS REPAIR PARTS

itemList['sfixbrake'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Brake Parts (S)',
  craft: [
    [
      { itemid: 'sgenericmechanicpart', amount: 3 },
    ]
  ],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_brake_parts_s.png',
  information: 'New brake discs, pads, calipers, hubs & accessories',
};
itemList['sfixaxle'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'sAxle Parts (S)',
  craft: [
    [
      { itemid: 'sgenericmechanicpart', amount: 3 },
    ]
  ],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_axle_parts_s.png',
  information: 'New axle components',
};

itemList['sfixradiator'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Radiator Parts (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cooling_parts_s.png',
  information: 'New radiator and cooling parts',
};

itemList['sfixclutch'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Clutch Parts (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_clutch_parts_s.png',
  information: 'New clutch disc and pressure plate',
};

itemList['sfixtransmission'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Transmission Parts (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_transmission_parts_s.png',
  information: 'New gear sets, shafts, converters and clutch packs',
};

itemList['sfixelectronics'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Vehicle Electronics (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_electronic_parts_s.png',
  information: 'Various vehicle electrical components',
};

itemList['sfixinjector'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Fuel Injectors (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fuel_injectors_s.png',
  information: 'New fuel injectors',
};

itemList['sfixtire'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire Repair Kit (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_tire_kit_s.png',
  information: 'For swapping and repairing worn or damaged tires',
};

itemList['sfixbody'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Body Panels (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_body_panels_s.png',
  information: 'New vehicle body panels',
};

itemList['sfixengine'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Engine Parts (S)',
  craft: [[
    { itemid: 'sgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_engine_parts_s.png',
  information: 'New engine parts',
};

//A CLASS REPAIR PARTS

itemList['afixbrake'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Brake Parts (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_brake_parts_a.png',
  information: 'New brake discs, pads, calipers, hubs & accessories',
};

itemList['afixaxle'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Axle Parts (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_axle_parts_a.png',
  information: 'New axle components',
};

itemList['afixradiator'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Radiator Parts (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cooling_parts_a.png',
  information: 'New radiator and cooling parts',
};

itemList['afixclutch'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Clutch Parts (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_clutch_parts_a.png',
  information: 'New clutch disc and pressure plate',
};

itemList['afixtransmission'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Transmission Parts (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_transmission_parts_a.png',
  information: 'New gear sets, shafts, converters and clutch packs',
};

itemList['afixelectronics'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Vehicle Electronics (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_electronic_parts_a.png',
  information: 'Various vehicle electrical components',
};

itemList['afixinjector'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Fuel Injectors (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fuel_injectors_a.png',
  information: 'New fuel injectors',
};

itemList['afixtire'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire Repair Kit (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_tire_kit_a.png',
  information: 'For swapping and repairing worn or damaged tires',
};

itemList['afixbody'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Body Panels (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_body_panels_a.png',
  information: 'New vehicle body panels',
};

itemList['afixengine'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Engine Parts (A)',
  craft: [[
    { itemid: 'agenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_engine_parts_a.png',
  information: 'New engine parts',
};

//B CLASS REPAIR PARTS

itemList['bfixbrake'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Brake Parts (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_brake_parts_b.png',
  information: 'New brake discs, pads, calipers, hubs & accessories',
};

itemList['bfixaxle'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Axle Parts (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_axle_parts_b.png',
  information: 'New axle components',
};

itemList['bfixradiator'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Radiator Parts (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cooling_parts_b.png',
  information: 'New radiator and cooling parts',
};

itemList['bfixclutch'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Clutch Parts (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_clutch_parts_b.png',
  information: 'New clutch disc and pressure plate',
};

itemList['bfixtransmission'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Transmission Parts (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_transmission_parts_b.png',
  information: 'New gear sets, shafts, converters and clutch packs',
};

itemList['bfixelectronics'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Vehicle Electronics (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_electronic_parts_b.png',
  information: 'Various vehicle electrical components',
};

itemList['bfixinjector'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Fuel Injectors (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fuel_injectors_b.png',
  information: 'New fuel injectors',
};

itemList['bfixtire'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire Repair Kit (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_tire_kit_b.png',
  information: 'For swapping and repairing worn or damaged tires',
};

itemList['bfixbody'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Body Panels (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_body_panels_b.png',
  information: 'New vehicle body panels',
};

itemList['bfixengine'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Engine Parts (B)',
  craft: [[
    { itemid: 'bgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_engine_parts_b.png',
  information: 'New engine parts',
};

//C CLASS REPAIR PARTS

itemList['cfixbrake'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Brake Parts (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_brake_parts_c.png',
  information: 'New brake discs, pads, calipers, hubs & accessories',
};

itemList['cfixaxle'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Axle Parts (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_axle_parts_c.png',
  information: 'New axle components',
};

itemList['cfixradiator'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Radiator Parts (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cooling_parts_c.png',
  information: 'New radiator and cooling parts',
};

itemList['cfixclutch'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Clutch Parts (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_clutch_parts_c.png',
  information: 'New clutch disc and pressure plate',
};

itemList['cfixtransmission'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Transmission Parts (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_transmission_parts_c.png',
  information: 'New gear sets, shafts, converters and clutch packs',
};

itemList['cfixelectronics'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Vehicle Electronics (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_electronic_parts_c.png',
  information: 'Various vehicle electrical components',
};

itemList['cfixinjector'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Fuel Injectors (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fuel_injectors_c.png',
  information: 'New fuel injectors',
};

itemList['cfixtire'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire Repair Kit (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_tire_kit_c.png',
  information: 'For swapping and repairing worn or damaged tires',
};

itemList['cfixbody'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Body Panels (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_body_panels_c.png',
  information: 'New vehicle body panels',
};

itemList['cfixengine'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Engine Parts (C)',
  craft: [[
    { itemid: 'cgenericmechanicpart', amount: 3 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_engine_parts_c.png',
  information: 'New engine parts',
};

//D CLASS REPAIR PARTS

itemList['dfixbrake'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Brake Parts (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_brake_parts_d.png',
  information: 'New brake discs, pads, calipers, hubs & accessories',
};

itemList['dfixaxle'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Axle Parts (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_axle_parts_d.png',
  information: 'New axle components',
};

itemList['dfixradiator'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Radiator Parts (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cooling_parts_d.png',
  information: 'New radiator and cooling parts',
};

itemList['dfixclutch'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Clutch Parts (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_clutch_parts_d.png',
  information: 'New clutch disc and pressure plate',
};

itemList['dfixtransmission'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Transmission Parts (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_transmission_parts_d.png',
  information: 'New gear sets, shafts, converters and clutch packs',
};

itemList['dfixelectronics'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Vehicle Electronics (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_electronic_parts_d.png',
  information: 'Various vehicle electrical components',
};

itemList['dfixinjector'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Fuel Injectors (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fuel_injectors_d.png',
  information: 'New fuel injectors',
};

itemList['dfixtire'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire Repair Kit (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_tire_kit_d.png',
  information: 'For swapping and repairing worn or damaged tires',
};

itemList['dfixbody'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Body Panels (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_body_panels_d.png',
  information: 'New vehicle body panels',
};

itemList['dfixengine'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Engine Parts (D)',
  craft: [[
    { itemid: 'dgenericmechanicpart', amount: 2 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_engine_parts_d.png',
  information: 'New engine parts',
};

//M CLASS REPAIR PARTS

itemList['mfixbrake'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Brake Parts (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_brake_parts_m.png',
  information: 'New brake discs, pads, calipers, hubs & accessories',
};

itemList['mfixaxle'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Axle Parts (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_axle_parts_m.png',
  information: 'New axle components',
};

itemList['mfixradiator'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Radiator Parts (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 5 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cooling_parts_m.png',
  information: 'New radiator and cooling parts',
};

itemList['mfixclutch'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Clutch Parts (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_clutch_parts_m.png',
  information: 'New clutch disc and pressure plate',
};

itemList['mfixtransmission'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Transmission Parts (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_transmission_parts_m.png',
  information: 'New gear sets, shafts, converters and clutch packs',
};

itemList['mfixelectronics'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Vehicle Electronics (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_electronic_parts_m.png',
  information: 'Various vehicle electrical components',
};

itemList['mfixinjector'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Fuel Injectors (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fuel_injectors_m.png',
  information: 'New fuel injectors',
};

itemList['mfixtire'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Tire Repair Kit (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_tire_kit_m.png',
  information: 'For swapping and repairing worn or damaged tires',
};

itemList['mfixbody'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Body Panels (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_body_panels_m.png',
  information: 'New vehicle body panels',
};

itemList['mfixengine'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Engine Parts (M)',
  craft: [[
    { itemid: 'mgenericmechanicpart', amount: 4 },
  ]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_engine_parts_m.png',
  information: 'New engine parts',
};

// MECHANIC REPAIR SHOPS END
itemList['gallery1star'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '1 Star Contract',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_1star.png',
  information: '1 Star Contract',
};
itemList['gallery2star'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '2 Star Contract',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_2star.png',
  information: '2 Star Contract',
};
itemList['gallery3star'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '3 Star Contract',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_3star.png',
  information: '3 Star Contract',
};
itemList['gallery4star'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '4 Star Contract',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_4star.png',
  information: '4 Star Contract',
};
itemList['gallery5star'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '5 Star Contract',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_5star.png',
  information: '5 Star Contract',
};
itemList['gallerypremium'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Gallery Membership Card',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_premium.png',
  information: 'Premiere Membership Card',
};
itemList['galleryregular'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Gallery Membership Card',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_regular.png',
  information: 'Regular Membership Card',
};
itemList['galleryvip'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Gallery Membership Card',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_gallery_vip.png',
  information: 'VIP Membership Card',
};

itemList['curvyelephant'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pet Elephant',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_pet-elephant.png',
  information: 'Pretty curvy',
};

// Xmas stuff
itemList['xmasgiftcoal'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'A nicely wrapped present',
  price: 1,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_christmas_present.png',
  information: 'Those on the nice list would be heartily rewarded :)',
};
itemList['xmascoal'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'A lump of coal',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_christmas_coal.png',
  information: 'Guess you were on the naughty list. At least its got a ribbon?',
};
// 126349499 - snowball

// Progression
itemList['godbook'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'The Bible',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_textbook-a.png',
  information: 'God has blessed thee with the gift of... power.',
};

itemList['newaccountbox'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Presents',
  price: 350,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_box.png',
  information: 'Welcome to NoPixel!',
};

itemList['pimpcane'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Cane',
  price: 350,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_pimp-cane.png',
  information: 'Walk with style.',
};

itemList['burgerReceipt'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Work Receipt',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_receipt.png',
  information: '',
};

itemList['farmersmarketreceipt'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Market Receipt',
  price: 400,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_receipt.png',
  information: 'Earned at the Farmers Market',
};

itemList['softdrink'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Soft Drink',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_softdrink.png',
  information: 'Sates thirst and gives a sugar rush',
};

itemList['bscoffee'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Cheap Coffee',
  price: 15,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_bscoffee.png',
  information: 'Tastes like dirt, but has the caffeine you need',
};

itemList['honestwinebox'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Box of Honest Wine',
  price: 1,
  weight: 30,
  nonStack: true,
  model: '',
  image: 'np_honest_wine_box.png',
  information: 'Contains 6 bottles of Honest Wine',
};

itemList['honestwinebottle'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Honest Wine',
  price: 1,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_honest_wine.png',
  information: 'Zero Crime',
};

itemList['honestwineglass'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Glass of Honest Wine',
  craft: [[{ itemid: 'honestwinebottle', amount: 0.25 }, { itemid: 'wineglass', amount: 1 }]],
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_wineglass_full.png',
  information: '[E] to Sip',
};

itemList['wineglass'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Empty Wine Glass',
  price: 20,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_wineglass_empty.png',
  information: 'Needs to be filled with something',
};

itemList['winemilkshake'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Milkshake',
  craft: [[{ itemid: 'honestwinebottle', amount: 1 }, { itemid: 'mshake', amount: 1 }]],
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_milkshake.png',
  information: 'Wine-scooped for you.',
};

itemList['hamburgerbuns'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Hamburger Bun',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_buns.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
};

itemList['lettuce'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Lettuce',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_lettuce.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
};

itemList['hamburgerpatty'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Hamburger Patty',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_patty.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
};

itemList['cheese'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Cheese',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_cheese.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
};

itemList['potatoingred'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Potatoes',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_potato.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
};

itemList['milk'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Milk',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_milk.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
};

itemList['icecreamingred'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Ice Cream',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_icecream.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
};

itemList['coffeebeans'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Coffee Beans',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_coffeebeans.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
};

itemList['hfcs'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'High-Fructose Syrup',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_hfcs.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
};

itemList['tomato'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Tomato',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_tomato.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
  foodCategory: ['vegetables'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
  produce: true,
};

itemList['cucumber'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Cucumber',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_cucumber.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
  foodCategory: ['vegetables'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
  produce: true,
};

itemList['carrot'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Carrot',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_carrot.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
  foodCategory: ['vegetables'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
  produce: true,
};

itemList['radish'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Radish',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'radish.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
  foodCategory: ['vegetables'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
  produce: true,
};

itemList['beetroot'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Beet',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'beetroot.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
  foodCategory: ['vegetables'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
  produce: true,
};

itemList['cabbage'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Cabbage',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_cabbage.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
  foodCategory: ['vegetables'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
  produce: true,
};

itemList['chives'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Chives',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_chives.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
  foodCategory: ['seasoning'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
  produce: true,
};

itemList['pumpkin'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Pumpkin',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_pumpkin.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
  foodCategory: ['sugar'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
  produce: true,
};

itemList['corn'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Corn',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'corn.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
  foodCategory: ['grain'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
  produce: true,
};

itemList['oregano'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Oregano',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_oregano.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
  foodCategory: ['seasoning'],
  foodEnhancement: 1.0,
  foodEnhancementFromMeta: false,
  produce: true,
};

itemList['garlic'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Garlic',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_garlic.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
  foodCategory: ['seasoning'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
  produce: true,
};

itemList['mushrooms'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Mushrooms',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ingredients_mushrooms.png',
  information: 'Used to craft food - be aware, food doesnt last forever!',
  foodCategory: ['vegetables'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
  produce: true,
};

itemList['burgershotbag'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'BurgerShot Bag',
  price: 1,
  weight: 4,
  nonStack: true,
  model: '',
  image: 'np_burgershot_bag.png',
  information: 'Contains your Burger Shot order... or does it?',
};

itemList['casinobag'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Diamond Casino Bag',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_dcbag.png',
  information: 'Contains some Casino goodies!',
};

itemList['wrappedgift'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Wrapped Gift',
  price: 50,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_wrappedgift.png',
  information: 'Its a gift, whats inside?',
};

itemList['burgershotheadset'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Hello? Is this thing on?',
  price: 1,
  weight: 4,
  nonStack: true,
  model: '',
  image: 'np_headset3.png',
  information: 'I asked for 3 fries, not 4 milkshakes?',
};

itemList['tealeaves'] = {
  fullyDegrades: false,
  decayrate: 0.75,
  displayname: 'Tea Leaves',
  price: 10,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_tealeaves.png',
  information: '',
};

itemList['roostertea'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'Tea',
  craft: [[{ itemid: 'tealeaves', amount: 1 }]],
  price: 15,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_roostertea.png',
  information: 'Makes you feel Charismatic, inspiring people to like you more for 2 hours!',
};

itemList['roostertakeout'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Roosters Takeout',
  price: 1,
  weight: 4,
  nonStack: true,
  model: '',
  image: 'np_roosterrest_bag.png',
  information: 'Contains your Roosters Rest order... or does it?',
};

itemList['foodbag'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Brown Bag',
  price: 5,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_food_bag.png',
  information: 'Enough space for one.',
};

itemList['helicopterrepairkit'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Helicopter Repair Kit',
  craft: [[{ itemid: 'electronics', amount: 10 }]],
  price: 500,
  weight: 80,
  nonStack: false,
  model: '',
  image: 'np_helicopter_repair_kit.png',
  information: '1 Time use - repairs engine to full.',
};

itemList['casinomember'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'Member Card',
  price: 3500,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_casino_member.png',
  information: 'All the games, all the fun. Diamond Casino.',
};

itemList['casinoloyalty'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Loyalty Card',
  price: 3500,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_casino_member.png',
  information: '%gamba',
};

itemList['casinovip'] = {
  fullyDegrades: true,
  decayrate: 0.025,
  displayname: 'High Roller Card',
  price: 60000,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_casino_high_roller.png',
  information: 'Stacks on stacks on stacks. Diamond Casino.',
};

itemList['casinoraffleticket'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Raffle Ticket',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_raffleticket.png',
  information: 'Win the car on display! Keep this safe!',
};

itemList['bodyrepairkit'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Body Repair Kit',
  craft: [[
    { itemid: 'aluminium', amount: 5 },
    { itemid: 'steel', amount: 10 }
  ]],
  price: 250,
  weight: 40,
  nonStack: false,
  model: '',
  image: 'np_body_repair_kit.png',
  information: '1 Time use - repairs body to full.',
};

itemList['gallerygem'] = {
  _name: 'gallerygem',
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Gemstone',
  craft: [],
  price: 250,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_gallery_diamond.png',
  information: 'Take this somewhere to get it appraised.',
};

itemList['mask'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Mask',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_mask.png',
  information: '',
};

itemList['hat'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Hat',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_hat.png',
  information: '',
};

itemList['cgchain'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Chang Gang Chain',
  craft: [[
    { itemid: 'goldbar', amount: 2 },
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'copper', amount: 100 },
  ], [
    { itemid: 'goldbar', amount: 2 },
    { itemid: 'refinedaluminium', amount: 32 },
    { itemid: 'refinedcopper', amount: 32 },
  ]],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_cg_chain.png',
  information: 'Represent!',
  cgChainCraft: true,
};

itemList['gsfchain'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'GSF Chain',
  craft: [[
    { itemid: 'goldbar', amount: 2 },
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'copper', amount: 100 },
  ], [
    { itemid: 'goldbar', amount: 2 },
    { itemid: 'refinedaluminium', amount: 32 },
    { itemid: 'refinedcopper', amount: 32 },
  ]],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_gsf_chain.png',
  information: 'Represent!',
  cgChainCraft: true,
};

itemList['vagoschain'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Vagos Chain',
  craft: [[
    { itemid: 'goldbar', amount: 2 },
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'copper', amount: 100 },
  ], [
    { itemid: 'goldbar', amount: 2 },
    { itemid: 'refinedaluminium', amount: 32 },
    { itemid: 'refinedcopper', amount: 32 },
  ]],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_vagos_chain.png',
  information: 'Represent!',
  cgChainCraft: true,
};

itemList['koilchain'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Sloth Chain',
  craft: [[
    { itemid: 'goldbar', amount: 2 },
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'copper', amount: 100 },
  ], [
    { itemid: 'goldbar', amount: 2 },
    { itemid: 'refinedaluminium', amount: 32 },
    { itemid: 'refinedcopper', amount: 32 },
  ]],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_sloth_chain.png',
  information: 'Represent!',
  cgChainCraft: true,
};

itemList['cerberuschain'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cerberus Chain',
  craft: [[
    { itemid: 'goldbar', amount: 2 },
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'copper', amount: 100 },
  ], [
    { itemid: 'goldbar', amount: 2 },
    { itemid: 'refinedaluminium', amount: 32 },
    { itemid: 'refinedcopper', amount: 32 },
  ]],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_cerberus_chain.png',
  information: 'Represent!',
  cgChainCraft: true,
};

itemList['mdmchain'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'MandeM Chain',
  craft: [[
    { itemid: 'goldbar', amount: 2 },
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'copper', amount: 100 },
  ], [
    { itemid: 'goldbar', amount: 2 },
    { itemid: 'refinedaluminium', amount: 32 },
    { itemid: 'refinedcopper', amount: 32 },
  ]],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_mdm_chain.png',
  information: 'Represent!',
  cgChainCraft: true,
};

itemList['squidmask'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'VIP Mask',
  craft: [[
    { itemid: 'goldbar', amount: 4 },
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'copper', amount: 100 },
  ], [
    { itemid: 'goldbar', amount: 4 },
    { itemid: 'refinedaluminium', amount: 32 },
    { itemid: 'refinedcopper', amount: 32 },
  ]],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_vip_mask.png',
  information: 'Hush hush.',
  cgChainCraft: true,
};

itemList['varhelmet'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'VAR Helmet',
  craft: [],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_var_headset.png',
  information: 'Virtually augmented reality, woah.',
};

itemList['varmedkit'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'CPR Medical Kit',
  price: 50,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_bandage.png',
  information: 'Gives life to someone who needs it!',
};

itemList['darkmarketdeliveries'] = {
  fullyDegrades: false,
  decayrate: 0.006,
  displayname: 'Delivery List',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_dark_market_customers.png',
  information: 'A suspicious list with transport instructions. Marked for Police Seizure.',
};

itemList['darkmarketpackage'] = {
  fullyDegrades: false,
  decayrate: 0.002,
  displayname: 'Suspicious Package',
  price: 1,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_dark_market_package.png',
  information: 'Package covered in tape and milk stickers. Marked for Police Seizure.',
};

itemList['choplist'] = {
  fullyDegrades: true,
  decayrate: 0.006,
  displayname: 'Vehicle List',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_dark_market_customers.png',
  information: 'List with locations and vehicle models. Marked for Police Seizure.',
};

itemList['bennysorder'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Bennys Order',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_receipt.png',
  information: 'Go to the manager and buy the parts.<br>Then give this to an employee.',
};

itemList['stolenshoes'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Stolen Shoes',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_stolenshoes.png',
  information: 'These are not yours, bro.',
};

itemList['rentalpapers'] = {
  fullyDegrades: true,
  decayrate: 0.018,
  displayname: 'Rental Papers',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_documents.png',
  information: 'Proof of purchase. Use to get extra rental keys.',
};

itemList['fightnightbelt'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Fight Night Belt',
  price: 1,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_fightnight_belt.png',
  information: '',
};

// Franks pranks
itemList['franksmonster'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Frankster',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_frankster.png',
  information: 'Gives you stunningly fast speed.',
};

itemList['frankstruth'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Truth Serum',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_truthserum.png',
  information: 'Good for one truth, and one truth only',
};

itemList['franksflute'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: "Frank's Flute",
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_franksflute.png',
  information: 'A little dance for everyone.',
};

// START TCG

itemList['tcggovernmentbooster'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Booster Pack',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_tcggovernmentbooster.png',
  information: 'Government set booster pack containing 6 cards.',
  deg: false,
  insertTo: ['tcgbinder'],
};

itemList['tcgcrewsbooster'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Booster Pack',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_tcgcrewsbooster.png',
  information: 'Crews set booster pack containing 6 cards.',
  deg: false,
  insertTo: ['tcgbinder'],
};

itemList['tcgcivsbooster'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Booster Pack',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_tcgcivsbooster.png',
  information: 'Civs set booster pack containing 6 cards.',
  deg: false,
  insertTo: ['tcgbinder'],
};

itemList['tcgpromobooster'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Booster Pack',
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_tcgpromobooster.png',
  information: 'Promo set booster pack containing 1 card.',
  deg: false,
  insertTo: ['tcgbinder'],
};

itemList['tcgpromopacks'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Promotional Pack',
  price: 1,
  weight: 3.0,
  nonStack: false,
  model: '',
  image: 'np_tcgpromopacks.png',
  information: '1 Civs Booster. 1 Crews Booster. 1 Government Booster.',
  deg: false,
};

itemList['tcgboosterbox'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Booster Box',
  price: 1,
  weight: 18.0,
  nonStack: false,
  model: '',
  image: 'np_tcgboosterbox.png',
  information: '6 Civs Boosters. 6 Crews Boosters. 6 Government Boosters.',
  deg: false,
};

itemList['tcgcard'] = {
  _name: 'tcgcard',
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Trading Card',
  price: 1,
  weight: 0.0,
  nonStack: true,
  model: '',
  image: 'np_tcgcard.png',
  information: 'A single trading card.',
  deg: false,
  insertTo: ['tcgbinder'],
  insertFrom: ['lighter'],
};

itemList['tcghardcase'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Hard Case',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_tcghardcase.png',
  information: 'A protective case for a trading card.',
  deg: false,
  insertTo: ['tcgcard'],
};

itemList['tcgbinder'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Trading Card Binder',
  price: 1,
  weight: 10.0,
  nonStack: true,
  model: '',
  image: 'np_tcgbinder.png',
  information: 'A binder for all your trading cards.',
  deg: false,
};

// END TCG

itemList['boebear'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Boe Bear',
  price: 1,
  weight: 1.0,
  nonStack: true,
  model: '',
  image: 'glenn_boe-bear.png',
  information: 'Los Santos wouldn’t be the same if it wasn’t for you. You made this possible, and we are all forever greatful. We love and miss you, always. Hug me!',
  deg: false,
};

// GoPro Dashcam
itemList['dashcamracing'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'GoPixel (Public)',
  price: 250,
  craft: [],
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_dashcam.png',
  information: 'Throw this in your vehicle to stream live footage to the cloud! Unencrypted.',
  weapon: false,
};
itemList['dashcampd'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'GoPixel (PD)',
  price: 100,
  craft: [],
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_dashcam.png',
  information: 'Throw this in your vehicle to stream live footage to the cloud! Encrypted.',
  weapon: false,
};
itemList['dashcamstatic'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'GoPixel (Static)',
  price: 250,
  craft: [[
    { itemid: 'plastic', amount: 100 },
    { itemid: 'electronics', amount: 50 },
  ], [
    { itemid: 'refinedplastic', amount: 33 },
    { itemid: 'electronics', amount: 50 },
  ]],
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_dashcam.png',
  information: 'Security camera for things.',
  weapon: false,
};
itemList['dashcamstaticpd'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'GoPixel (Static)',
  price: 250,
  craft: [[
    { itemid: 'plastic', amount: 100 },
    { itemid: 'electronics', amount: 50 },
  ], [
    { itemid: 'refinedplastic', amount: 33 },
    { itemid: 'electronics', amount: 50 },
  ]],
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_dashcam.png',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
  weapon: false,
};

itemList['moneycase'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Regular Briefcase',
  price: 500,
  craft: [],
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_moneycase.png',
  information: 'Good for about $20k in large bills.',
  weapon: false,
};

itemList['nightvisiongoggles'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Night Vision Goggles',
  price: 5000,
  craft: [],
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_nv.png',
  information: 'Mil-Spec. High price, low quality.',
  weapon: false,
};

itemList['nightvisiongogglespd'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'NVG (SWAT)',
  price: 100,
  craft: [],
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_nv.png',
  information: 'Mil-Spec. High price, low quality. If you are not SWAT certified do not buy this.',
  weapon: false,
};

itemList['grapplegun'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: 'Grapple Gun',
  price: 1000000,
  craft: [],
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_grapple.png',
  information: 'This is some Batman shit. Marked for Police Seizure.',
  weapon: false,
  craft: [
    [
      { itemid: 'aluminium', amount: 750 },
      { itemid: 'plastic', amount: 750 },
      { itemid: 'rubber', amount: 750 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 250 },
      { itemid: 'refinedplastic', amount: 250 },
      { itemid: 'refinedrubber', amount: 250 },
    ]
  ],
};

itemList['grapplegunpd'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: 'Grapple Gun (SWAT)',
  price: 100,
  craft: [],
  weight: 30,
  nonStack: true,
  model: '',
  image: 'np_grapple.png',
  information: 'This is some Batman shit. If you are not SWAT certified do not buy this.',
  weapon: false,
};

itemList['poisonedcocktail'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Red Death',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'moonshine', amount: 1 },
    { itemid: 'drink2', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_reddeath.png',
  information: "Named after someone who goes to another school.",
};

itemList['poisonedsandwich'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Sandwich',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'moonshine', amount: 1 },
    { itemid: 'sandwich', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_sandwich.png',
  information: "Sates Hunger",
};

itemList['poisonedwater'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Water',
  price: 150,
  weight: 1,
  craft: [[
    { itemid: 'moonshine', amount: 1 },
    { itemid: 'sandwich', amount: 1 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_water.png',
  information: "Sates Thirst",
}

itemList['weedpackage'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Suspicious Package',
  price: 1,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_box-of-weed-12-18-oz.png',
  information: 'Marked for Police Seizure.',
  contraband: true,
};

itemList['methpackage'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Suspicious Package',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_meth_brick.png',
  information: 'Marked for Police Seizure.',
  contraband: true,
};

itemList['methbag'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Big Meth Bag (100g)',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_meth_bag.png',
  information: '100g of pure fuckin meth',
  contraband: true,
};

itemList['tacodeliverylist'] = {
  fullyDegrades: false,
  decayrate: 0.006,
  displayname: 'Large Delivery List',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_dark_market_customers.png',
  information: 'A list with transport instructions.',
};

itemList['tattooremover'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Tattoo Remover',
  price: 1500,
  weight: 10,
  craft: [],
  nonStack: false,
  model: '',
  image: 'tattoo_remover.png',
  information: "Removes tattoos from someone.",
};

itemList['vehicle_repo_order'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Vehicle Repossision Order',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_repo_order.png',
  information: 'Document used to repossess vehicles.',
};

itemList['musictape'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Music Tape',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cassette.png',
  information: 'Play me!',
};

itemList['musicmerch'] = {
  _name: 'musicmerch',
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '(S) Merchandise',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_merchandise.png',
  information: '',
  collectible: true,
}

itemList['musicwalkman'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Walkman',
  price: 100,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_walkman.png',
  information: '',
  craft: [[
    { itemid: 'genericelectronicpart', amount: 1 },
  ]],
}

itemList['megaphone'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Megaphone',
  price: 500,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_megaphone.png',
  information: '',
  deg: true
}
itemList['vendorlicense'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Vendor License',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_driving-test.png',
  information: 'Ability to sell goods at the Farmers Markets.',
};

itemList['casinodiscountcard'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Casino Hotel Loyalty Card',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_casino_member.png',
  information: 'Show this for discounts with our partners around the city.',
};

itemList['customfooditem'] = {
  _name: 'customfooditem',
  fullyDegrades: true,
  decayrate: 0.1,
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  displayname: 'Food',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_sandwich.png',
  information: '',
};

itemList['customwateritem'] = {
  _name: 'customwateritem',
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Water',
  price: 5,
  weight: 0,
  craft: [[{ itemid: 'foodingredient', amount: 1 }]],
  nonStack: false,
  model: '',
  image: 'np_water.png',
  information: '',
};

itemList['customcoffeeitem'] = {
  _name: 'customcoffeeitem',
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Coffee',
  craft: [[{ itemid: 'foodingredient', amount: 2 }]],
  price: 50,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_coffee.png',
  information: '',
};

itemList['customjointitem'] = {
  _name: 'customjointitem',
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.1,
  displayname: 'Joint',
  craft: [[
    { itemid: 'weedq', amount: 0.5 },
    { itemid: 'rollingpaper', amount: 1 },
  ]],
  price: 25,
  weight: 3,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_joint.png',
  information: '',
  contraband: true,
};

itemList['custommerchitem'] = {
  _name: 'custommerchitem',
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Item',
  price: 25,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_merchandise.png',
  information: '',
  collectible: true,
};

itemList['customciggyitem'] = {
  _name: 'customciggyitem',
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Cigarettes',
  price: 25,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_ciggypack.png',
  information: '',
};

itemList['custombandageitem'] = {
  _name: 'custombandageitem',
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'First Aid Kit',
  price: 25,
  weight: 5,
  nonStack: false,
  model: 'prop_ld_health_pack',
  image: 'np_bandage.png',
  information: '',
};

itemList['imported_vehicle_part'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Imported Vehicle Part',
  price: 1,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_box.png',
  information: 'Imported vehicle modification ready to be prepared.',
};

itemList['vehicle_part'] = {
  _name: 'vehicle_part',
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Vehicle Part',
  price: 1,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_vehicle_part.png',
  information: 'Vehicle modification ready to be installed.',
};

// deanworld items
// corndog
// cotton candy
// caramel apple
// kettle corn
// soft pretzel

itemList['deanworldcorndog'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Corn Dog',
  price: 400,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_dw_corndog.png',
  information: 'Dean World special!',
};

itemList['deanworldcottoncandy'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Cotton Candy',
  price: 400,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_dw_cottoncandy.png',
  information: 'Dean World special!',
};

itemList['deanworldcaramelapple'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Caramel Apple',
  price: 400,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_dw_caramelapple.png',
  information: 'Dean World special!',
};

itemList['deanworldkettlecorn'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Kettle Corn',
  price: 400,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_dw_kettlecorn.png',
  information: 'Dean World special!',
};

itemList['deanworldsoftpretzel'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Soft Pretzel',
  price: 400,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_dw_softpretzel.png',
  information: 'Dean World special!',
};

itemList['fruitslushy'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Fruit Slushy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fruit_slushy.png',
  information: 'The fruitiest slushy ever.',
};

itemList['murdermeal'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Murder Meal',
  price: 0,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_murder_meal.png',
  information: 'This burger may kill you! We are not responsible',
};

itemList['randomtoy'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Murder Meal Toy - Collection 1',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toy.png',
  information: 'Open to see what you got!',
};

itemList['randomtoy2'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Murder Meal Toy - Collection 2',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toy.png',
  information: 'Open to see what you got!',
};

itemList['randomtoy3'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Murder Meal Toy - Collection 3',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toy.png',
  information: 'Open to see what you got!',
};

itemList['toy_burgershot'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toy.png',
  information: 'Collect them all!',
};

itemList['toy_shelly'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Shelly Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_shelly.png',
  information: '(C1) 1/4. Collect them all!',
  collectible: true,
};

itemList['toy_ken'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Ken Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_ken.png',
  information: '(C1) 2/4. Collect them all!',
  collectible: true,
};

itemList['toy_rob'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Rob Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_rob.png',
  information: '(C1) 3/4. Collect them all!',
  collectible: true,
};

itemList['toy_sheldon'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Sheldon Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_sheldon.png',
  information: '(C1) 4/4. Collect them all!',
  collectible: true,
};

itemList['toy_kevin'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Kevin Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_kevin.png',
  information: '(C1) 5/4. Ultra Rare!',
  collectible: true,
};

itemList['toy_dean'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Dean Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_dean.png',
  information: '(C2) 1/10. Collect them all!',
  collectible: true,
};

itemList['toy_pilbis'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pilbis Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_pilbis.png',
  information: '(C2) 2/10. Collect them all!',
  collectible: true,
};

itemList['toy_betch'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Betch Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_betch.png',
  information: '(C2) 3/10. Collect them all!',
  collectible: true,
};

itemList['toy_bradley'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Bradley Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_bradley.png',
  information: '(C2) 4/10. Collect them all!',
  collectible: true,
};

itemList['toy_barry'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Barry Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_barry.png',
  information: '(C2) 5/10. Collect them all!',
  collectible: true,
};

itemList['toy_lenny'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lenny Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_lenny.png',
  information: '(C2) 6/10. Collect them all!',
  collectible: true,
};

itemList['toy_ott'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'OTT Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_OTT.png',
  information: '(C2) 7/10. Collect them all!',
  collectible: true,
};

itemList['toy_slim'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Slim Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_slim.png',
  information: '(C2) 8/10. Collect them all!',
  collectible: true,
};

itemList['toy_tony'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Tony Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_tony.png',
  information: '(C2) 9/10. Collect them all!',
  collectible: true,
};

itemList['toy_cassie'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cassie Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_cassie.png',
  information: '(C2) 10/10. Collect them all!',
  collectible: true,
};

itemList['toy_clayvon'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Clayvon Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_clayvon.png',
  information: '(C2) 11/10. Ultra Rare!',
  collectible: true,
};

itemList['toy_jackie'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Jackie Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_jackie.png',
  information: '(C0) 1/1. Ultra Rare!',
  collectible: true,
};

itemList['toy_eugene'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Eugene Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_eugene.png',
  information: '(C3) 1/10. Collect them all!',
  collectible: true,
};

itemList['toy_jordan'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Jordan Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_jordan.png',
  information: '(C3) 2/10. Collect them all!',
  collectible: true,
};

itemList['toy_kiki'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Kiki Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_kiki.png',
  information: '(C3) 3/10. Collect them all!',
  collectible: true,
};

itemList['toy_steven'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Steven Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_steven.png',
  information: '(C3) 4/10. Collect them all!',
  collectible: true,
};

itemList['toy_kyle'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Kyle Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_kyle.png',
  information: '(C3) 5/10. Collect them all!',
  collectible: true,
};

itemList['toy_oki'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Oki Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_oki.png',
  information: '(C3) 6/10. Collect them all!',
  collectible: true,
};

itemList['toy_kitty'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Kitty Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_kitty.png',
  information: '(C3) 7/10. Collect them all!',
  collectible: true,
};

itemList['toy_molly'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Molly Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_molly.png',
  information: '(C3) 8/10. Collect them all!',
  collectible: true,
};

itemList['toy_sherry'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Sherry Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_sherry.png',
  information: '(C3) 9/10. Collect them all!',
  collectible: true,
};

itemList['toy_x'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'X Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_x.png',
  information: '(C3) 10/10. Collect them all!',
  collectible: true,
};

itemList['toy_frank'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Frank Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'bs_toy_frank.png',
  information: '(C3) 11/10. Ultra Rare!',
  collectible: true,
};

itemList['newsusb'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'News USB',
  price: 50,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_news_usb.png',
  information: 'Property of LS News Center',
};

itemList['newstape'] = {
  _name: "newstape",
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'News Footage',
  price: 0,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_news_tape.png',
  information: 'Caught in 4K Ultra HD',
};

itemList['newscamera'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'News Camera',
  price: 100,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_news_camera.png',
  information: 'A little dusty',
};

itemList['newsmic'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'News Mic',
  price: 100,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_news_mic.png',
  information: 'Is this thing on?',
};

itemList['newsboom'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'News Boom',
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_news_boom.png',
  information: 'Heavier than it looks',
};

itemList['newslight'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'News Light',
  price: 100,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_news_light.png',
  information: "I said, ooooh, Im blinded by the lights",
};

itemList['collectiblepouch'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Collectibles Pouch',
  price: 100,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_collectible_pouch.png',
  information: "Holds a bunch of collectibles.",
  whitelist: [
    "collectible"
  ],
};

itemList['summonablepet'] = {
  _name: 'summonablepet',
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pet Animal',
  price: 100,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_p_rott.png',
  information: "Summon your pet.",
}; // https://i.imgur.com/rwKGt2b.png rott https://i.imgur.com/Kc51atn.png shep

itemList['weedbaggie'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.3,
  displayname: 'Baggie (7g)',
  craft: [],
  price: 65,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_weed-oz.png',
  information: 'Sold on the streets',
  deg: false,
};

// GEM CRAFTING
// idk if any of the below will actually be a thing just leaving for reference
// Jade - Hunger/Thirst Buff 50%
// Citrine - Lockpick Buff
// Aquamarine - Oxygen Buff 50%
// Sapphire - Tazer Resistance
// Ruby - Fire Resistance Buff
// Diamond - Armor Buff
// Tanzanite - ???
// Onyx - ???
itemList['craftedgemjade'] = {
  fullyDegrades: true,
  deg: true,
  decayrate: 0.25,
  displayname: 'Jade Ring',
  craft: [],
  price: 50000,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_gallery_jade-ring.png',
  information: 'Wearing this helps with Nourishment',
};

itemList['craftedgemcitrine'] = {
  fullyDegrades: true,
  deg: true,
  decayrate: 0.25,
  displayname: 'Citrine Ring',
  craft: [],
  price: 50000,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_gallery_citrine-ring.png',
  information: 'Wearing this helps with Rejuvenation',
};

itemList['craftedgemaquamarine'] = {
  fullyDegrades: true,
  deg: true,
  decayrate: 0.25,
  displayname: 'Aquamarine Ring',
  craft: [],
  price: 50000,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_gallery_aquamarine-ring.png',
  information: 'Wearing this helps when in Water',
};

itemList['cockbox'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Cock In A Box',
  price: 0,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_rr_cock_box.png',
  information: 'Its a cock, in a box!',
};

itemList['cockegg'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cock Egg',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_rr_cock_egg.png',
  information: 'Contains a random Rooster Toy from Collection 1',
};

itemList['toy_rr_bjorn'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Bjorn Rooster Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_rr_bjorn.png',
  information: '(C1) 1/8. Collect them all!',
  collectible: true,
};

itemList['toy_rr_gloryon'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Gloryon Rooster Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_rr_gloryon.png',
  information: '(C1) 2/8. Collect them all!',
  collectible: true,
};

itemList['toy_rr_lando'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lando Rooster Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_rr_lando.png',
  information: '(C1) 3/8. Collect them all!',
  collectible: true,
};

itemList['toy_rr_meowfurryon'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Meowfurryon Rooster Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_rr_meowfurryon.png',
  information: '(C1) 4/8. Collect them all!',
  collectible: true,
};

itemList['toy_rr_leyla'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Leyla Rooster Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_rr_leyla.png',
  information: '(C1) 5/8. Collect them all!',
  collectible: true,
};

itemList['toy_rr_stagdancer'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Stagdancer Rooster Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_rr_stagdancer.png',
  information: '(C1) 6/8. Collect them all!',
  collectible: true,
};

itemList['toy_rr_yeager'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Yeager Rooster Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_rr_yeager.png',
  information: '(C1) 7/8. Collect them all!',
  collectible: true,
};

itemList['toy_rr_buddha'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Buddha Rooster Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_rr_buddha.png',
  information: '(C1) 8/8. Collect them all!',
  collectible: true,
};

itemList['toy_rr_clayvon'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Clayvon Rooster Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_rr_clayvon.png',
  information: '(C1) 9/8. Ultra Rare!',
  collectible: true,
};

itemList['toy_rr_sven'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Sven Rooster Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_rr_sven.png',
  information: '(C1) 10/8. Ultra Rare!',
  collectible: true,
};

itemList['toy_rr_donnie'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Donnie Rooster Toy',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_toys_rr_donnie.png',
  information: '(C1) 11/8. Ultra Rare!',
  collectible: true,
};

itemList['safecrackingkit'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Safe Cracking Tool',
  craft: [],
  price: 500,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_safecrackingkit.png',
  information: 'Marked for police seizure.',
};

itemList['lvaccesscodes'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Lower Vault Access Codes',
  craft: [],
  price: 500,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_receipt.png',
  information: 'Marked for police seizure.',
};

itemList['casinocaseaccesshalf'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Casino Access Codes: First Half',
  craft: [],
  price: 500,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_receipt.png',
  information: '658756',
};

itemList['casinocaseaccesshalfsecond'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Casino Access Codes: Second Half',
  craft: [],
  price: 500,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_receipt.png',
  information: '1',
};

itemList['gag_sock'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Gag',
  craft: [],
  price: 500,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_sock.png',
  information: 'When they talk too much.',
};

itemList['ivotedsticker'] = {
  fullyDegrades: true,
  decayrate: 0.25,
  displayname: 'I voted!',
  craft: [],
  price: 500,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_voted_sticker.png',
  information: '',
};

itemList['emptyballoon'] = {
  fullyDegrades: true,
  decayrate: 0.0,
  displayname: 'Empty Balloon',
  craft: [],
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_emptyballoon.png',
  information: 'This balloon is empty and flasid.',
};

itemList['nosballoon'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Balloon',
  craft: [],
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_balloon.png',
  information: 'Inflated balloon.',
};

//Buddha quest items
itemList['buddhaletter'] = {
  fullyDegrades: true,
  decayrate: 0.0,
  displayname: 'Letter',
  craft: [],
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_buddha_letter.png',
  information: 'The letter has a rooster seal on it.',
};

itemList['buddhamedalion'] = {
  fullyDegrades: true,
  decayrate: 0.0,
  displayname: 'Medallion',
  craft: [],
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_buddha_medalion.png',
  information: 'Touching the medallion makes your fingers tingle.',
};

itemList['buddhashovel'] = {
  fullyDegrades: true,
  decayrate: 0.0,
  displayname: 'Shovel',
  craft: [],
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_buddha_shovel.png',
  information: 'This is a shovel. What else do you want from me?',
};

itemList['buddhablade'] = {
  fullyDegrades: true,
  decayrate: 0.0,
  displayname: 'Sword Blade',
  craft: [],
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_buddha_blade.png',
  information: 'The blade of a sword.',
};

itemList['buddhaguard'] = {
  fullyDegrades: true,
  decayrate: 0.0,
  displayname: 'Sword Guard',
  craft: [],
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_buddha_guard.png',
  information: 'The guard of a sword.',
};

itemList['buddhahilt'] = {
  fullyDegrades: true,
  decayrate: 0.0,
  displayname: 'Sword Hilt',
  craft: [],
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_buddha_hilt.png',
  information: 'The hilt of a sword.',
};

itemList['contractortape'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Contractor Tape',
  craft: [],
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_news_tape.png',
  information: 'A tape showing what Dark Construction Industries LLC can construct for you if you choose them as the mansion contractor.',
};

itemList['bobmulet_scrunchie'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'Mulet Scrunchie',
  price: 25,
  weight: 1,
  craft: [[
    { itemid: 'plastic', amount: 2 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_bobmulet_scrunchie.png',
  information: 'Scrunchie by Bob Mulet',
};

itemList['bobmulet_hairspray'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'Mulet Hair Spray',
  price: 25,
  weight: 1,
  craft: [[
    { itemid: 'plastic', amount: 20 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_bobmulet_hairspray.png',
  information: 'Hair Spray by Bob Mulet - 10 Uses',
};

itemList['bobmulet_soap'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'Mulet Soap',
  price: 25,
  weight: 1,
  craft: [[
    { itemid: 'glass', amount: 15 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_bobmulet_soap.png',
  information: 'Soap by Bob Mulet',
};

itemList['bobmulet_chapstick'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'Mulet Chapstick',
  price: 25,
  weight: 1,
  craft: [[
    { itemid: 'plastic', amount: 15 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_bobmulet_chapstick.png',
  information: 'Chapstick by Bob Mulet',
};

itemList['bobmulet_cocoabutter'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'Mulet Cocoa Butter',
  price: 25,
  weight: 1,
  craft: [[
    { itemid: 'plastic', amount: 20 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_bobmulet_cocoabutter.png',
  information: 'Cocoa Butter by Bob Mulet',
};

itemList['dab_lambo'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Yung Dabs Lambo',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_lambocube.png',
  information: 'Yung Dab used to drive this.. Now it is just a cube.',
};

itemList['dab_gun'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Yung Dabs Gun',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_sns-pistol.png',
  information: 'Gun given to Siz by Yung Dab.',
};

//Vehicle Boosting Items
itemList['trackerdisabler'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Tracker Disabling Tool',
  craft: [[
    { itemid: 'copper', amount: 150 },
    { itemid: 'glass', amount: 150 },
    { itemid: 'electronics', amount: 150 },
    { itemid: 'aluminium', amount: 150 },
  ]],
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_disabler.png',
  information: 'Plug this in and keep moving.',
};

itemList['pixellaptop'] = {
  fullyDegrades: true,
  decayrate: 0.46,
  displayname: 'Pixel Laptop',
  craft: [[
    { itemid: 'genericelectronicpart', amount: 92 },
  ]],
  price: 7000,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_pixellaptop.png',
  information: 'Pixel 3 (os) 3.0.69',
};

itemList['tempcertificate'] = {
  fullyDegrades: false,
  decayrate: 0,
  displayname: 'Temp Certificate',
  price: 0,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_hf_certificate.png',
  information: 'A temporary certificate to allow hunting or fishing for an individual',
};

itemList['boxinggloves'] = {
  fullyDegrades: false,
  decayrate: 0,
  displayname: 'Boxing Gloves',
  price: 0,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_boxing_gloves.png',
  information: '16oz 90% Pixel Gloves',
};

// Nerd Crafting Shit

// Will remove blood / casings from a crime scene

itemList['gatheringkit'] = {
  fullyDegrades: false,
  decayrate: 0.25,
  displayname: 'Detective Kit',
  price: 1500,
  weight: 15,
  craft: [[
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 100 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_cleaning-goods.png',
  information: 'Used to gather evidence - should be seized by police if suspected of use in crime.',
};

itemList['weapon_silencer_pistol'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'Pistol Suppressor',
  price: 1500,
  weight: 15,
  craft: [[
    { itemid: 'copper', amount: 50 },
    { itemid: 'rubber', amount: 50 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_ssilencer.png',
  information: 'A silencer designed for use on some pistols.',
};

itemList['weapon_oil_silencer'] = {
  fullyDegrades: false,
  decayrate: 0.1,
  displayname: 'Oil Filter',
  price: 500,
  weight: 15,
  craft: [
    [
      { itemid: 'aluminium', amount: 30 },
      { itemid: 'steel', amount: 30 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 5 },
      { itemid: 'refinedsteel', amount: 5 },
    ]
  ],
  nonStack: false,
  model: '',
  image: 'np_oil_can_supp.png',
  information: 'Old, used oil filter. Do not seem to last long.',
};

itemList['weapon_silencer_assault'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'Rifle Suppressor',
  price: 1500,
  weight: 15,
  craft: [[
    { itemid: 'copper', amount: 110 },
    { itemid: 'rubber', amount: 110 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_silencerbig.png',
  information: 'Silencer designed for use on some rifles.',
};


itemList['weapon_scope'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Weapon Optics',
  price: 1500,
  weight: 15,
  craft: [[
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 100 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_lscope.png',
  information: 'Scope designed for use on some weapons.',
};

// UZI attachments
itemList['weapon_uzi_extended'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'UZI extended mag',
  price: 1500,
  weight: 15,
  craft: [
    [
      { itemid: 'aluminium', amount: 80 },
      { itemid: 'steel', amount: 80 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 20 },
      { itemid: 'refinedsteel', amount: 20 },
    ]
  ],
  nonStack: false,
  model: '',
  image: 'np_uzi_extended.png',
  information: 'Will only fit on the UZI.',
};

itemList['weapon_uzi_foldstock'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'UZI Stock',
  price: 1500,
  weight: 5,
  craft: [
    [
      { itemid: 'aluminium', amount: 40 },
      { itemid: 'rubber', amount: 40 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 10 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  nonStack: false,
  model: '',
  image: 'np_uzi_fold_stock.png',
  information: 'Will only fit on the UZI.',
};

itemList['weapon_uzi_woodstock'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'UZI Wooden Stock',
  price: 1500,
  weight: 5,
  craft: [
    [
      { itemid: 'aluminium', amount: 40 },
      { itemid: 'rubber', amount: 40 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 10 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  nonStack: false,
  model: '',
  image: 'np_uzi_wooden_stock.png',
  information: 'Will only fit on the UZI.',
};

itemList['2343591895'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Flash Light',
  price: 250,
  weight: 11,
  nonStack: true,
  blockScrap: true,
  craft: [[
    { itemid: 'copper', amount: 500 },
    { itemid: 'rubber', amount: 50 },
  ]],
  model: '',
  image: 'np_flashlight.png',
  weapon: true,
};



itemList['-1312131151'] = {
  fullyDegrades: false,
  decayrate: 4.0,
  displayname: 'Rocket Launcher',
  price: 1500,
  weight: 15,
  craft: [[
    { itemid: 'plastic', amount: 2300 },
    { itemid: 'rubber', amount: 2000 },
    { itemid: 'copper', amount: 2500 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_rocketlauncher.png',
  information: 'Accuracy may vary',
  weapon: true,
};

itemList['1672152130'] = {
  fullyDegrades: false,
  decayrate: 4.0,
  displayname: 'Homing Launcher',
  price: 1500,
  weight: 15,
  craft: [[
    { itemid: 'plastic', amount: 2300 },
    { itemid: 'rubber', amount: 2000 },
    { itemid: 'copper', amount: 2500 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_homing-launcher.png',
  information: 'Ground-To-Air active radar homing missile launcher',
  weapon: true,
};

itemList['rpgammo'] = {
  fullyDegrades: true,
  decayrate: 4.0,
  displayname: 'RPG',
  craft: [[
    { itemid: 'aluminium', amount: 150 },
    { itemid: 'plastic', amount: 150 },
    { itemid: 'rubber', amount: 150 },
  ]],
  price: 10,
  weight: 30,
  nonStack: false,
  model: '',
  image: 'np_rpgammo.png',
};

itemList['homingammo'] = {
  fullyDegrades: true,
  decayrate: 4.0,
  displayname: 'Homing Launcher Ammo',
  craft: [[
    { itemid: 'aluminium', amount: 150 },
    { itemid: 'plastic', amount: 150 },
    { itemid: 'rubber', amount: 150 },
  ]],
  price: 10,
  weight: 30,
  nonStack: false,
  model: '',
  image: 'np_rpgammo.png',
};

itemList['miningprobe'] = {
  fullyDegrades: true,
  decayrate: 0.00277,
  displayname: 'Mining Probe',
  craft: [],
  price: 0,
  weight: 20,
  nonStack: false,
  model: '',
  image: 'np_metaldetector.png',
};

itemList['miningpickaxe'] = {
  fullyDegrades: true,
  decayrate: 0.00277,
  displayname: 'Mining Pickaxe',
  craft: [],
  price: 0,
  weight: 20,
  nonStack: false,
  model: '',
  image: 'np_pickaxe.png',
};

itemList['metaldetector1'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'NPX 200',
  craft: [
    [
      { itemid: 'refinedaluminium', amount: 10 },
    ]
  ],
  price: 800,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_metaldetector2.png',
};

itemList['metaldetector2'] = {
  fullyDegrades: true,
  decayrate: 0.6,
  displayname: 'NPX 500',
  craft: [
    [
      { itemid: 'refinedaluminium', amount: 5 },
      { itemid: 'refinedcopper', amount: 12 },
      { itemid: 'refinedrubber', amount: 11 },
      { itemid: 'refinedplastic', amount: 10 },
    ]
  ],
  price: 2000,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_metaldetector2.png',
};

itemList['metaldetector3'] = {
  fullyDegrades: true,
  decayrate: 0.4,
  displayname: 'NPX 1000 Pro',
  craft: [
    [
      { itemid: 'refinedaluminium', amount: 25 },
      { itemid: 'refinedcopper', amount: 35 },
      { itemid: 'refinedrubber', amount: 15 },
      { itemid: 'refinedplastic', amount: 25 },
    ]
  ],
  price: 5000,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_metaldetector2.png',
};

itemList['trowel'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Trowel',
  craft: [],
  price: 400,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_trowel.png',
};

itemList['powertrowel'] = {
  fullyDegrades: true,
  decayrate: 0.004155,
  displayname: 'Power Trowel',
  craft: [],
  price: 400,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_trowel.png',
};

itemList['book'] = {
  _name: 'book',
  fullyDegrades: false,
  decayrate: 3.0,
  displayname: 'Book',
  craft: [],
  price: 400,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'closed-book.png',
};

itemList['paper'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Paper',
  craft: [],
  price: 25,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'paper.png',
};


itemList['pdevidencebag'] = {
  fullyDegrades: false,
  decayrate: 0,
  displayname: 'Evidence Bag',
  price: 10,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_evidence_bag.png',
};

itemList['smallcrate'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Small Mobile Crate',
  craft: [
    [
      { itemid: 'scrapmetal', amount: 160 },
      { itemid: 'plastic', amount: 40 },
      { itemid: 'rubber', amount: 40 },
    ],
    [
      { itemid: 'refinedscrap', amount: 40 },
      { itemid: 'refinedplastic', amount: 10 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  price: 100,
  weight: 25,
  nonStack: false,
  model: '',
  image: 'np_supplycrate_small.png',
};

itemList['mediumcrate'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Medium Mobile Crate',
  craft: [
    [
      { itemid: 'scrapmetal', amount: 320 },
      { itemid: 'plastic', amount: 80 },
      { itemid: 'rubber', amount: 80 },
    ],
    [
      { itemid: 'refinedscrap', amount: 80 },
      { itemid: 'refinedplastic', amount: 20 },
      { itemid: 'refinedrubber', amount: 20 },
    ]
  ],
  price: 100,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_supplycrate_medium.png',
};

itemList['bigcrate'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Big Mobile Crate',
  craft: [
    [
      { itemid: 'scrapmetal', amount: 480 },
      { itemid: 'plastic', amount: 120 },
      { itemid: 'rubber', amount: 120 },
    ],
    [
      { itemid: 'refinedscrap', amount: 120 },
      { itemid: 'refinedplastic', amount: 30 },
      { itemid: 'refinedrubber', amount: 30 },
    ]
  ],
  price: 100,
  weight: 100,
  nonStack: false,
  model: '',
  image: 'np_supplycrate_large.png',
};

itemList['vu_towel_yellow'] = {
  fullyDegrades: true,
  decayrate: 0.001385,
  displayname: 'Yellow VU Towel',
  price: 2,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_vu_towel_yellow.png',
};

itemList['vu_towel_purple'] = {
  fullyDegrades: true,
  decayrate: 0.001385,
  displayname: 'Purple VU Towel',
  price: 2,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_vu_towel_purple.png',
};

itemList['vu_towel_green'] = {
  fullyDegrades: true,
  decayrate: 0.001385,
  displayname: 'Green VU Towel',
  price: 2,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_vu_towel_green.png',
};

itemList['carpolish_high'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Excellent car polish',
  craft: [[
    { itemid: 'beeswax', amount: 4 },
    { itemid: 'water', amount: 4 },
    { itemid: 'plastic', amount: 8 },
  ]],
  price: 1,
  weight: 3.0,
  nonStack: false,
  model: '',
  image: 'np_carpolish_high.png',
  information: 'Keep that car sparkling clean, dawg.',
};

itemList['carpolish_medium'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Car Polish',
  craft: [[
    { itemid: 'beeswax', amount: 2 },
    { itemid: 'water', amount: 2 },
    { itemid: 'plastic', amount: 4 },
  ]],
  price: 1,
  weight: 2.0,
  nonStack: false,
  model: '',
  image: 'np_carpolish_medium.png',
  information: 'Keep that car clean, I guess.',
};

itemList['carpolish_low'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: 'Lard, the car polish',
  craft: [[
    { itemid: 'animal_lard', amount: 1 },
    { itemid: 'water', amount: 1 },
    { itemid: 'plastic', amount: 2 },
  ]],
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_carpolish_low.png',
  information: 'At least you tried.',
};

itemList['animal_lard'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: 'Animal Lard',
  craft: [],
  price: 1,
  weight: 5.0,
  nonStack: false,
  model: '',
  image: 'np_lard.png',
  information: 'Very greasy, lol.',
};

itemList['prisonlauncher'] = {
  fullyDegrades: false,
  decayrate: 0.025,
  displayname: 'Potato Launcher',
  price: 1,
  weight: 30,
  craft: [],
  nonStack: true,
  model: '',
  image: 'np_potatolauncher.png',
  information: 'Shoddily assembled from scraps, how did you smuggle this past the guards anyways?',
};

itemList['launcherpouch'] = {
  fullyDegrades: false,
  decayrate: 0.01,
  displayname: 'Canister',
  price: 1,
  weight: 11,
  craft: [],
  nonStack: true,
  model: '',
  image: 'np_hairspray.png',
  information: 'Feels empty? Maybe you could put stuff inside.',
};

itemList['ketamine'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Special K',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ketamine_baggie.png',
  information: 'Yummy Cereal',
  contraband: true,
};

itemList['cleaningproduct1'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Cleaning Product',
  price: 50,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_bakingsoda.png',
  information: 'Cleans n shit yo',
};

itemList['cleaningproduct2'] = {
  fullyDegrades: true,
  decayrate: 0.03,
  displayname: 'Cleaning Product',
  price: 50,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cleaningproduct.png',
  information: 'Cleans n shit yo',
};

itemList['cleaningproduct3'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Cleaning Product',
  price: 50,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cleaningproduct2.png',
  information: 'Cleans n shit yo',
};

itemList['floor_cleaner'] = {
  fullyDegrades: true,
  decayrate: 0.01,
  displayname: 'Floor Cleaner',
  price: 50,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_cleaningproduct2.png',
  information: 'Cleans the floors n shit',
};

itemList['boxscraps'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Box of Scraps',
  price: 1,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_scrapbox.png',
  information: 'Its filled to the brim with useless scraps',
};

itemList['pvcpipe'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'PVC Piping',
  price: 1,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_pvc_pipe.png',
  information: 'Seems useful',
};

itemList['pvcjoint'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'PVC Pipe Joint',
  price: 1,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_pvc_joint.png',
  information: 'Seems useful',
};

itemList['pvcvalve'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'PVC Valve',
  price: 1,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_pvc_valve.png',
  information: 'Seems useful',
};

itemList['hydroxylimine'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Mysterious Powder',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ketamine_powder.png',
  information: 'C13H16ClNO - HCl',
  contraband: true,
};

itemList['chlorophenyl'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Mixed Powder',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_ketamine_powder.png',
  information: 'C12H13ClO',
  contraband: true,
};

itemList['prospectingdevice'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Scanning Device',
  price: 750,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_digi_scanner.png',
  information: 'Scans an area for a special object',
};

itemList['hqparts'] = {
  fullyDegrades: true,
  decayrate: 10,
  displayname: 'HQ Car Parts',
  craft: [[
    { itemid: 'refinedaluminium', amount: 15 },
    { itemid: 'refinedsteel', amount: 15 },
    { itemid: 'refinedglass', amount: 15 },
    { itemid: 'refinedrubber', amount: 15 },
    { itemid: 'refinedcopper', amount: 15 }
  ]],
  price: 750,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_hqparts.png',
  information: "Meta-gamed in minutes.",
};



itemList['scraptoolset'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Scrap ToolKit',
  craft: [[{ itemid: 'electronics', amount: 10 }]],
  price: 100,
  weight: 100,
  nonStack: false,
  model: '',
  image: 'np_repair-toolkit.png',
  information: 'Hehe.',
};


itemList['cryptostick4'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'GNE Stick',
  craft: [[
    { itemid: 'refinedaluminium', amount: 1 },
  ]],
  price: 750,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cryptostick.png',
  information: "Contains 10GNE. Somehow more valuable than DOGE",
};

itemList['cryptostick5'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'GNE Stick',
  craft: [[
    { itemid: 'refinedaluminium', amount: 1 },
  ]],
  price: 750,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cryptostick.png',
  information: "Contains 25GNE. Somehow more valuable than DOGE",
};

itemList['cryptostick1'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'GNE Stick',
  craft: [[
    { itemid: 'refinedaluminium', amount: 1 },
  ]],
  price: 750,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_cryptostick.png',
  information: "Contains 50GNE. Somehow more valuable than DOGE",
};

itemList['cryptostick2'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'GNE Stick',
  craft: [[
    { itemid: 'refinedaluminium', amount: 1 },
  ]],
  price: 750,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_cryptostick.png',
  information: "Contains 100GNE. Somehow more valuable than DOGE",
};

itemList['cryptostick3'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'GNE Stick',
  craft: [[
    { itemid: 'refinedaluminium', amount: 1 },
  ]],
  price: 750,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_cryptostick.png',
  information: "Contains 250GNE. Somehow more valuable than DOGE",
};

itemList['turbokit'] = {
  fullyDegrades: false,
  decayrate: 2,
  displayname: 'Quality Turbo Parts',
  craft: [[
    { itemid: 'brokendownhqparts', amount: 1 },
    { itemid: 'refinedcopper', amount: 5 },
  ]],
  price: 750,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_vehicle_part.png',
  engineParts: true,
  information: "Turbo, might need repairs to fully function!",
};

itemList['enginekit'] = {
  fullyDegrades: false,
  decayrate: 2,
  displayname: 'Quality Engine Parts',
  craft: [[
    { itemid: 'brokendownhqparts', amount: 1 },
    { itemid: 'refinedsteel', amount: 5 },
  ]],
  price: 750,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_vehicle_part.png',
  engineParts: true,
  information: "Looks like some engine parts, might need repairs to fully function!",
};

itemList['transmissionkit'] = {
  fullyDegrades: false,
  decayrate: 2,
  displayname: 'Quality Transmission Parts',
  craft: [[
    { itemid: 'brokendownhqparts', amount: 1 },
    { itemid: 'refinedaluminium', amount: 5 },
  ]],
  price: 750,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_vehicle_part.png',
  engineParts: true,
  information: "Transmission Parts, might need repairs to fully function!",
};

itemList['brakingkit'] = {
  fullyDegrades: false,
  decayrate: 2,
  displayname: 'Quality Braking Parts',
  craft: [[
    { itemid: 'brokendownhqparts', amount: 1 },
    { itemid: 'refinedrubber', amount: 5 },
  ]],
  price: 750,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_vehicle_part.png',
  engineParts: true,
  information: "Transmission Parts, might need repairs to fully function!",
};

itemList['suspensionkit'] = {
  fullyDegrades: false,
  decayrate: 2,
  displayname: 'Quality Suspension Parts',
  craft: [[
    { itemid: 'brokendownhqparts', amount: 1 },
    { itemid: 'refinedplastic', amount: 5 },
  ]],
  price: 750,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_vehicle_part.png',
  engineParts: true,
  information: "Transmission Parts, might need repairs to fully function!",
};

itemList['enginebay'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Placeholder Item',
  craft: [[]],
  price: 0,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_vehicle_part.png',
  information: "Hey, dont touch this!",
  whitelist: [
    "engineParts"
  ],
};

itemList['brokendownhqparts'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Repair Parts',
  price: 750,
  craft: [[
    { itemid: 'hqparts', amount: 0.2 },
  ]],
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_clutch.png',
  information: "Used to repair upgrades on certain vehicles.",
};

itemList['turbotempkit'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Disposable Turbo Kit',
  price: 750,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_vehicle_part.png',
  information: "DIY Disposable Tunning Kit, try to not be too rough with it! (LOCAL CARS ONLY)",
};

itemList['enginetempkit'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Disposable Engine Tuning Kit',
  price: 750,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_vehicle_part.png',
  information: "DIY Disposable Tuning Kit, try to not be too rough with it! (LOCAL CARS ONLY)",
};

itemList['transmissiontempkit'] = {
  fullyDegrades: true,
  decayrate: 2,
  displayname: 'Disposable Transmission Kit',
  price: 750,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_vehicle_part.png',
  information: "DIY Disposable Tunning Kit, try to not be too rough with it! (LOCAL CARS ONLY)",
};

itemList['paint_thinner'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Paint thinner',
  craft: [],
  price: 4000,
  weight: 20.0,
  nonStack: false,
  model: '',
  image: 'np_paint_thinner.png',
  information: 'Thin out some paint',
};

itemList['paint_stripper'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Paint stripper',
  craft: [],
  price: 0,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_paint_stripper.png',
  information: 'Clean up some paint yo',
};

itemList['refinedaluminium'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Refined Aluminium",
  craft: [[
    { itemid: 'aluminium', amount: 3 },
  ]],
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_refined_aluminium.png',
  information: 'Refined Aluminium.',
};

itemList['refinedcopper'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Refined Copper",
  craft: [[
    { itemid: 'copper', amount: 3 },
  ]],
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_refined_copper.png',
  information: 'Refined Copper.',
};

itemList['refinedglass'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Refined Glass",
  craft: [[
    { itemid: 'glass', amount: 3 },
  ]],
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_refined_glass.png',
  information: 'Refined Glass.',
};

itemList['refinedplastic'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Refined Plastic",
  craft: [[
    { itemid: 'plastic', amount: 3 },
  ]],
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_refined_plastic.png',
  information: 'Refined Plastic.',
};

itemList['refinedrubber'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Refined Rubber",
  craft: [[
    { itemid: 'rubber', amount: 3 },
  ]],
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_refined_rubber.png',
  information: 'Refined Rubber.',
};

itemList['refinedscrap'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Refined Scrap",
  craft: [[
    { itemid: 'scrapmetal', amount: 3 },
  ]],
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_refined_scrap.png',
  information: 'Refined Scrap.',
};

itemList['refinedsteel'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Refined Steel",
  craft: [[
    { itemid: 'steel', amount: 3 },
  ]],
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_refined_steel.png',
  information: 'Refined Steel.',
};

itemList['beehive'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: 'Beehive',
  craft: [],
  price: 150,
  weight: 150.0,
  nonStack: false,
  model: '',
  image: 'np_beehive.png',
  information: 'Bzzzzz.',
};

itemList['beequeen'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: 'Bee Queen',
  craft: [],
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_bee_queen.png',
  information: 'Bzzzzz.',
};

itemList['beeswax'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Bee's wax",
  craft: [],
  price: 1,
  weight: 5.0,
  nonStack: false,
  model: '',
  image: 'np_bees_wax.png',
  information: 'Bzzzzz.',
};

itemList['honey'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Honey",
  craft: [],
  price: 1,
  weight: 2.0,
  nonStack: false,
  model: '',
  image: 'np_honey.png',
  information: 'Slurp.',
  foodCategory: ['sugar'],
  foodEnhancement: 0.6,
  foodEnhancementFromMeta: false,
};

itemList['golfball'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: "Golf Ball",
  craft: [],
  price: 50,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_golf_ball_white.png',
  information: 'White',
};

itemList['golfballpink'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: "Golf Ball",
  craft: [],
  price: 50,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_golf_ball_pink.png',
  information: 'Pink',
};

itemList['golfballorange'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: "Golf Ball",
  craft: [],
  price: 50,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_golf_ball_orange.png',
  information: 'Orange',
};

itemList['golfballyellow'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: "Golf Ball",
  craft: [],
  price: 50,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_golf_ball_yellow.png',
  information: 'Yellow',
};

itemList['golftee'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: "Golf Tee",
  craft: [],
  price: 10,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_golf_tee.png',
  information: 'Tee to place them balls on.',
};

itemList['golfclubdriver'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: "Golf Club",
  craft: [],
  price: 300,
  weight: 3.0,
  nonStack: true,
  model: '',
  image: 'np_golf_driver.png',
  information: 'Driver',
};

itemList['golfclubwood'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: "Golf Club",
  craft: [],
  price: 250,
  weight: 3.0,
  nonStack: true,
  model: '',
  image: 'np_golf_wood.png',
  information: 'Wood',
};

itemList['golfclubiron'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: "Golf Club",
  craft: [],
  price: 200,
  weight: 3.0,
  nonStack: true,
  model: '',
  image: 'np_golf_iron.png',
  information: 'Iron',
};

itemList['golfclubwedge'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: "Golf Club",
  craft: [],
  price: 150,
  weight: 3.0,
  nonStack: true,
  model: '',
  image: 'np_golf_pitcher.png',
  information: 'Wedge',
};

itemList['golfclubputter'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: "Golf Club",
  craft: [],
  price: 100,
  weight: 3.0,
  nonStack: true,
  model: '',
  image: 'np_golf_putter.png',
  information: 'Putter',
};

itemList['golfballpack'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'White Golf Ball Pack',
  price: 1000,
  weight: 20.0,
  nonStack: true,
  model: '',
  image: 'np_golf_ball_pack.png',
  information: 'A pack of white golf balls.',
};

itemList['golfballpackpink'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Pink Golf Ball Pack',
  price: 1000,
  weight: 20.0,
  nonStack: true,
  model: '',
  image: 'np_golf_ball_pack_p.png',
  information: 'A pack of pink golf balls.',
};

itemList['golfballpackorange'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Orange Golf Ball Pack',
  price: 1000,
  weight: 20.0,
  nonStack: true,
  model: '',
  image: 'np_golf_ball_pack_o.png',
  information: 'A pack of orange golf balls.',
};

itemList['golfballpackyellow'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Yellow Golf Ball Pack',
  price: 1000,
  weight: 20.0,
  nonStack: true,
  model: '',
  image: 'np_golf_ball_pack_y.png',
  information: 'A pack of yellow golf balls.',
};

itemList['dodopackagesmall'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Dodo Small Package',
  price: 1,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_dodobox1.png',
  information: 'Store various products in this packaging!',
};

itemList['dodopackagemedium'] = {
  fullyDegrades: true,
  decayrate: 0.133,
  displayname: 'Dodo Medium Package',
  price: 1,
  weight: 85,
  nonStack: true,
  model: '',
  image: 'np_dodobox2.png',
  information: 'Store various products in this packaging!',
};

itemList['dodopackagelarge'] = {
  fullyDegrades: true,
  decayrate: 0.133,
  displayname: 'Dodo Large Package',
  price: 1,
  weight: 120,
  nonStack: true,
  model: '',
  image: 'np_dodobox3.png',
  information: 'Store various products in this packaging!',
};

itemList['lawnchair'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lawn Chair',
  price: 100,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_props_lawnchair.png',
  information: 'Get off my lawn!',
};

itemList['lawnchair2'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Lawn Chair',
  price: 100,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_props_lawnchair2.png',
  information: 'Get off my lawn!',
};

itemList['woodbench'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Wooden Bench',
  price: 100,
  weight: 0,
  nonStack: true,
  craft: [[
    { itemid: 'woodforbench', amount: 10 },
  ]],
  model: '',
  image: 'np_props_woodbench.png',
  information: 'A bench.',
};

itemList['woodbench2'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Wooden Bench',
  price: 100,
  weight: 0,
  nonStack: true,
  craft: [[
    { itemid: 'woodforbench', amount: 10 },
    { itemid: 'woodsaw', amount: 1 },
  ]],
  model: '',
  image: 'np_props_woodbench_2.png',
  information: 'A bench.',
};

itemList['stonebench'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Stone Bench',
  price: 100,
  weight: 0,
  nonStack: true,
  craft: [[
    { itemid: 'stoneforbench', amount: 10 },
  ]],
  model: '',
  image: 'np_props_stonebench.png',
  information: 'A bench. Should be heavy!',
};

itemList['stonebench2'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Stone Bench',
  price: 100,
  weight: 0,
  nonStack: true,
  craft: [[
    { itemid: 'stoneforbench', amount: 20 },
    { itemid: 'stonechisel', amount: 1 },
  ]],
  model: '',
  image: 'np_props_stonebench_2.png',
  information: 'A bench. Should be heavy!',
};


itemList['metalbench'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Metal Bench',
  price: 100,
  weight: 0,
  craft: [[
    { itemid: 'metalforbench', amount: 10 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_props_metalbench.png',
  information: 'A bench. Lightweight and durable, made to last.',
};

itemList['metalbench2'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Metal Bench',
  price: 100,
  weight: 0,
  craft: [[
    { itemid: 'metalforbench', amount: 20 },
    { itemid: 'metalshaper', amount: 1 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_props_snowbench.png',
  information: 'A bench. Lightweight and durable, made to last.',
};

itemList['woodforbench'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Wood from Benches',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_props_woodbench.png',
  information: '',
};

itemList['stoneforbench'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Stone from Benches',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_props_stonebench.png',
  information: '',
};

itemList['metalforbench'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Metal from Benches',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_props_metalbench.png',
  information: '',
};

itemList['stonechisel'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Chisel',
  price: 100,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_chisel.png',
  information: 'Used for stone.',
};

itemList['metalshaper'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Shaper',
  price: 100,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_shaper.png',
  information: 'Used for metal.',
};

itemList['woodsaw'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Saw',
  price: 100,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_saw.png',
  information: 'Used for wood.',
};

itemList['pailshovel'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pail and Shovel',
  price: 100,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_props_pail_shovel.png',
  information: 'Sand sold separately.',
};

itemList['stopsign'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Stop Sign',
  price: 1,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_props_stop_sign.png',
  information: 'Where did you get this?!',
};

itemList['usedbattery'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Used Battery',
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_used_battery.png',
};

// Bowling Items
itemList['bowlingball'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: "Bowling Ball",
  craft: [],
  price: 50,
  weight: 8,
  nonStack: true,
  model: '',
  image: 'np_bowling_ball.png',
  information: 'Dont throw it too hard',
};

itemList['bowlingreceipt'] = {
  fullyDegrades: true,
  decayrate: 0.0007440464,
  displayname: 'Bowling Receipt',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_receipt.png',
  information: 'The number on the receipt tells you what lane you can use.',
};

// GEMANJI START
itemList['gemanjicompass'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Compass',
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  information: 'Find your way!',
  image: 'np_gemanji_compass.png',
};
itemList['gemanjiluggage'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Chaunceys Luggage',
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  information: 'Contains something of value.',
  image: 'np_gemanji_gembag.png',
};
itemList['gemanjipouch'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Onyx Pouch',
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  information: 'Contains something of value.',
  image: 'np_gemanji_gembag.png',
};
itemList['gemanjitrowel'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Trowel',
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  information: 'Used to dig for antidotes!',
  image: 'np_trowel.png',
};
itemList['gemanjiingred1'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Enchanted Fern',
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  information: 'Antidote Ingredient',
  image: 'np_gemanji_antidote1.png',
};
itemList['gemanjiingred2'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Hypnotic Soil',
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  information: 'Antidote Ingredient',
  image: 'np_gemanji_antidote2.png',
};
itemList['gemanjiantidote'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cow Remedy',
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  information: '',
  image: 'np_gemanji_antidote.png',
};
itemList['gemanjieffect'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Dream Liqour',
  price: 10,
  weight: 1,
  nonStack: false,
  model: '',
  information: '',
  image: 'np_gemanji_antidote.png',
};
itemList['gemanjiend'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Final Instructions',
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  information: 'In order to achieve that which you seek, you must look up and ascend to the highest peek. Upon finding me, shout my name.',
  image: 'np_receipt.png',
};
itemList['portalopener'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Infused Onyx Gem',
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  information: 'Use this to open an Onyx portal.',
  image: 'np_onyx_portal.png',
};
itemList['onyxgems'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Onyx Gems',
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  information: 'Can you feel what has been and what is yet to be?',
  image: 'np_onyx_gem.png',
};
itemList['onyxshard'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pure Onyx Crystals',
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  information: 'Not of this world. Not of this time.',
  image: 'np_onyx_shard.png',
};
itemList['onyxdust'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Onyx Dust',
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  information: 'All that remains of travellers past. Yet they may still need to make their journey.',
  image: 'np_onyx_dust.png',
};
// GEMANJI END

itemList['smallcontainer'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Small Mobile Container',
  price: 100,
  weight: 25,
  craft: [
    [
      { itemid: 'aluminium', amount: 400 },
      { itemid: 'steel', amount: 400 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 90 },
      { itemid: 'refinedsteel', amount: 90 },
    ]
  ],
  nonStack: false,
  model: '',
  image: 'np_container_s.png',
};

itemList['mediumcontainer'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Medium Mobile Container',
  price: 100,
  weight: 50,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'steel', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 110 },
      { itemid: 'refinedsteel', amount: 110 },
    ]
  ],
  nonStack: false,
  model: '',
  image: 'np_container_m.png',
};

itemList['bigcontainer'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Big Mobile Container',
  price: 100,
  weight: 100,
  craft: [
    [
      { itemid: 'aluminium', amount: 600 },
      { itemid: 'steel', amount: 600 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 130 },
      { itemid: 'refinedsteel', amount: 130 },
    ]
  ],
  nonStack: false,
  model: '',
  image: 'np_container_l.png',
};

itemList['bodybagstash'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Body bag',
  price: 100,
  weight: 25,
  nonStack: false,
  model: '',
  image: 'np_bodybag.png',
};

itemList['detcord'] = {
  fullyDegrades: true,
  decayrate: 0.001385,
  displayname: 'Det. Cord',
  price: 50,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_detcord.png',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
};

itemList['mobilewatervendor'] = {
  fullyDegrades: true,
  decayrate: 0.001385,
  displayname: 'Mobile Water Vendor',
  price: 50,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_vending_soda_01.png',
  craft: [
    [
      { itemid: 'aluminium', amount: 125 },
      { itemid: 'steel', amount: 125 },
      { itemid: 'plastic', amount: 125 },
      { itemid: 'rubber', amount: 125 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 40 },
      { itemid: 'refinedsteel', amount: 40 },
      { itemid: 'refinedplastic', amount: 40 },
      { itemid: 'refinedrubber', amount: 40 },
    ]
  ],
  information: 'Place it down anywhere and have a drink!',
};

itemList['mobilefoodvendor'] = {
  fullyDegrades: true,
  decayrate: 0.001385,
  displayname: 'Mobile Food Vendor',
  price: 50,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_vending_snack.png',
  craft: [
    [
      { itemid: 'aluminium', amount: 125 },
      { itemid: 'steel', amount: 125 },
      { itemid: 'plastic', amount: 125 },
      { itemid: 'rubber', amount: 125 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 40 },
      { itemid: 'refinedsteel', amount: 40 },
      { itemid: 'refinedplastic', amount: 40 },
      { itemid: 'refinedrubber', amount: 40 },
    ]
  ],
  information: 'Place it down anywhere and have some food!',
};

itemList['mobileatm'] = {
  fullyDegrades: true,
  decayrate: 0.001385,
  displayname: 'Mobile ATM',
  price: 50,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_vending_atm.png',
  craft: [
    [
      { itemid: 'aluminium', amount: 125 },
      { itemid: 'steel', amount: 125 },
      { itemid: 'plastic', amount: 125 },
      { itemid: 'rubber', amount: 125 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 40 },
      { itemid: 'refinedsteel', amount: 40 },
      { itemid: 'refinedplastic', amount: 40 },
      { itemid: 'refinedrubber', amount: 40 },
    ]
  ],
  information: 'Get some cash from anywhere!',
};

itemList['mobilecratelock'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Padlock',
  price: 50,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_padlock.png',
  craft: [
    [
      { itemid: 'aluminium', amount: 60 },
      { itemid: 'steel', amount: 60 },
      { itemid: 'plastic', amount: 60 },
      { itemid: 'rubber', amount: 60 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 20 },
      { itemid: 'refinedsteel', amount: 20 },
      { itemid: 'refinedplastic', amount: 20 },
      { itemid: 'refinedrubber', amount: 20 },
    ]
  ],
  information: 'Seems to perfectly fit some crates',
};


itemList['mobilecratekey'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Padlock Key',
  price: 50,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_mobilecratekey.png',
  information: 'A key for some padlock.',
};

itemList['mobilecratekeylock'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Keypad',
  price: 50,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_mobilecratekeylock.png',
  information: 'A keypad for something.',
};

itemList['petaccessory'] = {
  _name: 'petaccessory',
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Pet Accessory',
  price: 100,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np-petcollar.png',
  information: "",
};

itemList['trapcrate'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Trap Crate',
  price: 100,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_supplycrate_medium.png',
};

itemList['smalltrapcrate'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Small Trap Crate',
  price: 100,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_supplycrate_small.png',
};

itemList['bigtrapcrate'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Big Trap Crate',
  price: 100,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_supplycrate_large.png',
};

itemList['sginvite'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'An Invite',
  price: 0,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_sg_invite.png',
  information: 'This is your invite. Do not give it to somebody else. Open it when you are ready.'
}

itemList['squidcoinheads'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Commemorative Coin',
  craft: [[
    { itemid: 'goldbar', amount: 4 },
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'copper', amount: 100 },
  ], [
    { itemid: 'goldbar', amount: 4 },
    { itemid: 'refinedaluminium', amount: 32 },
    { itemid: 'refinedcopper', amount: 32 },
  ]],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_octo_coin.png',
  information: 'Flip it!',
};

itemList['squidcoinboth'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Commemorative Coin',
  craft: [[
    { itemid: 'goldbar', amount: 4 },
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'copper', amount: 100 },
  ], [
    { itemid: 'goldbar', amount: 4 },
    { itemid: 'refinedaluminium', amount: 32 },
    { itemid: 'refinedcopper', amount: 32 },
  ]],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_octo_coin.png',
  information: 'Flip it!',
};

itemList['squid_marble'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Marble',
  price: 5,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_marble.png',
  information: 'A marble.',
};

itemList['surveyortool'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Surveying Device',
  price: 10,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_digi_scanner.png',
  information: 'Various tools for surveying.',
};

itemList['tent'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Tent',
  price: 1000,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_tent.png',
  information: 'Easy setup and teardown. (Placeable Object)',
};

itemList['resfooditem'] = {
  _name: 'resfooditem',
  fullyDegrades: true,
  decayrate: 0.04,
  displayname: 'Food',
  price: 5,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_sandwich.png',
  information: '',
};
itemList['ressideitem'] = {
  _name: 'ressideitem',
  fullyDegrades: true,
  decayrate: 0.04,
  displayname: 'Side',
  price: 5,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_wings.png',
  information: '',
};
itemList['resdessertitem'] = {
  _name: 'resdessertitem',
  fullyDegrades: true,
  decayrate: 0.04,
  displayname: 'Dessert',
  price: 5,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_donut.png',
  information: '',
};
itemList['resdrinkitem'] = {
  _name: 'resdrinkitem',
  fullyDegrades: true,
  decayrate: 0.04,
  displayname: 'Drink',
  price: 5,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_water.png',
  information: '',
};
itemList['resalcoholitem'] = {
  _name: 'resalcoholitem',
  fullyDegrades: true,
  decayrate: 0.04,
  displayname: 'Alcohol',
  price: 5,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_drink1.png',
};

itemList['agenericmechanicpart'] = {
  decayrate: 1.0,
  displayname: 'Mechanical Part (A)',
  price: 0,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_generic_mechanical_A.png',
  craft: [
    [{ itemid: 'aluminium', amount: 3 }],
    [{ itemid: 'refinedaluminium', amount: 1 }],
    [{ itemid: 'copper', amount: 3 }],
    [{ itemid: 'refinedcopper', amount: 1 }],
    [{ itemid: 'plastic', amount: 3 }],
    [{ itemid: 'refinedplastic', amount: 1 }],
    [{ itemid: 'rubber', amount: 3 }],
    [{ itemid: 'refinedrubber', amount: 1 }],
    [{ itemid: 'steel', amount: 3 }],
    [{ itemid: 'refinedsteel', amount: 1 }],
    [{ itemid: 'scrapmetal', amount: 3 }],
    [{ itemid: 'refinedscrap', amount: 1 }],
    [{ itemid: 'glass', amount: 3 }],
    [{ itemid: 'refinedglass', amount: 1 }],
    [{ itemid: 'electronics', amount: 3 }],
  ],
  information: '',
};

itemList['bgenericmechanicpart'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Mechanical Part (B)',
  price: 0,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_generic_mechanical_B.png',
  craft: [
    [{ itemid: 'aluminium', amount: 1 }],
    [{ itemid: 'copper', amount: 1 }],
    [{ itemid: 'plastic', amount: 1 }],
    [{ itemid: 'rubber', amount: 1 }],
    [{ itemid: 'steel', amount: 1 }],
    [{ itemid: 'scrapmetal', amount: 1 }],
    [{ itemid: 'glass', amount: 1 }],
    [{ itemid: 'electronics', amount: 1 }],
  ],
  information: '',
};

itemList['cgenericmechanicpart'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Mechanical Part (C)',
  price: 0,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_generic_mechanical_C.png',
  craft: [
    [{ itemid: 'aluminium', amount: 1 }],
    [{ itemid: 'copper', amount: 1 }],
    [{ itemid: 'plastic', amount: 1 }],
    [{ itemid: 'rubber', amount: 1 }],
    [{ itemid: 'steel', amount: 1 }],
    [{ itemid: 'scrapmetal', amount: 1 }],
    [{ itemid: 'glass', amount: 1 }],
    [{ itemid: 'electronics', amount: 1 }],
  ],
  information: '',
};

itemList['dgenericmechanicpart'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Mechanical Part (D)',
  price: 0,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_generic_mechanical_D.png',
  craft: [
    [{ itemid: 'aluminium', amount: 1 }],
    [{ itemid: 'copper', amount: 1 }],
    [{ itemid: 'plastic', amount: 1 }],
    [{ itemid: 'rubber', amount: 1 }],
    [{ itemid: 'steel', amount: 1 }],
    [{ itemid: 'scrapmetal', amount: 1 }],
    [{ itemid: 'glass', amount: 1 }],
    [{ itemid: 'electronics', amount: 1 }],
  ],
  information: '',
};

itemList['mgenericmechanicpart'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Mechanical Part (M)',
  price: 0,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_generic_mechanical_M.png',
  craft: [
    [{ itemid: 'aluminium', amount: 1 }],
    [{ itemid: 'copper', amount: 1 }],
    [{ itemid: 'plastic', amount: 1 }],
    [{ itemid: 'rubber', amount: 1 }],
    [{ itemid: 'steel', amount: 1 }],
    [{ itemid: 'scrapmetal', amount: 1 }],
    [{ itemid: 'glass', amount: 1 }],
    [{ itemid: 'electronics', amount: 1 }],
  ],
  information: '',
};

itemList['sgenericmechanicpart'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Mechanical Part (S)',
  price: 0,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_generic_mechanical_S.png',
  craft: [
    [{ itemid: 'aluminium', amount: 3 }],
    [{ itemid: 'refinedaluminium', amount: 1 }],
    [{ itemid: 'copper', amount: 3 }],
    [{ itemid: 'refinedcopper', amount: 1 }],
    [{ itemid: 'plastic', amount: 3 }],
    [{ itemid: 'refinedplastic', amount: 1 }],
    [{ itemid: 'rubber', amount: 3 }],
    [{ itemid: 'refinedrubber', amount: 1 }],
    [{ itemid: 'steel', amount: 3 }],
    [{ itemid: 'refinedsteel', amount: 1 }],
    [{ itemid: 'scrapmetal', amount: 3 }],
    [{ itemid: 'refinedscrap', amount: 1 }],
    [{ itemid: 'glass', amount: 3 }],
    [{ itemid: 'refinedglass', amount: 1 }],
    [{ itemid: 'electronics', amount: 3 }],
  ],
  information: '',
};

itemList['xgenericmechanicpart'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Mechanical Part (X)',
  price: 0,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_generic_mechanical_X.png',
  craft: [
    [{ itemid: 'aluminium', amount: 3 }],
    [{ itemid: 'refinedaluminium', amount: 1 }],
    [{ itemid: 'copper', amount: 3 }],
    [{ itemid: 'refinedcopper', amount: 1 }],
    [{ itemid: 'plastic', amount: 3 }],
    [{ itemid: 'refinedplastic', amount: 1 }],
    [{ itemid: 'rubber', amount: 3 }],
    [{ itemid: 'refinedrubber', amount: 1 }],
    [{ itemid: 'steel', amount: 3 }],
    [{ itemid: 'refinedsteel', amount: 1 }],
    [{ itemid: 'scrapmetal', amount: 3 }],
    [{ itemid: 'refinedscrap', amount: 1 }],
    [{ itemid: 'glass', amount: 3 }],
    [{ itemid: 'refinedglass', amount: 1 }],
    [{ itemid: 'electronics', amount: 3 }],
  ],
  information: '',
};

itemList['genericelectronicpart'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Electronic Part',
  price: 0,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  craft: [
    [{ itemid: 'aluminium', amount: 3 }],
    [{ itemid: 'refinedaluminium', amount: 1 }],
    [{ itemid: 'copper', amount: 3 }],
    [{ itemid: 'refinedcopper', amount: 1 }],
    [{ itemid: 'plastic', amount: 3 }],
    [{ itemid: 'refinedplastic', amount: 1 }],
    [{ itemid: 'rubber', amount: 3 }],
    [{ itemid: 'refinedrubber', amount: 1 }],
    [{ itemid: 'steel', amount: 3 }],
    [{ itemid: 'refinedsteel', amount: 1 }],
    [{ itemid: 'scrapmetal', amount: 3 }],
    [{ itemid: 'refinedscrap', amount: 1 }],
    [{ itemid: 'glass', amount: 3 }],
    [{ itemid: 'refinedglass', amount: 1 }],
    [{ itemid: 'electronics', amount: 3 }],
  ],
  model: '',
  image: 'np_generic_electronic.png',
  information: '',
};

itemList['methlabusb'] = {
  decayrate: 0.0,
  displayname: 'USB Device',
  price: 300,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_mkii-usb-device.png',
};

itemList['methtable'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'A table',
  price: 150,
  weight: 50.0,
  nonStack: false,
  model: '',
  image: 'np_methtable.png',
  information: 'Looks like a placeable table',
};

itemList['lqleavening'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: '(LQ) Leavening',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_bakingsoda.png',
  information: 'Low quality. Used for restaurant food.',
  foodCategory: ['leavening'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
};

itemList['lqoil'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: '(LQ) Cooking Oil',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_oil.png',
  information: 'Low quality. Used for restaurant food.',
  foodCategory: ['oil'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
};

itemList['lqgrain'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: '(LQ) Grain',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_grain.png',
  information: 'Low quality. Used for restaurant food.',
  foodCategory: ['grain'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
};

itemList['lqseasoning'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: '(LQ) Seasoning',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_ingredients_garlic.png',
  information: 'Low quality. Used for restaurant food.',
  foodCategory: ['seasoning'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
};

itemList['lqsugar'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: '(LQ) Sugar',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_ketamine_powder.png',
  information: 'Low quality. Used for restaurant food.',
  foodCategory: ['sugar'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
};

itemList['lqvegetables'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: '(LQ) Vegetables',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_ingredients_carrot.png',
  information: 'Low quality. Used for restaurant food.',
  foodCategory: ['vegetables'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
};

itemList['lqprotein'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: '(LQ) Protein',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_rawmeat.png',
  information: 'Low quality. Used for restaurant food.',
  foodCategory: ['protein'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
};

itemList['lqdairy'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: '(LQ) Dairy',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'np_ingredients_milk.png',
  information: 'Low quality. Used for restaurant food.',
  foodCategory: ['dairy'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: false,
};

itemList['housesafe'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Home Safe',
  price: 0,
  weight: 100,
  nonStack: true,
  model: '',
  image: 'np_housesafe.png',
  information: 'Verying tempting to crack into...',
};

itemList['repcrate'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Small carryable crate',
  price: 0,
  weight: 20,
  nonStack: true,
  model: '',
  image: 'np_rewardbox.png',
  information: 'I wonder what is inside?',
};

itemList['toy_uwu_biker'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Biker Kitty',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'toy_uwu_biker.png',
  information: 'UwU Cafe (1/12). Collect them all!',
  collectible: true,
};

itemList['toy_uwu_bsk'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'BSK Kitty',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'toy_uwu_bsk.png',
  information: 'UwU Cafe (2/13). Collect them all!',
  collectible: true,
};

itemList['toy_uwu_business'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Business Kitty',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'toy_uwu_business.png',
  information: 'UwU Cafe (3/13). Collect them all!',
  collectible: true,
};

itemList['toy_uwu_burglar'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cat Burglar Kitty',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'toy_uwu_burglar.png',
  information: 'UwU Cafe (4/13). Collect them all!',
  collectible: true,
};

itemList['toy_uwu_doctor'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Doctor Kitty',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'toy_uwu_doctor.png',
  information: 'UwU Cafe (5/13). Collect them all!',
  collectible: true,
};

itemList['toy_uwu_esb'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'ESB Kitty',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'toy_uwu_esb.png',
  information: 'UwU Cafe (6/13). Collect them all!',
  collectible: true,
};

itemList['toy_uwu_esv'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'ESV Kitty',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'toy_uwu_esv.png',
  information: 'UwU Cafe (7/13). Collect them all!',
  collectible: true,
};

itemList['toy_uwu_fisher'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Fisher Kitty',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'toy_uwu_fisher.png',
  information: 'UwU Cafe (8/13). Collect them all!',
  collectible: true,
};

itemList['toy_uwu_gsf'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'GSF Kitty',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'toy_uwu_gsf.png',
  information: 'UwU Cafe (9/13). Collect them all!',
  collectible: true,
};

itemList['toy_uwu_maid'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Maid Kitty',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'toy_uwu_maid.png',
  information: 'UwU Cafe (10/13). Collect them all!',
  collectible: true,
};

itemList['toy_uwu_officer'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Officer Kitty',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'toy_uwu_officer.png',
  information: 'UwU Cafe (11/13). Collect them all!',
  collectible: true,
};

itemList['toy_uwu_wizard'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Wizard Kitty',
  price: 0,
  weight: 1,
  nonStack: false, 
  model: '',
  image: 'toy_uwu_wizard.png',
  information: 'UwU Cafe (12/13). Collect them all!',
  collectible: true,
};

itemList['toy_uwu_worker'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Worker Kitty',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'toy_uwu_worker.png',
  information: 'UwU Cafe (13/13). Collect them all!',
  collectible: true,
};

itemList['letterbox'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Mailbox',
  price: 500,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_letterbox.png',
  information: 'You got mail! (Placeable Object)',
}

itemList['raidreceipt'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Raid Evidence List',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_raid_receipt.png',
  information: 'List of items seized from a raid',
}

itemList['fridge'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Fridge',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_fridge.png',
  information: 'Literally a fridge',
};

itemList['Desomorphine'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.50,
  displayname: 'Metamorphine',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_desomorphine.png',
  information: 'Dumpster Flu Shot',
  contraband: true,
};

itemList['laxative'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.50,
  displayname: 'Chocolate',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_laxative.png',
  information: 'Who does not enjoy a piece of chocolate.',
  contraband: false,
};


itemList['Desomorphine_used'] = {
  fullyDegrades: true,
  illegal: true,
  decayrate: 0.25,
  displayname: 'Used Syringe',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_empty_syringe.png',
  information: 'I would not touch that if I were you.',
  contraband: true,
};

itemList['Peecup_empty'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 1.0,
  displayname: 'Pee cup',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_peecup_empty.png',
  information: 'Empty cup.',
  contraband: false,
};

itemList['Peecup_full'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 1.00,
  displayname: 'Pee cup',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_peecup_full.png',
  information: 'Cup full of pee.',
  contraband: false,
};

itemList['portablefridge'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Portable Fridge',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_fridge.png',
  information: 'Literally a fridge',
};

itemList['bentobox'] = {
  _name: 'bentobox',
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Bento Box',
  price: 0,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_bento_4.png',
  information: 'Convenient!',
};

itemList['pizzabox'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Pizza Box',
  price: 0,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_pizza_box.png',
  information: 'Oven Fresh!',
};

itemList['uwutoy'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Mystery Box',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'toy_uwu_package.png',
  information: 'Contains a random UwU Cafe toy.',
}

itemList['pumpkinseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Pumpkin Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'pumpkinseed.png',
  information: 'A pumpkin seed, also known in North America as a pepita, is the edible seed of a pumpkin or certain other cultivars of squash.',
  seed: true,
};

itemList['cornkernel'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Corn Kernel',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'cornkernel.png',
  information: 'Each kernel of corn is actually a seed that, like most seeds, contains an embryo (a baby plant) and a seed coat for protection.',
  seed: true,
};

itemList['tomatoseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Tomato Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'tomatoseed.png',
  information: 'Solanum lycopersicum',
  seed: true,
};

itemList['carrotseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Carrot Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'carrotseeds.png',
  information: 'Grown for its edible root',
  seed: true,
};

itemList['beetrootseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Beet Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'beetrootseeds.png',
  information: 'Beetroot or Beet (Beta vulgaris) is a root vegetable also known as red beet, table beet, garden beet, or just beet.',
  seed: true,
};

itemList['radishseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Radish Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'radishseeds.png',
  information: 'Radish seeds become radishes.',
  seed: true,
};

itemList['wheatseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Wheat Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'wheatseed.png',
  information: 'Wheat is a grass widely cultivated for its seed, a cereal grain which is a worldwide staple food.',
  seed: true,
};

itemList['potatoseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'True Potato Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'potatoseeds.png',
  information: 'Of the genus Solanum',
  seed: true,
};

itemList['cabbageseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Cabbage Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'cabbageseeds.png',
  information: 'I remember a time when a cabbage could sell itself by being a cabbage.',
  seed: true,
};

itemList['watermelonseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Watermelon Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'watermelonseeds.png',
  information: 'Grows into a large fruit of a more or less spherical shape',
  seed: true,
};

itemList['onionseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Onion Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'onionseeds.png',
  information: 'The seed of a round vegetable with a brown skin that grows underground',
  seed: true,
};

itemList['cucumberseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Cucumber Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'cucumberseeds.png',
  information: 'The seed of a long thin vegetable with a hard green skin and wet transparent flesh.',
  seed: true,
};

itemList['sunflowerseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Sunflower Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'sunflowerseeds.png',
  information: 'A sunflower seed.. a small embryonic sunflower.',
  seed: true,
};

itemList['sunfloweroil'] = {
  fullyDegrades: true,
  decayrate: 0.05,
  displayname: 'Sunflower Oil',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  image: 'sunfloweroil.png',
  information: 'Used for cooking.',
  foodCategory: ['oil'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
};

itemList['garlicseed'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Garlic Seed',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_weed-seed.png',
  information: 'Yes',
  seed: true,
};

itemList['seedanalyzer'] = {
  fullyDegrades: true,
  decayrate: 0.75,
  displayname: 'Seed Analyzer',
  price: 4000,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_seed_analyzer.png',
  information: 'This seed analyzer lets you sequence the DNA of a variety of seeds. It comes with a USB adapter to connect to a latop.',
};

itemList['seedbag'] = {
  fullyDegrades: false,
  decayrate: 0,
  displayname: 'Seed Bag',
  price: 200,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'seedbag.png',
  information: 'A bag for collecting seeds.',
  whitelist: [
    "seed"
  ],
};

itemList['wateringcan'] = {
  fullyDegrades: false,
  decayrate: 5.0,
  displayname: 'Watering Can',
  price: 700,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'wateringcan.png',
  information: 'Fill this at a river or lake.',
};

itemList['pitchfork'] = {
  fullyDegrades: false,
  decayrate: 0.25,
  displayname: 'Pitchfork',
  price: 1100,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_pitchfork.png',
  information: 'Used to harvest groups of crops.',
};

itemList['sprinkler1'] = {
  fullyDegrades: false,
  decayrate: 0.25,
  displayname: 'Sprinkler',
  price: 2600,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_sprinkler.png',
  information: 'Requires a nearby water source. Used to water crops.',
};

itemList['farmhoe'] = {
  fullyDegrades: false,
  decayrate: 0.25,
  displayname: 'Hoe',
  price: 900,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_hoe.png',
  information: 'Used to plant groups of crops.',
};

itemList['elevatorhackingdevice'] = {
  fullyDegrades: true,
  decayrate: 0.001385,
  displayname: 'Elevator Hacking Device',
  price: 1000,
  craft: [
    [
      { itemid: 'refinedaluminium', amount: 33 },
      { itemid: 'refinedcopper', amount: 33 },
      { itemid: 'refinedrubber', amount: 33 },
      { itemid: 'refinedplastic', amount: 33 },
    ]
  ],
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_elevator_hacking_device.png',
  information: 'Government Issued Equipment',
}

itemList['fishoil'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Fish oil',
  price: 1,
  weight: 1.0,
  nonStack: false,
  model: '',
  fishes: true,
  image: 'np_fishoil.png',
  information: 'All the Omega-3 acids',
  foodCategory: ['oil'],
  foodEnhancement: 0.2,
  foodEnhancementFromMeta: true,
};

itemList['ammonium_bicarbonate'] = {
  fullyDegrades: false,
  decayrate: 0.23,
  displayname: 'Ammonium Bicarbonate',
  price: 0,
  weight: 5,
  nonStack: false,
  model: '',
  insertFrom: ["1gcocaine"],
  image: 'np_ammonium_bicarbonate.png',
  information: 'Very good at breaking things down. This compound has many names, reflecting its long history',
};

itemList['envelope'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Envelope',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_documents.png',
  information: 'Contains important documents.',
};

itemList['uruore'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Uru Ore',
  price: 1,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_uru_metal.png',
  information: 'Metal ore from the first moon in existence.',
};

//Siz experiment items//
itemList['experiment_01'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.5,
  displayname: 'Unknown bottle',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_research_01.png',
  information: '',
  contraband: false,
};

itemList['experiment_02'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.5,
  displayname: 'Unknown bottle',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_research_02.png',
  information: '',
  contraband: false,
};

itemList['experiment_03'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.5,
  displayname: 'Unknown bottle',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_research_03.png',
  information: '',
  contraband: false,
};

itemList['experiment_04'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.5,
  displayname: 'Unknown bottle',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_research_04.png',
  information: '',
  contraband: false,
};

itemList['experiment_05'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.5,
  displayname: 'Unknown bottle',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_research_05.png',
  information: '',
  contraband: false,
};

itemList['experiment_06'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.5,
  displayname: 'Unknown bottle',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_research_06.png',
  information: '',
  contraband: false,
};

itemList['experiment_07'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.5,
  displayname: 'Unknown bottle',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_research_07.png',
  information: '',
  contraband: false,
};

itemList['experiment_08'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.5,
  displayname: 'Unknown bottle',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_research_08.png',
  information: '',
  contraband: false,
};

itemList['experiment_09'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.5,
  displayname: 'Unknown bottle',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_research_09.png',
  information: '',
  contraband: false,
};

itemList['pillbox'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.0,
  displayname: 'Pill box',
  price: 150,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_pillbox.png',
  information: '',
  contraband: false,
};

itemList['producebasket'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.0,
  displayname: 'Produce Basket',
  price: 340,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'producebasket.png',
  information: '',
  whitelist: [
    "produce"
  ],
};

itemList['notepad'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 1.0,
  displayname: 'a notepad',
  price: 200,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_notepad.png',
  information: 'notepad with 10 pages',
  contraband: false,
};

itemList['notepadnote'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.0,
  displayname: 'a note',
  price: 0,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_notepad_page.png',
  information: 'a note with something written on it',
  contraband: false,
};

itemList['drone_lspd'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.0,
  displayname: 'Police Drone',
  price: 0,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_drone.png',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
  contraband: false,
};

itemList['drone_civ'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.0,
  displayname: 'Drone',
  price: 0,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_drone.png',
  information: 'It flies!',
  contraband: false,
};

itemList['rccontroller'] = {
  fullyDegrades: false,
  illegal: false,
  decayrate: 0.0,
  displayname: 'Remote Controller',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_drone_control.png',
  information: 'Used to control a variety of RC vehicles.',
  contraband: false,
};

itemList['barrel_fuel'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Fuel Barrel',
  price: 10000,
  weight: 150,
  nonStack: true,
  model: '',
  image: 'np_barrel-fuel.png',
  information: 'Barrel full of processed petroleum ready to be used as fuel for vehicles.',
};

itemList['diamond_collar'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  isStolen: true,
  displayname: 'Diamond Collar',
  price: 1500,
  weight: 6,
  nonStack: true,
  model: '',
  image: 'diamond_collar.png',
  information: 'Collar full of embedded diamonds',
};

itemList['crackpipe'] = {
  fullyDegrades: false,
  decayrate: 0.1,
  isStolen: true,
  displayname: 'Crack Pipe',
  price: 0,
  weight: 5,
  nonStack: true,
  craft: [[
    { itemid: 'glass', amount: 75 },
    { itemid: '1gcrack', amount: 1 },
  ]],
  model: '',
  image: 'np_crackpipe.png',
  information: 'Hmm this seems interesting...',
};

itemList['methpipe'] = {
  fullyDegrades: false,
  decayrate: 0.1,
  isStolen: true,
  displayname: 'Meth Pipe',
  price: 0,
  weight: 5,
  nonStack: true,
  craft: [[
    { itemid: 'glass', amount: 75 },
    { itemid: 'methlabproduct', amount: 1 },
  ]],
  model: '',
  image: 'np_methpipe.png',
  information: 'Hmm this seems interesting...',
};

itemList['cokeline'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  isStolen: true,
  displayname: 'Rolled Bill',
  price: 0,
  weight: 5,
  nonStack: true,
  craft: [[
    { itemid: 'band', amount: 1 },
  ]],
  model: '',
  image: 'np_cokeline.png',
  information: 'Hmm this seems interesting...',
};

itemList['boggsproteinbar'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Bogg\'s Protein Bar',
  price: 150,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_boggs_protein_bar.png',
  information: 'Designed For the BMX Lovers. May cause erectile dysfunction.',
}

itemList['spraycan'] = {
  _name: 'spraycan',
  fullyDegrades: false,
  decayrate: 3.0,
  displayname: 'Spray Can',
  price: 500,
  weight: 2,
  nonStack: true,
  model: '',
  craft: [[
    { itemid: 'plastic', amount: 50 },
    { itemid: 'aluminium', amount: 100 },
  ]],
  image: 'spraycan.png',
  information: 'Art.',
};

itemList['matrixredpill'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Red Pill',
  price: 50,
  weight: 1,
  nonStack: false,
  image: 'np_matrix_redpill.png',
  information: '',
};

itemList['matrixbluepill'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Blue Pill',
  price: 50,
  weight: 1,
  nonStack: false,
  image: 'np_matrix_bluepill.png',
  information: '',
};

itemList['cgolympicslogo'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'CG Olympics',
  price: 50,
  weight: 1,
  nonStack: false,
  image: 'np_cg_olympics_logo.png',
  information: 'Participation Reward',
  collectible: true,
};

itemList['cgolympicsgold'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'CG Olympics',
  price: 50,
  weight: 1,
  nonStack: false,
  image: 'np_cg_olympics_gold.png',
  information: 'Gold Medal - For Winners!',
  collectible: true,
};

itemList['cgolympicssilver'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'CG Olympics',
  price: 50,
  weight: 1,
  nonStack: false,
  image: 'np_cg_olympics_silver.png',
  information: 'Silver Medal - For Almost Winners!',
  collectible: true,
};

itemList['cgolympicsbronze'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'CG Olympics',
  price: 50,
  weight: 1,
  nonStack: false,
  image: 'np_cg_olympics_bronze.png',
  information: 'Bronze Medal - For the worst Winners!',
  collectible: true,
};

itemList['chemicals'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Chemicals',
  price: 0,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_mysterious-vial.png',
  information: 'Something is in it... but what?',
  contraband: true,
};

itemList['C4_dev'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'C4',
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_c4.png',
  information: 'Beep...Beep...Beep...',
  contraband: true,
};

itemList['car_bomb'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Car Bomb',
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_carbomb.png',
  information: 'Beep...Beep...Beep...',
  contraband: true,
};

itemList['car_bomb_defused'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Defused Car Bomb',
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_carbomb.png',
  information: 'You should try and shake it!',
  contraband: true,
};

itemList['C4_defused'] = {
  fullyDegrades: false,
  illegal: true,
  decayrate: 0.0,
  displayname: 'Defused C4',
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_c4.png',
  information: 'You should try and shake it!',
  contraband: true,
};

itemList['bombmirror'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.3,
  displayname: 'Car Bomb Detector',
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_bombmirror.png',
  information: 'Helps stop boom boom',
  contraband: false,
};

itemList['highpoweredmagnet'] = {
  fullyDegrades: true,
  illegal: false,
  decayrate: 0.5,
  displayname: 'High Powered Magnet',
  price: 100,
  weight: 6,
  nonStack: false,
  model: '',
  image: 'np_magnet_hp.png',
  information: 'Bzzz',
  contraband: false,
  craft: [
    [
      { itemid: 'aluminium', amount: 75 },
      { itemid: 'copper', amount: 75 },
      { itemid: 'rubber', amount: 50 },
      { itemid: 'plastic', amount: 75 },
      { itemid: 'electronics', amount: 100 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 18 },
      { itemid: 'refinedcopper', amount: 18 },
      { itemid: 'refinedrubber', amount: 12 },
      { itemid: 'refinedplastic', amount: 18 },
      { itemid: 'electronics', amount: 100 },
    ]
  ]
};

itemList['casinoexeckeycard'] = {
  fullyDegrades: true,
  decayrate: 0.0015,
  displayname: 'Executive Key Card',
  price: 60000,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_exec_card.png',
  information: 'Limited Access to Casino Systems',
};

itemList['casinosafeaccesscodes'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Casino Safe Access Codes',
  craft: [],
  price: 500,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_receipt.png',
  information: 'Marked for police seizure.',
};

itemList['heistduffelbag'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Duffel Bag',
  price: 350,
  weight: 11,
  nonStack: false,
  model: '',
  image: 'np_duffel.png',
  whitelist: [
    "heist_loot"
  ],
  information: 'Can hold a considerable amount of cash. Marked for Police Seizure. <br><br><i>"We are just supposed to walk out of there with millions of dollars in cash on us without getting stopped?"</i>',
};

itemList['heistusb7'] = {
  fullyDegrades: false,
  decayrate: 0.01071, // 8~ hours
  displayname: 'USB Device',
  price: 300,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_unknown-usb-device.png',
};

itemList['uraniumrod'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Uranium Rod',
  price: 350,
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_uranium_rod.png',
  information: "Hot!",
};
itemList['1gcocainium'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: '10g cocanium',
  price: 100,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_ketamine_baggie_u.png',
  information: "Looks really high quality.. and hot!",
};

itemList['casinopantherstatue'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Panther Statue',
  price: 350,
  weight: 11,
  nonStack: false,
  model: '',
  heist_loot: true,
  image: 'np_casino_panther.png',
  information: "Its all connected. (1/1)",
  placeableObject: "h4_prop_h4_art_pant_01a",
};

itemList['xqcgrenade'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Grenade Statue',
  price: 350,
  weight: 11,
  nonStack: false,
  model: '',
  image: 'np_xqc_grenade.png',
  information: 'Quite explosive. <br><br><i>1 of 1. For solving the Casino Heist riddle.</i>',
  placeableObject: "vw_prop_casino_art_grenade_01d",
};

itemList['rearingbroncostatue'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Rearing Bronco Statue',
  price: 350,
  weight: 11,
  nonStack: false,
  model: '',
  image: 'np_fig_rearing_bronco.png',
  information: 'Behold a Pale Horse. <br><br><i>1 of 1. For solving one of the 3.0 anniversary riddles.</i>',
  placeableObject: "v_res_m_horsefig",
};
itemList['rearingbroncostatuebook'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Binder',
  craft: [],
  price: 400,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'closed-book.png',
  information: '',
};

itemList['impotentragefigure'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Impotent Rage Action Figure',
  price: 350,
  weight: 11,
  nonStack: false,
  model: '',
  image: 'np_fig_impotent_rage.png',
  information: 'Savior of the city. <br><br><i>1 of 1. For solving one of the 3.0 anniversary riddles.</i>',
  placeableObject: "np_imporage",
};
itemList['impotentragefigurebook'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Diary',
  craft: [],
  price: 400,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'closed-book.png',
  information: '',
};

itemList['glimpseofhope'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'The Glimpse of Hope',
  price: 350,
  weight: 11,
  nonStack: false,
  model: '',
  image: 'np_fig_glimpse_of_hope.png',
  information: 'Shines like a diamond.  <br><br><i>1 of 1. For solving one of the 3.0 anniversary riddles.</i>',
  placeableObject: "vw_prop_casino_art_skull_01a",
};
itemList['glimpseofhopebook'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Book',
  craft: [],
  price: 400,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'closed-book.png',
  information: '',
};

itemList['outbreak_skill_summon'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Summon Horde',
  price: 350,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_zombie_horde.png',
  information: 'Brains... (Event Skill)',
};

itemList['outbreak_skill_vision'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Zombie Vision',
  price: 350,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_zombie_vision.png',
  information: 'Brains... (Event Skill)',
};

itemList['outbreak_skill_jump'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Zombie Jump',
  price: 350,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_zombie_jump.png',
  information: 'Brains... (Event Skill)',
};

itemList['meteorite'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Fukang Meteorite',
  price: 350,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_tl_meteorite.png',
  information: 'Wear this for protection.',
};

itemList['outbreakcure'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Nanites Treatment',
  price: 12500,
  craft: [],
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_tl_nanitesupressor.png',
  information: 'Use it to cure the infection',
}

itemList['portaldisruptor'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Portal Disruptor',
  price: 12500,
  craft: [],
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_tl_portaldisruptor.png',
  information: 'Used to disrupt portals.',
}

itemList['infectiontest'] = {
  fullyDegrades: true,
  decayrate: 1,
  displayname: 'Infection Tester',
  price: 12500,
  craft: [],
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_tl_outbreak_tester.png',
  information: 'Used to detect if a person is infected.',
}

