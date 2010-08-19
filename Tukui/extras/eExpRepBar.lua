--[[	

	(c) Eclípsé

]]

if not TukuiCF["ExpRepBar"].enable then return end

----------------------------------------------
-- Settings
----------------------------------------------

local statusTexture = TukuiCF["Textures"].empath
local textFont, textSize = TukuiCF["Fonts"].font, 12

local barWidth, barHeight = TukuiDB.Scale(TukuiMinimap:GetWidth() + 4), TukuiDB.Scale(24)

----------------------------------------------
-- Colors
----------------------------------------------

local factioncolors = {
	{ r = .9, g = .3, b = .3 }, -- Hated
	{ r = .7, g = .3, b = .3 }, -- Hostile
	{ r = .7, g = .3, b = .3 }, -- Unfriendly
	{ r = .8, g = .7, b = .4 }, -- Neutral
	{ r = .3, g = .7, b = .3 }, -- Friendly
	{ r = .3, g = .7, b = .3 }, -- Honored
	{ r = .3, g = .7, b = .3 }, -- Revered
	{ r = .3, g = .9, b = .3 }, -- Exalted
}

local xpcolors = {
	{ r = .8, g = .2, b = .2, a = .5 }, -- Normal
	{ r = .2, g = .2, b = .8, a = .5 }, -- Rested
}

----------------------------------------------
-- Function for shortened values
----------------------------------------------

