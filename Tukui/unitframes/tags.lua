if not TukuiCF["Unitframes"].enable then return end

------------------------------------------------------------------------
--	Tags
------------------------------------------------------------------------

local function ShortenValue(value)
	if(value >= 1e6) then
		return ('%.2fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
	elseif(value >= 1e4) then
		return ('%.1fk'):format(value / 1e3):gsub('%.?0+([km])$', '%1')
	else
		return value
	end
end

oUF.TagEvents['Tukui:threat'] = 'UNIT_THREAT_LIST_UPDATE'
oUF.Tags['Tukui:threat'] = function(unit)
	local tanking, status, percent = UnitDetailedThreatSituation('player', 'target')
	if(percent and percent > 0) then
		return ('%s%d%%|r'):format(Hex(GetThreatStatusColor(status)), percent)
	end
end

oUF.Tags['Tukui:health'] = function(unit)
	local min, max = UnitHealth(unit), UnitHealthMax(unit)
	local status = not UnitIsConnected(unit) and 'Offline' or UnitIsGhost(unit) and 'Ghost' or UnitIsDead(unit) and 'Dead'

	if(status) then
		return status
	elseif(unit == 'target' and UnitCanAttack('player', unit)) then
		return ('%s (%d|cff0090ff%%|r)'):format(ShortenValue(min), min / max * 100)
	elseif(unit == 'player' and min ~= max) then
		return ('|cffff8080%d|r %d|cff0090ff%%|r'):format(min - max, min / max * 100)
	elseif(min ~= max) then
		return ('%s |cff0090ff/|r %s'):format(ShortenValue(min), ShortenValue(max))
	else
		return max
	end
end

oUF.Tags['Tukui:power'] = function(unit)
	local power = UnitPower(unit)
	if(power > 0 and not UnitIsDeadOrGhost(unit)) then
		local _, type = UnitPowerType(unit)
		local colors = _COLORS.power
		return ('%s%d|r'):format(Hex(colors[type] or colors['RUNES']), power)
	end
end

oUF.Tags['Tukui:druid'] = function(unit)
	local min, max = UnitPower(unit, 0), UnitPowerMax(unit, 0)
	if(UnitPowerType(unit) ~= 0 and min ~= max) then
		return ('|cff0090ff%d%%|r'):format(min / max * 100)
	end
end

oUF.TagEvents['Tukui:diffcolor'] = 'UNIT_LEVEL'
oUF.Tags['Tukui:diffcolor'] = function(unit)
	local r, g, b
	local level = UnitLevel(unit)
	if (level < 1) then
		r, g, b = 0.69, 0.31, 0.31
	else
		local DiffColor = UnitLevel('target') - UnitLevel('player')
		if (DiffColor >= 5) then
			r, g, b = 0.69, 0.31, 0.31
		elseif (DiffColor >= 3) then
			r, g, b = 0.71, 0.43, 0.27
		elseif (DiffColor >= -2) then
			r, g, b = 0.84, 0.75, 0.65
		elseif (-DiffColor <= GetQuestGreenRange()) then
			r, g, b = 0.33, 0.59, 0.33
		else
			r, g, b = 0.55, 0.57, 0.61
		end
	end
	return string.format('|cff%02x%02x%02x', r * 255, g * 255, b * 255)
end

local utf8sub = function(string, i, dots)
	if not string then return end
	local bytes = string:len()
	if (bytes <= i) then
		return string
	else
		local len, pos = 0, 1
		while(pos <= bytes) do
			len = len + 1
			local c = string:byte(pos)
			if (c > 0 and c <= 127) then
				pos = pos + 1
			elseif (c >= 192 and c <= 223) then
				pos = pos + 2
			elseif (c >= 224 and c <= 239) then
				pos = pos + 3
			elseif (c >= 240 and c <= 247) then
				pos = pos + 4
			end
			if (len == i) then break end
		end

		if (len == i and pos <= bytes) then
			return string:sub(1, pos - 1)..(dots and '...' or '')
		else
			return string
		end
	end
end


oUF.TagEvents['Tukui:getnamecolor'] = 'UNIT_HAPPINESS'
oUF.Tags['Tukui:getnamecolor'] = function(unit)
	local reaction = UnitReaction(unit, 'player')
	if (unit == 'pet' and GetPetHappiness()) then
		local c = TukuiDB.oUF_colors.happiness[GetPetHappiness()]
		return string.format('|cff%02x%02x%02x', c[1] * 255, c[2] * 255, c[3] * 255)
	elseif (UnitIsPlayer(unit)) then
		return _TAGS['raidcolor'](unit)
	elseif (reaction) then
		local c = TukuiDB.oUF_colors.reaction[reaction]
		return string.format('|cff%02x%02x%02x', c[1] * 255, c[2] * 255, c[3] * 255)
	else
		r, g, b = .84,.75,.65
		return string.format('|cff%02x%02x%02x', r * 255, g * 255, b * 255)
	end
end

oUF.TagEvents['Tukui:nameshort'] = 'UNIT_NAME_UPDATE'
oUF.Tags['Tukui:nameshort'] = function(unit)
	local name = UnitName(unit)
	return utf8sub(name, 10, false)
end

oUF.TagEvents['Tukui:namemedium'] = 'UNIT_NAME_UPDATE'
oUF.Tags['Tukui:namemedium'] = function(unit)
	local name = UnitName(unit)
	return utf8sub(name, 15, true)
end

oUF.TagEvents['Tukui:namelong'] = 'UNIT_NAME_UPDATE'
oUF.Tags['Tukui:namelong'] = function(unit)
	local name = UnitName(unit)
	return utf8sub(name, 20, true)
end

--------------------------------------------
-- Eclípsé custom tags below
--------------------------------------------

oUF.TagEvents["Tukui:pmlooter"] = "PARTY_LOOT_METHOD_CHANGED", "PARTY_MEMBERS_CHANGED"
oUF.Tags["Tukui:pmlooter"] = function(unit)
	local typeLoot, partyID, _ = GetLootMethod()
	if (typeLoot == "master") then
		if (partyID) then
			if (partyID == 0) then
				return (unit == "player") and "|CFFCC3333ML|r"
			else
				return (unit == "party"..partyID) and "|CFFCC3333ML|r"
			end
		end
	end
end
	
oUF.TagEvents["Tukui:rmlooter"] = "PARTY_LOOT_METHOD_CHANGED", "PARTY_MEMBERS_CHANGED"
oUF.Tags["Tukui:rmlooter"] = function(unit)
	local typeLoot, _, raidID = GetLootMethod()
	if (typeLoot == "master") then
		if (raidID) then
			if (raidID == 0) then
				return (unit == "player") and "|CFFCC3333ML|r"
			else
				return (unit == "raid"..raidID) and "|CFFCC3333ML|r"
			end
		end
	end
end
	
oUF.TagEvents["Tukui:dps_name_offline"] =  "PLAYER_FLAGS_CHANGED", "PARTY_MEMBER_DISBALE", "PARTY_MEMBER_DISABLE" , "UNIT_NAME_UPDATE"
oUF.Tags["Tukui:dps_name_offline"] = function(unit)
	if not UnitIsConnected(unit) then
		return "|CFFCC3333Offline|r"
	elseif UnitIsAFK(unit) then
		return "|CFFCC3333AFK|r"		
	else
		local name = UnitName(unit)
		return utf8sub(name, 8, false)
	end
end

oUF.TagEvents["Tukui:dps_dead"] = "UNIT_HEALTH", "PARTY_LEADER_CHANGED"
oUF.Tags["Tukui:dps_dead"] = function(unit)
	if UnitIsDead(unit) then
		if UnitIsPartyLeader(unit) then
			return "|CFFCC3333 D|r"
		else
			return "|CFFCC3333D|r"
		end
	elseif UnitIsGhost(unit) then
		if UnitIsPartyLeader(unit) then
			return "|CFFCC3333 G|r"
		else
			return "|CFFCC3333G|r"
		end
	end
end
	
oUF.TagEvents["Tukui:leader"] = "PARTY_LEADER_CHANGED"
oUF.Tags["Tukui:leader"] = function(unit) if UnitIsPartyLeader(unit) then return "|CFFCC3333L|r" end end
