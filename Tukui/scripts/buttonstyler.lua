local Actionbars = TukuiCF["Actionbars"]
local Colors = TukuiCF["Colors"]

if not Actionbars.enable then return end

local _G = _G
local media = TukuiDB["media"]
local securehandler = CreateFrame("Frame", nil, nil, "SecureHandlerBaseTemplate")
local replace = string.gsub

local function style(self)  
	local name = self:GetName()
	local action = self.action
	local Button = self
	local Icon = _G[name.."Icon"]
	local Count = _G[name.."Count"]
	local Flash	 = _G[name.."Flash"]	
	local HotKey = _G[name.."HotKey"]
	local Border  = _G[name.."Border"]
	local Btname = _G[name.."Name"]
	local normal  = _G[name.."NormalTexture"]

	Flash:SetTexture("")

	Button:SetPushedTexture("")
	Button:SetCheckedTexture("")
	Button:SetNormalTexture("")
	
	Border:Hide()
	Border = TukuiDB.dummy

	Count:ClearAllPoints()
	Count:SetPoint("BOTTOMRIGHT", 0, TukuiDB.Scale(2))
	Count:SetFont(TukuiCF["Fonts"].font, 12, "OUTLINE")
	
	HotKey:ClearAllPoints()
	HotKey:SetPoint("TOPRIGHT", 0, TukuiDB.Scale(-2))
	HotKey:SetFont(TukuiCF["Fonts"].font, 12, "OUTLINE")
	
	if not Actionbars.hotkey == true then
		HotKey:SetText("")
		HotKey:Hide()
		HotKey.Show = TukuiDB.dummy
	end

	Btname:SetText("")
	Btname:Hide()
	Btname.Show = TukuiDB.dummy
	
	if not _G[name.."Panel"] then
		self:SetWidth(Actionbars.buttonsize)
		self:SetHeight(Actionbars.buttonsize)
		
		local panel = CreateFrame("Frame", name.."Panel", self)
		TukuiDB.CreateFadedPanel(panel, Actionbars.buttonsize, Actionbars.buttonsize, "CENTER", self, "CENTER", 0, 0)

		panel:SetFrameStrata(self:GetFrameStrata())
		panel:SetFrameLevel(self:GetFrameLevel() - 1)

		Icon:SetTexCoord(.08, .92, .08, .92)
		Icon:SetPoint("TOPLEFT", Button, TukuiDB.Scale(2), TukuiDB.Scale(-2))
		Icon:SetPoint("BOTTOMRIGHT", Button, TukuiDB.Scale(-2), TukuiDB.Scale(2))
	end

	normal:ClearAllPoints()
	normal:SetPoint("TOPLEFT")
	normal:SetPoint("BOTTOMRIGHT")
end

local function stylesmallbutton(normal, button, icon, name, pet)
	local Flash	 = _G[name.."Flash"]
	button:SetPushedTexture("")
	button:SetNormalTexture("")
	button:SetCheckedTexture("")
	Flash:SetTexture("")
	
	if not _G[name.."Panel"] then
		if pet then
			button:SetWidth(Actionbars.petsize)
			button:SetHeight(Actionbars.petsize)
			
			local panel = CreateFrame("Frame", name.."Panel", button)
			TukuiDB.CreatePanel(panel, Actionbars.petsize, Actionbars.petsize, "CENTER", button, "CENTER", 0, 0)
			panel:SetBackdropColor(unpack(Colors.backdropcolor))
			panel:SetFrameStrata(button:GetFrameStrata())
			panel:SetFrameLevel(button:GetFrameLevel() - 1)
			
			local autocast = _G[name.."AutoCastable"]
			autocast:SetWidth(TukuiDB.Scale(Actionbars.petsize * 2))
			autocast:SetHeight(TukuiDB.Scale(Actionbars.petsize * 2))
			autocast:ClearAllPoints()
			autocast:SetPoint("CENTER", button, 0, 0)
			
			local shine = _G[name.."Shine"] -- Added to fix stupid auto-cast shine around pet buttons
			shine:SetWidth(TukuiDB.Scale(Actionbars.petsize)) -- As above
			shine:SetHeight(TukuiDB.Scale(Actionbars.petsize)) -- As above

			local cooldown = _G[name.."Cooldown"] -- Added to fix cooldown shadow being larger than pet buttons
			cooldown:SetWidth(TukuiDB.Scale(Actionbars.petsize - 2)) -- As above
			cooldown:SetHeight(TukuiDB.Scale(Actionbars.petsize - 2)) -- As above
			
			icon:SetTexCoord(.08, .92, .08, .92)
			icon:ClearAllPoints()
			icon:SetPoint("TOPLEFT", button, TukuiDB.Scale(2), TukuiDB.Scale(-2))
			icon:SetPoint("BOTTOMRIGHT", button, TukuiDB.Scale(-2), TukuiDB.Scale(2))
		else
			button:SetWidth(Actionbars.stancesize)
			button:SetHeight(Actionbars.stancesize)
			
			local panel = CreateFrame("Frame", name.."Panel", button)
			TukuiDB.CreatePanel(panel, Actionbars.stancesize, Actionbars.stancesize, "CENTER", button, "CENTER", 0, 0)
			panel:SetBackdropColor(unpack(Colors.backdropcolor))
			panel:SetFrameStrata(button:GetFrameStrata())
			panel:SetFrameLevel(button:GetFrameLevel() - 1)
			
			icon:SetTexCoord(.08, .92, .08, .92)
			icon:ClearAllPoints()
			icon:SetPoint("TOPLEFT", button, TukuiDB.Scale(2), TukuiDB.Scale(-2))
			icon:SetPoint("BOTTOMRIGHT", button, TukuiDB.Scale(-2), TukuiDB.Scale(2))
		end
	end
	
	normal:SetVertexColor(unpack(Colors.bordercolor))
	normal:ClearAllPoints()
	normal:SetPoint("TOPLEFT")
	normal:SetPoint("BOTTOMRIGHT")