local ShortValue = function(value)
	if value >= 1e6 then
		return ("%.1fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e3 or value <= -1e3 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return value
	end
end

----------------------------------------------
-- Setup main frame
----------------------------------------------

local mainFrame = CreateFrame("Frame", "TukuiMainFrame", UIParent)
TukuiDB.CreatePanel(mainFrame, barWidth, barHeight, "TOP", TukuiMinimap, "BOTTOM", 0, TukuiDB.Scale(-26))

----------------------------------------------
-- Setup main status bar
----------------------------------------------

local statusBar = CreateFrame("StatusBar", "TukuiStatusBar", mainFrame)
statusBar:SetPoint("TOPLEFT", mainFrame, TukuiDB.Scale(2), TukuiDB.Scale(-2))
statusBar:SetPoint("BOTTOMRIGHT", mainFrame, TukuiDB.Scale(-2), TukuiDB.Scale(2))
statusBar:SetStatusBarTexture(statusTexture)
statusBar:EnableMouse(true)

--------------------------------------------
-- Setup secondary status bar (shows rep if player is not max level)
--------------------------------------------

local extraBar = CreateFrame("StatusBar", "TukuiExtraBar", mainFrame)
extraBar:SetPoint("TOPLEFT", mainFrame, TukuiDB.Scale(2), TukuiDB.Scale(-(barHeight - 4)))
extraBar:SetPoint("BOTTOMRIGHT", mainFrame, TukuiDB.Scale(-2), TukuiDB.Scale(2))
extraBar:SetStatusBarTexture(statusTexture)
extraBar:Hide()

----------------------------------------------
-- Setup status bar text
----------------------------------------------

local statusText = statusBar:CreateFontString(nil, "OVERLAY")
statusText:SetPoint("CENTER", mainFrame, 0, 1)
statusText:SetFont(textFont, textSize)
statusText:SetShadowColor(0, 0, 0)
statusText:SetShadowOffset(1.25, -1.25)

----------------------------------------------
-- Update all values/bars/text
----------------------------------------------

local function event(self, event, ...)
	local name, id, min, max, value = GetWatchedFactionInfo()
	local colors = factioncolors[id]

	local currValue = UnitXP("player")
	local maxValue = UnitXPMax("player")
	local restXP = GetXPExhaustion()

	if UnitLevel("player") < MAX_PLAYER_LEVEL then
		statusBar:SetMinMaxValues(0, maxValue)
		statusBar:SetValue(currValue)
		
		if TukuiCF["ExpRepBar"].lowlevelshowrep and GetWatchedFactionInfo() then
			statusBar:SetPoint("BOTTOMRIGHT", mainFrame, TukuiDB.Scale(-2), TukuiDB.Scale(5))
		else
			statusBar:SetPoint("BOTTOMRIGHT", mainFrame, TukuiDB.Scale(-2), TukuiDB.Scale(2))
		end

		if restXP then
			if TukuiCF["ExpRepBar"].shortvalues then
				statusText:SetText(ShortValue(currValue).." / "..ShortValue(maxValue).." R: "..ShortValue(restXP))
			else
				statusText:SetText(currValue.." / "..maxValue.." R: "..restXP)
			end

			statusBar:SetStatusBarColor(xpcolors[2].r, xpcolors[2].g, xpcolors[2].b, xpcolors[2].a)
		else
			if TukuiCF["ExpRepBar"].shortvalues then
				statusText:SetText(ShortValue(currValue).." / "..ShortValue(maxValue))
			else
				statusText:SetText(currValue.." / "..maxValue)
			end
			
			statusBar:SetStatusBarColor(xpcolors[1].r, xpcolors[1].g, xpcolors[1].b, xpcolors[1].a)
		end
		
		extraBar:SetMinMaxValues(min, max)
		extraBar:SetValue(value)

		if TukuiCF["ExpRepBar"].lowlevelshowrep and GetWatchedFactionInfo() then
			extraBar:Show()
			extraBar:SetStatusBarColor(colors.r, colors.g, colors.b)
		else
			extraBar:Hide()
		end
	else
		statusBar:SetMinMaxValues(min, max)
		statusBar:SetValue(value)
		
		if id > 0 then
			if TukuiCF["ExpRepBar"].shortvalues then
				statusText:SetText(ShortValue(value - min).." / "..ShortValue(max - min))
			else
				statusText:SetText((value - min).." / "..(max - min))
			end

			statusBar:SetStatusBarColor(colors.r, colors.g, colors.b)
			
			mainFrame:Show()
		else
			mainFrame:Hide()
		end
	end
end

----------------------------------------------
-- Setup tooltip
----------------------------------------------

local function Tooltip()
	local titleColor = { r = .4, g = .78, b = 1 }
	local subColor = { r = 1, g = 1, b = 1 }
	local needColor = { r = .8, g = .2, b = .2 }
	local restColor = { r = .2, g = .2, b = .8 }

	local name, id, min, max, value = GetWatchedFactionInfo()
	local colors = factioncolors[id]
	
	local perMax = max - min
	local perGValue = value - min
	local perNValue = max - value
	
	local perGain = format("%.1f%%", (perGValue / perMax) * 100)
	local perNeed = format("%.1f%%", (perNValue / perMax) * 100)

	if UnitLevel("player") < MAX_PLAYER_LEVEL then
		local currValue = UnitXP("player")
		local maxValue = UnitXPMax("player")
		local restXP = GetXPExhaustion()
		
		local perMax = maxValue - currValue
		local perGain = format("%.1f%%", (currValue / maxValue) * 100)
		local perNeed = format("%.1f%%", (perMax / maxValue) * 100)
		
		local bars = format("%.1f", currValue / maxValue * 20)
		
		GameTooltip:SetOwner(mainFrame, 'ANCHOR_BOTTOMLEFT', TukuiDB.Scale(-3), barHeight)
		GameTooltip:AddLine("Experience:", titleColor.r, titleColor.g, titleColor.b)
		GameTooltip:AddDoubleLine("Bars: ", bars.." / 20", subColor.r, subColor.g, subColor.b, subColor.r, subColor.g, subColor.b)
		GameTooltip:AddDoubleLine("Gained: ", currValue.." ("..perGain..")", subColor.r, subColor.g, subColor.b, subColor.r, subColor.g, subColor.b)
		GameTooltip:AddDoubleLine("Needed: ", maxValue - currValue.." ("..perNeed..")", subColor.r, subColor.g, subColor.b, needColor.r, needColor.g, needColor.b)
		GameTooltip:AddDoubleLine("Total: ", maxValue, subColor.r, subColor.g, subColor.b, subColor.r, subColor.g, subColor.b)
		if restXP ~= nil and restXP > 0 then
			GameTooltip:AddDoubleLine("Rested:", restXP.." ("..format("%.f%%", restXP / maxValue * 100)..")", subColor.r, subColor.g, subColor.b, restColor.r, restColor.g, restColor.b)
		end
		if TukuiCF["ExpRepBar"].lowlevelshowrep and GetWatchedFactionInfo() then
			GameTooltip:AddLine' '
			GameTooltip:AddLine("Reputation:", titleColor.r, titleColor.g, titleColor.b)
			GameTooltip:AddDoubleLine("Faction: ", name, subColor.r, subColor.g, subColor.b, subColor.r, subColor.g, subColor.b)
			GameTooltip:AddDoubleLine("Standing: ", _G['FACTION_STANDING_LABEL'..id], subColor.r, subColor.g, subColor.b, colors.r, colors.g, colors.b)
			GameTooltip:AddDoubleLine("Gained: ", value - min.." ("..perGain..")", subColor.r, subColor.g, subColor.b, subColor.r, subColor.g, subColor.b)
			GameTooltip:AddDoubleLine("Needed: ", max - value.." ("..perNeed..")", subColor.r, subColor.g, subColor.b, needColor.r, needColor.g, needColor.b)
			GameTooltip:AddDoubleLine("Total: ", max - min, subColor.r, subColor.g, subColor.b, subColor.r, subColor.g, subColor.b)
		end
		GameTooltip:Show()
	else
		GameTooltip:SetOwner(mainFrame, 'ANCHOR_BOTTOMLEFT', TukuiDB.Scale(-3), barHeight)
		GameTooltip:AddLine("Reputation:", titleColor.r, titleColor.g, titleColor.b)
		GameTooltip:AddDoubleLine("Faction: ", name, subColor.r, subColor.g, subColor.b, subColor.r, subColor.g, subColor.b)
		GameTooltip:AddDoubleLine("Standing: ", _G['FACTION_STANDING_LABEL'..id], subColor.r, subColor.g, subColor.b, colors.r, colors.g, colors.b)
		GameTooltip:AddDoubleLine("Gained: ", value - min.." ("..perGain..")", subColor.r, subColor.g, subColor.b, subColor.r, subColor.g, subColor.b)
		GameTooltip:AddDoubleLine("Needed: ", max - value.." ("..perNeed..")", subColor.r, subColor.g, subColor.b, needColor.r, needColor.g, needColor.b)
		GameTooltip:AddDoubleLine("Total: ", max - min, subColor.r, subColor.g, subColor.b, subColor.r, subColor.g, subColor.b)
		GameTooltip:Show()
	end
end

statusBar:RegisterEvent("PLAYER_XP_UPDATE")
statusBar:RegisterEvent("PLAYER_LEVEL_UP")
statusBar:RegisterEvent("UPDATE_EXHAUSTION")
statusBar:RegisterEvent("UPDATE_FACTION")
statusBar:RegisterEvent("PLAYER_ENTERING_WORLD")

statusBar:SetScript("OnEvent", event)
statusBar:SetScript('OnLeave', GameTooltip_Hide)
statusBar:SetScript('OnEnter', Tooltip)	

extraBar:RegisterEvent("UPDATE_FACTION")
extraBar:RegisterEvent("PLAYER_ENTERING_WORLD")
	
extraBar:SetScript("OnEvent", event)
