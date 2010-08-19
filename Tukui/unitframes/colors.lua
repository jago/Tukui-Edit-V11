if not TukuiCF["Unitframes"].enable then return end

------------------------------------------------------------------------
--	Colors
------------------------------------------------------------------------

TukuiDB.oUF_colors = setmetatable({
	tapped = { .55, .57, .61 },
	disconnected = { .3, .3, .3 },
	power = setmetatable({
		["MANA"] = 							 { .31, .45, .63 },
		["RAGE"] = 							 { .69, .31, .31 },
		["FOCUS"] = 						 { .71, .43, .27 },
		["ENERGY"] = 						 { .65, .63, .35 },
		["RUNES"] = 						 { .55, .57, .61 },
		["RUNIC_POWER"] =			 { 0, .82, 1 },
		["AMMOSLOT"] = 				 { .8, .6, 0 },
		["FUEL"] =							 { 0, .55, .5 },
		["POWER_TYPE_STEAM"] = { .55, .57, .61 },
		["POWER_TYPE_PYRITE"] = { .60, .09, .17 },
	}, {__index = oUF.colors.power}),
	happiness = setmetatable({
		[1] = { .69, .31, .31 },
		[2] = { .65, .63, .35 },
		[3] = { .33, .59, .33 },
	}, {__index = oUF.colors.happiness}),
	runes = setmetatable({
			[1] = { .69, .31, .31 },
			[2] = { .33, .59, .33 },
			[3] = { .31, .45, .63 },
			[4] = { .84, .75, .65 },
	}, {__index = oUF.colors.runes}),
	reaction = setmetatable({
		[1] = { 222/255, 95/255,  95/255 }, -- Hated
		[2] = { 222/255, 95/255,  95/255 }, -- Hostile
		[3] = { 222/255, 95/255,  95/255 }, -- Unfriendly
		[4] = { 218/255, 197/255, 92/255 }, -- Neutral
		[5] = { 75/255,  175/255, 76/255 }, -- Friendly
		[6] = { 75/255,  175/255, 76/255 }, -- Honored
		[7] = { 75/255,  175/255, 76/255 }, -- Revered
		[8] = { 75/255,  175/255, 76/255 }, -- Exalted	
	}, {__index = oUF.colors.reaction}),
	class = setmetatable({
		["DEATHKNIGHT"] = { 196/255,  30/255,  60/255 },
		["DRUID"]       = { 255/255, 125/255,  10/255 },
		["HUNTER"]      = { 171/255, 214/255, 116/255 },
		["MAGE"]        = { 104/255, 205/255, 255/255 },
		["PALADIN"]     = { 245/255, 140/255, 186/255 },
		["PRIEST"]      = { 212/255, 212/255, 212/255 },
		["ROGUE"]       = { 255/255, 243/255,  82/255 },
		["SHAMAN"]      = {  41/255,  79/255, 155/255 },
		["WARLOCK"]     = { 148/255, 130/255, 201/255 },
		["WARRIOR"]     = { 199/255, 156/255, 110/255 },
	}, {__index = oUF.colors.class}),
}, {__index = oUF.colors})