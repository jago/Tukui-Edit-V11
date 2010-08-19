if not TukuiCF["Map"].enable then return end

----------------------------------------------
-- Settings/Variables
----------------------------------------------

local mapscale = WORLDMAP_WINDOWED_SIZE
local infoHeight = TukuiDB.Scale(20)

----------------------------------------------
-- Setup map border/background
----------------------------------------------

local map = CreateFrame("Frame", nil, WorldMapDetailFrame)
TukuiDB.SkinPanel(map)

----------------------------------------------
-- Setup map title frame
----------------------------------------------

local mapTitle = CreateFrame ("Frame", nil, WorldMapDetailFrame)
TukuiDB.SkinFadedPanel(mapTitle)
mapTitle:SetHeight(infoHeight)

----------------------------------------------
-- Setup map lock button/text/script
----------------------------------------------

local mapLock = CreateFrame ("Frame", nil, WorldMapDetailFrame)
mapLock:SetScale(1 / mapscale)
mapLock:SetHeight(infoHeight)
mapLock:SetWidth(35)
mapLock:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, "TOPRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(5))
TukuiDB.SkinPanel(mapLock)
mapLock:EnableMouse(true)
mapLock:Hide()

local lockText = mapLock:CreateFontString(nil, "OVERLAY")
lockText:SetFont(TukuiCF["Fonts"].font, 12)
lockText:SetPoint("CENTER", 0, 0)
lockText:SetText("Move")

mapLock:SetScript("OnMouseDown", function(self, LeftButton)
	if ( WORLDMAP_SETTINGS.selectedQuest ) then
		WorldMapBlobFrame:DrawQuestBlob(WORLDMAP_SETTINGS.selectedQuestId, false)
	end
	WorldMapScreenAnchor:ClearAllPoints()
	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:StartMoving()
end)

mapLock:SetScript("OnMouseUp", function(self)
	WorldMapFrame:StopMovingOrSizing()
	if ( WORLDMAP_SETTINGS.selectedQuest and not WORLDMAP_SETTINGS.selectedQuest.completed ) then
		WorldMapBlobFrame:DrawQuestBlob(WORLDMAP_SETTINGS.selectedQuestId, true)
	end 
	WorldMapScreenAnchor:StartMoving()
	WorldMapScreenAnchor:SetPoint("TOPLEFT", WorldMapFrame)
	WorldMapScreenAnchor:StopMovingOrSizing()
end)

----------------------------------------------
-- Setup map close button/text/script
----------------------------------------------

