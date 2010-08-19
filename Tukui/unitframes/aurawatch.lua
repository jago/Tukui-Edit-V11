--------------------------------------------------------------------------------------------
-- New Aurawatch by Foof
--------------------------------------------------------------------------------------------

if TukuiCF["Unitframes"].aurawatch then
	-- Classbuffs { spell ID, position [, {r,g,b,a}][, anyUnit] }
	TukuiDB.buffids = {
		PRIEST = {
			{6788, "TOPLEFT", {1, 0, 0}, true}, -- Weakened Soul
			{48113, "TOPRIGHT", {0.2, 0.7, 0.2}}, -- Prayer of Mending
			{48068, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, -- Renew
			{48066, "BOTTOMRIGHT", {0.81, 0.85, 0.1}, true}, -- Power Word: Shield
		},
		DRUID = {
			{48440, "TOPLEFT", {0.8, 0.4, 0.8}}, -- Rejuvenation
			{48443, "TOPRIGHT", {0.2, 0.8, 0.2}}, -- Regrowth
			{48450, "BOTTOMLEFT", {0.4, 0.8, 0.2}}, -- Lifebloom
			{53249, "BOTTOMRIGHT", {0.8, 0.4, 0}}, -- Wild Growth
		},
		PALADIN = {
			{53563, "TOPLEFT", {0.7, 0.3, 0.7}}, -- Beacon of Light
			{53601, "TOPRIGHT", {0.4, 0.7, 0.2}}, -- Sacred Shield
		},
		SHAMAN = {
			{61301, "TOPLEFT", {0.7, 0.3, 0.7}}, -- Riptide 
			{49284, "TOPRIGHT", {0.2, 0.7, 0.2}}, -- Earthliving Weapon
			{16237, "BOTTOMLEFT", {0.4, 0.7, 0.2}}, -- Ancestral Fortitude
			{52000, "BOTTOMRIGHT", {0.7, 0.4, 0}}, -- Earthliving
		},
		ALL = {
			-- {2893, "RIGHT", {0, 1, 0}}, -- Abolish Poison
			{23333, "LEFT", {1, 0, 0}}, -- Warsong flag xD
		},
	}
	
	-- Raid debuffs
	TukuiDB.debuffids = {
		-- Naxxramas
		27808, -- Frost Blast
		32407, -- Strange Aura
		28408, -- Chains of Kel'Thuzad

		-- Ulduar
		66313, -- Fire Bomb
		63134, -- Sara's Blessing
		62717, -- Slag Pot
		63018, -- Searing Light
		64233, -- Gravity Bomb
		63495, -- Static Disruption

		-- Trial of the Crusader
		66406, -- Snobolled!
		67574, -- Pursued by Anub'arak
		68509, -- Penetrating Cold
		67651, -- Arctic Breath
		68127, -- Legion Flame
		67049, -- Incinerate Flesh
		66869, -- Burning Bile
		66823, -- Paralytic Toxin

		-- Icecrown Citadel
		71224, -- Mutated Infection
		71822, -- Shadow Resonance
		70447, -- Volatile Ooze Adhesive
		72293, -- Mark of the Fallen Champion
		72448, -- Rune of Blood
		71473, -- Essence of the Blood Queen
		71624, -- Delirious Slash
		70923, -- Uncontrollable Frenzy
		70588, -- Suppression
		71738, -- Corrosion
		71733, -- Acid Burst
		72108, -- Death and Decay
		71289, -- Dominate Mind
		69762, -- Unchained Magic
		69651, -- Wounding Strike
		69065, -- Impaled
		71218, -- Vile Gas
		72442, -- Boiling Blood
		72769, -- Scent of Blood (heroic)
		69279, -- Gas Spore
		70949, -- Essence of the Blood Queen (hand icon)
		72151, -- Frenzied Bloodthirst (bite icon)
		71474, -- Frenzied Bloodthirst (red bite icon)
		71340, -- Pact of the Darkfallen
		72985, -- Swarming Shadows (pink icon)
		71267, -- Swarming Shadows (black purple icon)
		71264, -- Swarming Shadows (swirl icon)
		71807, -- Glittering Sparks
		70873, -- Emerald Vigor
		71283, -- Gut Spray
		69766, -- Instability
		70126, -- Frost Beacon
		70157, -- Ice Tomb
		71056, -- Frost Breath
		70106, -- Chilled to the Bone
		70128, -- Mystic Buffet
		73785, -- Necrotic Plague
		73779, -- Infest
		73800, -- Soul Shriek
		73797, -- Soul Reaper
		73708, -- Defile
		74322, -- Harvested Soul
		
		--Ruby Sanctum
		74502, --Enervating Brand
		75887, --Blazing Aura  
		74562, --Fiery Combustion
		74567, --Mark of Combustion (Fire)
		74792, --Soul Consumption
		74795, --Mark Of Consumption (Soul)

		-- Other debuff
		6215, -- Fear
		67479, -- Impale
		552, -- test with abolish disease
	}
end

--------------------------------------------------------------------------------------------
-- THE AURAWATCH FUNCTION ITSELF. HERE BE DRAGONS!
--------------------------------------------------------------------------------------------

TukuiDB.countOffsets = {
	TOPLEFT = { TukuiDB.Scale(6), TukuiDB.Scale(1) },
	TOPRIGHT = { -TukuiDB.Scale(6), TukuiDB.Scale(1) },
	BOTTOMLEFT = { TukuiDB.Scale(6), TukuiDB.Scale(1) },
	BOTTOMRIGHT = { -TukuiDB.Scale(6), TukuiDB.Scale(1) },
	LEFT = { TukuiDB.Scale(6), TukuiDB.Scale(1) },
	RIGHT = { -TukuiDB.Scale(6), TukuiDB.Scale(1) },
	TOP = { 0, 0 },
	BOTTOM = { 0, 0 },
}

function TukuiDB.auraIcon(self, icon)
	TukuiDB.SetTemplate(icon)
	icon.icon:SetPoint("TOPLEFT", TukuiDB.Scale(1), -TukuiDB.Scale(1))
	icon.icon:SetPoint("BOTTOMRIGHT", -TukuiDB.Scale(1), TukuiDB.Scale(1))
	icon.icon:SetTexCoord(.08, .92, .08, .92)
	icon.icon:SetDrawLayer("ARTWORK")
	if (icon.cd) then
		icon.cd:SetReverse()
	end
	icon.overlay:SetTexture()
end

local _, class = UnitClass("player")
function TukuiDB.createAuraWatch(self, unit)
	local auras = CreateFrame("Frame", nil, self)
	auras:SetPoint("TOPLEFT", self.Health, TukuiDB.Scale(2), -TukuiDB.Scale(2))
	auras:SetPoint("BOTTOMRIGHT", self.Health, -TukuiDB.Scale(2), TukuiDB.Scale(2))
	auras.presentAlpha = 1
	auras.missingAlpha = 0
	auras.icons = {}
	auras.PostCreateIcon = TukuiDB.auraIcon

	if (not TukuiCF["Unitframes"].auratimer) then
		auras.hideCooldown = true
	end

	local buffs = {}
	local debuffs = TukuiDB.debuffids

	if (TukuiDB.buffids["ALL"]) then
		for key, value in pairs(TukuiDB.buffids["ALL"]) do
			tinsert(buffs, value)
		end
	end

	if (TukuiDB.buffids[TukuiDB.myclass]) then
		for key, value in pairs(TukuiDB.buffids[TukuiDB.myclass]) do
			tinsert(buffs, value)
		end
	end

	-- "Cornerbuffs"
	if (buffs) then
		for key, spell in pairs(buffs) do
			local icon = CreateFrame("Frame", nil, auras)
			icon.spellID = spell[1]
			icon.anyUnit = spell[4]
			icon:SetWidth(TukuiDB.Scale(6))
			icon:SetHeight(TukuiDB.Scale(6))
			icon:SetPoint(spell[2], 0, 0)

			local tex = icon:CreateTexture(nil, "OVERLAY")
			tex:SetAllPoints(icon)
			tex:SetTexture(TukuiCF["Textures"].blank)
			if (spell[3]) then
				tex:SetVertexColor(unpack(spell[3]))
			else
				tex:SetVertexColor(0.8, 0.8, 0.8)
			end

			local count = icon:CreateFontString(nil, "OVERLAY")
			count:SetFont(TukuiCF["Fonts"].font, 8, "THINOUTLINE")
			count:SetPoint("CENTER", unpack(TukuiDB.countOffsets[spell[2]]))
			icon.count = count

			auras.icons[spell[1]] = icon
		end
	end

	-- Raid debuffs (Big icon in the middle)
	if TukuiCF["Unitframes"].auradebuff then
		if (debuffs) then
			for key, spellID in pairs(debuffs) do
				local icon = CreateFrame("Frame", nil, auras)
				icon.spellID = spellID
				icon.anyUnit = true
				icon:SetWidth(TukuiDB.Scale(22))
				icon:SetHeight(TukuiDB.Scale(22))
				icon:SetPoint("CENTER", 0, 0)

				local count = icon:CreateFontString(nil, "OVERLAY")
				count:SetFont(TukuiCF["Fonts"].font, 9, "THINOUTLINE")
				count:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(2))
				icon.count = count

				auras.icons[spellID] = icon
			end
		end
	end
	
	self.AuraWatch = auras
end