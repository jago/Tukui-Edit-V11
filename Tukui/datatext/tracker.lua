--[[

	By Eclípsé

]]

if TukuiCF["Datatext"].tracker and TukuiCF["Datatext"].tracker > 0 then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("HIGH")
	Stat:EnableMouse(true)
	
	local Text  = TukuiDataLeft:CreateFontString(nil, "LOW")
	Text:SetFont(TukuiCF["Datatext"].font, TukuiCF["Datatext"].fontsize)
	Text:SetWidth(100)
	TukuiDB.PP(TukuiCF["Datatext"].tracker, Text)

	local function OnEvent(self)
	local tracking = false
		for i = 1, GetNumTrackingTypes() do
			local name, texture, active, category = GetTrackingInfo(i)
			if active then
				tracking = true
				if category == "spell" then
					Text:SetText(name)
				else
					Text:SetText("Tracking: "..name)
				end
			end
		end
		if not tracking then
			Text:SetText("Not Tracking")
		end
		self:SetAllPoints(Text)
	end
	
	Stat:RegisterEvent("PLAYER_LOGIN")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:RegisterEvent("MINIMAP_UPDATE_TRACKING")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnMouseDown", function(self) ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, "cursor", TukuiDB.Scale(0), TukuiDB.Scale(0)) end)
end
