
SpellList = 
{
	
	
	-- casting a AOE heal spell wows. [ TARGET SPELL ]
	["AOEtest"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "scr_bike_adversary", ["Part"] = "scr_adversary_weap_glow", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 25, ["Target"] = true, ["ClientEffect"] = nil, ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Display"] = false, ["Casttime"] = 1000,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 1.0, alpha = 1.0 }, ["SoundFile"] = 'ArcaneShort'
		},

		["StartEffect"] = 
		{ 
			["Lib"] = "scr_bike_adversary", ["Part"] = "scr_adversary_weap_glow", ["Bone"] = 18905,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 1.0, alpha = 1.0 } 
		},

		["AreaEffect"] = 
		{ 
			["Lib"] = "scr_bike_adversary", ["Part"] = "scr_adversary_weap_glow", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 1, ["Target"] = true, ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Event"] = 'fx:spell:speed', 
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 5.0, alpha = 1.0 } 
		},

		["Animations"] = 
		{ 
			["Caster"] = { ["Dict"] = "none", ["Anim"] = "none", ["Duration"] = 5.0 }, 
			["Victim"] = {} 
		},

		["HitEffect"] = 
		{ 
			["Library"] = "core", ["Particle"] = "exp_air_molotov", ["Bone"] = 57005, ["Damage"] = 0.0, ["Stun"] = 0.0, ["ManaDrain"] = 0
		},
	},

	-- casting a AOE heal spell wows. [ TARGET SPELL ]
	["AOEpoop"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "scr_amb_chop", ["Part"] = "ent_anim_dog_poo", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 10, ["Target"] = true, ["ClientEffect"] = nil, ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Display"] = false, ["Casttime"] = 1000,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 15.0, alpha = 0.1 }, ["SoundFile"] = 'FartNoise'
		},

		["StartEffect"] = 
		{ 
			["Lib"] = "scr_bike_adversary", ["Part"] = "scr_adversary_ped_glow", ["Bone"] = 18905,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 1.0, alpha = 1.0 } 
		},

		["AreaEffect"] = 
		{ 
			["Lib"] = "scr_amb_chop", ["Part"] = "ent_anim_dog_poo", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 1, ["Target"] = true, ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Event"] = 'fx:spell:poop', 
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 15.0, alpha = 0.7 } 
		},

		["Animations"] = 
		{ 
			["Caster"] = { ["Dict"] = "none", ["Anim"] = "none", ["Duration"] = 5.0 }, 
			["Victim"] = {} 
		},

		["HitEffect"] = 
		{ 
			["Library"] = "core", ["Particle"] = "exp_air_molotov", ["Bone"] = 57005, ["Damage"] = 0.0, ["Stun"] = 0.0, ["ManaDrain"] = 0
		},
	},	

	-- casting a AOE heal spell wows. [ TARGET SPELL ]
	["AOEbuff"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "scr_bike_adversary", ["Part"] = "scr_adversary_ped_glow", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 10, ["Target"] = true, ["ClientEffect"] = nil, ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Display"] = false, ["Casttime"] = 1000,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 1.0, alpha = 1.0 }, ["SoundFile"] = 'ArcaneShort'
		},

		["StartEffect"] = 
		{ 
			["Lib"] = "scr_bike_adversary", ["Part"] = "scr_adversary_ped_glow", ["Bone"] = 18905,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 1.0, alpha = 1.0 } 
		},

		["AreaEffect"] = 
		{ 
			["Lib"] = "scr_bike_adversary", ["Part"] = "scr_adversary_ped_glow", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 1, ["Target"] = true, ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Event"] = 'fx:spell:buff', 
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 5.0, alpha = 1.0 } 
		},

		["Animations"] = 
		{ 
			["Caster"] = { ["Dict"] = "none", ["Anim"] = "none", ["Duration"] = 5.0 }, 
			["Victim"] = {} 
		},

		["HitEffect"] = 
		{ 
			["Library"] = "core", ["Particle"] = "exp_air_molotov", ["Bone"] = 57005, ["Damage"] = 0.0, ["Stun"] = 0.0, ["ManaDrain"] = 0
		},
	},

	-- casting a AOE heal spell wows. [ TARGET SPELL ]
	["AOEspeed"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "scr_bike_adversary", ["Part"] = "scr_adversary_weap_glow", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 10, ["Target"] = true, ["ClientEffect"] = nil, ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Display"] = false, ["Casttime"] = 1000,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 1.0, alpha = 1.0 }, ["SoundFile"] = 'FairyShort' 
		},

		["StartEffect"] = 
		{ 
			["Lib"] = "scr_bike_adversary", ["Part"] = "scr_adversary_weap_glow", ["Bone"] = 18905,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 1.0, alpha = 1.0 } 
		},

		["AreaEffect"] = 
		{ 
			["Lib"] = "scr_bike_adversary", ["Part"] = "scr_adversary_weap_glow", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 1, ["Target"] = true, ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Event"] = 'fx:spell:speed', 
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 5.0, alpha = 1.0 } 
		},

		["Animations"] = 
		{ 
			["Caster"] = { ["Dict"] = "none", ["Anim"] = "none", ["Duration"] = 5.0 }, 
			["Victim"] = {} 
		},

		["HitEffect"] = 
		{ 
			["Library"] = "core", ["Particle"] = "exp_air_molotov", ["Bone"] = 57005, ["Damage"] = 0.0, ["Stun"] = 0.0, ["ManaDrain"] = 0
		},
	},
	
	
	-- teleport to location
	["blink"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "core", ["Part"] = "exp_grd_grenade_smoke", ["Bone"] = 0, ["Damage"] = 0.0, ["Mana"] = 25, ["Target"] = true, ["ClientEffect"] = 'fx:teleport:location', ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Display"] = true, ["Casttime"] = 1000,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 1.0, alpha = 1.0 }, ["SoundFile"] = 'ArcaneShort' 
		},

		["StartEffect"] = 
		{ 
			["Lib"] = "core", ["Part"] = "exp_grd_grenade_smoke", ["Bone"] = 18905,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = -90.0, y = 0.0, z = 0.0}, scale = 0.3, alpha = 1.0 } 
		},

		["AreaEffect"] = 
		{ 
			["Lib"] = "core", ["Part"] = "exp_grd_grenade_smoke", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 1, ["Target"] = true, ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Event"] = nil, 
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 1.0}, rot = {x = -90.0, y = 0.0, z = 0.0}, scale = 1.0, alpha = 0.7 } 
		},

		["Animations"] = 
		{ 
			["Caster"] = { ["Dict"] = "none", ["Anim"] = "none", ["Duration"] = 5.0 }, 
			["Victim"] = {} 
		},

		["HitEffect"] = 
		{ 
			["Library"] = "core", ["Particle"] = "exp_air_molotov", ["Bone"] = 57005, ["Damage"] = 0.0, ["Stun"] = 0.0, ["ManaDrain"] = 0
		},
	},

	
	-- teleport to location
	["beacon"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "core", ["Part"] = "exp_grd_flare", ["Bone"] = 0, ["Damage"] = 0.0, ["Mana"] = 25, ["Target"] = true, ["ClientEffect"] = 'fx:teleport:location', ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Display"] = true, ["Casttime"] = 1000,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 1.0, alpha = 1.0 }, ["SoundFile"] = 'ArcaneShort' 
		},

		["StartEffect"] = 
		{ 
			["Lib"] = "core", ["Part"] = "exp_grd_flare", ["Bone"] = 18905,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = -90.0, y = 0.0, z = 0.0}, scale = 0.3, alpha = 1.0 } 
		},

		["AreaEffect"] = 
		{ 
			["Lib"] = "core", ["Part"] = "exp_grd_flare", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 1, ["Target"] = true, ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Event"] = nil, 
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 1.0}, rot = {x = -90.0, y = 0.0, z = 0.0}, scale = 1.0, alpha = 0.7 } 
		},

		["Animations"] = 
		{ 
			["Caster"] = { ["Dict"] = "none", ["Anim"] = "none", ["Duration"] = 5.0 }, 
			["Victim"] = {} 
		},

		["HitEffect"] = 
		{ 
			["Library"] = "core", ["Particle"] = "exp_air_molotov", ["Bone"] = 57005, ["Damage"] = 0.0, ["Stun"] = 0.0, ["ManaDrain"] = 0
		},
	},	
	
	
	-- casting a fire spell wows.
	["FireRay"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "core", ["Part"] = "ent_sht_flame", ["Bone"] = 18905, ["Damage"] = 10.0, ["Mana"] = 35, ["Target"] = false, ["ClientEffect"] = nil, ["Targetdist"] = 0.0, ["GCD"] = 3500, ["Display"] = true, ["Casttime"] = 10000,
			["OffSets"] = { offset = {x = 0.9, y = -0.2, z = 0.4}, rot = {x = 0.0, y = 63.0, z = 0.0}, scale = 2.0, alpha = 0.2 }, ["SoundFile"] = 'FireShort' 
		},

		["StartEffect"] = 
		{ 
			["Lib"] = "core", ["Part"] = "ent_amb_fbi_fire_beam", ["Bone"] = 18905,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = -90.0, y = 0.0, z = 0.0}, scale = 0.2, alpha = 0.1 } 
		},


		["AreaEffect"] = 
		{ 
			["Lib"] = "core", ["Part"] = "ent_amb_fountain_pour", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 1, ["Target"] = true, ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Event"] = nil,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 1.0}, rot = {x = -90.0, y = 0.0, z = 0.0}, scale = 2.0, alpha = 1.0 } 
		},


		["Animations"] = 
		{ 
			["Caster"] = { ["Dict"] = "none", ["Anim"] = "none", ["Duration"] = 5.0 }, 
			["Victim"] = {} 
		},

		["HitEffect"] = 
		{ 
			["Library"] = "core", ["Particle"] = "exp_air_molotov", ["Bone"] = 57005, ["Damage"] = 0.0, ["Stun"] = 0.0, ["ManaDrain"] = 0
		},
	},

	-- casting a AOE heal spell wows. [ TARGET SPELL ]
	["AOEheal"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "scr_rcbarry1", ["Part"] = "scr_alien_teleport", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 50, ["Target"] = true, ["ClientEffect"] = nil, ["Targetdist"] = 3.0, ["GCD"] = 0.0,  ["Display"] = true, ["Casttime"] = 1000,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = -90.0, y = 0.0, z = 0.0}, scale = 0.3, alpha = 0.1 }, ["SoundFile"] = 'FairyShort' 
		},

		["StartEffect"] = 
		{ 
			["Lib"] = "scr_rcbarry1", ["Part"] = "scr_alien_teleport", ["Bone"] = 18905,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = -90.0, y = 0.0, z = 0.0}, scale = 0.1, alpha = 0.1 } 
		},

		["AreaEffect"] = 
		{ 
			["Lib"] = "scr_rcbarry1", ["Part"] = "scr_alien_teleport", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 1, ["Target"] = true, ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Event"] = 'fx:spell:heal', 
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 1.0}, rot = {x = -90.0, y = 0.0, z = 0.0}, scale = 1.0, alpha = 0.3 } 
		},

		["Animations"] = 
		{ 
			["Caster"] = { ["Dict"] = "none", ["Anim"] = "none", ["Duration"] = 5.0 }, 
			["Victim"] = {} 
		},

		["HitEffect"] = 
		{ 
			["Library"] = "core", ["Particle"] = "exp_air_molotov", ["Bone"] = 57005, ["Damage"] = 0.0, ["Stun"] = 0.0, ["ManaDrain"] = 0
		},
	},

	-- casting a AOE heal spell wows. [ TARGET SPELL ]
	["AOEslow"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "scr_rcbarry1", ["Part"] = "scr_alien_charging", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 35, ["Target"] = true, ["ClientEffect"] = nil, ["Targetdist"] = 3.0, ["GCD"] = 0.0,  ["Display"] = true, ["Casttime"] = 1000,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = -90.0, y = 0.0, z = 0.0}, scale = 0.1, alpha = 0.1 }, ["SoundFile"] = 'IceShort' 
		},

		["StartEffect"] = 
		{ 
			["Lib"] = "scr_rcbarry1", ["Part"] = "scr_alien_charging", ["Bone"] = 18905,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = -90.0, y = 0.0, z = 0.0}, scale = 0.2, alpha = 0.2 } 
		},

		["AreaEffect"] = 
		{ 
			["Lib"] = "scr_rcbarry1", ["Part"] = "scr_alien_charging", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 1, ["Target"] = true, ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Event"] = 'fx:spell:slow', 
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 0.0, y = 0.0, z = 0.0}, scale = 1.0, alpha = 1.0 } 
		},

		["Animations"] = 
		{ 
			["Caster"] = { ["Dict"] = "none", ["Anim"] = "none", ["Duration"] = 5.0 }, 
			["Victim"] = {} 
		},

		["HitEffect"] = 
		{ 
			["Library"] = "core", ["Particle"] = "exp_air_molotov", ["Bone"] = 57005, ["Damage"] = 0.0, ["Stun"] = 0.0, ["ManaDrain"] = 0
		},
	},

	-- casting a AOE heal spell wows. [ TARGET SPELL ]
	["AOEshock"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "scr_rcbarry1", ["Part"] = "scr_alien_disintegrate", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 35, ["Target"] = true, ["ClientEffect"] = nil, ["Targetdist"] = 3.0, ["GCD"] = 0.0,  ["Display"] = true, ["Casttime"] = 1000,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = -90.0, y = 0.0, z = 0.0}, scale = 0.2, alpha = 0.1 }, ["SoundFile"] = 'ArcaneShort' 
		},

		["StartEffect"] = 
		{ 
			["Lib"] = "scr_rcbarry1", ["Part"] = "scr_alien_disintegrate", ["Bone"] = 18905,
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = -90.0, y = 0.0, z = 0.0}, scale = 0.1, alpha = 0.1 } 
		},

		["AreaEffect"] = 
		{ 
			["Lib"] = "scr_rcbarry1", ["Part"] = "scr_alien_disintegrate", ["Bone"] = 18905, ["Damage"] = 0.0, ["Mana"] = 1, ["Target"] = true, ["Targetdist"] = 3.0, ["GCD"] = 0.0, ["Event"] = 'fx:spell:shock', 
			["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 1.0}, rot = {x = -90.0, y = 0.0, z = 0.0}, scale = 3.0, alpha = 1.0 } 
		},

		["Animations"] = 
		{ 
			["Caster"] = { ["Dict"] = "none", ["Anim"] = "none", ["Duration"] = 5.0 }, 
			["Victim"] = {} 
		},

		["HitEffect"] = 
		{ 
			["Library"] = "core", ["Particle"] = "exp_air_molotov", ["Bone"] = 57005, ["Damage"] = 0.0, ["Stun"] = 0.0, ["ManaDrain"] = 0
		},
	},
	










	-- CLIENT STATUS EFFECT

	-- casting a AOE heal spell wows. [ TARGET SPELL ]
	["slowed"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "scr_rcbarry1", ["Part"] = "scr_alien_charging", ["Bone"] = 0, ["OffSets"] = { offset = {x = 0.0, y = 0.0, z = -0.2}, rot = {x = 90.0, y = 0.0, z = 0.0}, scale = 0.2, alpha = 1.0 }, ["SoundFile"] = 'IceEffect'
		},

	},
	["arcane"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "scr_rcbarry1", ["Part"] = "scr_alien_disintegrate", ["Bone"] = 0, ["OffSets"] = { offset = {x = 0.0, y = 0.0, z = -0.2}, rot = {x = 90.0, y = 0.0, z = 0.0}, scale = 0.2, alpha = 1.0 }, ["SoundFile"] = 'ArcaneEffect'
		},

	},

	["staffused"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "scr_rcbarry1", ["Part"] = "scr_alien_disintegrate", ["Bone"] = 57005, ["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 90.0, y = 0.0, z = 0.0}, scale = 0.3, alpha = 1.0 }, ["SoundFile"] = 'ArcaneEffect' 
		},

	},

	["buffed"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "scr_bike_adversary", ["Part"] = "scr_adversary_ped_glow", ["Bone"] = 0, ["OffSets"] = { offset = {x = 0.0, y = 0.0, z = 0.0}, rot = {x = 90.0, y = 0.0, z = 0.0}, scale = 1.5, alpha = 1.0 }, ["SoundFile"] = 'ArcaneEffect' 
		},

	},

	["speed"] = 
	{ 
		["Base"] = 
		{ 
			["Lib"] = "scr_bike_adversary", ["Part"] = "scr_adversary_weap_glow", ["Bone"] = 0, ["OffSets"] = { offset = {x = 0.0, y = 0.0, z = -1.0}, rot = {x = 90.0, y = 0.0, z = 0.0}, scale = 2.0, alpha = 0.7 }, ["SoundFile"] = 'FairyEffect'
		},

	},	

}

