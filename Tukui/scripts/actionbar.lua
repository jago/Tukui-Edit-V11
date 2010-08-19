-- NEED TO DO MOUSE OVER RIGHT ACTION BARS!!!

local Actionbars = TukuiCF["Actionbars"]

if not Actionbars.enable then return end

------------------------------------------------------------------------------------------
-- the bar holder
------------------------------------------------------------------------------------------

-- create it
local TukuiBar1 = CreateFrame("Frame", "TukuiBar1", UIParent) 
local TukuiBar2 = CreateFrame("Frame", "TukuiBar2", UIParent) 
local TukuiBar3 = CreateFrame("Frame", "TukuiBar3", UIParent) 
local TukuiBar4 = CreateFrame("Frame", "TukuiBar4", UIParent) 
local TukuiBar5 = CreateFrame("Frame", "TukuiBar5", UIParent) 
local TukuiPet = CreateFrame("Frame", "TukuiPet", UIParent) 
local TukuiShift = CreateFrame("Frame", "TukuiShift", UIParent)

-- move & set it
TukuiBar1:SetAllPoints(TukuiDataBottom)
TukuiBar2:SetAllPoints(TukuiDataBottom)
TukuiBar3:SetAllPoints(TukuiDataBottom)
TukuiBar4:SetAllPoints(TukuiDataBottom)
TukuiBar5:SetAllPoints(TukuiDataBottom)
TukuiPet:SetAllPoints(UIParent)
TukuiShift:SetPoint("BOTTOMLEFT", TukuiDataLeft, "BOTTOMRIGHT", TukuiDB.Scale(3), 0)
TukuiShift:SetWidth(48)
TukuiShift:SetHeight(24)

------------------------------------------------------------------------------------------
-- these bars will always exist, on any tukui action bar layout.
------------------------------------------------------------------------------------------

-- main action bar
for i = 1, 12 do
	_G["ActionButton"..i]:SetParent(TukuiBar1)
end

ActionButton1:ClearAllPoints()
ActionButton1:SetPoint("BOTTOMLEFT", TukuiDataBottom, "TOPLEFT", 0, TukuiDB.Scale(3))
for i = 2, 12 do
	local b = _G["ActionButton"..i]
	local b2 = _G["ActionButton"..i-1]
	b:ClearAllPoints()
	b:SetPoint("LEFT", b2, "RIGHT", Actionbars.buttonspacing, 0)
end

-- bonus action bar
BonusActionBarFrame:SetParent(TukuiBar1)
BonusActionBarTexture0:Hide()
BonusActionBarTexture1:Hide()
BonusActionButton1:ClearAllPoints()
BonusActionButton1:SetPoint("BOTTOMLEFT", TukuiDataBottom, "TOPLEFT", 0, TukuiDB.Scale(3))
for i = 2, 12 do
	local b = _G["BonusActionButton"..i]
	local b2 = _G["BonusActionButton"..i-1]
	b:ClearAllPoints()
	b:SetPoint("LEFT", b2, "RIGHT", Actionbars.buttonspacing, 0)
end

-- shapeshift
ShapeshiftBarFrame:SetParent(TukuiShift)
ShapeshiftBarFrame:SetWidth(0.00001)
ShapeshiftButton1:ClearAllPoints()
ShapeshiftButton1:SetHeight(TukuiDB.Scale(Actionbars.stancesize))
ShapeshiftButton1:SetWidth(TukuiDB.Scale(Actionbars.stancesize))
ShapeshiftButton1:SetPoint("BOTTOMLEFT", TukuiShift, 0, TukuiDB.Scale(0))
local function MoveShapeshift()
	ShapeshiftButton1:SetPoint("BOTTOMLEFT", TukuiShift, 0, TukuiDB.Scale(0))
end
hooksecurefunc("ShapeshiftBar_Update", MoveShapeshift)
for i = 2, 10 do
	local b = _G["ShapeshiftButton"..i]
	local b2 = _G["ShapeshiftButton"..i-1]
	b:ClearAllPoints()
	b:SetPoint("BOTTOM", b2, "TOP", 0, Actionbars.buttonspacing)
