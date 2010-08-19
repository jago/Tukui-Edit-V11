-- hide durability man - fuck I hate this guy
hooksecurefunc(DurabilityFrame,"SetPoint",function(self,_,parent)
    if (parent == "MinimapCluster") or (parent == _G["MinimapCluster"]) then
        DurabilityFrame:ClearAllPoints()
        DurabilityFrame:Hide()
    end
end)

-- reposition capture bar
local function CaptureUpdate()
	for i = 1, NUM_EXTENDED_UI_FRAMES do
		local cb = _G["WorldStateCaptureBar"..i]
		if cb and cb:IsShown() then
			cb:ClearAllPoints()
			cb:SetPoint("TOP", UIParent, "TOP", 0, TukuiDB.Scale(-120))
		end
	end
end
hooksecurefunc("WorldStateAlwaysUpFrame_Update", CaptureUpdate)

-- reposition vehicle
hooksecurefunc(VehicleSeatIndicator,"SetPoint",function(_,_,parent) -- vehicle seat indicator
    if (parent == "MinimapCluster") or (parent == _G["MinimapCluster"]) then
		VehicleSeatIndicator:ClearAllPoints()
		VehicleSeatIndicator:SetPoint("TOP", UIParent, "TOP", 0, TukuiDB.Scale(-200))
    end
end)

-- vehicle on mouseover because this shit take too much space on screen
local function VehicleNumSeatIndicator()
	if VehicleSeatIndicatorButton1 then
		TukuiDB.numSeat = 1
	elseif VehicleSeatIndicatorButton2 then
		TukuiDB.numSeat = 2
	elseif VehicleSeatIndicatorButton3 then
		TukuiDB.numseat = 3
	elseif VehicleSeatIndicatorButton4 then
		TukuiDB.numSeat = 4
	elseif VehicleSeatIndicatorButton5 then
		TukuiDB.numSeat = 5
	elseif VehicleSeatIndicatorButton6 then
		TukuiDB.numSeat = 6
	end
end

local function vehmousebutton(alpha)
	for i=1, TukuiDB.numSeat do
	local pb = _G["VehicleSeatIndicatorButton"..i]
		pb:SetAlpha(alpha)
	end
end

local function vehmouse()
	if VehicleSeatIndicator:IsShown() then
		VehicleSeatIndicator:SetAlpha(0)
		VehicleSeatIndicator:EnableMouse(true)
		
		VehicleNumSeatIndicator()
		
		VehicleSeatIndicator:HookScript("OnEnter", function() VehicleSeatIndicator:SetAlpha(1) vehmousebutton(1) end)
		VehicleSeatIndicator:HookScript("OnLeave", function() VehicleSeatIndicator:SetAlpha(0) vehmousebutton(0) end)

		for i=1, TukuiDB.numSeat do
			local pb = _G["VehicleSeatIndicatorButton"..i]
			pb:SetAlpha(0)
			pb:HookScript("OnEnter", function(self) VehicleSeatIndicator:SetAlpha(1) vehmousebutton(1) end)
			pb:HookScript("OnLeave", function(self) VehicleSeatIndicator:SetAlpha(0) vehmousebutton(0) end)
		end
	end
end
hooksecurefunc("VehicleSeatIndicator_Update", vehmouse)

-- oh look, watchframe reposition!
local TukuiWatchFrame = CreateFrame("Frame", nil, UIParent)

TukuiWatchFrame:RegisterEvent("ADDON_LOADED")
TukuiWatchFrame:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Tukui") and (not IsAddOnLoaded("Who Framed Watcher Wabbit") or not IsAddOnLoaded("Fux")) then	
		self:UnregisterEvent("ADDON_LOADED")
		
		local wfbutton = CreateFrame("Button", "WatchFrameButton", WatchFrame)
		TukuiDB.CreatePanel(wfbutton, 40, 10, "BOTTOM", WatchFrame, "TOP", 0, -8)
		wfbutton:Hide()

		local wf = WatchFrame
		local wfmove = false 

		wf:SetMovable(true)
		wf:SetClampedToScreen(false)
		wf:ClearAllPoints()
		wf:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", TukuiDB.Scale(-8), TukuiDB.Scale(-230))
		wf:SetHeight(600)
		wf:SetUserPlaced(true)
		wf.SetPoint = TukuiDB.dummy
		wf.ClearAllPoints = TukuiDB.dummy

		local function WATCHFRAMELOCK()
			if wfmove == false then
				wfmove = true
				print(tukuilocal.core_wf_unlock)
				wf:EnableMouse(true);
				wf:RegisterForDrag("LeftButton");
				wf:SetScript("OnDragStart", wf.StartMoving);
				wf:SetScript("OnDragStop", wf.StopMovingOrSizing);
				wfbutton:Show()
			elseif wfmove == true then
				wf:EnableMouse(false);
				wfmove = false
				wfbutton:Hide()
				print(tukuilocal.core_wf_lock)
			end
		end

		SLASH_WATCHFRAMELOCK1 = "/wf"
		SlashCmdList["WATCHFRAMELOCK"] = WATCHFRAMELOCK
	end
end)
