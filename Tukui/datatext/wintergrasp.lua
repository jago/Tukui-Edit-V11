if TukuiCF["Datatext"].wintergrasp and TukuiCF["Datatext"].wintergrasp > 0 then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("HIGH")
	Stat:EnableMouse(true)
	
	local Text  = TukuiDataLeft:CreateFontString(nil, "LOW")
	Text:SetFont(TukuiCF["Datatext"].font, TukuiCF["Datatext"].fontsize)
	TukuiDB.PP(TukuiCF["Datatext"].wintergrasp, Text)

	local function Update(self)
		local wgtime = GetWintergraspWaitTime() or nil
		local inInstance, instanceType = IsInInstance()
			if not ( instanceType == "none" ) then
				Text:SetText("Wintergrasp: "..QUEUE_TIME_UNAVAILABLE)
			elseif wgtime == nil then
				Text:SetText("Wintergrasp: "..WINTERGRASP_IN_PROGRESS)
			else
				Text:SetText("WG: "..SecondsToTime(wgtime))
			end
		self:SetAllPoints(Text)
	end
	
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:RegisterEvent("PLAYER_LOGIN")
	Stat:SetScript("OnUpdate", Update)
	Stat:SetScript("OnMouseDown", function() ToggleFrame(WorldMapFrame) SetMapZoom(4 , 11) end)
	Update(Stat, 10)
end