end
if TukuiDB.myclass == "PALADIN" then
	ShapeshiftButton4:ClearAllPoints()
	ShapeshiftButton4:SetPoint("BOTTOMRIGHT", TukuiDataRight, "BOTTOMLEFT", TukuiDB.Scale(-3), 0)
	ShapeshiftButton7:ClearAllPoints()
	ShapeshiftButton7:SetPoint("BOTTOM", ShapeshiftButton3, "TOP", 0, TukuiDB.Scale(3))
end

if TukuiDB.myclass == "SHAMAN" then
	if MultiCastActionBarFrame then
		MultiCastActionBarFrame:SetParent(TukuiShift)
		MultiCastActionBarFrame:ClearAllPoints()
		MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", TukuiShift, 0, TukuiDB.Scale(26))

		for i = 1, 4 do
			local b = _G["MultiCastSlotButton"..i]
			local b2 = _G["MultiCastActionButton"..i]
			b:ClearAllPoints()
			b:SetAllPoints(b2)
		end

		MultiCastActionBarFrame.SetParent = TukuiDB.dummy
		MultiCastActionBarFrame.SetPoint = TukuiDB.dummy
	end
end

-- possess bar, we don't care about this one, we just hide it.
PossessBarFrame:SetParent(TukuiShift)
PossessBarFrame:SetScale(0.0001)
PossessBarFrame:SetAlpha(0)

-- pet action bar.
PetActionBarFrame:SetParent(TukuiPet)
PetActionBarFrame:SetWidth(0.00001)
PetActionButton1:ClearAllPoints()
if Actionbars.verticalrightbars then
	if Actionbars.rightbars == 0 then
		PetActionButton1:SetPoint("BOTTOMRIGHT", TukuiChatRightTabs, "TOPRIGHT", 0, TukuiDB.Scale(Actionbars.petsize * 10 + 4))
	elseif Actionbars.rightbars == 1 then
		PetActionButton1:SetPoint("BOTTOMRIGHT", MultiBarRightButton3, "BOTTOMLEFT", TukuiDB.Scale(-3), TukuiDB.Scale(0))
	elseif Actionbars.splitbar or Actionbars.rightbars == 2 then
		PetActionButton1:SetPoint("BOTTOMRIGHT", MultiBarBottomRightButton3, "BOTTOMLEFT", TukuiDB.Scale(-3), TukuiDB.Scale(0))
	elseif Actionbars.rightbars == 3 and not Actionbars.splitbar then
		PetActionButton1:SetPoint("BOTTOMRIGHT", MultiBarLeftButton3, "BOTTOMLEFT", TukuiDB.Scale(-3), TukuiDB.Scale(0))
	end
else
	if Actionbars.rightbars == 0 then
		PetActionButton1:SetPoint("BOTTOMRIGHT", TukuiChatRightTabs, "TOPRIGHT", TukuiDB.Scale(-(Actionbars.petsize * 10 + 1)), TukuiDB.Scale(3))
	elseif Actionbars.rightbars == 1 then
		PetActionButton1:SetPoint("BOTTOMRIGHT", MultiBarRightButton3, "TOPRIGHT", 0, TukuiDB.Scale(3))
	elseif Actionbars.splitbar or Actionbars.rightbars == 2 then
		PetActionButton1:SetPoint("BOTTOMRIGHT", MultiBarBottomRightButton3, "TOPRIGHT", 0, TukuiDB.Scale(3))
	elseif Actionbars.rightbars == 3 and not Actionbars.splitbar then
		PetActionButton1:SetPoint("BOTTOMRIGHT", MultiBarLeftButton3, "TOPRIGHT", 0, TukuiDB.Scale(3))
	end
end
for i = 2, 10 do
	local b = _G["PetActionButton"..i]
	local b2 = _G["PetActionButton"..i-1]
	b:ClearAllPoints()
	if Actionbars.verticalrightbars then
		b:SetPoint("TOP", b2, "BOTTOM", 0, -Actionbars.buttonspacing)
	else
		b:SetPoint("LEFT", b2, "RIGHT", Actionbars.buttonspacing, 0)
	end
end

------------------------------------------------------------------------------------------
-- now let's parent, set and hide extras action bar.
------------------------------------------------------------------------------------------

MultiBarBottomLeft:SetParent(TukuiBar2)
TukuiBar2:Hide()

MultiBarBottomRight:SetParent(TukuiBar3)
TukuiBar3:Hide()

MultiBarRight:SetParent(TukuiBar4)
TukuiBar4:Hide()

