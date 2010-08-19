if TukuiCF["Datatext"].avoidance and TukuiCF["Datatext"].avoidance > 0 then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("HIGH")
	Stat:EnableMouse(true)

	local Text  = TukuiDataLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF["Datatext"].font, TukuiCF["Datatext"].fontsize)
	TukuiDB.PP(TukuiCF["Datatext"].avoidance, Text)

	local function Update(self)
		local format = string.format
		local targetlv, playerlv = UnitLevel("target"), UnitLevel("player")
		if targetlv == -1 then
			basemisschance = (5 - (3*.2))  --Boss Value
			leveldifference = 3
		elseif targetlv > playerlv then
			basemisschance = (5 - ((targetlv - playerlv)*.2)) --Mobs above player level
			leveldifference = (targetlv - playerlv)
		elseif targetlv < playerlv and targetlv > 0 then
			basemisschance = (5 + ((playerlv - targetlv)*.2)) --Mobs below player level
			leveldifference = (targetlv - playerlv)
		else
			basemisschance = 5 --Sets miss chance of attacker level if no target exists, lv80=5, 81=4.2, 82=3.4, 83=2.6
			leveldifference = 0
		end

		if leveldifference >= 0 then
			dodge = (GetDodgeChance()-leveldifference*.2)
			parry = (GetParryChance()-leveldifference*.2)
			block = (GetBlockChance()-leveldifference*.2)
			MissChance = (basemisschance + 1/(0.0625 + 0.956/(GetCombatRating(CR_DEFENSE_SKILL)/4.91850*0.04)))
			avoidance = (dodge+parry+block+MissChance)
			Text:SetText(tukuilocal.datatext_playeravd.."|r"..format("%.2f", avoidance))
		else
			dodge = (GetDodgeChance()+abs(leveldifference*.2))
			parry = (GetParryChance()+abs(leveldifference*.2))
			block = (GetBlockChance()+abs(leveldifference*.2))
			MissChance = (basemisschance + 1/(0.0625 + 0.956/(GetCombatRating(CR_DEFENSE_SKILL)/4.91850*0.04)))
			avoidance = (dodge+parry+block+MissChance)
			Text:SetText(tukuilocal.datatext_playeravd.."|r"..format("%.2f", avoidance))
		end

		self:SetAllPoints(Text)
		self:SetScript("OnEnter", function()
			if not InCombatLockdown() then
				GameTooltip:SetOwner(this, "ANCHOR_TOP", 0, TukuiDB.Scale(6));
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, TukuiDB.mult)
				GameTooltip:ClearLines()
				if targetlv > 1 then
					GameTooltip:AddDoubleLine(tukuilocal.datatext_avoidancebreakdown.." ("..tukuilocal.datatext_lvl.." "..targetlv..")")
				elseif targetlv == -1 then
					GameTooltip:AddDoubleLine(tukuilocal.datatext_avoidancebreakdown.." ("..tukuilocal.datatext_boss..")")
				else
					GameTooltip:AddDoubleLine(tukuilocal.datatext_avoidancebreakdown.." ("..tukuilocal.datatext_lvl.." "..playerlv..")")
				end
				GameTooltip:AddDoubleLine(tukuilocal.datatext_miss,format("%.2f",MissChance) .. "%",1,1,1,  1,1,1)
				GameTooltip:AddDoubleLine(tukuilocal.datatext_dodge,format("%.2f",dodge) .. "%",1,1,1,  1,1,1)
				GameTooltip:AddDoubleLine(tukuilocal.datatext_parry,format("%.2f",parry) .. "%",1,1,1,  1,1,1)
				GameTooltip:AddDoubleLine(tukuilocal.datatext_block,format("%.2f",block) .. "%",1,1,1,  1,1,1)
				GameTooltip:Show()
			end
		end)
		self:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end

	Stat:RegisterEvent("UNIT_AURA")
	Stat:RegisterEvent("UNIT_INVENTORY_CHANGED")
	Stat:RegisterEvent("PLAYER_TARGET_CHANGED")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnEvent", Update)
end