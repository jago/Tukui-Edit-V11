local Colors = TukuiCF["Colors"]
local Textures = TukuiCF["Textures"]

function TukuiDB.UIScale()
	-- the tukui high reso whitelist
	if not (TukuiDB.getscreenresolution == "1680x945"
		or TukuiDB.getscreenresolution == "2560x1440" 
		or TukuiDB.getscreenresolution == "1680x1050" 
		or TukuiDB.getscreenresolution == "1920x1080" 
		or TukuiDB.getscreenresolution == "1920x1200" 
		or TukuiDB.getscreenresolution == "1600x900" 
		or TukuiDB.getscreenresolution == "2048x1152" 
		or TukuiDB.getscreenresolution == "1776x1000" 
		or TukuiDB.getscreenresolution == "2560x1600" 
		or TukuiDB.getscreenresolution == "1600x1200") then
			if TukuiCF["General"].overridelowtohigh == true then
				TukuiCF["General"].autoscale = false
				TukuiDB.lowversion = false
			else
				TukuiDB.lowversion = true
			end			
	end

	if TukuiCF["General"].autoscale == true then
		-- i'm putting a autoscale feature mainly for an easy auto install process
		-- we all know that it's not very effective to play via 1024x768 on an 0.64 uiscale :P
		-- with this feature on, it should auto choose a very good value for your current reso!
		TukuiCF["General"].uiscale = 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")
	end
end
TukuiDB.UIScale()

-- pixel perfect script of custom ui scale.
local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/TukuiCF["General"].uiscale
local function scale(x)
    return mult*math.floor(x/mult+.5)
end

function TukuiDB.Scale(x) return scale(x) end
TukuiDB.mult = mult

-- setup backdrop texture.
local backdrop = {
	bgFile = Textures.empath,
	edgeFile = Textures.blank,
	tile = false,
	tileSize = 0,
	edgeSize = mult,
	insets = { left = -mult, right = -mult, top = -mult, bottom = -mult }
}

-- setup backdrop for faded panels
local fadedbackdrop = {
	bgFile = Textures.blank,
	edgeFile = Textures.blank,
	tile = false,
	tileSize = 0,
	edgeSize = mult,
	insets = { left = -mult, right = -mult, top = -mult, bottom = -mult }
}

-- setup shadow border texture.
local shadows = {
	edgeFile = Textures.glow, 
	edgeSize = 3,
	insets = { left = mult, right = mult, top = mult, bottom = mult }
}

-- create shadow frame
function TukuiDB.CreateShadow(f)
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -3, 3)
	shadow:SetPoint("BOTTOMRIGHT", 3, -3)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, .5)
end

-- let's skin our panels!
function TukuiDB.SkinPanel(f)
	f:SetBackdrop(backdrop)
	f:SetBackdropColor(unpack(Colors.backdropcolor))
	f:SetBackdropBorderColor(unpack(Colors.bordercolor))
	if TukuiCF["Panels"].shadows then
		TukuiDB.CreateShadow(f)
	end
end

-- finally create them
function TukuiDB.CreatePanel(f, w, h, a1, p, a2, x, y)
	sh = scale(h)
	sw = scale(w)
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	TukuiDB.SkinPanel(f)
end

-- this is used for panels that don't use shadows
function TukuiDB.SetTemplate(f)
	f:SetBackdrop(backdrop)
	f:SetBackdropColor(unpack(Colors.backdropcolor))
	f:SetBackdropBorderColor(unpack(Colors.bordercolor))
end

-- create border for faded panels or it looks shit
function TukuiDB.CreateBorder(f)
	local border = CreateFrame("Frame", nil, f)
	border:SetFrameLevel(0)
	border:SetPoint("TOPLEFT", -mult, mult)
	border:SetPoint("BOTTOMRIGHT", mult, -mult)
	border:SetBackdrop({
	  edgeFile = Textures.blank, edgeSize = 3, 
	  insets = { left = 0, right = 0, top = 0, bottom = 0 }
	})
	border:SetBackdropBorderColor(unpack(Colors.backdropcolor))
end

-- skin more shit
function TukuiDB.SkinFadedPanel(f)
	f:SetBackdrop(fadedbackdrop)
	f:SetBackdropColor(unpack(Colors.fadedbackdropcolor))
	f:SetBackdropBorderColor(unpack(Colors.bordercolor))
	TukuiDB.CreateBorder(f)
	if TukuiCF["Panels"].shadows then
		TukuiDB.CreateShadow(f)
	end
end

-- create our faded panels
function TukuiDB.CreateFadedPanel(f, w, h, a1, p, a2, x, y)
	sh = scale(h)
	sw = scale(w)
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	TukuiDB.SkinFadedPanel(f)
end

-- these are strictly for unitframe backgrounds. what terrible fucking functions :D
function TukuiDB.CreateUFBackdrop(f, w, h, a1, p, a2, x, y)
	sh = scale(h)
	sw = scale(w)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetFrameLevel(1)
	f:SetPoint(a1, p, a2, x, y)
	f:SetBackdrop({
	  bgFile = Textures.blank,
	  edgeFile = Textures.blank, 
	  tile = false, tileSize = 0, edgeSize = 1, 
	  insets = { left = 0, right = 0, top = 0, bottom = 0}
	})
	f:SetBackdropColor(unpack(Colors.bordercolor))
	f:SetBackdropBorderColor(unpack(Colors.unitframeborder))
	
	-- god damn we need to add shadow like this
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -2, 2)
	shadow:SetPoint("BOTTOMRIGHT", 2, -2)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, .5)
end

function TukuiDB.CreateUFBorder(f)
	f:SetBackdrop({
	  edgeFile = Textures.blank, edgeSize = 1, 
	  insets = { left = 0, right = 0, top = 0, bottom = 0}
	})
	f:SetBackdropColor(unpack(Colors.unitframeborder))
	f:SetBackdropBorderColor(unpack(Colors.unitframeborder))
end


function TukuiDB.Kill(object)
	object.Show = TukuiDB.dummy
	object:Hide()
end