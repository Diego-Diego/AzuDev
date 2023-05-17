return {
  	--- Basic
  	['money'] = {
  		label = 'Argent',
  	},
  	['black_money'] = {
  		label = 'Argent sale',
  	},
  	--- Thirst/Hunger
  	-- Water
  	['water'] = {
  		label = "Bouteille d'eau",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = nil
  	},
  	-- Bread
  	['bread'] = {
  		label = 'Pain',
  		weight = 1,
  		stack = true,
  		close = true,
  		description = nil
  	},
  	['beer'] = {
  		label = 'Bière',
  		weight = 1,
  		stack = true,
  		close = true,
  		description = nil
  	},
  	--- Basic Items
  	-- Phone
  	['phone'] = {
  		label = 'Phone',
  		weight = 190,
  		stack = false,
  		consume = 0,
  		client = {
  			add = function(total)
  				if total > 0 then
  					pcall(function() return exports.npwd:setPhoneDisabled(false) end)
  				end
  			end,
  
  			remove = function(total)
  				if total < 1 then
  					pcall(function() return exports.npwd:setPhoneDisabled(true) end)
  				end
  			end
  		}
  	},
  	-- Radio
  	['radio'] = {
  		label = 'Radio',
  		weight = 1000,
  		stack = false,
  		allowArmed = true
  	},
  	--- Jobs Items
  	-- Ambulance
  	['bandage'] = {
  		label = 'Bandage',
  		weight = 115,
  		client = {
  			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
  			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
  			disable = { move = true, car = true, combat = true },
  			usetime = 2500,
  		}
  	},
  
  	['medikit'] = {
  		label = 'Medikit',
  		weight = 2,
  		stack = true,
  		close = true,
  		description = nil
  	},
  	--- Basic Ox_Inventory
  	['burger'] = {
  		label = 'Burger',
  		weight = 220,
  		client = {
  			status = { hunger = 200000 },
  			anim = 'eating',
  			prop = 'burger',
  			usetime = 2500,
  			notification = 'You ate a delicious burger'
  		},
  	},
  	['cola'] = {
  		label = 'eCola',
  		weight = 350,
  		client = {
  			status = { thirst = 200000 },
  			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
  			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
  			usetime = 2500,
  			notification = 'You quenched your thirst with cola'
  		}
  	},
  	--[[['parachute'] = {
  		label = 'Parachute',
  		weight = 8000,
  		stack = false,
  		client = {
  			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
  			usetime = 1500
  		}
  	},
  
  	['garbage'] = {
  		label = 'Garbage',
  	},
  
  	['paperbag'] = {
  		label = 'Paper Bag',
  		weight = 1,
  		stack = false,
  		close = false,
  		consume = 0
  	},
  
  	['identification'] = {
  		label = 'Identification',
  	},]]--
  
  	["assaultrifle_drum"] = {
  		label = "Rifle Drum Clip",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"Attachment component\""
  	},
  
  	["assaultrifle_extendedclip"] = {
  		label = "Rifle EXT Clip",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"Attachment component\""
  	},
  
  	["assaultrifle_luxuryfinish"] = {
  		label = "Rifle Luxury Finish",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"Attachment component\""
  	},
  
  	["hat"] = {
  		label = "Hat",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"a hat\""
  	},
  
  	["large_backpack"] = {
  		label = "Backpack",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"Large Backpack\""
  	},
  
  	["medium_bag"] = {
  		label = "Bag",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"Medium Bag\""
  	},
  
  	["pants"] = {
  		label = "Pants",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"pants\""
  	},
  
  	["rifle_suppressor"] = {
  		label = "Rifle Suppressor",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"Attachment component\""
  	},
  
  	["shoes"] = {
  		label = "",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"An item\""
  	},
  
  	["small_backpack"] = {
  		label = "Backpack",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"Small Backpack\""
  	},
  
  	["storage_case"] = {
  		label = "Storage Case",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"Storage Case\""
  	},
  
  	["torso"] = {
  		label = "Torso",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"a torso\""
  	},
  
  	["tshirt"] = {
  		label = "Shirt",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"a shirt\""
  	},
  
  	["watch"] = {
  		label = "Watch",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"watch\""
  	},
  
  	["weapon_case"] = {
  		label = "Weapon Case",
  		weight = 1,
  		stack = true,
  		close = true,
  		description = "\"Large weapon case\""
  	},
  	['atmhacker'] = {
  		label = 'ATM Hacker',
  		weight = 750,
        description = 'Utiliser pour des activités malveillantes..',
  	},
  
  	["blowpipe"] = {
  		label = "Chalumeaux",
  		weight = 2,
  		stack = true,
  		close = true,
  	},
  
  	["carokit"] = {
  		label = "Kit carosserie",
  		weight = 3,
  		stack = true,
  		close = true,
  	},
  
  	["carotool"] = {
  		label = "outils carosserie",
  		weight = 2,
  		stack = true,
  		close = true,
  	},
  
  	["fixkit"] = {
  		label = "Kit réparation (moteur)",
  		weight = 3,
  		stack = true,
  		close = true,
  	},
  
  	["fixtool"] = {
  		label = "Outils réparation",
  		weight = 2,
  		stack = true,
  		close = true,
  	},

  	["gazbottle"] = {
  		label = "Bouteille de gaz",
  		weight = 2,
  		stack = true,
  		close = true,
  	},

  	["tablet"] = {
		label = "Tablette mécano",
		weight = 2,
		stack = true,
		close = true,
	},
	["carglass"] = {
		label = "fenêtre véhicule",
		weight = 2,
		stack = true,
		close = true,
	},
	["tire"] = {
		label = "Pneu",
		weight = 10,
		stack = true,
		close = true,
	},
	["superoil"] = {
		label = "Super OIL",
		weight = 1,
		stack = true,
		close = true,
	},
}