MultiBarLeft:SetParent(TukuiBar5)
TukuiBar5:Hide()

------------------------------------------------------------------------------------------
-- now let's show what we need by checking our config.lua
------------------------------------------------------------------------------------------

-- look for right bars
if Actionbars.rightbars > 0 then
	TukuiBar4:Show()
	MultiBarRightButton1:ClearAllPoints()
	if Actionbars.verticalrightbars then
		MultiBarRightButton1:SetPoint("BOTTOMRIGHT", TukuiChatRightTabs, "TOPRIGHT", 0, TukuiDB.Scale(Actionbars.buttonsize * 12 + 10))
	else
		MultiBarRightButton1:SetPoint("BOTTOMRIGHT", TukuiChatRightTabs, "TOPRIGHT", TukuiDB.Scale(-(Actionbars.buttonsize * 12 + 7)), TukuiDB.Scale(3))
	end
	for i = 2, 12 do
		local b = _G["MultiBarRightButton"..i]
		local b2 = _G["MultiBarRightButton"..i-1]
		b:ClearAllPoints()
		if Actionbars.verticalrightbars then
			b:SetPoint("TOP", b2, "BOTTOM", 0, -Actionbars.buttonspacing)
		else
			b:SetPoint("LEFT", b2, "RIGHT", Actionbars.buttonspacing, 0)
		end
	end
end

if Actionbars.rightbars > 1 then
	TukuiBar3:Show()
	MultiBarBottomRightButton1:ClearAllPoints()
	if Actionbars.verticalrightbars then
		MultiBarBottomRightButton1:SetPoint("TOPRIGHT", MultiBarRightButton1, "TOPLEFT", TukuiDB.Scale(-3), 0)
	else
		MultiBarBottomRightButton1:SetPoint("BOTTOMLEFT", MultiBarRightButton1, "TOPLEFT", 0, TukuiDB.Scale(3))
	end
	for i = 2, 12 do
		local b = _G["MultiBarBottomRightButton"..i]
		local b2 = _G["MultiBarBottomRightButton"..i-1]
		b:ClearAllPoints()
		if Actionbars.verticalrightbars then
			b:SetPoint("TOP", b2, "BOTTOM", 0, -Actionbars.buttonspacing)
		else
			b:SetPoint("LEFT", b2, "RIGHT", Actionbars.buttonspacing, 0)
		end
	end    
end

if (not Actionbars.splitbar) and Actionbars.rightbars > 2 then
	TukuiBar5:Show()
	MultiBarLeftButton1:ClearAllPoints()
	if Actionbars.verticalrightbars then
		MultiBarLeftButton1:SetPoint("TOPRIGHT", MultiBarBottomRightButton1, "TOPLEFT", TukuiDB.Scale(-3), 0)
	else
		MultiBarLeftButton1:SetPoint("BOTTOMLEFT", MultiBarBottomRightButton1, "TOPLEFT", 0, TukuiDB.Scale(3))
	end
	for i = 2, 12 do
		local b = _G["MultiBarLeftButton"..i]
		local b2 = _G["MultiBarLeftButton"..i-1]
		b:ClearAllPoints()
		if Actionbars.verticalrightbars then
			b:SetPoint("TOP", b2, "BOTTOM", 0, -Actionbars.buttonspacing)
		else
			b:SetPoint("LEFT", b2, "RIGHT", Actionbars.buttonspacing, 0)
		end
	end
end

-- now look for others shit, if found, set bar or override settings bar above.
if Actionbars.bottomrows == 2 then
	TukuiBar2:Show()
	MultiBarBottomLeftButton1:ClearAllPoints()
	MultiBarBottomLeftButton1:SetPoint("BOTTOM", ActionButton1, "TOP", 0, TukuiDB.Scale(3))
	for i = 2, 12 do
		local b = _G["MultiBarBottomLeftButton"..i]
		local b2 = _G["MultiBarBottomLeftButton"..i-1]
		b:ClearAllPoints()
		b:SetPoint("LEFT", b2, "RIGHT", Actionbars.buttonspacing, 0)
	end   
end

