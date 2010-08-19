if TukuiCF["Datatext"].arp and TukuiCF["Datatext"].arp > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("HIGH")

	local Text  = TukuiDataLeft:CreateFontString(nil, "LOW")
	Text:SetFont(TukuiCF["Datatext"].font, TukuiCF["Datatext"].fontsize)
	TukuiDB.PP(TukuiCF["Datatext"].arp, Text)
   
	local int = 1

	local function Update(self, t)
	int = int - t
		if int < 0 then
			Text:SetText(GetCombatRating(25) .. " " .. tukuilocal.datatext_playerarp)
			int = 1
		end
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end