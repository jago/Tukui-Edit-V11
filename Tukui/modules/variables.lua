TukuiDB = { }
TukuiCF = { }
tukuilocal = { }

TukuiDB.dummy = function() return end
TukuiDB.myname, _ = UnitName("player")
_, TukuiDB.myclass = UnitClass("player") 
TukuiDB.client = GetLocale() 
TukuiDB.resolution = GetCurrentResolution()
TukuiDB.getscreenresolution = select(TukuiDB.resolution, GetScreenResolutions())
TukuiDB.version = GetAddOnMetadata("Tukui", "Version")
TukuiDB.release = GetAddOnMetadata("Tukui", "X-Release")
TukuiDB.incombat = UnitAffectingCombat("player")
TukuiDB.patch = GetBuildInfo()
TukuiDB.level = UnitLevel("player")