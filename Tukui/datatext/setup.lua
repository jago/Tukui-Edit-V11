function TukuiDB.PP(p, obj)
	if p == 1 then
		obj:SetHeight(TukuiDataLeft:GetHeight())
		obj:SetPoint("LEFT", TukuiDataLeft, 30, 0.5)
	elseif p == 2 then
		obj:SetHeight(TukuiDataLeft:GetHeight())
		obj:SetPoint("CENTER", TukuiDataLeft, 0, 0.5)
	elseif p == 3 then
		obj:SetHeight(TukuiDataLeft:GetHeight())
		obj:SetPoint("RIGHT", TukuiDataLeft, -30, 0.5)
	elseif p == 4 then
		obj:SetHeight(TukuiDataRight:GetHeight())
		obj:SetPoint("LEFT", TukuiDataRight, 30, 0.5)
	elseif p == 5 then
		obj:SetHeight(TukuiDataRight:GetHeight())
		obj:SetPoint("CENTER", TukuiDataRight, 0, 0.5)
	elseif p == 6 then
		obj:SetHeight(TukuiDataRight:GetHeight())
		obj:SetPoint("RIGHT", TukuiDataRight, -30, 0.5)
	elseif p == 7 then
		obj:SetHeight(TukuiDataBottom:GetHeight())
		obj:SetPoint("LEFT", TukuiDataBottom, 30, 0.5)
	elseif p == 8 then
		obj:SetHeight(TukuiDataBottom:GetHeight())
		obj:SetPoint("CENTER", TukuiDataBottom, 0, 0.5)
	elseif p == 9 then
		obj:SetHeight(TukuiDataBottom:GetHeight())
		obj:SetPoint("RIGHT", TukuiDataBottom, -30, 0.5)
	end
	
	if TukuiMinimap then
		if p == 10 then
			obj:SetHeight(TukuiMinimapDataLeft:GetHeight())
			obj:SetPoint("CENTER", TukuiMinimapDataLeft, 0, 0.5)
		elseif p == 11 then
			obj:SetHeight(TukuiMinimapDataRight:GetHeight())
			obj:SetPoint("CENTER", TukuiMinimapDataRight, 0, 0.5)
		end
	end
	
	if TukuiCF["Actionbars"].splitbar then
		if p == 12 then
			obj:SetHeight(TukuiLeftSplitData:GetHeight())
			obj:SetPoint("CENTER", TukuiLeftSplitData, 0, 0.5)
		elseif p == 13 then
			obj:SetHeight(TukuiRightSplitData:GetHeight())
			obj:SetPoint("CENTER", TukuiRightSplitData, 0, 0.5)
		end
	end
end