local mapClose = CreateFrame ("Frame", nil, WorldMapDetailFrame)
mapClose:SetScale(1 / mapscale)
mapClose:SetHeight(infoHeight)
mapClose:SetWidth(35)
mapClose:SetPoint("BOTTOMLEFT", WorldMapDetailFrame, "TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(5))
TukuiDB.SkinPanel(mapClose)
mapClose:EnableMouse(true)
mapClose:Hide()

local closeText = mapClose:CreateFontString(nil, "OVERLAY")
closeText:SetFont(TukuiCF["Fonts"].font, 12)
closeText:SetPoint("CENTER", 0, 0)
closeText:SetText("Close")

mapClose:SetScript("OnMouseUp", function(self) ToggleFrame(WorldMapFrame) end)

----------------------------------------------
-- Setup map expand button/text/script
----------------------------------------------

local mapExpand = CreateFrame ("Frame", nil, WorldMapDetailFrame)
mapExpand:SetScale(1 / mapscale)
mapExpand:SetHeight(infoHeight)
mapExpand:SetWidth(40)
mapExpand:SetPoint("TOPRIGHT", mapLock, "TOPLEFT", TukuiDB.Scale(-3), 0)
TukuiDB.SkinPanel(mapExpand)
mapExpand:EnableMouse(true)
mapExpand:Hide()

local expandText = mapExpand:CreateFontString(nil, "OVERLAY")
expandText:SetFont(TukuiCF["Fonts"].font, 12)
expandText:SetPoint("CENTER", 0, 0)
expandText:SetText("Expand")

mapExpand:SetScript("OnMouseUp", function(self) 
	WorldMapFrame_ToggleWindowSize()
end)

local SmallerMapSkin = function()
	-- new frame to put zone and title text in
	mapTitle:SetScale(1 / mapscale)
	mapTitle:SetFrameStrata("MEDIUM")
	mapTitle:SetFrameLevel(20)
	mapTitle:SetPoint("BOTTOMLEFT", WorldMapDetailFrame, "TOPLEFT", TukuiDB.Scale(36), TukuiDB.Scale(5))
	mapTitle:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, "TOPRIGHT", TukuiDB.Scale(-79), TukuiDB.Scale(5))
	
	map:SetScale(1 / mapscale)
	map:SetPoint("TOPLEFT", WorldMapDetailFrame, TukuiDB.Scale(-2), TukuiDB.Scale(2))
	map:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, TukuiDB.Scale(2), TukuiDB.Scale(-2))
	map:SetFrameStrata("MEDIUM")
	map:SetFrameLevel(20)
	
	-- move buttons / texts and hide default border
	WorldMapButton:SetAllPoints(WorldMapDetailFrame)
	
	WorldMapFrame:SetFrameStrata("MEDIUM")
	WorldMapFrame:SetClampedToScreen(true) 
	
	WorldMapDetailFrame:SetFrameStrata("MEDIUM")
	
	WorldMapTitleButton:Show()	
	mapLock:Show()
	mapClose:Show()
	mapExpand:Show()

	WorldMapFrameMiniBorderLeft:Hide()
	WorldMapFrameMiniBorderRight:Hide()
	WorldMapFrameCloseButton:Hide()
	WorldMapFrameSizeUpButton:Hide()

	WorldMapFrameSizeDownButton:SetPoint("TOPRIGHT", WorldMapFrameMiniBorderRight, "TOPRIGHT", TukuiDB.Scale(-66), TukuiDB.Scale(5))
	
	WorldMapQuestShowObjectives:ClearAllPoints()
	WorldMapQuestShowObjectives:SetPoint("BOTTOMRIGHT", WorldMapButton, "BOTTOMRIGHT", 0, TukuiDB.Scale(-1))
	WorldMapQuestShowObjectives:SetFrameStrata("HIGH")
	
	WorldMapQuestShowObjectivesText:SetFont(TukuiCF["Fonts"].font, 12, "OUTLINE")
	WorldMapQuestShowObjectivesText:ClearAllPoints()
	WorldMapQuestShowObjectivesText:SetPoint("RIGHT", WorldMapQuestShowObjectives, "LEFT", TukuiDB.Scale(-4), TukuiDB.Scale(1))
	
	WorldMapTrackQuest:ClearAllPoints()
	WorldMapTrackQuest:SetPoint("BOTTOMLEFT", WorldMapButton, "BOTTOMLEFT", 0, TukuiDB.Scale(-1))
	WorldMapTrackQuest:SetFrameStrata("HIGH")
	
	WorldMapTrackQuestText:SetFont(TukuiCF["Fonts"].font, 12, "OUTLINE")

	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:SetParent(mapTitle)
	WorldMapFrameTitle:SetPoint("CENTER",0, 0)
	WorldMapFrameTitle:SetFont(TukuiCF["Fonts"].font, 12)
	
	-- temporary
	WorldMapLevelDropDown:SetPoint("TOPRIGHT", WorldMapPositioningGuide, "TOPRIGHT", 0, TukuiDB.Scale(-30))

	WorldMapTitleButton:SetFrameStrata("MEDIUM")
	WorldMapTooltip:SetFrameStrata("TOOLTIP")

	-- fix tooltip not hidding after leaving quest # tracker icon
	WorldMapQuestPOI_OnLeave = function()
		WorldMapTooltip:Hide()
	end
end
hooksecurefunc("WorldMap_ToggleSizeDown", function() SmallerMapSkin() end)

local BiggerMapSkin = function()
	WorldMapFrameCloseButton:Show()
	mapLock:Hide()
	mapClose:Hide()
	mapExpand:Hide()
end
hooksecurefunc("WorldMap_ToggleSizeUp", function() BiggerMapSkin() end)