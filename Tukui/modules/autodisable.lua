------------------------------------------------------------------------
-- prevent action bar users config errors
------------------------------------------------------------------------

if TukuiCF["Actionbars"].rightbars > 3 then
	TukuiCF["Actionbars"].rightbars = 3
end

------------------------------------------------------------------------
-- temporary healermode no portrait crap
------------------------------------------------------------------------

if TukuiCF["Unitframes"].healermode then
	TukuiCF["Unitframes"].charportrait = false
end

if TukuiDB.lowversion then
	TukuiCF["Unitframes"].healermode = false
end

------------------------------------------------------------------------
-- overwrite font for some language
------------------------------------------------------------------------

if TukuiDB.client == "ruRU" then
	TukuiCF["Fonts"].uffont = [[fonts\ARIALN.ttf]]
elseif TukuiDB.client == "zhTW" or TukuiDB.client == "zhCN" then
	TukuiCF["Fonts"].uffont = [[fonts\bLEI00D.ttf]]
	TukuiCF["Fonts"].font = [[fonts\bLEI00D.ttf]]
	TukuiCF["Fonts"].dmgfont = [[fonts\bLEI00D.ttf]]
end

------------------------------------------------------------------------
-- auto-overwrite script config is X mod is found
------------------------------------------------------------------------

-- because users are too lazy to disable feature in config file
-- adding an auto disable if some mods are loaded

if (IsAddOnLoaded("Stuf") or IsAddOnLoaded("PitBull4") or IsAddOnLoaded("ShadowedUnitFrames") or IsAddOnLoaded("ag_UnitFrames")) then
	TukuiCF["Unitframes"].enable = false
end

if (IsAddOnLoaded("TidyPlates") or IsAddOnLoaded("Aloft")) then
	TukuiCF["Nameplates"].enable = false
end

if (IsAddOnLoaded("Dominos") or IsAddOnLoaded("Bartender4") or IsAddOnLoaded("Macaroon")) then
	TukuiCF["Actionbars"].enable = false
end

if (IsAddOnLoaded("Mapster")) then
	TukuiCF["Map"].enable = false
end

if (IsAddOnLoaded("Prat") or IsAddOnLoaded("Chatter")) then
	TukuiCF["Chat"].enable = false
end

if (IsAddOnLoaded("Quartz") or IsAddOnLoaded("AzCastBar") or IsAddOnLoaded("eCastingBar")) then
	TukuiCF["Unitframes"].unitcastbar = false
end

if (IsAddOnLoaded("TipTac")) then
	TukuiCF["Tooltip"].enable = false
end