-- split bar
if Actionbars.splitbar then
	TukuiBar5:Show()
	MultiBarLeftButton1:ClearAllPoints()
	MultiBarLeftButton1:SetPoint("BOTTOMLEFT", TukuiLeftSplitData, "TOPLEFT", 0, TukuiDB.Scale(3))
	for i = 2, 12 do
		local b = _G["MultiBarLeftButton"..i]
		local b2 = _G["MultiBarLeftButton"..i-1]
		b:ClearAllPoints()
		b:SetPoint("LEFT", b2, "RIGHT", TukuiDB.Scale(3), 0)
	end
	MultiBarLeftButton4:ClearAllPoints()
	MultiBarLeftButton4:SetPoint("BOTTOMLEFT", TukuiRightSplitData, "TOPLEFT", 0, TukuiDB.Scale(3))
	MultiBarLeftButton7:ClearAllPoints()  
	MultiBarLeftButton7:SetPoint("BOTTOMLEFT", MultiBarLeftButton1,"TOPLEFT", 0, TukuiDB.Scale(3));
	MultiBarLeftButton10:ClearAllPoints()  
	MultiBarLeftButton10:SetPoint("BOTTOMLEFT", MultiBarLeftButton4,"TOPLEFT", 0, TukuiDB.Scale(3));
	if Actionbars.bottomrows == 1 then
		MultiBarLeftButton7:SetAlpha(0)
		MultiBarLeftButton7:SetScale(0.0001)
		MultiBarLeftButton8:SetAlpha(0)
		MultiBarLeftButton8:SetScale(0.0001)
		MultiBarLeftButton9:SetAlpha(0)
		MultiBarLeftButton9:SetScale(0.0001)
		MultiBarLeftButton10:SetAlpha(0)
		MultiBarLeftButton10:SetScale(0.0001)
		MultiBarLeftButton11:SetAlpha(0)
		MultiBarLeftButton11:SetScale(0.0001)
		MultiBarLeftButton12:SetAlpha(0)
		MultiBarLeftButton12:SetScale(0.0001)
	end
end

------------------------------------------------------------------------------------------
-- functions and others stuff
------------------------------------------------------------------------------------------

-- bonus bar (vehicle, rogue, etc)
local function BonusBarAlpha(alpha)
	local f = "ActionButton"
	for i = 1, 12 do
		_G[f..i]:SetAlpha(alpha)
	end
end
BonusActionBarFrame:HookScript("OnShow", function(self) BonusBarAlpha(0) end)
BonusActionBarFrame:HookScript("OnHide", function(self) BonusBarAlpha(1) end)
if BonusActionBarFrame:IsShown() then
	BonusBarAlpha(0)
end

-- hide these blizzard frames
local FramesToHide = {
	MainMenuBar,
	VehicleMenuBar,
} 

for _, f in pairs(FramesToHide) do
	f:SetScale(0.00001)
	f:SetAlpha(0)
end

-- vehicle button under minimap
local vehicle = CreateFrame("BUTTON", nil, UIParent, "SecureActionButtonTemplate")
vehicle:SetWidth(TukuiDB.Scale(26))
vehicle:SetHeight(TukuiDB.Scale(26))
vehicle:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", TukuiDB.Scale(-4), TukuiDB.Scale(-4))

vehicle:RegisterForClicks("AnyUp")
vehicle:SetScript("OnClick", function() VehicleExit() end)

vehicle:SetNormalTexture("Interface\\AddOns\\Tukui\\media\\textures\\vehicleexit")
vehicle:SetPushedTexture("Interface\\AddOns\\Tukui\\media\\textures\\vehicleexit")
vehicle:SetHighlightTexture("Interface\\AddOns\\Tukui\\media\\textures\\vehicleexit")
TukuiDB.SkinPanel(vehicle)

vehicle:RegisterEvent("UNIT_ENTERING_VEHICLE")
vehicle:RegisterEvent("UNIT_ENTERED_VEHICLE")
vehicle:RegisterEvent("UNIT_EXITING_VEHICLE")
vehicle:RegisterEvent("UNIT_EXITED_VEHICLE")
vehicle:RegisterEvent("ZONE_CHANGED_NEW_AREA")
vehicle:SetScript("OnEvent", function(self, event, arg1)
	if (((event=="UNIT_ENTERING_VEHICLE") or (event=="UNIT_ENTERED_VEHICLE")) and arg1 == "player") then
		vehicle:SetAlpha(1)
	elseif (((event=="UNIT_EXITING_VEHICLE") or (event=="UNIT_EXITED_VEHICLE")) and arg1 == "player") or (event=="ZONE_CHANGED_NEW_AREA" and not UnitHasVehicleUI("player")) then
		vehicle:SetAlpha(0)
	end
end)  
vehicle:SetAlpha(0)

