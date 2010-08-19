local Panels = TukuiCF["Panels"]
local Actionbars = TukuiCF["Actionbars"]

-- setup bottom data panel
local databottom = CreateFrame("Frame", "TukuiDataBottom", UIParent)
TukuiDB.CreatePanel(databottom, (Actionbars.buttonsize * 12 + Actionbars.buttonspacing * 11), Panels.infoheight, "BOTTOM", UIParent, "BOTTOM", 0, TukuiDB.Scale(14))

-- setup data panels under split bars
if Actionbars.splitbar then
	local leftsd = CreateFrame("Frame", "TukuiLeftSplitData", UIParent)
	TukuiDB.CreatePanel(leftsd, (Actionbars.buttonsize * 3 + Actionbars.buttonspacing * 2), Panels.infoheight, "RIGHT", databottom, "LEFT", TukuiDB.Scale(-3), 0)

	local rightsd = CreateFrame("Frame", "TukuiRightSplitData", UIParent)
	TukuiDB.CreatePanel(rightsd, (Actionbars.buttonsize * 3 + Actionbars.buttonspacing * 2), Panels.infoheight, "LEFT", databottom, "RIGHT", TukuiDB.Scale(3), 0)
end

-- setup left data panel
local dataleft = CreateFrame("Frame", "TukuiDataLeft", UIParent)
TukuiDB.CreatePanel(dataleft, Panels.infowidth, Panels.infoheight, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", TukuiDB.Scale(14), TukuiDB.Scale(14))

-- setup right data panel
local dataright = CreateFrame("Frame", "TukuiDataRight", UIParent)
TukuiDB.CreatePanel(dataright, Panels.infowidth, Panels.infoheight, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", TukuiDB.Scale(-14), TukuiDB.Scale(14))

-- setup left chat faded background and chat tabs
local chatleft = CreateFrame("Frame", "TukuiChatLeftBg", UIParent)
TukuiDB.CreateFadedPanel(chatleft, Panels.infowidth, 117, "BOTTOM", dataleft, "TOP", 0, TukuiDB.Scale(3))

local chatltabs = CreateFrame("Frame", "TukuiChatLeftTabs", UIParent)
TukuiDB.CreateFadedPanel(chatltabs, Panels.infowidth, Panels.infoheight - 1, "BOTTOM", chatleft, "TOP", 0, TukuiDB.Scale(3))

-- setup right chat faded background and chat tabs
local chatright = CreateFrame("Frame", "TukuiChatRightBg", UIParent)
TukuiDB.CreateFadedPanel(chatright, Panels.infowidth, 117, "BOTTOM", dataright, "TOP", 0, TukuiDB.Scale(3))

local chatrtabs = CreateFrame("Frame", "TukuiChatRightTabs", UIParent)
TukuiDB.CreateFadedPanel(chatrtabs, Panels.infowidth, Panels.infoheight - 1, "BOTTOM", chatright, "TOP", 0, TukuiDB.Scale(3))

-- setup minimap data panels
if TukuiMinimap then
	local minimapdataleft = CreateFrame("Frame", "TukuiMinimapDataLeft", TukuiMinimap)
	TukuiDB.CreatePanel(minimapdataleft, ((TukuiMinimap:GetWidth() + 4) / 2) - 2, 20, "TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
	
	local minimapdataright = CreateFrame("Frame", "TukuiMinimapDataRight", TukuiMinimap)
	TukuiDB.CreatePanel(minimapdataright, ((TukuiMinimap:GetWidth() + 4) / 2) - 2, 20, "TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, TukuiDB.Scale(-3))
end