end

local function styleshift(pet)
	for i = 1, NUM_SHAPESHIFT_SLOTS do
		local name = "ShapeshiftButton"..i
		local button  = _G[name]
		local icon  = _G[name.."Icon"]
		local normal  = _G[name.."NormalTexture"]
		
		stylesmallbutton(normal, button, icon, name)

		local _, _, isActive, _ = GetShapeshiftFormInfo(i)
		local panel =_G[name.."Panel"]

		if panel then
			if (isActive) then -- for the current active stance/shapeshift
				panel:SetBackdropBorderColor(0.2, 0.2, 0.7, 1)
			else
				panel:SetBackdropBorderColor(unpack(Colors.bordercolor))
			end
		end
	end
end

local function stylepet(self)
	for i = 1, NUM_PET_ACTION_SLOTS do
		local name = "PetActionButton"..i
		local button  = _G[name]
		local icon  = _G[name.."Icon"]
		local normal  = _G[name.."NormalTexture2"]
		
		stylesmallbutton(normal, button, icon, name, true)
		
		local _, _, _, _, isActive, _, _ = GetPetActionInfo(i)
		local panel =_G[name.."Panel"]
		
		if panel then
			if (isActive) then -- for the current active abilities (follow/stay + aggresive/defensive/passive)
				panel:SetBackdropBorderColor(0.2, 0.2, 0.7, 1)
			else
				panel:SetBackdropBorderColor(unpack(Colors.bordercolor))
			end
		end
	end
end

local function stylebutton(self)
	local name = self:GetName()
	local action = self.action
	local icon = _G[name.."Icon"]
	local panel = _G[name.."Panel"]
	
	if panel then
		if (IsEquippedAction(action)) then -- for equipped items that have a "use" effect (aka trinkets)
			panel:SetBackdropBorderColor(.7, .2, .2, 1)
		elseif (IsCurrentAction(action)) or (IsAutoRepeatAction(action)) then -- for your current skills/spells being used
			panel:SetBackdropBorderColor(.2, .2, .7, 1)
		else
			panel:SetBackdropBorderColor(unpack(Colors.bordercolor))
		end
	end
end

local function usable(self)
	local name = self:GetName()
	local action = self.action
	local icon = _G[name.."Icon"]

	local isusable, mana = IsUsableAction(action)
	if ActionHasRange(action) and IsActionInRange(action) == 0 then
		icon:SetVertexColor(.8, .1, .1)
		return
	elseif mana then
		icon:SetVertexColor(.1, .3, 1)
		return
	elseif isusable then
		icon:SetVertexColor(.8, .8, .8)
		return
	else
		icon:SetVertexColor(.4, .4, .4)
		return
	end
end

local function updatehotkey(self, actionButtonType)
	local hotkey = _G[self:GetName() .. 'HotKey']
	local text = hotkey:GetText()
	
	text = replace(text, '(s%-)', 'S')
	text = replace(text, '(a%-)', 'A')
	text = replace(text, '(c%-)', 'C')
	text = replace(text, '(Mouse Button )', 'M')
	text = replace(text, '(Middle Mouse)', 'M3')
	text = replace(text, '(Num Pad )', 'N')
	text = replace(text, '(Page Up)', 'PU')
	text = replace(text, '(Page Down)', 'PD')
	text = replace(text, '(Spacebar)', 'SpB')
	text = replace(text, '(Insert)', 'Ins')
	text = replace(text, '(Home)', 'Hm')
	
	if hotkey:GetText() == _G['RANGE_INDICATOR'] then
		hotkey:SetText('')
	else
		hotkey:SetText(text)
	end
end

-- rescale cooldown spiral to fix texture.
local buttonNames = { "ActionButton", "MultiBarBottomLeftButton", "MultiBarBottomRightButton", "MultiBarLeftButton", "MultiBarRightButton", "ShapeshiftButton", "PetActionButton" }
for _, name in ipairs( buttonNames ) do
	for index = 1, 20 do
		local buttonName = name .. tostring(index)
		local button = _G[buttonName]
		local cooldown = _G[buttonName .. "Cooldown"]
 
		if ( button == nil or cooldown == nil ) then
			break;
		end
 
		cooldown:ClearAllPoints()
		cooldown:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
		cooldown:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	end
end

hooksecurefunc("ActionButton_Update", style)
hooksecurefunc("ActionButton_UpdateState", style)

hooksecurefunc("ActionButton_UpdateState", stylebutton)
hooksecurefunc("ActionButton_Update", stylebutton)

hooksecurefunc("PetActionBar_Update", stylepet)

hooksecurefunc("ShapeshiftBar_OnLoad", styleshift)
hooksecurefunc("ShapeshiftBar_Update", styleshift)
hooksecurefunc("ShapeshiftBar_UpdateState", styleshift)

hooksecurefunc("ActionButton_UpdateHotkeys", updatehotkey)