-- shapeshift command to move it in-game
local ssmover = CreateFrame("Frame", "ssmoverholder", UIParent)
ssmover:SetAllPoints(TukuiShift)
TukuiDB.SetTemplate(ssmover)
ssmover:SetAlpha(0)
TukuiShift:SetMovable(true)
TukuiShift:SetUserPlaced(true)
local ssmove = false
local function showmovebutton()
	if ssmove == false then
		ssmove = true
		ssmover:SetAlpha(1)
		TukuiShift:EnableMouse(true)
		TukuiShift:RegisterForDrag("LeftButton", "RightButton")
		TukuiShift:SetScript("OnDragStart", function(self) self:StartMoving() end)
		TukuiShift:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	elseif ssmove == true then
		ssmove = false
		ssmover:SetAlpha(0)
		TukuiShift:EnableMouse(false)
	end
end
SLASH_SHOWMOVEBUTTON1 = "/mss"
SlashCmdList["SHOWMOVEBUTTON"] = showmovebutton

local function mouseoverpet(alpha)
	for i=1, NUM_PET_ACTION_SLOTS do
		local pb = _G["PetActionButton"..i]
		pb:SetAlpha(alpha)
	end
end

local function mouseoverstance(alpha)
	if TukuiDB.myclass == "SHAMAN" then
		for i=1, 12 do
			local pb = _G["MultiCastActionButton"..i]
			pb:SetAlpha(alpha)
		end
		for i=1, 4 do
			local pb = _G["MultiCastSlotButton"..i]
			pb:SetAlpha(alpha)
		end
	else
		for i=1, 10 do
			local pb = _G["ShapeshiftButton"..i]
			pb:SetAlpha(alpha)
		end
	end
end

local function rightbaralpha(alpha)
	if not Actionbars.splitbar and Actionbars.rightbars > 2 then
		if MultiBarLeft:IsShown() then
			for i=1, 12 do
				local pb = _G["MultiBarLeftButton"..i]
				pb:SetAlpha(alpha)
			end
			MultiBarLeft:SetAlpha(alpha)
		end
	end
	if Actionbars.rightbars > 1 then
		if MultiBarBottomRight:IsShown() then
			for i=1, 12 do
				local pb = _G["MultiBarBottomRightButton"..i]
				pb:SetAlpha(alpha)
			end
			MultiBarBottomRight:SetAlpha(alpha)
		end
	end
	if Actionbars.rightbars > 0 then
		if MultiBarRight:IsShown() then
			for i=1, 12 do
				local pb = _G["MultiBarRightButton"..i]
				pb:SetAlpha(alpha)
			end
			MultiBarRight:SetAlpha(alpha)
		end
	end
end

if Actionbars.rightbarmouseover and Actionbars.rightbars > 0 then
	for i=1, 12 do
		local pb = _G["MultiBarRightButton"..i]
		pb:SetAlpha(0)
		pb:HookScript("OnEnter", function(self) mouseoverpet(1) rightbaralpha(1) end)
		pb:HookScript("OnLeave", function(self) mouseoverpet(0) rightbaralpha(0) end)
		
		if not Actionbars.splitbar then
			local pb = _G["MultiBarLeftButton"..i]
			pb:SetAlpha(0)
			pb:HookScript("OnEnter", function(self) mouseoverpet(1) rightbaralpha(1) end)
			pb:HookScript("OnLeave", function(self) mouseoverpet(0) rightbaralpha(0) end)
		end
		
		local pb = _G["MultiBarBottomRightButton"..i]
		pb:SetAlpha(0)
		pb:HookScript("OnEnter", function(self) mouseoverpet(1) rightbaralpha(1) end)
		pb:HookScript("OnLeave", function(self) mouseoverpet(0) rightbaralpha(0) end)
	end
	for i=1, NUM_PET_ACTION_SLOTS do
		local pb = _G["PetActionButton"..i]
		pb:SetAlpha(0)
		pb:HookScript("OnEnter", function(self) mouseoverpet(1) rightbaralpha(1) end)
		pb:HookScript("OnLeave", function(self) mouseoverpet(0) rightbaralpha(0) end)
	end
end

