if TukuiCF["Datatext"].fps and TukuiCF["Datatext"].fps > 0 then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("HIGH")

	local Text  = TukuiDataLeft:CreateFontString(nil, "LOW")
	Text:SetFont(TukuiCF["Datatext"].font, TukuiCF["Datatext"].fontsize)
	TukuiDB.PP(TukuiCF["Datatext"].fps, Text)

	local int = 1
	local function Update(self, t)
		int = int - t
		if int < 0 then
			Text:SetText(floor(GetFramerate())..tukuilocal.datatext_fps..select(3, GetNetStats())..tukuilocal.datatext_ms)
			int = 1
		end	
	end

	Stat:SetScript("OnUpdate", Update) 
	Update(Stat, 10)
end