if Actionbars.shapeshiftmouseover then
	if TukuiDB.myclass == "SHAMAN" then
		TukuiShift:HookScript("OnEnter", function(self) MultiCastSummonSpellButton:SetAlpha(1) MultiCastRecallSpellButton:SetAlpha(1) mouseoverstance(1) end)
		TukuiShift:HookScript("OnLeave", function(self) MultiCastSummonSpellButton:SetAlpha(0) MultiCastRecallSpellButton:SetAlpha(0) mouseoverstance(0) end)
		MultiCastSummonSpellButton:SetAlpha(0)
		MultiCastSummonSpellButton:HookScript("OnEnter", function(self) MultiCastSummonSpellButton:SetAlpha(1) MultiCastRecallSpellButton:SetAlpha(1) mouseoverstance(1) end)
		MultiCastSummonSpellButton:HookScript("OnLeave", function(self) MultiCastSummonSpellButton:SetAlpha(0) MultiCastRecallSpellButton:SetAlpha(0) mouseoverstance(0) end)
		MultiCastRecallSpellButton:SetAlpha(0)
		MultiCastRecallSpellButton:HookScript("OnEnter", function(self) MultiCastSummonSpellButton:SetAlpha(1) MultiCastRecallSpellButton:SetAlpha(1) mouseoverstance(1) end)
		MultiCastRecallSpellButton:HookScript("OnLeave", function(self) MultiCastSummonSpellButton:SetAlpha(0) MultiCastRecallSpellButton:SetAlpha(0) mouseoverstance(0) end)
		MultiCastFlyoutFrameOpenButton:HookScript("OnEnter", function(self) MultiCastSummonSpellButton:SetAlpha(1) MultiCastRecallSpellButton:SetAlpha(1) mouseoverstance(1) end)
		MultiCastFlyoutFrameOpenButton:HookScript("OnLeave", function(self) MultiCastSummonSpellButton:SetAlpha(0) MultiCastRecallSpellButton:SetAlpha(0) mouseoverstance(0) end)		

		for i=1, 4 do
			local pb = _G["MultiCastSlotButton"..i]
			pb:SetAlpha(0)
			pb:HookScript("OnEnter", function(self) MultiCastSummonSpellButton:SetAlpha(1) MultiCastRecallSpellButton:SetAlpha(1) mouseoverstance(1) end)
			pb:HookScript("OnLeave", function(self) MultiCastSummonSpellButton:SetAlpha(0) MultiCastRecallSpellButton:SetAlpha(0) mouseoverstance(0) end)
		end
		for i=1, 4 do
			local pb = _G["MultiCastActionButton"..i]
			pb:SetAlpha(0)
			pb:HookScript("OnEnter", function(self) MultiCastSummonSpellButton:SetAlpha(1) MultiCastRecallSpellButton:SetAlpha(1) mouseoverstance(1) end)
			pb:HookScript("OnLeave", function(self) MultiCastSummonSpellButton:SetAlpha(0) MultiCastRecallSpellButton:SetAlpha(0) mouseoverstance(0) end)
		end
	else
		TukuiShift:HookScript("OnEnter", function(self) mouseoverstance(1) end)
		TukuiShift:HookScript("OnLeave", function(self) mouseoverstance(0) end)
		for i=1, 10 do
			local pb = _G["ShapeshiftButton"..i]
			pb:SetAlpha(0)
			pb:HookScript("OnEnter", function(self) mouseoverstance(1) end)
			pb:HookScript("OnLeave", function(self) mouseoverstance(0) end)
		end
	end
end

-- option to hide shapeshift or totem bar.
if Actionbars.hideshapeshift then
	TukuiShift:Hide()
end

-- Hide options for action bar in default interface option.
InterfaceOptionsActionBarsPanelBottomLeft:Hide()
InterfaceOptionsActionBarsPanelBottomRight:Hide()
InterfaceOptionsActionBarsPanelRight:Hide()
InterfaceOptionsActionBarsPanelRightTwo:Hide()
InterfaceOptionsActionBarsPanelAlwaysShowActionBars:Hide()

-- always hide these textures
SlidingActionBarTexture0:SetTexture(nil)
SlidingActionBarTexture1:SetTexture(nil)
ShapeshiftBarLeft:SetTexture(nil)
ShapeshiftBarRight:SetTexture(nil)
ShapeshiftBarMiddle:SetTexture(nil)